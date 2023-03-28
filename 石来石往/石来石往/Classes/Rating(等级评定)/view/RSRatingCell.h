//
//  RSRatingCell.h
//  石来石往
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSRatingModel;

@interface RSRatingCell : UITableViewCell



/**按键A*/
@property (nonatomic,strong)UIButton *aBtn;

/**按键B*/
@property (nonatomic,strong)UIButton *bBtn;
/**按键C*/
@property (nonatomic,strong)UIButton *cBtn;


@property (nonatomic,strong)RSRatingModel *ratingModel;

@end
