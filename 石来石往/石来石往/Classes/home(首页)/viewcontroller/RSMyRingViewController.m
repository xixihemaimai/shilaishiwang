//
//  RSMyRingViewController.m
//  石来石往
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyRingViewController.h"
#import "RSMyRingCell.h"
#import "RSMyRingHeaderview.h"
#import "RSMyRingFooterview.h"
#import "RSMyRingModel.h"
#import "RSMyRingTimeModel.h"
#import <MJRefresh.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "RSMyPublishViewController.h"
#import "RSWasteMaterialViewController.h"
#import "UIImageView+WebCache.h"
#import "RSTimeTool.h"
#import "XLPhotoBrowser.h"
#import <HUPhotoBrowser.h>
#import "RSLeftViewController.h"
#import "RSFriendDetailController.h"
#import "RSProductDetailViewController.h"
#import "RSPublishButton.h"
#define margin 10
#define ECA 3
#define MARGIN 11

//UIImagePickerControllerDelegate,UINavigationControllerDelegate,
@interface RSMyRingViewController ()<UITableViewDelegate,UITableViewDataSource,RSMyRingHeaderviewDelegate>
{
    NSInteger selectIndex;
    //货主的边框的图片
    UIImageView * _bianImage;

    UIView * _bottomeview;
    //蒙版View;
    UIView * _menview;
}
/**获取是上啦刷新，还是下拉刷新的地方 true是下拉刷新，false是下来刷新*/
@property (nonatomic,assign)BOOL isRefresh;

@property (nonatomic,strong)UITableView * tableview;
/**获取上啦刷新的页数*/
@property (nonatomic,assign)int pageNum;

@property (nonatomic,strong)NSMutableArray * oweArray;

@end

@implementation RSMyRingViewController
- (NSMutableArray *)oweArray{
    if (_oweArray == nil) {
        _oweArray = [NSMutableArray array];
    }
    return _oweArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.hidesBottomBarWhenPushed = YES;
    //self.navigationController.navigationBar.hidden = true;
    //删除的时候要进行的刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delFriendData) name:@"delFriendData" object:nil];
    //这边是发表评论和图片的时候要做的刷新的动作
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshMyFriendData) name:@"refreshMyFriendData" object:nil];
}

static NSString * MYHEADER = @"myheader";
static NSString * MYFOOTER = @"myfooter";
static NSInteger oldMyRingSection = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的圈";
    self.pageNum = 2;
    
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    UITableView * tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    self.tableview = tableview;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor whiteColor];
//    self.tableview.estimatedRowHeight = 0.01;
//    self.tableview.estimatedSectionHeaderHeight = 0.01;
//    self.tableview.estimatedSectionFooterHeight = 0.01;
    [self isAddjust];
    [self.view addSubview:self.tableview];
    RSWeakself
    //下拉
   self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [weakSelf loadTableviewData];
   }];
    
    
    //上拉
   self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       [weakSelf loadMoreTableviewNewData];
   }];
    
   [self loadHeadData];
    
    
}

#pragma mark -- 获取上半部分的数据
- (void)loadHeadData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:self.erpCodeStr forKey:@"erpCode"];
    [dict setObject:self.userIDStr forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_MY_QUAN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                NSMutableArray * array = nil;
                array = json[@"Data"];
                    for (int n = 0; n < array.count; n++) {
                        RSMyRingModel * mymodel = [[RSMyRingModel alloc]init];
                        mymodel.ERP_USER_CODE = [[array objectAtIndex:n]objectForKey:@"ERP_USER_CODE"];
                        mymodel.backgroundImgUrl = [[array objectAtIndex:n]objectForKey:@"backgroundImgUrl"];
                        mymodel.blockNum = [[[array objectAtIndex:n]objectForKey:@"blockNum"] doubleValue];
                        mymodel.ownerAdress = [[array objectAtIndex:n]objectForKey:@"ownerAdress"];
                        mymodel.ownerLinkMan = [[array objectAtIndex:n]objectForKey:@"ownerLinkMan"];;
                        mymodel.ownerLogo = [[array objectAtIndex:n]objectForKey:@"ownerLogo"];
                        mymodel.ownerName = [[array objectAtIndex:n]objectForKey:@"ownerName"];
                        mymodel.ownerPhone = [[array objectAtIndex:n]objectForKey:@"ownerPhone"];
                        mymodel.slabNum = [[[array objectAtIndex:n]objectForKey:@"slabNum"]doubleValue];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakSelf.mymodel = mymodel;
                             [weakSelf addCustomTableview];
                            [weakSelf loadTableviewData];
                        });
                    }
            }else{
               [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
        }
    }];
}

- (void)loadTableviewData{
    [SVProgressHUD showWithStatus:@"拼命加载数据....."];
    self.isRefresh = true;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.creat_userIDStr forKey:@"friendId"];
    [phoneDict setObject:self.erpCodeStr forKey:@"erpCode"];
    [phoneDict setObject:self.userModel.userID forKey:@"loginUserId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_FOOT_MY_QUAN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                  [weakSelf.oweArray removeAllObjects];
                //weakSelf.oweArray = [RSFriendModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                
                if (array.count > 0) {
                    for (int j = 0; j < array.count; j++) {
                        RSFriendModel *friendModel = [[RSFriendModel alloc]init];
                        friendModel.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                        friendModel.status = [[array objectAtIndex:j] objectForKey:@"status"];
                        friendModel.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                        friendModel.content = [[array objectAtIndex:j] objectForKey:@"content"];
                        friendModel.url = [[array objectAtIndex:j] objectForKey:@"url"];
                        friendModel.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                        friendModel.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                        friendModel.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                        friendModel.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                        friendModel.day = [[array objectAtIndex:j]objectForKey:@"day"];
                        friendModel.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                        friendModel.month = [[array objectAtIndex:j]objectForKey:@"month"];
                        friendModel.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        friendModel.status = [[array objectAtIndex:j]objectForKey:@"status"];
                        friendModel.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                        friendModel.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                        friendModel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                        friendModel.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                        friendModel.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                        friendModel.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                        friendModel.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                        friendModel.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                        friendModel.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                        friendModel.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                        friendModel.index = j;
                        friendModel.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                        friendModel.type = [[array objectAtIndex:j]objectForKey:@"type"];
                        friendModel.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                        friendModel.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                        
                        friendModel.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                        friendModel.video = [[array objectAtIndex:j]objectForKey:@"video"];
                        friendModel.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                        friendModel.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                        friendModel.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"]doubleValue];
                        [weakSelf.oweArray addObject:friendModel];
                    }
                    if ( weakSelf.oweArray.count >= 1) {
                        _bottomeview.sd_layout
                        .heightIs(10);
                        _bottomeview.backgroundColor = [UIColor whiteColor];
                    }else{
                        _bottomeview.sd_layout
                        .heightIs(0);
                    }
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
                [SVProgressHUD dismiss];
            }else{
                [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:weakSelf];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD dismiss];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)loadMoreTableviewNewData{
    self.isRefresh = false;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"%d",self.pageNum] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.creat_userIDStr forKey:@"friendId"];
    [phoneDict setObject:self.userModel.userID forKey:@"loginUserId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_FOOT_MY_QUAN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
               // NSMutableArray * array = [RSFriendModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                NSMutableArray * array = [NSMutableArray array];
                NSMutableArray * temp = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int j = 0; j < array.count; j++) {
                        RSFriendModel *friendModel = [[RSFriendModel alloc]init];
                        friendModel.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                        friendModel.status = [[array objectAtIndex:j] objectForKey:@"status"];
                        friendModel.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                        friendModel.content = [[array objectAtIndex:j] objectForKey:@"content"];
                        friendModel.url = [[array objectAtIndex:j] objectForKey:@"url"];
                        friendModel.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                        friendModel.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                        friendModel.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                        friendModel.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                        friendModel.day = [[array objectAtIndex:j]objectForKey:@"day"];
                        friendModel.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                        friendModel.month = [[array objectAtIndex:j]objectForKey:@"month"];
                        friendModel.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        friendModel.status = [[array objectAtIndex:j]objectForKey:@"status"];
                        friendModel.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                        friendModel.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                        friendModel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                        friendModel.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                        friendModel.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                        friendModel.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                        friendModel.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                        friendModel.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                        friendModel.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                        friendModel.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                        friendModel.index = j;
                        friendModel.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                        friendModel.type = [[array objectAtIndex:j]objectForKey:@"type"];
                        friendModel.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                        friendModel.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                        friendModel.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                        friendModel.video = [[array objectAtIndex:j]objectForKey:@"video"];
                        friendModel.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                        friendModel.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                        friendModel.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"]doubleValue];
                        [temp addObject:friendModel];
                    }
                    [weakSelf.oweArray addObjectsFromArray:temp];
                }
                weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

#pragma mark -- 添加自定义tableview
- (void)addCustomTableview{
    CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
    UIView * headerview = [[UIView alloc]initWithFrame:frame];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
    //背景图片
    UIImageView * oweImage = [[UIImageView alloc]init];
    [oweImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.mymodel.backgroundImgUrl]] placeholderImage:[UIImage imageNamed:@"beijing"]];
    UITapGestureRecognizer * oweImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callTheCamera:)];
    oweImage.userInteractionEnabled = YES;
    oweImage.contentMode = UIViewContentModeScaleAspectFill;
    oweImage.clipsToBounds = YES;
    oweImage.tag = 0;
    [oweImage addGestureRecognizer:oweImageTap];
    _oweImage = oweImage;
    [headerview addSubview:oweImage];
    
    
    UIButton * backImageBtn = [[UIButton alloc]init];
    //backImageBtn.image = [UIImage imageNamed:@"返回"];
    //backImageBtn.alpha = 0.5;
    [backImageBtn setImage:[UIImage imageNamed:@"上一页"] forState:UIControlStateNormal];
    backImageBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 11, 6, 11);
    [backImageBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000" alpha:0.5]];
    [backImageBtn addTarget:self action:@selector(backUpViewController:) forControlEvents:UIControlEventTouchUpInside];
    [oweImage addSubview:backImageBtn];
    
    
    
    //当前货主的信息
    UIView * ownMessageview = [[UIView alloc]init];
    ownMessageview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:ownMessageview];
    //我的荒料和我的大板
    UIView * myOweview = [[UIView alloc]init];
    myOweview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:myOweview];
    //调取相册
    UIView * ownALAssetview = [[UIView alloc]init];
    ownALAssetview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:ownALAssetview];
    //用户的信息
    //联系人
    UILabel * contactName = [[UILabel alloc]init];
    contactName.text = [NSString stringWithFormat:@"联系人:%@",self.mymodel.ownerName];
    contactName.font =[UIFont systemFontOfSize:15];
    contactName.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [ownMessageview addSubview:contactName];
    //电话号码
    UILabel * contactPhone = [[UILabel alloc]init];
    contactPhone.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    contactPhone.font = [UIFont systemFontOfSize:15];
    contactPhone.text = [NSString stringWithFormat:@"电   话:%@",self.mymodel.ownerPhone];
    [ownMessageview addSubview:contactPhone];
    //地址
    UILabel * contactAddress = [[UILabel alloc]init];
    contactAddress.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    contactAddress.font = [UIFont systemFontOfSize:15];
    contactAddress.text = [NSString stringWithFormat:@"地   址:%@",self.mymodel.ownerAdress];
    [ownMessageview addSubview:contactAddress];
    //我的荒料和我的大板
    //荒料
    UIButton * huangBtn = [[UIButton alloc]init];
    [huangBtn setBackgroundColor:[UIColor whiteColor]];
    [myOweview addSubview:huangBtn];
    [huangBtn addTarget:self action:@selector(choiceHuange:) forControlEvents:UIControlEventTouchUpInside];
    //荒料的图片
    UIImageView * huangImage = [[UIImageView alloc]init];
    huangImage.image = [UIImage imageNamed:@"荒料"];
    [huangBtn addSubview:huangImage];
    UILabel * huangLabel = [[UILabel alloc]init];
    huangLabel.text = @"荒料现货";
    huangLabel.font = [UIFont systemFontOfSize:15];
    huangLabel.textColor = [UIColor colorWithHexColorStr:@"#51ADDF"];
    [huangBtn addSubview:huangLabel];
    
    UILabel * huangDetailLabel = [[UILabel alloc]init];
    huangDetailLabel.text = [NSString stringWithFormat:@"%0.3lf立方米",self.mymodel.blockNum];
    huangDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#51ADDF"];
    huangDetailLabel.font = [UIFont systemFontOfSize:15];
    [huangBtn addSubview:huangDetailLabel];
    UIButton * huangDetailBtn = [[UIButton alloc]init];
    [huangDetailBtn setImage:[UIImage imageNamed:@"ra"] forState:UIControlStateNormal];
    [huangBtn addSubview:huangDetailBtn];
    
    UIView * midview = [[UIView alloc]init];
    midview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [myOweview addSubview:midview];
    //大板
    UIButton * daBtn = [[UIButton alloc]init];
    [daBtn setBackgroundColor:[UIColor whiteColor]];
    [myOweview addSubview:daBtn];
    [daBtn addTarget:self action:@selector(choiceDaBan:) forControlEvents:UIControlEventTouchUpInside];
    //荒料的图片
    UIImageView * daBanImage = [[UIImageView alloc]init];
    daBanImage.image = [UIImage imageNamed:@"大板"];
    [daBtn addSubview:daBanImage];
    
    UILabel * daBanLabel = [[UILabel alloc]init];
    daBanLabel.text = @"大板现货";
    daBanLabel.font = [UIFont systemFontOfSize:15];
    daBanLabel.textColor = [UIColor colorWithHexColorStr:@"#32B191"];
    [daBtn addSubview:daBanLabel];
    
    UILabel * daBanDetailLabel = [[UILabel alloc]init];
    daBanDetailLabel.text = [NSString stringWithFormat:@"%lf平方米",self.mymodel.slabNum];
    daBanDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#32B191"];
    daBanDetailLabel.font = [UIFont systemFontOfSize:15];
    [daBtn addSubview:daBanDetailLabel];
    
    UIButton * daBanDetailBtn = [[UIButton alloc]init];
    [daBanDetailBtn setImage:[UIImage imageNamed:@"ra"] forState:UIControlStateNormal];
    [daBtn addSubview:daBanDetailBtn];
    //调用相册
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"今天";
    timeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    timeLabel.font = [UIFont systemFontOfSize:28];
    [ownALAssetview addSubview:timeLabel];
    //调用相册
    UIButton * alassetviewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alassetviewBtn setImage:[UIImage imageNamed:@"iconfont-照相机"] forState:UIControlStateNormal];
    [ownALAssetview addSubview:alassetviewBtn];
    _alassetviewBtn = alassetviewBtn;
    //背景图片里面的内容
    UIImageView * nameImage = [[UIImageView alloc]init];
    nameImage.layer.borderWidth = 2;
    nameImage.layer.borderColor = [UIColor colorWithHexColorStr:@"#f0f0f0"].CGColor;
    nameImage.layer.cornerRadius = 4;
    nameImage.layer.masksToBounds = YES;
    [nameImage bringSubviewToFront:headerview];
    nameImage.userInteractionEnabled = YES;
    nameImage.contentMode = UIViewContentModeScaleAspectFill;
    nameImage.clipsToBounds = YES;
    [nameImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.mymodel.ownerLogo]] placeholderImage:[UIImage imageNamed:@"头像"]];
    if ([self.userType isEqualToString:@"hxyk"]) {
        nameImage.layer.borderColor = [UIColor colorWithHexColorStr:@"#F2F2F2"].CGColor;
        nameImage.layer.borderWidth =  3;
        nameImage.layer.masksToBounds = YES;
    }
   [headerview addSubview:nameImage];
    //用来区分
    nameImage.tag = 1;
    UITapGestureRecognizer * nameImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callTheCamera:)];
    [nameImage addGestureRecognizer:nameImageTap];
    _nameImage = nameImage;
    //背景图片里面的用户名
    UILabel * oweName = [[UILabel alloc]init];
    oweName.textColor = [UIColor whiteColor];
    _oweName = oweName;
    oweName.text = [NSString stringWithFormat:@"%@",self.mymodel.ownerName];
    oweName.textAlignment = NSTextAlignmentRight;
    [oweName bringSubviewToFront:headerview];
    oweName.font = [UIFont systemFontOfSize:16];
    [headerview addSubview:oweName];
    
    UITapGestureRecognizer * oweNameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callTheCamera:)];
    oweName.tag = 1;
    [oweName addGestureRecognizer:oweNameTap];

    UIView * bottomeview = [[UIView alloc]init];
    bottomeview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:bottomeview];
    _bottomeview = bottomeview;
    
    oweImage.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(headerview, 0)
    .heightIs(250);

    ownMessageview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(oweImage, 0)
    .heightIs(107);
    
    myOweview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(ownMessageview, 10)
    .heightIs(135);

    ownALAssetview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(myOweview, 10)
    .heightIs(120);
    //用户的信息
    contactName.sd_layout
    .leftSpaceToView(ownMessageview, 12)
    .topSpaceToView(ownMessageview, 22)
    .rightSpaceToView(ownMessageview, 12)
    .heightIs(15);
    
    
    backImageBtn.sd_layout
    .leftSpaceToView(oweImage, 8)
    .topSpaceToView(oweImage, 40.5)
    .widthIs(32)
    .heightEqualToWidth();
    
    backImageBtn.layer.cornerRadius = backImageBtn.yj_width * 0.5;
    backImageBtn.layer.masksToBounds = YES;
    
    
    contactPhone.sd_layout
    .leftEqualToView(contactName)
    .rightEqualToView(contactName)
    .topSpaceToView(contactName, 13)
    .heightIs(15);
    
    contactAddress.sd_layout
    .leftEqualToView(contactPhone)
    .rightEqualToView(contactPhone)
    .topSpaceToView(contactPhone, 13)
    .bottomSpaceToView(ownMessageview, 14);

    huangBtn.sd_layout
    .leftSpaceToView(myOweview, 0)
    .rightSpaceToView(myOweview, 0)
    .topSpaceToView(myOweview, 0)
    .heightIs(67);

    huangImage.sd_layout
    .leftSpaceToView(huangBtn, 12)
    .topSpaceToView(huangBtn, 11)
    .bottomSpaceToView(huangBtn, 12)
    .widthIs(44);
    
    huangLabel.sd_layout
    .leftSpaceToView(huangImage, 16)
    .topEqualToView(huangImage)
    .widthRatioToView(huangBtn, 0.3)
    .heightIs(15);
    
    huangDetailLabel.sd_layout
    .leftEqualToView(huangLabel)
    .topSpaceToView(huangLabel,8)
    .bottomEqualToView(huangImage)
    .widthRatioToView(huangBtn, 0.5);
    
    huangDetailBtn.sd_layout
    .centerYEqualToView(huangBtn)
    .rightSpaceToView(huangBtn, 13)
    .widthIs(7)
    .heightIs(13);
    
    midview.sd_layout
    .leftSpaceToView(myOweview, 12)
    .rightSpaceToView(myOweview, 12)
    .topSpaceToView(huangBtn, 0)
    .heightIs(1);
    
    daBtn.sd_layout
    .leftSpaceToView(myOweview, 0)
    .rightSpaceToView(myOweview, 0)
    .topSpaceToView(midview, 0)
    .bottomSpaceToView(myOweview, 0);

    daBanImage.sd_layout
    .leftSpaceToView(daBtn, 12)
    .topSpaceToView(daBtn, 11)
    .bottomSpaceToView(daBtn, 12)
    .widthIs(44);
    
    daBanLabel.sd_layout
    .leftSpaceToView(daBanImage, 16)
    .topEqualToView(daBanImage)
    .widthRatioToView(daBtn, 0.3)
    .heightIs(15);
    
    daBanDetailLabel.sd_layout
    .leftEqualToView(daBanLabel)
    .topSpaceToView(daBanLabel,8)
    .bottomEqualToView(daBanImage)
    .widthRatioToView(daBtn, 0.5);
    
    daBanDetailBtn.sd_layout
    .centerYEqualToView(daBtn)
    .rightSpaceToView(daBtn, 13)
    .widthIs(7)
    .heightIs(13);
    
    //调用相册
    timeLabel.sd_layout
    .leftSpaceToView(ownALAssetview, 12)
    .topSpaceToView(ownALAssetview, 20)
    .widthIs(70)
    .heightIs(30);
    
    alassetviewBtn.sd_layout
    .leftSpaceToView(timeLabel, 20)
    .topEqualToView(timeLabel)
    .bottomSpaceToView(ownALAssetview, 20)
    .widthIs(80);

    nameImage.sd_layout
    .rightSpaceToView(headerview, 18)
    .topSpaceToView(headerview, 192)
    .widthIs(91)
    .heightIs(74);
    
    oweName.sd_layout
    .leftSpaceToView(headerview, 12)
    .rightSpaceToView(nameImage, 9)
    .centerYEqualToView(nameImage)
    .heightIs(15);

    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
        timeLabel.hidden = NO;
        [alassetviewBtn addTarget:self action:@selector(choiceAlassetview:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.mymodel.ownerName isEqualToString:self.userModel.userName]) {
            alassetviewBtn.enabled = YES;
            alassetviewBtn.hidden = NO;
            ownALAssetview.sd_layout
            .heightIs(120);
            bottomeview.sd_layout
            .leftSpaceToView(headerview, 0)
            .rightSpaceToView(headerview, 0)
            .topSpaceToView(ownALAssetview, 0)
            .heightIs(0);
        }else{
            alassetviewBtn.enabled = NO;
            alassetviewBtn.hidden = YES;
            ownALAssetview.sd_layout
            .heightIs(0);
            bottomeview.sd_layout
            .leftSpaceToView(headerview, 0)
            .rightSpaceToView(headerview, 0)
            .topSpaceToView(ownALAssetview, 0)
            .heightIs(10);
        }
    }else if([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSProductDetailViewController class]){
            alassetviewBtn.hidden = YES;
            alassetviewBtn.enabled = NO;
            timeLabel.hidden = YES;
            ownALAssetview.sd_layout
            .heightIs(0);

        bottomeview.sd_layout
        .leftSpaceToView(headerview, 0)
        .rightSpaceToView(headerview, 0)
        .topSpaceToView(myOweview, 10)
        .heightIs(10);
    }else{
        alassetviewBtn.hidden = YES;
        alassetviewBtn.enabled = NO;
        timeLabel.hidden = YES;
        ownALAssetview.sd_layout
        .heightIs(0);
        
        bottomeview.sd_layout
        .leftSpaceToView(headerview, 0)
        .rightSpaceToView(headerview, 0)
        .topSpaceToView(myOweview, 10)
        .heightIs(10);
        bottomeview.backgroundColor = [UIColor clearColor];
    }
    oweImage.contentMode = UIViewContentModeScaleToFill;
    if ([self.userType isEqualToString:@"hxhz"]) {
          [headerview setupAutoHeightWithBottomView:bottomeview bottomMargin:0];
    }else{
        myOweview.sd_layout
        .heightIs(0);
        
        contactName.sd_layout
        .heightIs(0);
        
        contactPhone.sd_layout
        .heightIs(0);
        
        contactAddress.sd_layout
        .heightIs(0);
        
        huangDetailBtn.sd_layout
        .heightIs(0);
        
        huangDetailLabel.sd_layout
        .heightIs(0);
        
        daBanDetailBtn.sd_layout
        .heightIs(0);
        
        daBanDetailLabel.sd_layout
        .heightIs(0);

        midview.sd_layout
        .heightIs(0);
        
        daBanLabel.sd_layout
        .heightIs(0);
        
        daBanImage.sd_layout
        .heightIs(0);
        
        huangImage.sd_layout
        .heightIs(0);
        
        huangLabel.sd_layout
        .heightIs(0);
        
        huangBtn.sd_layout
        .heightIs(0);
        
        daBtn.sd_layout
        .heightIs(0);
        
        ownMessageview.sd_layout
        .heightIs(0);
        
        myOweview.hidden = YES;
        contactName.hidden = YES;
        contactPhone.hidden = YES;
        contactAddress.hidden = YES;
        huangDetailBtn.hidden = YES;
        huangDetailLabel.hidden = YES;
        daBanDetailBtn.hidden = YES;
        daBanDetailLabel.hidden = YES;
        midview.hidden = YES;
        daBanLabel.hidden = YES;
        daBanImage.hidden = YES;
        huangImage.hidden = YES;
        huangBtn.hidden = YES;
        huangLabel.hidden = YES;
        daBtn.hidden = YES;
        ownMessageview.hidden = YES;
        headerview.backgroundColor = [UIColor whiteColor];
        [headerview setupAutoHeightWithBottomView:bottomeview bottomMargin:0];
    }
    [headerview layoutIfNeeded];
    self.tableview.tableHeaderView = headerview;
}




#pragma mark-- 选择荒料
- (void)choiceHuange:(UIButton *)btn{
    RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
    wasteMaterialVc.titleNameLabel = [NSString stringWithFormat:@"%@--荒料汇总",self.mymodel.ownerName];
    wasteMaterialVc.tyle = @"huangliao";
    wasteMaterialVc.erpCodeStr = self.mymodel.ERP_USER_CODE;
    wasteMaterialVc.userModel = self.userModel;
    [self.navigationController pushViewController:wasteMaterialVc animated:YES];
}

#pragma mark -- 选择大板
- (void)choiceDaBan:(UIButton *)btn{
    RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
    wasteMaterialVc.titleNameLabel = [NSString stringWithFormat:@"%@--大板汇总",self.mymodel.ownerName];
    wasteMaterialVc.tyle = @"daban";
    wasteMaterialVc.erpCodeStr = self.mymodel.ERP_USER_CODE;
    wasteMaterialVc.userModel = self.userModel;
    [self.navigationController pushViewController:wasteMaterialVc animated:YES];
}


#pragma mark -- 选择相册
- (void)choiceAlassetview:(UIButton *)btn{
    UIView * menview = [[UIView alloc]init];
    menview.backgroundColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:0.7];
    [self.view addSubview:menview];
    [menview bringSubviewToFront:self.view];
    
    menview.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view , 0);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelMenview:)];
    menview.userInteractionEnabled = YES;
    [menview addGestureRecognizer:tap];
    _menview = menview;
    
    UIView * selectview = [[UIView alloc]init];
    selectview.backgroundColor = [UIColor whiteColor];
    [menview addSubview:selectview];
    [selectview bringSubviewToFront:menview];
    
    if (iPhone4 || iPhone5) {
        selectview.sd_layout
        .leftSpaceToView(menview, 24)
        .rightSpaceToView(menview, 24)
        .centerXEqualToView(menview)
        .centerYEqualToView(menview)
        .heightIs(180);
    }else{
        selectview.sd_layout
        .leftSpaceToView(menview, 24)
        .rightSpaceToView(menview, 24)
        .centerXEqualToView(menview)
        .centerYEqualToView(menview)
        .heightIs(220);
    }
    NSArray * imageArray = @[@"说荒料",@"谈大板",@"言花岗岩",@"抒生活",@"辅料",@"求购"];
    NSArray * titleArray = @[@"说荒料",@"谈大板",@"言花岗岩",@"抒生活",@"语辅料",@"求购"];
    CGFloat btnW = ((SCW - 48) - (ECA + 1)*margin)/ECA;
    CGFloat btnH = btnW;
    for (int i = 0 ; i < imageArray.count; i++) {
        RSPublishButton * publishBtn = [[RSPublishButton alloc]init];
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        publishBtn.tag = 10000 + i;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        CGFloat btnY =  row * (margin + btnH) + margin;
        publishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [publishBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [selectview addSubview:publishBtn];
        [publishBtn addTarget:self action:@selector(selectPublishStyle:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)selectPublishStyle:(UIButton *)btn{
    NSString * tempStr = [NSString string];
    switch (btn.tag) {
        case 10000:
            tempStr = @"gongying";
            break;
        case 10001:
            tempStr = @"gongying";
            break;
        case 10002:
            tempStr = @"gongying";
            break;
        case 10003:
            tempStr = @"gongying";
            break;
        case 10004:
            tempStr = @"gongying";
            break;
        case 10005:
            tempStr = @"qiugou";
            break;
    }
    RSMyPublishViewController * mypublishVc = [[RSMyPublishViewController alloc]init];
    mypublishVc.usermodel = self.userModel;
    //发布什么类型的朋友圈
    mypublishVc.tempStr = tempStr;
    [self.navigationController pushViewController:mypublishVc animated:YES];
    for (UIView * view  in _menview.subviews) {
        [view removeFromSuperview];
    }
    [_menview removeFromSuperview];
}

- (void)cancelMenview:(UITapGestureRecognizer *)tap
{
    for (UIView * view in _menview.subviews) {
        [view removeFromSuperview];
    }
    //让蒙版的view清除掉
    [_menview removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.oweArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MYID = @"myid";
    RSMyRingCell * cell = [tableView dequeueReusableCellWithIdentifier:MYID];
    if (!cell) {
        cell = [[RSMyRingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MYID];
    }
    return cell;
}

- (void)myRingPlaySelectVideoIndex:(NSInteger)index{
     RSFriendModel * friendmodel = self.oweArray[index];
    [RSJumpPlayVideoTool canYouSkipThePlaybackVideoInterfaceRSFriendModel:friendmodel andViewController:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSMyRingHeaderview * myHeaderview = [[RSMyRingHeaderview alloc]initWithReuseIdentifier:MYHEADER];
    myHeaderview.delegate = self;
    //现在没有用
   // myHeaderview.myModel = self.myModel;
   // RSMyRingTimeModel * myTimeModel = self.oweArray[section];
   //RSMyRingTimeModel * mySecondTimeModel = [[RSMyRingTimeModel alloc]init];
    RSFriendModel * myfriendmodel = self.oweArray[section];
    RSFriendModel * mySecondFriendmodel = [[RSFriendModel alloc]init];
    if (section > 0) {
       // mySecondTimeModel = self.oweArray[section-1];
        mySecondFriendmodel = self.oweArray[section - 1];
    }
    //月，日，年，是昨天，还是今天的，要是相同就隐藏，不同就显示
//    if (myTimeModel.timeMark == mySecondTimeModel.timeMark &&[myTimeModel.day isEqualToString:mySecondTimeModel.day] && [myTimeModel.month isEqualToString:mySecondTimeModel.month] && myTimeModel.timeMarkYear == mySecondTimeModel.timeMarkYear) {
//        myHeaderview.dayTimeLabel.hidden = YES;
//        
//    }else{
//        myHeaderview.dayTimeLabel.hidden = NO;
//    }
    if (myfriendmodel.timeMark == mySecondFriendmodel.timeMark && [myfriendmodel.day isEqualToString:mySecondFriendmodel.day]&&[myfriendmodel.month isEqualToString:mySecondFriendmodel.month]&&myfriendmodel.timeMarkYear == mySecondFriendmodel.timeMarkYear) {
        myHeaderview.dayTimeLabel.hidden = YES;
    }else{
        myHeaderview.dayTimeLabel.hidden = NO;
    }
   // myHeaderview.myTimeModel = self.oweArray[section];
    myHeaderview.friendmodel = self.oweArray[section];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor clearColor]];
    [myHeaderview.contentView addSubview:btn];
    btn.tag = 10000+section;
    [btn addTarget:self action:@selector(jumpDetailConent:) forControlEvents:UIControlEventTouchUpInside];
    btn.sd_layout
    .leftSpaceToView(myHeaderview.view, 10)
    .rightSpaceToView(myHeaderview.contentView, 0)
    .topSpaceToView(myHeaderview.contentView, 0)
    .bottomSpaceToView(myHeaderview.contentView, 0);
    myHeaderview.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    return myHeaderview;
}

- (void)jumpDetailConent:(UIButton *)btn{
    RSFriendModel * friendmodel = self.oweArray[btn.tag - 10000];
    if ([friendmodel.status isEqualToString:@"2"]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"你上传的图片审核不通过" message:@"你是否需要删除" preferredStyle:(UIAlertControllerStyleAlert)];
        RSWeakself
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf deletFriendNotConformToPicture:friendmodel];
            [weakSelf.oweArray removeObjectAtIndex:btn.tag - 10000];
        }];
        [alert addAction:action1];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [SVProgressHUD showInfoWithStatus:@"取消删除"];
        }];
         [alert addAction:action2];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                               alert.modalPresentationStyle = UIModalPresentationFullScreen;
                           }
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
        friendDetailVc.titleStyle = @"";
        friendDetailVc.selectStr = @"";
        friendDetailVc.friendID = friendmodel.friendId;
        friendDetailVc.userModel = self.userModel;
        friendDetailVc.title = friendmodel.HZName;
        [self.navigationController pushViewController:friendDetailVc animated:YES];
    }
}

#pragma mark -- 删除朋友圈
- (void)deletFriendNotConformToPicture:(RSFriendModel *)friendmodel{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:friendmodel.friendId forKey:@"friendId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DEL_FRIEND_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    RSFriendModel * friendmodel = self.oweArray[section];
    if ([friendmodel.viewType isEqualToString:@"video"]) {
        return 80;
    }else if([friendmodel.viewType isEqualToString:@"picture"]){
        if (friendmodel.photos.count < 1) {
            CGSize size = [friendmodel.content boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
            return size.height + 20;
        }else{
            return 80;
        }
    }else{
        CGSize size = [friendmodel.content boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
        return size.height + 20;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    oldMyRingSection = section;
    RSFriendModel * myfriendmodel = self.oweArray[oldMyRingSection];
    RSFriendModel * nextMyFriendmodel = [[RSFriendModel alloc]init];
    if (oldMyRingSection + 1 <= self.oweArray.count - 1) {
        nextMyFriendmodel = self.oweArray[oldMyRingSection+1];
        if ([myfriendmodel.day isEqualToString:nextMyFriendmodel.day]&&[myfriendmodel.month isEqualToString:nextMyFriendmodel.month] && myfriendmodel.timeMarkYear == nextMyFriendmodel.timeMarkYear){
            return 5;
        }
        return 15;
    }else{
        return 15;
    }
}

#pragma mark -- 调用相机还是相册
- (void)callTheCamera:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
        case 0:
            selectIndex = 0;
            break;
        case 1:
            selectIndex = 1;
            break;
    }
    [self openPhotoAlbumAndOpenCamera];
}

- (void)openPhotoAlbumAndOpenCamera{
    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){    
        if ([self.mymodel.ownerName isEqualToString:self.userModel.userName]) {
            RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
            [selectTool openPhotoAlbumAndOpenCameraViewController:self];
            selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
                _photoEntityWillUpload = photoEntityWillUpload;
                [self uploadUserHead];
            };
        }else{
            if (selectIndex == 0) {
                //背景图片
                NSMutableArray * array = [NSMutableArray array];
                [array addObject:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.mymodel.backgroundImgUrl]];
                 [HUPhotoBrowser showFromImageView:self.oweImage withURLStrings:array atIndex:0];
               
            }else{
                
                NSMutableArray * array = [NSMutableArray array];
                [array addObject:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.mymodel.ownerLogo]];
                 [HUPhotoBrowser showFromImageView:self.nameImage withURLStrings:array atIndex:0];
            }
        }
    }else{
        if (selectIndex == 0) {
            //背景图片
            
            NSMutableArray * array = [NSMutableArray array];
            [array addObject:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.mymodel.backgroundImgUrl]];
             [HUPhotoBrowser showFromImageView:self.oweImage withURLStrings:array atIndex:0];
            
        }else{
             NSMutableArray * array = [NSMutableArray array];
             [array addObject:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.mymodel.ownerLogo]];
            [HUPhotoBrowser showFromImageView:self.nameImage withURLStrings:array atIndex:0];
        }
    }
}

#pragma mark -- 进行上传图片
- (void)uploadUserHead
{
    [SVProgressHUD showWithStatus:@"正在上传中....."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userModel.userPhone forKey:@"mobilePhone"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    NSArray *avatarArray = [NSArray arrayWithObject:_photoEntityWillUpload.image];
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    NSString * urlStr = nil;
    if (selectIndex == 0) {
        urlStr = URL_HEADER_SINGEPICTURE_BACKIMAGE;
    }else{
        urlStr =  URL_HEADER_SINGEPICTURE;
    }
    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
    [netWork getImageDataWithUrlString:urlStr withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                if (selectIndex == 0) {
                    //这边是背景图片
                    [_oweImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_HEADER_IMAGEURL_PING_IOS,json[@"path"],json[@"fileName"]]] placeholderImage:[UIImage imageNamed:@"beijing"]];
                }else{
                    //这边是头像
                    [_nameImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_HEADER_IMAGEURL_PING_IOS,json[@"path"],json[@"fileName"]]] placeholderImage:[UIImage imageNamed:@"iconfont-照相机"]];
                }
                [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传图片不能超过1M"];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
        }
    }];
}

//发表
- (void)refreshMyFriendData{
    [self loadTableviewData];
}

//删除
- (void)delFriendData{
    [self loadTableviewData];
    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    RSMyRingFooterview * myFooterview = [[RSMyRingFooterview alloc]initWithReuseIdentifier:MYFOOTER];
    myFooterview.contentView.backgroundColor = [UIColor whiteColor];
    return myFooterview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}


//- (void)viewDidDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"refreshMyFriendData" object:nil];
//}

//FIXME:返回上一个界面
- (void)backUpViewController:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:true];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
