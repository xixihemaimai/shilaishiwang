//
//  RSRightModel.h
//  石来石往
//
//  Created by mac on 17/6/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSRightModel : NSObject

////获取出库和入库的时间
//@property (nonatomic,strong)NSString *billtime;
////获取货主的ID
//@property (nonatomic,strong)NSString *deacode;
////获取货主名称
//@property (nonatomic,strong)NSString *deaname;
////获取石材图片
//@property (nonatomic,strong)NSString * imgUrl;
////获取石材信息，平方米
//@property (nonatomic,strong)NSString * message;
////获取数量
//@property (nonatomic,strong)NSString *num;
////获取石种
//@property (nonatomic,strong)NSString *mtlname;
////获取类型
//@property (nonatomic,assign)NSInteger type;
////获取物种类型
//@property (nonatomic,strong)NSString *mtltype;


/**荒料入库数量*/
@property (nonatomic,strong)NSString * blockInstoreNum;
/**荒料入库面积*/
@property (nonatomic,strong)NSString * blockInstoreVolume;
/**荒料出库数量*/
@property (nonatomic,strong)NSString * blockOutstoreNum;
/**荒料出库面积*/
@property (nonatomic,strong)NSString * blockOutstoreVolume;
/**大板入库*/
@property (nonatomic,strong)NSString * plateInstoreNum;
/**大板入库面积*/
@property (nonatomic,strong)NSString * plateInstoreArea;
/**大板出库数量*/
@property (nonatomic,strong)NSString * plateOutstoreNum;
/**大板出库面积*/
@property (nonatomic,strong)NSString * plateOutstoreArea;
/**时间*/
@property (nonatomic,strong)NSString * time;


@end
