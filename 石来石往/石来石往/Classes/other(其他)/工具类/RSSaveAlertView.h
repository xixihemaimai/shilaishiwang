//
//  RSSaveAlertView.h
//  石来石往
//
//  Created by mac on 2019/2/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSaveAlertView : UIView

@property (nonatomic,strong)NSString * totalNumber;

@property (nonatomic,strong)NSString * totalArea;

@property (nonatomic,strong)NSString * totalWeight;

@property (nonatomic,strong)NSString * totalDedArea;

@property (nonatomic,strong)NSString * totalPreArea;


@property (nonatomic,strong)NSString * selectType;
/**选择的类型*/
@property (nonatomic,strong)NSString * selectFunctionType;


-(void)showView;
-(void)closeView;

@end

NS_ASSUME_NONNULL_END
