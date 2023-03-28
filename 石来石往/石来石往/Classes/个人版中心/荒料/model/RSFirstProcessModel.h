//
//  RSFirstProcessModel.h
//  石来石往
//
//  Created by mac on 2019/7/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSFirstProcessModel : NSObject


/**
 {"data":{"billdtlid":284981,"createTime":1561519332540,"createUser":171,"id":1,"processName":"包胶","processStatus":1,"processTime":1558800000000},"status":0,"success":true}
 
 */

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,assign)NSInteger billdtlid;

@property (nonatomic,strong)NSString * createUser;

@property (nonatomic,strong)NSString * processName;

@property (nonatomic,strong)NSString * processTime;

@property (nonatomic,assign)NSInteger processId;

@property (nonatomic,assign)NSInteger processStatus;

@end

NS_ASSUME_NONNULL_END
