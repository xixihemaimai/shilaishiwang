//
//  AlertTableViewHeaderView.m
//  GGAlertAction
//
//  Created by mac on 2018/12/17.
//  Copyright © 2018年 jixiang. All rights reserved.
//

#import "AlertTableViewHeaderFootView.h"

@implementation AlertTableViewHeaderFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, 0, 100, 50)];
         self.titleLabel.backgroundColor = [UIColor whiteColor];
         self.titleLabel.textAlignment = NSTextAlignmentCenter;
         self.titleLabel.font = [UIFont systemFontOfSize:16];
         self.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
         [self addSubview: self.titleLabel];
        
        
        UIButton * editHeaderBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 12 -50, 0, 50, 50)];
        [editHeaderBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        editHeaderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [editHeaderBtn setBackgroundColor:[UIColor clearColor]];
        [self addSubview:editHeaderBtn];
        _editHeaderBtn = editHeaderBtn;
        
        UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        bottomview.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self addSubview:bottomview];
        
        
        
        
        
       
    }
    return self;
}

@end
