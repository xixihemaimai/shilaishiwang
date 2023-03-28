//
//  RSWarehouseManamentCell.m
//  石来石往
//
//  Created by mac on 2019/2/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSWarehouseManamentCell.h"

@implementation RSWarehouseManamentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //图片
        UIImageView * warehouseImageView = [[UIImageView alloc]init];
        warehouseImageView.image = [UIImage imageNamed:@"荒"];
        warehouseImageView.contentMode = UIViewContentModeScaleAspectFill;
        warehouseImageView.clipsToBounds = YES;
        [self.contentView addSubview:warehouseImageView];
        _warehouseImageView = warehouseImageView;
        //仓库位置
        UILabel * warehouseLabel = [[UILabel alloc]init];
        warehouseLabel.text = @"一号仓库";
        warehouseLabel.font = [UIFont systemFontOfSize:16];
        warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        warehouseLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:warehouseLabel];
        _warehouseLabel = warehouseLabel;
        
        //仓库类型
        UILabel * warehouseTyleLabel = [[UILabel alloc]init];
        warehouseTyleLabel.text = @"荒料仓";
        warehouseTyleLabel.font = [UIFont systemFontOfSize:14];
        warehouseTyleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        warehouseTyleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:warehouseTyleLabel];
        _warehouseTyleLabel = warehouseTyleLabel;
        
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
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [self.contentView addSubview:cancelBtn];
        _cancelBtn = cancelBtn;
        
        
        
        //底部横线
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomView];
        
        
        
        
        
        
        warehouseImageView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(32)
        .heightEqualToWidth();
        
        
        
        warehouseLabel.sd_layout
        .leftSpaceToView(warehouseImageView, 8)
        .topSpaceToView(self.contentView, 11)
        .heightIs(23)
        .widthRatioToView(self.contentView, 0.5);
        
        
        
        
        warehouseTyleLabel.sd_layout
        .leftEqualToView(warehouseLabel)
        .topSpaceToView(warehouseLabel, 0)
        .heightIs(20)
        .rightEqualToView(warehouseLabel);
        
        
        
        cancelBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(40)
        .widthIs(40);
        
        
        midView.sd_layout
        .rightSpaceToView(cancelBtn, 9)
        .centerYEqualToView(self.contentView)
        .heightIs(20)
        .widthIs(1);
        
        
        editBtn.sd_layout
        .rightSpaceToView(midView, 9)
        .centerYEqualToView(self.contentView)
        .heightIs(40)
        .widthIs(40);
        
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
