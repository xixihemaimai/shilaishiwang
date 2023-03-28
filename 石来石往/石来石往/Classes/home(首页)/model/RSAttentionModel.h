//
//  RSAttentionModel.h
//  石来石往
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAttentionModel : NSObject

/**关注的Logo*/
@property (nonatomic,strong)NSString * userLogo;

/**关注的名字*/
@property (nonatomic,strong)NSString * userName;

/**关注的类型*/
@property (nonatomic,strong)NSString * userType;

/**关注的ID*/
@property (nonatomic,strong)NSString * attentionID;

/**关注的方式*/
@property (nonatomic,strong)NSString * attStatus;

@end
