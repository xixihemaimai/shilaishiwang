//
//  RSNewRoleFootView.m
//  石来石往
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSNewRoleFootView.h"

@implementation RSNewRoleFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
     
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self.contentView addSubview:view];
        
        UILabel * label = [[UILabel alloc]init];
        label.text = @"权限设置";
        label.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
        
        
        view.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        label.sd_layout
        .leftSpaceToView(view, 12)
        .rightSpaceToView(view, 12)
        .topSpaceToView(view, 9)
        .bottomSpaceToView(view, 5);
        
        
        
        
    }
    return self;
}


@end
