//
//  RSCaseTypeModel.h
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSNewCompanyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSCaseTypeModel : NSObject
@property (nonatomic, assign) NSInteger caseTypeId;
@property (nonatomic, copy) NSString *nameCn;
@property (nonatomic, copy) NSString *nameEn;
@property (nonatomic, copy) NSString *url;

@property (nonatomic,strong)RSNewSencondCompanyModel * attachment;


@end

NS_ASSUME_NONNULL_END
