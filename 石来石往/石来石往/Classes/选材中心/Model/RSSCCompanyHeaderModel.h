//
//  RSSCCompanyHeaderModel.h
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSLocationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSCCompanyHeaderModel : NSObject
@property (nonatomic, copy) NSString *address;

//List<EnterpriseMan> enterpriseManList;   联系人列表
//List<EnterpriseStore> enterpriseStoreList;   门店列表


//@property (nonatomic, copy) NSString *contactNumber1;
//@property (nonatomic, copy) NSString *contactNumber2;
//@property (nonatomic, copy) NSString *operatingStores;

@property (nonatomic, copy) NSString *contacts;
@property (nonatomic, assign) NSInteger companyHeaderId;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *mainBusiness;
@property (nonatomic, copy) NSString *nameCn;
@property (nonatomic, copy) NSString *nameEn;
@property (nonatomic,assign)NSInteger collectionState;

@property (nonatomic, assign)NSInteger sysUserId;
@property (nonatomic, strong)NSString * backgroundUrl;
@property (nonatomic,strong)NSArray<NSString *> * urlList;
@property (nonatomic,strong)RSLocationModel *location;

@property (nonatomic,strong)NSMutableArray * enterpriseManList;

@property (nonatomic,strong)NSMutableArray * enterpriseStoreList;



@end

NS_ASSUME_NONNULL_END
