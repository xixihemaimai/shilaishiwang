//
//  RSSelectiveInventoryCell.h
//  石来石往
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSelectiveInventoryCell : UITableViewCell

//@property (nonatomic,copy) void(^ChoseBtnBlock)(id,BOOL);

//@property (nonatomic,assign) BOOL selectedStutas;

@property (nonatomic,strong) UIButton * selectBtn;

@property (nonatomic,strong) UILabel * selectiveLabel;

//是否冻结
@property (nonatomic,strong)UILabel * isfrozenLabel;

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

@end

NS_ASSUME_NONNULL_END
