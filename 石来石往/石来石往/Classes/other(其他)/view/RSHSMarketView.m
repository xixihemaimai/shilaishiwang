//
//  RSHSMarketView.m
//  石来石往
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHSMarketView.h"

@implementation RSHSMarketView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        //阴影uiview
        UIView * shadowView = [[UIView alloc]init];
       // shadowView.backgroundColor = [UIColor redColor];
        [self addSubview:shadowView];
        _shadowView = shadowView;
        
        
        
        //内容的view
        UIView * contentView = [[UIView alloc]init];
      //  contentView.backgroundColor = [UIColor yellowColor];
        [self addSubview:contentView];
        _contentView = contentView;
        
        
        //这边设置界面
        UILabel * titleLabel = [[UILabel alloc]init];
       // titleLabel.text = @"海西石材城";
       // titleLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
//          NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"海西石材城"];
//        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#ffffff"] range:NSMakeRange(0, str.length)];
//        [str addAttribute:NSShadowAttributeName value:[UIColor colorWithHexColorStr:@"#4965B7"] range:NSMakeRange(0, str.length)];
//
//        titleLabel.attributedText = str;
        /**
         
         
         NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
         [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
         [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
         attrLabel.attributedText = str;
         
         */
        
        
        
       // titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        //荒料
        UILabel * huangLabel = [[UILabel alloc]init];
        huangLabel.text = @"荒料(m³):";
        huangLabel.font = [UIFont systemFontOfSize:17];
       
        huangLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [contentView addSubview:huangLabel];
        
        
        
        //荒料中的view
        UIImageView * huangMidView = [[UIImageView alloc]init];
        huangMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        huangMidView.image = [UIImage imageNamed:@"矩形1拷贝10"];
        huangMidView.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:huangMidView];

        
        
        
        //荒料要填入的值
        UILabel * huangInputLabel = [[UILabel alloc]init];
        huangInputLabel.text = @"83,076";
        huangInputLabel.font = [UIFont systemFontOfSize:17];
        huangInputLabel.textAlignment = NSTextAlignmentCenter;
        huangInputLabel.backgroundColor = [UIColor clearColor];
        _huangInputLabel = huangInputLabel;
        
        
        [UILabel changeWordSpaceForLabel:huangInputLabel WithSpace:2];
        //huangInputLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        huangInputLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
        [huangMidView addSubview:huangInputLabel];
        
        //大板
        UILabel * daBanLabel = [[UILabel alloc]init];
        daBanLabel.text = @"大板(m²):";
        daBanLabel.font = [UIFont systemFontOfSize:17];
        
        daBanLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [contentView addSubview:daBanLabel];
        
        
        
        //荒料中的view
        UIImageView * daBanMidView = [[UIImageView alloc]init];
        daBanMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        [contentView addSubview:daBanMidView];
        daBanMidView.image = [UIImage imageNamed:@"矩形1拷贝10"];
        daBanMidView.contentMode = UIViewContentModeScaleAspectFill;
        
        
        
        //大板要填入的值
        UILabel * dabanInputLabel = [[UILabel alloc]init];
        dabanInputLabel.text = @"1,915,539";
        [UILabel changeWordSpaceForLabel:dabanInputLabel WithSpace:2];
        dabanInputLabel.font = [UIFont systemFontOfSize:17];
        dabanInputLabel.textAlignment = NSTextAlignmentCenter;
        _dabanInputLabel = dabanInputLabel;
        //dabanInputLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        dabanInputLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
        [daBanMidView addSubview:dabanInputLabel];
        
        //品种
        UILabel * typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"品种数:";
        typeLabel.font = [UIFont systemFontOfSize:17];
       
        typeLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [contentView addSubview:typeLabel];
        
        
        
        //荒料中的view
        UIImageView * typeMidView = [[UIImageView alloc]init];
        typeMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [contentView addSubview:typeMidView];
        typeMidView.image = [UIImage imageNamed:@"矩形1拷贝10"];
        typeMidView.contentMode = UIViewContentModeScaleAspectFill;
        
        //品种数要填入的值
        UILabel * typeInputLabel = [[UILabel alloc]init];
        typeInputLabel.text = @"3700";
        [UILabel changeWordSpaceForLabel:typeInputLabel WithSpace:2];
        typeInputLabel.font = [UIFont systemFontOfSize:17];
        typeInputLabel.textAlignment = NSTextAlignmentCenter;
       // typeInputLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        typeInputLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
        [typeMidView addSubview:typeInputLabel];
        _typeInputLabel = typeInputLabel;
        
        shadowView.sd_layout
        .leftSpaceToView(self, 37)
        .rightSpaceToView(self, 37)
        .bottomSpaceToView(self, 0)
        .heightIs(110);
        shadowView.layer.cornerRadius = 10;
        shadowView.layer.masksToBounds = YES;
        
        
        
        contentView.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 7);
        
        contentView.layer.cornerRadius = 10;
        contentView.layer.masksToBounds = YES;
        
       
        
        
        if (iPhone5||iPhone4) {
            
            titleLabel.sd_layout
            .leftSpaceToView(contentView, 20)
            .rightSpaceToView(contentView, 57)
            .topSpaceToView(contentView, 10)
            .heightIs(30);
            
            
            huangLabel.sd_layout
            .leftSpaceToView(contentView, 20)
            .topSpaceToView(titleLabel, 10)
            .widthIs(80)
            .heightIs(30);
            
             huangLabel.textAlignment = NSTextAlignmentLeft;
            daBanLabel.textAlignment = NSTextAlignmentLeft;
             typeLabel.textAlignment = NSTextAlignmentLeft;
        }else{
             huangLabel.textAlignment = NSTextAlignmentRight;
            daBanLabel.textAlignment = NSTextAlignmentRight;
             typeLabel.textAlignment = NSTextAlignmentRight;
            titleLabel.sd_layout
            .leftSpaceToView(contentView, 57)
            .rightSpaceToView(contentView, 57)
            .topSpaceToView(contentView, 10)
            .heightIs(30);
            
            
            huangLabel.sd_layout
            .leftSpaceToView(contentView, 57)
            .topSpaceToView(titleLabel, 10)
            .widthIs(80)
            .heightIs(30);
            
        }
       
        
        
        
        huangMidView.sd_layout
        .leftSpaceToView(huangLabel, 11)
        .rightSpaceToView(contentView, 57)
        .topEqualToView(huangLabel)
        .bottomEqualToView(huangLabel);
        
        
        
        
        huangInputLabel.sd_layout
        .leftSpaceToView(huangMidView, 0)
        .rightSpaceToView(huangMidView, 0)
        .topEqualToView(huangMidView)
        .bottomEqualToView(huangMidView);
        
        
        
        daBanLabel.sd_layout
        .leftEqualToView(huangLabel)
        .rightEqualToView(huangLabel)
        .topSpaceToView(huangLabel, 10)
        .heightIs(30);
        
        
        daBanMidView.sd_layout
        .leftSpaceToView(daBanLabel, 11)
        .rightSpaceToView(contentView, 57)
        .topEqualToView(daBanLabel)
        .bottomEqualToView(daBanLabel);
        
        
        dabanInputLabel.sd_layout
        .leftSpaceToView(daBanMidView, 0)
        .rightEqualToView(daBanMidView)
        .topEqualToView(daBanMidView)
        .bottomEqualToView(daBanMidView);
        
        
        typeLabel.sd_layout
        .leftEqualToView(daBanLabel)
        .rightEqualToView(daBanLabel)
        .topSpaceToView(daBanLabel, 10)
        .heightIs(30);
        
        
        typeMidView.sd_layout
        .leftSpaceToView(typeLabel, 11)
        .rightSpaceToView(contentView, 57)
        .topEqualToView(typeLabel)
        .bottomEqualToView(typeLabel);
        
        
        typeInputLabel.sd_layout
        .leftSpaceToView(typeMidView, 0)
        .rightEqualToView(typeMidView)
        .topEqualToView(typeMidView)
        .bottomEqualToView(typeMidView);
        

        
    }
    return self;
}




@end
