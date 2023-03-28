//
//  RSTaoBaoBannerModel.h
//  石来石往
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoBannerModel : NSObject

@property (nonatomic,strong)NSString * discount;

@property (nonatomic,strong)NSString * endTime;

@property (nonatomic,strong)NSString * imageUrl;

@property (nonatomic,strong)NSString * jumpType;

@property (nonatomic,strong)NSString * originalPrice;

@property (nonatomic,strong)NSString * price;

@property (nonatomic,strong)NSString * shopName;

@property (nonatomic,strong)NSString * startTime;

@property (nonatomic,strong)NSString * stoneName;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,assign)NSInteger jumpId;


@property (nonatomic,assign)NSInteger bannerID;

@end

NS_ASSUME_NONNULL_END
