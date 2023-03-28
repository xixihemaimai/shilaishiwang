//
//  RSShopCircleViewController.m
//  石来石往
//
//  Created by mac on 2021/11/1.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSShopCircleViewController.h"
#import "RSShopCircleCell.h"
#import "Moment.h"
#import "Comment.h"
#import "RSLike.h"
//分享
#import "LXActivity.h"
#import "RSWeChatShareTool.h"
//评论框
#import "CommentView.h"


#import "RSFriendDetailController.h"
#import "RSMyRingViewController.h"
#import "RSCargoCenterBusinessViewController.h"

@interface RSShopCircleViewController ()<RSShopCircleCellDelegate,LXActivityDelegate,UITextViewDelegate,RSFriendDetailControllerDelegate>

@property(nonatomic,strong)CommentView * cmtView;

@property (nonatomic,strong)Comment * currentComment;

@property (nonatomic,strong)RSShopCircleCell * cell;

//评论状态
@property (nonatomic,strong)NSString * selectType;

@property (nonatomic,assign)NSInteger pageNum;


/**选择你要看的选择的类型*/
@property (nonatomic,strong)NSString * selectStr;

@end

@implementation RSShopCircleViewController


-(CommentView *)cmtView
{
    if (!_cmtView){
        _cmtView = [[CommentView alloc]initWithFrame:CGRectMake(0, SCH, SCW, Height_Real(50))];
        _cmtView.inputView.delegate = self;
        _cmtView.inputView.zw_placeHolder = @"回复";
    }
    return _cmtView;
}


- (NSMutableArray *)momentList{
    if (!_momentList) {
        _momentList = [NSMutableArray array];
    }
    return _momentList;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshFriendStatus:) name:@"refreshFriendStatus" object:nil];
    
    //删除其中一个商圈
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteOneFriend) name:@"delFriendData" object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isAddjust];
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[RSShopCircleCell class] forCellReuseIdentifier:@"NEWSHOPCIRCLE"];
    [self.view addSubview:self.cmtView];
    if ([self.title isEqualToString:@"供应"]) {
        self.selectStr = @"gongying";
    }else{
        self.selectStr = @"qiugou";
    }
    self.selectType = @"0";
    [self loadNewDataWithPageSize:10 andIsHead:true];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewDataWithPageSize:10 andIsHead:true];
    }];
    
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self loadNewDataWithPageSize:10 andIsHead:false];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Height_Real(0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.momentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Moment * moment = self.momentList[indexPath.row];
    return moment.rowHeight + Height_Real(10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSShopCircleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NEWSHOPCIRCLE"];
    cell.moment = self.momentList[indexPath.row];
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [UserManger checkLogin:self successBlock:^{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
        Moment * moment = [self.momentList objectAtIndex:indexPath.row];
        RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
        friendDetailVc.title = moment.HZName;
        friendDetailVc.delegate = self;
        friendDetailVc.index = indexPath.row;
        friendDetailVc.titleStyle = self.title;
        friendDetailVc.friendID = moment.friendId;
        friendDetailVc.selectStr = self.selectStr;
        friendDetailVc.userModel = [UserManger getUserObject];
        [self.navigationController pushViewController:friendDetailVc animated:YES];
    }];
    
}


#pragma mark -- RSFriendDetailControllerDelegate
- (void)replaceMoment:(Moment *)moment andIndex:(NSInteger)index andType:(NSString *)type{
    [self.momentList replaceObjectAtIndex:index withObject:moment];
    
    if ([type isEqualToString:@"gz"]) {
        if ([self.delegate respondsToSelector:@selector(changAttatitionDataMoment:andSelectStr:)]) {
            [self.delegate changAttatitionDataMoment:moment andSelectStr:self.selectStr];
        }
        
        for (int j = 0; j < self.momentList.count; j++) {
            Moment * moment1 = self.momentList[j];
            if ([moment.HZName isEqualToString:moment1.HZName]) {
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:j inSection:0];
                moment1.attstatus = moment.attstatus;
                [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
        
    }else{
        
        [UIView setAnimationsEnabled:NO];
        [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [UIView setAnimationsEnabled:YES];
    }
}



#pragma mark -- 刷新新的数据
- (void)loadNewDataWithPageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead{
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:@"" forKey:@"showType"];
    [phoneDict setObject:self.selectStr forKey:@"friendType"];
    NSString * str = nil;
    if ([UserManger getUserObject].userID == nil) {
        str = @"-1";
    }else{
        str = [UserManger getUserObject].userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    BOOL isFresh = true;
    if (isHead) {
        isFresh = true;
        self.pageNum = 1;
    }else{
        isFresh = false;
        self.pageNum++;
    }
    if (self.searchType == 2) {
        [phoneDict setObject:self.searchStr forKey:@"searchText"];
    }
    [phoneDict setObject:[NSNumber numberWithBool:isFresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"page_num"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey]  == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
//    CLog(@"===============================%@",parameters);
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        CLog(@"=============================================%@",json);
        if (success) {
            BOOL Result = [json[@"Result"] boolValue] ;
            if (Result) {
                [SVProgressHUD dismiss];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
                if (isHead) {
                    [weakSelf.momentList removeAllObjects];
                    NSMutableArray *array = [NSMutableArray array];
                    array = json[@"Data"];
                    for (int i = 0; i < array.count; i++) {
                        Moment * moment = [Moment mj_objectWithKeyValues:[array objectAtIndex:i]];
                        moment.index = i;
                        moment.commentList = [Comment mj_objectArrayWithKeyValuesArray:[[array objectAtIndex:i]objectForKey:@"comment"]];
                        moment.likeList = [RSLike mj_keyValuesArrayWithObjectArray:[[array objectAtIndex:i]objectForKey:@"likeList"]];
                        [weakSelf.momentList addObject:moment];
                    }
                    [weakSelf.tableview.mj_header endRefreshing];
                }else{
                    NSMutableArray * tempArray = [NSMutableArray array];
                    NSMutableArray *array = [NSMutableArray array];
                    array = json[@"Data"];
                    for (int i = 0; i < array.count; i++) {
                        Moment * moment = [Moment mj_objectWithKeyValues:[array objectAtIndex:i]];
                        moment.index = i;
                        moment.commentList = [Comment mj_objectArrayWithKeyValuesArray:[[array objectAtIndex:i]objectForKey:@"comment"]];
                        moment.likeList = [RSLike mj_keyValuesArrayWithObjectArray:[[array objectAtIndex:i]objectForKey:@"likeList"]];
                        [tempArray addObject:moment];
                    }
                    [weakSelf.momentList addObjectsFromArray:tempArray];
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"badgeValuerefresh" object:nil];
                [weakSelf.tableview reloadData];
            }else{
                if (isHead) {
                    [weakSelf.tableview.mj_header endRefreshing];
                }else{
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
                [SVProgressHUD dismiss];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            }
        }else{
            [SVProgressHUD dismiss];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            if (isHead) {
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }
    }];
}


#pragma mark -- 点赞，评论，关注统一一个接口
- (void)obtailComment:(NSString *)commentStr andType:(NSString *)type andUserID:(NSString *)userId andMoment:(NSString *)friendId andCommentMod:(int)commentMod andcommentUserId:(NSString *)commentUserId andCommentId:(NSString *)commentId{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
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
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
//    CLog(@"=-==============================%@",parameters);
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DIANZAO_PL_GZ_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
//            CLog(@"=-==============================%@",json);
//            CLog(@"=-==============================%@",json[@"MSG_CODE"]);
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                if ([type isEqualToString:@"dz"]) {
                    //这边是点赞的状态
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"dz"];
                }else if([type isEqualToString:@"pl"]){
                    //这边是评论的状态
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"pl"];
                }else if([type isEqualToString:@"gz"]){
                    //关注
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"gz"];
//                    NSString * attentionStr = json[@"Data"][@"status"];
//                    NSString * codeStr = [NSString stringWithFormat:@"%@",attentionStr];
//                    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:_cell.attentionBtn.tag - 1000 inSection:0];
//                    Moment * moment = self.momentList[indexpath.row];
//                    moment.attstatus = [NSString stringWithFormat:@"%@",codeStr];
//                    [weakSelf.momentList replaceObjectAtIndex:indexpath.row withObject:moment];
//                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                    //[weakSelf changAttatitionDataMoment:moment andShowType:self.showType];
                }else{
                    //删除评论
                    //知道当前评论的内容和当前是那个cell
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"sc"];
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


#pragma mark 获取特定的朋友圈
- (void)loadFriendDetailOneNewData:(RSShopCircleCell *)cell andType:(NSString *)type{
//    self.isRefresh = true;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:true] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:@"" forKey:@"showType"];
    [phoneDict setObject:self.selectStr forKey:@"friendType"];
    [phoneDict setObject:cell.moment.friendId forKey:@"friendId"];
    NSString * str = nil;
    if ([UserManger getUserObject].userID == nil) {
        str = @"-1";
        // self.userModel.userID = [NSString stringWithFormat:@"%@",str];
    }else{
        str = [UserManger getUserObject].userID;
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
//            CLog(@"=-==============2323================%@",json);
//            CLog(@"=-==============2323================%@",json[@"MSG_CODE"]);
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int j = 0; j < array.count; j++) {
                    
                    Moment * moment = [Moment mj_objectWithKeyValues:[array objectAtIndex:j]];
                    moment.index = j;
                    moment.commentList = [Comment mj_objectArrayWithKeyValuesArray:[[array objectAtIndex:j]objectForKey:@"comment"]];
                    moment.likeList = [RSLike mj_keyValuesArrayWithObjectArray:[[array objectAtIndex:j]objectForKey:@"likeList"]];
                    if ([type isEqualToString:@"gz"] || [type isEqualToString:@"pl"]||[type isEqualToString:@"sc"]) {
                        [weakSelf.momentList replaceObjectAtIndex:_cell.tag withObject:moment];
                    }
                    
                    //这边还是要进行变化的
//                    if ([type isEqualToString:@"pl"] || [type isEqualToString:@"sc"]) {
//                        cell.moment.commentList = moment.commentList;
//                    }else if ([type isEqualToString:@"dz"]){
//                        cell.moment.likenum = moment.likenum;
//                        cell.moment.likestatus = moment.likestatus;
//                        cell.moment.likeList = moment.likeList;
//                    }else if ([type isEqualToString:@"gz"]){
//                    }
                    
                    
                    /**
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
                      [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                      [UIView setAnimationsEnabled:YES];
                     
                     
                     */
                    
                    if ([type isEqualToString:@"gz"]){
                        if ([weakSelf.delegate respondsToSelector:@selector(changAttatitionDataMoment:andSelectStr:)]) {
                            [weakSelf.delegate changAttatitionDataMoment:moment andSelectStr:weakSelf.selectStr];
                        }
                        for (int j = 0; j < weakSelf.momentList.count; j++) {
                            Moment * moment1 = weakSelf.momentList[j];
                            if ([moment.HZName isEqualToString:moment1.HZName]) {
                                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:j inSection:0];
                                moment1.attstatus = moment.attstatus;
                                [weakSelf.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                            }
                        }
                    }
                    
                    if ([type isEqualToString:@"dz"]) {
                        cell.moment.likenum = moment.likenum;
                        cell.moment.likestatus = moment.likestatus;
                        cell.moment.likeList = moment.likeList;
                    }
                    //代理
                    [UIView setAnimationsEnabled:NO];
//                    if (@available(iOS 11.0, *)) {
//                        [weakSelf.tableview performBatchUpdates:^{
//                            [weakSelf.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                        } completion:^(BOOL finished) {
//                            [UIView setAnimationsEnabled:YES];
//                        }];
//                      }
//                    }else if ([type isEqualToString:@"gz"] || [type isEqualToString:@"pl"] || [type isEqualToString:@"sc"]){
//                        [UIView setAnimationsEnabled:NO];
                        [weakSelf.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                        if ([type isEqualToString:@"pl"] || [type isEqualToString:@"sc"]) {
                            [weakSelf.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_cell.tag inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                        }
                        [UIView setAnimationsEnabled:YES];
//                    }
                }
            }
        }
    }];
}


#pragma mark -- deleteOneFriend
- (void)deleteOneFriend{
    [self loadNewDataWithPageSize:10 andIsHead:true];
}

#pragma mark -- 通知refreshFriendStatus
//- (void)refreshFriendStatus:(NSNotification *)notification{
//    Moment * moment = notification.userInfo[@"moment"];
//    NSString * type = notification.userInfo[@"Type"];
//    if ([type isEqualToString:@"gz"]) {
//        if ([self.delegate respondsToSelector:@selector(changAttatitionDataMoment:andSelectStr:)]) {
//            [self.delegate changAttatitionDataMoment:moment andSelectStr:self.selectStr];
//        }
//    }else{
//        for (int i = 0; i < self.momentList.count; i++) {
//            Moment * moment1 = self.momentList[i];
//            if ([moment.friendId isEqualToString:moment1.friendId]) {
//                [UIView setAnimationsEnabled:NO];
//                [self.momentList replaceObjectAtIndex:i withObject:moment];
//                [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                [UIView setAnimationsEnabled:YES];
//                break;
//            }
//        }
//    }
//}




#pragma mark 分享
- (void)didShopCircleShareMoment:(RSShopCircleCell *)cell{
    CLog(@"分享");
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

#pragma mark 全选和收取
- (void)didShopCircleSelectFullText:(RSShopCircleCell *)cell{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
    CLog(@"全选和收取");
    NSIndexPath * indexpath = [self.tableview indexPathForCell:cell];
    [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}



//FIXME:点击视频的地方
- (void)didCurrentCellVideoUrl:(Moment *)moment{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
    [RSJumpPlayVideoTool canYouSkipThePlaybackVideoInterfaceMoment:moment andViewController:self];
}

- (void)didCurrentShowImageView{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
}


// 点击用户头像
- (void)didClickProfile:(RSShopCircleCell *)cell{
    
    [UserManger checkLogin:self successBlock:^{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
        if ([cell.moment.userType isEqualToString:@"hxhz"]) {
            
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
            
        }else{
            
            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
            myRingVc.erpCodeStr = cell.moment.erpCode ;
            myRingVc.userIDStr = cell.moment.userid;
            myRingVc.userType = cell.moment.userType;
            myRingVc.creat_userIDStr = cell.moment.create_user;
            myRingVc.userModel = [UserManger getUserObject];
            [self.navigationController pushViewController:myRingVc animated:YES];
        }
        
    }];
}

//点击用户名称
- (void)didClickName:(RSShopCircleCell *)cell{
    
    [UserManger checkLogin:self successBlock:^{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
        if ([cell.moment.userType isEqualToString:@"hxhz"]) {
            
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
          
        }else{
            
            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
            myRingVc.erpCodeStr = cell.moment.erpCode;
            myRingVc.userIDStr = cell.moment.userid;
            myRingVc.userType = cell.moment.userType;
            myRingVc.creat_userIDStr = cell.moment.create_user;
            myRingVc.userModel = [UserManger getUserObject];
            [self.navigationController pushViewController:myRingVc animated:YES];
        }
        
    }];
}

#pragma mark 点赞
- (void)didShopCircleLikeMoment:(RSShopCircleCell *)cell{
    CLog(@"点赞");
    [UserManger checkLogin:self successBlock:^{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
        //cell.goodBtn.selected = !cell.goodBtn.selected;
//        if (cell.goodBtn.selected) {
//
//            [cell.goodBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353D40"]];
//            [cell.goodBtn setImage:[UIImage imageNamed:@"Path1"] forState:UIControlStateNormal];
//            [cell.goodBtn setTitle:@"取消" forState:UIControlStateNormal];
//
//        }else{
//
////            cell.goodBtn.backgroundColor = [UIColor clearColor];
//            [cell.goodBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
//            [cell.goodBtn setTitle:@"点赞" forState:UIControlStateNormal];
//        }
        _cell = cell;
        [self obtailComment:@"" andType:@"dz" andUserID:[UserManger getUserObject].userID andMoment:_cell.moment.friendId andCommentMod:1 andcommentUserId:[UserManger getUserObject].userID andCommentId:@""];
        
    }];
}

#pragma mark 评论
- (void)didShopCircleAddComment:(RSShopCircleCell *)cell{
//    CLog(@"-----------------------------------评论");
    [UserManger checkLogin:self successBlock:^{
        self.cmtView.inputView.text = @"";
        self.selectType = @"1";
         [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
        _cell = cell;
        self.cmtView.inputView.zw_placeHolder = @"回复";
        _cell.imageListView.userInteractionEnabled = NO;
        [self.cmtView.inputView becomeFirstResponder];
    }];
}


#pragma mark 选择评论
- (void)didShopCircleSelectComment:(Comment *)comment andMomentCell:(RSShopCircleCell *)cell{
    CLog(@"选择评论");
    [UserManger checkLogin:self successBlock:^{
        self.cmtView.inputView.text = @"";
        self.selectType = @"1";
    //     [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
        _cell = cell;
        _currentComment = comment;
        self.cmtView.inputView.zw_placeHolder = @"回复";
    //    [self.cmtView.inputView becomeFirstResponder];
         _cell.imageListView.userInteractionEnabled = YES;
        if ([_currentComment.commentName isEqualToString:[UserManger getUserObject].userName]) {
            //这边是做的
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除评论" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
                 [self obtailComment:@"" andType:@"sc" andUserID:[UserManger getUserObject].userID andMoment:_cell.moment.friendId andCommentMod:0 andcommentUserId: _currentComment.relUserId andCommentId: _currentComment.commentId];
            }];
        }else{
            self.selectType = @"2";
    //        cell.menuView.show = NO;
            [self.cmtView.inputView becomeFirstResponder];
            _cell.imageListView.userInteractionEnabled = NO;
            [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
            self.cmtView.inputView.zw_placeHolder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
        }
    }];
}

#pragma mark 关注
- (void)didShopCircleAttentionMoment:(RSShopCircleCell *)cell{
    //刷新单条数据
    [UserManger checkLogin:self successBlock:^{
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        [self.cmtView.inputView resignFirstResponder];
        //这边是关注要做的事情
        NSIndexPath * indexpath = [self.tableview indexPathForCell:cell];
        Moment * moment = self.momentList[indexpath.row];
        _cell = cell;
        RSWeakself
        if ( [_cell.attentionBtn.currentTitle isEqualToString:@"已关注"]) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
                [weakSelf obtailComment:@"" andType:@"gz" andUserID:[UserManger getUserObject].userID andMoment:moment.friendId andCommentMod:1 andcommentUserId:[UserManger getUserObject].userID andCommentId:@""];
            }];
        }else{
            [weakSelf obtailComment:@"" andType:@"gz" andUserID:[UserManger getUserObject].userID andMoment:moment.friendId andCommentMod:0 andcommentUserId:[UserManger getUserObject].userID andCommentId:@""];
        }
    }];
}


#pragma mark 点击高亮文字
- (void)didShopCircleClickLink:(MLLink *)link linkText:(NSString *)linkText andCell:(RSShopCircleCell *)cell{
    CLog(@"点击高亮文字");
    /**
     MLLinkTypeNone          = 0,
     MLLinkTypeURL           = 1,          // 链接
     MLLinkTypePhoneNumber   = 2,          // 电话
     MLLinkTypeEmail         = 3,          // 邮箱
     MLLinkTypeUserHandle    = 4,          //@
     MLLinkTypeHashtag       = 5,          //#..
     
     MLLinkTypeOther        = 30,          //这个一般是和MLDataDetectorTypeAttributedLink对应的，但是也可以自己随意添加啦，不过是一个标识而已，至于为什么30，随便定的，预留上面空间以添加新的个性化
     */
    _cell = cell;
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
    }
}

#pragma mark 点击评论高亮内容
- (void)didShopCircleClickLink:(MLLink *)link linkText:(NSString *)linkText andComment:(Comment *)comment andCell:(RSShopCircleCell *)cell{
    CLog(@"点击评论高亮内容");
    /**
     MLLinkTypeNone          = 0,
     MLLinkTypeURL           = 1,          // 链接
     MLLinkTypePhoneNumber   = 2,          // 电话
     MLLinkTypeEmail         = 3,          // 邮箱
     MLLinkTypeUserHandle    = 4,          //@
     MLLinkTypeHashtag       = 5,          //#..
     MLLinkTypeOther        = 30,          //这个一般是和MLDataDetectorTypeAttributedLink对应的，但是也可以自己随意添加啦，不过是一个标识而已，至于为什么30，随便定的，预留上面空间以添加新的个性化
     */
    _cell = cell;
    _currentComment = comment;
    
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
                
                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:@"" andCreat_userIDStr:_currentComment.commentUserId andUserIDStr:_currentComment.commentUserId];
                [self.navigationController pushViewController:cargoCenterVc animated:YES];
                
            }else{
                
                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
                myRingVc.erpCodeStr = @"";
                myRingVc.userIDStr = _currentComment.commentUserId;
                //新添加一个是游客还是货主
                myRingVc.userType = _currentComment.commentUserType;
                myRingVc.creat_userIDStr = _currentComment.commentUserId;
                myRingVc.userModel = [UserManger getUserObject];
                [self.navigationController pushViewController:myRingVc animated:YES];
                
            }
            return;
        }
        
        if ([_currentComment.relUser isEqualToString:linkText]) {
            if ([_currentComment.relUserType isEqualToString:@"hxhz"]) {
                
                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:@"" andCreat_userIDStr:_currentComment.relUserId andUserIDStr:_currentComment.relUserId];
                [self.navigationController pushViewController:cargoCenterVc animated:YES];
                
            }else{
                
                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
                myRingVc.erpCodeStr = @"";
                myRingVc.userIDStr = _currentComment.relUserId;
                //新添加一个是游客还是货主
                myRingVc.userType = _currentComment.relUserType;
                myRingVc.creat_userIDStr = _currentComment.relUserId;
                myRingVc.userModel = [UserManger getUserObject];
                [self.navigationController pushViewController:myRingVc animated:YES];
            }
            return;
        }
    }
}


#pragma mark UITextViewDelegate
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
                str = [UserManger getUserObject].userID;
            }else{
                str = _currentComment.commentUserId;
            }
            [self obtailComment:self.cmtView.inputView.text andType:@"pl" andUserID:[UserManger getUserObject].userID andMoment:_cell.moment.friendId andCommentMod:[self.selectType intValue] andcommentUserId:str andCommentId:@""];
            
        }
        //在这里做你响应return键的代码
        [self.cmtView.inputView resignFirstResponder];
        self.cmtView.inputView.text = @"";
        self.cmtView.inputView.zw_placeHolder = @"回复";
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
//    CLog(@"=======================================================================================================1");
    _cell.imageListView.userInteractionEnabled = YES;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    [self setEditing:YES];
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
            self.cmtView.frame = CGRectMake(0, SCH - offset - Height_Real(130), SCW, Height_Real(50));
        }];
//        [self.tableview scrollToRowAtIndexPath:self.selectIndexpath atScrollPosition:UITableViewScrollPositionBottom animated:false];
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
        self.cmtView.frame = CGRectMake(0, SCH , SCW, Height_Real(50));
    }];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}




@end
