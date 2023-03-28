//
//  RSHuangFristViewController.h
//  石来石往
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAllHuangAndDaViewController.h"

#import "RSUserModel.h"


@interface RSHuangFristViewController : RSAllHuangAndDaViewController


@property (nonatomic,strong)RSUserModel * userModel;

/**判断是大板还是荒料的情况*/
@property (nonatomic,strong)NSString * searchType;

/**搜索的内容*/
@property (nonatomic,strong)NSString * searchStr;








@end
