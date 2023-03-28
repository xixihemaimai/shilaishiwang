//
//  RSUserManagementCell.m
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSUserManagementCell.h"

@implementation RSUserManagementCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        //        UIView * materiaManagementView = [[UIView alloc]init];
        //        materiaManagementView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        //        [self.contentView addSubview:materiaManagementView];
        
        
        UIImageView * materiaManagementImageView = [[UIImageView alloc]init];
        materiaManagementImageView.image = [UIImage imageNamed:@"角色"];
        [self.contentView addSubview:materiaManagementImageView];
        
        
        //搜索名称
        //        UILabel * materiaManagemnetNameLabel = [[UILabel alloc]init];
        //        materiaManagemnetNameLabel.text = @"白";
        //        materiaManagemnetNameLabel.font = [UIFont systemFontOfSize:16];
        //        materiaManagemnetNameLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        //        materiaManagemnetNameLabel.textAlignment = NSTextAlignmentCenter;
        //        [materiaManagementImageView addSubview:materiaManagemnetNameLabel];
        
        
        //物料名称内容
        UILabel * nameDetialLabel  = [[UILabel alloc]init];
        nameDetialLabel.text = @"13950800222";
        nameDetialLabel.font = [UIFont systemFontOfSize:16];
        nameDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameDetialLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameDetialLabel];
        _nameDetialLabel = nameDetialLabel;
        
        
        //物料类型
        //        UILabel * materiaManagemnetTypeLabel = [[UILabel alloc]init];
        //        materiaManagemnetTypeLabel.text = @"物料类型:";
        //        materiaManagemnetTypeLabel.font = [UIFont systemFontOfSize:16];
        //        materiaManagemnetTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        //        materiaManagemnetTypeLabel.textAlignment = NSTextAlignmentLeft;
        //        [materiaManagementView addSubview:materiaManagemnetTypeLabel];
        
        //物料类型内容
     UILabel * typeDetialLabel  = [[UILabel alloc]init];
       typeDetialLabel.text = @"销售";
                typeDetialLabel.font = [UIFont systemFontOfSize:14];
                typeDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
                typeDetialLabel.textAlignment = NSTextAlignmentLeft;
                [self.contentView addSubview:typeDetialLabel];
        _typeDetialLabel = typeDetialLabel;
        
        
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
        
        
        //        materiaManagementView.sd_layout
        //        .leftSpaceToView(self.contentView, 12)
        //        .rightSpaceToView(self.contentView, 12)
        //        .topSpaceToView(self.contentView, 10)
        //        .bottomEqualToView(self.contentView);
        
        
        materiaManagementImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(32)
        .heightEqualToWidth();
        
        
        //        materiaManagemnetNameLabel.sd_layout
        //        .centerXEqualToView(materiaManagementImageView)
        //        .centerYEqualToView(materiaManagementImageView)
        //        .leftSpaceToView(materiaManagementImageView, 0)
        //        .rightSpaceToView(materiaManagementImageView, 0)
        //        .topSpaceToView(materiaManagementImageView, 0)
        //        .bottomSpaceToView(materiaManagementImageView, 0);
        
        
        //        materiaManagemnetTypeLabel.sd_layout
        //        .leftEqualToView(materiaManagemnetNameLabel)
        //        .rightEqualToView(materiaManagemnetNameLabel)
        //        .topSpaceToView(materiaManagemnetNameLabel, 5)
        //        .heightIs(23);
        
        
       nameDetialLabel.sd_layout
       .leftSpaceToView(materiaManagementImageView, 10)
       .topSpaceToView(self.contentView, 15)
       .heightIs(23)
       .widthRatioToView(self.contentView, 0.4);
        
       typeDetialLabel.sd_layout
       .leftEqualToView(nameDetialLabel)
       .rightEqualToView(nameDetialLabel)
       .topSpaceToView(nameDetialLabel, 0)
       .bottomSpaceToView(self.contentView, 11);
        
        
        
        //materiaManagementView.layer.cornerRadius = 3;
        //materiaManagementImageView.layer.cornerRadius = 3;
        
        
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
