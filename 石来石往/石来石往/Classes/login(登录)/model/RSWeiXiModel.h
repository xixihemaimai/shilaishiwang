//
//  RSWeiXiModel.h
//  石来石往
//
//  Created by mac on 17/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSWeiXiModel : NSObject
/**微信的QQ号*/
@property (nonatomic,strong)NSString * openid;
/**微信的昵称*/
@property (nonatomic,strong)NSString * nickname;
/**微信的性别*/
@property (nonatomic,strong)NSString * sex;
/**微信的省份*/
@property (nonatomic,strong)NSString * province;
/**微信的城市*/
@property (nonatomic,strong)NSString * city;
/**微信的国家*/
@property (nonatomic,strong)NSString * country;
/**微信的头像的图片*/
@property (nonatomic,strong)NSString * headimgurl;
/**微信的特权*/
@property (nonatomic,strong)NSArray * privilege;
/**微信的unionid*/
@property (nonatomic,strong)NSString * unionid;
/**微信的语言*/
@property (nonatomic,strong)NSString * language;


/**微信的方式*/

//@property (nonatomic,strong)NSString * grant_type;

@end
