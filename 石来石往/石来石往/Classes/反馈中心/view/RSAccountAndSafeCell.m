//
//  RSAccountAndSafeCell.m
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSAccountAndSafeCell.h"

@implementation RSAccountAndSafeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UILabel * leftLabel = [[UILabel alloc]init];
        leftLabel.text = @"注销账号";
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:leftLabel];
        
        leftLabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, 16).heightIs(30).widthIs(80);
        
        
        UIImageView * rightImage = [[UIImageView alloc]init];
        rightImage.image = [UIImage imageNamed:@"向右"];
        [self.contentView addSubview:rightImage];
        
        rightImage.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 12)
            .widthIs(15)
            .heightEqualToWidth();
        
        
        UILabel * rightLabel = [[UILabel alloc]init];
        rightLabel.text = @"注销后账号无法恢复，请谨慎操作";
        rightLabel.font = [UIFont systemFontOfSize:15];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:rightLabel];
        
        
        rightLabel.sd_layout.rightSpaceToView(rightImage, 0).centerYEqualToView(self.contentView).leftSpaceToView(leftLabel, 0).heightIs(30);
        
      
        
        
        
        
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
