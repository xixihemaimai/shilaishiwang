//
//  RSAlreadyRatingViewController.h
//  石来石往
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAlreadyRatingViewController : UIViewController
//获取是按大板还是按照荒料
@property (nonatomic,strong)NSString *choiceStyle;

//获取父控制器中的搜索框中的内容
@property (nonatomic,strong)UITextField * searchTextfield;


- (void)getStoneHasBeenRatedSearchNoNullString;
@end
