//
//  RSRawMaterialCell.h
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRawMaterialCell : UITableViewCell


@property (nonatomic,strong) UIButton * selectBtn;

@property (nonatomic,strong) UILabel * selectiveLabel;


/**物料名称*/
@property (nonatomic,strong) UILabel * selectDetailNameLabel;
/**物料类型*/
@property (nonatomic,strong)  UILabel * selectDetailTypeLabel;
/**长宽高*/
@property (nonatomic,strong)  UILabel * selectDetailShapeLabel;
/**体积*/
@property (nonatomic,strong)UILabel * selectDetailAreaLabel;

/**重量*/
@property (nonatomic,strong)UILabel * selectDetailWightLabel;


@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong) UILabel * timeDetialLabel;
@property (nonatomic,strong)UILabel * typeLabel;
@property (nonatomic,strong)UILabel * typeDetialLabel;
@property (nonatomic,strong)UILabel * wareHouseLabel;
@property (nonatomic,strong)UILabel * wareHouseDetialLabel;


@end

NS_ASSUME_NONNULL_END
