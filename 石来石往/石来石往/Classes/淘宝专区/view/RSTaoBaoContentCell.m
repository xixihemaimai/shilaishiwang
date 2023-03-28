//
//  RSTaoBaoContentCell.m
//  石来石往
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoContentCell.h"
#import "RSTaobaoVideoAndPictureModel.h"

@interface RSTaoBaoContentCell()



@property (nonatomic,strong)UIImageView * imageView;

@property (nonatomic,strong) UIImageView * typeImageView;


@property (nonatomic,strong)UILabel * nameLabel;

@property (nonatomic,strong)UILabel * discountPriceLabel;

@property (nonatomic,strong)UILabel * currentPriceLabel;

@property (nonatomic,strong)UILabel * surplusLabel;

@property (nonatomic,strong)UILabel * symbolLabel;
@end


@implementation RSTaoBaoContentCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
        //图片
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"01"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        _imageView = imageView;
        
        //类型
        UIImageView * typeImageView = [[UIImageView alloc]init];
        typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
        typeImageView.contentMode = UIViewContentModeScaleAspectFill;
        typeImageView.clipsToBounds = YES;
        [self.contentView addSubview:typeImageView];
        _typeImageView = typeImageView;
        
        //石种名字
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"波斯海浪灰";
        //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        
        //打折价钱
        UILabel * discountPriceLabel = [[UILabel alloc]init];
        discountPriceLabel.textAlignment = NSTextAlignmentLeft;
        discountPriceLabel.font = [UIFont systemFontOfSize:10];
        discountPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:discountPriceLabel];
        _discountPriceLabel = discountPriceLabel;
        
        
        //符号
        UILabel * symbolLabel = [[UILabel alloc]init];
        symbolLabel.text = @"¥";
        //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        symbolLabel.textAlignment = NSTextAlignmentCenter;
        symbolLabel.font = [UIFont systemFontOfSize:10];
        symbolLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [self.contentView addSubview:symbolLabel];
        _symbolLabel = symbolLabel;
        
        //当前价格
        UILabel * currentPriceLabel = [[UILabel alloc]init];
        currentPriceLabel.text = @"9.9";
        
        CGRect rect = [currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25)options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
        currentPriceLabel.textAlignment = NSTextAlignmentLeft;
        currentPriceLabel.font = [UIFont systemFontOfSize:18];
        currentPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [self.contentView addSubview:currentPriceLabel];
        _currentPriceLabel = currentPriceLabel;
        
        
        //剩余
        UILabel * surplusLabel = [[UILabel alloc]init];
        surplusLabel.text = @"剩余234m³";
        
        
        surplusLabel.textAlignment = NSTextAlignmentLeft;
        surplusLabel.font = [UIFont systemFontOfSize:12];
        surplusLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [self.contentView addSubview:surplusLabel];
        _surplusLabel = surplusLabel;
        
        
        
        
        imageView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(171);
        
        
        
        CGRect rect6 = CGRectMake(0, 0, self.contentView.frame.size.width, 171);
        CGRect oldRect2 = rect6;
        oldRect2.size.width = self.contentView.frame.size.width;
        UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect2 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
        maskLayer2.path = maskPath2.CGPath;
        maskLayer2.frame = oldRect2;
        imageView.layer.mask = maskLayer2;
        
    
        typeImageView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(imageView, 10)
        .widthIs(22)
        .heightIs(12);
        
       nameLabel.sd_layout
        .leftSpaceToView(typeImageView, 3)
        .topSpaceToView(imageView, 7)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(19);
        
        surplusLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(typeImageView, 10)
        .heightIs(14);
       
        
        symbolLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(surplusLabel, 8)
        .widthIs(6)
        .heightIs(14);
        
        
       currentPriceLabel.sd_layout
        .leftSpaceToView(symbolLabel, 2)
        .topSpaceToView(surplusLabel, 0)
        .widthIs(rect.size.width)
        .heightIs(25);
        
        
        CGRect rect1 = [discountPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        
        discountPriceLabel.sd_layout
        .leftSpaceToView(currentPriceLabel, 5)
        .topSpaceToView(imageView, 52)
        .heightIs(17)
        .widthIs(rect1.size.width);
        
        
          self.contentView.layer.cornerRadius = 6;
        
    }
    return self;
}


- (void)setTaobaoUserLikemodel:(RSTaoBaoUserLikeModel *)taobaoUserLikemodel{
    _taobaoUserLikemodel = taobaoUserLikemodel;
   [_imageView sd_setImageWithURL:[NSURL URLWithString:_taobaoUserLikemodel.imageUrl] placeholderImage:[UIImage imageNamed:@"512"]];
    if ([_taobaoUserLikemodel.stockType isEqualToString:@"huangliao"]) {
        _typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
    }else{
       _typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
    }
    _nameLabel.text = _taobaoUserLikemodel.stoneName;
    //_discountPriceLabel.text = [NSString stringWithFormat:@"%0.0lf",[_taobaoUserLikemodel.originalPrice floatValue]];
    

            
          _currentPriceLabel.text = [NSString stringWithFormat:@"%@",_taobaoUserLikemodel.price];
          CGRect rect = [_currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25)options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
          
          _currentPriceLabel.sd_layout
          .leftSpaceToView(_symbolLabel, 2)
          .topSpaceToView(_surplusLabel, 0)
          .widthIs(rect.size.width)
          .heightIs(25);
             
    if ([_taobaoUserLikemodel.stockType isEqualToString:@"huangliao"]) {
        if ([_taobaoUserLikemodel.unit isEqualToString:@"立方米"]) {
            _surplusLabel.text = [NSString stringWithFormat:@"剩余%0.3lfm³",[_taobaoUserLikemodel.inventory floatValue]];
        }else{
            _surplusLabel.text = [NSString stringWithFormat:@"剩余%0.3lf吨",[_taobaoUserLikemodel.weight floatValue]];
        }
    }else{
        _surplusLabel.text = [NSString stringWithFormat:@"剩余%0.3lfm²",[_taobaoUserLikemodel.inventory floatValue]];
    }
    

//    _surplusLabel.sd_layout
//    .leftSpaceToView(self.contentView, 12)
//    .rightSpaceToView(self.contentView, 12)
//    .topSpaceToView(_typeImageView, 10)
//    .heightIs(14);

        
     
          NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
          NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_taobaoUserLikemodel.originalPrice] attributes:attribtDic];
          _discountPriceLabel.attributedText = attribtStr;
          
      
    
    
    
    
    CGRect rect1 = [_discountPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    _discountPriceLabel.sd_layout
    //.rightSpaceToView(self.contentView, 9)
    .leftSpaceToView(_currentPriceLabel, 5)
    .topSpaceToView(_imageView, 52)
    .heightIs(17)
    .widthIs(rect1.size.width);
    
}


@end
