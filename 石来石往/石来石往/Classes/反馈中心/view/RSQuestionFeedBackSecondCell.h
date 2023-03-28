//
//  RSQuestionFeedBackSecondCell.h
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol RSQuestionFeedBackSecondCellDelegate <NSObject>

- (void)inputTextViewContent:(NSString *)contentStr;


@end

@interface RSQuestionFeedBackSecondCell : UITableViewCell

@property (nonatomic,weak)id<RSQuestionFeedBackSecondCellDelegate>delegate;

@end
