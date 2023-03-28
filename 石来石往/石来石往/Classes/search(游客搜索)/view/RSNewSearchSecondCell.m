//
//  RSNewSearchSecondCell.m
//  石来石往
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNewSearchSecondCell.h"


@interface RSNewSearchSecondCell()
{
    
    UIImageView * _fristImage;
    
    UILabel * _timeLabel;
 
}


@end



@implementation RSNewSearchSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //图片
        UIImageView * fristImage = [[UIImageView alloc]init];
        [self.contentView addSubview:fristImage];
        
        _fristImage = fristImage;
        //评论
        UITextView  *textview = [[UITextView alloc]init];
        textview.editable = NO;
        
        textview.userInteractionEnabled = NO;
        
        [self.contentView addSubview:textview];
        _textview = textview;
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:12];
       // timeLabel.text = @"1000/01/01";
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        //底部的视图
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        fristImage.sd_layout
        .topSpaceToView(self.contentView, 8.5)
        .bottomSpaceToView(self.contentView, 8.5)
        .topSpaceToView(self.contentView, 11.5)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(80.5);
        
        timeLabel.sd_layout
        .leftSpaceToView(fristImage, 8)
        .rightSpaceToView(self.contentView, 12)
        .bottomEqualToView(fristImage)
        .heightIs(15);
        
        textview.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(fristImage, 8)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(timeLabel, 0);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
    }
    return self;
}







    
    






- (void)setCompanyAndStonemodel:(RSCompanyAndStoneModel *)companyAndStonemodel{
    _companyAndStonemodel = companyAndStonemodel;
    
    
    [_fristImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_companyAndStonemodel.imgUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
    
    
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",_companyAndStonemodel.createTime];
    
    
    
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
