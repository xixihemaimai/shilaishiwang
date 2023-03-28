//
//  RSFriendDetailFootview.m
//  石来石往
//
//  Created by mac on 2017/10/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFriendDetailFootview.h"

@implementation RSFriendDetailFootview


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel * label = [[UILabel alloc]init];
        //label.text = @"没有评论内容";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _label = label;
        
        
        label.sd_layout
        .centerYEqualToView(self.contentView)
        .centerXEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
    }
    
    return self;
}


@end
