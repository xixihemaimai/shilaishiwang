//
//  RSADPictureModel.h
//  石来石往
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSADPictureModel : NSObject

@property (nonatomic,copy)NSString * blockTotalMessage;

@property (nonatomic,copy)NSString * erpId;

@property (nonatomic,copy)NSString * erpName;

@property (nonatomic,copy)NSString * plateTotalMessage;
@property (nonatomic,copy)NSString * stoneTypeNum;

@property (nonatomic,strong)NSArray * sliderImgs;

@end

NS_ASSUME_NONNULL_END
