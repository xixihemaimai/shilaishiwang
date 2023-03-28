//
//  RSDetailsOfOsakaViewController.h
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDetailsOfDifferentViewController.h"
@interface RSDetailsOfOsakaViewController : RSDetailsOfDifferentViewController


/**起始时间*/
@property (nonatomic,strong)NSString * datefrom;

/**截止时间*/
@property (nonatomic,strong)NSString * dateto;

@end
