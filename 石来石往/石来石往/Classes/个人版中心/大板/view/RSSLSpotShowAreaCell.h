//
//  RSSLSpotShowAreaCell.h
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSLSpotShowAreaCell : UITableViewCell

/**荒料号*/
@property (nonatomic,strong) UILabel * showProductLabel;
/**匝号*/
@property (nonatomic,strong)UILabel * showTurnLabel;


/**是否选中*/
@property (nonatomic,strong)UIButton * showSelectBtn;
/**物料名称*/
@property (nonatomic,strong)UILabel * showNameDetailLabel;
/**物料类型*/
@property (nonatomic,strong)UILabel * showTypeDetailLabel;

/**长宽高*/
@property (nonatomic,strong) UILabel * showShapeDetailLabel;

/**体积*/
@property (nonatomic,strong)UILabel * showAreaDetailLabel;

/**重量*/
@property (nonatomic,strong)UILabel * showWightDetailLabel;
/**完善图片按键*/
@property (nonatomic,strong)UIButton * completeBtn;
@property (nonatomic,copy) void(^ChoseBtnBlock)(id,BOOL);
@property (nonatomic,assign) BOOL selectedStutas;
@end

NS_ASSUME_NONNULL_END
