//
//  RSSLSpotShowAreaCell.m
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLSpotShowAreaCell.h"

@implementation RSSLSpotShowAreaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        
        //视图
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:showView];
        
        
        //荒料号
        UILabel * showProductLabel = [[UILabel alloc]init];
        showProductLabel.text = @"ESB00295/DH-539";
        showProductLabel.textAlignment = NSTextAlignmentLeft;
        showProductLabel.font = [UIFont systemFontOfSize:15];
        showProductLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:showProductLabel];
        _showProductLabel = showProductLabel;
        
        //匝号
        UILabel * showTurnLabel = [[UILabel alloc]init];
        showTurnLabel.text = @"匝号：5-1";
        showTurnLabel.textAlignment = NSTextAlignmentLeft;
        showTurnLabel.font = [UIFont systemFontOfSize:14];
        showTurnLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:showTurnLabel];
        _showTurnLabel = showTurnLabel;
        
        
        
        //选中按键
        UIButton * showSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [showSelectBtn setImage:[UIImage imageNamed:@"Oval 9"] forState:UIControlStateNormal];
        [showSelectBtn setImage:[UIImage imageNamed:@"个人选中"] forState:UIControlStateSelected];
        [showView addSubview:showSelectBtn];
        _showSelectBtn = showSelectBtn;
        [showSelectBtn addTarget:self action:@selector(choseBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        //上割线
        UIView * topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [showView addSubview:topView];
        
        
        //物料名称
        UILabel * showNameLabel = [[UILabel alloc]init];
        showNameLabel.text = @"物料名称：";
        showNameLabel.textAlignment = NSTextAlignmentLeft;
        showNameLabel.font = [UIFont systemFontOfSize:15];
        showNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [showView addSubview:showNameLabel];
        
        
        UILabel * showNameDetailLabel = [[UILabel alloc]init];
        showNameDetailLabel.text = @"白玉兰";
        showNameDetailLabel.textAlignment = NSTextAlignmentRight;
        showNameDetailLabel.font = [UIFont systemFontOfSize:15];
        showNameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:showNameDetailLabel];
        _showNameDetailLabel = showNameDetailLabel;
        //物料类型
        UILabel * showTypeLabel = [[UILabel alloc]init];
        showTypeLabel.text = @"物料类型：";
        showTypeLabel.textAlignment = NSTextAlignmentLeft;
        showTypeLabel.font = [UIFont systemFontOfSize:15];
        showTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [showView addSubview:showTypeLabel];
        
        
        UILabel * showTypeDetailLabel = [[UILabel alloc]init];
        showTypeDetailLabel.text = @"大理石";
        showTypeDetailLabel.textAlignment = NSTextAlignmentRight;
        showTypeDetailLabel.font = [UIFont systemFontOfSize:15];
        showTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:showTypeDetailLabel];
        _showTypeDetailLabel = showTypeDetailLabel;
        //长宽高
        UILabel * showShapeLabel = [[UILabel alloc]init];
        showShapeLabel.text = @"长宽：";
        showShapeLabel.textAlignment = NSTextAlignmentLeft;
        showShapeLabel.font = [UIFont systemFontOfSize:15];
        showShapeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [showView addSubview:showShapeLabel];
        
        UILabel * showShapeDetailLabel = [[UILabel alloc]init];
        showShapeDetailLabel.text = @"0.1 | 3.3";
        showShapeDetailLabel.textAlignment = NSTextAlignmentRight;
        showShapeDetailLabel.font = [UIFont systemFontOfSize:15];
        showShapeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:showShapeDetailLabel];
        _showShapeDetailLabel = showShapeDetailLabel;
        
        //体积
        UILabel * showAreaLabel = [[UILabel alloc]init];
        showAreaLabel.text = @"厚(cm)：";
        showAreaLabel.textAlignment = NSTextAlignmentLeft;
        showAreaLabel.font = [UIFont systemFontOfSize:15];
        showAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [showView addSubview:showAreaLabel];
        
        UILabel * showAreaDetailLabel = [[UILabel alloc]init];
        showAreaDetailLabel.text = @"5.883";
        showAreaDetailLabel.textAlignment = NSTextAlignmentRight;
        showAreaDetailLabel.font = [UIFont systemFontOfSize:15];
        showAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:showAreaDetailLabel];
        _showAreaDetailLabel = showAreaDetailLabel;
        
        //重量
        UILabel * showWightLabel = [[UILabel alloc]init];
        showWightLabel.text = @"面积(m²)：";
        showWightLabel.textAlignment = NSTextAlignmentLeft;
        showWightLabel.font = [UIFont systemFontOfSize:15];
        showWightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [showView addSubview:showWightLabel];
        
        
        UILabel * showWightDetailLabel = [[UILabel alloc]init];
        showWightDetailLabel.text = @"5.445";
        showWightDetailLabel.textAlignment = NSTextAlignmentRight;
        showWightDetailLabel.font = [UIFont systemFontOfSize:15];
        showWightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:showWightDetailLabel];
        _showWightDetailLabel = showWightDetailLabel;
        
        //下割线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [showView addSubview:bottomview];
        
        
        //完善图片
        UIButton * completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [completeBtn setTitle:@"完善图片" forState:UIControlStateNormal];
        [completeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        completeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [showView addSubview:completeBtn];
        _completeBtn = completeBtn;
        
        showView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        showProductLabel.sd_layout
        .leftSpaceToView(showView, 8)
        .topSpaceToView(showView, 10)
        .heightIs(21)
        .widthRatioToView(showView, 0.5);
        
        showTurnLabel.sd_layout
        .leftEqualToView(showProductLabel)
        .rightEqualToView(showProductLabel)
        .topSpaceToView(showProductLabel, 0)
        .heightIs(21);
        
        
        
        showSelectBtn.sd_layout
        .rightSpaceToView(showView, 15)
        .topSpaceToView(showView, 12)
        .widthIs(25)
        .heightEqualToWidth();
        
        
        topView.sd_layout
        .leftSpaceToView(showView, 0)
        .rightSpaceToView(showView, 0)
        .heightIs(1)
        .topSpaceToView(showTurnLabel, 8);
        
        showNameLabel.sd_layout
        .leftSpaceToView(showView, 16)
        .topSpaceToView(topView, 13)
        .heightIs(21)
        .widthIs(100);
        
        
        showNameDetailLabel.sd_layout
        .rightSpaceToView(showView, 12)
        .topEqualToView(showNameLabel)
        .bottomEqualToView(showNameLabel)
        .widthRatioToView(showView, 0.5);
        
        
        showTypeLabel.sd_layout
        .leftEqualToView(showNameLabel)
        .rightEqualToView(showNameLabel)
        .topSpaceToView(showNameLabel, 3)
        .heightIs(21);
        
        showTypeDetailLabel.sd_layout
        .rightEqualToView(showNameDetailLabel)
        .leftEqualToView(showNameDetailLabel)
        .topEqualToView(showTypeLabel)
        .bottomEqualToView(showTypeLabel);
        
        showShapeLabel.sd_layout
        .leftEqualToView(showTypeLabel)
        .rightEqualToView(showTypeLabel)
        .topSpaceToView(showTypeLabel, 3)
        .heightIs(21);
        
        showShapeDetailLabel.sd_layout
        .leftEqualToView(showTypeDetailLabel)
        .rightEqualToView(showTypeDetailLabel)
        .topEqualToView(showShapeLabel)
        .bottomEqualToView(showShapeLabel);
        
        showAreaLabel.sd_layout
        .topSpaceToView(showShapeLabel, 3)
        .leftEqualToView(showShapeLabel)
        .rightEqualToView(showShapeLabel)
        .heightIs(21);
        
        showAreaDetailLabel.sd_layout
        .leftEqualToView(showShapeDetailLabel)
        .rightEqualToView(showShapeDetailLabel)
        .topEqualToView(showAreaLabel)
        .bottomEqualToView(showAreaLabel);
        
        showWightLabel.sd_layout
        .leftEqualToView(showAreaLabel)
        .rightEqualToView(showAreaLabel)
        .topSpaceToView(showAreaLabel, 3)
        .heightIs(21);
        
        showWightDetailLabel.sd_layout
        .topEqualToView(showWightLabel)
        .bottomEqualToView(showWightLabel)
        .leftEqualToView(showAreaDetailLabel)
        .rightEqualToView(showAreaDetailLabel);
        
        bottomview.sd_layout
        .leftSpaceToView(showView, 0)
        .rightSpaceToView(showView, 0)
        .heightIs(1)
        .topSpaceToView(showWightLabel, 9);
        
        completeBtn.sd_layout
        .rightSpaceToView(showView, 15)
        .topSpaceToView(bottomview, 12)
        .heightIs(28)
        .widthIs(76);
        
        completeBtn.layer.cornerRadius = 15;
        completeBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#3385ff"].CGColor;
        completeBtn.layer.borderWidth = 1;
    }
    return self;
}


- (void)choseBtnAction{
    self.showSelectBtn.selected = !self.showSelectBtn.selected;
    //判端这个BLOCK是不是为selectedStutas空，要是不加判断，为空的话，就会崩掉
    if (self.ChoseBtnBlock) {
        self.ChoseBtnBlock(self, self.showSelectBtn.selected);
    }
}
- (void)setSelectedStutas:(BOOL)selectedStutas{
    self.showSelectBtn.selected = selectedStutas;
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
