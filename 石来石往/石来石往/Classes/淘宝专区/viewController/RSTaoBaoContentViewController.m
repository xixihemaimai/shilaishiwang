//
//  RSTaoBaoContentViewController.m
//  石来石往
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoContentViewController.h"
#import "RSTaoBaoContentCell.h"
//图片轮播
#import "ZKImgRunLoopView.h"
//滚动字幕
#import "GYRollingNoticeView.h"

//超值抢购界面
#import "RSTaoBaoActivityViewController.h"
//商品详情界面
#import "RSTaoBaoProductDetailsViewController.h"


//淘宝专区首页
#import "RSTaobaoDistrictViewController.h"

#import "RSLoginViewController.h"

//淘石头条的模型
#import "RSTaoBaoLatestModel.h"
//淘石Banner
#import "RSTaoBaoBannerModel.h"
//猜你喜欢的模型
#import "RSTaoBaoUserLikeModel.h"
#import "RSTaobaoVideoAndPictureModel.h"
//进入店铺
#import "RSTaoBaoShopViewController.h"




@interface RSTaoBaoContentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GYRollingNoticeViewDelegate,GYRollingNoticeViewDataSource>



@property (nonatomic,strong)UICollectionView * collectionview;

@property (nonatomic,strong)GYRollingNoticeView *noticeView;

@property (nonatomic,strong)NSMutableArray * arr;

@property (nonatomic,strong)NSMutableArray * imageArray;

@property (nonatomic,strong)NSMutableArray * contentArray;



@property (nonatomic,strong)NSMutableArray * activityArray;

/**用来保存店铺搜索石种名称的字符串*/
@property (nonatomic,strong)NSString * shopStoneName;


@end

@implementation RSTaoBaoContentViewController

- (NSMutableArray *)activityArray{
    if (!_activityArray) {
        _activityArray = [NSMutableArray array];
    }
    return _activityArray;
}


- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}



- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fairReload) name:@"fairReload" object:nil];
}



static NSString * TAOBAOCONTENTCELLID = @"TAOBAOCONTENTCELLID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.pageNum = 2;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (SCW - (2 + 1)*12)/2;
    CGFloat itemHeight = 250;
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    // 设置列间距
    layout.minimumInteritemSpacing = 9;
    // 设置行间距
    layout.minimumLineSpacing = 9;
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(9, 12, 9, 12);
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCW, self.view.frame.size.height - 140) collectionViewLayout:layout];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    //self.collectionview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.view addSubview:self.collectionview];
    [self.collectionview registerClass:[RSTaoBaoContentCell class] forCellWithReuseIdentifier:TAOBAOCONTENTCELLID];
    RSWeakself
    if ([self.title isEqualToString:@"首页"] ) {
        //bannar
        [self reloadBannerNewData];
        //淘石头条
        [self reloadGetLatestNewData];
        //获取活动数据
        [self reloadActivityNewData];
        //获取猜你喜欢
        [self reloadUserLikeNewData];
        
        self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageNum = 2;
            [weakSelf reloadUserLikeNewData];
        }];
        
        self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakSelf reloadUserLikeMoreNewData];
        }];
        
        [self.collectionview setupEmptyDataText:@"重新加载数据" tapBlock:^{
            [weakSelf reloadUserLikeNewData];
        }];
        
    }else if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]){
        
        
        //获取猜你喜欢
        [self reloadUserLikeNewData];
        
        self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageNum = 2;
            [weakSelf reloadUserLikeNewData];
        }];
        
        self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakSelf reloadUserLikeMoreNewData];
        }];
        
        [self.collectionview setupEmptyDataText:@"重新加载数据" tapBlock:^{
            [weakSelf reloadUserLikeNewData];
        }];
        
    }
    //     else if ([self.title isEqualToString:@"大板"]){
    //
    //     //获取猜你喜欢
    //            [self reloadUserLikeNewData];
    //            RSWeakself
    //            self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //            weakSelf.pageNum = 2;
    //            [weakSelf reloadUserLikeNewData];
    //            }];
    //
    //            self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    //            [weakSelf reloadUserLikeMoreNewData];
    //            }];
    //
    //            [self.collectionview setupEmptyDataText:@"重新加载数据" tapBlock:^{
    //                [weakSelf reloadUserLikeNewData];
    //            }];
    //
    //     }
    else{
        
        [self reloadShopInformationNewData:@""];
        
        self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageNum = 2;
            [weakSelf reloadShopInformationNewData:_shopStoneName];
        }];
        
        self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakSelf reloadShopInformationMoreNewData];
        }];
        
        [self.collectionview setupEmptyDataText:@"重新加载数据" tapBlock:^{
            [weakSelf reloadShopInformationNewData:_shopStoneName];
        }];
    }
}

- (void)reloadBannerNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETBANNER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            [weakSelf.imageArray removeAllObjects];
            if (isresult) {
                //                NSLog(@"===================%@",json);
                weakSelf.imageArray = [RSTaoBaoBannerModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}




- (void)reloadGetLatestNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETLATEST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            [weakSelf.arr removeAllObjects];
            if (isresult) {
                weakSelf.arr = [RSTaoBaoLatestModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取头条失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取头条失败"];
        }
    }];
}




- (void)reloadActivityNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:4] forKey:@"pageSize"];
    [phoneDict setObject:@"" forKey:@"stoneName"];
    [phoneDict setObject:@"" forKey:@"shopName"];
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else if ([self.title isEqualToString:@"大板"]){
        str = @"daban";
    }else{
        str = @"";
    }
    [phoneDict setObject:str forKey:@"stockType"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETACTIVITYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
//            NSLog(@"===============================%@",json);
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                //NSMutableArray * array = [NSMutableArray array];
                [weakSelf.activityArray removeAllObjects];
                //array = json[@"data"][@"list"];
                ;
                weakSelf.activityArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in weakSelf.activityArray) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
                
                
                //                NSLog(@"+++++++++++++++++++++++++++++++++++++%@",json[@"data"][@"list"]);
                
                //                for (int i = 0; i < array.count; i++) {
                //                    RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
                //                    taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
                //                    taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
                //                    taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                //                    taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
                //                    taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
                //                    taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
                //                    taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
                //                    taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
                //                    taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
                //                    taobaoUserLikemodel.discount = [[array objectAtIndex:i]objectForKey:@"discount"];
                //                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                //                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
                //                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
                //                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
                //                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
                //                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
                //                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
                //                    taobaoUserLikemodel.imageUrl =  [[array objectAtIndex:i]objectForKey:@"imageUrl"];
                //                    taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
                //                    taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                //                    NSMutableArray * temp = [NSMutableArray array];
                //                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
                //                    for (int j = 0; j < temp.count; j++) {
                //                        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                //                        videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
                //                        videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
                //                        videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
                //                        videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
                //                        [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
                //                    }
                //                    [weakSelf.activityArray addObject:taobaoUserLikemodel];
                //                }
                [weakSelf setUICollectionViewHeaderView];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}









- (void)reloadUserLikeNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else if ([self.title isEqualToString:@"大板"]){
        str = @"daban";
    }else{
        str = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:str forKey:@"stockType"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETUSERLIKE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                //                NSMutableArray * array = [NSMutableArray array];
                [weakSelf.contentArray removeAllObjects];
                //                NSLog(@"=++++++++++++++++++++++++++++++%@",json[@"data"][@"list"]);
                weakSelf.contentArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in weakSelf.contentArray) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
                
                //                array = json[@"data"][@"list"]
                //                for (int i = 0; i < array.count; i++) {
                //                    RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
                //                    taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
                //                    taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
                //                    taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                //                    taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
                //                    taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
                //                    taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
                //                    taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
                //                    taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
                //                    taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
                //                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                //                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
                //                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
                //                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
                //                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
                //                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
                //                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
                //                    taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
                //                    taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
                //                    taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                //                    NSMutableArray * temp = [NSMutableArray array];
                //                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
                //                    for (int j = 0; j < temp.count; j++) {
                //                        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                //                        videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
                //                        videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
                //                        videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
                //                        videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
                //                        [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
                //                    }
                //                    [weakSelf.contentArray addObject:taobaoUserLikemodel];
                //                }
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_header endRefreshing];
                weakSelf.pageNum = 2;
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取喜欢列表失败"];
                [weakSelf.collectionview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取喜欢列表失败"];
            [weakSelf.collectionview.mj_header endRefreshing];
        }
    }];
}



- (void)reloadUserLikeMoreNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else if ([self.title isEqualToString:@"大板"]){
        str = @"daban";
    }else{
        str = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:str forKey:@"stockType"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETUSERLIKE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                //                NSMutableArray * array = [NSMutableArray array];
                //                NSMutableArray * newtemp = [NSMutableArray array];
                //                array = json[@"data"][@"list"];
                //                for (int i = 0; i < array.count; i++) {
                //                    RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
                //                    taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
                //                    taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
                //                    taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                //                    taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
                //                    taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
                //                    taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
                //                    taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
                //                    taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
                //                    taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
                //                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                //                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
                //                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
                //                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
                //                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
                //                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
                //                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
                //                    taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
                //                     taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
                //                    taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                //                    NSMutableArray * temp = [NSMutableArray array];
                //                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
                //                    for (int j = 0; j < temp.count; j++) {
                //                        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                //                        videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
                //                        videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
                //                        videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
                //                        videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
                //                        [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
                //                    }
                //                    [newtemp addObject:taobaoUserLikemodel];
                //                }
                NSMutableArray * array = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in array) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
                [weakSelf.contentArray addObjectsFromArray:array];
                weakSelf.pageNum++;
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_footer endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取喜欢列表失败"];
                [weakSelf.collectionview.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取喜欢列表失败"];
            [weakSelf.collectionview.mj_footer endRefreshing];
        }
    }];
}




//获取店铺的数据
- (void)reloadShopInformationNewData:(NSString *)stoneName{
    _shopStoneName = stoneName;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料1"]) {
        str = @"huangliao";
    }else if ([self.title isEqualToString:@"大板1"]){
        str = @"daban";
    }else{
        str = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:str forKey:@"stockType"];
    if ([stoneName isEqualToString:@""]) {
        [phoneDict setObject:@"" forKey:@"stoneName"];
    }else{
        [phoneDict setObject:stoneName forKey:@"stoneName"];
    }
    [phoneDict setObject:@"" forKey:@"orderField"];
    [phoneDict setObject:@"" forKey:@"orderMode"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.tsUserId] forKey:@"tsUserId"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"length"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"width"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"height"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volume"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"area"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"heightType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volumeType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"areaType"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_INVENTORYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                //                NSMutableArray * array = [NSMutableArray array];
                [weakSelf.contentArray removeAllObjects];
                weakSelf.contentArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in weakSelf.contentArray) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
                //                array = json[@"data"][@"list"];
                //                for (int i = 0; i < array.count; i++) {
                //                    RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
                //                    taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
                //                    taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
                //                    taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                //                    taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
                //                    taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
                //                    taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
                //                    taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
                //                    taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
                //                    taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
                //                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                //                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
                //                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
                //                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
                //                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
                //                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
                //                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
                //                    taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
                //                    taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
                //                    taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                //                    NSMutableArray * temp = [NSMutableArray array];
                //                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
                //                    for (int j = 0; j < temp.count; j++) {
                //                        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                //                        videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
                //                        videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
                //                        videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
                //                        videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
                //                        [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
                //                    }
                //                    [weakSelf.contentArray addObject:taobaoUserLikemodel];
                //                }
                weakSelf.pageNum = 2;
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_header endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取店铺列表失败"];
                [weakSelf.collectionview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取店铺列表失败"];
            [weakSelf.collectionview.mj_header endRefreshing];
        }
    }];
}



- (void)reloadShopInformationMoreNewData{
    //_shopStoneName = stoneName;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料1"]) {
        str = @"huangliao";
    }else if ([self.title isEqualToString:@"大板1"]){
        str = @"daban";
    }else{
        str = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:str forKey:@"stockType"];
    if ([_shopStoneName isEqualToString:@""]) {
        [phoneDict setObject:@"" forKey:@"stoneName"];
    }else{
        [phoneDict setObject:_shopStoneName forKey:@"stoneName"];
    }
    [phoneDict setObject:@"" forKey:@"orderField"];
    [phoneDict setObject:@"" forKey:@"orderMode"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.tsUserId] forKey:@"tsUserId"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"length"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"width"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"height"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volume"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"area"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"heightType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volumeType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"areaType"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_INVENTORYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                //                NSMutableArray * array = [NSMutableArray array];
                //                NSMutableArray * newTemp = [NSMutableArray array];
                //                array = json[@"data"][@"list"];
                //                for (int i = 0; i < array.count; i++) {
                //                    RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
                //                    taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
                //                    taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
                //                    taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                //                    taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
                //                    taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
                //                    taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
                //                    taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
                //                    taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
                //                    taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
                //                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                //                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
                //                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
                //                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
                //                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
                //                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
                //                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
                //                    taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
                //                    taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
                //                    NSMutableArray * temp = [NSMutableArray array];
                //                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
                //                    for (int j = 0; j < temp.count; j++) {
                //                        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                //                        videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
                //                        videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
                //                        videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
                //                        videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
                //                        [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
                //                    }
                //                    [newTemp addObject:taobaoUserLikemodel];
                //                }
                NSMutableArray * array = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in array) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
                [weakSelf.contentArray addObjectsFromArray:array];
                weakSelf.pageNum++;
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_footer endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取店铺列表失败"];
                [weakSelf.collectionview.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取店铺列表失败"];
            [weakSelf.collectionview.mj_footer endRefreshing];
        }
    }];
}





- (void)setUICollectionViewHeaderView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -545, SCW, 545)];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    //图片轮播
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < self.imageArray.count; i++) {
        RSTaoBaoBannerModel * taobaoBannermodel = self.imageArray[i];
        [mutableArray addObject:taobaoBannermodel.imageUrl];
    }
    
    ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, SCW, (SCW * 118)/375) placeholderImg:[UIImage imageNamed:@"01"]];
    imgRunView.pageControl.hidden = NO;
    //self.imgRunView = imgRunView;
    imgRunView.pageControl.PageControlStyle = JhPageControlContentModeLeft;
    imgRunView.pageControl.PageControlStyle = JhPageControlStyelDefault;
    imgRunView.pageControl.currentColor = [UIColor whiteColor];
    imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#f7f7f7" alpha:0.4];
    if (mutableArray.count > 0) {
        imgRunView.imgUrlArray = mutableArray;
    }
    //这边是点击每个广告图片要跳转的位置
    [imgRunView  touchImageIndexBlock:^(NSInteger index) {
        RSTaoBaoBannerModel * taobaoBannermodel = self.imageArray[index];
        if ([taobaoBannermodel.jumpType isEqualToString:@"shop"]) {
            
            RSTaoBaoShopViewController * taoBaoShopVc = [[RSTaoBaoShopViewController alloc]init];
            taoBaoShopVc.tsUserId = taobaoBannermodel.jumpId;
            [self.navigationController pushViewController:taoBaoShopVc animated:YES];
            
        }else{
            
            RSTaoBaoProductDetailsViewController * taobaoProductDetailsVc = [[RSTaoBaoProductDetailsViewController alloc]init];
            taobaoProductDetailsVc.tsUserId = taobaoBannermodel.jumpId;
            [self.navigationController pushViewController:taobaoProductDetailsVc animated:YES];
            
        }
    }];
    [headerView addSubview:imgRunView];
    
    
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(imgRunView.frame) + 17, SCW - 24, 359)];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:contentView];
    contentView.layer.cornerRadius = 12;
    
    
    //优惠专区
    UILabel * preferentialZoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 64, 23)];
    preferentialZoneLabel.text = @"优惠专区";
    preferentialZoneLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    preferentialZoneLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    preferentialZoneLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:preferentialZoneLabel];
    
    
    //品质好材
    UILabel * goodStoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(preferentialZoneLabel.frame) + 6, 17, 42, 14)];
    goodStoneLabel.text = @"品质好材";
    goodStoneLabel.font = [UIFont systemFontOfSize:9];
    goodStoneLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    goodStoneLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    goodStoneLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:goodStoneLabel];
    goodStoneLabel.layer.cornerRadius = 3;
    goodStoneLabel.layer.masksToBounds = YES;
    
    
    
    UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    secondBtn.frame = CGRectMake(contentView.yj_width - (contentView.yj_width - (3 + 1)* 10)/3 - 12, CGRectGetMaxY(preferentialZoneLabel.frame) + 12, (contentView.yj_width - (3 + 1)* 10)/3 - 12, 126);
    [contentView addSubview:secondBtn];
    [secondBtn addTarget:self action:@selector(activityAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //第一张图片
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(preferentialZoneLabel.frame) + 12,contentView.yj_width - (contentView.yj_width - (3 + 1)* 10)/3  - 32 , 126)];
    //firstImageBtn.image = [UIImage imageNamed:@"512"];
    //@"http://117.29.162.206:8888/slsw/imgs/taoshi/ad//20191012094703u3D10013241562C409521366126fm3D2626gp3D0.jpg"
    // [firstImageBtn setImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
    [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.slsw.link:8099/slsw/imgs/taoshi/discountadv.png"]] placeholderImage:[UIImage imageNamed:@"01"]];
    
    //    [firstImageBtn setImage:imageview.image forState:UIControlStateNormal];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [contentView addSubview:imageview];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstactivityAction:)];
    imageview.userInteractionEnabled = YES;
    [imageview addGestureRecognizer:tap];
    
    RSTaoBaoUserLikeModel * taobaoUserLikemodel  = [[RSTaoBaoUserLikeModel alloc]init];
    if (self.activityArray.count > 0) {
        taobaoUserLikemodel = self.activityArray[0];
    }
    //第二张图片
    UIImageView * secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,secondBtn.yj_width,71)];
    [secondImageView sd_setImageWithURL:[NSURL URLWithString:taobaoUserLikemodel.imageUrl] placeholderImage:[UIImage imageNamed:@"512"]];
    secondImageView.contentMode = UIViewContentModeScaleAspectFill;
    secondImageView.clipsToBounds = YES;
    [secondBtn addSubview:secondImageView];
    
    //第二张图片文字
    UILabel * secondDiscountLabel = [[UILabel alloc]initWithFrame:CGRectMake(secondBtn.yj_width/2 - 23, CGRectGetMaxY(secondImageView.frame) - 8, 46, 16)];
    secondDiscountLabel.text = [NSString stringWithFormat:@"%0.1lf折",[taobaoUserLikemodel.discount floatValue]];
    secondDiscountLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    secondDiscountLabel.textAlignment = NSTextAlignmentCenter;
    secondDiscountLabel.font = [UIFont systemFontOfSize:10];
    secondDiscountLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [secondBtn addSubview:secondDiscountLabel];
    secondDiscountLabel.layer.cornerRadius = 8;
    secondDiscountLabel.layer.masksToBounds = YES;
    
    
    //类型
    UIImageView * typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondImageView.frame) + 17, 22, 12)];
    if ([taobaoUserLikemodel.stockType isEqualToString:@"huangliao"]) {
        typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
    }else{
        typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
    }
    
    typeImageView.contentMode = UIViewContentModeScaleAspectFill;
    typeImageView.clipsToBounds = YES;
    [secondBtn addSubview:typeImageView];
    typeImageView.layer.cornerRadius = 2;
    typeImageView.layer.masksToBounds = YES;
    
    
    //name
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeImageView.frame) + 6, CGRectGetMaxY(secondImageView.frame) + 14, 70, 19)];
    
    nameLabel.text = taobaoUserLikemodel.stoneName;
    
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [secondBtn addSubview:nameLabel];
    
    
    //符号
    UILabel * symbolLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeImageView.frame) + 11, 6, 14)];
    symbolLabel.text = @"¥";
    //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    symbolLabel.textAlignment = NSTextAlignmentCenter;
    symbolLabel.font = [UIFont systemFontOfSize:10];
    symbolLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    [secondBtn addSubview:symbolLabel];
    
    
    //当前价格
    UILabel * currentPriceLabel = [[UILabel alloc]init];
    
    currentPriceLabel.text = [NSString stringWithFormat:@"%@",taobaoUserLikemodel.price];
    
    CGRect rect = [currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    currentPriceLabel.frame = CGRectMake(CGRectGetMaxX(symbolLabel.frame) + 3, CGRectGetMaxY(typeImageView.frame) + 7, rect.size.width, 20);
    currentPriceLabel.textAlignment = NSTextAlignmentLeft;
    currentPriceLabel.font = [UIFont systemFontOfSize:14];
    currentPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    [secondBtn addSubview:currentPriceLabel];
    
    
    //打折价钱
    UILabel * discountPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(currentPriceLabel.frame) + 6, CGRectGetMaxY(nameLabel.frame) + 8, 50, 14)];
    discountPriceLabel.textAlignment = NSTextAlignmentLeft;
    discountPriceLabel.font = [UIFont systemFontOfSize:10];
    discountPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",taobaoUserLikemodel.originalPrice] attributes:attribtDic];
    discountPriceLabel.attributedText = attribtStr;
    [secondBtn addSubview:discountPriceLabel];
    if (self.activityArray.count > 0) {
        [self.activityArray removeObjectAtIndex:0];
    }
    CGFloat pictureW = (contentView.yj_width - (3 + 1)* 10)/3;
    CGFloat pictureH = 126;
    for (int i = 0 ; i < self.activityArray.count; i++) {
        UIButton * pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [pictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        NSInteger colom = i % 3;
        pictureBtn.tag = 10000 + i;
        CGFloat pictureBtnX =  colom * (10 + pictureW) + 10;
        pictureBtn.frame = CGRectMake(pictureBtnX, CGRectGetMaxY(imageview.frame) + 10, pictureW, pictureH);
        [contentView addSubview:pictureBtn];
        
        RSTaoBaoUserLikeModel * taobaoUserLikemodel = self.activityArray[i];
        //第二张图片
        UIImageView * secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,secondBtn.yj_width,71)];
        [secondImageView sd_setImageWithURL:[NSURL URLWithString:taobaoUserLikemodel.imageUrl] placeholderImage:[UIImage imageNamed:@"512"]];
        secondImageView.contentMode = UIViewContentModeScaleAspectFill;
        secondImageView.clipsToBounds = YES;
        [pictureBtn addSubview:secondImageView];
        
        //第二张图片文字
        UILabel * secondDiscountLabel = [[UILabel alloc]initWithFrame:CGRectMake(secondBtn.yj_width/2 - 23, CGRectGetMaxY(secondImageView.frame) - 8, 46, 16)];
        
        secondDiscountLabel.text = [NSString stringWithFormat:@"%0.1lf折",[taobaoUserLikemodel.discount floatValue]];
        
        secondDiscountLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        secondDiscountLabel.textAlignment = NSTextAlignmentCenter;
        secondDiscountLabel.font = [UIFont systemFontOfSize:10];
        secondDiscountLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [pictureBtn addSubview:secondDiscountLabel];
        secondDiscountLabel.layer.cornerRadius = 8;
        secondDiscountLabel.layer.masksToBounds = YES;
        
        
        //类型
        UIImageView * typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondImageView.frame) + 17, 22, 12)];
        //typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
        if ([taobaoUserLikemodel.stockType isEqualToString:@"huangliao"]) {
            typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
        }else{
            typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
        }
        
        
        typeImageView.contentMode = UIViewContentModeScaleAspectFill;
        typeImageView.clipsToBounds = YES;
        [pictureBtn addSubview:typeImageView];
        typeImageView.layer.cornerRadius = 2;
        typeImageView.layer.masksToBounds = YES;
        
        
        //name
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeImageView.frame) + 6, CGRectGetMaxY(secondImageView.frame) + 14, 70, 19)];
        
        nameLabel.text = taobaoUserLikemodel.stoneName;
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [pictureBtn addSubview:nameLabel];
        
        
        //符号
        UILabel * symbolLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeImageView.frame) + 11, 6, 14)];
        symbolLabel.text = @"¥";
        //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        symbolLabel.textAlignment = NSTextAlignmentCenter;
        symbolLabel.font = [UIFont systemFontOfSize:10];
        symbolLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [pictureBtn addSubview:symbolLabel];
        
        
        //当前价格
        UILabel * currentPriceLabel = [[UILabel alloc]init];
        
        currentPriceLabel.text = [NSString stringWithFormat:@"%@",taobaoUserLikemodel.price];
        
        
        CGRect rect = [currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        currentPriceLabel.frame = CGRectMake(CGRectGetMaxX(symbolLabel.frame) + 3, CGRectGetMaxY(typeImageView.frame) + 7, rect.size.width, 20);
        currentPriceLabel.textAlignment = NSTextAlignmentLeft;
        currentPriceLabel.font = [UIFont systemFontOfSize:14];
        currentPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [pictureBtn addSubview:currentPriceLabel];
        
        
        //打折价钱
        UILabel * discountPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(currentPriceLabel.frame) + 6, CGRectGetMaxY(nameLabel.frame) + 8, 50, 14)];
        discountPriceLabel.textAlignment = NSTextAlignmentLeft;
        discountPriceLabel.font = [UIFont systemFontOfSize:10];
        discountPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",taobaoUserLikemodel.originalPrice] attributes:attribtDic];
        discountPriceLabel.attributedText = attribtStr;
        [pictureBtn addSubview:discountPriceLabel];
        [pictureBtn addTarget:self action:@selector(activityAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    //分隔线
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, contentView.yj_height - 40, contentView.yj_width, 1)];
    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [contentView addSubview:bottomView];
    
    
    //淘宝头条
    UILabel * taoBaoHeadlinesLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(bottomView.frame) + 7, 80, 23)];
    taoBaoHeadlinesLabel.text = @"淘石头条";
    //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    taoBaoHeadlinesLabel.textAlignment = NSTextAlignmentLeft;
    taoBaoHeadlinesLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    taoBaoHeadlinesLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [contentView addSubview:taoBaoHeadlinesLabel];
    
    
    
    //淘宝头条滚动字幕
    
    self.noticeView = [[GYRollingNoticeView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(taoBaoHeadlinesLabel.frame) + 2, CGRectGetMaxY(bottomView.frame) + 7, contentView.yj_width - CGRectGetMaxX(taoBaoHeadlinesLabel.frame) - 12, 20)];
    _noticeView.delegate = self;
    _noticeView.dataSource = self;
    
    [contentView addSubview:self.noticeView];
    [_noticeView registerClass:[GYNoticeViewCell class] forCellReuseIdentifier:@"GYNoticeViewCell"];
    [_noticeView reloadDataAndStartRoll];
    
    
    //猜你喜欢的文字
    UILabel * loveLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerView.yj_width/2 - 40, CGRectGetMaxY(contentView.frame) + 15, 80, 23)];
    loveLabel.text = @"猜你喜欢";
    //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    loveLabel.textAlignment = NSTextAlignmentCenter;
    loveLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    loveLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [headerView addSubview:loveLabel];
    
    
    //猜你喜欢
    UIImageView * loveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.yj_width/2 - 40 - 23, CGRectGetMaxY(contentView.frame) + 15, 23, 23)];
    loveImageView.image = [UIImage imageNamed:@"猜"];
    loveImageView.contentMode = UIViewContentModeScaleAspectFill;
    loveImageView.clipsToBounds = YES;
    [headerView addSubview:loveImageView];
    
    
    self.collectionview.contentInset = UIEdgeInsetsMake(545, 0, 0, 0);
    [self.collectionview addSubview:headerView];
    [self.collectionview setContentOffset:CGPointMake(0, -545)];
}


//进入超值抢购界面
- (void)activityAction:(UIButton *)activityBtn{
    
    RSTaoBaoActivityViewController * taobaoActivityVc = [[RSTaoBaoActivityViewController alloc]init];
    //    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //    if (VERIFYKEY.length < 1) {
    //    }else{
    //        taobaoActivityVc.taobaoUsermodel = self.taobaoUsermodel;
    //    }
    [self.navigationController pushViewController:taobaoActivityVc animated:YES];
}


- (void)firstactivityAction:(UITapGestureRecognizer *)tap{
    RSTaoBaoActivityViewController * taobaoActivityVc = [[RSTaoBaoActivityViewController alloc]init];
    //    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //    if (VERIFYKEY.length < 1) {
    //    }else{
    //        taobaoActivityVc.taobaoUsermodel = self.taobaoUsermodel;
    //    }
    
    [self.navigationController pushViewController:taobaoActivityVc animated:YES];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contentArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RSTaoBaoContentCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:TAOBAOCONTENTCELLID forIndexPath:indexPath];
    RSTaoBaoUserLikeModel * taobaoUserLikemodel = self.contentArray[indexPath.row];
    cell.taobaoUserLikemodel = taobaoUserLikemodel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    
    
    RSTaoBaoUserLikeModel * taobaoUserLikemodel = self.contentArray[indexPath.row];
    RSTaoBaoProductDetailsViewController * taobaoProductDetailsVc = [[RSTaoBaoProductDetailsViewController alloc]init];
    taobaoProductDetailsVc.tsUserId = taobaoUserLikemodel.userLikeID;
    [self.navigationController pushViewController:taobaoProductDetailsVc animated:YES];
}


#pragma mark- <GYRollingNoticeViewDataSource, GYRollingNoticeViewDelegate>
- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
    return _arr.count;
}


- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    GYNoticeViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"GYNoticeViewCell"];
    RSTaoBaoLatestModel * taobaoLatestmodel = [[RSTaoBaoLatestModel alloc]init];
    if (_arr.count > 0) {
        taobaoLatestmodel = _arr[index];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", taobaoLatestmodel.title];
    cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    RSTaoBaoLatestModel * taobaoLatestmodel = _arr[index];
    RSTaoBaoProductDetailsViewController * taobaoProductDetailsVc = [[RSTaoBaoProductDetailsViewController alloc]init];
    //    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //    if (VERIFYKEY.length < 1) {
    //    }else{
    //        taobaoProductDetailsVc.taobaoUsermodel = self.taobaoUsermodel;
    //    }
    taobaoProductDetailsVc.tsUserId = taobaoLatestmodel.stoneId;
    [self.navigationController pushViewController:taobaoProductDetailsVc animated:YES];
}


- (void)fairReload{
    [self.collectionview.mj_header beginRefreshing];
}



- (void)dealloc{
    [_noticeView stopRoll];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}




//删除字典里的null值
- (NSDictionary *)deleteEmpty:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    for (id obj in mdic.allKeys)
    {
        id value = mdic[obj];
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:value];
            [dicSet setObject:changeDic forKey:obj];
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:value];
            [arrSet setObject:changeArr forKey:obj];
        }
        else
        {
            if ([value isKindOfClass:[NSNull class]]) {
                [set addObject:obj];
            }
        }
    }
    for (id obj in set)
    {
        mdic[obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        mdic[obj] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        mdic[obj] = arrSet[obj];
    }

    return mdic;
}

//删除数组中的null值
- (NSArray *)deleteEmptyArr:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];

    for (id obj in marr)
    {
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:obj];
            NSInteger index = [marr indexOfObject:obj];
            [dicSet setObject:changeDic forKey:@(index)];
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:obj];
            NSInteger index = [marr indexOfObject:obj];
            [arrSet setObject:changeArr forKey:@(index)];
        }
        else
        {
            if ([obj isKindOfClass:[NSNull class]]) {
                NSInteger index = [marr indexOfObject:obj];
                [set addObject:@(index)];
            }
        }
    }
    for (id obj in set)
    {
        marr[(int)obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = arrSet[obj];
    }
    return marr;
}





@end
