//
//  RSImageListModel.h
//  石来石往
//
//  Created by mac on 2022/9/1.
//  Copyright © 2022 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSImageListModel : NSObject

@property (nonatomic,copy)NSString * identityId;

@property (nonatomic,copy)NSString * urlOrigin;

@property (nonatomic,copy)NSString * url;

//identityId = 051b579db53244969f5e8974739a27a3;
//url = "/slsw/attachment/20220326132640QQE59BBEE7898720211211022515_mini.jpg";
//urlOrigin = "/slsw/attachment/20220326132640QQE59BBEE7898720211211022515.jpg";

@end

NS_ASSUME_NONNULL_END
