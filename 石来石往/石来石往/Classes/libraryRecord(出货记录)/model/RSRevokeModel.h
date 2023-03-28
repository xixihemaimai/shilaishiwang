//
//  RSRevokeModel.h
//  石来石往
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRevokeModel : NSObject


@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,assign)NSInteger createUserId;
@property (nonatomic,strong)NSString * createUserName;
@property (nonatomic,assign)NSInteger revokeId;
@property (nonatomic,strong)NSString *  optDescribe;
@property (nonatomic,assign)NSInteger optStatus;
@property (nonatomic,strong)NSString * optType;
@property (nonatomic,strong)NSString * outBoundNo;



@end

NS_ASSUME_NONNULL_END
