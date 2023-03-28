//
//  RSThirdProcessModel.h
//  石来石往
//
//  Created by mac on 2019/7/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSThirdProcessModel : NSObject

/**
 filePath = "/slsw/process/854967/20190701143237image.png";
 */


@property (nonatomic,assign)NSInteger billdtlid;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * createUser;

@property (nonatomic,assign)NSInteger processId;

@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * filePath;


@end

NS_ASSUME_NONNULL_END
