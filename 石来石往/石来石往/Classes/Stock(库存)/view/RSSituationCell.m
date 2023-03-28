//
//  RSSituationCell.m
//  石来石往
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSituationCell.h"

@interface RSSituationCell ()





@end

@implementation RSSituationCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        
        UIImageView *imageview = [[UIImageView alloc]init];
        [self.contentView addSubview:imageview];
        self.imageview = imageview;
        
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        _label = label;
        
        UILabel * blockLabel = [[UILabel alloc]init];
        blockLabel.text = @"荒料";
        blockLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        blockLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:blockLabel];
        _blockLabel = blockLabel;
        
        UILabel *osakaLabel = [[UILabel alloc]init];
        osakaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        osakaLabel.text = @"大板";
        osakaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:osakaLabel];
        _osakaLabel = osakaLabel;
        
        UILabel * keLabel = [[UILabel alloc]init];
        keLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        keLabel.text = @"545颗";
        keLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:keLabel];
        _keLabel = keLabel;
        
        UILabel *zaLabel = [[UILabel alloc]init];
        zaLabel.text = @"125匝";
        zaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        zaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:zaLabel];
        _zaLabel = zaLabel;
        
        UILabel * liLabel = [[UILabel alloc]init];
        liLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        liLabel.text = @"545855m3";
        liLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:liLabel];
        _liLabel = liLabel;
        
        UILabel *piLabel = [[UILabel alloc]init];
        piLabel.textColor = [UIColor colorWithHexColorStr:@"333333"];
        piLabel.text = @"545855m2";
        piLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:piLabel];
        _piLabel = piLabel;
        
        UILabel * bottomlabel = [[UILabel alloc]init];
        bottomlabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomlabel];
        
        
        
        
        
        imageview.sd_layout
        .leftSpaceToView(self.contentView,12)
        .topSpaceToView(self.contentView,13)
        .bottomSpaceToView(self.contentView,13)
        .widthIs(24);
        
        label.sd_layout
        .leftSpaceToView(imageview,10)
        .topEqualToView(imageview)
        .bottomEqualToView(imageview)
        .widthIs(65);
        
        
        
        
        if (iPhone4) {
            blockLabel.sd_layout
            .leftSpaceToView(label,12.5)
            .topSpaceToView(self.contentView,5)
            .heightIs(20)
            .widthIs(40);
            
            osakaLabel.sd_layout
            .leftEqualToView(blockLabel)
            .topSpaceToView(blockLabel,5)
            .bottomSpaceToView(self.contentView,5)
            .widthIs(40);
            
            
            keLabel.sd_layout
            .leftSpaceToView(blockLabel,12.5)
            .topEqualToView(blockLabel)
            .bottomEqualToView(blockLabel)
            .widthIs(50);
            
            
            zaLabel.sd_layout
            .leftEqualToView(keLabel)
            .topEqualToView(osakaLabel)
            .bottomEqualToView(osakaLabel)
            .rightEqualToView(keLabel);
        }else if (iPhone5){
            blockLabel.sd_layout
            .leftSpaceToView(label,5.5)
            .topSpaceToView(self.contentView,5)
            .heightIs(20)
            .widthIs(40);
            
            osakaLabel.sd_layout
            .leftEqualToView(blockLabel)
            .topSpaceToView(blockLabel,5)
            .bottomSpaceToView(self.contentView,5)
            .widthIs(40);
            
            
            keLabel.sd_layout
            .leftSpaceToView(blockLabel,5.5)
            .topEqualToView(blockLabel)
            .bottomEqualToView(blockLabel)
            .widthIs(50);
            
            
            zaLabel.sd_layout
            .leftEqualToView(keLabel)
            .topEqualToView(osakaLabel)
            .bottomEqualToView(osakaLabel)
            .rightEqualToView(keLabel);
        }else{
            blockLabel.sd_layout
            .leftSpaceToView(label,27.5)
            .topSpaceToView(self.contentView,5)
            .heightIs(20)
            .widthIs(40);
            
            osakaLabel.sd_layout
            .leftEqualToView(blockLabel)
            .topSpaceToView(blockLabel,5)
            .bottomSpaceToView(self.contentView,5)
            .widthIs(40);
            
            
            keLabel.sd_layout
            .leftSpaceToView(blockLabel,27.5)
            .topEqualToView(blockLabel)
            .bottomEqualToView(blockLabel)
            .widthIs(50);
            
            
            zaLabel.sd_layout
            .leftEqualToView(keLabel)
            .topEqualToView(osakaLabel)
            .bottomEqualToView(osakaLabel)
            .rightEqualToView(keLabel);
        }
        
      
        
        
        liLabel.sd_layout
        .leftSpaceToView(keLabel,5)
        .topEqualToView(keLabel)
        .bottomEqualToView(keLabel)
        .rightSpaceToView(self.contentView,12);
        
        
        piLabel.sd_layout
        .leftEqualToView(liLabel)
        .topEqualToView(zaLabel)
        .bottomEqualToView(zaLabel)
        .rightEqualToView(liLabel);
        
        
        bottomlabel.sd_layout
        .leftEqualToView(label)
        .rightSpaceToView(self.contentView,12)
        .bottomSpaceToView(self.contentView,0)
        .heightIs(1);
        
        
    }
    return self;
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
