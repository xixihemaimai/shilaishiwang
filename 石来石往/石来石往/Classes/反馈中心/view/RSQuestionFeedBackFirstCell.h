//
//  RSQuestionFeedBackFirstCell.h
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol RSQuestionFeedBackFirstCellDelegate<NSObject>


- (void)currentSelectQuestionBtnTitle:(NSString *)title;

@end




@interface RSQuestionFeedBackFirstCell : UITableViewCell


@property (nonatomic,weak)id<RSQuestionFeedBackFirstCellDelegate>delegate;

@end
