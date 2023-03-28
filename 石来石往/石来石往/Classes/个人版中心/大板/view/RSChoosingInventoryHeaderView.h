//
//  RSChoosingInventoryHeaderView.h
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSChoosingInventoryHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong)UIButton * selectBtn;

//@property (nonatomic,strong)UIView * bottomview;

@property (nonatomic, strong) UITapGestureRecognizer * tap;

@property (nonatomic,strong)UIImageView * choosingDirectionImageView;


@property (nonatomic,strong)UILabel * choosingNumberLabel;

@property (nonatomic,strong)UILabel * choosingProductNameLabel;
@property (nonatomic,strong)UILabel * choosingProductTypeLabel;

@property (nonatomic,strong)UILabel * choosingAreaLabel;

@property (nonatomic,strong)UILabel * choosingWarehouseLabel;
@end

NS_ASSUME_NONNULL_END
