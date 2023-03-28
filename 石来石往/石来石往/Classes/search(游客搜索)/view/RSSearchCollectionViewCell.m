//
//  RSSearchCollectionViewCell.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSearchCollectionViewCell.h"

@implementation RSSearchCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIButton * contentButton = [[UIButton alloc]init];
        [contentButton setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        contentButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:contentButton];
        
       contentButton.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        [contentButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        _contentButton = contentButton;
        
        
        
        
        UILongPressGestureRecognizer * longPan = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPan.minimumPressDuration = 1.0;
        [contentButton addGestureRecognizer:longPan];
        
        [_contentButton.layer setMasksToBounds:YES];
        [_contentButton.layer setCornerRadius:12.0];
        [_contentButton setBackgroundColor:[UIColor colorWithWhite:0.957 alpha:1.000]];
        
    }
    
    return self;
    
}


+ (CGSize) getSizeWithText:(NSString*)text;
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGFloat margin = 10;
    CGFloat textW = SCW - (2 * margin);
    CGSize size = [text boundingRectWithSize:CGSizeMake(textW, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width +  50, 24);
}

- (void)select:(id)sender {
    if ([self.selectDelegate respondsToSelector:@selector(selectButttonClick:)]) {
        [self.selectDelegate selectButttonClick:self];
    }
}

- (void)longPress:(UILongPressGestureRecognizer*)sender {
    if ([self.selectDelegate respondsToSelector:@selector(longSelectButttonClick:)]) {
        [self.selectDelegate longSelectButttonClick:sender];
    }
    
}


@end
