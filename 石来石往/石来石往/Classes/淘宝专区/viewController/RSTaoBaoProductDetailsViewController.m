//
//  RSTaoBaoProductDetailsViewController.m
//  石来石往
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProductDetailsViewController.h"
//荒料cell
#import "RSTaoBaoProductDetailCell.h"
//大板cell
#import "RSTaoBaoProductDetailSLCell.h"

#import "RSAllMessageUIButton.h"
//大板弹窗
#import "RSTaoBaoSLDetailView.h"
//视频和图片
#import "TSVideoPlayback.h"

//投诉
#import "RSTaobaoComplaintViewController.h"

#import <AVFoundation/AVFoundation.h>
//进店逛逛
#import "RSTaoBaoShopViewController.h"


//模型
#import "RSTaoBaoUserLikeModel.h"

#import "RSLoginViewController.h"

#import "LXActivity.h"
#import "RSWeChatShareTool.h"

@interface RSTaoBaoProductDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,RSTaoBaoSLDetailViewDelegate,TSVideoPlaybackDelegate,LXActivityDelegate>
{
    
    
    UIButton * _collectionBtn;
    
}



@property (nonatomic,strong)UIButton * allShowBtn;

@property (nonatomic,strong)UITableView * tableview;




//@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
//@property (strong, nonatomic)AVPlayerItem *item;//播放单元
//@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer
@property (nonatomic,assign) TSBANNERTYPE type;
@property (nonatomic,strong) TSVideoPlayback *video;


@property (nonatomic,strong)RSTaoBaoUserLikeModel * taobaoUserLikemodel;

@end

@implementation RSTaoBaoProductDetailsViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length > 0) {
        [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    }
    
}

//- (UITableView *)tableview{
//    if (!_tableview) {
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
////        _tableview.estimatedRowHeight = 0;
////        _tableview.estimatedSectionFooterHeight = 0;
////        _tableview.estimatedSectionHeaderHeight = 0;
//        //_tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
//        _tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return _tableview;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
   
    
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
         self.tableview.contentInset = UIEdgeInsetsMake(-44, 0, 181, 0);
    }else{
         self.tableview.contentInset = UIEdgeInsetsMake(-20, 0, 181, 0);
    }
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSCStatus:) name:@"updateSCStatus" object:nil];
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"updateSCData" object:dict];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSCData:) name:@"updateSCData" object:nil];
    
    [self setUITableviewFootView];
    
    
    [self reloadHeadShopInformationNewData];
}



- (void)updateSCStatus:(NSNotification *)notification{
//    NSDictionary * infoDic = [notification object];
//    NSString * str = [infoDic objectForKey:@"type"];
//    if ([str isEqualToString:@"stone"]) {
      [self setUITableviewFootView];
      [self reloadHeadShopInformationNewData];
//    }
}



- (void)updateSCData:(NSNotification *)notification{
//    NSDictionary * infoDic = [notification object];
//    NSString * str = [infoDic objectForKey:@"status"];
//    if ([str isEqualToString:@"attention"]) {
        
        [self setUITableviewFootView];
        [self reloadHeadShopInformationNewData];
        
//        [_collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
//        [_collectionBtn setImage:[UIImage imageNamed:@"淘宝已收藏"] forState:UIControlStateNormal];
                           
//    }else{
//
//        [_collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
//        [_collectionBtn setImage:[UIImage imageNamed:@"guanzhu商品复制"] forState:UIControlStateNormal];
//    }
}


- (void)reloadHeadShopInformationNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
       }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.tsUserId] forKey:@"id"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_INVENTORY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSLog(@"==============================%@",json);
                weakSelf.taobaoUserLikemodel = [RSTaoBaoUserLikeModel mj_objectWithKeyValues:json[@"data"]];
                
               
                
//                RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
//                taobaoUserLikemodel.actId = [json[@"data"][@"actId"]integerValue];
//                taobaoUserLikemodel.collectionId =[json[@"data"][@"collectionId"]integerValue];
//
//                taobaoUserLikemodel.createTime =json[@"data"][@"createTime"];
//                taobaoUserLikemodel.userLikeID = [json[@"data"][@"id"]integerValue];
//                taobaoUserLikemodel.identityId = json[@"data"][@"identityId"];
//                taobaoUserLikemodel.inventory = json[@"data"][@"inventory"];
//                taobaoUserLikemodel.isComplete = [json[@"data"][@"isComplete"]integerValue];
//                taobaoUserLikemodel.originalPrice = json[@"data"][@"originalPrice"];
//                taobaoUserLikemodel.price = json[@"data"][@"price"];
//                taobaoUserLikemodel.qty = [json[@"data"][@"qty"]integerValue];
//                taobaoUserLikemodel.shopName = json[@"data"][@"shopName"];
//                taobaoUserLikemodel.status =[json[@"data"][@"status"]integerValue];
//                taobaoUserLikemodel.stockType = json[@"data"][@"stockType"];
//                taobaoUserLikemodel.stoneName = json[@"data"][@"stoneName"];
//                taobaoUserLikemodel.tsUserId = [json[@"data"][@"tsUserId"]integerValue];
//                taobaoUserLikemodel.updateTime =json[@"data"][@"updateTime"];
//
//                taobaoUserLikemodel.unit = json[@"data"][@"unit"];
//                taobaoUserLikemodel.weight = json[@"data"][@"weight"];
//
//                RSTaoBaoShopInformationModel * taobaoShopInformationmodel = [[RSTaoBaoShopInformationModel alloc]init];
//                taobaoShopInformationmodel.address = json[@"data"][@"tsUser"][@"address"];
//                taobaoShopInformationmodel.collectionId =[json[@"data"][@"tsUser"][@"collectionId"] integerValue];
//                taobaoShopInformationmodel.shopInformationID =[json[@"data"][@"tsUser"][@"id"] integerValue];
//                taobaoShopInformationmodel.phone = json[@"data"][@"tsUser"][@"phone"];
//                taobaoShopInformationmodel.shopLogo = json[@"data"][@"tsUser"][@"shopLogo"];
//                taobaoShopInformationmodel.shopName = json[@"data"][@"tsUser"][@"shopName"];
//                taobaoShopInformationmodel.userType = json[@"data"][@"tsUser"][@"userType"];
//                taobaoShopInformationmodel.status =[json[@"data"][@"tsUser"][@"status"] integerValue];
//                taobaoShopInformationmodel.area = json[@"data"][@"tsUser"][@"area"];
//                taobaoShopInformationmodel.createTime = json[@"data"][@"tsUser"][@"createTime"];
//                taobaoShopInformationmodel.identityId = json[@"data"][@"tsUser"][@"identityId"];
//                taobaoShopInformationmodel.sysUserId = [json[@"data"][@"tsUser"][@"sysUserId"] integerValue];
//                taobaoShopInformationmodel.updateTime = json[@"data"][@"tsUser"][@"updateTime"];
//                taobaoShopInformationmodel.volume = json[@"data"][@"tsUser"][@"volume"];
//                taobaoShopInformationmodel.weight = json[@"data"][@"tsUser"][@"weight"];
//
//                taobaoUserLikemodel.tsUsermodel = taobaoShopInformationmodel;
//                RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                taobaoUserLikemodel.videoAndPicturemodel = videoAndPicturemodel;
//                taobaoUserLikemodel.videoAndPicturemodel.imageId = [json[@"data"][@"video"][@"imageId"]integerValue];
//                taobaoUserLikemodel.videoAndPicturemodel.videoId = [json[@"data"][@"video"][@"videoId"]integerValue];
//                taobaoUserLikemodel.videoAndPicturemodel.imageUrl = json[@"data"][@"video"][@"imageUrl"];
//                taobaoUserLikemodel.videoAndPicturemodel.videoUrl = json[@"data"][@"video"][@"videoUrl"];
//

                weakSelf.taobaoUserLikemodel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"imageList"]];
//
                
                
                //                NSMutableArray * temp = [NSMutableArray array];
//                temp = json[@"data"][@"stoneDtlList"];
//                NSMutableArray * dabanTemp = [NSMutableArray array];
//                for (int j = 0; j < temp.count; j++) {
//                    RSTaobaoStoneDtlModel * taobaoStoneDtlmodel = [[RSTaobaoStoneDtlModel alloc]init];
//                    taobaoStoneDtlmodel.blockNo = [[temp objectAtIndex:j]objectForKey:@"blockNo"];
//                    taobaoStoneDtlmodel.height = [[temp objectAtIndex:j]objectForKey:@"height"];
//                    taobaoStoneDtlmodel.StoneDtlID = [[[temp objectAtIndex:j]objectForKey:@"StoneDtlID"]integerValue];
//                    taobaoStoneDtlmodel.inventoryId = [[temp objectAtIndex:j]objectForKey:@"inventoryId"];
//                    taobaoStoneDtlmodel.length = [[temp objectAtIndex:j]objectForKey:@"length"];
//                    taobaoStoneDtlmodel.stoneType = [[temp objectAtIndex:j]objectForKey:@"stoneType"];
//                    taobaoStoneDtlmodel.volume = [[temp objectAtIndex:j]objectForKey:@"volume"];
//                    taobaoStoneDtlmodel.warehouseName = [[temp objectAtIndex:j]objectForKey:@"warehouseName"];
//                    taobaoStoneDtlmodel.weight = [[temp objectAtIndex:j]objectForKey:@"weight"];
//                    taobaoStoneDtlmodel.width = [[temp objectAtIndex:j]objectForKey:@"width"];
//                    taobaoStoneDtlmodel.area = [[temp objectAtIndex:j]objectForKey:@"area"];
//                    taobaoStoneDtlmodel.dedArea = [[temp objectAtIndex:j]objectForKey:@"dedArea"];
//                    taobaoStoneDtlmodel.preArea = [[temp objectAtIndex:j]objectForKey:@"preArea"];
//                    taobaoStoneDtlmodel.turnQty = [[[temp objectAtIndex:j]objectForKey:@"turnQty"]integerValue];
//                    taobaoStoneDtlmodel.turnNo = [[temp objectAtIndex:j]objectForKey:@"turnNo"];
//                    if ([taobaoUserLikemodel.stockType isEqualToString:@"huangliao"]) {
//                        [taobaoUserLikemodel.stoneDtlList addObject:taobaoStoneDtlmodel];
//                    }else{
//                        [dabanTemp addObject:taobaoStoneDtlmodel];
//                    }
//                }
                
                if ([weakSelf.taobaoUserLikemodel.stockType isEqualToString:@"daban"]) {
                    NSMutableArray * dabanTemp = [RSTaobaoStoneDtlModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"stoneDtlList"]];
                    weakSelf.taobaoUserLikemodel.stoneDtlList = [weakSelf changeArrayRule:dabanTemp];
                }else{
                    weakSelf.taobaoUserLikemodel.stoneDtlList = [RSTaobaoStoneDtlModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"stoneDtlList"]];
                }
//                NSMutableArray * imageArray = [NSMutableArray array];
//                imageArray = json[@"data"][@"imageList"];
//                for (int j = 0; j < imageArray.count; j++) {
//                    RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                    videoAndPicturemodel.imageId = [[[imageArray objectAtIndex:j]objectForKey:@"imageId"]integerValue];
//                    videoAndPicturemodel.videoId = [[[imageArray objectAtIndex:j]objectForKey:@"videoId"]integerValue];
//                    videoAndPicturemodel.imageUrl = [[imageArray objectAtIndex:j]objectForKey:@"imageUrl"];
//                    videoAndPicturemodel.videoUrl = [[imageArray objectAtIndex:j]objectForKey:@"videoUrl"];
//                    [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
//                }
//                weakSelf.taobaoUserLikemodel = taobaoUserLikemodel;
                [weakSelf setCustomHeaderView:weakSelf.taobaoUserLikemodel];
                [weakSelf setCustomBottomView:weakSelf.taobaoUserLikemodel];
                [weakSelf.tableview reloadData];
                
            }else{
                //[SVProgressHUD showErrorWithStatus:@"获取失败"];
                
                [JHSysAlertUtil presentAlertViewWithTitle:@"提示" message:@"该商品已下架?" cancelTitle:@"确定" defaultTitle:@"取消" distinct:true cancel:^{
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"fairReload" object:nil];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } confirm:^{
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"fairReload" object:nil];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}







- (void)setCustomHeaderView:(RSTaoBaoUserLikeModel *)taobaoUserlikemodel{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 393)];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    //视频
    self.video = [[TSVideoPlayback alloc] initWithFrame:CGRectMake(0, 0, SCW, 275)];
    self.video.delegate = self;
    
    NSMutableArray * array = [NSMutableArray array];
    if (taobaoUserlikemodel.video.videoId != 0) {
        [array addObject:taobaoUserlikemodel.video.videoUrl];
        for (int i = 0; i < taobaoUserlikemodel.imageList.count; i++) {
            RSTaobaoVideoAndPictureModel * videoAndPicturemodel = taobaoUserlikemodel.imageList[i];
            [array addObject:videoAndPicturemodel.imageUrl];
        }
        [self.video setWithIsVideo:TSDETAILTYPEVIDEO andDataArray:array];
    }else{
        for (int i = 0; i < taobaoUserlikemodel.imageList.count; i++) {
            RSTaobaoVideoAndPictureModel * videoAndPicturemodel = taobaoUserlikemodel.imageList[i];
            [array addObject:videoAndPicturemodel.imageUrl];
        }
        [self.video setWithIsVideo:TSDETAILTYPEIMAGE andDataArray:array];
    }
    [headerView addSubview:self.video];
    
    
    //返回
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"商店返回"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(13, 29, 32, 32);
    [headerView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(upforceViewController:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn bringSubviewToFront:headerView];
    
    //分享
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"商店分享"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(SCW - 12 - 32, 29, 32, 32);
    [headerView addSubview:shareBtn];
    [shareBtn bringSubviewToFront:headerView];
    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //类型
    UIView * typeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.video.frame), SCW, 67)];
    typeView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:typeView];
    
    UIImageView * typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 8, 28, 15)];
    //淘宝荒料
    
    if ([taobaoUserlikemodel.stockType isEqualToString:@"huangliao"]) {
         typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
    }else{
        typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
    }
    [typeView addSubview:typeImageView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeImageView.frame) + 7, 5, SCW - CGRectGetMaxX(typeImageView.frame) - 7, 21)];
    
    nameLabel.text = [NSString stringWithFormat:@"%@",taobaoUserlikemodel.stoneName];
    
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    [typeView addSubview:nameLabel];
    
    
    //符号
    UILabel * symbolLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(typeImageView.frame) + 18, 8, 17)];
    symbolLabel.font = [UIFont systemFontOfSize:12];
    symbolLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    symbolLabel.textAlignment = NSTextAlignmentCenter;
    symbolLabel.text = @"¥";
    [typeView addSubview:symbolLabel];
    
    //当前的价格
    UILabel * currentLabel = [[UILabel alloc]init];
    currentLabel.textAlignment = NSTextAlignmentLeft;
    currentLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    currentLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:24];
    //currentLabel.text = @"69/m²";
    
    if ([taobaoUserlikemodel.stockType isEqualToString:@"huangliao"]) {
        if ([taobaoUserlikemodel.unit isEqualToString:@"立方米"]) {
             currentLabel.text = [NSString stringWithFormat:@"%@/m³",taobaoUserlikemodel.price];
        }else{
             currentLabel.text = [NSString stringWithFormat:@"%@/吨",taobaoUserlikemodel.price];
        }
    }else{
        currentLabel.text = [NSString stringWithFormat:@"%@/m²",taobaoUserlikemodel.price];
    }
    
    CGRect rect = [currentLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 34)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]} context:nil];
    
    currentLabel.frame = CGRectMake(CGRectGetMaxX(symbolLabel.frame) + 3, CGRectGetMaxY(nameLabel.frame) + 2, rect.size.width + 5, 34);
    
    [typeView addSubview:currentLabel];
    
    //原来的价格
    //打折价钱
    UILabel * discountPriceLabel = [[UILabel alloc]init];
    discountPriceLabel.textAlignment = NSTextAlignmentLeft;
    //discountPriceLabel.text = @"¥248/m²";
    if ([taobaoUserlikemodel.stockType isEqualToString:@"huangliao"]) {
        if ([taobaoUserlikemodel.unit isEqualToString:@"立方米"]) {
             discountPriceLabel.text = [NSString stringWithFormat:@"¥%@/m³",taobaoUserlikemodel.originalPrice];
        }else{
             discountPriceLabel.text = [NSString stringWithFormat:@"¥%@/吨",taobaoUserlikemodel.originalPrice];
        }
    }else{
        discountPriceLabel.text = [NSString stringWithFormat:@"¥%@/m²",taobaoUserlikemodel.originalPrice];
    }
    discountPriceLabel.font = [UIFont systemFontOfSize:12];
    discountPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:discountPriceLabel.text attributes:attribtDic];
    discountPriceLabel.attributedText = attribtStr;
    
    CGRect rect2 = [discountPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    discountPriceLabel.frame = CGRectMake(CGRectGetMaxX(currentLabel.frame) + 10, 41, rect2.size.width, 17);
    [typeView addSubview:discountPriceLabel];
    
    
    //剩余
    UILabel * surplusLabel = [[UILabel alloc]init];
    if ([taobaoUserlikemodel.stockType isEqualToString:@"huangliao"]) {
        if ([taobaoUserlikemodel.unit isEqualToString:@"立方米"]) {
              surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm³",[taobaoUserlikemodel.inventory floatValue]];
        }else{
              surplusLabel.text = [NSString stringWithFormat:@"余%0.3lf吨",[taobaoUserlikemodel.weight floatValue]];
        }
    }else{
        surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm²",[taobaoUserlikemodel.inventory floatValue]];
    }
    //surplusLabel.text = @"余234m³";
    
    
    
    CGRect rect1 = [surplusLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 21)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    surplusLabel.textAlignment = NSTextAlignmentRight;
    surplusLabel.font = [UIFont systemFontOfSize:15];
    surplusLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    surplusLabel.frame = CGRectMake(SCW - 12 - rect1.size.width, 36, rect1.size.width, 21);
    [typeView addSubview:surplusLabel];
    
    
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeView.frame), SCW, 51)];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:contentView];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 7)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    [contentView addSubview:topView];
    
    
    
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(topView.frame) + 12, SCW - 24, 20)];
    detailLabel.text = @"详细内容";
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    detailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [contentView addSubview:detailLabel];
    
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(12, contentView.yj_height - 1, SCW - 24, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [contentView addSubview:bottomview];
    
    
    //[headerView setupAutoHeightWithBottomView:contentView bottomMargin:0];
    //[headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}

#pragma mark - TSVideoPlaybackDelegate
-(void)videoView:(TSVideoPlayback *)view didSelectItemAtIndexPath:(NSInteger)index andTap:(UITapGestureRecognizer *)tap
{
    //NSLog(@"%ld",(long)index);
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < self.taobaoUserLikemodel.imageList.count; i++) {
        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = self.taobaoUserLikemodel.imageList[i];
        [array addObject:videoAndPicturemodel.imageUrl];
    }
    view.placeholderImg.image = [UIImage imageNamed:@""];
    [HUPhotoBrowser showFromImageView:view.placeholderImg withURLStrings:array atIndex:index - 1];
}


//返回上一个界面
- (void)upforceViewController:(UIButton *)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setCustomBottomView:(RSTaoBaoUserLikeModel *)taobaoUserlikemodel{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - 132, SCW, 132)];
    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:bottomView];
    [bottomView bringSubviewToFront:self.view];
    
    
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 7)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    [bottomView addSubview:midView];
    
    //店面
    UIImageView * imageview = [[UIImageView alloc]init];
    
    
    //nameLabel.text = @"唐";
    
    //nameLabel.text = [NSString stringWithFormat:@"%@",[taobaoUserlikemodel.tsUsermodel.shopName substringToIndex:1]];
    [imageview sd_setImageWithURL:[NSURL URLWithString:taobaoUserlikemodel.tsUser.shopLogo] placeholderImage:[UIImage imageNamed:@"512"]];
    
    
    imageview.frame = CGRectMake(13, 19, 49, 49);
    
    imageview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    [bottomView addSubview:imageview];
    
    imageview.layer.cornerRadius = 4;
    imageview.layer.masksToBounds = YES;
    
    //详细名称
    UILabel * detailNameLabel = [[UILabel alloc]init];
    //detailNameLabel.text = @"大唐石业";
    
    detailNameLabel.text = [NSString stringWithFormat:@"%@",taobaoUserlikemodel.tsUser.shopName];
    
    detailNameLabel.frame = CGRectMake(CGRectGetMaxX(imageview.frame) + 9, 29, SCW/2 - CGRectGetMaxX(imageview.frame), 20);
    detailNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
   // detailNameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#000000"];
    detailNameLabel.textAlignment = NSTextAlignmentLeft;
    detailNameLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:detailNameLabel];
    
    //地址
    UILabel * addressLabel = [[UILabel alloc]init];
    //addressLabel.text = @"南安市水头";
    addressLabel.text = [NSString stringWithFormat:@"%@",taobaoUserlikemodel.tsUser.address];
    
    
    addressLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.frame = CGRectMake(CGRectGetMaxX(imageview.frame) + 9, CGRectGetMaxY(detailNameLabel.frame), SCW/2 - CGRectGetMaxX(imageview.frame), 17);
    [bottomView addSubview:addressLabel];
    
    
    
    //投诉
    UIButton * complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [complaintBtn setTitle:@"投诉" forState:UIControlStateNormal];
    [complaintBtn setTitleColor:[UIColor colorWithHexColorStr:@"#F61E23"] forState:UIControlStateNormal];
    complaintBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    complaintBtn.frame = CGRectMake(SCW - 129, 32, 41, 24);
    [bottomView addSubview:complaintBtn];
    [complaintBtn addTarget:self action:@selector(taoBaoComplainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    complaintBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#F3191D"].CGColor;
    complaintBtn.layer.borderWidth = 0.5;
    complaintBtn.layer.cornerRadius = 12;
    
    
    //进店逛逛
    UIButton * inShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inShopBtn setTitle:@"进店逛逛" forState:UIControlStateNormal];
    [inShopBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    inShopBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [inShopBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
    inShopBtn.frame = CGRectMake(CGRectGetMaxX(complaintBtn.frame) + 9, 32, 65, 24);
    [bottomView addSubview:inShopBtn];
    [inShopBtn addTarget:self action:@selector(inShopAction:) forControlEvents:UIControlEventTouchUpInside];
    inShopBtn.layer.cornerRadius = 12;
    
    
    //收藏
    UIButton * collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (taobaoUserlikemodel.collectionId > 0) {
        //已经收藏了
        [collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        [collectionBtn setImage:[UIImage imageNamed:@"淘宝已收藏"] forState:UIControlStateNormal];
    }else{
        //没有收藏
        [collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [collectionBtn setImage:[UIImage imageNamed:@"guanzhu商品复制"] forState:UIControlStateNormal];
    }
    [collectionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [collectionBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353A42"]];
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    collectionBtn.frame = CGRectMake(0, 83, 124, 49);
    [collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectionBtn];
    _collectionBtn = collectionBtn;
    
    collectionBtn.titleLabel.sd_layout
    .centerXEqualToView(collectionBtn)
    .centerYEqualToView(collectionBtn)
    .leftSpaceToView(collectionBtn.imageView, 4)
    .widthIs(124);
    
    
    //联系卖家
    UIButton * contactSellersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contactSellersBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
    [contactSellersBtn setImage:[UIImage imageNamed:@"商店电话"] forState:UIControlStateNormal];
    [contactSellersBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [contactSellersBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF4B33"]];
    contactSellersBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    contactSellersBtn.frame = CGRectMake(CGRectGetMaxX(collectionBtn.frame), 83, SCW - CGRectGetMaxX(collectionBtn.frame), 49);
    [contactSellersBtn addTarget:self action:@selector(contactSellersAction:) forControlEvents:UIControlEventTouchUpInside];
    contactSellersBtn.titleLabel.sd_layout
    .centerXEqualToView(contactSellersBtn)
    .centerYEqualToView(contactSellersBtn)
    .leftSpaceToView(contactSellersBtn.imageView, 4)
    .widthIs(SCW - CGRectGetMaxX(collectionBtn.frame));
    
    [bottomView addSubview:contactSellersBtn];
    
    
}




//收藏
- (void)collectionAction:(UIButton *)collectionBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
       if (VERIFYKEY.length < 1) {
           RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
           loginVc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:loginVc animated:YES];
       }else{
           if ([collectionBtn.currentTitle isEqualToString:@"收藏"]) {
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
    [phoneDict setObject:@"stone" forKey:@"type"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.taobaoUserLikemodel.userLikeID] forKey:@"collId"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.taobaoUserLikemodel.collectionId] forKey:@"collectionId"];
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
                if ([_collectionBtn.currentTitle isEqualToString:@"收藏"]) {
                    weakSelf.taobaoUserLikemodel.collectionId = [json[@"data"] integerValue];
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    [_collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                    [_collectionBtn setImage:[UIImage imageNamed:@"淘宝已收藏"] forState:UIControlStateNormal];
                    [dict setValue:@"attention" forKey:@"status"];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                    [_collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
                    [_collectionBtn setImage:[UIImage imageNamed:@"guanzhu商品复制"] forState:UIControlStateNormal];
                    [dict setValue:@"noattention" forKey:@"status"];
                }
                [dict setValue:@"stone" forKey:@"type"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updateSCData" object:dict];
            }else{
                [SVProgressHUD showErrorWithStatus:@"操作失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"操作失败"];
        }
    }];
}


//联系卖家
- (void)contactSellersAction:(UIButton *)contactSellersBtn{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.taobaoUserLikemodel.tsUser.phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)setUITableviewFootView{

    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 58)];
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    //展示全部
    RSAllMessageUIButton * allShowBtn = [RSAllMessageUIButton buttonWithType:UIButtonTypeCustom];
    [allShowBtn setTitle:@"展示全部" forState:UIControlStateNormal];
    [allShowBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [allShowBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    [allShowBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    allShowBtn.frame = CGRectMake(12, 10, SCW - 24, 38);
    allShowBtn.imageView.sd_layout
    .leftSpaceToView(allShowBtn.titleLabel,3)
    .centerYEqualToView(allShowBtn)
    .heightIs(8)
    .widthIs(14);
    allShowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [footView addSubview:allShowBtn];
    _allShowBtn = allShowBtn;
    [allShowBtn addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tableview.tableFooterView = footView;
   
}

//展示全部，还是展示部分
- (void)openAction:(UIButton *)allShowBtn{
    allShowBtn.selected = !allShowBtn.selected;
    if (allShowBtn.selected) {
        [allShowBtn setTitle:@"关闭全部" forState:UIControlStateNormal];
    }else{
        [allShowBtn setTitle:@"展示全部" forState:UIControlStateNormal];
    }
    [self.tableview reloadData];
}

//分享
- (void)shareAction:(UIButton *)shareBtn{
     NSArray *shareButtonTitleArray = nil;
     NSArray *shareButtonImageNameArray = nil;
     shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
     shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
     LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andTaobaoUserListModel:self.taobaoUserLikemodel];
     [lxActivity showInView:self.view];
}

- (void)didClickOnmageIndex:(NSInteger *)imageIndex andTaobaoShare:(RSTaoBaoUserLikeModel *)taobaoUserlistmodel{
    [RSWeChatShareTool weChatShareStylemageIndex:imageIndex andTaobao:taobaoUserlistmodel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.taobaoUserLikemodel.stoneDtlList.count > 2) {
        _allShowBtn.hidden = NO;
    }else{
        _allShowBtn.hidden = YES;
    }
    if (self.taobaoUserLikemodel.stoneDtlList.count > 2) {
        return self.allShowBtn.selected == true ? self.taobaoUserLikemodel.stoneDtlList.count : 2;
    }else{
        return self.taobaoUserLikemodel.stoneDtlList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 187;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TAOBAOPRODETIALCELLID = @"TAOBAOPRODETIALCELLID";
    if ([self.taobaoUserLikemodel.stockType isEqualToString:@"huangliao"]) {
        RSTaoBaoProductDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOPRODETIALCELLID];
        if (!cell) {
            cell = [[RSTaoBaoProductDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOPRODETIALCELLID];
        }
        
        RSTaobaoStoneDtlModel * taobaoStoneDtlmodel = self.taobaoUserLikemodel.stoneDtlList[indexPath.row];
        cell.taobaoStoneDtlmodel = taobaoStoneDtlmodel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        RSTaoBaoProductDetailSLCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOPRODETIALCELLID];
        if (!cell) {
            cell = [[RSTaoBaoProductDetailSLCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOPRODETIALCELLID];
        }
        
        
        NSMutableArray * array = self.taobaoUserLikemodel.stoneDtlList[indexPath.row];
        
        RSTaobaoStoneDtlModel * taobaoStoneDtlmodel = array[0];
        cell.blockNoLabel.text = [NSString stringWithFormat:@"%@",taobaoStoneDtlmodel.blockNo];
        cell.typeDetailLabel.text = [NSString stringWithFormat:@"%@",taobaoStoneDtlmodel.stoneType];
        cell.numberDetailLabel.text = [NSString stringWithFormat:@"%ld",array.count];
        NSString * str = [NSString string];
        str = @"0.000";
        for (int i = 0; i < array.count; i++) {
            RSTaobaoStoneDtlModel * taobaoStoneDtlmodel = array[i];
            str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoStoneDtlmodel.area floatValue]]];
        }
        cell.areaDetailLabel.text = str;
        cell.checkBtn.tag = indexPath.row;
        cell.addressDetailLabel.text = [NSString stringWithFormat:@"%@",taobaoStoneDtlmodel.warehouseName];
        [cell.checkBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

//查看
- (void)checkAction:(RSAllMessageUIButton *)checkBtn{
    RSTaoBaoSLDetailView * contactsAction = [[RSTaoBaoSLDetailView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    NSMutableArray * array = self.taobaoUserLikemodel.stoneDtlList[checkBtn.tag];
    contactsAction.delegate = self;
    contactsAction.contactsArray = array;
    //contactsAction.usermodel = usermodel;
    [self.view addSubview:contactsAction];
}


//进店逛逛
- (void)inShopAction:(UIButton *)inShopBtn{
    RSTaoBaoShopViewController * taoBaoShopVc = [[RSTaoBaoShopViewController alloc]init];
    taoBaoShopVc.taobaoUsermodel = self.taobaoUsermodel;
    taoBaoShopVc.tsUserId = self.taobaoUserLikemodel.tsUserId;
    [self.navigationController pushViewController:taoBaoShopVc animated:YES];
}


- (void)hideCurrentShowView:(RSTaoBaoSLDetailView *)contactsActionView{
    [contactsActionView removeFromSuperview];
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return YES;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}


//投诉
- (void)taoBaoComplainAction:(UIButton *)complainBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1) {
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        RSTaobaoComplaintViewController * taoBaoComplainVc = [[RSTaobaoComplaintViewController alloc]init];
        taoBaoComplainVc.taobaoUsermodel = self.taobaoUsermodel;
        taoBaoComplainVc.productid = self.taobaoUserLikemodel.userLikeID;
        taoBaoComplainVc.tsUserId = self.taobaoUserLikemodel.tsUserId;
        [self.navigationController pushViewController:taoBaoComplainVc animated:YES];
    }
}


- (NSMutableArray *)changeArrayRule:(NSArray *)contentarray{
    NSMutableArray *dateMutablearray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
    for (int i = 0; i < array.count; i ++) {
        //NSString *string = array[i];
        RSTaobaoStoneDtlModel * taobaoStoneDtlmodel = array[i];
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:taobaoStoneDtlmodel];
        for (int j = i+1;j < array.count; j ++) {
            RSTaobaoStoneDtlModel * taobaoStoneDtlmodel1 = array[j];
            if([taobaoStoneDtlmodel1.blockNo isEqualToString:taobaoStoneDtlmodel.blockNo]){
                [tempArray addObject:taobaoStoneDtlmodel1];
                [array removeObjectAtIndex:j];
                j = j - 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    return dateMutablearray;
}


//相加
- (NSString *)calculateNumberByAdding:(NSString *)number1 secondNumber:(NSString *)number2{
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber * addNum = [num1 decimalNumberByAdding:num2 withBehavior:Handler];
    return [addNum stringValue];
}


- (void)dealloc{
    [self.video removeFromSuperview];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
