//
//  RSDetailSegmentCell.m
//  石来石往
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDetailSegmentCell.h"


@interface RSDetailSegmentCell()

{
    
}

@end


@implementation RSDetailSegmentCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel  * countLabel = [[UILabel alloc]init];
        countLabel.font = [UIFont systemFontOfSize:17];
        countLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
        
        countLabel.sd_layout.leftSpaceToView(self.contentView, 12).topSpaceToView(self.contentView, 5).heightIs(16).widthIs(40);
        
        UILabel * huangLabel = [[UILabel alloc]init];
        huangLabel.text = @"荒料号:";
        huangLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        huangLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:huangLabel];
        
        
        huangLabel.sd_layout.leftSpaceToView(countLabel, 10).topEqualToView(countLabel).bottomEqualToView(countLabel).widthIs(70);
        
        
        
        UILabel * huangliaoLabel = [[UILabel alloc]init];
        
        huangliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        huangliaoLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:huangliaoLabel];
        _huangliaoLabel = huangliaoLabel;
        
        huangliaoLabel.sd_layout.leftSpaceToView(huangLabel, 10).rightSpaceToView(self.contentView, 12).topEqualToView(huangLabel).bottomEqualToView(huangLabel);
        
        
        UILabel * rugeLabel = [[UILabel alloc]init];
        rugeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        rugeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:rugeLabel];
        rugeLabel.text = @"规   格:";
        rugeLabel.sd_layout.leftEqualToView(huangLabel).topSpaceToView(huangLabel, 5).rightEqualToView(huangLabel).heightIs(16);
        
        
        
        
        UILabel * guiLabel = [[UILabel alloc]init];
        
        guiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        guiLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:guiLabel];
        _guiLabel = guiLabel;
        
        guiLabel.sd_layout
        .leftEqualToView(huangliaoLabel)
        .widthRatioToView(self.contentView, 0.5)
        .topEqualToView(rugeLabel)
        .bottomEqualToView(rugeLabel);
        
        
        
        UILabel * tiLabel = [[UILabel alloc]init];
        _tiLabel = tiLabel;
        
        tiLabel.font = [UIFont systemFontOfSize:14];
        tiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:tiLabel];
        
        
        tiLabel.sd_layout
        .leftEqualToView(rugeLabel)
        .rightEqualToView(rugeLabel)
        .topSpaceToView(rugeLabel, 5)
        .heightIs(16);
        
        
        UILabel * tijiLabel = [[UILabel alloc]init];
        
        tijiLabel.textColor  = [UIColor colorWithHexColorStr:@"#999999"];
        tijiLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:tijiLabel];
        
        _tijiLabel= tijiLabel;
        tijiLabel.sd_layout
        .leftEqualToView(guiLabel)
        .rightEqualToView(guiLabel)
        .topEqualToView(tiLabel)
        .bottomEqualToView(tiLabel);
        
        
        
        UILabel * weightLabel = [[UILabel alloc]init];
        _weightLabel = weightLabel;
        //weightLabel.text = @"重   量:";
        weightLabel.textColor  = [UIColor colorWithHexColorStr:@"#999999"];
        weightLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:weightLabel];
        
        weightLabel.sd_layout
        .leftEqualToView(tiLabel)
        .rightEqualToView(tiLabel)
        .topSpaceToView(tiLabel, 5)
        .heightIs(16);
        
        
        UILabel * zhongLabel = [[UILabel alloc]init];
        
        zhongLabel.textColor  = [UIColor colorWithHexColorStr:@"#999999"];
        zhongLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:zhongLabel];
        _zhongLabel = zhongLabel;
        
        zhongLabel.sd_layout
        .leftEqualToView(tijiLabel)
        .rightEqualToView(tijiLabel)
        .topEqualToView(weightLabel)
        .bottomEqualToView(weightLabel);
        
        
        
        
        UILabel * cangLabel = [[UILabel alloc]init];
        _cangLabel = cangLabel;
        cangLabel.text = @"仓储位置:";
        cangLabel.textColor  = [UIColor colorWithHexColorStr:@"#999999"];
        cangLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:cangLabel];
        cangLabel.sd_layout
        .leftEqualToView(weightLabel)
        .rightEqualToView(weightLabel)
        .topSpaceToView(weightLabel, 5)
        .heightIs(16);
        
        
        UILabel * cangkuLabel = [[UILabel alloc]init];
        
        cangkuLabel.textColor  = [UIColor colorWithHexColorStr:@"#999999"];
        cangkuLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:cangkuLabel];
        _cangkuLabel = cangkuLabel;
        
        cangkuLabel.sd_layout
        .leftEqualToView(zhongLabel)
        .rightEqualToView(huangliaoLabel)
        .topEqualToView(cangLabel)
        .bottomEqualToView(cangLabel);
        
        
        
        
        
        
        
        UIButton * loveBtn = [[UIButton alloc]init];
        [self.contentView addSubview:loveBtn];
        _loveBtn = loveBtn;
        
        loveBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(22)
        .widthIs(25);
        
        
        
        
        UILabel * bottomLabel = [[UILabel alloc]init];
        bottomLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomLabel];
        
        
        bottomLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
    }
    
    return self;
    
    
}




- (void)setSearchType:(NSString *)searchType{
    
    _searchType = searchType;
    
    if ([_searchType isEqualToString:@"huangliao"]) {
        _tiLabel.text = @"体   积:";
        _weightLabel.text = @"重   量:";
        
//        _zhongLabel.hidden = NO;
//        _weightLabel.hidden = NO;
//        
//        
//        _cangLabel.sd_layout
//        .topSpaceToView(_weightLabel, 5);
//        _cangkuLabel.sd_layout
//        .topSpaceToView(_zhongLabel, 5);
        
        
    }else{
        
        
       
        
         _tiLabel.text = @"面   积:";
        _weightLabel.text = @"匝   号:";
        
        
//        _zhongLabel.hidden = YES;
//        _weightLabel.hidden = YES;
//        _cangLabel.sd_layout
//        .topSpaceToView(_tiLabel, 5);
//        _cangkuLabel.sd_layout
//        .topSpaceToView(_tijiLabel, 5);
        
        
    }
    
    
}


- (void)setDetailSegmnetModel:(RSDetailSegmentModel *)detailSegmnetModel{
    
    _detailSegmnetModel = detailSegmnetModel;
    
    
    
    

   
    
   
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
