//
//  RSTaoBaoShopViewController.m
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoShopViewController.h"
//淘宝首页，荒料，大板
#import "RSTaoBaoContentViewController.h"
//收藏
#import "RSTaobaoCollectionViewController.h"
//首页
#import "RSTaobaoDistrictViewController.h"
//申请店铺
#import "RSTaoBaoApplyShopViewController.h"
//管理店铺
#import "RSTaoBaoCommodityManagementViewController.h"

//模型
#import "RSTaoBaoShopInformationModel.h"


#import "RSLoginViewController.h"

@interface RSTaoBaoShopViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    
    UIView * _headerView;
    
    UITextField * _textfield;
    
    UIButton * _attentionBtn;
    
    BOOL _isFirst;
    
}
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;

/**标题视图*/
@property (nonatomic,strong)UIView * titleView;

/**内容的视图*/
@property (nonatomic,strong)UIScrollView *contentScrollView;

/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;


/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
@property (nonatomic,strong)RSTaoBaoTool * taobaoTool;

@property (nonatomic,strong)RSTaoBaoShopInformationModel * taobaoShopInformationmodel;



@end

@implementation RSTaoBaoShopViewController


- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length > 0) {
        [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    }
    
 
}

//- (void)getNotificationAction:(NSNotification *)notification{
//    NSDictionary * infoDic = [notification object];
//    // 这样就得到了我们在发送通知时候传入的字典了
//    if ([infoDic objectForKey:@"Type"]) {
//
//
//    }
//    [self loadNewData];
//}



- (void)updateSCStatus:(NSNotification *)notification{
    
     [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
}

- (void)updateSCData:(NSNotification *)notification{
    NSDictionary * infoDic = [notification object];
    NSString * str = [infoDic objectForKey:@"status"];
    if ([str isEqualToString:@"attention"]) {
       [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
       [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirst = NO;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    RSTaoBaoTool * taobaoTool = [[RSTaoBaoTool alloc]init];
    self.taobaoTool = taobaoTool;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSCStatus:) name:@"updateSCStatus" object:nil];
    
    
     //[[NSNotificationCenter defaultCenter]postNotificationName:@"updateSCData" object:dict];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSCData:) name:@"updateSCData" object:nil];
    
    
//    UISearchBar * search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCW/2 + 80, 35)];
//    search.placeholder = @"搜索本店";
//    search.
//    self.navigationItem.titleView = search;
//    [search setImage:[UIImage imageNamed:@""] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW/2 + 50, 35)];
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    searchView.layer.cornerRadius = 17;
    self.navigationItem.titleView = searchView;
    
    
    //uitextfield
    UITextField * textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, searchView.yj_width, searchView.yj_height)];
    textfield.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    textfield.placeholder = @"搜索本店内容";
    textfield.font = [UIFont systemFontOfSize:12];
    textfield.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    [searchView addSubview:textfield];
    textfield.delegate = self;
    textfield.layer.cornerRadius = 17;
    _textfield = textfield;
    
    
    UIImageView * leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 35)];
    leftImage.image = [UIImage imageNamed:@""];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.leftView = leftImage;
    
    
    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setTitle:@"..." forState:UIControlStateNormal];
    [menuBtn setTitleColor:[UIColor colorWithHexColorStr:@"#424545"] forState:UIControlStateNormal];
    menuBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:21];
    menuBtn.frame = CGRectMake(0, 0, 50, 50);
    menuBtn.titleLabel.sd_layout
    .centerXEqualToView(menuBtn)
    .topSpaceToView(menuBtn, -5);
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = item;
    [menuBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self reloadHeadShopInformationNewData];
    
    
   // [self setHeaderViewCustomView];
    
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        //添加标题view
//        [self addBLShowTitleView];
//
//        // 添加内容的scrollView
//        [self addBLShowContentScrollView];
//
//        // 添加所有的子控制器
//        [self addAllChildViewControllers];
//
//
//        // 默认点击下标为0的标题按钮
//        [self titleBtnClick:self.titleBtns[0]];
//    });
    


    
}



- (void)reloadHeadShopInformationNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.tsUserId] forKey:@"shopId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETTSUSERINFO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                RSTaoBaoShopInformationModel * taobaoShopInformationmodel = [[RSTaoBaoShopInformationModel alloc]init];
                taobaoShopInformationmodel.address = json[@"data"][@"address"];
                taobaoShopInformationmodel.collectionId =[json[@"data"][@"collectionId"] integerValue];
                taobaoShopInformationmodel.shopInformationID =[json[@"data"][@"id"] integerValue];
                taobaoShopInformationmodel.phone = json[@"data"][@"phone"];
                taobaoShopInformationmodel.shopLogo = json[@"data"][@"shopLogo"];
                taobaoShopInformationmodel.shopName = json[@"data"][@"shopName"];
                taobaoShopInformationmodel.userType = json[@"data"][@"userType"];
                taobaoShopInformationmodel.status =[json[@"data"][@"status"] integerValue];
                taobaoShopInformationmodel.area = json[@"data"][@"area"];
                taobaoShopInformationmodel.createTime = json[@"data"][@"createTime"];
                taobaoShopInformationmodel.identityId = json[@"data"][@"identityId"];
                taobaoShopInformationmodel.sysUserId = [json[@"data"][@"sysUserId"] integerValue];
                taobaoShopInformationmodel.updateTime = json[@"data"][@"updateTime"];
                taobaoShopInformationmodel.volume = json[@"data"][@"volume"];
                taobaoShopInformationmodel.weight = json[@"data"][@"weight"];
                weakSelf.taobaoShopInformationmodel = taobaoShopInformationmodel;
                [weakSelf setHeaderViewCustomView:taobaoShopInformationmodel];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}




//菜单
- (void)menuAction:(UIButton *)menuBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1) {
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        RSWeakself
        [self.taobaoTool showMenuContentType:@"商店" andOnView:menuBtn andViewController:self andBlock:^(RSTaobaoUserModel * _Nonnull taobaoUsermodel) {
            weakSelf.taobaoUsermodel = taobaoUsermodel;
        }];
    
    
    }
}


- (void)setHeaderViewCustomView:(RSTaoBaoShopInformationModel *)taobaoShopInformationmodel{
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, navHeight + navY, SCW, 80)];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    [self.view addSubview:headerView];
    _headerView = headerView;

    
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:taobaoShopInformationmodel.shopLogo] placeholderImage:[UIImage imageNamed:@"512"]];
   // [nameLabel setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000"]];
    //nameLabel.text = @"唐";
   // nameLabel.text = [NSString stringWithFormat:@"%@",[taobaoShopInformationmodel.shopName substringToIndex:1]];
    
    
    imageView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    //nameLabel.textAlignment = NSTextAlignmentCenter;
   // nameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
    [headerView addSubview:imageView];
    
    UILabel * nameDetailLabel = [[UILabel alloc]init];
   // [nameDetailLabel setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000"]];
    //nameDetailLabel.text = @"大唐石业";
    
    nameDetailLabel.text = [NSString stringWithFormat:@"%@",taobaoShopInformationmodel.shopName];
    nameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameDetailLabel.textAlignment = NSTextAlignmentLeft;
    nameDetailLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [headerView addSubview:nameDetailLabel];
    
    
    //地址
    UILabel * addressLabel = [[UILabel alloc]init];
    //addressLabel.text = @"南安市水头";
    addressLabel.text = [NSString stringWithFormat:@"%@",taobaoShopInformationmodel.address];
    addressLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:addressLabel];
    
    
    //荒料
    UILabel * blocKLabel = [[UILabel alloc]init];
    //blocKLabel.text = @"荒料：234m³";
    
    blocKLabel.text = [NSString stringWithFormat:@"荒料 %0.3lfm³",[taobaoShopInformationmodel.volume floatValue]];
    
    blocKLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
    blocKLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    blocKLabel.textAlignment = NSTextAlignmentCenter;
    blocKLabel.font = [UIFont systemFontOfSize:10];
    [headerView addSubview:blocKLabel];
    
    CGRect rect = [blocKLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    
    
    
    //重量
    UILabel * weightLabel = [[UILabel alloc]init];
       //slocKLabel.text = @"大板：234m²";
    weightLabel.text = [NSString stringWithFormat:@"%0.3lf吨",[taobaoShopInformationmodel.weight floatValue]];
       
    weightLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
    weightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    weightLabel.textAlignment = NSTextAlignmentCenter;
    weightLabel.font = [UIFont systemFontOfSize:10];
    [headerView addSubview:weightLabel];
       
    CGRect rect2 = [weightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];

    
    
    
    //大板
    UILabel * slocKLabel = [[UILabel alloc]init];
    //slocKLabel.text = @"大板：234m²";
    
     slocKLabel.text = [NSString stringWithFormat:@"大板 %0.3lfm²",[taobaoShopInformationmodel.area floatValue]];
    
    slocKLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
    slocKLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    slocKLabel.textAlignment = NSTextAlignmentCenter;
    slocKLabel.font = [UIFont systemFontOfSize:10];
    [headerView addSubview:slocKLabel];
    
    CGRect rect1 = [slocKLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    

   
    //关注
    UIButton * attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    
    if (taobaoShopInformationmodel.collectionId > 0) {
        //已经收藏了
        [attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        //[collectionBtn setImage:[UIImage imageNamed:@"nh-拷贝"] forState:UIControlStateNormal];
    }else{
        //没有收藏
        [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        //[collectionBtn setImage:[UIImage imageNamed:@"guanzhu商品复制"] forState:UIControlStateNormal];
    }
    [attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#F61E23"] forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:attentionBtn];
    _attentionBtn = attentionBtn;
    
    
    imageView.sd_layout
    .leftSpaceToView(headerView, 24)
    .topSpaceToView(headerView, 15)
    .bottomSpaceToView(headerView, 15)
    .widthIs(50)
    .heightEqualToWidth();
    
    imageView.layer.cornerRadius = 4;
    imageView.layer.masksToBounds = YES;
    
    
    nameDetailLabel.sd_layout
    .leftSpaceToView(imageView, 9)
    .topSpaceToView(headerView, 11)
    .widthRatioToView(headerView, 0.5)
    .heightIs(20);
    
    addressLabel.sd_layout
    .leftEqualToView(nameDetailLabel)
    .rightEqualToView(nameDetailLabel)
    .topSpaceToView(nameDetailLabel, 0)
    .heightIs(17);
    
    blocKLabel.sd_layout
    .leftEqualToView(addressLabel)
    .topSpaceToView(addressLabel, 3)
    .heightIs(16)
    .widthIs(rect.size.width + 5);
    blocKLabel.layer.cornerRadius = 8;
    blocKLabel.layer.masksToBounds = YES;
    
    weightLabel.sd_layout
       .leftSpaceToView(blocKLabel, 9)
       .topEqualToView(blocKLabel)
       .bottomEqualToView(blocKLabel)
       .widthIs(rect2.size.width + 5);
       weightLabel.layer.cornerRadius = 8;
       weightLabel.layer.masksToBounds = YES;
    
    
    slocKLabel.sd_layout
    .leftSpaceToView(weightLabel, 9)
    .topEqualToView(weightLabel)
    .bottomEqualToView(weightLabel)
    .widthIs(rect1.size.width + 5);
    slocKLabel.layer.cornerRadius = 8;
    slocKLabel.layer.masksToBounds = YES;
    
    
   
    
    
    attentionBtn.sd_layout
    .rightSpaceToView(headerView, 24)
    .topSpaceToView(headerView, 14)
    .widthIs(41)
    .heightIs(21);
    attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#F3191D"].CGColor;
    attentionBtn.layer.borderWidth = 0.5;
    attentionBtn.layer.cornerRadius = 12;
    
    
    
    
    
//      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //添加标题view
        [self addBLShowTitleView];
        // 添加内容的scrollView
        [self addBLShowContentScrollView];
        // 添加所有的子控制器
        [self addAllChildViewControllers];
        // 默认点击下标为0的标题按钮
        [self titleBtnClick:self.titleBtns[0]];
//      });
    
    
    
}

//关注
- (void)attentionAction:(UIButton *)attentionBtn{
     NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1) {
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
         
        if ([attentionBtn.currentTitle isEqualToString:@"关注"]) {
            //关注
            NSString * str = @"addCollection";
            
            [self updateCancelAndAttionStr:str];
            
        }else{
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消关注" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //取消关注
                NSString * str = @"cancelCollection";
                [self updateCancelAndAttionStr:str];
            }];
            [alertView addAction:alert];
            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert1];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                
                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alertView animated:YES completion:nil];
            
        }
    }
}



- (void)updateCancelAndAttionStr:(NSString *)str{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:str forKey:@"optType"];
    [phoneDict setObject:@"shop" forKey:@"type"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.taobaoShopInformationmodel.shopInformationID] forKey:@"collId"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.taobaoShopInformationmodel.collectionId] forKey:@"collectionId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_COLLECTIONOPT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                if ([_attentionBtn.currentTitle isEqualToString:@"关注"]) {
                    weakSelf.taobaoShopInformationmodel.collectionId = [json[@"data"] integerValue];
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    [dict setValue:@"attention" forKey:@"status"];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                    [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
                    [dict setValue:@"noattention" forKey:@"status"];
                }
                [dict setValue:@"shop" forKey:@"type"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updateSCData" object:dict];
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"操作失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"操作失败"];
        }
    }];
}








- (void)addBLShowTitleView{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCW/2, 38)];
    titleview.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    self.titleView = titleview;
    [self.view addSubview:titleview];
    // 添加所有的标题按钮
    [self addAllTitleBtns];
    
    // 添加下滑线
    [self setupUnderLineView];
}


- (void)addBLShowContentScrollView
{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    //self.contentScrollview.hidden = YES;
    //self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0,CGRectGetMaxY(self.titleView.frame) , SCW, SCH - CGRectGetMaxY(self.titleView.frame));
    [self.view addSubview:contentScrollView];
    // 设置scrollView
    // 设置分页效果
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    // 去掉弹簧效果
    contentScrollView.bounces = NO;
    // 设置代理
    contentScrollView.delegate = self;
    [contentScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

- (void)setupUnderLineView
{
    // 获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    // 下滑线高度
    CGFloat lineViewH = 2;
    CGFloat y = self.titleView.yj_height - lineViewH - 4;
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    //lineView.yj_width = titleBtn.titleLabel.yj_width;
    lineView.yj_width = 30;
    lineView.yj_centerX = titleBtn.yj_centerX;
    // 添加到titleView里
    [self.titleView addSubview:lineView];
    lineView.layer.cornerRadius = 1;
    lineView.layer.masksToBounds = YES;
}




#pragma mark - 添加所有的子控制器
- (void)addAllChildViewControllers
{
    
    
    RSTaoBaoContentViewController * view1 = [[RSTaoBaoContentViewController alloc]init];
//    view1.taobaoUsermodel = self.taobaoUsermodel;
    view1.title = @"全部1";
    view1.tsUserId = self.tsUserId;
    view1.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view1];
    
    RSTaoBaoContentViewController * view2 = [[RSTaoBaoContentViewController alloc]init];
//    view2.taobaoUsermodel = self.taobaoUsermodel;
    view2.title = @"荒料1";
    view2.tsUserId = self.tsUserId;
    view2.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view2];
    
    RSTaoBaoContentViewController * view3 = [[RSTaoBaoContentViewController alloc]init];
//    view3.taobaoUsermodel = self.taobaoUsermodel;
    view3.title = @"大板1";
    view3.tsUserId = self.tsUserId;
    view3.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view3];
    
    
    
    NSInteger count = self.childViewControllers.count;
    //    // 给contentScrollView添加子控制器的view
    //    for (int i = 0 ; i < count; i++) {
    //        UIViewController *vc = self.childViewControllers[i];
    //        vc.view.frame = CGRectMake(i * YJScreenW, 0, YJScreenW, YJScreenH);
    //        [self.contentScrollView addSubview:vc.view];
    //    }
    // 设置内容scrollView的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * self.contentScrollView.yj_width, 0);
}



#pragma mark - 添加所有的标题按钮
- (void)addAllTitleBtns
{
    // 所有的标题
    NSArray *titles = @[@"首页",@"荒料",@"大板"];
    // 按钮宽度
    CGFloat btnW = (SCW / 2)/titles.count;
    CGFloat btnH = self.titleView.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF4B33"] forState:UIControlStateSelected];
        
        [self.titleView addSubview:titleBtn];
        
        //        if (i == 0) {
        //            UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleBtn.frame), 10, 1, 21)];
        //            midView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
        //            [self.titleView addSubview:midView];
        //        }
        //
        // 保存标题按钮
        [self.titleBtns addObject:titleBtn];
        
        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    
}
#pragma mark - 标题点击事件
- (void)titleBtnClick:(UIButton *)titleBtn
{
    // 判断标题按钮是否重复点击
    //    if (titleBtn == self.preBtn) {
    //        // 重复点击标题按钮，发送通知给帖子控制器，告诉它刷新数据
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"titleBtnRefreshClick" object:nil];
    //    }
    // 1.标题按钮点击三步曲
    if (titleBtn.selected) {
        titleBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
//        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF4B33"] forState:UIControlStateNormal];
        self.preBtn.selected = NO;
        titleBtn.selected = YES;
        self.preBtn = titleBtn;
    }else{
        titleBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        self.preBtn.selected = NO;
        titleBtn.selected = YES;
        self.preBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.preBtn = titleBtn;
    }
    
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.yj_width = titleBtn.titleLabel.yj_width + 10;
        self.lineView.yj_centerX = titleBtn.yj_centerX;
        
        // 3.修改contentScrollView的便宜量,点击标题按钮的时候显示对应子控制器的view
        self.contentScrollView.contentOffset = CGPointMake(tag * self.contentScrollView.yj_width, 0);
    }];
    
    // 添加子控制器的view
    UIViewController *vc = self.childViewControllers[tag];
    // 如果子控制器的view已经添加过了，就不需要再添加了
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:vc.view];
    
}
#pragma mark - <UIScrollViewDelegate>
// 当scrollView减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取子控制对应的标题按钮
    // 计算出子控制器的下标
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    UIButton *titleBtn = self.titleBtns[index];
    
    // 调用标题按钮的点击事件
    [self titleBtnClick:titleBtn];
}

// 当scrollView滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算拖拽的比例
    CGFloat ratio = scrollView.contentOffset.x / scrollView.yj_width;
    // 将整数部分减掉，保留小数部分的比例(控制器比例的范围0~1.0)
    ratio = ratio - self.preBtn.tag;
    // 设置下划线的centerX
    self.lineView.yj_centerX = self.preBtn.yj_centerX + ratio * self.preBtn.yj_width;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        _textfield.text = temp;
    }else{
        _textfield.text = @"";
    }
    [self searchShopStoneNameNewData:_textfield.text];
}



- (void)searchShopStoneNameNewData:(NSString *)tempStr{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        RSTaoBaoContentViewController * vc = (RSTaoBaoContentViewController *)self.childViewControllers[i];
        if (i == 0) {
//            vc.taobaoUsermodel = self.taobaoUsermodel;
            vc.title = @"全部1";
            vc.tsUserId = self.tsUserId;
            
        }else if (i == 1){
//            vc.taobaoUsermodel = self.taobaoUsermodel;
            vc.title = @"荒料1";
            vc.tsUserId = self.tsUserId;
            
        }else if (i == 2){
//            vc.taobaoUsermodel = self.taobaoUsermodel;
            vc.title = @"大板1";
            vc.tsUserId = self.tsUserId;
        }
        vc.pageNum = 2;
        [vc reloadShopInformationNewData:tempStr];
        //vc.BLSpotDict = self.BLSpotDict;
        //vc.delegate = self;
        //vc.type = @"DETAIL";
        //[vc.selectArray removeAllObjects];
        //[vc.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        //[vc.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"isPublic"];
        //vc.isReSelect = false;
        //vc.isAllSelect = false;
        //vc.allBtn.selected = false;
        //[vc reloadSLSpotNewData];
    }
}





- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (BOOL)prefersStatusBarHidden{
    if (_isFirst == NO) {
        if (iphonex || iPhoneXSMax || iPhoneXR || iPhoneXS) {
            self.navigationController.navigationBar.frame = CGRectMake(0,44, SCW,44);
        }else{
            self.navigationController.navigationBar.frame = CGRectMake(0,20, SCW,44);
        }
        //_isFirst = YES;
    }else{
        self.navigationController.navigationBar.frame = CGRectMake(0,0, SCW,64);

    }
    return NO;
}






@end
