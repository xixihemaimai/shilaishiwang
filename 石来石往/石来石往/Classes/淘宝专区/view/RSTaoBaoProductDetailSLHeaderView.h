//
//  RSTaoBaoProductDetailSLHeaderView.h
//  石来石往
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAllMessageUIButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoProductDetailSLHeaderView : UITableViewHeaderFooterView

//荒料号
@property (nonatomic,strong)UITextField * blockNoLabelTextField;
//物料类型
@property (nonatomic,strong)UITextField * typeTextField;
//面积
@property (nonatomic,strong)UITextField * areaTextField;
//总匝数
@property (nonatomic,strong)UITextField * totalTextField;
//存储位置
@property (nonatomic,strong)UITextField * addressTextField;
//删除
@property (nonatomic,strong)UIButton * deleteBtn;
//添加匝信息

@property (nonatomic,strong)RSAllMessageUIButton * addTurnsBtn;
@end

NS_ASSUME_NONNULL_END
