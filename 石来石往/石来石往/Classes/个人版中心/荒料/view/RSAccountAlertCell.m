//
//  RSAccountAlertCell.m
//  石来石往
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSAccountAlertCell.h"

@implementation RSAccountAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UIView * accountView = [[UIView alloc]init];
        accountView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
        [self.contentView addSubview:accountView];
        
        UILabel * shapeLabel = [[UILabel alloc]init];
         shapeLabel.text = @"长宽高(cm)";
        shapeLabel.font = [UIFont systemFontOfSize:15];
        shapeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        shapeLabel.textAlignment = NSTextAlignmentLeft;
        [accountView addSubview:shapeLabel];
        
        
        UILabel * shapeDetialLabel = [[UILabel alloc]init];
        shapeDetialLabel.font = [UIFont systemFontOfSize:15];
        shapeDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        shapeDetialLabel.textAlignment = NSTextAlignmentRight;
        [accountView addSubview:shapeDetialLabel];
        _shapeDetialLabel = shapeDetialLabel;
        
        UILabel * volumeLabel = [[UILabel alloc]init];
        volumeLabel.font = [UIFont systemFontOfSize:15];
        volumeLabel.text = @"体积(m³)";
        volumeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        volumeLabel.textAlignment = NSTextAlignmentLeft;
        [accountView addSubview:volumeLabel];
        
        
        UILabel * volumeDetialLabel = [[UILabel alloc]init];
        volumeDetialLabel.font = [UIFont systemFontOfSize:15];
        volumeDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        volumeDetialLabel.textAlignment = NSTextAlignmentRight;
        [accountView addSubview:volumeDetialLabel];
        _volumeDetialLabel = volumeDetialLabel;
        
        
        UILabel * weightLabel = [[UILabel alloc]init];
        weightLabel.font = [UIFont systemFontOfSize:15];
        weightLabel.text = @"重量(吨)";
        weightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        weightLabel.textAlignment = NSTextAlignmentLeft;
        [accountView addSubview:weightLabel];
        
        
        UILabel * weightDetialLabel = [[UILabel alloc]init];
        weightDetialLabel.font = [UIFont systemFontOfSize:15];
        weightDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        weightDetialLabel.textAlignment = NSTextAlignmentRight;
        [accountView addSubview:weightDetialLabel];
        _weightDetialLabel = weightDetialLabel;
        
        
        accountView.sd_layout
        .leftSpaceToView(self.contentView, 13)
        .rightSpaceToView(self.contentView, 13)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5);
        
        accountView.layer.cornerRadius = 3;
        
        shapeLabel.sd_layout
        .leftSpaceToView(accountView, 10)
        .topSpaceToView(accountView, 6)
        .widthIs(85)
        .heightIs(21);
        
        
        shapeDetialLabel.sd_layout
        .rightSpaceToView(accountView, 12)
        .leftSpaceToView(shapeLabel, 0)
        .topEqualToView(shapeLabel)
        .bottomEqualToView(shapeLabel);
        
        volumeLabel.sd_layout
        .leftEqualToView(shapeLabel)
        .rightEqualToView(shapeLabel)
        .topSpaceToView(shapeLabel, 3)
        .heightIs(21);
        
        volumeDetialLabel.sd_layout
        .leftEqualToView(shapeDetialLabel)
        .rightEqualToView(shapeDetialLabel)
        .topEqualToView(volumeLabel)
        .bottomEqualToView(volumeLabel);
        
        
        weightLabel.sd_layout
        .leftEqualToView(volumeLabel)
        .rightEqualToView(volumeLabel)
        .topSpaceToView(volumeLabel, 3)
        .heightIs(21);
        
        weightDetialLabel.sd_layout
        .leftEqualToView(volumeDetialLabel)
        .rightEqualToView(volumeDetialLabel)
        .topEqualToView(weightLabel)
        .bottomEqualToView(weightLabel);
        
        
        
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
