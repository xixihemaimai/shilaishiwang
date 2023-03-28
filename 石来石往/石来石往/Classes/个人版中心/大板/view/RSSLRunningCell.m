//
//  RSSLRunningCell.m
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLRunningCell.h"

@implementation RSSLRunningCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        
        //创建view
        UIButton * runningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [runningBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [self.contentView addSubview:runningBtn];
        _runningBtn = runningBtn;
        
        UILabel * runningNameLabel = [[UILabel alloc]init];
        runningNameLabel.text = @"白玉兰";
        runningNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        runningNameLabel.font = [UIFont systemFontOfSize:17];
        runningNameLabel.textAlignment = NSTextAlignmentLeft;
        [runningBtn addSubview:runningNameLabel];
        _runningNameLabel = runningNameLabel;
        
        UILabel * blockNameLabel = [[UILabel alloc]init];
        blockNameLabel.text = @"ESB00295/DH-539";
        blockNameLabel.font = [UIFont systemFontOfSize:12];
        blockNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        blockNameLabel.textAlignment = NSTextAlignmentLeft;
        [runningBtn addSubview:blockNameLabel];
        
        _blockNameLabel = blockNameLabel;
        //
        UILabel * turnNameLabel = [[UILabel alloc]init];
        turnNameLabel.text = @"5-1";
        turnNameLabel.font = [UIFont systemFontOfSize:15];
        turnNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        turnNameLabel.textAlignment = NSTextAlignmentCenter;
        [runningBtn addSubview:turnNameLabel];
        _turnNameLabel = turnNameLabel;
        
        UIImageView * nameView = [[UIImageView alloc]init];
        nameView.image = [UIImage imageNamed:@"system-moreb"];
        [runningBtn addSubview:nameView];
        
        
        
        runningBtn.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0);
        
        runningBtn.layer.cornerRadius = 8;
        
        nameView.sd_layout
        .centerYEqualToView(runningBtn)
        .rightSpaceToView(runningBtn, 15)
        .widthIs(9)
        .heightIs(16);
        
        turnNameLabel.sd_layout
        .centerYEqualToView(runningBtn)
        .rightSpaceToView(nameView, 17)
        .heightIs(21)
        .widthRatioToView(runningBtn, 0.2);
        
        
        
        runningNameLabel.sd_layout
        .leftSpaceToView(runningBtn, 13)
        .topSpaceToView(runningBtn, 15)
        .widthRatioToView(runningBtn, 0.5)
        .heightIs(24);
        
        blockNameLabel.sd_layout
        .leftEqualToView(runningNameLabel)
        .rightEqualToView(runningNameLabel)
        .topSpaceToView(runningNameLabel, 0)
        .heightIs(17);
        
      
        
        
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
