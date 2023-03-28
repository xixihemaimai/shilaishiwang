//
//  RSSLStoragemanagementModel.h
//  石来石往
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSLStoragemanagementModel : NSObject
//大板入库
/**单据ID*/
@property (nonatomic,assign)NSInteger billid;
/**明细ID*/
@property (nonatomic,assign)NSInteger billdtlid;
/**物料ID*/
@property (nonatomic,assign)NSInteger mtlId;
/**物料类别ID*/
@property (nonatomic,assign)NSInteger mtltypeId;
/**库区ID*/
@property (nonatomic,assign)NSInteger storeareaId;
/**数量*/
@property (nonatomic,assign)NSInteger qty;
/**荒料编号*/
@property (nonatomic,strong)NSString * blockNo;
/**匝号*/
@property (nonatomic,strong)NSString * turnsNo;
/**板号*/
@property (nonatomic,strong)NSString * slNo;
/**板号*/
//@property (nonatomic,strong)NSString * SLockNo;
/**物料名称*/
@property (nonatomic,strong)NSString * mtlName;
/**物料类别名称*/
@property (nonatomic,strong)NSString * mtltypeName;
/**库区名称*/
@property (nonatomic,strong)NSString * storeareaName;
/**长*/
@property (nonatomic,strong)NSDecimalNumber * length;
/**宽*/
@property (nonatomic,strong)NSDecimalNumber * width;
/**厚*/
@property (nonatomic,strong)NSDecimalNumber * height;
/**重量*/
@property (nonatomic,strong)NSDecimalNumber * weight;

/**原始面积*/
@property (nonatomic,strong)NSDecimalNumber * preArea;
/**扣尺面积*/
@property (nonatomic,strong)NSDecimalNumber * dedArea;
/**实际面积*/
@property (nonatomic,strong)NSDecimalNumber * area;
/**扣尺长1*/
@property (nonatomic,strong)NSDecimalNumber * dedLengthOne;
/**扣尺宽1*/
@property (nonatomic,strong)NSDecimalNumber * dedWidthOne;
/**扣尺长2*/
@property (nonatomic,strong)NSDecimalNumber * dedLengthTwo;
/**扣尺宽2*/
@property (nonatomic,strong)NSDecimalNumber * dedWidthTwo;
/**扣尺长3*/
@property (nonatomic,strong)NSDecimalNumber * dedLengthThree;
/**扣尺宽3*/
@property (nonatomic,strong)NSDecimalNumber * dedWidthThree;
/**扣尺长4*/
@property (nonatomic,strong)NSDecimalNumber * dedLengthFour;
/**扣尺宽4*/
@property (nonatomic,strong)NSDecimalNumber * dedWidthFour;

//自己加的
@property (nonatomic,assign)BOOL isbool;

//大板出库新增
/**库存标识*/
@property (nonatomic,assign)NSInteger did;
/**入库类型*/
@property (nonatomic,strong)NSString * storageType;
/**入库时间*/
@property (nonatomic,strong)NSString * receiptDate;
/**是否冻结*/
@property (nonatomic,assign)NSInteger isfrozen;
/**仓库名称*/
@property (nonatomic,strong)NSString * whsName;
/**仓库ID*/
@property (nonatomic,assign)NSInteger whsId;

@property (nonatomic,assign)BOOL isSelect;



//异常处理 新增的值
/**物料ID新*/
@property (nonatomic,assign)NSInteger mtlInId;
/**物料类别ID 新*/
@property (nonatomic,assign)NSInteger mtltypeInId;
/**长  新*/
@property (nonatomic,strong)NSDecimalNumber * lengthIn;
/**宽 新*/
@property (nonatomic,strong)NSDecimalNumber * widthIn;
/**厚 新*/
@property (nonatomic,strong)NSDecimalNumber * heightIn;
/**原始面积 新*/
@property (nonatomic,strong)NSDecimalNumber * preAreaIn;
/**扣尺面积 新*/
@property (nonatomic,strong)NSDecimalNumber * dedAreaIn;
/**实际面积 新*/
@property (nonatomic,strong)NSDecimalNumber * areaIn;
/**物料名称 新*/
@property (nonatomic,strong)NSString * mtlInName;
/**物料类别名称 新*/
@property (nonatomic,strong)NSString * mtltypeInName;

/**调拨*/
@property (nonatomic,assign)NSInteger storeareaInId;

@end

NS_ASSUME_NONNULL_END
