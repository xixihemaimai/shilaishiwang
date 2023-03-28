//
//  RSChoiceFreeServiceModel.h
//  石来石往
//
//  Created by mac on 2018/4/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDispatchPersonDataModel.h"


@interface RSChoiceFreeServiceModel : NSObject

/**ID*/
@property (nonatomic,strong)NSString * ID;

/**空闲服务人员的名字*/
@property (nonatomic,strong)NSString * USER_NAME;
/**空闲服务人员是否有被派遣服务*/
@property (nonatomic,assign)BOOL isChose;
/**空闲服务人员的电话号码*/
@property (nonatomic,strong)NSString * user_phone;

@property (nonatomic,strong)RSDispatchPersonDataModel * dispatchpersonlmodel;
@end
