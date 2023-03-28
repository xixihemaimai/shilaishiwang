//
//  RSBlockOutCell.m
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSBlockOutCell.h"

@interface RSBlockOutCell ()


@end

@implementation RSBlockOutCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
        [self addSubview:view];
        
        
        view.sd_layout
        .leftSpaceToView(self,0)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .rightSpaceToView(self,0);
        
        
        UIView *contview = [[UIView alloc]init];
        contview.backgroundColor = [UIColor whiteColor];
        [view addSubview:contview];
        
    
        contview.sd_layout
        .leftSpaceToView(view,0)
        .rightSpaceToView(view,0)
        .topSpaceToView(view,0)
        .heightIs(102.5);
        
        
        UIImageView * redImageview = [[UIImageView alloc]init];
        redImageview.image = [UIImage imageNamed:@"椭圆-1"];
        [contview addSubview:redImageview];
        
        redImageview.sd_layout
        .leftSpaceToView(contview,12)
        .topSpaceToView(contview,10.5)
        .heightIs(12)
        .widthIs(12);
        
        UILabel * blockNumberLabel = [[UILabel alloc]init];
        blockNumberLabel.text = @"荒料号";
        blockNumberLabel.font = [UIFont systemFontOfSize:16];
        blockNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [contview addSubview:blockNumberLabel];
        
        UILabel * numberlabel = [[UILabel alloc]init];
        numberlabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        numberlabel.font = [UIFont systemFontOfSize:16];
        numberlabel.text = @"ESB000295/DH-539";
        [contview addSubview:numberlabel];
        _numberlabel = numberlabel;
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.text = @"名  称";
        [contview addSubview:nameLabel];
        
        UILabel *productLabel = [[UILabel alloc]init];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productLabel.font = [UIFont systemFontOfSize:16];
        productLabel.text = @"黄金麻";
        [contview addSubview:productLabel];
        _productLabel = productLabel;
        //规格
        UILabel * ssLabel = [[UILabel alloc]init];
        ssLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        ssLabel.font = [UIFont systemFontOfSize:16];
        ssLabel.text = @"规  格";
        [contview addSubview:ssLabel];
        
        UILabel * psLabel = [[UILabel alloc]init];
        psLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        psLabel.font = [UIFont systemFontOfSize:16];
        psLabel.text = @"1.8*1.8*2.4(m)";
        [contview addSubview:psLabel];
        _psLabel = psLabel;
        
        RSHomeButtom * choicebtn = [[RSHomeButtom alloc]init];
        [choicebtn setImage:[UIImage imageNamed:@"oq"] forState:UIControlStateNormal];
        [choicebtn setImage:[UIImage imageNamed:@"or-拷贝"] forState:UIControlStateSelected];
        self.choiceBtn = choicebtn;
        [self.choiceBtn addTarget:self action:@selector(choseBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [contview addSubview:choicebtn];
        
        
        
        
        blockNumberLabel.sd_layout
        .leftSpaceToView(redImageview,12)
        .topSpaceToView(contview,7.5)
        .widthIs(50)
        .heightIs(20.5);
        
        numberlabel.sd_layout
        .leftSpaceToView(blockNumberLabel,10)
        .topEqualToView(blockNumberLabel)
        .bottomEqualToView(blockNumberLabel)
        .widthRatioToView(contview,0.7);
        
        
        nameLabel.sd_layout
        .topSpaceToView(blockNumberLabel,10.5)
        .leftEqualToView(blockNumberLabel)
        .widthIs(50)
        .heightIs(20.5);
        
        productLabel.sd_layout
        .leftSpaceToView(nameLabel,10)
        .topEqualToView(nameLabel)
        .bottomEqualToView(nameLabel)
        .widthRatioToView(contview,0.4);
        
        ssLabel.sd_layout
        .topSpaceToView(nameLabel,10.5)
        .leftEqualToView(nameLabel)
        .widthIs(50)
        .heightIs(20.5);
        
        psLabel.sd_layout
        .leftSpaceToView(ssLabel,10)
        .topEqualToView(ssLabel)
        .bottomEqualToView(ssLabel)
        .widthRatioToView(contview,0.45);
        
        choicebtn.sd_layout
        .rightSpaceToView(contview,12)
        .centerYEqualToView(contview)
        .leftSpaceToView(productLabel,20)
        .widthIs(50)
        .heightIs(30);
        
        
    }
    return self;
}

- (void)choseBtnAction{
    self.choiceBtn.selected = !self.choiceBtn.selected;
    //判端这个BLOCK是不是为selectedStutas空，要是不加判断，为空的话，就会崩掉
    if (self.ChoseBtnBlock) {
        self.ChoseBtnBlock(self, self.choiceBtn.selected);
    }
}

- (void)setSelectedStutas:(BOOL)selectedStutas{
    self.choiceBtn.selected = selectedStutas;
}




//- (void)setBlockmodel:(RSBlockModel *)blockmodel{
//    
//    _blockmodel = blockmodel;
//    
//    
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
