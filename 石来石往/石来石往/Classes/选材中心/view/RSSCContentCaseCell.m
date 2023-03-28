//
//  RSSCContentCaseCell.m
//  石来石往
//
//  Created by mac on 2021/10/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCContentCaseCell.h"

@interface RSSCContentCaseCell()

@property (nonatomic,strong)UIImageView * caseImage;

@property (nonatomic,strong)UILabel * caseNameLabel;

@property (nonatomic,strong)UILabel * caseDetailLabel;

@end

@implementation RSSCContentCaseCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * caseImage = [[UIImageView alloc]init];
        caseImage.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:caseImage];
        _caseImage = caseImage;
        
//        CGFloat height = ((SCW - Width_Real(32)) * Height_Real(193))/Width_Real(343);
        
        caseImage.sd_layout.topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, Width_Real(16)).rightSpaceToView(self.contentView, Width_Real(16)).heightIs(Height_Real(193));
        caseImage.layer.cornerRadius = Width_Real(4);
        caseImage.layer.masksToBounds = true;
        
        
        UILabel * caseNameLabel = [[UILabel alloc]init];
        caseNameLabel.text = @"海西石材有限公司";
        caseNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        caseNameLabel.font = [UIFont systemFontOfSize:Width_Real(17) weight:UIFontWeightMedium];
        caseNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:caseNameLabel];
        _caseNameLabel = caseNameLabel;
        
        caseNameLabel.sd_layout.topSpaceToView(caseImage, Height_Real(8)).leftEqualToView(caseImage).rightEqualToView(caseImage).heightIs(Height_Real(24));
        
        
        UILabel * caseDetailLabel = [[UILabel alloc]init];
        caseDetailLabel.text = @"哈达迪就石业有限公司 l 234浏览";
        caseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        caseDetailLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightMedium];
        caseDetailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:caseDetailLabel];
        
        caseDetailLabel.sd_layout.leftEqualToView(caseNameLabel).topSpaceToView(caseNameLabel, Height_Real(2)).rightEqualToView(caseNameLabel).heightIs(Height_Real(20));
        _caseDetailLabel = caseDetailLabel;
    }
    return self;
}


- (void)setCaseModel:(RSCasesModel *)caseModel{
    _caseModel = caseModel;
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    [self.caseImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_caseModel.urlList[0]]] placeholderImage:[UIImage imageNamed:@"01"]];
    
    self.caseNameLabel.text = _caseModel.caseCategoryNameCn;
    self.caseDetailLabel.text = _caseModel.enterpriseNameCn;
    
}


@end
