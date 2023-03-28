//
//  RSMyRingCell.m
//  石来石往
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyRingCell.h"

@implementation RSMyRingCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //日
        UILabel * dayTimeLabel = [[UILabel alloc]init];
        dayTimeLabel.font = [UIFont systemFontOfSize:30];
        dayTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        dayTimeLabel.text = @"05";
        [self.contentView addSubview:dayTimeLabel];
        
        //月
        UILabel * monthTimeLabel = [[UILabel alloc]init];
        
        monthTimeLabel.font = [UIFont systemFontOfSize:12];
        monthTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        monthTimeLabel.text = @"5月";
        [self.contentView addSubview:monthTimeLabel];
        
        
        
        //这边是显示图片的view,这边想做一个自定义view,在从模型里面传图片的个数进去
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:view];
        
  
        
        //这边是内容
        UILabel * contentLabel = [[UILabel alloc]init];
        contentLabel.numberOfLines = 0;
        contentLabel.text = @"111";
        contentLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        contentLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:contentLabel];
        
        
        
        //这边做一个假的view
        /*
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:bottomview];

        dayTimeLabel.sd_layout
        .leftSpaceToView(self.contentView,12)
        .topSpaceToView(self.contentView, 0)
        .heightIs(24)
        .widthIs(40);
        
        */
        
        monthTimeLabel.sd_layout
        .leftSpaceToView(dayTimeLabel, 6)
        .topSpaceToView(dayTimeLabel, 16)
        .bottomEqualToView(dayTimeLabel)
        .widthIs(20);
        
        
        
        view.sd_layout
        .leftSpaceToView(monthTimeLabel, 26)
        .topEqualToView(self.contentView)
        .widthIs(75)
        .heightIs(75);
        
        
        contentLabel.sd_layout
        .leftSpaceToView(view, 5)
        .topEqualToView(view)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(15);
        
        
       /*
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(view, 0)
        .heightIs(29);

        */
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
