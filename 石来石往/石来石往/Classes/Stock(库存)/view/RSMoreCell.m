//
//  RSMoreCell.m
//  石来石往
//
//  Created by mac on 17/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMoreCell.h"

@interface RSMoreCell ()

{
    UILabel * _titleLabel;
    UILabel * _dateLabel;
}

@end


@implementation RSMoreCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:midView];
        midView.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .centerYEqualToView(self.contentView)
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0);
        
        
        
        
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"img_trumpet"];
        [midView addSubview:imageview];
        
        
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        titleLabel.text = @"石来石往上线了";
        [midView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        //        UILabel * styleLabel = [[UILabel alloc]init];
        //        styleLabel.text = @"发文办理流程";
        //        styleLabel.textAlignment = NSTextAlignmentCenter;
        //        styleLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        //        styleLabel.font = [UIFont systemFontOfSize:10];
        //        [midView addSubview:styleLabel];
        //        _styleLabel = styleLabel;
        
        //        UILabel * pubilishLabel = [[UILabel alloc]init];
        //        pubilishLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        //        pubilishLabel.font = [UIFont systemFontOfSize:10];
        //        pubilishLabel.textAlignment = NSTextAlignmentCenter;
        //
        //        pubilishLabel.text = @"陈小编";
        //        [midView addSubview:pubilishLabel];
        //        _pubilishLabel = pubilishLabel;
        //
        UILabel *dateLabel = [[UILabel alloc]init];
        dateLabel.text = @"05-19 18:00";
        dateLabel.textAlignment = NSTextAlignmentRight;
        dateLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        dateLabel.font = [UIFont systemFontOfSize:10];
        [midView addSubview:dateLabel];
        _dateLabel = dateLabel;
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        [self.contentView addSubview:view];
        
        
        
        imageview.sd_layout
        .leftSpaceToView(midView,5)
        .centerYEqualToView(midView)
        .heightIs(10)
        .widthIs(15);
        
        
        
        titleLabel.sd_layout
        .leftSpaceToView(imageview,5)
        .centerYEqualToView(midView)
        .heightIs(10)
        .widthIs(120);
        
        
        
        dateLabel.sd_layout
        .leftSpaceToView(titleLabel,10)
        .rightSpaceToView(midView,10)
        .centerYEqualToView(midView)
        .heightIs(10);
        
        view.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0)
        .heightIs(1);

        
    }
    return self;
    
}

- (void)setInformationModel:(RSInformationModel *)informationModel{
    _informationModel = informationModel;
    _dateLabel.text = [NSString stringWithFormat:@"%@",_informationModel.publishTime];
    //    _pubilishLabel.text = [NSString stringWithFormat:@"%@",_informationModel.person];
    //    _styleLabel.text = [NSString stringWithFormat:@"%@",_informationModel.type];
    _titleLabel.text = [NSString stringWithFormat:@"%@",_informationModel.title];
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
