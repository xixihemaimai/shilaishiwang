//
//  RSReportFormShareSLModel.h
//  石来石往
//
//  Created by mac on 2020/2/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSReportFormShareSLModel : NSObject

/**
 area = "2.608";
 csid = "ACX-905";
 deaName = "\U56db\U946b\U77f3\U4e1a";
 materialtype = "\U5927\U7406\U77f3";
 msid = HXAC000247A;
 mtlname = "\U827e\U65af\U7c73\U9ec4";
 n = 1;
 pieces =                 (

 
 */
/**面积*/
@property (nonatomic,strong)NSDecimalNumber * area;


/**客户荒料号*/
@property (nonatomic,strong)NSString * csid;
/**货主名称*/
@property (nonatomic,strong)NSString * deaName;
/**石种类别*/
@property (nonatomic,strong)NSString * materialtype;
/**园区荒料号*/
@property (nonatomic,strong)NSString * msid;
/**石种名称*/
@property (nonatomic,strong)NSString * mtlname;

@property (nonatomic,assign)NSInteger  n;
/**片数*/
@property (nonatomic,assign)NSInteger  qty;
/**匝号*/
@property (nonatomic,strong)NSString * turnsno;
/**有多少片*/
@property (nonatomic,strong)NSMutableArray * pieces;


@end

NS_ASSUME_NONNULL_END
