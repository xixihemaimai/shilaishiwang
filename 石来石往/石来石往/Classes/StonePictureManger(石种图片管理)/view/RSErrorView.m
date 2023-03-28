//
//  RSErrorView.m
//  石来石往
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSErrorView.h"
#import "RSErrorPictureView.h"

@implementation RSErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        
        [self addSetupUI];
        
        
    }
    return self;
    
    
}



#pragma mark -- 添加UI
- (void)addSetupUI{
    
    
    UIView * showErrorImageview = [[UIView alloc]init];
    showErrorImageview.backgroundColor = [UIColor whiteColor];
    [self addSubview:showErrorImageview];
    
    UILabel * errorLabel = [[UILabel alloc]init];
    errorLabel.text = @"可以做一下操作来提升图片的审核通过率";
    errorLabel.font = [UIFont systemFontOfSize:12];
    errorLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [showErrorImageview addSubview:errorLabel];
    
    
    RSErrorPictureView * errorPictureview = [[RSErrorPictureView alloc]init];
    errorPictureview.backgroundColor = [UIColor whiteColor];
    [showErrorImageview addSubview:errorPictureview];
    
    
    
    showErrorImageview.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .heightIs(125);
    
    
    errorLabel.sd_layout
    .leftSpaceToView(showErrorImageview, 12)
    .rightSpaceToView(showErrorImageview, 12)
    .topSpaceToView(showErrorImageview, 10)
    .heightIs(12);
    
    
    errorPictureview.sd_layout
    .leftSpaceToView(showErrorImageview, 10)
    .rightSpaceToView(showErrorImageview, 10)
    .topSpaceToView(errorLabel, 10)
    .bottomSpaceToView(showErrorImageview, 4);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


@end
