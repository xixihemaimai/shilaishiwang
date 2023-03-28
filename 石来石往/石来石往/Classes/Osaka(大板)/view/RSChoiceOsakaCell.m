//
//  RSChoiceOsakaCell.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSChoiceOsakaCell.h"

@implementation RSChoiceOsakaCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        view.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .heightIs(105);
        
        UIImageView * redImageview = [[UIImageView alloc]init];
        redImageview.image = [UIImage imageNamed:@"椭圆-1"];
        [view addSubview:redImageview];
        
        redImageview.sd_layout
        .leftSpaceToView(view,12)
        .topSpaceToView(view,10.5)
        .heightIs(12)
        .widthIs(12);
        
        UILabel * blockNumberLabel = [[UILabel alloc]init];
        blockNumberLabel.text = @"荒料号";
        blockNumberLabel.font = [UIFont systemFontOfSize:16];
        blockNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [view addSubview:blockNumberLabel];
        
        UILabel * numberlabel = [[UILabel alloc]init];
        numberlabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        numberlabel.font = [UIFont systemFontOfSize:16];
        numberlabel.text = @"ESB000295/DH-539";
        [view addSubview:numberlabel];
        _numberlabel = numberlabel;
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.text = @"名  称";
        [view addSubview:nameLabel];
        
        UILabel *productLabel = [[UILabel alloc]init];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productLabel.font = [UIFont systemFontOfSize:16];
        productLabel.text = @"黄金麻";
        [view addSubview:productLabel];
        _productLabel = productLabel;
        //已选
        UILabel * ssLabel = [[UILabel alloc]init];
        ssLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        ssLabel.font = [UIFont systemFontOfSize:16];
        ssLabel.text = @"已  选";
        [view addSubview:ssLabel];
        
        UILabel * choiceCountLabel = [[UILabel alloc]init];
        choiceCountLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        choiceCountLabel.font = [UIFont systemFontOfSize:16];
        choiceCountLabel.text = @"1.8*1.8*2.4(m)";
        [view addSubview:choiceCountLabel];
        _choiceCountLabel = choiceCountLabel;
        
        RSHomeButtom * modifyBtn = [[RSHomeButtom alloc]init];
        [modifyBtn setImage:[UIImage imageNamed:@"k3"] forState:UIControlStateNormal];
        //[removeBtn setImage:[UIImage imageNamed:@"or-拷贝"] forState:UIControlStateSelected];
        self.modifyBtn = modifyBtn;
        //[modifyBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:modifyBtn];
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [view addSubview:bottomview];
        
        
        
        blockNumberLabel.sd_layout
        .leftSpaceToView(redImageview,12)
        .topSpaceToView(view,10.5)
        .widthIs(50)
        .heightIs(20.5);
        
        numberlabel.sd_layout
        .leftSpaceToView(blockNumberLabel,10)
        .topEqualToView(blockNumberLabel)
        .bottomEqualToView(blockNumberLabel)
        .widthRatioToView(view,0.7);
        
        
        nameLabel.sd_layout
        .topSpaceToView(blockNumberLabel,10.5)
        .leftEqualToView(blockNumberLabel)
        .widthIs(50)
        .heightIs(20.5);
        
        productLabel.sd_layout
        .leftSpaceToView(nameLabel,10)
        .topEqualToView(nameLabel)
        .bottomEqualToView(nameLabel)
        .widthRatioToView(view,0.4);
        
        ssLabel.sd_layout
        .topSpaceToView(nameLabel,10.5)
        .leftEqualToView(nameLabel)
        .widthIs(50)
        .heightIs(20.5);
        
        choiceCountLabel.sd_layout
        .leftSpaceToView(ssLabel,10)
        .topEqualToView(ssLabel)
        .bottomEqualToView(ssLabel)
        .widthRatioToView(view,0.4);
        
        modifyBtn.sd_layout
        .rightSpaceToView(view,12)
        .centerYEqualToView(view)
        .leftSpaceToView(productLabel,20)
        .widthIs(40)
        .heightIs(30);
        
        bottomview.sd_layout
        .leftSpaceToView(view,12)
        .rightSpaceToView(view,12)
        .bottomSpaceToView(view,0)
        .heightIs(1);
    }
    
    return self;
    
    
}
- (void)setOsakaModel:(RSOsakaModel *)osakaModel{
    _osakaModel = osakaModel;
    
    _numberlabel.text = [NSString stringWithFormat:@"%@/%@",osakaModel.erpid,osakaModel.blockID];
    _productLabel.text = [NSString stringWithFormat:@"%@",osakaModel.blockName];
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
