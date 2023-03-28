//
//  RSAccountDetailModel.h
//  石来石往
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAccountDetailModel : NSObject



@property (nonatomic,assign)NSInteger mtlId;
@property (nonatomic,assign)NSInteger mtlInId;
@property (nonatomic,assign)NSInteger mtltypeId;
@property (nonatomic,assign)NSInteger whsId;
@property (nonatomic,assign)NSInteger whsInId;


/**单据日期*/
@property (nonatomic,strong)NSString * billDate;
/**单据名称*/
@property (nonatomic,strong)NSString * billName;
/**单据编号*/
@property (nonatomic,strong)NSString * billNo;
/**单据类型*/
@property (nonatomic,strong)NSString * billType;
/**单据ID*/
@property (nonatomic,assign)NSInteger billid;
/**物料名称*/
@property (nonatomic,strong)NSString * mtlName;
/**物料名称新*/
@property (nonatomic,strong)NSString * mtlInName;
/** 物料类别名称*/
@property (nonatomic,strong)NSString * mtltypeName;
/**荒料号*/
@property (nonatomic,strong)NSString * blockNo;
/**长*/
@property (nonatomic,strong)NSDecimalNumber * length;
/**宽*/
@property (nonatomic,strong)NSDecimalNumber * width;
/**高*/
@property (nonatomic,strong)NSDecimalNumber * height;
/**体积*/
@property (nonatomic,strong)NSDecimalNumber * volume;
/**重量*/
@property (nonatomic,strong)NSDecimalNumber * weight;
/**长 新*/
@property (nonatomic,strong)NSDecimalNumber * lengthIn;
/**宽 新*/
@property (nonatomic,strong)NSDecimalNumber * widthIn;
/**高 新*/
@property (nonatomic,strong)NSDecimalNumber * heightIn;
/**体积 新*/
@property (nonatomic,strong)NSDecimalNumber * volumeIn;
/**重量 新*/
@property (nonatomic,strong)NSDecimalNumber * weightIn;
/**入库类型*/
@property (nonatomic,strong)NSString * storageType;
/**入库日期*/
@property (nonatomic,strong)NSString * receiptDate;
/** 仓库名称*/
@property (nonatomic,strong)NSString * whsName;
/**异常处理类型*/
@property (nonatomic,strong)NSString * abType;
/**调入仓库名称*/
@property (nonatomic,strong)NSString * whsInName;

/**唯一标示号*/
@property (nonatomic,assign)NSInteger did;
/**异常处理需要的数组*/
@property (nonatomic,strong)NSMutableArray * billDetailVos;

/**qty*/
@property (nonatomic,assign)NSInteger qty;
/**storeareaId*/
@property (nonatomic,assign)NSInteger storeareaId;

/*
 billDetailVos =                 (
 {
 billDetailVos =                         (
 );
 billid = 113620;
 blockNo = re1;
 did = 113462;
 height = 12;
 length = 12;
 mtlId = 113;
 mtlName = "\U9ed1\U91d1\U82b1";
 mtltypeId = 1;
 mtltypeName = "\U5b89\U5c71\U77f3";
 qty = 1;
 receiptDate = "2019-04-24";
 storageType = CGRK;
 storeareaId = 0;
 volume = "0.002";
 weight = 12;
 whsId = 81;
 width = 12;
 },
 {
 billDetailVos =                         (
 );
 billid = 113620;
 blockNo = re2;
 did = 113462;
 height = 12;
 length = 12;
 mtlId = 113;
 mtlName = "\U9ed1\U91d1\U82b1";
 mtltypeId = 1;
 mtltypeName = "\U5b89\U5c71\U77f3";
 qty = 1;
 receiptDate = "2019-04-24";
 storageType = CGRK;
 storeareaId = 0;
 volume = "0.002";
 weight = 12;
 whsId = 81;
 width = 12;
 },
 {
 billDetailVos =                         (
 );
 billid = 113620;
 blockNo = re3;
 did = 113462;
 height = 12;
 length = 12;
 mtlId = 113;
 mtlName = "\U9ed1\U91d1\U82b1";
 mtltypeId = 1;
 mtltypeName = "\U5b89\U5c71\U77f3";
 qty = 1;
 receiptDate = "2019-04-24";
 storageType = CGRK;
 storeareaId = 0;
 volume = "0.002";
 weight = 12;
 whsId = 81;
 width = 12;
 }
 );
 
 
 */



@end

NS_ASSUME_NONNULL_END
