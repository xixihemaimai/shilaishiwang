//
//  RSLocationModel.h
//  石来石往
//
//  Created by mac on 2021/12/5.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSLocationModel : NSObject

@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lon;
@property (nonatomic, copy) NSString *nameCn;
@property (nonatomic, copy) NSString *nameEn;


@end

NS_ASSUME_NONNULL_END
