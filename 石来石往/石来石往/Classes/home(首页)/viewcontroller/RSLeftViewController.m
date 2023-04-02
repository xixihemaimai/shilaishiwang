//
//  RSLeftView.m
//  石来石往
//
//  Created by mac on 17/5/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSLeftViewController.h"
#import "RSLoginDetialCell.h"

//我的收藏
#import "RSCollectViewController.h"
//注册的模型
#import "RSRegisterModel.h"

//我的登录
#import "RSMyLoginViewController.h"

//修改密码
#import "RSRePasswordViewController.h"

//修改企业信息
#import "RSCompayWebviewViewController.h"

//首页
#import "RSHomeViewController.h"

#import "RSSignOutButton.h"


#import "UIImageView+WebCache.h"


#import <MJExtension.h>

/**原生类，我的圈*/
#import "RSMyRingViewController.h"



#import "RSStockViewController.h"
#import "RSStonePictureMangerViewController.h"
#import "RSPermissionsViewController.h"
#import "RSPersonSettingViewController.h"
#import "RSAccessModel.h"



//关注和粉丝
#import "RSAttentionAndFansViewController.h"
 //服务中心
#import "RSServiceCentreVViewController.h"
//服务人员中心
#import "RSPersonalServiceViewController.h"


#import "RSAllHomeViewController.h"
#import "RSHSViewController.h"

#import "RSMessageCenterController.h"

#import "RSDispatchedPersonnelViewController.h"

#import "RSRightNavigationButton.h"

#import "RSAllMessageUIButton.h"

/**反馈服务中心*/
#import "RSFeedbackViewController.h"


#import "RSCargoCenterBusinessViewController.h"


#import "RSEngineeringCaseViewController.h"
#import "YCMenuView.h"



//淘宝专区后台
#import "RSTaoBaoCommodityManagementViewController.h"




@interface RSLeftViewController ()<RSPersonSettingViewControllerDelegate>
{
    /**退出登录*/
    RSSignOutButton * _signOutBtn;
}

//@property (nonatomic,strong)UItableView *tableView;



/**没有登录的情况下文字*/
//@property (nonatomic,strong)NSArray * noLoginTitleArr;
/**没有登录的情况下的图片*/
//@property (nonatomic,strong)NSArray * noLoginImageArr;

///**普通登录用户图片*/
//@property (nonatomic,strong)NSMutableArray *ordinaryloginImageArr;
///**普通登录用户的每个cell的内容*/
//@property (nonatomic,strong)NSMutableArray *ordinaryLoginTitleArr;
/**普通登录用户每个cell的详细内容*/
//@property (nonatomic,strong)NSArray *detailArr;
/**货主登录用户的每个cell的内容*/
@property (nonatomic,strong)NSMutableArray *moderatorloginTitleArr;

/**货主登录用户的图片*/
@property (nonatomic,strong)NSMutableArray *moderatorloginImageArr;


//@property (nonatomic,strong)UITableView * marketTableview;


@property (nonatomic,strong)RSAllMessageUIButton * selectMarketBtn;


@property (nonatomic,strong)UIView * headerview;


//@property (nonatomic,strong)NSArray * marketArray;


@end

@implementation RSLeftViewController

//SingerM(RSLeftViewController);

//这个是没有登录的时候
//- (NSArray *)noLoginTitleArr{
//    if (_noLoginTitleArr == nil) {
//        _noLoginTitleArr = @[@"我的收藏"];
//    }
//    return _noLoginTitleArr;
//}
//没有登录的时候显示的图片
//- (NSArray *)noLoginImageArr{
//    if (_noLoginImageArr == nil) {
//        _noLoginImageArr = @[@"石来石往图标设计_39",@"石来石往图标设计_65",@"石来石往图标设计_34"];
//    }
//    return _noLoginImageArr;
//}


//没有登录的时候的右边的显示的文字
//- (NSArray *)detailArr{
//    if (_detailArr == nil) {
//        _detailArr = @[@"",@"",@"400-0046056"];
//    }
//    return _detailArr;
//
//}

////普通用户登录图片
//- (NSArray *)ordinaryloginImageArr{
//    if (_ordinaryloginImageArr == nil) {
//      //  _ordinaryloginImageArr = @[@"石来石往图标设计_39",@"石来石往图标设计_34"];
//        _ordinaryloginImageArr =[NSMutableArray array];
//    }
//    return _ordinaryloginImageArr;
//}
//
//
//
////普通用户登录的文字
//- (NSArray *)ordinaryLoginTitleArr{
//    if (_ordinaryLoginTitleArr == nil) {
//       // _ordinaryLoginTitleArr = @[@"我的收藏",@"联系客服"];
//        _ordinaryLoginTitleArr = [NSMutableArray array];
//    }
//    return _ordinaryLoginTitleArr;
//
//}

//货主用户登录图片
- (NSMutableArray *)moderatorloginImageArr{
    if (_moderatorloginImageArr == nil) {
       // _moderatorloginImageArr = @[@"石来石往图标设计_44",@"石来石往图标设计_36",@"石来石往图标设计_39",@"石来石往图标设计_55",@"石来石往图标设计_42",@"石来石往图标设计_34"];
        _moderatorloginImageArr = [NSMutableArray array];
    }
    return _moderatorloginImageArr;
}

//货主用户登录的文字
- (NSMutableArray *)moderatorloginTitleArr{
    if (_moderatorloginTitleArr == nil) {
       // _moderatorloginTitleArr = @[@"业务办理",@"我的圈",@"我的收藏",@"石种图片上传",@"权限设置",@"联系客服"];
        _moderatorloginTitleArr = [NSMutableArray array];
    }
    return _moderatorloginTitleArr;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(attentAndFansNumberMessageCenter) name:@"attentAndFansNumberMessageCenter" object:nil];
    [self isAddjust];
}




- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    //这边要先获取到登录
    
//    if (![self respondsToSelector:@selector(getLoginNSNotificationCenter)]) {
//        //获取到登录的通知
//        [self getLoginNSNotificationCenter];
//    }else{
//        [self initUserInfo];
//    }
//
//
//
//    if (![self isKindOfClass:[RSAllHomeViewController class]]) {
//    self.isLogin = 1;
    
    //获取用户信息
//    self.userModel = [UserManger getUserObject];
    [self.moderatorloginImageArr removeAllObjects];
    [self.moderatorloginTitleArr removeAllObjects];
//    self.title = @"我的";
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//        CGFloat bottomH = 0.0;
//        if (iphonex) {
//            bottomH = 34;
//        }else{
//            bottomH = 0.0;
//        }
    
    //联系客服
//    RSRightNavigationButton * contactServiceBtn = [[RSRightNavigationButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    //[contactServiceBtn setTitle:@"" forState:UIControlStateNormal];
//    [contactServiceBtn setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
//    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:contactServiceBtn];
//    self.navigationItem.rightBarButtonItem = rightitem;
//    [contactServiceBtn addTarget:self action:@selector(contactCustomerServiceAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//
//    YCMenuAction *action = [YCMenuAction actionWithTitle:@"海西石材城" image:nil handler:^(YCMenuAction *action) {
//        self.selectMarketBtn.selected = NO;
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        applegate.ERPID = @"1";
//        [self.selectMarketBtn setTitle:@"海西" forState:UIControlStateNormal];
//        //这边到底是刷新全部的界面还是刷新前俩个界面的数据
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
//    }];
//    YCMenuAction *action1 = [YCMenuAction actionWithTitle:@"高时石材城" image:nil handler:^(YCMenuAction *action) {
//
//        self.selectMarketBtn.selected = NO;
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        applegate.ERPID = @"2";
//        [self.selectMarketBtn setTitle:@"高时" forState:UIControlStateNormal];
//        //这边到底是刷新全部的界面还是刷新前俩个界面的数据
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
//    }];
//    self.marketArray = @[action,action1];
//    //这边判断有没有登录过
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];

//    self.leftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
        
//    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, Height_Real(60), 0);
        
//    [self.view addSubview:self.leftTableview];
//    self.leftTableview.delegate = self;
//    self.leftTableview.dataSource = self;
    
    [self addTableviewHeaderAndFootView];
     RSWeakself
//    if ([UserManger isLogin]){
//        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf attitionAndFansNumber];
//        }];
//    }
 
    
//    if ([UserManger isLogin]) {
//        self.isLogin = false;
//        self.isOwner = true;
        
//        //下一版本需要用到
//        NSString * str1 = @"淘宝专区管理";
//        NSString * imageStr1 = @"石来石往图标设计_44";
//        [self.moderatorloginImageArr addObject:imageStr1];
//        [self.moderatorloginTitleArr addObject:str1];
        
        
//        if (self.userModel.appManage_ywbl == 1) {
//            NSString * str = @"业务办理";
//            NSString * imageStr = @"石来石往图标设计_44";
//            [self.moderatorloginImageArr addObject:imageStr];
//            [self.moderatorloginTitleArr addObject:str];
//        }
//
        
        
//        CLog(@"===========================%@",self.userModel.userType);
        
        if ([[UserManger getUserObject].userType isEqualToString:@"hxhz"] && [UserManger getUserObject].erpUserList.count > 0) {
            NSString * str = @"业务办理";
            NSString * imageStr = @"石来石往图标设计_44";
            [self.moderatorloginImageArr addObject:imageStr];
            [self.moderatorloginTitleArr addObject:str];
        }
        
        //这边要添加一个消息中心
        //if (weakSelf.userModel.access.appManage_grzx == 1) {
        NSString * str = @"消息中心";
        NSString * imageStr = @"消息中心";
        [self.moderatorloginImageArr addObject:imageStr];
        [self.moderatorloginTitleArr addObject:str];
        
        
        
        //这边添加一个服务中心
        if ([UserManger getUserObject].appManage_wdfw == 1) {
            if ([[UserManger getUserObject].userType isEqualToString:@"ckfw"] || [[UserManger getUserObject].userType isEqualToString:@"scfw"]) {
                NSString * str = @"服务中心";
                NSString * imageStr = @"服务中心";
                [self.moderatorloginImageArr addObject:imageStr];
                [self.moderatorloginTitleArr addObject:str];
            }
        }
        

        
        if ([UserManger getUserObject].appManage_fwfp == 1) {
            NSString * str = @"调遣中心";
            NSString * imageStr = @"调遣中心";
            [self.moderatorloginImageArr addObject:imageStr];
            [self.moderatorloginTitleArr addObject:str];
        }
        if ([UserManger getUserObject].appManage_sq == 1) {
            
            NSString * str = @"个人主页";
            NSString * imageStr = @"石来石往图标设计_36";
            [self.moderatorloginImageArr addObject:imageStr];
            [self.moderatorloginTitleArr addObject:str];
        }
        if ([UserManger getUserObject].appManage_sc == 1) {
            NSString * str = @"我的收藏";
            NSString * imageStr = @"石来石往图标设计_39";
            [self.moderatorloginImageArr addObject:imageStr];
            [self.moderatorloginTitleArr addObject:str];
        }
    
    
    [self.moderatorloginImageArr addObject:@"客服"];
    [self.moderatorloginTitleArr addObject:@"服务"];
        
//        if (self.userModel.appManage_tppp == 1) {
//            NSString * str = @"石种图片上传";
//            NSString * imageStr = @"石来石往图标设计_55";
//            [self.moderatorloginImageArr addObject:imageStr];
//            [self.moderatorloginTitleArr addObject:str];
//        }
//        if (self.userModel.appManage_gcal == 1) {
//            NSString * str = @"工程案例";
//            NSString * imageStr = @"工程案例";
//            [self.moderatorloginImageArr addObject:imageStr];
//            [self.moderatorloginTitleArr addObject:str];
//        }
//
//        if (self.userModel.appManage_qxgl == 1) {
//            NSString * str = @"权限管理";
//            NSString * imageStr = @"石来石往图标设计_42";
//            [self.moderatorloginImageArr addObject:imageStr];
//            [self.moderatorloginTitleArr addObject:str];
//        }
//
        
        [self.nameBtn setTitle:[UserManger getUserObject].userName forState:UIControlStateNormal];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,[UserManger getUserObject].userHead]] placeholderImage:[UIImage imageNamed:@"求真像"]];
        // _namePhone.text = [NSString stringWithFormat:@"%@",weakSelf.userModel.userPhone];
        [self.namePhone setTitle:[UserManger getUserObject].userPhone forState:UIControlStateNormal];
        self.namePhone.enabled = NO;
        [self.nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.nameBtn setTitle:[UserManger getUserObject].userName forState:UIControlStateNormal];
        self.nameBtn.enabled = NO;
//        self.signOutview.hidden = NO;
      
        [self attitionAndFansNumber];
        
        [self.tableview reloadData];
//     }
//    }else{
//        self.isOwner = false;
////        self.isLogin = true;
//        [self.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//        [user removeObjectForKey:@"oneUserModel"];
////        [user removeObjectForKey:@"VERIFYKEY"];
//        [user removeObjectForKey:@"USER_CODE"];
////        [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//        [user synchronize];
//        self.iconImage.image = [UIImage imageNamed:@"求真像"];
//        self.nameBtn.enabled = YES;
//        self.namePhone.enabled = YES;
//        [self.fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
//        [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//        [self.namePhone setTitle:@"" forState:UIControlStateNormal];
//        self.signOutview.hidden = YES;
//        [self.tableview reloadData];
//    }
}


//- (void)choiceMarketAction:(UIButton *)selectMarketBtn{
//    selectMarketBtn.selected = !selectMarketBtn.selected;
//
//    if (selectMarketBtn.selected == YES) {
//        self.marketTableview.hidden = NO;
//    }else{
//        self.marketTableview.hidden = YES;
//    }
//
//
//    YCMenuView *view = [YCMenuView menuWithActions:self.marketArray width:140 relyonView:selectMarketBtn];
//    view.maxDisplayCount = 2;
//
//    [view show];
//
//
//}



#pragma mark -- 关注和粉丝的数量的接口

- (void)attitionAndFansNumber{
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    
    if ([UserManger getUserObject].userID != nil && [UserManger Verifykey].length > 0) {
         //URL_ATTITIONANDFASNUMBER_IOS
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:[UserManger getUserObject].userID forKey:@"userId"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        __weak typeof(self) weakSelf = self;
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_ATTITIONANDFASNUMBER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    if ([self isKindOfClass:[RSLeftViewController class]]) {
                        //fansSize:粉丝数
                        //gzSize: 关注数
                        NSString * fansStr =   [NSString stringWithFormat:@"粉丝 %@",json[@"Data"][@"fansSize"]] ;
                        NSString  * attentionStr = [NSString stringWithFormat:@"关注 %@",json[@"Data"][@"gzSize"]];
                        [weakSelf.fansBtn setTitle:fansStr forState:UIControlStateNormal];
                        [weakSelf.attentionBtn setTitle:attentionStr forState:UIControlStateNormal];
                    }
                    [weakSelf.tableview.mj_header endRefreshing];
                }else{
                    [weakSelf.tableview.mj_header endRefreshing];
                }
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }];
    }
}


//联系客服
//- (void)contactCustomerServiceAction:(UIButton *)serviceBtn{
    
//    RSFeedbackViewController * feedBackVc = [[RSFeedbackViewController alloc]init];
//    feedBackVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:feedBackVc animated:YES];
    
//}


#pragma mark -- 重新刷新关注和粉丝的数量
- (void)attentAndFansNumberMessageCenter{
    [self.tableview.mj_header beginRefreshing];
}

- (void)extracted:(UIButton *)btn{
    [self jumpPersonSettingViewController:btn];
}

//- (void)extracted {
//    return @selector(jumpPersonSettingViewController:
//}

- (void)addTableviewHeaderAndFootView{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCW, 230)];
    headerview.userInteractionEnabled = YES;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
    self.tableview.tableHeaderView = headerview;
    //[self.tableView.tableHeaderView addSubview:headerview];
    _headerview = headerview;
    //self.leftTableview.scrollEnabled = NO;
    UIButton * topBtn = [[UIButton alloc]init];
    //topView.backgroundColor = [UIColor whiteColor];
    [topBtn setBackgroundImage:[UIImage imageNamed:@"个人中心背景图"] forState:UIControlStateNormal];
    [topBtn setBackgroundColor:[UIColor whiteColor]];
    [topBtn addTarget:self action:@selector(extracted:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:topBtn];
    _topBtn = topBtn;
    //_topBtn.enabled = NO;
    
    topBtn.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(headerview, 0)
    .heightIs(220);

    UIImageView *iconImage = [[UIImageView alloc]init];
    iconImage.image = [UIImage imageNamed:@"求真像"];
    [topBtn addSubview:iconImage];
    _iconImage = iconImage;
    
    iconImage.sd_layout
    .centerXEqualToView(topBtn)
    .widthIs(59)
    .topSpaceToView(topBtn, 61)
    .heightEqualToWidth();
    
    _iconImage.layer.cornerRadius = iconImage.yj_width * 0.5;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.contentMode =  UIViewContentModeScaleAspectFill;
    _iconImage.clipsToBounds = YES;
    
    UIButton *nameBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    nameBtn.titleLabel.numberOfLines = 0;
    [nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
    nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    nameBtn.titleLabel.textColor = [UIColor whiteColor];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:16];

    [nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//     [nameBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [topBtn addSubview:nameBtn];

    //[nameBtn sizeToFit];
   // nameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 180);
    _nameBtn = nameBtn;
//    nameLabel.userInteractionEnabled = YES;

    
    UIButton * namePhone = [UIButton buttonWithType:UIButtonTypeSystem];
    namePhone.titleLabel.font = [UIFont systemFontOfSize:14];
    namePhone.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [namePhone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    namePhone.titleLabel.textColor = [UIColor whiteColor];
    namePhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [namePhone addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [topBtn addSubview:namePhone];
    _namePhone = namePhone;

    
    UIView * attentionview = [[UIView alloc]init];
    attentionview.backgroundColor = [UIColor clearColor];
    [topBtn addSubview:attentionview];
    
    
    UIButton * attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    attentionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    attentionBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [attentionview addSubview:attentionBtn];
    [attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    _attentionBtn = attentionBtn;
    
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#3C4358"];
    [attentionview addSubview:midView];
    
    UIButton * fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fansBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
    fansBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    fansBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    fansBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [attentionview addSubview:fansBtn];
    [fansBtn addTarget:self action:@selector(fansAction:) forControlEvents:UIControlEventTouchUpInside];
    _fansBtn = fansBtn;

    
    namePhone.sd_layout
    .leftSpaceToView(topBtn, 12)
    .topSpaceToView(iconImage, 14)
    .rightSpaceToView(topBtn, 12)
    .heightIs(1);


    nameBtn.sd_layout
    .topSpaceToView(namePhone, 8)
    .leftSpaceToView(topBtn,10)
    .rightSpaceToView(topBtn,10)
    .heightIs(20);
    
    
    attentionview.sd_layout
    .leftSpaceToView(topBtn, 0)
    .rightSpaceToView(topBtn, 0)
    .bottomSpaceToView(topBtn, 15)
    .heightIs(25);
    
    
    attentionBtn.sd_layout
    .leftSpaceToView(attentionview, 0)
    .topSpaceToView(attentionview, 0)
    .bottomSpaceToView(attentionview, 0)
    .widthIs((SCW/2) - 1);
    
    
    midView.sd_layout
    .leftSpaceToView(attentionBtn, 0)
    .topEqualToView(attentionBtn)
    .bottomEqualToView(attentionBtn)
    .widthIs(1);
    
    
    fansBtn.sd_layout
    .leftSpaceToView(midView, 1)
    .rightSpaceToView(attentionview, 0)
    .topSpaceToView(attentionview, 0)
    .bottomSpaceToView(attentionview, 0);
    
    
    //底下退出登录的视图
    self.signOutview = [[UIView alloc]init];
    _signOutview.frame = CGRectMake(0, 0, SCW, 69);
    _signOutview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
   // [self.leftTableview addSubview:self.signOutview];
//    _signOutview.hidden = YES;
    
    //继承UIButton的，用来设置图片
    UIButton * signOutBtn = [[UIButton alloc]init];
    //_signOutBtn = signOutBtn;
    [signOutBtn setTitle:@"退出" forState:UIControlStateNormal];
    //[signOutBtn setImage:[UIImage imageNamed:@"退出1"] forState:UIControlStateNormal];
    
    signOutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [signOutBtn setBackgroundColor:[UIColor whiteColor]];
    [signOutBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [signOutBtn addTarget:self action:@selector(singOut) forControlEvents:UIControlEventTouchUpInside];
    // signOutBtn.imageEdgeInsets = UIEdgeInsetsMake(5,-5,5,10);
    [self.signOutview addSubview:signOutBtn];
    
    signOutBtn.sd_layout
    .rightSpaceToView(self.signOutview,0)
    .bottomSpaceToView(self.signOutview,10)
    .topSpaceToView(self.signOutview,10)
    .leftSpaceToView(self.signOutview, 0);
    self.tableview.tableFooterView = self.signOutview;
}

#pragma mark -- 关注的按键
- (void)attentionAction:(UIButton *)attentionBtn{
//    if (self.isLogin) {
//
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//         loginVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVc animated:YES];
//
//    }else{
        
        RSAttentionAndFansViewController * attentionVc = [[RSAttentionAndFansViewController alloc]init];
        attentionVc.title = @"关注";
//        attentionVc.hidesBottomBarWhenPushed = YES;
//        attentionVc.userModel = self.userModel;
        [self.navigationController pushViewController:attentionVc animated:YES];
        
//    }
}



#pragma mark -- 粉丝的按键
- (void)fansAction:(UIButton *)fansBtn{
//    self.marketTableview.hidden = YES;
    if (![UserManger isLogin]) {
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        loginVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVc animated:YES];
        
        
    }else{
        
        RSAttentionAndFansViewController * fansVc = [[RSAttentionAndFansViewController alloc]init];
        fansVc.title = @"粉丝";
//        fansVc.hidesBottomBarWhenPushed = YES;
//        fansVc.userModel = self.userModel;
        [self.navigationController pushViewController:fansVc animated:YES];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.moderatorloginTitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSLoginDetialCell * cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (!cell) {
        cell = [[RSLoginDetialCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"test"];
    }
    cell.cellImageview.image = [UIImage imageNamed:self.moderatorloginImageArr[indexPath.row]];
    cell.cellLabel.text = self.moderatorloginTitleArr[indexPath.row];
    cell.arrowImageview.image = [UIImage imageNamed:@"向右"];
    if (indexPath.row == self.moderatorloginTitleArr.count - 1) {
        //  cell.cellDetailLabel.text = [self.detailArr lastObject];
        cell.cellDetailLabel.textColor = [UIColor redColor];
        [cell.cellDetailLabel setSd_maxWidth:[NSNumber numberWithInteger:100]];
        cell.cellDetailLabel.sd_layout.leftSpaceToView(cell.cellLabel, 40);
        cell.cellDetailLabel.textAlignment = NSTextAlignmentLeft;
    }
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self jumpOtherViewControllerMethodNSIndexpath:indexPath];
}



//- (NSInteger)numberOfSectionsIntableView:(UITableView *)tableView{
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    CLog(@"=+++++++++++++++++++++++%ld",self.moderatorloginTitleArr.count);
//    if (tableView == self.leftTableview) {
//        if (self.isLogin) {
//            //判断没有登录
//            return self.noLoginTitleArr.count;
//        }else
//        {
            //if (self.isOwner)
            //判读是不是货主
//            return self.moderatorloginTitleArr.count;
//        }
//    }else{
//
//        return 2;
//    }
//
    
  
//    else if(self.isOrdinary){
//        //判断是普通登录
//        return self.ordinaryLoginTitleArr.count;
//    }
   // return 3;
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//   // if (tableView == self.leftTableview) {
//        RSLoginDetialCell *cell = [[RSLoginDetialCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
////        if (self.isLogin) {
////            //是不是没有登录
////            cell.cellImageview.image = [UIImage imageNamed:self.noLoginImageArr[indexPath.row]];
////            cell.cellLabel.text = self.noLoginTitleArr[indexPath.row];
////            cell.arrowImageview.image = [UIImage imageNamed:@"向右"];
////            if (indexPath.row <=3) {
////                //    cell.cellDetailLabel.text = self.detailArr[indexPath.row];
////
////                cell.cellDetailLabel.textColor = [UIColor redColor];
////                [cell.cellDetailLabel setSd_maxWidth:[NSNumber numberWithInteger:100]];
////                cell.cellDetailLabel.sd_layout
////                .leftSpaceToView(cell.cellLabel, 40);
////                cell.cellDetailLabel.textAlignment = NSTextAlignmentRight;
////            }
////            return cell;
////        }else
////        if (self.isOwner) {
//            cell.cellImageview.image = [UIImage imageNamed:self.moderatorloginImageArr[indexPath.row]];
//            cell.cellLabel.text = self.moderatorloginTitleArr[indexPath.row];
//            cell.arrowImageview.image = [UIImage imageNamed:@"向右"];
//            if (indexPath.row == self.moderatorloginTitleArr.count - 1) {
//              //  cell.cellDetailLabel.text = [self.detailArr lastObject];
//                cell.cellDetailLabel.textColor = [UIColor redColor];
//                [cell.cellDetailLabel setSd_maxWidth:[NSNumber numberWithInteger:100]];
//                cell.cellDetailLabel.sd_layout
//                .leftSpaceToView(cell.cellLabel, 40);
//                cell.cellDetailLabel.textAlignment = NSTextAlignmentLeft;
//            }
////            return cell;
////        }
//       return cell;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
//   // if (tableView == self.leftTableview) {
////        if (self.isLogin) {
////            //没有登录的情况下
////            //点击每个Cell显示要的界面
////            self.marketTableview.hidden = YES;
////            if (indexPath.row == 0) {
////                //self.hidesBottomBarWhenPushed = YES;
////                RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
////                loginVc.hidesBottomBarWhenPushed = YES;
////                [self.navigationController pushViewController:loginVc animated:YES];
////               // self.hidesBottomBarWhenPushed = NO;
////            }
////        }else if(self.isOwner){
//            [self jumpOtherViewControllerMethodNSIndexpath:indexPath];
////        }
//}


//这边是用来判断数组里面显示的是什么东西
- (void)jumpOtherViewControllerMethodNSIndexpath:(NSIndexPath *)indexpath{
    //这边要从数组里面去拿出数据来
    NSString * str = self.moderatorloginTitleArr[indexpath.row];
//    self.marketTableview.hidden = YES;/
    //这边就是要跳转到业务办理的页面
    if ([str isEqualToString:@"业务办理"]) {
        
        RSStockViewController * stockVc = [[RSStockViewController alloc]init];
//        stockVc.userID = [UserManger getUserObject].userID;
//        stockVc.ownerName = [UserManger getUserObject].userName;
//        stockVc.userModel = [UserManger getUserObject];
//        stockVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:stockVc animated:YES];
        
    }else if([str isEqualToString:@"消息中心"]){
        //跳转到消息中心的地方
        
        RSMessageCenterController * messagcenterVc = [[RSMessageCenterController alloc]init];
        messagcenterVc.usermodel = [UserManger getUserObject];
//        messagcenterVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messagcenterVc animated:YES];
        
    }
    else if ([str isEqualToString:@"服务中心"]){
       // if ([self.userModel.userType isEqualToString:@"ckfw"] || [self.userModel.userType isEqualToString:@"scfw"]) {

            RSPersonalServiceViewController * personalServiceVc = [[RSPersonalServiceViewController alloc]init];
            personalServiceVc.usermodel = [UserManger getUserObject];
//            personalServiceVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personalServiceVc animated:YES];

       // }else{

//            RSServiceCentreVViewController * serviceCentreVc = [[RSServiceCentreVViewController alloc]init];
//            serviceCentreVc.usermodel = self.userModel;
//            serviceCentreVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:serviceCentreVc animated:YES];

//        }
    }
    else if ([str isEqualToString:@"个人主页"]){
        if ([[UserManger getUserObject].userType isEqualToString:@"hxhz"]) {
            //这边就是要跳转到我的圈的页面
            
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:[UserManger getUserObject].curErpUserCode andCreat_userIDStr:[UserManger getUserObject].userID andUserIDStr:[UserManger getUserObject].userID];
//             cargoCenterVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
            
        }else{
            //这边就是要跳转到我的圈的页面
            
            RSMyRingViewController * myVc = [[RSMyRingViewController alloc]init];
            myVc.erpCodeStr =@"";
            myVc.userIDStr =[UserManger getUserObject].userID;
//             myVc.hidesBottomBarWhenPushed = YES;
          //  myVc.userType = self.userModel.userType;
            myVc.creat_userIDStr =[UserManger getUserObject].userID;
            myVc.userModel = [UserManger getUserObject];
            [self.navigationController pushViewController:myVc animated:YES];
        }
        
    }else if ([str isEqualToString:@"我的收藏"]){
        //这边就是要跳转到我的收藏的页面
        
        RSCollectViewController *collectVc = [[RSCollectViewController alloc]init];
        collectVc.userModel = [UserManger getUserObject];
//        collectVc.hidesBottomBarWhenPushed = YES;
        //[self presentViewController:collectVc animated:YES completion:nil];
        [self.navigationController pushViewController:collectVc animated:YES];
        
    }
//    else if ([str isEqualToString:@"石种图片上传"]){
//        //这边就要跳转到石种图片上传的页面
//
//        RSStonePictureMangerViewController * stoneVc = [[RSStonePictureMangerViewController alloc]init];
//        stoneVc.userModel =self.userModel;
//          stoneVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:stoneVc animated:YES];
//
//    }
    
//    else if ([str isEqualToString:@"权限管理"]){
//        //这边就是权限管理的页面
//
//        RSPermissionsViewController * permissionsVc = [[RSPermissionsViewController alloc]init];
//        permissionsVc.userModel = self.userModel;
//         permissionsVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:permissionsVc animated:YES];
//
//    }
    
//
//    else if ([str isEqualToString:@"联系客服"]){
//        //这边就要做联系客服的动作了
//        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-0046056"];
//        UIWebView *callWebview = [[UIWebView alloc] init];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//        [self.view addSubview:callWebview];
//    }
    
    else if ([str isEqualToString:@"调遣中心"]){
        
        RSDispatchedPersonnelViewController * dispatchedPersonlVc = [[RSDispatchedPersonnelViewController alloc]init];
        dispatchedPersonlVc.usermodel = [UserManger getUserObject];
//        dispatchedPersonlVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dispatchedPersonlVc animated:YES];
        
    }else if ([str isEqualToString:@"服务"]){
        
        RSFeedbackViewController * feedBackVc = [[RSFeedbackViewController alloc]init];
    //    feedBackVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedBackVc animated:YES];
        
    }
    
//    else if ([str isEqualToString:@"工程案例"]){
//
//
//
//        RSEngineeringCaseViewController * engineeringCaseVc = [[RSEngineeringCaseViewController alloc]init];
//        engineeringCaseVc.usermodel = self.userModel;
//        engineeringCaseVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:engineeringCaseVc animated:YES];
//
//    }

}

#pragma mark -- 点击登录跳转界面到登录界面
//- (void)clickLogin:(UIButton *)btn{
//    self.marketTableview.hidden = YES;
//    RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
////    [self.navigationController pushViewController:loginVc animated:YES];
//    RSMyNavigationViewController * navi3 = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
//    navi3.modalPresentationStyle = 0;
//    [self presentViewController:navi3 animated:YES completion:nil];
//}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 55;
//}

#pragma mark -- 退出登录
- (void)singOut{
    RSWeakself
    [JHSysAlertUtil presentAlertViewWithTitle:@"确定要退出登录？" message:nil cancelTitle:@"确定" defaultTitle:@"取消" distinct:YES cancel:^{
//        weakSelf.marketTableview.hidden = YES;
        
        
//        [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%@",[UserManger getUserObject].userID]];
//        [MiPushSDK getAllAccountAsync];
        
        
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        } seq:0];
        
        
        //确定对登录的数据进行清除
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy-MM-dd"];
//        NSString *dateTime=[formatter stringFromDate:[NSDate date]];
//        NSDate *date = [formatter dateFromString:dateTime];
//        [user setObject:date forKey:@"showAuthorization"];
        [UserManger logoOut];
        [user removeObjectForKey:@"VERIFYKEY"];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"SignOutLogin" object:nil];
//        [weakSelf.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//        _nameBtn.enabled = YES;
//        weakSelf.isLogin = true;
      //  weakSelf.isOrdinary = false;
        weakSelf.isOwner = false;
//        weakSelf.signOutview.hidden = YES;
//        weakSelf.namePhone.enabled = YES;
//        [weakSelf.namePhone setTitle:@"" forState:UIControlStateNormal];
//        weakSelf.userModel = nil;
       //  weakSelf.topBtn.enabled = NO;
//        weakSelf.iconImage.image = [UIImage imageNamed:@"求真像"];
//        [weakSelf.fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
//        [weakSelf.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//        [weakSelf.tableview reloadData];
        
        
//        RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        AppDelegate * app =(AppDelegate *) [UIApplication sharedApplication].delegate;
        RSMainTabBarViewController * mainTabbar =(RSMainTabBarViewController *)app.window.rootViewController;
        RSMyLoginViewController * pwmsUserVc = [[RSMyLoginViewController alloc]init];
        RSMyNavigationViewController * navi3 = [mainTabbar.viewControllers objectAtIndex:3];
        NSMutableArray * controllers = [NSMutableArray arrayWithArray:navi3.viewControllers];
        controllers[0] = pwmsUserVc;
        pwmsUserVc.tabBarItem.tag = 3;
        pwmsUserVc.tabBarItem.title = @"我的";
        pwmsUserVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
        UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
        UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        pwmsUserVc.tabBarItem.selectedImage = newImage3;
        [navi3 setViewControllers:controllers];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
        
    } confirm:^{
        //这边只是取消下
//        [SVProgressHUD showSuccessWithStatus:@"你取消退出账号"];
    }];
    
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要注销登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        //确定对登录的数据进行清除
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy-MM-dd"];
//        NSString *dateTime=[formatter stringFromDate:[NSDate date]];
//        NSDate *date = [formatter dateFromString:dateTime];
//        [user setObject:date forKey:@"showAuthorization"];
//
//        [user removeObjectForKey:@"oneUserModel"];
////        [user removeObjectForKey:@"USER_CODE"];
//        [user removeObjectForKey:@"VERIFYKEY"];
////        [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//        [user synchronize];
//
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"SignOutLogin" object:nil];
//
//        [weakSelf.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//
//        _nameBtn.enabled = YES;
//        weakSelf.isLogin = true;
//      //  weakSelf.isOrdinary = false;
//        weakSelf.isOwner = false;
//        weakSelf.signOutview.hidden = YES;
//        weakSelf.namePhone.enabled = YES;
//        [weakSelf.namePhone setTitle:@"" forState:UIControlStateNormal];
//        weakSelf.userModel = nil;
//       //  weakSelf.topBtn.enabled = NO;
//        weakSelf.iconImage.image = [UIImage imageNamed:@"求真像"];
//        [weakSelf.fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
//        [weakSelf.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//        [weakSelf.leftTableview reloadData];
//
//
//    }];
//    [alert addAction:action1];
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        //这边只是取消下
//        [SVProgressHUD showSuccessWithStatus:@"你取消了注销账号"];
//    }];
//    [alert addAction:action2];
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                           alert.modalPresentationStyle = UIModalPresentationFullScreen;
//                       }
//    [self presentViewController:alert animated:YES completion:nil];
}

- (void)jumpPersonSettingViewController:(UIButton *)btn{
//    self.marketTableview.hidden = YES;
    if (![UserManger isLogin]) {
       // self.hidesBottomBarWhenPushed = YES;
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        loginVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVc animated:YES];
       // self.hidesBottomBarWhenPushed = NO;
    }else{
        //self.hidesBottomBarWhenPushed = YES;
        RSPersonSettingViewController * personSettingVc = [[RSPersonSettingViewController alloc]init];
        personSettingVc.userModel = [UserManger getUserObject];
//        personSettingVc.hidesBottomBarWhenPushed = YES;
        personSettingVc.delegate = self;
        [self.navigationController pushViewController:personSettingVc animated:YES];
        //self.hidesBottomBarWhenPushed = NO;
    }
}


#pragma mark -- RSPersonSettingviewcontroller代理方法
- (void)reRefreshUserPicture:(NSString *)picutre{
     [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_IMAGEURL_PING_IOS,picutre]]];
     _iconImage.contentMode =  UIViewContentModeScaleAspectFill;
    _iconImage.clipsToBounds = YES;
    [UserManger getUserObject].userHead = picutre;
}

- (void)reRefreshUserNameType:(NSString *)btnType andName:(NSString *)reStr{
    if ([[UserManger getUserObject].userType isEqualToString:@"hxhz"] ) {
        //只会修改公司和职位
        if ([btnType isEqualToString:@"orgName"]) {
            [UserManger getUserObject].orgName = reStr;
        }else if ([btnType isEqualToString:@"remark"]){
            [UserManger getUserObject].inviteCode = reStr;
        }
    }else if([[UserManger getUserObject].userType isEqualToString:@"hxyk"]){
    //会修改昵称,电话号码，公司，职位
    
        if ([btnType isEqualToString:@"orgName"]) {
            [UserManger getUserObject].orgName = reStr;
        }else if ([btnType isEqualToString:@"remark"]){
            [UserManger getUserObject].inviteCode = reStr;
        }
//        else if ([btnType isEqualToString:@"mobilePhone"]){
//            [_namePhone setTitle:reStr forState:UIControlStateNormal];
//            self.userModel.userPhone = reStr;
//            
//        }
        else if ([btnType isEqualToString:@"userName"]){
            [_nameBtn setTitle:reStr forState:UIControlStateNormal];
            [UserManger getUserObject].userName = reStr;
        }
    }else{
        if ([btnType isEqualToString:@"userName"]) {
            [UserManger getUserObject].userName = reStr;
        }else if ([btnType isEqualToString:@"mobilePhone"]){
            [UserManger getUserObject].userPhone = reStr;
        }else if ([btnType isEqualToString:@"orgName"]) {
            [UserManger getUserObject].orgName = reStr;
        }else if ([btnType isEqualToString:@"remark"]){
            [UserManger getUserObject].inviteCode = reStr;
        }
    }
    [self.tableview reloadData];
}


//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isNewData" object:nil];
//}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
