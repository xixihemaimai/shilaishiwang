//
//  RSBLSpotModel.h
//  石来石往
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSBLSpotModel : NSObject

@property (nonatomic,strong)NSDecimalNumber * height;
@property (nonatomic,strong)NSDecimalNumber * length;
@property (nonatomic,strong)NSDecimalNumber * volume;
@property (nonatomic,strong)NSDecimalNumber * weight;
@property (nonatomic,strong)NSDecimalNumber * width;

@property (nonatomic,assign)NSInteger did;
@property (nonatomic,assign)NSInteger qty;

@property (nonatomic,assign)BOOL isfrozen;
@property (nonatomic,assign)NSInteger mtlId;

@property (nonatomic,assign)NSInteger mtltypeId;
@property (nonatomic,assign)NSInteger whsId;
@property (nonatomic,assign)NSInteger storeareaId;
@property (nonatomic,assign)NSInteger pwmsUserId;



@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * mtltypeName;

@property (nonatomic,strong)NSString * receiptDate;

@property (nonatomic,strong)NSString * storageType;

@property (nonatomic,strong)NSString * whsName;

/**自己添加的属性*/
//@property (nonatomic,assign)BOOL isSelected;


@end

NS_ASSUME_NONNULL_END
