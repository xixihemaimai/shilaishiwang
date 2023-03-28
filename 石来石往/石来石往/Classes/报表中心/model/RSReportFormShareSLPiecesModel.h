//
//  RSReportFormShareSLPiecesModel.h
//  石来石往
//
//  Created by mac on 2020/2/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSReportFormShareSLPiecesModel : NSObject

/**实际面积*/
@property (nonatomic,strong)NSDecimalNumber * area;
/**客户荒料号*/
@property (nonatomic,strong)NSString * csid;
/**货主名称*/
@property (nonatomic,strong)NSString * deaName;
/**货主名称code*/
@property (nonatomic,strong)NSString * deacode;
/**扣尺长度4*/
@property (nonatomic,strong)NSDecimalNumber * ded_length_four;
/**扣尺长度1*/
@property (nonatomic,strong)NSDecimalNumber * ded_length_one;
/**扣尺长度3*/
@property (nonatomic,strong)NSDecimalNumber * ded_length_three;
/**扣尺长度2*/
@property (nonatomic,strong)NSDecimalNumber * ded_length_two;
/**扣尺宽度4*/
@property (nonatomic,strong)NSDecimalNumber * ded_wide_four;
/**扣尺宽度1*/
@property (nonatomic,strong)NSDecimalNumber * ded_wide_one;
/**扣尺宽度3*/
@property (nonatomic,strong)NSDecimalNumber * ded_wide_three;
/**扣尺宽度2*/
@property (nonatomic,strong)NSDecimalNumber * ded_wide_two;
/**扣尺面积*/
@property (nonatomic,strong)NSDecimalNumber * dedarea;
/**标识*/
@property (nonatomic,assign)NSInteger did;
/**高*/
@property (nonatomic,assign)NSInteger height;
/**长*/
@property (nonatomic,assign)NSInteger lenght;
/**宽*/
@property (nonatomic,assign)NSInteger width;

/**储位*/
@property (nonatomic,strong)NSString * locationname;
/**石种类别*/
@property (nonatomic,strong)NSString * materialtype;
/**园区荒料号*/
@property (nonatomic,strong)NSString * msid;

@property (nonatomic,strong)NSString * mtlcode;
/**石种名称*/
@property (nonatomic,strong)NSString * mtlname;

@property (nonatomic,assign)NSInteger  n;

/**原始面积*/
@property (nonatomic,strong)NSDecimalNumber * prearea;
/**片*/
@property (nonatomic,assign)NSInteger  qty;
/**片号*/
@property (nonatomic,strong)NSString * slno;
/**库区*/
@property (nonatomic,strong)NSString * storeareaname;
/**匝号*/
@property (nonatomic,strong)NSString * turnsno;
/**仓库*/
@property (nonatomic,strong)NSString * whsname;

//自己加
@property (nonatomic,assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
