//
//  RSScreenheaderView.m
//  石来石往
//
//  Created by mac on 2017/7/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSScreenheaderView.h"

@implementation RSScreenheaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIView * view = [[UIView alloc]init];
        
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        view.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        
        
        UILabel * label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [view addSubview:label];
        _label = label;
        
        label.sd_layout
        .leftSpaceToView(view, 12)
        .rightSpaceToView(view, 12)
        .topSpaceToView(view, 0)
        .bottomSpaceToView(view, 0);
 
    }
    return self;
    
    
}

@end
