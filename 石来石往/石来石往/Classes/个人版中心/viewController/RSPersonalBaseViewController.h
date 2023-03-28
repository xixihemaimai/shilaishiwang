//
//  RSPersonalBaseViewController.h
//  石来石往
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSPersonalBaseViewController : RSAllViewController

//@property (nonatomic,strong)UITableView * tableview;


- (NSString *)delSpaceAndNewline:(NSString *)string;

- (NSString *)showCurrentTime;

- (NSDate *)nsstringConversionNSDate:(NSString *)dateStr;

- (NSString *)time_dateToString:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
