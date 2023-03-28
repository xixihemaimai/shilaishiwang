//
//  RSContactsActionFootView.m
//  石来石往
//
//  Created by mac on 2019/1/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSContactsActionFootView.h"

@implementation RSContactsActionFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UIButton * cancelBtn = [[UIButton alloc]init];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor clearColor]];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:cancelBtn];
        _cancelBtn = cancelBtn;
        cancelBtn.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
    }
    return self;
}


@end
