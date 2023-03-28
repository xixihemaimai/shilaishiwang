//
//  RSCargoMainHeaderView.m
//  石来石往
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSCargoMainHeaderView.h"

@implementation RSCargoMainHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton * addBtn = [[UIButton alloc]init];
        [addBtn setTitle:@"添加新案例" forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"添加1"] forState:UIControlStateNormal];
        [self addSubview:addBtn];
        [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _addBtn = addBtn;
        
        addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        addBtn.sd_layout
        .leftSpaceToView(self, 12)
        .rightSpaceToView(self, 12)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        addBtn.layer.cornerRadius = 6;
        addBtn.layer.borderWidth = 1;
        addBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#B5B5B5"].CGColor;

    }
    return self;
}
@end
