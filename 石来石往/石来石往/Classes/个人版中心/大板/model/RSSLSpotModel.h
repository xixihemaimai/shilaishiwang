//
//  RSSLSpotModel.h
//  石来石往
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSLSpotModel : NSObject

@property (nonatomic,strong)NSString * blockNo;


@property (nonatomic,strong)NSDecimalNumber * height;

@property (nonatomic,strong)NSDecimalNumber * length;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * mtltypeName;

@property (nonatomic,assign)NSInteger totalQty;


@property (nonatomic,strong)NSDecimalNumber * totalVaQty;
@property (nonatomic,strong)NSString * turnsNo;
@property (nonatomic,strong)NSDecimalNumber * width;


//自己加的值
@property (nonatomic,assign)NSInteger did;

@end

NS_ASSUME_NONNULL_END
