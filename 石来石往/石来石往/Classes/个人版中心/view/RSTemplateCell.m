//
//  RSTemplateCell.m
//  石来石往
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSTemplateCell.h"

@implementation RSTemplateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];

        //物料名称内容
        UILabel * nameDetialLabel  = [[UILabel alloc]init];
        nameDetialLabel.text = @"13950800222";
        nameDetialLabel.font = [UIFont systemFontOfSize:15];
        nameDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameDetialLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameDetialLabel];
        _nameDetialLabel = nameDetialLabel;
        
        
        //状态
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:statusLabel];
        _statusLabel = statusLabel;
        
        
        
        //编辑
        UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [self.contentView addSubview:editBtn];
        _editBtn = editBtn;
        
        //中间横线
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:midView];
        
        
        //删除
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [self.contentView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        
        //底部横线
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomView];
        


        
        
        nameDetialLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .heightIs(23)
        .widthRatioToView(self.contentView, 0.5);
        
        
        statusLabel.sd_layout
        .leftEqualToView(nameDetialLabel)
        .topSpaceToView(nameDetialLabel, 0)
        .rightEqualToView(nameDetialLabel)
        .bottomSpaceToView(self.contentView, 5);
        

        
        deleteBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 11)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5)
        .widthIs(40);
        
        midView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(deleteBtn, 9)
        .heightIs(20)
        .widthIs(1);
        
        editBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(midView, 9)
        .widthIs(40)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5);
        
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
