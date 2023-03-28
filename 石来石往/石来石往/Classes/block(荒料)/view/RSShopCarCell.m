//
//  RSShopCarCell.m
//  石来石往
//
//  Created by mac on 17/5/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSShopCarCell.h"

@implementation RSShopCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *contentview = [[UIView alloc]init];
        contentview.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentview];
        
        contentview.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .bottomEqualToView(self);
        
        UIImageView * redImageview = [[UIImageView alloc]init];
        redImageview.image = [UIImage imageNamed:@"椭圆-1"];
        [contentview addSubview:redImageview];
        
        redImageview.sd_layout
        .leftSpaceToView(contentview,12)
        .topSpaceToView(contentview,10.5)
        .heightIs(12)
        .widthIs(12);
        
        
        
        
        
        UILabel * blockNumberLabel = [[UILabel alloc]init];
        blockNumberLabel.text = @"荒料号";
        blockNumberLabel.font = [UIFont systemFontOfSize:16];
        blockNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [contentview addSubview:blockNumberLabel];
        
        UILabel * numberlabel = [[UILabel alloc]init];
        numberlabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        numberlabel.font = [UIFont systemFontOfSize:16];
        numberlabel.text = @"ESB000295/DH-539";
        [contentview addSubview:numberlabel];
        _numberlabel = numberlabel;
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.text = @"名  称";
        [contentview addSubview:nameLabel];
        
        UILabel *productLabel = [[UILabel alloc]init];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productLabel.font = [UIFont systemFontOfSize:16];
        productLabel.text = @"黄金麻";
        [contentview addSubview:productLabel];
        _productLabel = productLabel;
        //规格
        UILabel * ssLabel = [[UILabel alloc]init];
        ssLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        ssLabel.font = [UIFont systemFontOfSize:16];
        ssLabel.text = @"规  格";
        [contentview addSubview:ssLabel];
        
        UILabel * psLabel = [[UILabel alloc]init];
        psLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        psLabel.font = [UIFont systemFontOfSize:16];
        psLabel.text = @"1.8*1.8*2.4(m)";
        [contentview addSubview:psLabel];
        _psLabel = psLabel;
        
        
        //体积
        UILabel * tiLabel = [[UILabel alloc]init];
        tiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        tiLabel.font = [UIFont systemFontOfSize:16];
        tiLabel.text = @"体  积";
        [contentview addSubview:tiLabel];
        
        
        UILabel * tiDetailLabel = [[UILabel alloc]init];
        tiDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        tiDetailLabel.font = [UIFont systemFontOfSize:16];
        [contentview addSubview:tiDetailLabel];
        _tiDetailLabel = tiDetailLabel;
        
        
        
        RSHomeButtom * removeBtn = [[RSHomeButtom alloc]init];
        [removeBtn setImage:[UIImage imageNamed:@"k4"] forState:UIControlStateNormal];
        //[removeBtn setImage:[UIImage imageNamed:@"or-拷贝"] forState:UIControlStateSelected];
        self.removeBtn = removeBtn;
        [self.removeBtn addTarget:self action:@selector(removeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentview addSubview:removeBtn];
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [contentview addSubview:bottomview];
        
        
        
        blockNumberLabel.sd_layout
        .leftSpaceToView(redImageview,12)
        .topSpaceToView(contentview,10.5)
        .widthIs(50)
        .heightIs(20.5);
        
        numberlabel.sd_layout
        .leftSpaceToView(blockNumberLabel,10)
        .topEqualToView(blockNumberLabel)
        .bottomEqualToView(blockNumberLabel)
        .widthRatioToView(contentview,0.7);
        
        
        nameLabel.sd_layout
        .topSpaceToView(blockNumberLabel,10.5)
        .leftEqualToView(blockNumberLabel)
        .widthIs(50)
        .heightIs(20.5);
        
        productLabel.sd_layout
        .leftSpaceToView(nameLabel,10)
        .topEqualToView(nameLabel)
        .bottomEqualToView(nameLabel)
        .widthRatioToView(contentview,0.4);
        
        ssLabel.sd_layout
        .topSpaceToView(nameLabel,10.5)
        .leftEqualToView(nameLabel)
        .widthIs(50)
        .heightIs(20.5);
        
        psLabel.sd_layout
        .leftSpaceToView(ssLabel,10)
        .topEqualToView(ssLabel)
        .bottomEqualToView(ssLabel)
        .widthRatioToView(contentview,0.5);
        
        removeBtn.sd_layout
        .rightSpaceToView(contentview,12)
        .centerYEqualToView(contentview)
        .leftSpaceToView(productLabel,20)
        .widthIs(40)
        .heightIs(30);
        
        
        tiLabel.sd_layout
        .leftEqualToView(ssLabel)
        .rightEqualToView(ssLabel)
        .topSpaceToView(ssLabel, 10.5)
        .heightIs(20.5);
        
        tiDetailLabel.sd_layout
        .leftEqualToView(psLabel)
        .rightEqualToView(psLabel)
        .topEqualToView(tiLabel)
        .bottomEqualToView(tiLabel);
        
        
        bottomview.sd_layout
        .leftSpaceToView(contentview,12)
        .rightSpaceToView(contentview,12)
        .bottomSpaceToView(contentview,0)
        .heightIs(1);
        
        
        
    }
    
    return self;
}

- (void)removeBtnAction:(UIButton *)btn{
   
    if ([self.delegate respondsToSelector:@selector(removeDetailTableviewCell:)]) {
        [self.delegate removeDetailTableviewCell:btn.tag];
    }
    
    
    
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
