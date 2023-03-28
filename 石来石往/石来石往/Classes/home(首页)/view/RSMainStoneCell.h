//
//  RSMainStoneCell.h
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSMainStoneCell : UITableViewCell

/**次数*/
@property (nonatomic,strong)UILabel * mainStoneNumberLabel;

/**荒料号*/
@property (nonatomic,strong)UILabel * huangliaoLabel;
/**规格*/
@property (nonatomic,strong)UILabel * ruleLabel;
/**体积*/
@property (nonatomic,strong)UILabel * areaLabel;
/**重量*/
@property (nonatomic,strong)UILabel * weightLabel;

@property (nonatomic,strong)UIButton * mainStoneCollectionBtn;




@end

NS_ASSUME_NONNULL_END
