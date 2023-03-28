//
//  RSRunningAccountBaseCell.h
//  石来石往
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBalanceModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger) {
    CLOSE  = 0, //关闭
    OPEN  = 1, //打开
}BtnType;

@class RSRunningAccountBaseCell;

@protocol RSRunningAccountBaseCellDelegate <NSObject>

/** 选中按钮点击 */
- (void)baseCell:(RSRunningAccountBaseCell *)baseCell btnType:(BtnType)btnType WithIndex:(int)index withArr:(NSMutableArray *)array withOpenArr:(NSMutableArray *)openArr;


@end



@interface RSRunningAccountBaseCell : UITableViewCell


@property (nonatomic, weak) id <RSRunningAccountBaseCellDelegate> delegate;


@property (nonatomic, assign) BtnType btnType;

@property (nonatomic,strong)RSBalanceModel * balancemodel;

/**
 点击的是哪一个cell上的按钮
 */
@property(assign,nonatomic)int index;

/**
 记录每个cell上的按钮状态
 */
@property(strong,nonatomic)NSMutableArray * indexArr;


/**记录每个cell展开的有多少单的数组*/
@property (nonatomic,strong)NSMutableArray * openArr;
//- (void)setView:(NSString *)selectFunctionType;

@end


NS_ASSUME_NONNULL_END
