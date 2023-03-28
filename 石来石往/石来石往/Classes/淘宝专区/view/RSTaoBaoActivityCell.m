//
//  RSTaoBaoActivityCell.m
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoActivityCell.h"
#import "RSTaobaoVideoAndPictureModel.h"

@interface RSTaoBaoActivityCell()

@property (nonatomic,strong)UIImageView * newimageView;

@property (nonatomic,strong)UIImageView * typeImageView;

@property (nonatomic,strong)UILabel * nameLabel;

@property (nonatomic,strong)UILabel * surplusLabel;

@property (nonatomic,strong) UILabel * symbolLabel;

@property (nonatomic,strong)UILabel * currentPriceLabel;



@property (nonatomic,strong)UILabel * shopLabel;

@property (nonatomic,strong)UILabel * discountPriceLabel;

@end


@implementation RSTaoBaoActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        
        [self setupCell];
        
        
        
        
        
    }
    return self;
}



-(void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.contentView addSubview:backView];
    
    
    //图片
    UIImageView * newimageView = [[UIImageView alloc]init];
    newimageView.image = [UIImage imageNamed:@"01"];
    newimageView.contentMode = UIViewContentModeScaleAspectFill;
    newimageView.clipsToBounds = YES;
    [backView addSubview:newimageView];
    _newimageView = newimageView;
    
    
    
    
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
    _discountPriceLabel = discountPriceLabel;
    
    
    
    //折扣
    UIButton * showDisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showDisBtn setBackgroundImage:[UIImage imageNamed:@"矩形"] forState:UIControlStateNormal];
    [showDisBtn setTitle:@"2.7折" forState:UIControlStateNormal];
    [showDisBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF4B33"] forState:UIControlStateNormal];
    [backView addSubview:showDisBtn];
    showDisBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    _showDisBtn = showDisBtn;
    
    
    //商店
    UILabel * shopLabel = [[UILabel alloc]init];
    shopLabel.text = @"大唐石业";
    //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    shopLabel.textAlignment = NSTextAlignmentLeft;
    shopLabel.font = [UIFont systemFontOfSize:11];
    shopLabel.textColor = [UIColor colorWithHexColorStr:@"#9D9D9D"];
    [backView addSubview:shopLabel];
    
    CGRect rect2 = [shopLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15)options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    
    _shopLabel = shopLabel;
    
    
    //进店按键
    RSTaobaoSCButton * taoBaoSCBtn = [[RSTaobaoSCButton alloc]init];
    [taoBaoSCBtn setTitle:@"进店" forState:UIControlStateNormal];
    [taoBaoSCBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    taoBaoSCBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [taoBaoSCBtn setImage:[UIImage imageNamed:@"icon_chose_arrow_nor"] forState:UIControlStateNormal];
    [backView addSubview:taoBaoSCBtn];
    _taoBaoSCBtn = taoBaoSCBtn;
    
    
    //马上抢
    UIButton * rowNowRobBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rowNowRobBtn setTitle:@"马上抢" forState:UIControlStateNormal];
    [rowNowRobBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    rowNowRobBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rowNowRobBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
    [backView addSubview:rowNowRobBtn];
    _rowNowRobBtn = rowNowRobBtn;
    
    
    backView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 7)
    .bottomSpaceToView(self.contentView, 0);
    
    
    
    newimageView.sd_layout
    .leftSpaceToView(backView, 12)
    .topSpaceToView(backView, 12)
    .widthIs(96)
    .heightEqualToWidth();
    newimageView.layer.cornerRadius = 5;
    
    
    typeImageView.sd_layout
    .leftSpaceToView(newimageView, 10)
    .topSpaceToView(backView, 16)
    .widthIs(22)
    .heightIs(12);
    
    nameLabel.sd_layout
    .leftSpaceToView(typeImageView, 3)
    .topSpaceToView(backView, 12)
    .rightSpaceToView(backView, 12)
    .heightIs(20);
    
    surplusLabel.sd_layout
    .leftEqualToView(typeImageView)
    .topSpaceToView(nameLabel, 4)
    .heightIs(17)
    .widthIs(rect1.size.width);
    
    symbolLabel.sd_layout
    .leftEqualToView(surplusLabel)
    .topSpaceToView(surplusLabel, 13)
    .heightIs(14)
    .widthIs(6);
    
    
    currentPriceLabel.sd_layout
    .leftSpaceToView(symbolLabel, 2)
    .topSpaceToView(surplusLabel, 5)
    .heightIs(25)
    .widthIs(rect.size.width);
    
    NSString * str = @"¥248";
    CGRect disCountrect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    
    
    
    discountPriceLabel.sd_layout
    .leftSpaceToView(currentPriceLabel, 4)
    .topSpaceToView(surplusLabel, 13)
    .widthIs(disCountrect.size.width)
    .heightIs(14);
    
    
    showDisBtn.sd_layout
    .leftSpaceToView(discountPriceLabel, 1)
    .heightIs(14)
    .widthIs(34)
    .topSpaceToView(surplusLabel,13);
    
    
    
    
    
    shopLabel.sd_layout
    .leftEqualToView(symbolLabel)
    .bottomEqualToView(newimageView)
    .heightIs(15)
    .widthIs(rect2.size.width);
    
    taoBaoSCBtn.sd_layout
    .leftSpaceToView(shopLabel, 4)
    .topEqualToView(shopLabel)
    .bottomEqualToView(shopLabel)
    .widthIs(80);
    
    rowNowRobBtn.sd_layout
    .rightSpaceToView(backView, 12)
    .bottomEqualToView(newimageView)
    .widthIs(65)
    .heightIs(24);
    
    rowNowRobBtn.layer.cornerRadius = 12;
    
    
    
    
}


- (void)showBigPictureAction:(UITapGestureRecognizer *)tap{
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:self.taobaoUserlikemodel.imageUrl];
    [HUPhotoBrowser showFromImageView:_newimageView withURLStrings:array atIndex:0];
}


- (void)setTaobaoUserlikemodel:(RSTaoBaoUserLikeModel *)taobaoUserlikemodel{
    _taobaoUserlikemodel = taobaoUserlikemodel;
    
    
    //RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = _taobaoUserlikemodel.imageList[0];
    [_newimageView sd_setImageWithURL:[NSURL URLWithString:_taobaoUserlikemodel.imageUrl] placeholderImage:[UIImage imageNamed:@"512"]];
    _newimageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPictureAction:)];
    [_newimageView addGestureRecognizer:tap];
   
    
    if ([_taobaoUserlikemodel.stockType isEqualToString:@"daban"]) {
        _typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
    }else{
        _typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
    }
    _nameLabel.text = _taobaoUserlikemodel.stoneName;
    if ([_taobaoUserlikemodel.stockType isEqualToString:@"daban"]) {
         _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm²",[_taobaoUserlikemodel.inventory floatValue]];
    }else{
        if ([_taobaoUserlikemodel.unit isEqualToString:@"立方米"]) {
            _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm³",[_taobaoUserlikemodel.inventory floatValue]];
        }else{
            _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lf吨",[_taobaoUserlikemodel.weight floatValue]];
        }
        // _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm³",[_taobaoUserlikemodel.inventory floatValue]];
    }
    CGRect rect1 = [_surplusLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    _surplusLabel.sd_layout
    .leftEqualToView(_typeImageView)
    .topSpaceToView(_nameLabel, 4)
    .heightIs(17)
    .widthIs(rect1.size.width);
    
    
       
       
    _currentPriceLabel.text = [NSString stringWithFormat:@"%@",_taobaoUserlikemodel.price];
    
    
    
    CGRect rect = [_currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25)options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    
    _currentPriceLabel.sd_layout
    .leftSpaceToView(_symbolLabel, 2)
    .topSpaceToView(_surplusLabel, 5)
    .heightIs(25)
    .widthIs(rect.size.width);
    
    
    
    
               
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
           NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_taobaoUserlikemodel.originalPrice] attributes:attribtDic];
           _discountPriceLabel.attributedText = attribtStr;
           
           
           CGRect disCountrect = [[NSString stringWithFormat:@"¥%@",_taobaoUserlikemodel.originalPrice] boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
           
           
           
           
           _discountPriceLabel.sd_layout
           .leftSpaceToView(_currentPriceLabel, 4)
           .topSpaceToView(_surplusLabel, 13)
           .widthIs(disCountrect.size.width)
           .heightIs(14);
        
        
        
        
    
   
    
    
    
    [_showDisBtn setTitle:[NSString stringWithFormat:@"%0.1lf折",[_taobaoUserlikemodel.discount floatValue]] forState:UIControlStateNormal];
    
    
    _showDisBtn.sd_layout
    .leftSpaceToView(_discountPriceLabel, 1)
    .heightIs(14)
    .widthIs(34)
    .topSpaceToView(_surplusLabel,13);
    

    _shopLabel.text = _taobaoUserlikemodel.shopName;
    CGRect rect2 = [_shopLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15)options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    
    _shopLabel.sd_layout
    .leftEqualToView(_symbolLabel)
    .bottomEqualToView(_newimageView)
    .heightIs(15)
    .widthIs(rect2.size.width);
    
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
