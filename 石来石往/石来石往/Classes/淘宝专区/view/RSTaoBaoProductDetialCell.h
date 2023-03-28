//
//  RSTaoBaoProductDetialCell.h
//  石来石往
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoProductDetialCell : UITableViewCell
//匝号
@property (nonatomic,strong)UITextField * turnNoTextField;
//长
@property (nonatomic,strong)UITextField * lenghtTextField;
//厚
@property (nonatomic,strong)UITextField * heightTextField;
//扣尺面积
@property (nonatomic,strong)UITextField * buckleAreaTextField;
//片数
@property (nonatomic,strong)UITextField * numberTextField;
//宽
@property (nonatomic,strong)UITextField * widthTextField;
//原始面积
@property (nonatomic,strong)UITextField * primitiveAreaTextField;
//实际面积
@property (nonatomic,strong)UITextField * actualAreaTextField;
//删除
@property (nonatomic,strong) UIButton * deleteBtn;

@end

NS_ASSUME_NONNULL_END
