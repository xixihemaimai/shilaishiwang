//
//  RSSLFractureTreatmentView.m
//  石来石往
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLFractureTreatmentView.h"

@interface RSSLFractureTreatmentView()<RSDabanContentViewDelegate>

{
    UILabel * _productNameLabel;
    
    UILabel * _productNumberLabel;
    UILabel * _productTurnLabel;
    
}



@end

@implementation RSSLFractureTreatmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
     //这边要
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        UIView * topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self addSubview:topView];
        topView.userInteractionEnabled = YES;
        
        
        
        topView.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 5)
        .rightSpaceToView(self, 0)
        .heightIs(58);
        
     
        UIImageView * yellewView = [[UIImageView alloc]init];
        //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
        yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
        yellewView.contentMode = UIViewContentModeScaleAspectFill;
        yellewView.clipsToBounds = YES;
        [topView addSubview:yellewView];
        
        
        
        yellewView.sd_layout
        .leftSpaceToView(topView, 0)
        .topSpaceToView(topView, 18)
        .heightIs(17)
        .widthIs(4);
        
        UIImageView * blueView = [[UIImageView alloc]init];
        blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
        blueView.contentMode = UIViewContentModeScaleAspectFill;
        blueView.clipsToBounds = YES;
        [topView addSubview:blueView];
        
        blueView.sd_layout
        .rightSpaceToView(topView, 0)
        .topSpaceToView(topView, 18)
        .heightIs(17)
        .widthIs(4);
        
        //物料名称
        UILabel * productNameLabel = [[UILabel alloc]init];
        productNameLabel.text = @"白玉兰";
        productNameLabel.font = [UIFont systemFontOfSize:17];
        productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productNameLabel.textAlignment = NSTextAlignmentLeft;
        [topView addSubview:productNameLabel];
        _productNameLabel = productNameLabel;
        
        productNameLabel.sd_layout
        .leftSpaceToView(topView, 14)
        .topSpaceToView(topView, 14)
        .widthRatioToView(topView, 0.4)
        .heightIs(24);
        
        
        //物料号
        UILabel * productNumberLabel = [[UILabel alloc]init];
        productNumberLabel.text = @"ESB00295/DH-539";
        productNumberLabel.font = [UIFont systemFontOfSize:12];
        productNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productNumberLabel.textAlignment = NSTextAlignmentLeft;
        [topView addSubview:productNumberLabel];
        _productNumberLabel = productNumberLabel;
        productNumberLabel.sd_layout
        .leftEqualToView(productNameLabel)
        .topSpaceToView(productNameLabel, 0)
        .rightEqualToView(productNameLabel)
        .heightIs(17);

        
     
        
        
        UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [downBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [self addSubview:downBtn];
        _downBtn = downBtn;
        
        downBtn.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(topView, 5)
        .rightSpaceToView(self, 0)
        .heightIs(40);
        
        
        //分割线
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [downBtn addSubview:midView];
        
        midView.sd_layout
        .leftSpaceToView(downBtn, 0)
        .rightSpaceToView(downBtn, 0)
        .topSpaceToView(downBtn, 0)
        .heightIs(1);
        
        //匝号
        UILabel * productTurnLabel = [[UILabel alloc]init];
        productTurnLabel.text = @"匝号：5-5";
        productTurnLabel.font = [UIFont systemFontOfSize:14];
        productTurnLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productTurnLabel.textAlignment = NSTextAlignmentLeft;
        [downBtn addSubview:productTurnLabel];
        _productTurnLabel = productTurnLabel;
        productTurnLabel.sd_layout
        .leftSpaceToView(downBtn, 11)
        .topSpaceToView(downBtn, 10)
        .widthRatioToView(downBtn, 0.5)
        .heightIs(20);
        
        
        
        //删除按键
        UIButton * productDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [productDeleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
        // [productDeleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
        [topView addSubview:productDeleteBtn];
        _productDeleteBtn = productDeleteBtn;
        
        productDeleteBtn.sd_layout
        .rightSpaceToView(topView, 16)
        .topSpaceToView(topView, 14)
        .widthIs(28)
        .heightEqualToWidth();
        
        
        
        UIImageView * downImageView = [[UIImageView alloc]init];
        // [downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
        downImageView.image = [UIImage imageNamed:@"system-pull-down"];
        downImageView.clipsToBounds = YES;
        downImageView.contentMode = UIViewContentModeScaleAspectFill;
        [downBtn addSubview:downImageView];
    //    _downImageView = downImageView;
        
        downImageView.sd_layout
        .topSpaceToView(downBtn, 16)
        .rightSpaceToView(downBtn, 11)
        .widthIs(16)
        .heightIs(9);
        
        
        //这边放一个view在这里面
        
        RSDabanContentView * dabanContentView = [[RSDabanContentView alloc]init];
        dabanContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self addSubview:dabanContentView];
        dabanContentView.delegate = self;
        dabanContentView.userInteractionEnabled = YES;
        _dabanContentView = dabanContentView;
        
        
        dabanContentView.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topSpaceToView(downBtn, 0)
        .heightIs(0);
        
        UILabel * chuliLabel = [[UILabel alloc]init];
        chuliLabel.text = @"处理后";
        chuliLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        chuliLabel.font = [UIFont systemFontOfSize:14];
        chuliLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:chuliLabel];
        _chuliLabel = chuliLabel;
        
        chuliLabel.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(dabanContentView, 20)
        .heightIs(20)
        .widthIs(60);
        
 
    }
    return self;
}


- (void)setContentArray:(NSArray *)contentArray{
    _contentArray = contentArray;
    RSSLStoragemanagementModel * slstoragemanagementmodel = contentArray[0];
    if (slstoragemanagementmodel.isbool) {
        _dabanContentView.sd_layout
        .heightIs(contentArray.count * 118);
        _dabanContentView.dataArray= contentArray;
    }else{
        _dabanContentView.sd_layout
        .heightIs(0);
    }
    
   
    
    
    [self setupAutoHeightWithBottomView:_dabanContentView bottomMargin:10];
}


- (void)sendIndex:(NSInteger)row{
    if ([self.delegate respondsToSelector:@selector(sendSection:andIndex:)]) {
        [self.delegate sendSection:_dabanContentView.tag andIndex:row];
    }
}

- (void)deleteIndex:(NSInteger)row{
    if ([self.delegate respondsToSelector:@selector(deleteSection:andIndex:)]) {
        [self.delegate deleteSection:_dabanContentView.tag andIndex:row];
    }
}


@end
