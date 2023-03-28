//
//  RSNewCompanyModel.h
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSNewSencondCompanyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSNewCompanyModel : NSObject

@property (nonatomic, copy) NSString *category;
@property (nonatomic, assign) NSInteger enterpriseId;
@property (nonatomic, assign) NSInteger newCompanyId;
@property (nonatomic, copy) NSString *nameCn;
@property (nonatomic, copy) NSString *nameEn;
@property (nonatomic,strong)RSNewSencondCompanyModel * attachment;
@end

NS_ASSUME_NONNULL_END
