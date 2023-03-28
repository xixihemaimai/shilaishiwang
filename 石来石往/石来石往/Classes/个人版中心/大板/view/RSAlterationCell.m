//
//  RSAlterationCell.m
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSAlterationCell.h"

@implementation RSAlterationCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        //物料
        UILabel * alterationLabel = [[UILabel alloc]init];
        alterationLabel.font = [UIFont systemFontOfSize:15];
        alterationLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        alterationLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:alterationLabel];
        _alterationLabel = alterationLabel;
        //物料详情
        UITextField * alterationDetailLabel = [[UITextField alloc]init];
        alterationDetailLabel.font = [UIFont systemFontOfSize:15];
        alterationDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        alterationDetailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:alterationDetailLabel];
        _alterationDetailLabel = alterationDetailLabel;
        
        //按键
        UIButton * alterationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [alterationBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
        [self.contentView addSubview:alterationBtn];
        _alterationBtn = alterationBtn;
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        alterationLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(21)
        .widthRatioToView(self.contentView, 0.2);
    
        alterationDetailLabel.sd_layout
        .leftSpaceToView(alterationLabel, 34)
        .centerYEqualToView(self.contentView)
        .heightIs(21)
        .widthRatioToView(self.contentView, 0.5);

        
        alterationBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(28)
        .widthEqualToHeight();
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
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
