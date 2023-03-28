//
//  RSAddingBlocksCell.m
//  石来石往
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSAddingBlocksCell.h"

@implementation RSAddingBlocksCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //物料
        UILabel * productNameLabel = [[UILabel alloc]init];
        productNameLabel.font = [UIFont systemFontOfSize:15];
        productNameLabel.textAlignment = NSTextAlignmentLeft;
        productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:productNameLabel];
        _productNameLabel = productNameLabel;
        //提示语
        UITextField * productTextField = [[UITextField alloc]init];
        productTextField.placeholder = @"请选择物料名称";
        productTextField.font = [UIFont systemFontOfSize:15];
        productTextField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productTextField.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:productTextField];
        _productTextField = productTextField;
        
        //选择
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
        [self.contentView addSubview:addBtn];
        _addBtn = addBtn;
        
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomView];
        
        productNameLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(62)
        .heightIs(21);
        
        
        productTextField.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(productNameLabel, 23)
        .widthRatioToView(self.contentView, 0.5)
        .heightIs(21);
        
        
        addBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(28)
        .widthEqualToHeight();
        
        bottomView.sd_layout
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
