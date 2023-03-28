//
//  RSCollectCell.m
//  石来石往
//
//  Created by mac on 17/5/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSCollectCell.h"


@interface RSCollectCell ()

{
    //用户
    UILabel * _Label;
    //电话
//    UILabel * _phoneLabel;
    //石种
    UILabel * _stoneLabel;
    
    //荒料号
    UILabel * _blockLabel;
    
    //规格
    UILabel * _ruleLabel;
    //面积
    UILabel * _physiqueLabel;
    
    
    //仓储位置
    UILabel * _storageLabel;
    
    
    //重量
    UILabel * _weightLabel;
    
    
    
    //体积
    UILabel * _tiLabel;
    
    
    
    UILabel * _zhongLabel;
    
}

@end

@implementation RSCollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        UIView * headerview = [[UIView alloc]init];
//        headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
//        [self.contentView addSubview:headerview];
        
        CGFloat withtd = 0.00;
        if (iPhone4 || iPhone5) {
            withtd = 160;
        }else{
            withtd = 200;
        }
//        headerview.sd_layout
//        .leftSpaceToView(self.contentView,0)
//        .rightSpaceToView(self.contentView,0)
//        .topSpaceToView(self.contentView,0)
//        .heightIs(200);
        
        UIView * producetview = [[UIView alloc]init];
        producetview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:producetview];
        //电话部分
        UILabel * Label = [[UILabel alloc]init];
        Label.text = @"石来石往货主";
        _Label = Label;
        Label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        Label.font = [UIFont systemFontOfSize:16];
        [producetview addSubview:Label];
        
        UILabel * label1 = [[UILabel alloc]init];
        label1.text = @"电话:";
        label1.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        label1.font = [UIFont systemFontOfSize:14];
        [producetview addSubview:label1];
        
        UILabel *phoneLabel = [[UILabel alloc]init];
        phoneLabel.text = @"18925353565";
        phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel = phoneLabel;
        
        phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        phoneLabel.font = [UIFont systemFontOfSize:14];
        [producetview addSubview:phoneLabel];
        
        producetview.sd_layout
        .leftSpaceToView(self.contentView ,0)
        .rightSpaceToView(self.contentView ,0)
        .topSpaceToView(self.contentView ,0)
        .heightIs(39);
        
        Label.sd_layout
        .leftSpaceToView(producetview,12)
        .topSpaceToView(producetview,9.5)
        .bottomSpaceToView(producetview,9.5)
        .widthIs(withtd)
        .heightIs(15);
        
        
        
        phoneLabel.sd_layout
        .rightSpaceToView(producetview, 12)
        .topEqualToView(Label)
        .bottomEqualToView(Label)
        .widthIs(100);
        
        label1.sd_layout
        .rightSpaceToView(phoneLabel, 0)
        .widthIs(35)
        .topEqualToView(phoneLabel)
        .bottomEqualToView(phoneLabel);
        
        
/*
        label1.sd_layout
        .leftSpaceToView(Label,0)
        .topEqualToView(Label)
        .bottomEqualToView(Label)
        .widthIs(35);
        
        
        
        phoneLabel.sd_layout
        .leftSpaceToView(label1,0)
        .topEqualToView(label1)
        .bottomEqualToView(label1)
        .rightSpaceToView(producetview,12);
        
  */
        //内容部分
        UIView * midview = [[UIView alloc]init];
        midview.backgroundColor = [UIColor whiteColor];
        [self.contentView  addSubview:midview];
        midview.sd_layout
        .leftSpaceToView(self.contentView ,0)
        .rightSpaceToView(self.contentView ,0)
        .topSpaceToView(producetview,1)
        .heightIs(117);
//
//        UIView *topview = [[UIView alloc]init];
//        topview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
//        [midview addSubview:topview];
//
//        topview.sd_layout
//        .leftSpaceToView(midview,12)
//        .rightSpaceToView(midview,12)
//        .topSpaceToView(midview,0)
//        .heightIs(1);
        
        
//        UIView *bottomview = [[UIView alloc]init];
//        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
//        [midview addSubview:bottomview];
//        bottomview.sd_layout
//        .leftSpaceToView(midview,12)
//        .rightSpaceToView(midview,12)
//        .bottomSpaceToView(midview,0)
//        .heightIs(1);
        
        //石种
        UILabel * siLabel = [[UILabel alloc]init];
        siLabel.text = @"石   种:";
        siLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        siLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:siLabel];
        
        UILabel *stoneLabel = [[UILabel alloc]init];
        stoneLabel.text = @"白玉兰";
        stoneLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        stoneLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:stoneLabel];
        _stoneLabel = stoneLabel;
        
        
        //荒料号
        UILabel *huangLabel = [[UILabel alloc]init];
        huangLabel.text = @"荒料号:";
        huangLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        huangLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:huangLabel];
        
        UILabel *blockLabel = [[UILabel alloc]init];
        blockLabel.text = @"HXAC019654/SX-15605";
        blockLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        blockLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:blockLabel];
        _blockLabel = blockLabel;
        
        //规格
        
        UILabel *guiLabel = [[UILabel alloc]init];
        guiLabel.text = @"规   格:";
        guiLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        guiLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:guiLabel];
        
        UILabel *ruleLabel = [[UILabel alloc]init];
        ruleLabel.text = @"1.2*45*52";
        ruleLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        ruleLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:ruleLabel];
        _ruleLabel = ruleLabel;
        
        
        
        //仓储位置
        UILabel * cangLabel = [[UILabel alloc]init];
        cangLabel.text = @"仓储位置:";
        cangLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        cangLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:cangLabel];
        
        
        UILabel * storageLabel = [[UILabel alloc]init];
        storageLabel.text = @"荒料2仓1区A86储位";
        storageLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        storageLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:storageLabel];
        _storageLabel = storageLabel;
        

        //体格
        UILabel *tiLabel = [[UILabel alloc]init];
        _tiLabel = tiLabel;
       // tiLabel.text = @"面   积:";
        tiLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        tiLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:tiLabel];
        
        UILabel *physiqueLabel = [[UILabel alloc]init];
        physiqueLabel.text = @"12.123m3";
        physiqueLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        physiqueLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:physiqueLabel];
        _physiqueLabel = physiqueLabel;
        
        
        
        
        
        
        
        
        //匝号
        UILabel * zhongLabel = [[UILabel alloc]init];
        //zhongLabel.text = @"匝号:";
        _zhongLabel = zhongLabel;
        zhongLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        zhongLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:zhongLabel];
        
        UILabel *weightLabel = [[UILabel alloc]init];
        weightLabel.text = @"0.000顿";
        weightLabel.textColor = [UIColor colorWithHexColorStr:@"#b8b8b8"];
        weightLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:weightLabel];
        _weightLabel = weightLabel;
        
        
        
        siLabel.sd_layout
        .leftSpaceToView(midview,12)
        .topSpaceToView(midview,7.5)
        .widthIs(70)
        .heightIs(15);
        
        stoneLabel.sd_layout
        .leftSpaceToView(siLabel,10)
        .rightSpaceToView(midview,12)
        .topEqualToView(siLabel)
        .bottomEqualToView(siLabel);
        
        huangLabel.sd_layout
        .leftEqualToView(siLabel)
        .topSpaceToView(siLabel,7)
        .rightEqualToView(siLabel)
        .heightIs(15);
        
        blockLabel.sd_layout
        .leftEqualToView(stoneLabel)
        .rightEqualToView(stoneLabel)
        .topEqualToView(huangLabel)
        .bottomEqualToView(huangLabel);
        
        
        guiLabel.sd_layout
        .leftEqualToView(huangLabel)
        .rightEqualToView(huangLabel)
        .topSpaceToView(huangLabel,7)
        .heightIs(15);
        
        ruleLabel.sd_layout
        .leftEqualToView(blockLabel)
        .rightEqualToView(blockLabel)
        .topEqualToView(guiLabel)
        .bottomEqualToView(guiLabel);
        
        
        
        
        cangLabel.sd_layout
        .leftEqualToView(guiLabel)
        .rightEqualToView(guiLabel)
        .topSpaceToView(guiLabel,7)
        .heightIs(15);
        
        
        storageLabel.sd_layout
        .leftEqualToView(ruleLabel)
        .rightEqualToView(ruleLabel)
        .topEqualToView(cangLabel)
        .bottomEqualToView(cangLabel);
        
        
        
        
        
        
        
        
        
       tiLabel.sd_layout
        .leftEqualToView(cangLabel)
        .rightEqualToView(cangLabel)
        .topSpaceToView(cangLabel,7)
        .bottomSpaceToView(midview,7);
        
        physiqueLabel.sd_layout
        .leftEqualToView(storageLabel)
        .widthIs(100)
        .topEqualToView(tiLabel)
        .bottomEqualToView(tiLabel);
        
        
        zhongLabel.sd_layout
        .leftSpaceToView(physiqueLabel, 12)
        .widthIs(40)
        .topEqualToView(physiqueLabel)
        .bottomEqualToView(physiqueLabel);
        
        weightLabel.sd_layout
        .rightSpaceToView(midview,12)
        .topEqualToView(physiqueLabel)
        .bottomEqualToView(physiqueLabel)
        .leftSpaceToView(zhongLabel, 5);
        
        
        
        
        
        
        UIView * footview = [[UIView alloc]init];
        footview.backgroundColor = [UIColor whiteColor];
        [self.contentView  addSubview:footview];
        
        footview.sd_layout
        .topSpaceToView(midview,1)
        .rightSpaceToView(self.contentView ,0)
        .leftSpaceToView(self.contentView ,0)
        .heightIs(39);
        
        
        
        UIButton * playPhoneBtn = [[UIButton alloc]init];
        [playPhoneBtn setImage:[UIImage imageNamed:@"打电话"] forState:UIControlStateNormal];
        [footview addSubview:playPhoneBtn];
        _playPhoneBtn = playPhoneBtn;
        
        UIButton * removeBtn = [[UIButton alloc]init];
        [removeBtn setImage:[UIImage imageNamed:@"删除-(4)"] forState:UIControlStateNormal];
        [footview addSubview:removeBtn];
        _removeBtn = removeBtn;
        
        removeBtn.sd_layout
        .centerYEqualToView(footview)
        .rightSpaceToView(footview,20)
        .heightIs(30)
        .widthIs(30);
        
        playPhoneBtn.sd_layout
        .centerYEqualToView(footview)
        .rightSpaceToView(removeBtn,20)
        .heightIs(30)
        .widthIs(30);
        
        
    }
    return self;
}

- (void)setCollectionModel:(RSCollectionModel *)collectionModel{
    _collectionModel = collectionModel;
    
    /*
     int stoneType;      //1 2
     String companyName; //货主名称
     String phone;       //货主联系电话
     String stoneName;   //石材名称
     String stoneId;     //园区号 / 货主号
     String stoneMessage;//石材规格
     String stoneVolume; //石材体积 或 面积
     String stoneWeight; //石材重量(如果有的话)
     String stoneblno;   //荒料号(服务器)
     String stoneturnsno;//匝号(服务器)
     String stoneslno;   //片号(服务器)
     String storerreaName; //石种仓储位置
     
     
     
     
     
     
     */
    
    
    
    _Label.text = [NSString stringWithFormat:@"%@",_collectionModel.companyName];
    _stoneLabel.text = [NSString stringWithFormat:@"%@",_collectionModel.stoneName];
    _phoneLabel.text = [NSString stringWithFormat:@"%@",_collectionModel.phone];
    
    NSString * str = [NSString stringWithFormat:@"%ld",(long)_collectionModel.stoneType];
    
    if ([str isEqualToString:@"1"]) {
        
        
        _physiqueLabel.text = [NSString stringWithFormat:@"%@m³",_collectionModel.stoneVolume];
        
        _tiLabel.text = @"体   积:";
        _zhongLabel.text = @"重量";
    }else{
        _physiqueLabel.text = [NSString stringWithFormat:@"%@m²",_collectionModel.stoneVolume];
        _tiLabel.text = @"面   积:";
        
        _zhongLabel.text = @"匝号:";
    }
    
    
    
    _blockLabel.text = [NSString stringWithFormat:@"%@",_collectionModel.stoneId];
    
    _ruleLabel.text = [NSString stringWithFormat:@"%@",_collectionModel.stoneMessage];
    
    
    
    if ([str isEqualToString:@"1"]) {
        if ([_collectionModel.stoneWeight isEqualToString:@""]) {
            _collectionModel.stoneWeight = @"0.000";
            _weightLabel.text = [NSString stringWithFormat:@"%@顿",_collectionModel.stoneWeight];
        }else{
            _weightLabel.text = [NSString stringWithFormat:@"%@顿",_collectionModel.stoneWeight];
        }
    }else{
        _weightLabel.text = [NSString stringWithFormat:@"%@",_collectionModel.stoneturnsno];
    }
    
    
    
  
    
    _storageLabel.text = [NSString stringWithFormat:@"%@",_collectionModel.storerreaName];
    
    
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
