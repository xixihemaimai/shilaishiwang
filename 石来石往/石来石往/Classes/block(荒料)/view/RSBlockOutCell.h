//
//  RSBlockOutCell.h
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBlockModel.h"
@interface RSBlockOutCell : UITableViewCell

@property (nonatomic,copy) void(^ChoseBtnBlock)(id,BOOL);
@property (nonatomic,assign) BOOL selectedStutas;

/**规格*/
@property (nonatomic,strong)UILabel * psLabel;
/**名称*/
@property (nonatomic,strong)UILabel *productLabel;

/**荒料号*/
@property (nonatomic,strong)UILabel * numberlabel;

@property (nonatomic,strong)RSBlockModel *blockmodel;


/**选择按键*/
@property (nonatomic,strong)UIButton *choiceBtn;
@end
