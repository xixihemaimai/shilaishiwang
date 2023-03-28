//
//  RSDetailSegmentCell.h
//  石来石往
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSDetailSegmentModel.h"

@interface RSDetailSegmentCell : UITableViewCell


/**收藏的按键*/
@property (nonatomic,strong)UIButton * loveBtn;


@property (nonatomic,strong)UILabel  * countLabel;


@property (nonatomic,strong)RSDetailSegmentModel * detailSegmnetModel;



@property (nonatomic,strong)NSString * searchType;



/**荒料号*/
@property (nonatomic,strong)UILabel *huangliaoLabel;

 //规格
@property (nonatomic,strong) UILabel * guiLabel;


//体积
@property (nonatomic,strong)UILabel * tijiLabel;
 //重量
@property (nonatomic,strong)UILabel * zhongLabel;

//仓储位置
@property (nonatomic,strong)UILabel * cangkuLabel;
//重量的名称

@property (nonatomic,strong)UILabel * weightLabel;


//体积的名字
@property (nonatomic,strong)UILabel * tiLabel;


 //仓库的名字
@property (nonatomic,strong)UILabel * cangLabel;


@end
