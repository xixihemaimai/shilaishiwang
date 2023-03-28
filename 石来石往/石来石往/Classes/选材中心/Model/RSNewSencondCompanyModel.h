//
//  RSNewSencondCompanyModel.h
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSNewSencondCompanyModel : NSObject

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, assign) NSInteger fileSize;
@property (nonatomic, copy) NSString *fileType;
@property (nonatomic, assign) NSInteger newSecondCompanyId;
@property (nonatomic, copy) NSString *identityId;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *urlOrigin;

@end

NS_ASSUME_NONNULL_END
