//
//  RSTaobaoComplaintCell.m
//  石来石往
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoComplaintCell.h"

@implementation RSTaobaoComplaintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        //投诉内容
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        
        //投诉是否选择
        UIImageView * selectComplaintImage = [[UIImageView alloc]init];
        selectComplaintImage.image = [UIImage imageNamed:@"投诉对"];
        [self.contentView addSubview:selectComplaintImage];
        _selectComplaintImage = selectComplaintImage;
        
        
        //底部横线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        
        titleLabel.sd_layout
         .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(23)
        .widthRatioToView(self.contentView, 0.5);
        
        
        selectComplaintImage.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(19)
        .heightIs(14);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 1)
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
