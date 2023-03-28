//
//  RSPrintModel.h
//  石来石往
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPrintModel : NSObject
/**发起时间*/
@property (nonatomic,strong)NSString * outDate;
/**出库类别SL 大板  BL 荒料*/
@property (nonatomic,strong)NSString * outType;
/**出库单号*/
@property (nonatomic,strong)NSString * outbountNo;
/**货主名称*/
@property (nonatomic,strong)NSString * ownerName;
/**页码*/
@property (nonatomic,assign)NSInteger pageNum;
/**总体积/面积*/
@property (nonatomic,strong)NSString * sumVaqty;
/**总颗数/片数*/
@property (nonatomic,strong)NSString * totalQty;

/**表明细*/
@property (nonatomic,strong)NSMutableArray * bolcks;

/**出库单号*/
@property (nonatomic,strong)NSString * erpOutboundNo;

@end
