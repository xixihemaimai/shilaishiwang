//
//  RSSegmentSecondCell.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSegmentSecondCell.h"



@interface RSSegmentSecondCell ()

{
    
    /**货主*/
   UILabel * _conmpanyLabel;
    

    
   
    
    
    
    
    
}


@end


@implementation RSSegmentSecondCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.userInteractionEnabled = YES;
        
       
        
       
        
        
        
        UILabel * conmpanyLabel = [[UILabel alloc]init];
        conmpanyLabel.font = [UIFont systemFontOfSize:15];
        conmpanyLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:conmpanyLabel];
        _conmpanyLabel = conmpanyLabel;
        conmpanyLabel.sd_layout
        .topSpaceToView(self.contentView, 2.5)
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(25);
        
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:midView];
        midView.sd_layout
        .leftEqualToView(conmpanyLabel)
        .rightEqualToView(conmpanyLabel)
        .topSpaceToView(conmpanyLabel, 0)
        .bottomSpaceToView(self.contentView, 2.5);
        
        
        
        /**颗*/
        UILabel * secondKeLabel = [[UILabel alloc]init];
        _secondKeLabel = secondKeLabel;
        secondKeLabel.textAlignment = NSTextAlignmentLeft;
        secondKeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondKeLabel.font = [UIFont systemFontOfSize:14];
        [midView addSubview:secondKeLabel];
        
        
        
        /**体积*/
        UILabel * secondTiLabel = [[UILabel alloc]init];
        _secondTiLabel = secondTiLabel;
        secondTiLabel.textAlignment = NSTextAlignmentCenter;
        secondTiLabel.font = [UIFont systemFontOfSize:14];
        secondTiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [midView addSubview:secondTiLabel];
        
        
        /**重量*/
        UILabel * secondWightLabel = [[UILabel alloc]init];
        _secondWightLabel = secondWightLabel;
        secondWightLabel.textAlignment = NSTextAlignmentRight;
        secondWightLabel.font = [UIFont systemFontOfSize:14];
        secondWightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [midView addSubview:secondWightLabel];
        
        
        secondKeLabel.sd_layout
        .leftSpaceToView(midView, 0)
        .topSpaceToView(midView, 0)
        .bottomSpaceToView(midView, 0)
        .widthIs((SCW - 24)/3);
        
        
        secondTiLabel.sd_layout
        .leftSpaceToView(secondKeLabel, 0)
        .topEqualToView(secondKeLabel)
        .bottomEqualToView(secondKeLabel)
        .widthIs((SCW - 24)/3);
        
        secondWightLabel.sd_layout
        .leftSpaceToView(secondTiLabel, 0)
        .topEqualToView(secondTiLabel)
        .bottomEqualToView(secondTiLabel)
        .rightSpaceToView(midView, 0);
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
        
    }
    return self;
}


- (void)setCompanyAndStoneModel:(RSCompanyAndStoneModel *)companyAndStoneModel{
    _companyAndStoneModel = companyAndStoneModel;
   // _conmpanyLabel.text = [NSString stringWithFormat:@"%@",companyAndStoneModel.companyName];
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
