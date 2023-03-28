//
//  RSMaterialHeaderview.m
//  石来石往
//
//  Created by mac on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMaterialHeaderview.h"
#import "UIImageView+WebCache.h"
#import <HUPhotoBrowser.h>
@interface RSMaterialHeaderview ()

@property (nonatomic,strong)NSArray * imagesArray;


@end



@implementation RSMaterialHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor whiteColor];
        showView.layer.cornerRadius = 4;
        showView.layer.masksToBounds = YES;
        [self.contentView addSubview:showView];
        _showView = showView;
        
        //图片
        UIImageView * productImage = [[UIImageView alloc]init];
       // productImage.image = [UIImage imageNamed:@"矢量智能对象"];
        [showView addSubview:productImage];
        
        productImage.userInteractionEnabled = YES;
        productImage.contentMode = UIViewContentModeScaleAspectFill;
        productImage.clipsToBounds=YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showProductImageSecond:)];
        [productImage addGestureRecognizer:tap];
       
        
        _productImage = productImage;
        // [UIColor colorWithHexColorStr:@"#f0f0f0"]
        //产品名称
        UILabel * productName = [[UILabel alloc]init];
        productName.text = @"1";
        productName.textColor =[UIColor blackColor];
        productName.font = [UIFont systemFontOfSize:16];
        productName.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:productName];
        
        _productName = productName;
        //匝号和片数
        UILabel * productTurn = [[UILabel alloc]init];
        productTurn.text = @"2";
        productTurn.textColor = [UIColor blackColor];
        productTurn.textAlignment = NSTextAlignmentLeft;
        productTurn.font = [UIFont systemFontOfSize:15];
        [showView addSubview:productTurn];
        _productTurn = productTurn;
        
        //平方数或者立方数
        UILabel * productNum = [[UILabel alloc]init];
        productNum.text = @"3";
        productNum.textColor = [UIColor blackColor];
        productNum.textAlignment = NSTextAlignmentLeft;
        productNum.font = [UIFont systemFontOfSize:15];
        [showView addSubview:productNum];
        
        _productNum = productNum;
        
        /*
        //仓位位置
        UILabel * productPositionLabel = [[UILabel alloc]init];
        productPositionLabel.text = @"4";
        productPositionLabel.textColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        productPositionLabel.textAlignment = NSTextAlignmentLeft;
        productPositionLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:productPositionLabel];
        */
        
       // _productPositionLabel = productPositionLabel;
        //更多
        UIButton * productMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _productMoreBtn = productMoreBtn;
        productMoreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [productMoreBtn setTitle:[NSString stringWithFormat:@"仓储位置"] forState:UIControlStateNormal];
        [productMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [showView addSubview:productMoreBtn];
        
        
        
        
        UIImageView * downImage = [[UIImageView alloc]init];
        downImage.image = [UIImage imageNamed:@"向下"];
        [showView addSubview:downImage];
        
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        [self.contentView addSubview:bottomview];
        
        
        
        
        
        
        showView.sd_layout
        .leftSpaceToView(self.contentView, 20)
        .rightSpaceToView(self.contentView, 20)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5);
        
        productImage.sd_layout
        .leftSpaceToView(showView, 5)
        .topSpaceToView(showView, 5)
        .bottomSpaceToView(showView, 5)
        .widthIs(80);
        
        
        
        productName.sd_layout
        .leftSpaceToView(productImage, 5)
        .topEqualToView(productImage)
        .rightSpaceToView(showView, 12)
        .heightIs(20);
        
        
        productTurn.sd_layout
        .leftEqualToView(productName)
        .topSpaceToView(productName, 10)
        .rightEqualToView(productName)
        .heightIs(20);
        
        
        productNum.sd_layout
        .leftEqualToView(productTurn)
        .widthRatioToView(showView, 0.4)
        .topSpaceToView(productTurn, 10)
        .bottomEqualToView(productImage);
        
        
        
        /*
        productPositionLabel.sd_layout
        .leftEqualToView(productNum)
        .topSpaceToView(productNum, 5)
        .bottomEqualToView(productImage)
        .widthIs(120);
        */
        
        
        productMoreBtn.sd_layout
        .topEqualToView(productNum)
        .widthIs(60)
        .bottomEqualToView(productNum)
        .leftSpaceToView(productNum, 10);
        
        
        
        downImage.sd_layout
        .leftSpaceToView(productMoreBtn, 5)
        .centerYEqualToView(productMoreBtn)
        .widthIs(15)
        .heightIs(15);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
    }
    return self;
    
    
}



- (void)setMastemainmodel:(RSMasteMainModel *)mastemainmodel{
    _mastemainmodel = mastemainmodel;
    
    _imagesArray = mastemainmodel.photos;
    [_productImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mastemainmodel.photos objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"默认图灰"]];
   
    
}


- (void)showProductImageSecond:(UITapGestureRecognizer *)tap{
    [HUPhotoBrowser showFromImageView:self.productImage withURLStrings:_imagesArray atIndex:0];
}


@end
