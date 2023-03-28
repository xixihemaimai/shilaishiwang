//
//  RSCasesModel.h
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSCasesModel : NSObject


/**
 Long enterpriseId; 企业ID
 Long caseCategoryId; 案例类别ID
 String subject;主题
 String notes;案例介绍
 String enterpriseNameCn; 企业名称
 String caseCategoryNameCn; 案例类别名称
 
 
 List<String> urlList; 首页图URL列表
 List<String> stoneUrlList;用料图URL列表
 */

@property (nonatomic, assign)NSInteger enterpriseId;
@property (nonatomic, assign)NSInteger caseCategoryId;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, copy) NSString *enterpriseNameCn;
@property (nonatomic, copy) NSString *caseCategoryNameCn;

@property (nonatomic,assign)NSInteger imageIdentityId;
@property (nonatomic,assign)NSInteger stoneIdentityId;
@property (nonatomic, copy) NSString * logoUrl;
@property (nonatomic,assign)NSInteger caseId;

@property (nonatomic, strong) NSArray<NSString *> *urlList;
@property (nonatomic, strong) NSArray<NSString *> *stoneUrlList;

@end

NS_ASSUME_NONNULL_END
