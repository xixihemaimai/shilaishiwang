//
//  RSRSBalanceDetialCell.h
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRSBalanceDetialCell : UITableViewCell

@property (nonatomic,strong) UIButton * selectBtn;

@property (nonatomic,strong) UILabel * selectiveLabel;

//是否冻结
@property (nonatomic,strong) UIImageView * isfrozenImageView;

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

@property (nonatomic,strong)UIView * selectiveInventoryView;




//入仓时间或者出仓时间
@property (nonatomic,strong)UILabel * billdateNameLabel;

@property (nonatomic,strong)UILabel *  billdateTimeLabel;

//入仓类型
@property (nonatomic,strong)UILabel * storageTypeNameLabel;

@property (nonatomic,strong)UILabel * storageTypeLabel;

//仓库
@property (nonatomic,strong)UILabel * whsnameNameLabel;
@property (nonatomic,strong)UILabel * whsnameLabel;


@end

NS_ASSUME_NONNULL_END
