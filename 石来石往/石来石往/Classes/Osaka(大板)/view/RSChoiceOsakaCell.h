//
//  RSChoiceOsakaCell.h
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSOsakaModel.h"
@interface RSChoiceOsakaCell : UITableViewCell
/**已选中多少片*/
@property (nonatomic,strong)UILabel * choiceCountLabel;
/**名称*/
@property (nonatomic,strong)UILabel *productLabel;

/**荒料号*/
@property (nonatomic,strong)UILabel * numberlabel;

/**修改*/
@property (nonatomic,strong)UIButton *modifyBtn;

@property (nonatomic,strong)RSOsakaModel *osakaModel;
@end
