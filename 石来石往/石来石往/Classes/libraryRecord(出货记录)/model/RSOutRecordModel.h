//
//  RSOutRecordModel.h
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSOutRecordModel : NSObject

/**出货类型*/
@property (nonatomic,strong)NSString * OUT_TYPE;
/**出货的时间*/
@property (nonatomic,strong)NSString * outstoreDate;
/**出货的单号*/
@property (nonatomic,strong)NSString * outstoreId;
/**出货的状态*/
@property (nonatomic,strong)NSString * outstoreStatus;

/**出货的详情信息*/
@property (nonatomic,strong)NSArray * bolcks;

/**提货人的名字*/
@property (nonatomic,strong)NSString * csnName;
/**提货人的电话号码*/
@property (nonatomic,strong)NSString * csnPhone;

/**二维码的样式*/
@property (nonatomic,strong)NSString * qrCode;
/**服务的状态*/
@property (nonatomic,strong)NSString * servicestatus;

/**判断提货人可以不可修改*/
@property (nonatomic,strong)NSString * scnStatus;

/**汽车类型*/
@property (nonatomic,strong)NSString * carType;





@end
