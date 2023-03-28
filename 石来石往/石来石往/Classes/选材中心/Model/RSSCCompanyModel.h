//
//  RSSCCompanyModel.h
//  石来石往
//
//  Created by mac on 2021/12/5.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSCCompanyModel : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *contactNumber1;
@property (nonatomic, copy) NSString *contactNumber2;
@property (nonatomic, copy) NSString *contacts;
@property (nonatomic, assign)NSInteger sccompanyId;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *mainBusiness;
@property (nonatomic, copy) NSString *nameCn;
@property (nonatomic, copy) NSString *nameEn;
@property (nonatomic, copy) NSString *operatingStores;
@property (nonatomic, assign) NSInteger sysUserId;
@property (nonatomic, copy) NSString *sysUserName;
@property (nonatomic, copy) NSString *sysUserPhone;
@property (nonatomic, strong) NSArray<NSString *> *urlList;
@end

NS_ASSUME_NONNULL_END
