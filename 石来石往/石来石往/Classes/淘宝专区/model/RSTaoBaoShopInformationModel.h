//
//  RSTaoBaoShopInformationModel.h
//  石来石往
//
//  Created by mac on 2019/9/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoShopInformationModel : NSObject
/**
area = "1516.27";
createTime = "2019-09-10 13:53:36";
identityId = 45d8eca8e2e44f87956c2d8f31b34920;
sysUserId = 10;
updateTime = "2019-09-26 11:06:54";
volume = "143829.305";
 */
@property (nonatomic,strong)NSString * shopName;

@property (nonatomic,assign)NSInteger  shopInformationID;

@property (nonatomic,assign)NSInteger  collectionId;

@property (nonatomic,strong)NSDecimalNumber * area;

@property (nonatomic,strong)NSDecimalNumber * volume;


@property (nonatomic,strong)NSString * shopLogo;

@property (nonatomic,strong)NSString * phone;

@property (nonatomic,strong)NSString * address;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * userType;


@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,strong)NSString * identityId;
@property (nonatomic,assign)NSInteger sysUserId;
@property (nonatomic,strong)NSString * updateTime ;


@property (nonatomic,strong)NSDecimalNumber * weight;


@end

NS_ASSUME_NONNULL_END
