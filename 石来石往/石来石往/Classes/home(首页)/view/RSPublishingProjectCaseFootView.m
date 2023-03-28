//
//  RSPublishingProjectCaseFootView.m
//  石来石往
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPublishingProjectCaseFootView.h"

@implementation RSPublishingProjectCaseFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UIButton * addBtn = [[UIButton alloc]init];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        [self.contentView addSubview:addBtn];
        _addBtn = addBtn;
        addBtn.sd_layout
        .rightSpaceToView(self.contentView, 24)
        .topSpaceToView(self.contentView, 7.5)
        .bottomSpaceToView(self.contentView, 7.5)
        .widthIs(50);
        
        
        _addBtn.layer.cornerRadius = 5;
        _addBtn.layer.masksToBounds = YES;
        
    }
    return self;
}

@end
