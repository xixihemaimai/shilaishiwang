//
//  RSPersonalWkWebviewViewController.h
//  石来石往
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSPersonalWkWebviewViewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;


@property (nonatomic,strong)NSString * dateFrom;

@property (nonatomic,strong)NSString * dateTo;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,assign)NSInteger mtlId;

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * whsName;

@property (nonatomic,strong)NSString * storageType;

@property (nonatomic,assign)NSInteger whsId;

@property (nonatomic,assign)NSInteger isFrozen;

@property (nonatomic,assign)NSInteger lengthType;

@property (nonatomic,assign)NSInteger widthType;

@property (nonatomic,strong)NSString * length;

@property (nonatomic,strong)NSString * width;

@property (nonatomic,strong)NSString * slNo;

@property (nonatomic,strong)NSString * turnsNo;


/**（1：ios  2：安卓）*/
@property (nonatomic,assign)NSInteger appType;
//1荒料库存余额表 2荒料入库明细表 3荒料出库明细表
//4大板库存余额表 5大板入库明细表 6大板出库明细表
@property (nonatomic,assign)NSInteger pageType;
@property (nonatomic,strong)NSString * VerifyKey;
@property (nonatomic,assign)NSInteger totalQty;// 查询后总片数
@property (nonatomic,strong)NSDecimalNumber * totalVaQty;//查询后总面积

@property (nonatomic,strong)NSString * webStr;


/**网址*/
@property (nonatomic,strong)NSString * ulrStr;
//分享类型
@property (nonatomic,strong)NSString * typeStr;

//判断值 -- 1为报表
@property (nonatomic,assign)NSInteger showT;



//报表中心的数组
@property (nonatomic,strong)NSMutableArray * selectArray;


@end


NS_ASSUME_NONNULL_END
