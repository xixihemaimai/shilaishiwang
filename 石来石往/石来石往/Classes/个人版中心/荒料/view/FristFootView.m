//
//  FristFootView.m
//  石来石往
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FristFootView.h"

@implementation FristFootView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorFromHexString:@"#ffffff"];
        
//        UIView * leftView = [[UIView alloc]init];
//        leftView.backgroundColor = [UIColor colorFromHexString:@"#E8E8E8"];
//        [self.contentView addSubview:leftView];
        
        
        //右边
//        UIView * rightView = [[UIView alloc]init];
//        rightView.backgroundColor = [UIColor colorFromHexString:@"#E8E8E8"];
//        [self.contentView addSubview:rightView];
        
        
        
        //分割线
//        UIView * bottomview = [[UIView alloc]init];
//        bottomview.backgroundColor = [UIColor colorFromHexString:@"#E8E8E8"];
//        [self.contentView addSubview:bottomview];
        
        
        //添加费用的按键
        UIButton * addMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addMoneyBtn setBackgroundColor:[UIColor colorFromHexString:@"#3385ff"]];
        [addMoneyBtn setTitle:@"添加费用" forState:UIControlStateNormal];
        [addMoneyBtn setTitleColor:[UIColor colorFromHexString:@"#ffffff"] forState:UIControlStateNormal];
        addMoneyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:addMoneyBtn];
        _addMoneyBtn = addMoneyBtn;
        
        
        
        
        //总计
        UILabel * totalLabel = [[UILabel alloc]init];
        totalLabel.text = @"总计:48元";
        totalLabel.textAlignment = NSTextAlignmentRight;
        totalLabel.font = [UIFont systemFontOfSize:16];
        totalLabel.textColor = [UIColor colorFromHexString:@"#666666"];
        [self.contentView addSubview:totalLabel];
        _totalLabel = totalLabel;
        
//        leftView.sd_layout
//        .leftSpaceToView(self.contentView, 12)
//        .topSpaceToView(self.contentView, 0)
//        .heightIs(30)
//        .widthIs(1);
//
//
//        rightView.sd_layout
//        .rightSpaceToView(self.contentView, 12)
//        .topSpaceToView(self.contentView, 0)
//        .heightIs(30)
//        .widthIs(1);
//
//        bottomview.sd_layout
//        .leftSpaceToView(leftView, 0)
//        .rightSpaceToView(rightView, 0)
//        .heightIs(1)
//        .topSpaceToView(self.contentView, 30);
        
        addMoneyBtn.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .heightIs(32)
        .widthIs(73);
        
        addMoneyBtn.layer.cornerRadius = 3;
        
        totalLabel.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .heightIs(32)
        .widthRatioToView(self.contentView, 0.3);
        
    }
    return self;
}


@end
