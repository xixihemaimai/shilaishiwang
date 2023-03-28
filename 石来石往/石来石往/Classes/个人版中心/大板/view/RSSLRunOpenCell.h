//
//  RSSLRunOpenCell.h
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLRunningDetialModel.h"
#import "RSAccountDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol RSSLRunOpenCellDelegate <NSObject>

- (void)clickOpenDetialContentCurrentCellIndex:(NSInteger)cellIndex andContentArrIndex:(NSInteger)index;

@end

@interface RSSLRunOpenCell : UITableViewCell


@property (nonatomic,strong)UIButton * bottomBtn;

@property (nonatomic,strong)RSSLRunningDetialModel * balancemodel;

@property (nonatomic,strong)UIImageView * accountOpenImageView;

@property (nonatomic,weak)id<RSSLRunOpenCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
