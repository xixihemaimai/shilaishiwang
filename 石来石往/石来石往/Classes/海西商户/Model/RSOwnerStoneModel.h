//
//  RSOwnerStoneModel.h
//  石来石往
//
//  Created by mac on 2021/12/15.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOwnerStoneModel : NSObject
/**
 String ownerPhone;//货主电话
 String mtlClass;//石材类别
 String mtlType;//库存类别  1荒料  2大板
 String deaName;//货主名称
 String deaCode;//货主代码
 String mtlName;//石种名称
 String location;//储位描述

 
 */
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, copy) NSString *deaCode;
@property (nonatomic, copy) NSString *deaName;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *mtlClass;
@property (nonatomic, copy) NSString *mtlCode;
@property (nonatomic, copy) NSString *mtlName;
@property (nonatomic, copy) NSString *mtlType;
@property (nonatomic, copy) NSString *ownerName;
@property (nonatomic, copy) NSString *ownerPhone;
@property (nonatomic, copy) NSString *stoneImageUrl;
@property (nonatomic,assign)CGFloat height;

@end

NS_ASSUME_NONNULL_END
