//
//  RSTaoBaoShopManagementCell.m
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoShopManagementCell.h"

@interface RSTaoBaoShopManagementCell()

@property (nonatomic,strong) UIImageView * shopImageView;


@property (nonatomic,strong) UIImageView * typeImageView;


@property (nonatomic,strong) UILabel * nameLabel;


@property (nonatomic,strong) UILabel * surplusLabel;

@property (nonatomic,strong) UILabel * currentPriceLabel;
@property (nonatomic,strong) UILabel * discountPriceLabe;
@property (nonatomic,strong) UILabel * symbolLabel;
@property (nonatomic,strong) UIView * backView;
@end



@implementation RSTaoBaoShopManagementCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
        UIView * backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:backView];
        _backView = backView;
        
        
        UIImageView * shopImageView = [[UIImageView alloc]init];
        shopImageView.image = [UIImage imageNamed:@"512"];
        [backView addSubview:shopImageView];
        _shopImageView = shopImageView;
        
        _shopImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShowImageAction:)];
        
        [_shopImageView addGestureRecognizer:tap];
        
        //类型
        UIImageView * typeImageView = [[UIImageView alloc]init];
        typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
        typeImageView.contentMode = UIViewContentModeScaleAspectFill;
        typeImageView.clipsToBounds = YES;
        [backView addSubview:typeImageView];
        _typeImageView = typeImageView;
        
        //名字
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"波斯海浪灰";
        //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [backView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        
        //剩余
        UILabel * surplusLabel = [[UILabel alloc]init];
        surplusLabel.text = @"剩余234m³";
        
        CGRect rect1 = [surplusLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        surplusLabel.textAlignment = NSTextAlignmentLeft;
        surplusLabel.font = [UIFont systemFontOfSize:12];
        surplusLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [backView addSubview:surplusLabel];
        _surplusLabel = surplusLabel;
        
        
        //符号
        UILabel * symbolLabel = [[UILabel alloc]init];
        symbolLabel.text = @"¥";
        //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        symbolLabel.textAlignment = NSTextAlignmentCenter;
        symbolLabel.font = [UIFont systemFontOfSize:10];
        symbolLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [backView addSubview:symbolLabel];
        _symbolLabel = symbolLabel;
        
        //当前价格
        UILabel * currentPriceLabel = [[UILabel alloc]init];
        currentPriceLabel.text = @"9.9";
        
        CGRect rect = [currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25)options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
        currentPriceLabel.textAlignment = NSTextAlignmentLeft;
        currentPriceLabel.font = [UIFont systemFontOfSize:18];
        currentPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [backView addSubview:currentPriceLabel];
        _currentPriceLabel = currentPriceLabel;
        
        
        //打折价钱
        UILabel * discountPriceLabel = [[UILabel alloc]init];
        discountPriceLabel.textAlignment = NSTextAlignmentLeft;
        discountPriceLabel.font = [UIFont systemFontOfSize:10];
        discountPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥248" attributes:attribtDic];
        discountPriceLabel.attributedText = attribtStr;
        [backView addSubview:discountPriceLabel];
        _discountPriceLabe = discountPriceLabel;
        
        //下架
        UIButton * noShelfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [noShelfBtn setTitle:@"下架" forState:UIControlStateNormal];
        [noShelfBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        noShelfBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:noShelfBtn];
        _noShelfBtn = noShelfBtn;
        
        //编辑
        UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:editBtn];
        _editBtn = editBtn;
        
        
        //删除
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        
        
        
        backView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
        shopImageView.sd_layout
        .leftSpaceToView(backView, 12)
        .topSpaceToView(backView, 0)
        .widthIs(96)
        .heightEqualToWidth();
        shopImageView.layer.cornerRadius = 5;
        
        
        typeImageView.sd_layout
        .leftSpaceToView(shopImageView, 10)
        .topSpaceToView(backView, 7)
        .widthIs(22)
        .heightIs(12);
        
        nameLabel.sd_layout
        .leftSpaceToView(typeImageView, 3)
        .topSpaceToView(backView, 3)
        .rightSpaceToView(backView, 12)
        .heightIs(20);
        
        surplusLabel.sd_layout
        .leftEqualToView(typeImageView)
        .topSpaceToView(nameLabel, 2)
        .heightIs(17)
        .widthIs(rect1.size.width);
        
        symbolLabel.sd_layout
        .leftEqualToView(surplusLabel)
        .topSpaceToView(surplusLabel, 10)
        .heightIs(14)
        .widthIs(6);
        
        
        currentPriceLabel.sd_layout
        .leftSpaceToView(symbolLabel, 2)
        .topSpaceToView(surplusLabel, 2)
        .heightIs(25)
        .widthIs(rect.size.width);
        
        
        discountPriceLabel.sd_layout
        .leftSpaceToView(currentPriceLabel, 4)
        .topSpaceToView(surplusLabel, 11)
        .rightSpaceToView(backView, 12)
        .heightIs(14);
        
        
        noShelfBtn.sd_layout
        .leftEqualToView(symbolLabel)
        .topSpaceToView(currentPriceLabel, 4)
        .widthIs(47)
        .heightIs(23);
        
        
        noShelfBtn.layer.cornerRadius = 12;
        noShelfBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF4B33"].CGColor;
        noShelfBtn.layer.borderWidth = 1;
        
        
        editBtn.sd_layout
        .leftSpaceToView(noShelfBtn, 4)
        .topEqualToView(noShelfBtn)
        .bottomEqualToView(noShelfBtn)
        .widthIs(47);
        
        
        editBtn.layer.cornerRadius = 12;
        editBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF4B33"].CGColor;
        editBtn.layer.borderWidth = 1;
        
        
        
        
        deleteBtn.sd_layout
        .leftSpaceToView(editBtn, 4)
        .topEqualToView(editBtn)
        .bottomEqualToView(editBtn)
        .widthIs(47);
        
        
        deleteBtn.layer.cornerRadius = 12;
        deleteBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF4B33"].CGColor;
        deleteBtn.layer.borderWidth = 1;
        
        
    }
    return self;
}


- (void)setTaobaomanagementmodel:(RSTaoBaoMangementModel *)taobaomanagementmodel{
    _taobaomanagementmodel = taobaomanagementmodel;
    
    RSTaobaoVideoAndPictureModel * taovideoAndPicturemodel = _taobaomanagementmodel.imageList.firstObject;
    
    [_shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",taovideoAndPicturemodel.imageUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
    
    if ([_taobaomanagementmodel.stockType isEqualToString:@"huangliao"]) {
        _typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
    }else{
        _typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
    }
    _nameLabel.text = _taobaomanagementmodel.stoneName;
   // _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lf",[_taobaomanagementmodel.inventory floatValue]];
    if ([_taobaomanagementmodel.stockType isEqualToString:@"daban"]) {
         _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm²",[_taobaomanagementmodel.inventory floatValue]];
    }else{
        if ([_taobaomanagementmodel.unit isEqualToString:@"立方米"]) {
            _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm³",[_taobaomanagementmodel.inventory floatValue]];
        }else{
            _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lf吨",[_taobaomanagementmodel.weight floatValue]];
        }
    }
    CGRect rect1 = [_surplusLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    _surplusLabel.sd_layout
    .leftEqualToView(_typeImageView)
    .topSpaceToView(_nameLabel, 2)
    .heightIs(17)
    .widthIs(rect1.size.width);
    
    
    
    _currentPriceLabel.text = [NSString stringWithFormat:@"%0.3lf",[ _taobaomanagementmodel.price floatValue]];
    CGRect rect = [_currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    
    _currentPriceLabel.sd_layout
    .leftSpaceToView(_symbolLabel, 2)
    .topSpaceToView(_surplusLabel, 2)
    .heightIs(25)
    .widthIs(rect.size.width);
    
    
    _discountPriceLabe.text = [NSString stringWithFormat:@"%0.3lf",[_taobaomanagementmodel.originalPrice floatValue]];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_discountPriceLabe.text attributes:attribtDic];
    _discountPriceLabe.attributedText = attribtStr;
    
    _discountPriceLabe.sd_layout
    .leftSpaceToView(_currentPriceLabel, 4)
    .topSpaceToView(_surplusLabel, 11)
    .rightSpaceToView(_backView, 12)
    .heightIs(14);
    
 
    
}

- (void)tapShowImageAction:(UITapGestureRecognizer *)tap{
    NSMutableArray * imageArray = [NSMutableArray array];
    for (int i = 0; i < self.taobaomanagementmodel.imageList.count; i++) {
        RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = self.taobaomanagementmodel.imageList[i];
        [imageArray addObject:taobaoVideoAndPicturemodel.imageUrl];
    }
    [HUPhotoBrowser showFromImageView:_shopImageView withURLStrings:imageArray atIndex:0];
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
