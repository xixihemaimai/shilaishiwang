//
//  RSAccountAlertView.h
//  石来石往
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAccountDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSAccountAlertView : UIView

@property (nonatomic,strong)RSAccountDetailModel * accountDetailmodel;



-(void)showView;
-(void)closeView;

@end

NS_ASSUME_NONNULL_END
