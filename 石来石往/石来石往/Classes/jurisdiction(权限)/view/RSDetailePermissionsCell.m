//
//  RSDetailePermissionsCell.m
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDetailePermissionsCell.h"


#import "UIColor+HexColor.h"
#import <SDAutoLayout.h>


@implementation RSDetailePermissionsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UIImageView * permissionsImage = [[UIImageView alloc]init];
        [self.contentView addSubview:permissionsImage];
        _permissionsImage = permissionsImage;
        
        
        UILabel * permissionsNameLabel = [[UILabel alloc]init];
        permissionsNameLabel.textAlignment = NSTextAlignmentLeft;
        permissionsNameLabel.font = [UIFont systemFontOfSize:15];
        permissionsNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:permissionsNameLabel];
        _permissionsNameLabel = permissionsNameLabel;
        

        UISwitch * sw = [[UISwitch alloc]init];
        [self.contentView addSubview:sw];
        _sw = sw;

        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
    
        permissionsImage.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        //.topSpaceToView(self.contentView, 11)
        //.bottomSpaceToView(self.contentView, 11)
        .heightIs(23)
        .widthIs(23);
        
        
        permissionsNameLabel.sd_layout
        .centerYEqualToView(permissionsImage)
        .leftSpaceToView(permissionsImage, 6)
        .heightIs(14)
        .widthIs(90);
        
        sw.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
       // .topSpaceToView(self.contentView, 10)
       // .bottomSpaceToView(self.contentView, 10)
        .widthIs(45)
        .heightIs(10);
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 13)
        .rightSpaceToView(self.contentView, 13)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
 
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
