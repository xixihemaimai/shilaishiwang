//
//  RSSegmentSecondHeaderView.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCompanyAndStoneModel.h"


@interface RSSegmentSecondHeaderView : UITableViewHeaderFooterView
/**图片*/
@property (nonatomic,strong)UIImageView * imageview;
/**石种*/
@property (nonatomic,strong)UILabel * stoneLabel;
/**颗*/
@property (nonatomic,strong)UILabel * keLabel;


@property (nonatomic,strong)RSCompanyAndStoneModel * companyAndStoneModel;

@end
