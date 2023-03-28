//
//  RSTaoBaoMangementModel.h
//  石来石往
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSTaobaoVideoAndPictureModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoMangementModel : NSObject

@property (nonatomic,strong)NSString * createTime;


@property (nonatomic,assign)NSInteger mangementID;

@property (nonatomic,strong)NSString * identityId;


@property (nonatomic,strong)NSDecimalNumber * inventory;

@property (nonatomic,strong)NSDecimalNumber * originalPrice;


@property (nonatomic,strong)NSDecimalNumber * price;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * stockType;
@property (nonatomic,strong)NSString * stoneName;
@property (nonatomic,strong)NSString * tsUserId;
@property (nonatomic,strong)NSString * updateTime;


@property (nonatomic,strong)NSMutableArray * imageList;


@property (nonatomic,assign)NSInteger isComplete;

//视频缩列图

@property (nonatomic,strong)RSTaobaoVideoAndPictureModel * videoAndPicturemodel;
//@property (nonatomic,strong)NSString * imageUrl;
//@property (nonatomic,strong)NSString * videoUrl;
//@property (nonatomic,assign)NSInteger imageId;
//@property (nonatomic,assign)NSInteger videoId;


@property (nonatomic,strong)NSMutableArray * stoneDtlList;



//新增计价单位
@property (nonatomic,strong)NSString * unit;

//新增总重量
@property (nonatomic,strong)NSDecimalNumber * weight;

@end

NS_ASSUME_NONNULL_END
