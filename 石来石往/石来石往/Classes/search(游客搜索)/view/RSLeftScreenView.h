//
//  RSLeftScreenView.h
//  石来石往
//
//  Created by mac on 2017/7/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YBScreenCell;
@protocol RSLeftScreenViewDelegate <NSObject>

//荒料
- (void)screeningConditionStr1:(NSString *)tempStr1 andStr2:(NSString *)tempStr2 andStr3:(NSString *)tempStr3 andStr4:(NSString * )tempStr4 andBtn1:(NSString *)btnStr1 andBtn2:(NSString *)btnStr2 andBtn3:(NSString *)btnStr3 andBtnStr4:(NSString *)btnStr4 andYBScreenCell:(YBScreenCell *)cell andSearchType:(NSString *)searchType;


//大板
- (void)dabanscreeningConditionStr1:(NSString *)tempStr1 andStr2:(NSString *)tempStr2 andStr3:(NSString *)tempStr3 andStr4:(NSString * )tempStr4 andBtn1:(NSString *)btnStr1 andBtn2:(NSString *)btnStr2 andBtn3:(NSString *)btnStr3 andBtnStr4:(NSString *)btnStr4 andYBScreenCell:(YBScreenCell *)cell andSearchType:(NSString *)searchType;



@end


@interface RSLeftScreenView : UIView

@property (nonatomic,weak)id<RSLeftScreenViewDelegate>delegate;


@property (nonatomic,strong)YBScreenCell * cell;


@property (nonatomic,strong)UITableView * tableview;

/**判断是大板还是荒料的情况*/
@property (nonatomic,strong)NSString * searchType;



/**假的*/
@property (nonatomic,strong)UICollectionView * collectionview;



@end
