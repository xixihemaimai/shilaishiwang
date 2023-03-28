//
//  RSUserManagementFristFootView.m
//  石来石往
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSUserManagementFristFootView.h"

@implementation RSUserManagementFristFootView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UITextField * textfield = [[UITextField alloc]init];
        //textfield.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        
        //[textfield setValue:[UIColor colorWithHexColorStr:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        if ([UIDevice currentDevice].systemVersion.floatValue <= 12.0) {
                      
                      [textfield setValue:[UIColor colorWithHexColorStr:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
                  }else{
                      
                      
                      NSMutableAttributedString * place = [[NSMutableAttributedString alloc]initWithString:textfield.text];
                      
                      [place addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, place.length)];
                      
                      textfield.attributedPlaceholder = place;
                      
                  }
        
        
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.placeholder = @"请输入用户昵称";
        
        textfield.font = [UIFont systemFontOfSize:14];
        [self addSubview:textfield];
        _textfield = textfield;
        
        
    
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:bottomview];
        
        
        
        textfield.sd_layout
        .leftSpaceToView(self, 12)
        .centerYEqualToView(self)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .rightSpaceToView(self, 12);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .heightIs(1);
        
        
        
    }
    
    return self;
}


@end
