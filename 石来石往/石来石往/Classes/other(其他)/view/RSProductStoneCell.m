//
//  RSProductStoneCell.m
//  石来石往
//
//  Created by mac on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSProductStoneCell.h"


@interface RSProductStoneCell ()
{
    
    
    
    UILabel * _companyLaebl;
    
    UILabel * _lianLabel;
    
    
}

@end






@implementation RSProductStoneCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        UIImageView * imageview = [[UIImageView alloc]init];
        [self.contentView addSubview:imageview];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        imageview.userInteractionEnabled =  YES;
        _imageview = imageview;
        
        //公司名字
        UILabel * companyLaebl  = [[UILabel alloc]init];
        companyLaebl.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        companyLaebl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:companyLaebl];
        _companyLaebl = companyLaebl;
        
        //联系电话
        UILabel * lianLabel = [[UILabel alloc]init];
        //[lianLabel sizeToFit];
        lianLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        lianLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:lianLabel];
        _lianLabel = lianLabel;
        
        UILabel * phoneLabel = [[UILabel alloc]init];
        phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        phoneLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:phoneLabel];
        
        
        //数量
        UILabel * numLabel = [[UILabel alloc]init];
        numLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        numLabel.font = [UIFont systemFontOfSize:12];
        
        _numLabel = numLabel;
        
        [self.contentView addSubview:numLabel];
        
        
        //打电话
        UIButton * playPhoneBtn = [[UIButton alloc]init];
        _playPhoneBtn = playPhoneBtn;
        [playPhoneBtn setImage:[UIImage imageNamed:@"打电话-正常"] forState:UIControlStateNormal];
        [playPhoneBtn setImage:[UIImage imageNamed:@"打电话点击"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:playPhoneBtn];
        
        
        
        //底部分割线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        
        playPhoneBtn.sd_layout
        .rightSpaceToView(self.contentView, 13)
        .topSpaceToView(self.contentView, 30)
        .bottomSpaceToView(self.contentView, 30)
        .widthIs(41);
        
        
        
        
        
        
        
        imageview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 10)
        .widthIs(109);
        
        
        
        
        
        
        
        companyLaebl.sd_layout
        .leftSpaceToView(imageview, 10)
        .topSpaceToView(self.contentView, 25)
        .rightSpaceToView(playPhoneBtn, 10)
        .heightIs(14);
        
        
        lianLabel.sd_layout
        .topSpaceToView(companyLaebl, 9)
        .leftEqualToView(companyLaebl)
        .rightEqualToView(companyLaebl)
        .heightIs(14);
        
        
        phoneLabel.sd_layout
        .leftSpaceToView(lianLabel, 0)
        .rightEqualToView(companyLaebl)
        .bottomEqualToView(lianLabel)
        .topEqualToView(lianLabel);
        
        
        
        numLabel.sd_layout
        .leftEqualToView(lianLabel)
        .topSpaceToView(lianLabel, 9)
        .bottomSpaceToView(self.contentView, 15)
        .rightEqualToView(phoneLabel);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
        
        
        
        
        
    }
    return self;
    
    
}


- (void)setPicturepathmodel:(RSPicturePathModel *)picturepathmodel{
    _picturepathmodel = picturepathmodel;
    
    
    
    
    if (picturepathmodel.logo.count >= 1) {
        //URL_HEADER_TEXT_IOS
         [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picturepathmodel.logo objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"512"]];
    }else{
        _imageview.image = [UIImage imageNamed:@"512"];
    }
    
   
    _companyLaebl.text = [NSString stringWithFormat:@"%@",_picturepathmodel.name];
    _lianLabel.text = [NSString stringWithFormat:@"联系电话:%@",_picturepathmodel.phone];
    
    
    
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
