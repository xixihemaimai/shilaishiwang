//
//  RSCaseProjectCustomCell.m
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCaseProjectCustomCell.h"

@implementation RSCaseProjectCustomCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * caseImage = [[UIImageView alloc]init];
        caseImage.image = [UIImage imageNamed:@"1080-675"];
        caseImage.contentMode = UIViewContentModeScaleAspectFill;
        caseImage.clipsToBounds = YES;
        [self.contentView addSubview:caseImage];
        _caseImage = caseImage;
        UILabel * caseLabel = [[UILabel alloc]init];
        caseLabel.text = @"天然米黄";
        caseLabel.textAlignment = NSTextAlignmentLeft;
        caseLabel.font = [UIFont systemFontOfSize:14];
        caseLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:caseLabel];
        _caseLabel = caseLabel;
        caseImage.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(220);
        
        caseLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(caseImage, 8)
        .bottomSpaceToView(self.contentView, 0);
        
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
