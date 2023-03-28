//
//  RSTaoBaoUserLikeModel.h
//  石来石往
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSTaobaoVideoAndPictureModel.h"
#import "RSTaoBaoShopInformationModel.h"
#import "RSTaobaoStoneDtlModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoUserLikeModel : NSObject

@property (nonatomic,assign)NSInteger actId;

@property (nonatomic,assign)NSInteger collectionId;

@property (nonatomic,strong)NSString * discount;


@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,assign)NSInteger userLikeID;

@property (nonatomic,strong)NSString * identityId;


@property (nonatomic,strong)NSMutableArray * imageList;

@property (nonatomic,strong)NSDecimalNumber * inventory;

@property (nonatomic,assign)NSInteger isComplete;
@property (nonatomic,strong)NSDecimalNumber * originalPrice;
@property (nonatomic,strong)NSDecimalNumber * price;
@property (nonatomic,assign)NSInteger qty;

@property (nonatomic,strong)NSString * shopName;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * stockType;

@property (nonatomic,strong)NSString * stoneName;

@property (nonatomic,assign)NSInteger tsUserId;

@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,strong)NSString * imageUrl;


@property (nonatomic,strong)NSString * unit;

@property (nonatomic,strong)NSDecimalNumber * weight;


@property (nonatomic,strong)NSMutableArray * stoneDtlList;

//店铺信息
@property (nonatomic,strong)RSTaoBaoShopInformationModel * tsUser;

//视频缩列图

@property (nonatomic,strong)RSTaobaoVideoAndPictureModel * video;


@end

NS_ASSUME_NONNULL_END
