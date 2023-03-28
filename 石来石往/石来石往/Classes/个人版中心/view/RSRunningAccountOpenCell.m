//
//  RSRunningAccountOpenCell.m
//  石来石往
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSRunningAccountOpenCell.h"


@interface RSRunningAccountOpenCell()



@property (nonatomic,strong)UILabel * accountProductNameLabel;

@property (nonatomic,strong)UILabel * accountMaterielLabel;

@property (nonatomic,strong)UILabel * accountNumberLabel;

@property (nonatomic,strong)UIImageView * yellewView;

@property (nonatomic,strong)UIButton * bottomBtn;

@end

@implementation RSRunningAccountOpenCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    
    
    UIView * accountView = [[UIView alloc]init];
    accountView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.contentView addSubview:accountView];
    
    
    
    UIImageView * yellewView = [[UIImageView alloc]init];
    //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
    yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
    yellewView.contentMode = UIViewContentModeScaleAspectFill;
    yellewView.clipsToBounds = YES;
    [accountView addSubview:yellewView];
    
    _yellewView = yellewView;
    
    
    
    
    UIImageView * blueView = [[UIImageView alloc]init];
    blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
    blueView.contentMode = UIViewContentModeScaleAspectFill;
    blueView.clipsToBounds = YES;
    [accountView addSubview:blueView];
    
    
    UILabel * accountProductNameLabel = [[UILabel alloc]init];
    accountProductNameLabel.text = @"白玉兰";
    accountProductNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    accountProductNameLabel.font = [UIFont systemFontOfSize:16];
    accountProductNameLabel.textAlignment = NSTextAlignmentLeft;
    [accountView addSubview:accountProductNameLabel];
    _accountProductNameLabel = accountProductNameLabel;
    
    //物料号
    UILabel * accountMaterielLabel = [[UILabel alloc]init];
    accountMaterielLabel.text = @"ESB00295/DH-539";
    accountMaterielLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    accountMaterielLabel.font = [UIFont systemFontOfSize:15];
    accountMaterielLabel.textAlignment = NSTextAlignmentRight;
    [accountView addSubview:accountMaterielLabel];
    _accountMaterielLabel = accountMaterielLabel;
    
    //分隔线
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [accountView addSubview:midView];
    
    UIButton * bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [bottomBtn addTarget:self action:@selector(closeMemberView:) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:bottomBtn];
    _bottomBtn = bottomBtn;
    
    
    UILabel * accountNumberLabel = [[UILabel alloc]init];
    accountNumberLabel.text = @"ESB00295/DH-539";
    accountNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    accountNumberLabel.font = [UIFont systemFontOfSize:14];
    accountNumberLabel.textAlignment = NSTextAlignmentLeft;
    [bottomBtn addSubview:accountNumberLabel];
    _accountNumberLabel = accountNumberLabel;
    
    UIImageView * accountClsoeImageView = [[UIImageView alloc]init];
    accountClsoeImageView.image = [UIImage imageNamed:@"system-pull-down copy 2"];
    accountClsoeImageView.clipsToBounds = YES;
    accountClsoeImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  [accountOpenBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    // [accountOpenBtn addTarget:self action:@selector(openMemberView:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn addSubview:accountClsoeImageView];
    
    accountView.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .rightSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 0);
    
    accountView.layer.cornerRadius = 8;
    
    yellewView.sd_layout
    .leftSpaceToView(accountView, 0)
    .topSpaceToView(accountView, 18)
    .heightIs(17)
    .widthIs(4);
    
    
    blueView.sd_layout
    .rightSpaceToView(accountView, 0)
    .topSpaceToView(accountView, 18)
    .heightIs(17)
    .widthIs(4);
    
    
    accountProductNameLabel.sd_layout
    .leftSpaceToView(accountView, 13)
    .topSpaceToView(accountView, 14)
    .heightIs(23)
    .rightSpaceToView(accountView, 15);

    
    accountMaterielLabel.sd_layout
    .widthRatioToView(accountView, 0.6)
    .rightSpaceToView(blueView, 19)
    .topSpaceToView(accountView, 14)
    .heightIs(21);
    
    
    midView.sd_layout
    .leftSpaceToView(accountView, 0)
    .rightSpaceToView(accountView, 0)
    .heightIs(1)
    .topSpaceToView(accountView, 54);
    
    
    bottomBtn.sd_layout
    .leftSpaceToView(accountView, 0)
    .rightSpaceToView(accountView, 0)
    .topSpaceToView(midView, 0)
    .heightIs(30);
    
    
    
    accountNumberLabel.sd_layout
    .leftSpaceToView(bottomBtn, 3)
    .topSpaceToView(bottomBtn, 10)
    .heightIs(20)
    .widthRatioToView(bottomBtn, 0.5);
    
    accountClsoeImageView.sd_layout
    .rightSpaceToView(bottomBtn, 21)
    .centerYEqualToView(bottomBtn)
    .widthIs(16)
    .heightIs(9);
    
  
}


- (void)setBalancemodel:(RSBalanceModel *)balancemodel{
    _accountProductNameLabel.text = balancemodel.mtlName;
    _accountMaterielLabel.text = balancemodel.blockNo;
    _accountNumberLabel.text = [NSString stringWithFormat:@"流转单据 %ld单",balancemodel.billCount];
}


//- (void)setView:(NSString *)selectFunctionType{
//    
//    if ([selectFunctionType isEqualToString:@"大板库存流水账"]) {
//        _accountMaterielLabel.hidden = NO;
//        _accountNumberLabel.text = @"匝号：5-5 片号1";
//        _yellewView.hidden = YES;
//
//        _oddNumbersLabel.text = @"单号";
//        _oddNumbersDetailLabel.text = @"CGRK201901070001";
//        _oddNumbersLabel.sd_layout
//        .topSpaceToView(_bottomBtn, 5);
//
//        _shapeLabel.text = @"入库日期";
//        _shapeDetailLabel.text = @"2019-01-12";
//        _shapeLabel.sd_layout
//        .topSpaceToView(_oddNumbersLabel, 5);
//
//        _warehousingTimeLabel.text = @"入库类型";
//        _warehousingTimeDetailLabel.text = @"采购入库";
//        _warehousingTimeLabel.sd_layout
//        .topSpaceToView(_shapeLabel, 5);
//
//        _areaLabel.text = @"入库仓库";
//        _areaDetailLabel.text = @"一号仓库";
//        _areaLabel.sd_layout
//        .topSpaceToView(_warehousingTimeLabel, 5);
//
//        _storageTypeLabel.text = @"长宽厚(cm)";
//        _storageTypeDetailLabel.text = @"3.3 | 2.8 | 0.3";
//        _storageTypeLabel.sd_layout
//        .topSpaceToView(_areaLabel, 5);
//
//
//        _warehouseLabel.text = @"原始面积(m²)";
//        _warehouseDetailLabel.text = @"5.883";
//
//        _warehouseLabel.sd_layout
//        .topSpaceToView(_storageTypeLabel, 5);
//
//        _wightLabel.text = @"扣尺面积(m²)";
//        _wightDetailLabel.text = @"5.883";
//        _wightLabel.sd_layout
//        .topSpaceToView(_warehouseLabel, 5);
//
//        _actualAreaLabel.text = @"实际面积(m²)";
//        _actualAreaDetailLabel.text = @"5.883";
//        _actualAreaLabel.sd_layout
//        .topSpaceToView(_wightLabel, 5);
//
//        _actualAreaLabel.hidden = NO;
//        _actualAreaDetailLabel.hidden = NO;
//
//
//
//    }else{
//        _yellewView.hidden = NO;
//        _accountMaterielLabel.hidden = YES;
//        _accountNumberLabel.text = @"ESB00295/DH-539";
//
//          _oddNumbersLabel.text = @"单号";
//        _oddNumbersDetailLabel.text = @"CGRK201901070001";
//        _oddNumbersLabel.sd_layout
//        .topSpaceToView(_bottomBtn, 9);
//
//        _shapeLabel.text = @"长宽高(cm)";
//        _shapeDetailLabel.text = @"0.1 | 3.3 | 2.8";
//        _shapeLabel.sd_layout
//        .topSpaceToView(_oddNumbersLabel, 7);
//
//        _warehousingTimeLabel.text = @"入库时间";
//        _warehousingTimeDetailLabel.text = @"2019-01-12";
//        _warehousingTimeLabel.sd_layout
//        .topSpaceToView(_shapeLabel, 7);
//
//        _areaLabel.text = @"体积(m³)";
//        _areaDetailLabel.text = @"5.883";
//        _areaLabel.sd_layout
//        .topSpaceToView(_warehousingTimeLabel, 7);
//
//         _storageTypeLabel.text = @"入库类型";
//        _storageTypeDetailLabel.text = @"采购入库";
//        _storageTypeLabel.sd_layout
//        .topSpaceToView(_areaLabel, 7);
//
//
//        _warehouseLabel.text = @"入库仓库";
//        _warehouseDetailLabel.text = @"一号仓库";
//        _warehouseLabel.sd_layout
//        .topSpaceToView(_storageTypeLabel, 7);
//
//        _wightLabel.text = @"重量(吨)";
//        _wightDetailLabel.text = @"5.445";
//        _wightLabel.sd_layout
//        .topSpaceToView(_warehouseLabel, 7);
//
//        _actualAreaLabel.text = @"实际面积(m²)";
//        _actualAreaDetailLabel.text = @"5.883";
//        _actualAreaLabel.hidden = YES;
//        _actualAreaDetailLabel.hidden = YES;
//    }
//
//
//
//}


- (void)closeMemberView:(UIButton *)btn{
    
    [self.indexArr removeObject:[NSString stringWithFormat:@"%d",self.index]];
    
    if ([self.delegate respondsToSelector:@selector(baseCell:btnType:WithIndex:withArr:withOpenArr:)])
    {
        [self.delegate baseCell:self btnType:CLOSE WithIndex:self.index withArr:self.indexArr withOpenArr:self.openArr];
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
