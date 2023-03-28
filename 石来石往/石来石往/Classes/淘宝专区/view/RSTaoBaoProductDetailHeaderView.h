//
//  RSTaoBaoProductDetailHeaderView.h
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoProductDetailHeaderView : UITableViewHeaderFooterView

//荒料号
@property (nonatomic,strong)UITextField * blockNoLabelTextField;
//物料类型
@property (nonatomic,strong)UITextField * typeTextField;
//宽
@property (nonatomic,strong)UITextField * widthTextField;
//面积
@property (nonatomic,strong)UITextField * areaTextField;
//长
@property (nonatomic,strong)UITextField * lenghtTextField;
//厚
@property (nonatomic,strong)UITextField * heightTextField;
//重量和总匝数
@property (nonatomic,strong)UITextField * totalTextField;
//存储位置
@property (nonatomic,strong)UITextField * addressTextField;
//删除
@property (nonatomic,strong)UIButton * deleteBtn;

@property (nonatomic,strong)UIView * backView;
@property (nonatomic,strong)UIView * showView;


@end

NS_ASSUME_NONNULL_END
