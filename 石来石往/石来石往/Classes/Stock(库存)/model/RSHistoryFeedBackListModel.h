//
//  RSHistoryFeedBackListModel.h
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSImageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSHistoryFeedBackListModel : NSObject

@property (nonatomic,copy)NSString * contactNumber;

@property (nonatomic,copy)NSString * content;

@property (nonatomic,copy)NSString * createTime;

@property (nonatomic,copy)NSString * updateTime;

@property (nonatomic,copy)NSString * historyId;

@property (nonatomic,copy)NSString * imageIdentityId;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSMutableArray<RSImageListModel *> * imageList;


@end



NS_ASSUME_NONNULL_END
