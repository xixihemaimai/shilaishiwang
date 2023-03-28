//
//  RSSCContentModel.h
//  石来石往
//
//  Created by mac on 2021/12/5.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSLocationModel.h"
#import "RSImageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSCContentModel : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *contactNumber;
@property (nonatomic, assign) NSInteger enterpriseId;
@property (nonatomic, copy) NSString *enterpriseNameCn;
@property (nonatomic, copy) NSString *exhibitionLocation;
@property (nonatomic, assign) NSInteger sccontentId;
@property (nonatomic, strong) RSLocationModel *location;
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, copy) NSString *stoneIdentityId;
@property (nonatomic, copy) NSString *stoneName;
@property (nonatomic, copy) NSString *stoneType;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *urlOrigin;


@property (nonatomic,strong)NSMutableArray<RSImageListModel *> * imageList;



@end

NS_ASSUME_NONNULL_END
