//
//  RSSCCompanyViewController.h
//  石来石往
//
//  Created by mac on 2021/10/30.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSCCompanyViewController : YNPageViewController


+ (instancetype)suspendCenterPageVCWithEnterpriseId:(NSInteger)enterpriseId;


//+ (instancetype)suspendCenterPageVCUserModel:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr;

@end

NS_ASSUME_NONNULL_END
