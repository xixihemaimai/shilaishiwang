//
//  RSNewSearchCollectionCell.m
//  石来石往
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSNewSearchCollectionCell.h"

@implementation RSNewSearchCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithHexColorStr:@"#6A6A6A"];
        label.backgroundColor = [UIColor colorWithHexColorStr:@"#F6F6F6"];
        label.textAlignment = NSTextAlignmentCenter;
        _label = label;
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
    
        UIButton * deleteBtn = [[UIButton alloc]init];
        [deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        [self.contentView addSubview:deleteBtn];
        [deleteBtn bringSubviewToFront:self.contentView];
        deleteBtn.hidden = YES;
        deleteBtn.enabled = NO;
        _deleteBtn = deleteBtn;
        
        label.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        deleteBtn.sd_layout
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .widthIs(10)
        .heightEqualToWidth();
        
        
    
        label.layer.cornerRadius = 3;
        label.layer.masksToBounds = YES;
        
        
    }
    return self;
}



@end
