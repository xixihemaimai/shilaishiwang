//
//  RSFriendDetailController.m
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFriendDetailController.h"
#import "UIImageView+WebCache.h"

//#import <WXApi.h>
#import "WXApi.h"
#import "RSGetPhoneNumberTool.h"
#import "RSMyRingViewController.h"
#import "RSWeChatShareTool.h"
#import "RSFriendModel.h"
#import "RSCargoCenterBusinessViewController.h"
#import "RSVideoScreenViewController.h"
#import "MomentCell.h"
#import "RSLeftViewController.h"
#import "Moment.h"
#import "CommentView.h"

//UITableViewDelegate,UITableViewDataSource,
//MomentCellDelegate
#import "RSShopCircleCell.h"

@interface RSFriendDetailController ()<RSShopCircleCellDelegate,UITextViewDelegate>

//@property (nonatomic,assign)BOOL isRefresh;


//@property (nonatomic,strong)UITableView * tableview;



/**选择你要评论的选择的类型*/
@property (nonatomic,strong)NSString * selectType;



//@property (nonatomic,strong)UITextField * textfield;

@property (nonatomic,strong)Comment * currentComment;

//@property (nonatomic,strong)MomentCell * cell;


@property (nonatomic,strong)RSShopCircleCell * cell;

@property (nonatomic,strong)Moment * moment;


@property(nonatomic,strong)CommentView *cmtView;

@end

@implementation RSFriendDetailController

-(CommentView *)cmtView
{
    if (!_cmtView){
        _cmtView = [[CommentView alloc]initWithFrame:CGRectMake(0, SCH, SCW, 50)];
        _cmtView.inputView.delegate = self;
        _cmtView.inputView.zw_placeHolder = @"回复";
    }
    return _cmtView;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    //self.tabBarController.tabBar.hidden = YES;
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    _tempStr = @"1";
    [self loadFriendDetailNewData];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[RSShopCircleCell class] forCellReuseIdentifier:@"frienddetaildd"];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.selectType = @"0";
    //self.type = @"0";
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    //添加自定义导航栏
    [self addCustomNavigation];
    
    [self.view addSubview:self.cmtView];
}




- (void)addCustomNavigation{
    UIButton * deletBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [deletBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deletBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:deletBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [deletBtn addTarget:self action:@selector(deletBtnFriendViewController:) forControlEvents:UIControlEventTouchUpInside];
    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
            if ([self.moment.HZName isEqualToString:[UserManger getUserObject].userName]) {
                deletBtn.hidden = NO;
                deletBtn.enabled = YES;
            }else{
                deletBtn.hidden = NO;
                deletBtn.enabled = YES;
            }
        
    }else{
        deletBtn.hidden = YES;
        deletBtn.enabled = NO;
    }
}
//
#pragma mark -- 删除朋友圈
- (void)deletBtnFriendViewController:(UIButton *)btn{
    RSWeakself
    [JHSysAlertUtil presentAlertViewWithTitle:@"你确定要删除该朋友圈吗" message:@"你是否需要删除" cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
            
    } confirm:^{
            //随便的
           [weakSelf deleteSelfFriendDeatilData];
    }];
}



#pragma mark -- 添加自定义tableview
- (void)addCustomFriendDetailTableview{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    self.tableview  = tableview;
//    //self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.estimatedRowHeight = 0;
//    self.tableview.estimatedSectionHeaderHeight = 0;
//    self.tableview.estimatedSectionFooterHeight = 0;
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableview];
//
    [self addcommentContent];
}


#pragma mark -- 评论
- (void)addcommentContent{

    
    //textfield
//    UITextField * textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, SCH, SCW, 50)];
//    textfield.textColor = [UIColor blackColor];
//    //textfield.borderStyle = UITextBorderStyleRoundedRect;
//    textfield.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    textfield.placeholder = @"回复:";
//    textfield.returnKeyType = UIReturnKeySend;
////    [textfield becomeFirstResponder];
//    textfield.delegate = self;
//    [self.view addSubview:textfield];
//    [textfield bringSubviewToFront:self.view];
//    _textfield = textfield;
    
    [self.view addSubview:self.cmtView];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = self.moment.rowHeight;
    return rowHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * FRIENDDETAILDD = @"frienddetaildd";
//    MomentCell * cell = [tableView dequeueReusableCellWithIdentifier:FRIENDDETAILDD];
//    if (!cell) {
//        cell = [[MomentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FRIENDDETAILDD];
//    }
    RSShopCircleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"frienddetaildd"];
    cell.moment = self.moment;
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell = cell;
//    cell.moment = self.moment;
//    cell.delegate = self;
//    if ([[NSString stringWithFormat:@"%@",self.moment.attstatus] isEqualToString:@"0"]) {
//        [cell.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//        [cell.attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#4C618E"] forState:UIControlStateNormal];
//        [cell.attentionBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
//        cell.attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#4C618E"].CGColor;
//    }else{
//        [cell.attentionBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [cell.attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#B2B2B2"] forState:UIControlStateNormal];
//        [cell.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
//        cell.attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
//    }
//    [cell.attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    if ([[NSString stringWithFormat:@"%@",self.moment.likestatus] isEqualToString:@"0"]) {
//        //没有点赞
//        cell.menuView.likeBtn.selected = NO;
//        cell.menuView.likeBtn.backgroundColor = [UIColor clearColor];
//        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
//        [cell.menuView.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
//    }else{
//        //已经点赞
//        cell.menuView.likeBtn.selected = YES;
//        [cell.menuView.likeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353D40"]];
//        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path1"] forState:UIControlStateNormal];
//        [cell.menuView.likeBtn setTitle:@"取消" forState:UIControlStateNormal];
//    }
    return cell;
}


#pragma mark RSShopCircleCellDelegate

// 点赞
//- (void)didLikeMoment:(MomentCell *)cell{
//    _cell.imageListView.userInteractionEnabled = YES;
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
////    [self.textfield resignFirstResponder];
//    cell.menuView.likeBtn.selected = !cell.menuView.likeBtn.selected;
//    if (cell.menuView.likeBtn.selected) {
//        [cell.menuView.likeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353D40"]];
//        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path1"] forState:UIControlStateNormal];
//        [cell.menuView.likeBtn setTitle:@"取消" forState:UIControlStateNormal];
//    }else{
//        cell.menuView.likeBtn.backgroundColor = [UIColor clearColor];
//        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
//        [cell.menuView.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
//    }
//    _cell = cell;
//    //这边还是要网络请求
//     [self obtailComment:@"" andType:@"dz" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
//}


//新的评论
- (void)didShopCircleAddComment:(RSShopCircleCell *)cell{
    self.cmtView.inputView.text = @"";
    self.selectType = @"1";
    _cell = cell;
//    cell.menuView.show = NO;
    //self.textfield.placeholder = @"回复";
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    self.cmtView.inputView.zw_placeHolder = @"回复";
    _cell.imageListView.userInteractionEnabled = NO;
    //[self.textfield becomeFirstResponder];
    [self.cmtView.inputView becomeFirstResponder];
    
}


//新的评论评论
- (void)didShopCircleSelectComment:(Comment *)comment andMomentCell:(RSShopCircleCell *)cell{
    self.cmtView.inputView.text = @"";
    _cell.imageListView.userInteractionEnabled = YES;
    _currentComment = comment;
    _cell = cell;
    if ([_currentComment.commentName isEqualToString:self.userModel.userName]) {
        //这边是做的
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除评论" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
             [self obtailComment:@"" andType:@"sc" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:0 andcommentUserId:_currentComment.relUserId andCommentId:_currentComment.commentId];
        }];
    }else{
        self.selectType = @"2";
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
//        cell.menuView.show = NO;
          _cell.imageListView.userInteractionEnabled = NO;
        //[self.textfield becomeFirstResponder];
        [self.cmtView.inputView becomeFirstResponder];
        //self.textfield.placeholder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
        self.cmtView.inputView.zw_placeHolder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
    }
}

//新的点赞
- (void)didShopCircleLikeMoment:(RSShopCircleCell *)cell{
    
//    _cell.imageListView.userInteractionEnabled = YES;
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
    _cell = cell;
    //这边还是要网络请求
     [self obtailComment:@"" andType:@"dz" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
}

//新的分享
- (void)didShopCircleShareMoment:(RSShopCircleCell *)cell{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    self.textfield.text = @"";
//    self.textfield.placeholder = @"回复";
//     [self.textfield resignFirstResponder];
//     _cell.imageListView.userInteractionEnabled = YES;
//    cell.menuView.show = NO;
    Moment * moment = cell.moment;
    NSArray *shareButtonTitleArray = nil;
    NSArray *shareButtonImageNameArray = nil;
    shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
    shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andMoment:moment];
    [lxActivity showInView:self.view];
}

- (void)didClickOnImageIndex:(NSInteger *)imageIndex andMoment:(Moment *)moment{
    [RSWeChatShareTool weChatShareStyleImageIndex:imageIndex andMoment:moment];
}

// 评论
//- (void)didAddComment:(MomentCell *)cell{
//    //self.textfield.text = @"";
//    self.cmtView.inputView.text = @"";
//    self.selectType = @"1";
//    _cell = cell;
//    cell.menuView.show = NO;
//    //self.textfield.placeholder = @"回复";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    cell.imageListView.userInteractionEnabled = NO;
//    //[self.textfield becomeFirstResponder];
//    [self.cmtView.inputView becomeFirstResponder];
//    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
//}

//分享
//- (void)didShareMoment:(MomentCell *)cell{
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
////     [self.textfield resignFirstResponder];
//     _cell.imageListView.userInteractionEnabled = YES;
//    cell.menuView.show = NO;
//    Moment * moment = cell.moment;
//    NSArray *shareButtonTitleArray = nil;
//    NSArray *shareButtonImageNameArray = nil;
//    shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
//    shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
//    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andMoment:moment];
//    [lxActivity showInView:self.view];
//}


//新的查看全文和收取
- (void)didShopCircleSelectFullText:(RSShopCircleCell *)cell{
//    _cell.imageListView.userInteractionEnabled = YES;
  self.cmtView.inputView.text = @"";
  self.cmtView.inputView.zw_placeHolder = @"回复";
  [self.cmtView.inputView resignFirstResponder];
  NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
  [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




//新的点击图片
- (void)didCurrentShowImageView{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    _cell.imageListView.userInteractionEnabled = YES;
}

//点击视频的动作
- (void)didCurrentCellVideoUrl:(Moment *)moment{
//    _cell.imageListView.userInteractionEnabled = YES;
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
    [RSJumpPlayVideoTool canYouSkipThePlaybackVideoInterfaceMoment:moment andViewController:self];
}

//新的关注
- (void)didShopCircleAttentionMoment:(RSShopCircleCell *)cell{
//    _cell.imageListView.userInteractionEnabled = YES;
    RSWeakself
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
    if ( [cell.attentionBtn.currentTitle isEqualToString:@"已关注"]) {
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
            [weakSelf obtailComment:@"" andType:@"gz" andUserID:self.userModel.userID andMoment:self.moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
        }];
    }else{
        [self obtailComment:@"" andType:@"gz" andUserID:self.userModel.userID andMoment:self.moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
    }
}


- (void)didClickOnCancelButton
{
   // NSLog(@"didClickOnCancelButton");
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
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    _cell.imageListView.userInteractionEnabled = YES;
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
                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:_currentComment.commentUserId andUserIDStr:_currentComment.commentUserId];
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
                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:_currentComment.relUserId andUserIDStr:_currentComment.relUserId];
                [self.navigationController pushViewController:cargoCenterVc animated:YES];
            }else{
                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
                myRingVc.erpCodeStr = @"";
                myRingVc.userIDStr = _currentComment.relUserId;
                //新添加一个是游客还是货主
                myRingVc.userType = _currentComment.relUserType;
                myRingVc.creat_userIDStr = _currentComment.relUserId;
                myRingVc.userModel = self.userModel;
                [self.navigationController pushViewController:myRingVc animated:YES];
            }
            return;
        }
    }
}

//新的点击用户名称
- (void)didClickName:(RSShopCircleCell *)cell{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    _cell.imageListView.userInteractionEnabled = YES;
        if ([cell.moment.userType isEqualToString:@"hxhz"]) {
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
        }else{
            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
            myRingVc.erpCodeStr = cell.moment.erpCode;
            myRingVc.userIDStr = cell.moment.userid;
            myRingVc.userType = cell.moment.userType;
            myRingVc.creat_userIDStr = cell.moment.create_user;
            myRingVc.userModel = self.userModel;
            [self.navigationController pushViewController:myRingVc animated:YES];
    }
}

//新的用户头像
- (void)didClickProfile:(RSShopCircleCell *)cell{
//    _cell.imageListView.userInteractionEnabled = YES;
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
    if ([cell.moment.userType isEqualToString:@"hxhz"]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = cell.moment.erpCode ;
        myRingVc.userIDStr = cell.moment.userid;
        myRingVc.userType = cell.moment.userType;
        myRingVc.creat_userIDStr = cell.moment.create_user;
        myRingVc.userModel = self.userModel;
        [self.navigationController pushViewController:myRingVc animated:YES];
    }
    
}



// 点击用户头像
//- (void)didClickProfile:(MomentCell *)cell
//{
//    _cell.imageListView.userInteractionEnabled = YES;
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
////    [self.textfield resignFirstResponder];
//        if ([cell.moment.userType isEqualToString:@"hxhz"]) {
//            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
//            [self.navigationController pushViewController:cargoCenterVc animated:YES];
//        }else{
//            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
//            myRingVc.erpCodeStr = cell.moment.erpCode ;
//            myRingVc.userIDStr = cell.moment.userid;
//            //新添加一个是游客还是货主
//            /**
//             myRingVc.userType = _currentComment.commentUserType;
//             myRingVc.creat_userIDStr = _currentComment.commentUserId
//             */
//            myRingVc.userType = cell.moment.userType;
//            myRingVc.creat_userIDStr = cell.moment.create_user;
//            myRingVc.userModel = self.userModel;
//            [self.navigationController pushViewController:myRingVc animated:YES];
//        }
//}

//点击用户名称
//- (void)didClickName:(MomentCell *)cell{
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
//    _cell.imageListView.userInteractionEnabled = YES;
////     [self.textfield resignFirstResponder];
//        if ([cell.moment.userType isEqualToString:@"hxhz"]) {
//            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
////            cargoCenterVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:cargoCenterVc animated:YES];
//        }else{
//            RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
//            myRingVc.erpCodeStr = cell.moment.erpCode;
//            myRingVc.userIDStr = cell.moment.userid;
//            //新添加一个是游客还是货主
//            /**
//             myRingVc.userType = _currentComment.commentUserType;
//             myRingVc.creat_userIDStr = _currentComment.commentUserId
//             */
//            myRingVc.userType = cell.moment.userType;
//            myRingVc.creat_userIDStr = cell.moment.create_user;
//            myRingVc.userModel = self.userModel;
////            myRingVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:myRingVc animated:YES];
//
//    }
//}

//点赞评论内容的
//- (void)didLikeContentTitleLike:(RSLike *)like{
//     _cell.imageListView.userInteractionEnabled = YES;
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
////     [self.textfield resignFirstResponder];
//    if ([like.USER_TYPE isEqualToString:@"hxhz"]) {
//        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:like.SYS_USER_ID andUserIDStr:like.SYS_USER_ID];
////        cargoCenterVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:cargoCenterVc animated:YES];
//    }else{
//        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
//        myRingVc.erpCodeStr = @"";
//        myRingVc.userIDStr = like.SYS_USER_ID;
//        //新添加一个是游客还是货主
//        myRingVc.userType = like.USER_TYPE;
//        myRingVc.creat_userIDStr = like.SYS_USER_ID;
//        myRingVc.userModel = self.userModel;
////        myRingVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:myRingVc animated:YES];
//    }
//}




// 查看全文/收起
//- (void)didSelectFullText:(MomentCell *)cell{
//      _cell.imageListView.userInteractionEnabled = YES;
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
////    [self.textfield resignFirstResponder];
//    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
//    [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//}

// 选择评论
//- (void)didSelectComment:(Comment *)comment andMomentCell:(MomentCell *)cell{
//    //self.textfield.text = @"";
//    self.cmtView.inputView.text = @"";
//      _cell.imageListView.userInteractionEnabled = YES;
//    _currentComment = comment;
//    _cell = cell;
//    if ([_currentComment.commentName isEqualToString:self.userModel.userName]) {
//        //这边是做的
//        [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除评论" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
//        } confirm:^{
//             [self obtailComment:@"" andType:@"sc" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:0 andcommentUserId:_currentComment.relUserId andCommentId:_currentComment.commentId];
//        }];
//
//
////        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除该评论" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
////        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////            // 取消
////
////        }]];
////        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
////
////            [self obtailComment:@"" andType:@"sc" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:0 andcommentUserId:_currentComment.relUserId andCommentId:_currentComment.commentId];
////        }]];
////        [self presentViewController:alert animated:YES completion:nil];
//    }else{
//        self.selectType = @"2";
//        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
//        cell.menuView.show = NO;
//          _cell.imageListView.userInteractionEnabled = NO;
//        //[self.textfield becomeFirstResponder];
//        [self.cmtView.inputView becomeFirstResponder];
//        //self.textfield.placeholder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
//        self.cmtView.inputView.zw_placeHolder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
//    }
//}




//- (void)didCurrentShowImageView{
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
//    _cell.imageListView.userInteractionEnabled = YES;
//    //[self.textfield resignFirstResponder];
//}


// 点击高亮文字
//- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText andComment:(Comment *)comment andCell:(MomentCell *)cell{
//    /**
//     MLLinkTypeNone          = 0,
//     MLLinkTypeURL           = 1,          // 链接
//     MLLinkTypePhoneNumber   = 2,          // 电话
//     MLLinkTypeEmail         = 3,          // 邮箱
//     MLLinkTypeUserHandle    = 4,          //@
//     MLLinkTypeHashtag       = 5,          //#..
//
//     MLLinkTypeOther        = 30,          //这个一般是和MLDataDetectorTypeAttributedLink对应的，但是也可以自己随意添加啦，不过是一个标识而已，至于为什么30，随便定的，预留上面空间以添加新的个性化
//     */
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
////     [self.textfield resignFirstResponder];
//      _cell.imageListView.userInteractionEnabled = YES;
//
//    _cell = cell;
//    _currentComment = comment;
//
//    if (link.linkType == 1) {
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:linkText]]) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
//        }
//    }else if (link.linkType == 2){
//        NSMutableString *  phoneMutableStr = [[NSMutableString alloc] initWithFormat:@"tel:%@",linkText];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneMutableStr]];
//    }else if (link.linkType == 3){
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:linkText]]) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
//        }
//    }else{
//        if ([_currentComment.commentName isEqualToString:linkText]) {
//
//            if ([_currentComment.commentUserType isEqualToString:@"hxhz"]) {
//                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:_currentComment.commentUserId andUserIDStr:_currentComment.commentUserId];
//                cargoCenterVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:cargoCenterVc animated:YES];
//            }else{
//                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
//                myRingVc.erpCodeStr = @"";
//                myRingVc.userIDStr = _currentComment.commentUserId;
//                //新添加一个是游客还是货主
//                myRingVc.userType = _currentComment.commentUserType;
//                myRingVc.creat_userIDStr = _currentComment.commentUserId;
//                myRingVc.userModel = [UserManger getUserObject];
//                myRingVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:myRingVc animated:YES];
//
//
//            }
//            return;
//        }
//        if ([_currentComment.relUser isEqualToString:linkText]) {
//            if ([_currentComment.relUserType isEqualToString:@"hxhz"]) {
//                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:_currentComment.relUserId andUserIDStr:_currentComment.relUserId];
////                cargoCenterVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:cargoCenterVc animated:YES];
//            }else{
//                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
//                myRingVc.erpCodeStr = @"";
//                myRingVc.userIDStr = _currentComment.relUserId;
//                //新添加一个是游客还是货主
//                myRingVc.userType = _currentComment.relUserType;
//                myRingVc.creat_userIDStr = _currentComment.relUserId;
//                myRingVc.userModel = self.userModel;
////                myRingVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:myRingVc animated:YES];
//            }
//            return;
//        }
//    }
//}




//关注
//- (void)attentionBtnAction:(UIButton *)attentionBtn{
//    //这边是关注要做的事情
//    //NSIndexPath * indexpath = [NSIndexPath indexPathForRow:attentionBtn.tag - 1000 inSection:0];
//    //Moment * moment = self.momentList[indexpath.row];
//
//
//   // _cell = (MomentCell *)[self.tableView cellForRowAtIndexPath:indexpath];
//    _cell.imageListView.userInteractionEnabled = YES;
//    RSWeakself
//    self.cmtView.inputView.text = @"";
//    self.cmtView.inputView.zw_placeHolder = @"回复";
//    [self.cmtView.inputView resignFirstResponder];
////    self.textfield.text = @"";
////    self.textfield.placeholder = @"回复";
////     [self.textfield resignFirstResponder];
//    if ( [attentionBtn.currentTitle isEqualToString:@"已关注"]) {
//        [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
//        } confirm:^{
//            [weakSelf obtailComment:@"" andType:@"gz" andUserID:self.userModel.userID andMoment:self.moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
//        }];
//    }else{
//        [self obtailComment:@"" andType:@"gz" andUserID:self.userModel.userID andMoment:self.moment.friendId andCommentMod:1 andcommentUserId:self.userModel.userID andCommentId:@""];
//    }
//}


#pragma mark -- 显示键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    //258
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
          //_textfield.frame  = CGRectMake(0.0f,SCH - offset  - 50, SCW, 50);
            self.cmtView.frame = CGRectMake(0, SCH - offset - 50, SCW, 50);
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
        //_textfield.frame = CGRectMake(0, SCH, SCW, 50);
        self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    }];
}

#pragma mark -- uitextviewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
        if ([temp length] < 1){
//            _cell.imageListView.userInteractionEnabled = YES;
            self.cmtView.inputView.text = @"";
            //[self.textfield resignFirstResponder];
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

- (void)textViewDidEndEditing:(UITextView *)textView{
//    CLog(@"=======================================================================================================1");
    _cell.imageListView.userInteractionEnabled = YES;
}


#pragma mark -- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    _cell.imageListView.userInteractionEnabled = YES;
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    [self.cmtView.inputView resignFirstResponder];
//    self.textfield.text = @"";
//    self.textfield.placeholder = @"回复";
//    [self.textfield resignFirstResponder];
//    NSIndexPath *indexPath =  [self.tableview indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
//    MomentCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
//    cell.menuView.show = NO;
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([string isEqualToString:@"\n"]) {
//        textField.text = @"";
//        textField.placeholder = @"回复";
//        [textField resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}


- (void)loadFriendDetailNewData{
//    self.isRefresh = true;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:true] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    //NSLog(@"---------------------%@",self.titleStyle);
    [phoneDict setObject:@"" forKey:@"showType"];
    [phoneDict setObject:self.selectStr forKey:@"friendType"];
    [phoneDict setObject:self.friendID forKey:@"friendId"];
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
//                   Moment *moment = [[Moment alloc]init];
//                   moment.index = j;
//                   moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
//                   moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
//                   moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
//                   moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
//                   moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
//                   moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
//                   moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
//                   moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
//                   moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
//                   moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
//                   moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
//                   moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
//                   moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
//                   moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
//                   moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
//                   moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
//                   moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
//                   moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
//                   moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
//                   moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
//                   moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
//                   moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
//                   moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
//                   moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
//                   moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
//                   moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
//                   moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
//                   moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
//                   moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
//                   moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
//                   moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
//                   moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
//                   moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
//                   moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
//                   NSMutableArray * tempArray = [NSMutableArray array];
//                   //评论
//                   tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
//                   for (int i = 0 ; i < tempArray.count; i++) {
//                       Comment * commen = [[Comment alloc]init];
//                       commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
//                       commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
//                       commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
//                       commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
//                       commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
//                       commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
//                       commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
//                       commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
//                       commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
//                       commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
//                       commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
//                       commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
//                       commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
//                       commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
//                       [moment.commentList addObject:commen];
//                   }
//                   NSMutableArray * likeArray = [NSMutableArray array];
//                   likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
//                   for (int n = 0; n < likeArray.count; n++) {
//                       RSLike * like = [[RSLike alloc]init];
//                       like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
//                       like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
//                       like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
//                       like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
//                       [moment.likeList addObject:like];
//                   }
                   Moment * moment = [Moment mj_objectWithKeyValues:[array objectAtIndex:j]];
                   moment.index = j;
                   moment.commentList = [Comment mj_objectArrayWithKeyValuesArray:[[array objectAtIndex:j]objectForKey:@"comment"]];
                   moment.likeList = [RSLike mj_keyValuesArrayWithObjectArray:[[array objectAtIndex:j]objectForKey:@"likeList"]];
                   weakSelf.moment = moment;
               }
//               [weakSelf.tableview.mj_header endRefreshing];
               [weakSelf.tableview reloadData];
//               [weakSelf addCustomFriendDetailTableview];
           }
        }
    }];
}



- (void)deleteSelfFriendDeatilData{
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.friendID forKey:@"friendId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DEL_FRIEND_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"delFriendData" object:nil];
                //RSMainTabBarViewController * mainVc = [[RSMainTabBarViewController alloc]init];
                //mainVc.selectedIndex = 0;
                //[UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
                //[[NSNotificationCenter defaultCenter]postNotificationName:@"delFriendData" object:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    }];
}


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
                    //点赞
//                    if (_cell.menuView.likeBtn.selected) {
//                        _cell.moment.isPraise = 1;
//                        NSString * status = json[@"Data"][@"status"];
//                        _cell.moment.likestatus = status;
//                        _cell.menuView.likeBtn.selected = YES;
//                        RSLike * like = [[RSLike alloc]init];
//                        like.SYS_USER_ID = _cell.moment.userid;
//                        like.USER_NAME = self.userModel.userName;
//                        like.USER_TYPE = self.userModel.userType;
//                        like.likeID = _cell.moment.userid;
//                        [_cell.moment.likeList addObject:like];
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
//                    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    [weakSelf loadFriendDetailCommentAndLikeNewData:friendId andType:@"dz"];
                }else if ([type isEqualToString:@"pl"]){
                    [weakSelf loadFriendDetailCommentAndLikeNewData:friendId andType:@"pl"];
//                     //评论
//                    Comment * currentComment = [[Comment alloc]init];
//                    currentComment.comment = [NSString stringWithFormat:@"%@",json[@"Data"][@"value"]];
//                    //这边是当前用户自己
//                    currentComment.relUser = self.userModel.userName;
//                    currentComment.relUserId = [NSString stringWithFormat:@"%@",json[@"Data"][@"beCommentedUserId"]];
//                    currentComment.commentUserId = [NSString stringWithFormat:@"%@",json[@"Data"][@"commentUserId"]];
//                    currentComment.commentId = [NSString stringWithFormat:@"%@",json[@"Data"][@"id"]];
//                    currentComment.commentUserType = self.userModel.userType;
//                    if ([self.selectType isEqualToString:@"1"]) {
//                        currentComment.commentmod = 1;
//                       // Moment * moment = self.moment;
//                        //当前用户自己
//                        currentComment.commentName = self.userModel.userName;
//                        currentComment.relUserType = self.userModel.userType;
//                        [self.moment.commentList addObject:currentComment];
//                      //  [self.moment replaceObjectAtIndex:0 withObject:moment];
//                        //[self.tableView reloadData];
//                        [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    }else if ([self.selectType isEqualToString:@"2"]){
//                        //Moment *moment = self.moment;
//                        if (_currentComment.commentmod == 2) {
//                            //别人评论之后和评论你在评论别人的东西
//                            currentComment.commentmod = 2;
//                            currentComment.relUserType = _currentComment.relUserType;
//                            //当前登录者
//                            currentComment.relUser = self.userModel.userName;
//                            currentComment.commentName = _currentComment.relUser;
//                            [self.moment.commentList addObject:currentComment];
//                           // [self.moment replaceObjectAtIndex:_cell.tag withObject:moment];
//                        }else{
//                            //直接评论
//                            currentComment.commentmod = 2;
//                            //当前登录者
//                            currentComment.relUser = self.userModel.userName;
//                            currentComment.commentName = _currentComment.commentName;
//                            [self.moment.commentList addObject:currentComment];
//                           // [self.moment replaceObjectAtIndex:0 withObject:moment];
//                        }
//                        [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    }

                }else if([type isEqualToString:@"gz"]){
                    //关注
                    [weakSelf loadFriendDetailCommentAndLikeNewData:friendId andType:@"gz"];
//                    NSString * attentionStr = json[@"Data"][@"status"];
//                    NSString * codeStr = [NSString stringWithFormat:@"%@",attentionStr];
//                    // BOOL OK = [codeStr isEqualToString:@"1"];
//                    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
//                     self.moment.attstatus = [NSString stringWithFormat:@"%@",codeStr];
//                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                }else{
                    //删除评论
                       [weakSelf loadFriendDetailCommentAndLikeNewData:friendId andType:@"sc"];
//                    for (int i = 0 ; i < _cell.moment.commentList.count; i++) {
//                        Comment * comment = _cell.moment.commentList[i];
//                        if ([comment.commentId isEqualToString:_currentComment.commentId]) {
//                            [_cell.moment.commentList removeObjectAtIndex:i];
//                            break;
//                        }
//                    }
//                    [weakSelf.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }
              // [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];
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

- (void)loadFriendDetailCommentAndLikeNewData:(NSString *)friendID andType:(NSString *)type{
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:true] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
//    if ([self.titleStyle isEqualToString:@"石圈"]) {
//        [phoneDict setObject:@"all" forKey:@"showType"];
//    }else if([self.titleStyle isEqualToString:@"关注"]){
//        [phoneDict setObject:@"attention" forKey:@"showType"];
//    }else{
    [phoneDict setObject:@"" forKey:@"showType"];
//    }
    [phoneDict setObject:self.selectStr forKey:@"friendType"];
    [phoneDict setObject:friendID forKey:@"friendId"];
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
            CLog(@"==============================%@",json);
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int j = 0; j < array.count; j++) {
                    Moment * moment = [Moment mj_objectWithKeyValues:[array objectAtIndex:j]];
                    moment.index = j;
                    moment.commentList = [Comment mj_objectArrayWithKeyValuesArray:[[array objectAtIndex:j]objectForKey:@"comment"]];
                    moment.likeList = [RSLike mj_keyValuesArrayWithObjectArray:[[array objectAtIndex:j]objectForKey:@"likeList"]];
                    weakSelf.moment = moment;
                    [UIView setAnimationsEnabled:NO];
                   [weakSelf.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    [UIView setAnimationsEnabled:YES];
                    
//                   NSDictionary *dict = @{@"moment": weakSelf.moment,@"Type":type};
//                   [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"refreshFriendStatus" object:nil userInfo:dict]];
                    
                    if ([weakSelf.delegate respondsToSelector:@selector(replaceMoment:andIndex:andType:)]) {
                        [weakSelf.delegate replaceMoment:weakSelf.moment andIndex:weakSelf.index andType:type];
                    }
                }
//                for (int j = 0; j < array.count; j++) {
//                    Moment *moment = [[Moment alloc]init];
//                    moment.index = j;
//                    moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
//                    moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
//                    moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
//                    moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
//                    moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
//                    moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
//                    moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
//                    moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
//                    moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
//                    moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
//                    moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
//                    moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
//                    moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
//                    moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
//                    moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
//                    moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
//                    moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
//                    moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
//                    moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
//                    moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
//                    moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
//                    moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
//                    moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
//                    moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
//                    moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
//                    moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
//                    moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
//                    moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
//                    moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
//                    moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
//                    moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
//                    moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
//                    moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
//                    moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
//                    NSMutableArray * tempArray = [NSMutableArray array];
//                    //评论
//                    tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
//                    for (int i = 0 ; i < tempArray.count; i++) {
//                        Comment * commen = [[Comment alloc]init];
//                        commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
//                        commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
//                        commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
//                        commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
//                        commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
//                        commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
//                        commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
//                        commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
//                        commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
//                        commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
//                        commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
//                        commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
//                        commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
//                        commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
//                        [moment.commentList addObject:commen];
//                    }
//                    NSMutableArray * likeArray = [NSMutableArray array];
//                    likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
//                    for (int n = 0; n < likeArray.count; n++) {
//                        RSLike * like = [[RSLike alloc]init];
//                        like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
//                        like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
//                        like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
//                        like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
//                        [moment.likeList addObject:like];
//                    }
//                    weakSelf.moment = moment;
//                     [UIView setAnimationsEnabled:NO];
//                    [weakSelf.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                     [UIView setAnimationsEnabled:YES];
//                    NSDictionary *dict = @{@"moment": weakSelf.moment,@"Type":type};
//                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"refreshFriendStatus" object:nil userInfo:dict]];
//                }
            }
        }
    }];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    temp = [self delSpaceAndNewline:temp];
//    if ([temp length] < 1){
//        self.textfield.text = @"";
//        [self.textfield resignFirstResponder];
//    }else{
//
//        self.textfield.text = temp;
//        //如果等于1那么传的是userId ,2 就是传commentUserId
//        NSString * str = [NSString string];
//        if ([self.selectType isEqualToString:@"1"]) {
//            str = self.userModel.userID;
//        }else{
//            str = _currentComment.commentUserId;
//        }
//        [self obtailComment:self.textfield.text andType:@"pl" andUserID:self.userModel.userID andMoment:_cell.moment.friendId andCommentMod:[self.selectType intValue] andcommentUserId:str andCommentId:@""];
//    }
//
//    textField.text = @"";
//    textField.placeholder = @"回复";
//    [textField resignFirstResponder];
//    return YES;
//}
//
//






- (BOOL)prefersHomeIndicatorAutoHidden {
    return NO;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
