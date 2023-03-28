//
//  MomentViewController.m
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MomentViewController.h"
#import "MomentCell.h"

#import "RSLike.h"

#define ECA 5

#import "RSMomentButton.h"
#import "RSFriendDetailController.h"
#import "RSWeChatShareTool.h"
#import "RSJumpPlayVideoTool.h"
#import "RSLoginViewController.h"
#import "RSMyRingViewController.h"
#import "RSCargoCenterBusinessViewController.h"
#import "CommentView.h"


//UITextFieldDelegate
@interface MomentViewController ()<UITableViewDelegate,UITableViewDataSource,MomentCellDelegate,UITextViewDelegate>

//@property (nonatomic,strong)UITextField * textfield;

@property (nonatomic,strong)Comment * currentComment;

@property (nonatomic,strong)MomentCell * cell;

@property (nonatomic,strong)NSString * selectType;
/**获取是上啦刷新，还是下拉刷新的地方 true是下拉刷新，false是下来刷新*/
@property (nonatomic,assign)BOOL isRefresh;
/**获取上啦刷新的页数*/
@property (nonatomic,assign)int pageNum;
// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
/**选择你要看的选择的类型*/
@property (nonatomic,strong)NSString * selectStr;
/**用来存储全部的第一个最大的FriendID的中间值*/
@property (nonatomic,strong)NSString * tempFriendID;

@property(nonatomic,strong)CommentView *cmtView;

@end

@implementation MomentViewController

-(CommentView *)cmtView
{
    if (!_cmtView){
        _cmtView = [[CommentView alloc]initWithFrame:CGRectMake(0, SCH, SCW, 50)];
        _cmtView.inputView.delegate = self;
        _cmtView.inputView.zw_placeHolder = @"回复";
    }
    return _cmtView;
}

//- (UITextField *)textfield{
//
//    if (!_textfield) {
//        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, SCH, SCW, 50)];
//        _textfield.textAlignment = NSTextAlignmentLeft;
//        _textfield.textColor = [UIColor blackColor];
//        _textfield.returnKeyType = UIReturnKeySend;
//        _textfield.userInteractionEnabled =YES;
//        _textfield.delegate = self;
//
////        [_textfield addTarget:self action:@selector(changTextViewFrame:) forControlEvents:UIControlEventEditingChanged];
//        _textfield.font = [UIFont systemFontOfSize:18];
//        _textfield.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//        _textfield.placeholder = @"回复:";
//    }
//    return _textfield;
//}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCW, self.view.yj_height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // tableView.separatorColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        // tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
        RSWeakself
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //下拉刷新数据
            [weakSelf loadNewData];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上拉加载更多
            [weakSelf footNewData];
        }];
        [_tableView setupEmptyDataText:@"点击重新加载数据" tapBlock:^{
            [weakSelf loadNewData];
        }];
    }
    return _tableView;
}

- (NSMutableArray *)momentList{
    if (!_momentList) {
        _momentList = [NSMutableArray array];
    }
    return _momentList;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    //这边是要对进入评论详情界面做的事情。
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"refreshData" object:nil];
    
    //删除其中一个商圈
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteOneFriend) name:@"delFriendData" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshFriendStatus:) name:@"refreshFriendStatus" object:nil];
    
    //点击TabbarItem
    //点击第二个控制器
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isNewData) name:@"isNewData" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if ([self.title isEqualToString:@"石圈"]) {
        self.showType = @"all";
    }else{
        self.showType = @"attention";
    }
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.selectType = @"0";
    self.pageNum = 2;
    self.isRefresh = true;
    //全部
    _selectStr = @"";
    [self.tableView.mj_header beginRefreshing];
//    [self loadNewData];
    [self setUpUI];
   // 一进来获取网络数据
//    static dispatch_once_t disOnce;
//    __weak typeof(self) weakSelf = self;
//    dispatch_once(&disOnce,^ {
//        //只执行一次的代码
//        //获取版本号
//        [weakSelf getAPPCurrentVersion];
//    });
}

#pragma mark -- 刷新数据
- (void)refreshFriendStatus:(NSNotification *)notification{
    Moment * moment = notification.userInfo[@"moment"];
    NSString * type = notification.userInfo[@"Type"];
    if ([type isEqualToString:@"gz"]) {
         [self changAttatitionDataMoment:moment andShowType:self.showType];
    }else{
        for (int i = 0; i < self.momentList.count; i++) {
            Moment * moment1 = self.momentList[i];
            if ([moment.friendId isEqualToString:moment1.friendId]) {
                [UIView setAnimationsEnabled:NO];
                // [self reloadArrayDataMoment:moment andMomentList:self.momentList andshowType:self.showType];
                [self.momentList replaceObjectAtIndex:i withObject:moment];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                // [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_cell.tag inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                [self reloadArrayDataMoment:moment andMomentList:self.momentList andshowType:self.showType];
                [UIView setAnimationsEnabled:YES];
                break;
            }
        }
    }
}


- (void)refreshData{
    [self loadNewData];
}

- (void)deleteOneFriend{
    [self loadNewData];
}

//是否有最新的数据--点击Tabbar各个控制器按键，还有就从后台进入前台的时候
- (void)isNewData{
    //1.这边要知道用户的的信息
    //2.这边要知道朋友圈的第一条信息
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length > 0) {
        if (self.userModel.userID != nil && _tempFriendID != nil) {
            //URL_NEWDATAINMESSAGE_IOS
            if ([self.showType isEqualToString:@"all"]) {
                // if ([_selectStr isEqualToString:@""]) {
                // RSFriendModel * freindmodel = self.friendArray[0];
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
                NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                [phoneDict setObject:self.userModel.userID forKey:@"userId"];
                [phoneDict setObject:_tempFriendID forKey:@"friendId"];
                //二进制数
                NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                [network getDataWithUrlString:URL_NEWDATAINMESSAGE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                    if (success) {
                        BOOL Resutl = [json[@"Result"] boolValue];
                        if (Resutl) {
                            BOOL isfriendRed = [json[@"Data"][@"friendRed"] boolValue];
                            NSInteger  attSize = [json[@"Data"][@"attSize"] integerValue];
                            if ([self.delegate respondsToSelector:@selector(changRedBadValueAttSize:andFriendRed:andShowType:)]) {
                                //self.title = @"石圈"
                                [self.delegate changRedBadValueAttSize:attSize andFriendRed:isfriendRed andShowType:self.title];
                                //这句话出现，从前台进入后台，在从后台进入前台，会导致self.tabBarController.tabBar.hidden = NO;出现
                              //  self.tabBarController.tabBar.hidden = NO;
                            }
                        }else{
                            if ([self.delegate respondsToSelector:@selector(changRedBadValueAttSize:andFriendRed:andShowType:)]) {
                                //self.title = @"石圈"
                                [self.delegate changRedBadValueAttSize:0 andFriendRed:NO andShowType:self.title];
                                //这句话出现，从前台进入后台，在从后台进入前台，会导致self.tabBarController.tabBar.hidden = NO;出现
                                //  self.tabBarController.tabBar.hidden = NO;
                            }
                            
                        }
                    }else{
                        if ([self.delegate respondsToSelector:@selector(changRedBadValueAttSize:andFriendRed:andShowType:)]) {
                            //self.title = @"石圈"
                            [self.delegate changRedBadValueAttSize:0 andFriendRed:NO andShowType:self.title];
                            //这句话出现，从前台进入后台，在从后台进入前台，会导致self.tabBarController.tabBar.hidden = NO;出现
                            //  self.tabBarController.tabBar.hidden = NO;
                        }
                    }
                }];
                // }
            }
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(changRedBadValueAttSize:andFriendRed:andShowType:)]) {
            //self.title = @"石圈"
            [self.delegate changRedBadValueAttSize:0 andFriendRed:NO andShowType:self.title];
            //这句话出现，从前台进入后台，在从后台进入前台，会导致self.tabBarController.tabBar.hidden = NO;出现
            //  self.tabBarController.tabBar.hidden = NO;
        }
    }
}


- (RSUserModel *)userModel{
    return nil;
}


//#pragma mark -- 获取版本号
//- (void)getAPPCurrentVersion{
//    //当前APP的名称
//    //NSString * currentAppName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
//    //当前APP的版本
//    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    //app build版本
//    //NSString *currentBulid = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
//    //包名
//    NSString * currentBundleIdentifier = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"APP_TYPE"];
//    [phoneDict setObject:currentBundleIdentifier forKey:@"VERSION"];
//    [phoneDict setObject:currentVersion forKey:@"versionCode"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (applegate.ERPID == nil) {
//        applegate.ERPID = @"0";
//    }
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_CURRENTVERSION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                NSString * updateName = [NSString stringWithFormat:@"%@",json[@"MSG_CODE"]];
//                NSString * url = [NSString stringWithFormat:@"%@",json[@"Data"][@"URL"]];
//                //判断第一次进来之后的显示系统的问题
//                if (![currentVersion isEqualToString:json[@"Data"][@"VERSIONCODE"]]) {
//                    [JHSysAlertUtil presentAlertViewWithTitle:@"商店有最新版" message:updateName cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
//                    } confirm:^{
//                        //随便的
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//                    }];
//                }
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"获取版本错误"];
//            }
//        }
//    }];
//}

/**
 数据项含义    字段名    字段类型    说明
 商圈id    friendId    int
 操作人id    userId    int    评论/点赞人 id
 操作类别    type    String    pl/dz/gz  评论/点赞/关注
 评论内容    commenter    String
 被评论人    relUserId    Int    评论人的回复对象id
 评论模式    CommentMod    Int    1：评论商圈  2:评论用户
 评论时才传改参数
 */


//#pragma mark -- 点赞，评论，关注统一一个接口
- (void)obtailComment:(NSString *)commentStr andType:(NSString *)type andUserID:(NSString *)userId andMoment:(NSString *)friendId andCommentMod:(int)commentMod andcommentUserId:(NSString *)commentUserId andCommentId:(NSString *)commentId{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    // 商圈id    friendId    int
    [phoneDict setObject:friendId forKey:@"friendId"];
    // 操作人id    userId    int    评论/点赞人 id
    [phoneDict setObject:userId forKey:@"userId"];
    // 评论内容    commenter    String
    [phoneDict setObject:commentStr forKey:@"commenter"];
    // 操作类别    type    String    pl/dz/gz  评论/点赞/关注
    [phoneDict setObject:type forKey:@"type"];
    //被评论人    relUserId    Int    评论人的回复对象id
    //如果等于1那么传的是userId ,2 就是传commentUserId
    [phoneDict setObject:commentUserId forKey:@"relUserId"];
    // 评论模式    CommentMod    Int    1：评论商圈  2:评论用户
    //删除commentId
    [phoneDict setObject:commentId forKey:@"commentId"];
    //评论时才传改参数
    [phoneDict setObject:[NSString stringWithFormat:@"%d",commentMod] forKey:@"commentMod"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DIANZAO_PL_GZ_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                if ([type isEqualToString:@"dz"]) {
                    //这边是点赞的状态
                   // NSString * status = json[@"Data"][@"status"];
                   //  NSString * codeStr = [NSString stringWithFormat:@"%@",status];
                    
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"dz"];
                    
//                    if (_cell.menuView.likeBtn.selected) {
//                        _cell.moment.isPraise = 1;
//                        NSString * status = json[@"Data"][@"status"];
//                        _cell.moment.likestatus = status;
//                        _cell.menuView.likeBtn.selected = YES;
//                        RSLike * like = [[RSLike alloc]init];
//                        like.SYS_USER_ID = self.userModel.userID;
//                        like.USER_NAME = self.userModel.userName;
//                        like.USER_TYPE = self.userModel.userType;
//                        like.likeID = _cell.moment.userid;
//                        [_cell.moment.likeList addObject:like];
//
//                    }else{
//                        _cell.moment.isPraise = 0;
//                        NSString * status = json[@"Data"][@"status"];
//                        _cell.moment.likestatus = status;
//                        _cell.menuView.likeBtn.selected = NO;
//                        for (int i = 0; i < _cell.moment.likeList.count; i++) {
//                            RSLike * like = _cell.moment.likeList[i];
//                            if ([like.USER_NAME isEqualToString:self.userModel.userName]) {
//                                [_cell.moment.likeList removeObjectAtIndex:i];
//                            }
//                        }
//                    }
//                    [self.momentList replaceObjectAtIndex:_cell.tag withObject:_cell.moment];
//                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    [weakSelf reloadArrayDataMoment:_cell.moment andMomentList:weakSelf.momentList andshowType:self.showType];

                }else if([type isEqualToString:@"pl"]){
//                    //这边是评论的状态
//                    Comment * currentComment = [[Comment alloc]init];
//                    currentComment.comment = [NSString stringWithFormat:@"%@",json[@"Data"][@"value"]];
//                    //这边是当前用户自己
//                    currentComment.relUser = self.userModel.userName;
//                    currentComment.relUserId = [NSString stringWithFormat:@"%@",json[@"Data"][@"beCommentedUserId"]];
//                    currentComment.commentUserId = [NSString stringWithFormat:@"%@",json[@"Data"][@"commentUserId"]];
//                    currentComment.commentId = [NSString stringWithFormat:@"%@",json[@"Data"][@"id"]];
//
//                    currentComment.commentUserType = self.userModel.userType;
//
//                    if ([self.selectType isEqualToString:@"1"]) {
//                        currentComment.commentmod = 1;
//                        Moment * moment = _cell.moment;
//                         currentComment.relUserType = self.userModel.userType;
//                        //当前用户自己
//                        currentComment.commentName = self.userModel.userName;
//                        [moment.commentList addObject:currentComment];
//                        [self.momentList replaceObjectAtIndex:_cell.tag withObject:moment];
//                        //[self.tableView reloadData];
//                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    }else if ([self.selectType isEqualToString:@"2"]){
//                        Moment *moment = _cell.moment;
//                        if (_currentComment.commentmod == 2) {
//                            //别人评论之后和评论你在评论别人的东西
//                             currentComment.relUserType = _currentComment.relUserType;
//                            currentComment.commentmod = 2;
//                            //当前登录者
//                            currentComment.relUser = _currentComment.relUser;
//                            currentComment.commentName = self.userModel.userName;
//                            [moment.commentList addObject:currentComment];
//                            [self.momentList replaceObjectAtIndex:_cell.tag withObject:moment];
//                        }else{
//                            //直接评论
//                            currentComment.commentmod = 2;
//                            //当前登录者
//                            currentComment.relUser = _currentComment.commentName;
//                            currentComment.commentName =self.userModel.userName;
//                            [moment.commentList addObject:currentComment];
//                            [self.momentList replaceObjectAtIndex:_cell.tag withObject:moment];
//                        }
//                        // [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
//                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    }
                    
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"pl"];
                   
 
                }else if([type isEqualToString:@"gz"]){
                    
                   //  [weakSelf loadFriendDetailOneNewData:_cell andType:@"gz"];
                    
        
                   //这边是关注的地方
                    NSString * attentionStr = json[@"Data"][@"status"];
                    NSString * codeStr = [NSString stringWithFormat:@"%@",attentionStr];
                    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:_cell.attentionBtn.tag - 1000 inSection:0];
                    Moment * moment = self.momentList[indexpath.row];
                    moment.attstatus = [NSString stringWithFormat:@"%@",codeStr];
                    [weakSelf.momentList replaceObjectAtIndex:indexpath.row withObject:moment];
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                    [weakSelf changAttatitionDataMoment:moment andShowType:self.showType];

                }else{
                    //删除评论
                    //知道当前评论的内容和当前是那个cell
                    
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"sc"];
                    
//                    for (int i = 0 ; i < _cell.moment.commentList.count; i++) {
//                        Comment * comment = _cell.moment.commentList[i];
//                        if ([comment.commentId isEqualToString:_currentComment.commentId]) {
//                            [_cell.moment.commentList removeObjectAtIndex:i];
//                            [weakSelf.momentList replaceObjectAtIndex:_cell.tag withObject:_cell.moment];
//                            break;
//                        }
//                    }
//                    [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }
            }else{
                if ([type isEqualToString:@"pl"]) {
                    [SVProgressHUD showErrorWithStatus:@"评论失败"];
                }else if ([type isEqualToString:@"dz"]){
                    [SVProgressHUD showErrorWithStatus:@"点赞失败"];
                }else if ([type isEqualToString:@"gz"]){
                    [SVProgressHUD showErrorWithStatus:@"关注失败"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"删除失败"];
                }
            }
        }else{
            if ([type isEqualToString:@"pl"]) {
                [SVProgressHUD showErrorWithStatus:@"评论失败"];
            }else if ([type isEqualToString:@"dz"]){
                [SVProgressHUD showErrorWithStatus:@"点赞失败"];
            }else if ([type isEqualToString:@"gz"]){
                [SVProgressHUD showErrorWithStatus:@"关注失败"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }
    }];
}


//获取特定的朋友圈
- (void)loadFriendDetailOneNewData:(MomentCell *)cell andType:(NSString *)type{
    self.isRefresh = true;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.showType forKey:@"showType"];
    [phoneDict setObject:self.selectStr forKey:@"friendType"];
    [phoneDict setObject:cell.moment.friendId forKey:@"friendId"];
    NSString * str = nil;
    if (self.userModel.userID == nil) {
        str = @"-1";
        // self.userModel.userID = [NSString stringWithFormat:@"%@",str];
    }else{
        str = self.userModel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    // [phoneDict setObject:EPRID(1) forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int j = 0; j < array.count; j++) {
                    Moment *moment = [[Moment alloc]init];
                    moment.index = j;
                    moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                    moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                    moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
                    moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
                    moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                    moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                    moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                    moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
                    moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                    moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
                    moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                    moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                    moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
                    moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                    moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                    moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                    moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                    moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                    moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                    moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                    moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                    moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                    moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                    moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                    moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                    moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                    moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
                    moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                    moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
                    moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                    moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                    moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
                    moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                    moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
                    NSMutableArray * tempArray = [NSMutableArray array];
                    //评论
                    tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
                    for (int i = 0 ; i < tempArray.count; i++) {
                        Comment * commen = [[Comment alloc]init];
                        commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
                        commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
                        commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
                        commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
                        commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
                        commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
                        commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
                        commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
                        commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
                        commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
                        commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
                        commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
                        commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
                        commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
                        [moment.commentList addObject:commen];
                    }
                    
                    
                    
                    NSMutableArray * likeArray = [NSMutableArray array];
                    likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
                    for (int n = 0; n < likeArray.count; n++) {
                        RSLike * like = [[RSLike alloc]init];
                        like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
                        like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
                        like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
                        like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
                        [moment.likeList addObject:like];
                    }
                    
                    /**
                     NSMutableArray *newArray = [_alertsArray mutableCopy];
                     [newArray replaceObjectAtIndex:3 withObject:@"YES"];
                     _alertsArray = newArray;
                     */
                    if ([type isEqualToString:@"pl"] || [type isEqualToString:@"sc"]) {
                        cell.moment.commentList = moment.commentList;
                    }else if ([type isEqualToString:@"dz"]){
                        cell.moment.likenum = moment.likenum;
                        cell.moment.likestatus = moment.likestatus;
                        cell.moment.likeList = moment.likeList;
                    }else if ([type isEqualToString:@"gz"]){
                    }
                     [weakSelf reloadArrayDataMoment:cell.moment andMomentList:weakSelf.momentList andshowType:self.showType];
                    [UIView setAnimationsEnabled:NO];
                   // [weakSelf.momentList replaceObjectAtIndex:cell.tag withObject:moment];
                     [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                   // [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_cell.tag inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                     [UIView setAnimationsEnabled:YES];
                }
            }
        }
    }];
}






#pragma mark -- 刷新新的数据
- (void)loadNewData{
    self.isRefresh = true;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.showType forKey:@"showType"];
    [phoneDict setObject:_selectStr forKey:@"friendType"];
    NSString * str = nil;
    if (self.userModel.userID == nil) {
        str = @"-1";
    }else{
        str = self.userModel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    // [phoneDict setObject:EPRID(1) forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue] ;
            if (Result) {
                [weakSelf.momentList removeAllObjects];
                    NSMutableArray *array = [NSMutableArray array];
                    array = json[@"Data"];
               
                    for (int j = 0; j < array.count; j++) {
                        Moment *moment = [[Moment alloc]init];
                        moment.index = j;
                        moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                        moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                        moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
                        moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
                        moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                        moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                        moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                        moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
                        moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                        moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
                        moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                        moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
                        moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                        moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                        moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                        moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                        moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                        moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                        moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                        moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                        moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                        moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                        moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                        moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                        moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                        moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
                        moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                        moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
                        moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                        moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                        moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
                        moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                        moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
                        NSMutableArray * tempArray = [NSMutableArray array];
                        //评论
                        tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
                        for (int i = 0 ; i < tempArray.count; i++) {
                            Comment * commen = [[Comment alloc]init];
                            commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
                            commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
                            commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
                            commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
                            commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
                            commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
                            commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
                            commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
                            commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
                            commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
                            commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
                            commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
                            commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
                            commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
                            [moment.commentList addObject:commen];
                        }
                        NSMutableArray * likeArray = [NSMutableArray array];
                        likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
                        for (int n = 0; n < likeArray.count; n++) {
                            RSLike * like = [[RSLike alloc]init];
                            like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
                            like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
                            like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
                            like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
                            [moment.likeList addObject:like];
                        }
                        [weakSelf.momentList addObject:moment];
                        //点赞
                    }
                weakSelf.pageNum = 2;
                //停止刷新
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
                if ([_selectStr isEqualToString:@""]) {
                    if ([self.showType isEqualToString:@"all"]) {
                        //全部的时候
                       // RSFriendModel *friendModel = weakSelf.friendArray[0];
                        if (weakSelf.momentList.count > 0) {
                            Moment * moment =  weakSelf.momentList[0];
                            _tempFriendID = moment.friendId;
                        }
                    }
                    //刷新的时候对消息角标进行处理下
                    if ([weakSelf.delegate respondsToSelector:@selector(hideRedBadValueTitle:)]) {
                        [weakSelf.delegate hideRedBadValueTitle:weakSelf.title];
                    }
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"badgeValuerefresh" object:nil];
            }else{
                 [SVProgressHUD showErrorWithStatus:@"获取失败"];
                [weakSelf.tableView.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableView.mj_header endRefreshing];
        }
    }];
}

- (void)footNewData{
     self.isRefresh = false;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.showType forKey:@"showType"];
    [phoneDict setObject:_selectStr forKey:@"friendType"];
    NSString * str = nil;
    if (self.userModel.userID == nil) {
        str = @"-1";
    }else{
        str = self.userModel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    // [phoneDict setObject:EPRID(1) forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue] ;
            if (Result) {
                NSMutableArray *array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                   // NSMutableArray * temp = [NSMutableArray array];
                    for (int j = 0; j < array.count; j++) {
                        Moment *moment = [[Moment alloc]init];
                        moment.index = j;
                        moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                        moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                        moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
                        moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
                        moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                        moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                        moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                        moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
                        moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                        moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
                        moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                        moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
                        moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                        moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                        moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                        moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                        moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                        moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                        moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                        moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                        moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                        moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                        moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                        moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                        moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                        moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
                        moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                        moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
                        moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                        moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                        moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
                        moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                        moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
                        NSMutableArray * tempArray = [NSMutableArray array];
                        //评论
                        tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
                        for (int i = 0 ; i < tempArray.count; i++) {
                            Comment * commen = [[Comment alloc]init];
                            commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
                            commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
                            commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
                            commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
                            commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
                            commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
                            commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
                            commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
                            commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
                            commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
                            commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
                            commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
                            commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
                            commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
                            [moment.commentList addObject:commen];
                        }
                        NSMutableArray * likeArray = [NSMutableArray array];
                        likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
                        for (int n = 0; n < likeArray.count; n++) {
                            RSLike * like = [[RSLike alloc]init];
                            like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
                            like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
                            like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
                            like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
                            [moment.likeList addObject:like];
                        }
                      //  [temp addObject:moment];
                        
                        [weakSelf.momentList addObject:moment];
                        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:weakSelf.momentList.count -1 inSection:0];
                        [weakSelf.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                   // [weakSelf.momentList addObjectsFromArray:temp];
                    weakSelf.pageNum++;
                  //  [weakSelf.tableView reloadData];
                }
                  [weakSelf.tableView.mj_footer endRefreshing];
            }else{
                [weakSelf.tableView.mj_footer endRefreshing];
                [weakSelf.tableView reloadData];
            }
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        }
    }];
}



#pragma mark - UI
- (void)setUpUI
{
    [self.view addSubview:self.tableView];
    
    //[self.view addSubview:self.textfield];
    [self.view addSubview:self.cmtView];
    
    
//    //这边要添加一个键盘输入文字的uitextview;
//    UITextField * textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, SCH, SCW, 50)];
//    textfield.textAlignment = NSTextAlignmentLeft;
//    textfield.textColor = [UIColor blackColor];
//    textfield.userInteractionEnabled =YES;
//    textfield.delegate = self;
//    textfield.font = [UIFont systemFontOfSize:18];
//    textfield.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    textfield.placeholder = @"回复:";
//    [self.view addSubview:textfield];
//    //[textfield bringSubviewToFront:self.view];
//    _textfield = textfield;

    UIScrollView * friendStyleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCW, 95)];
    NSArray * styleArray = @[@"全部",@"荒料",@"大板",@"花岗岩",@"生活",@"辅料",@"求购"];
    NSArray * imageArray = @[@"语全部",@"语荒料",@"语大板",@"语花岗岩",@"语生活",@"语辅料",@"语求购"];
    friendStyleView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    friendStyleView.delegate = self;
    [self.view addSubview:friendStyleView];
    friendStyleView.pagingEnabled = NO;
    friendStyleView.showsHorizontalScrollIndicator = NO;
    // 去掉弹簧效果
    
    NSInteger margin = 0;
    if (iPhone4 || iPhone5) {
        margin = 18;
    }else{
        margin = 24;
    }
    friendStyleView.bounces = NO;
    CGFloat fastBtnW = (SCW  - ((ECA + 1)*margin))/ECA;
    CGFloat fastBtnH = 75;
    for (int i = 0; i < styleArray.count; i++) {
        RSMomentButton * fastBtn = [[RSMomentButton alloc]init];
        fastBtn.tag = i;
        fastBtn.frame = CGRectMake(i * fastBtnW + i * margin + margin, 10, fastBtnW, fastBtnH);
        [fastBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [fastBtn setTitle:styleArray[i] forState:UIControlStateNormal];
        [fastBtn setBackgroundColor:[UIColor clearColor]];
        if (iPhone5) {
            fastBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        }else{
            fastBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        if (i == 0) {
           // [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FBB399"] forState:UIControlStateNormal];
            [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#9ECCEF"] forState:UIControlStateNormal];
            self.selectedBtn.selected = !self.selectedBtn.selected;
            fastBtn.selected = !fastBtn.selected;
            self.selectedBtn = fastBtn;
        }else{
            [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        }
        [fastBtn addTarget:self action:@selector(selectBtnStyle:) forControlEvents:UIControlEventTouchUpInside];
        [friendStyleView addSubview:fastBtn];
    }
    friendStyleView.contentSize = CGSizeMake(styleArray.count * fastBtnW + (styleArray.count + 1) * margin , 0);
    self.tableView.tableHeaderView = friendStyleView;
}

- (void)selectBtnStyle:(UIButton *)selectBtn{
    if ([selectBtn.titleLabel.text isEqualToString:@"全部"]) {
        _selectStr = @"";
         [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#9ECCEF"] forState:UIControlStateNormal];
    }else if ([selectBtn.titleLabel.text isEqualToString:@"荒料"]) {
        _selectStr = @"huangliao";
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FAA5BC"] forState:UIControlStateNormal];
    }else if ([selectBtn.titleLabel.text isEqualToString:@"大板"]){
        _selectStr = @"daban";
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FBB399"] forState:UIControlStateNormal];
    }else if ([selectBtn.titleLabel.text isEqualToString:@"花岗岩"]){
        _selectStr = @"huagangyan";
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#F4D09F"] forState:UIControlStateNormal];
    }else if ([selectBtn.titleLabel.text isEqualToString:@"生活"]){
        _selectStr = @"shenghuo";
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#BAE7C2"] forState:UIControlStateNormal];
    }else if ([selectBtn.titleLabel.text isEqualToString:@"辅料"]){
        _selectStr = @"fuliao";
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#9EDCEF"] forState:UIControlStateNormal];
    }else if ([selectBtn.titleLabel.text isEqualToString:@"求购"]){
        _selectStr = @"qiugou";
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#CDB3FC"] forState:UIControlStateNormal];
    }
    if (!selectBtn.isSelected) {
        self.selectedBtn.selected = !self.selectedBtn.selected;
        //self.selectedBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        [self.selectedBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        selectBtn.selected = !selectBtn.selected;
        //selectBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#C1DAFF"];
       // [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FBB399"] forState:UIControlStateNormal];
        self.selectedBtn = selectBtn;
        // [self.allBtn setBackgroundColor:[UIColor whiteColor]];
    }
    [self loadNewData];
}






- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
        if ([temp length] < 1){
            _cell.imageListView.userInteractionEnabled = YES;
            self.cmtView.inputView.text = @"";
            [self.cmtView.inputView resignFirstResponder];
        }else{
            self.cmtView.inputView.text = temp;
            //如果等于1那么传的是userId ,2 就是传commentUserId
            NSString * str = [NSString string];
            if ([self.selectType isEqualToString:@"1"]) {
                str = self.userModel.userID;
            }else{
                str = _currentComment.commentUserId;
            }
            [self obtailComment:self.cmtView.inputView.text andType:@"pl" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:[self.selectType intValue] andcommentUserId:str andCommentId:@""];
            
        }
        //在这里做你响应return键的代码
        [self.cmtView.inputView resignFirstResponder];
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}




//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    temp = [self delSpaceAndNewline:temp];
//    if ([temp length] < 1){
//        _cell.imageListView.userInteractionEnabled = YES;
//        self.textfield.text = @"";
//        [self.textfield resignFirstResponder];
//    }else{
//        self.textfield.text = temp;
//        //如果等于1那么传的是userId ,2 就是传commentUserId
//        NSString * str = [NSString string];
//        if ([self.selectType isEqualToString:@"1"]) {
//            str = self.userModel.userID;
//        }else{
//            str = _currentComment.commentUserId;
//        }
//        [self obtailComment:self.textfield.text andType:@"pl" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:[self.selectType intValue] andcommentUserId:str andCommentId:@""];
//
//    }
//    textField.text = @"";
//    textField.placeholder = @"回复";
//    [textField resignFirstResponder];
//    return YES;
//}
//
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([string isEqualToString:@"\n"]) {
//        _cell.imageListView.userInteractionEnabled = YES;
//        textField.text = @"";
//        textField.placeholder = @"回复";
//        [textField resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//- (void)changTextViewFrame:(UITextField *)textfield{
//    CGSize size = [textfield.text boundingRectWithSize:CGSizeMake(SCW, CGFLOAT_MAX)
//                                                              options:NSStringDrawingUsesLineFragmentOrigin
//                                                           attributes:@{NSFontAttributeName:textfield.font}
//                                               context:nil].size;
//    textfield.frame = CGRectMake(0, self.height, SCW, size.height);
//}


//点赞评论内容的
- (void)didLikeContentTitleLike:(RSLike *)like{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        
        
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
//        self.textfield.text = @"";
//        self.textfield.placeholder = @"回复";
//        [self.textfield resignFirstResponder];
        if ([like.USER_TYPE isEqualToString:@"hxhz"]) {
           
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:like.SYS_USER_ID andUserIDStr:like.SYS_USER_ID];
            cargoCenterVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
            
        }else{
            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
            myRingVc.erpCodeStr = @"";
            myRingVc.userIDStr = like.SYS_USER_ID;
            //新添加一个是游客还是货主
            myRingVc.userType = like.USER_TYPE;
            myRingVc.creat_userIDStr = like.SYS_USER_ID;
            myRingVc.userModel = self.userModel;
            myRingVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myRingVc animated:YES];
        }
    }
}





#pragma mark -- 显示键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            //self.textfield.frame  = CGRectMake(0,SCH - offset - 130, SCW, 50);
            self.cmtView.frame = CGRectMake(0, SCH - offset - 130, SCW, 50);
        }];
    }
}

#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
       // self.textfield.frame = CGRectMake(0, SCH, SCW, 50);
        self.cmtView.frame = CGRectMake(0, SCH , SCW, 50);
    }];
}

#pragma mark - MomentCellDelegate
// 点击用户头像
- (void)didClickProfile:(MomentCell *)cell
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
//        self.textfield.text = @"";
//        self.textfield.placeholder = @"回复";
//        [self.textfield resignFirstResponder];
        if ([cell.moment.userType isEqualToString:@"hxhz"]) {
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
            cargoCenterVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
        }else{
            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
            myRingVc.erpCodeStr = cell.moment.erpCode ;
            myRingVc.userIDStr = cell.moment.userid;
            //新添加一个是游客还是货主
            /**
             myRingVc.userType = _currentComment.commentUserType;
             myRingVc.creat_userIDStr = _currentComment.commentUserId
             */
            myRingVc.userType = cell.moment.userType;
            myRingVc.creat_userIDStr = cell.moment.create_user;
            myRingVc.userModel = self.userModel;
            myRingVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myRingVc animated:YES];
        }
    }
}

//点击用户名称
- (void)didClickName:(MomentCell *)cell{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
//        self.textfield.text = @"";
//        self.textfield.placeholder = @"回复";
//        [self.textfield resignFirstResponder];
        if ([cell.moment.userType isEqualToString:@"hxhz"]) {
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
            cargoCenterVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
          
        }else{
            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
            myRingVc.erpCodeStr = cell.moment.erpCode;
            myRingVc.userIDStr = cell.moment.userid;
            myRingVc.userType = cell.moment.userType;
            myRingVc.creat_userIDStr = cell.moment.create_user;
            myRingVc.userModel = self.userModel;
            myRingVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myRingVc animated:YES];
        }
    }
}

// 点赞
- (void)didLikeMoment:(MomentCell *)cell
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
//        self.textfield.text = @"";
//        self.textfield.placeholder = @"回复";
//        [self.textfield resignFirstResponder];
        cell.menuView.likeBtn.selected = !cell.menuView.likeBtn.selected;
        if (cell.menuView.likeBtn.selected) {
            [cell.menuView.likeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353D40"]];
            [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path1"] forState:UIControlStateNormal];
            [cell.menuView.likeBtn setTitle:@"取消" forState:UIControlStateNormal];
        }else{
            cell.menuView.likeBtn.backgroundColor = [UIColor clearColor];
            [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
            [cell.menuView.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
        }
        _cell = cell;
        [self obtailComment:@"" andType:@"dz" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
    }
}






// 评论
- (void)didAddComment:(MomentCell *)cell
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        
        //self.textfield.text = @"";
        self.cmtView.inputView.text = @"";
        self.selectType = @"1";
         [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
        _cell = cell;
        cell.menuView.show = NO;
       // self.textfield.placeholder = @"回复";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        
        cell.imageListView.userInteractionEnabled = NO;
       // [self.textfield becomeFirstResponder];
        [self.cmtView.inputView becomeFirstResponder];
    }
}

- (void)didCurrentShowImageView{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    self.textfield.text = @"";
//    self.textfield.placeholder = @"回复";
//    [self.textfield resignFirstResponder];
}

// 查看全文/收起
- (void)didSelectFullText:(MomentCell *)cell
{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
   // self.textfield.text = @"";
   // self.textfield.placeholder = @"回复";
     //[self.textfield resignFirstResponder];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

//// 删除
//- (void)didDeleteMoment:(MomentCell *)cell
//{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        // 取消
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        // 删除
//        [self.momentList removeObject:cell.moment];
//        [self.tableView reloadData];
//    }]];
//    [self presentViewController:alert animated:YES completion:nil];
//}

// 选择评论
- (void)didSelectComment:(Comment *)comment andMomentCell:(MomentCell *)cell{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        //self.textfield.text = @"";
        self.cmtView.inputView.text = @"";
        _cell.imageListView.userInteractionEnabled = YES;
        _currentComment = comment;
        _cell = cell;
        if ([_currentComment.commentName isEqualToString:self.userModel.userName]) {
            //这边是做的
            
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除评论" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
                 [self obtailComment:@"" andType:@"sc" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:0 andcommentUserId: _currentComment.relUserId andCommentId: _currentComment.commentId];
            }];
        }else{
            self.selectType = @"2";
            cell.menuView.show = NO;
            //[self.textfield becomeFirstResponder];
            [self.cmtView.inputView becomeFirstResponder];
            cell.imageListView.userInteractionEnabled = NO;
            [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
           // self.textfield.placeholder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
            self.cmtView.inputView.zw_placeHolder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
        }
    }
}

//分享
- (void)didShareMoment:(MomentCell *)cell{
    //这边要改的模型的地方
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    self.textfield.text = @"";
//    self.textfield.placeholder = @"回复";
//    [self.textfield resignFirstResponder];
    cell.menuView.show = NO;
    Moment * moment = cell.moment;
    NSArray *shareButtonTitleArray = nil;
    NSArray *shareButtonImageNameArray = nil;
    shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
    shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andMoment:moment];
    [lxActivity showInView:self.view];
}

#pragma mark - LXActivityDelegate分享---这个方法还是要修改
- (void)didClickOnImageIndex:(NSInteger *)imageIndex andMoment:(Moment *)moment{
    [RSWeChatShareTool weChatShareStyleImageIndex:imageIndex andMoment:moment];
}

//FIXME:点击视频的地方
- (void)didCurrentCellVideoUrl:(Moment *)moment{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    self.textfield.text = @"";
//    self.textfield.placeholder = @"回复";
//     [self.textfield resignFirstResponder];
    [RSJumpPlayVideoTool canYouSkipThePlaybackVideoInterfaceMoment:moment andViewController:self];
}

// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText andComment:(Comment *)comment andCell:(MomentCell *)cell
{
    /**
     MLLinkTypeNone          = 0,
     MLLinkTypeURL           = 1,          // 链接
     MLLinkTypePhoneNumber   = 2,          // 电话
     MLLinkTypeEmail         = 3,          // 邮箱
     MLLinkTypeUserHandle    = 4,          //@
     MLLinkTypeHashtag       = 5,          //#..
     
     MLLinkTypeOther        = 30,          //这个一般是和MLDataDetectorTypeAttributedLink对应的，但是也可以自己随意添加啦，不过是一个标识而已，至于为什么30，随便定的，预留上面空间以添加新的个性化
     */
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
    
//    self.textfield.text = @"";
//    self.textfield.placeholder = @"回复";
//    [self.textfield resignFirstResponder];
    _cell = cell;
    _currentComment = comment;
    // [self.textfield resignFirstResponder];
    if (link.linkType == 1) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:linkText]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
        }
    }else if (link.linkType == 2){
        NSMutableString *  phoneMutableStr = [[NSMutableString alloc] initWithFormat:@"tel:%@",linkText];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneMutableStr]];
    }else if (link.linkType == 3){
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:linkText]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
        }
    }else{
        if ([_currentComment.commentName isEqualToString:linkText]) {
            if ([_currentComment.commentUserType isEqualToString:@"hxhz"]) {
                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:_currentComment.commentUserId andUserIDStr:_currentComment.commentUserId];
                cargoCenterVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cargoCenterVc animated:YES];
            }else{
                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
                myRingVc.erpCodeStr = @"";
                myRingVc.userIDStr = _currentComment.commentUserId;
                //新添加一个是游客还是货主
                myRingVc.userType = _currentComment.commentUserType;
                myRingVc.creat_userIDStr = _currentComment.commentUserId;
                myRingVc.userModel = self.userModel;
                myRingVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myRingVc animated:YES];
            }
            return;
        }
        
        if ([_currentComment.relUser isEqualToString:linkText]) {
            if ([_currentComment.relUserType isEqualToString:@"hxhz"]) {
                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:_currentComment.relUserId andUserIDStr:_currentComment.relUserId];
                 cargoCenterVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cargoCenterVc animated:YES];
            }else{
                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
                myRingVc.erpCodeStr = @"";
                myRingVc.userIDStr = _currentComment.relUserId;
                //新添加一个是游客还是货主
                myRingVc.userType = _currentComment.relUserType;
                myRingVc.creat_userIDStr = _currentComment.relUserId;
                myRingVc.userModel = self.userModel;
                myRingVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myRingVc animated:YES];
            }
            return;
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.momentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MomentCell";
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MomentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    Moment * moment = [self.momentList objectAtIndex:indexPath.row];
    cell.moment = moment;
    cell.delegate = self;
    [cell.attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.attentionBtn.tag = 1000+indexPath.row;
    cell.menuView.shareBtn.tag = 100000 + indexPath.row;
    cell.menuView.commentBtn.tag = 100000 + indexPath.row;
    cell.menuView.likeBtn.tag = 100000 + indexPath.row;
    //没有关注和关注的状态
    if ([[NSString stringWithFormat:@"%@",moment.attstatus] isEqualToString:@"0"]) {
        [cell.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [cell.attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#4C618E"] forState:UIControlStateNormal];
        [cell.attentionBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        cell.attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#4C618E"].CGColor;
    }else{
        [cell.attentionBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [cell.attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#B2B2B2"] forState:UIControlStateNormal];
        [cell.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        cell.attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
    }
    if ([[NSString stringWithFormat:@"%@",moment.likestatus] isEqualToString:@"0"]) {
        //没有点赞
        cell.menuView.likeBtn.selected = NO;
        cell.menuView.likeBtn.backgroundColor = [UIColor clearColor];
        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
        [cell.menuView.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    }else{
        //已经点赞
        cell.menuView.likeBtn.selected = YES;
        [cell.menuView.likeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353D40"]];
        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path1"] forState:UIControlStateNormal];
        [cell.menuView.likeBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    cell.tag = indexPath.row;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.momentList.count - 2) {
        [self.tableView.mj_footer beginRefreshing];
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 使用缓存行高，避免计算多次
    Moment *moment = [self.momentList objectAtIndex:indexPath.row];
    return moment.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        // loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
//        self.textfield.text = @"";
//        self.textfield.placeholder = @"回复";
//        [self.textfield resignFirstResponder];
            Moment *moment = [self.momentList objectAtIndex:indexPath.row];
            RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
            friendDetailVc.title = moment.HZName;
            friendDetailVc.titleStyle = self.title;
            friendDetailVc.friendID = moment.friendId;
            friendDetailVc.selectStr = _selectStr;
            friendDetailVc.titleStyle = self.title;
          //  friendDetailVc.hidesBottomBarWhenPushed = YES;
            friendDetailVc.userModel = self.userModel;
            [self.navigationController pushViewController:friendDetailVc animated:YES];
    }
}


//FIXME:关注
- (void)attentionAction:(UUButton *)attentionBtn{
    //关注
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        _cell.imageListView.userInteractionEnabled = YES;
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
//        self.textfield.text = @"";
//        self.textfield.placeholder = @"回复";
//        [self.textfield resignFirstResponder];
        //这边是关注要做的事情
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:attentionBtn.tag - 1000 inSection:0];
        Moment * moment = self.momentList[indexpath.row];
        _cell = (MomentCell *)[self.tableView cellForRowAtIndexPath:indexpath];
        RSWeakself
        if ( [attentionBtn.currentTitle isEqualToString:@"已关注"]) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
                [weakSelf obtailComment:@"" andType:@"gz" andUserID:self.userModel.userID andMoment:moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
            }];
        }else{
            [weakSelf obtailComment:@"" andType:@"gz" andUserID:self.userModel.userID andMoment:moment.friendId andCommentMod:0 andcommentUserId:self.userModel.userID andCommentId:@""];
        }
    }
}

//这边是对俩个点赞的地方进行代理
- (void)reloadArrayDataMoment:(Moment *)moment andMomentList:(NSMutableArray *)momentList andshowType:(NSString *)showType{
    
    if ([self.delegate respondsToSelector:@selector(reloadArrayDataMoment:andMomentList:andshowType:)]) {
        [self.delegate reloadArrayDataMoment:moment andMomentList:self.momentList andshowType:self.showType];
    }
}
//这边是对关注的地方进行代理
- (void)changAttatitionDataMoment:(Moment *)moment andShowType:(NSString *)showType{
    if ([self.delegate respondsToSelector:@selector(changAttatitionDataMoment:andShowType:)]) {
        [self.delegate changAttatitionDataMoment:moment andShowType:showType];
    }
}








#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    self.textfield.text = @"";
//    self.textfield.placeholder = @"回复";
//     [self.textfield resignFirstResponder];
    _cell.imageListView.userInteractionEnabled = YES;
   
    NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    MomentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.menuView.show = NO;
}



#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"refreshData" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"refreshFriendStatus" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"delFriendData" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isNewData" object:nil];
}

@end
