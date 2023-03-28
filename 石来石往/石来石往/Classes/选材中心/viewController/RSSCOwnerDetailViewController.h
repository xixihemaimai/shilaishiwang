//
//  RSSCOwnerDetailViewController.h
//  石来石往
//
//  Created by mac on 2021/10/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSAllViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSCOwnerDetailViewController : RSAllViewController
//企业id
@property (nonatomic,assign)NSInteger enterpriseId;
//石材名称
@property (nonatomic,copy)NSString * stoneName;
//石材类型
@property (nonatomic,copy)NSString * stoneType;

//网络请求
- (void)loadSCContentStoneNamePageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead andEnterpriseId:(NSInteger)enterpriseId andStoneName:(NSString *)stoneName andStoneType:(NSString *)stoneType;

//荒料和大板
- (void)newStoneSearchPageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead andStoneName:(NSString *)stoneName;

@end

NS_ASSUME_NONNULL_END
