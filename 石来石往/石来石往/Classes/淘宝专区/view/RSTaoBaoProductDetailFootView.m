//
//  RSTaoBaoProductDetailFootView.m
//  石来石往
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProductDetailFootView.h"

@implementation RSTaoBaoProductDetailFootView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        
        
        UIView * backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:backView];
        _backView = backView;
        
        UIButton * addTurnsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addTurnsBtn setTitle:@"添加匝" forState:UIControlStateNormal];
        addTurnsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [addTurnsBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [addTurnsBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
        [backView addSubview:addTurnsBtn];
        _addTurnsBtn = addTurnsBtn;
        
        backView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
       
        
        
        addTurnsBtn.sd_layout
        .rightSpaceToView(backView, 12)
        .topSpaceToView(backView, 10)
        .widthIs(58)
        .heightIs(23);
        
        
        addTurnsBtn.layer.cornerRadius = 12;
        
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
