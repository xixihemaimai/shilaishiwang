//
//  RSRunningAccountCloseCell.h
//  石来石往
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSRunningAccountBaseCell.h"
#import "RSBalanceModel.h"
#import "RSAccountDetailModel.h"
NS_ASSUME_NONNULL_BEGIN


@protocol RSRunningAccountCloseCellDelegate <NSObject>

- (void)clickOpenDetialContentCurrentCellIndex:(NSInteger)cellIndex andContentArrIndex:(NSInteger)index;

@end


@interface RSRunningAccountCloseCell : UITableViewCell


@property (nonatomic,strong)RSBalanceModel * balancemodel;

@property (nonatomic,strong)UIButton * bottomBtn;


@property (nonatomic,strong)UIImageView * accountOpenImageView;

@property (nonatomic,weak)id<RSRunningAccountCloseCellDelegate>delegate;

//- (void)setView:(NSString *)selectFunctionType;

@end

NS_ASSUME_NONNULL_END
