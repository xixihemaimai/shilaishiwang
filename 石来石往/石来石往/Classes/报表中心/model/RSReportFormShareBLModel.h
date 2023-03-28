//
//  RSReportFormShareBLModel.h
//  石来石往
//
//  Created by mac on 2020/2/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSReportFormShareBLModel : NSObject


/**
 标识
 did
 Int
 货主名称
 deaName
 String
 园区荒料号
 msid
 String
 客户荒料号
 csid
 String
 石种名称
 mtlname
 String
 石种类别
 materialtype
 String
 长(mm)
 lenght
 Int
 宽（mm）
 width
 Int
 高（mm）
 height
 Int
 体积
 volume
 Decimal
 吨数
 weight
 Decimal
 仓库
 whsname
 String
 库区
 storeareaname
 String
 储位
 locationname
 String
 */
/**标识*/
@property (nonatomic,assign)NSInteger did;
/**货主名称*/
@property (nonatomic,strong)NSString * deaName;
/**货主code*/
@property (nonatomic,strong)NSString * deacode;
/**园区荒料号*/
@property (nonatomic,strong)NSString * msid;
/**客户荒料号*/
@property (nonatomic,strong)NSString * csid;
/**石种名称*/
@property (nonatomic,strong)NSString * mtlname;
/**石种类别*/
@property (nonatomic,strong)NSString * materialtype;

@property (nonatomic,strong)NSString * mtlcode;
/**长(mm)*/
@property (nonatomic,assign)NSInteger lenght;
/**宽（mm*/
@property (nonatomic,assign)NSInteger width;
/**高（mm）*/
@property (nonatomic,assign)NSInteger height;
/**体积*/
@property (nonatomic,strong)NSDecimalNumber * volume;
/**吨数*/
@property (nonatomic,strong)NSDecimalNumber * weight;
/**仓库*/
//@property (nonatomic,strong)NSString * whsname;
/**库区*/
@property (nonatomic,strong)NSString * storeareaname;
/**储位*/
@property (nonatomic,strong)NSString * locationname;
/**片*/
@property (nonatomic,assign)NSInteger qty;

@property (nonatomic,assign)NSInteger n;

/**入库仓库或者出口仓库*/
@property (nonatomic,copy)NSString * whsname;
/**入库时间或者出库时间*/
@property (nonatomic,copy)NSString * billdate;
/**入库类型   storageType*/
@property (nonatomic,copy)NSString * storageType;
/**出库类型  storageOutType*/
@property (nonatomic,copy)NSString * storageOutType;


@end

NS_ASSUME_NONNULL_END
