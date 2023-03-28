//
//  RSSCCompanyHeaderContactModel.h
//  石来石往
//
//  Created by mac on 2021/12/11.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSCCompanyHeaderContactModel : NSObject

/**
 contactManName = "\U77f3\U6750\U57ce1\U53f7";
 contactNumber = 18060911209;
 enterpriseId = 7288345473318915;
 */

@property (nonatomic,strong)NSString * contactManName;

@property (nonatomic,strong)NSString * contactNumber;

@property (nonatomic,assign)NSInteger enterpriseId;


@end

NS_ASSUME_NONNULL_END
