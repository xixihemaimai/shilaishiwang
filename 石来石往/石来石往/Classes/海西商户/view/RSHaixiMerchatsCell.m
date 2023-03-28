//
//  RSHaixiMerchatsCell.m
//  石来石往
//
//  Created by mac on 2021/10/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSHaixiMerchatsCell.h"

@implementation RSHaixiMerchatsCell



//- (void)drawRect:(CGRect)rect{
    
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor =  [UIColor whiteColor];
        
        
        //中间view
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:showView];
        _showView = showView;
        showView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
        showView.layer.shadowOffset = CGSizeMake(0,0);
        showView.layer.shadowRadius = Width_Real(16);
        showView.layer.shadowOpacity = Width_Real(1);
        // Radius Code
        showView.layer.cornerRadius = Width_Real(8);
        showView.sd_layout.centerYEqualToView(self.contentView).topSpaceToView(self.contentView, Height_Real(10)).bottomSpaceToView(self.contentView, Height_Real(10)).leftSpaceToView(self.contentView, Width_Real(16)).rightSpaceToView(self.contentView, Width_Real(16));
       
       
        //名称
        UILabel * namelabel = [[UILabel alloc] init];
        namelabel.text = @"荒料总库存量";
        namelabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightSemibold];
        namelabel.textColor = [UIColor colorWithHexColorStr:@"333333"];
        namelabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:namelabel];
       
        namelabel.sd_layout.leftSpaceToView(showView, Width_Real(16)).widthRatioToView(showView, 0.5).topSpaceToView(showView, Height_Real(25)).heightIs(Height_Real(21));
        _namelabel = namelabel;
        
        //数字
        UILabel * numLabel = [[UILabel alloc]init];
        numLabel.text = @"120142.531";
        numLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numLabel.numberOfLines = 0;
        numLabel.textAlignment = NSTextAlignmentLeft;
        numLabel.font = [UIFont systemFontOfSize:Width_Real(24) weight:UIFontWeightRegular];
        [showView addSubview:numLabel];
        numLabel.sd_layout.leftSpaceToView(showView, Width_Real(16)).topSpaceToView(namelabel, Height_Real(6)).bottomSpaceToView(showView, Height_Real(5)).widthIs(0);
        _numLabel = numLabel;
        
        //单位
        UILabel * companyLabel = [[UILabel alloc]init];
        companyLabel.text = @"m²";
        companyLabel.font = [UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightRegular];
        companyLabel.textAlignment = NSTextAlignmentLeft;
        companyLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [showView addSubview:companyLabel];
        
        companyLabel.sd_layout.leftSpaceToView(numLabel, 0).topEqualToView(numLabel).bottomEqualToView(numLabel).widthIs(Width_Real(30));
        _companyLabel = companyLabel;
        
        
        UIImageView * haixiMerchatImage = [[UIImageView alloc]init];
        [showView addSubview:haixiMerchatImage];
        _haixiMerchatImage = haixiMerchatImage;
        
        haixiMerchatImage.sd_layout.centerYEqualToView(showView).rightSpaceToView(showView, Width_Real(28)).widthIs(Width_Real(49)).heightEqualToWidth();
       
    }
    return self;
}

- (void)setNumStr:(NSString *)numStr{
    _numStr = numStr;
   
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:Width_Real(24)]};
    CGFloat length = [_numStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 5;
    
    _numLabel.sd_layout.leftSpaceToView(_showView, Width_Real(16)).topSpaceToView(_namelabel, Height_Real(6)).bottomSpaceToView(_showView, Height_Real(5)).widthIs(length);
//    CLog(@"-------------------------%lf",length);
    
    _numLabel.text = _numStr;
    
    _companyLabel.sd_layout.leftSpaceToView(_numLabel, 0).topEqualToView(_numLabel).bottomEqualToView(_numLabel).widthIs(Width_Real(30));
    
}






@end
