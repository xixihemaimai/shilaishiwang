//
//  RSContactsActionHeaderFootView.m
//  石来石往
//
//  Created by mac on 2019/1/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSContactsActionHeaderFootView.h"

@implementation RSContactsActionHeaderFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        //标题
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:Width_Real(16)];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        //编辑
        UIButton * editBtn = [[UIButton alloc]init];
        [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setBackgroundColor:[UIColor clearColor]];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14)];
        [self.contentView addSubview:editBtn];
        _editBtn = editBtn;
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        
        nameLabel.sd_layout
        .centerXEqualToView(self.contentView)
        .centerYEqualToView(self.contentView)
        .widthIs(Width_Real(100))
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        editBtn.sd_layout
        .rightSpaceToView(self.contentView, Width_Real(12))
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(Width_Real(50));
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(Height_Real(1));
        
    }
    return self;
}
@end
