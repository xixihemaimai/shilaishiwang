//
//  RSHistoryCell.m
//  石来石往
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHistoryCell.h"


@interface RSHistoryCell ()


@end


@implementation RSHistoryCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"放大镜"];
        [self.contentView addSubview:imageview];
        
        imageview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 12)
        .widthIs(20);
        
        
        
        
        
        
        UILabel * nameLabel = [[UILabel alloc]init];
        //nameLabel.text = @"333333";
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UIView * botttomview = [[UIView alloc]init];
        botttomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:botttomview];
        
        
        botttomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
          
        nameLabel.sd_layout
        .leftSpaceToView(imageview, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(botttomview, 0);
    }
    return self;
}

//- (void)setHistorySearchModel:(RSHistorySearchModel *)historySearchModel{
//    _historySearchModel = historySearchModel;
//    //_nameLabel.text = [NSString stringWithFormat:@"%@",historySearchModel.mtlname];
//}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
