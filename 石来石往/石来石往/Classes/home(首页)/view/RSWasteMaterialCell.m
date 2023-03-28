//
//  RSWasteMaterialCell.m
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSWasteMaterialCell.h"



@interface RSWasteMaterialCell()
{
    
    
    UIImageView * _informationImageView;
    
    UILabel * _nameLabel;
    
    
    
}

@end


@implementation RSWasteMaterialCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      //图片
        UIImageView * informationImageView = [[UIImageView alloc]init];
       // informationImageView.image = [UIImage imageNamed:@"图片加载失败"];
        informationImageView.contentMode = UIViewContentModeScaleAspectFill;
        informationImageView.clipsToBounds = YES;
        informationImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:informationImageView];
        _informationImageView = informationImageView;
        
        //名字
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.text = @"黑晶玉";
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        //片数
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.font = [UIFont systemFontOfSize:15];
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        numberLabel.text = @"33";
        [self.contentView addSubview:numberLabel];
        _numberLabel = numberLabel;
        
        //面积
        UILabel * areaLabel = [[UILabel alloc]init];
        areaLabel.textAlignment = NSTextAlignmentLeft;
        areaLabel.font = [UIFont systemFontOfSize:15];
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        areaLabel.text = @"2345m²";
        [self.contentView addSubview:areaLabel];
        _areaLabel = areaLabel;
        
        //底部分割线
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomView];
        
        
        
        informationImageView.sd_layout
        .leftSpaceToView(self.contentView, 13)
        .centerYEqualToView(self.contentView)
        .widthIs(144)
        .topSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 12);
        
        
        informationImageView.layer.cornerRadius = 6;
        informationImageView.layer.masksToBounds = YES;
        
        
        nameLabel.sd_layout
        .leftSpaceToView(informationImageView, 18)
        .topSpaceToView(self.contentView, 29)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(14);
        
        
        numberLabel.sd_layout
        .leftEqualToView(nameLabel)
        .topSpaceToView(nameLabel, 10)
        .heightIs(14)
        .rightEqualToView(nameLabel);
        
        
        areaLabel.sd_layout
        .leftEqualToView(numberLabel)
        .rightEqualToView(numberLabel)
        .topSpaceToView(numberLabel, 10)
        .heightIs(14);
        
        
        bottomView.sd_layout
        .leftSpaceToView(self.contentView, 13)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);

    }
    return self;
}


- (void)setMasteMainModel:(RSMasteMainModel *)masteMainModel{
    _masteMainModel = masteMainModel;
        
    [_informationImageView sd_setImageWithURL:[NSURL URLWithString:_masteMainModel.photos[0]] placeholderImage:[UIImage imageNamed:@"512"]];
    
    _nameLabel.text = _masteMainModel.stoneName;
    
    

    UITapGestureRecognizer  * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMasteMainModelPicture:)];
    [_informationImageView addGestureRecognizer:tap];

}

- (void)showMasteMainModelPicture:(UITapGestureRecognizer *)tap{
    [HUPhotoBrowser showFromImageView:_informationImageView withURLStrings:self.masteMainModel.photos atIndex:0];
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
