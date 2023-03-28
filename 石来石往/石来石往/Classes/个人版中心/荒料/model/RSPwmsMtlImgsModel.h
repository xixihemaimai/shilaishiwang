//
//  RSPwmsMtlImgsModel.h
//  石来石往
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSPwmsMtlImgsModel : NSObject


@property (nonatomic,assign)NSInteger status;

@property (nonatomic,assign)NSInteger pwmsUserId;
@property (nonatomic,assign)NSInteger PwmsMtlImgsId;
@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,strong)NSString * fileName;
@property (nonatomic,strong)NSString * mtlName;
@property (nonatomic,strong)NSString * path;
@property (nonatomic,strong)NSString * stockType;
@property (nonatomic,strong)NSString * turnsNo;

@end

NS_ASSUME_NONNULL_END
