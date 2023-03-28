//
//  RSDirverContact.h
//  石来石往
//
//  Created by mac on 17/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSDirverContact : NSObject
/**司机的姓名*/
@property (nonatomic,strong)NSString *csnName;
/**司机的手机号码*/
@property (nonatomic,strong)NSString *csnPhone;

@property (nonatomic,strong)NSString * erpId;


@property (nonatomic,strong)NSString * erpUserCode;

///**司机的身份证号*/
//@property (nonatomic,strong)NSString *idCard;
///**司机的车牌号*/
//@property (nonatomic,strong)NSString * license;
/**司机的ID*/
@property (nonatomic,strong)NSString * driverID;



// 提供快速创建对象的类方法
//+ (instancetype)contactWithDriverName:(NSString *)name andaphonNumber:(NSString *)phoneNumbebr andIdentity:(NSString *)identity andCarCord:(NSString *)carCord;

@end
