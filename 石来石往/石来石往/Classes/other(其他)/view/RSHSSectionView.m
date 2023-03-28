//
//  RSHSSectionView.m
//  石来石往
//
//  Created by mac on 17/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHSSectionView.h"

@implementation RSHSSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self= [super initWithReuseIdentifier:reuseIdentifier]) {
        
         self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        
//        UIView * topview = [[UIView alloc]init];
//        topview.backgroundColor = [UIColor whiteColor];
//        [self addSubview:topview];
//        _topview = topview;
//        topview.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .topSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0)
        
        
//        UIImageView * imageview = [[UIImageView alloc]init];
//        imageview.image = [UIImage imageNamed:@"火"];
//        [topview addSubview:imageview];
//
//        imageview.sd_layout
//        .leftSpaceToView(topview, 12)
//        .topSpaceToView(topview, 10.5)
//        .bottomSpaceToView(topview, 10.5)
//        .widthIs(26);
//
//
//        UILabel * nameLabel = [[UILabel alloc]init];
//        _nameLabel = nameLabel;
//        //nameLabel.text = @"热门荒料交易排行榜";
//        nameLabel.font = [UIFont systemFontOfSize:16];
//        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        nameLabel.textAlignment = NSTextAlignmentLeft;
//
//        [topview addSubview:nameLabel];
//
//
//        nameLabel.sd_layout
//        .leftSpaceToView(imageview, 5)
//        .topEqualToView(imageview)
//        .bottomEqualToView(imageview)
//        .rightSpaceToView(topview, 12);
        
        
//        UIView * diView = [[UIView alloc]init];
//        diView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
//        [topview addSubview:diView];
//        
//        diView.sd_layout
//        .leftSpaceToView(topview, 0)
//        .rightSpaceToView(topview, 0)
//        .bottomSpaceToView(topview, 0)
//        .heightIs(1);
        
        
        
        
        
        
//        UIView * bottomview = [[UIView alloc]init];
//        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
//        [self addSubview:bottomview];
//
//
//        bottomview.sd_layout
//        .leftSpaceToView(self, 0)
//        .rightSpaceToView(self, 0)
//        .topSpaceToView(topview, 0)
//        .bottomSpaceToView(self, 0);
        
        
        
        
        
        
        UILabel * ranklabel = [[UILabel alloc]init];
        ranklabel.text = @"排名";
        ranklabel.textAlignment = NSTextAlignmentCenter;
        ranklabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        ranklabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:ranklabel];
        
        
        UILabel *ownerLabel = [[UILabel alloc]init];
        ownerLabel.text = @"石种";
        ownerLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
       // ownerLabel.textColor = [UIColor redColor];
         ownerLabel.textAlignment = NSTextAlignmentCenter;
        ownerLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:ownerLabel];
        
        
        UILabel *volumeLabel = [[UILabel alloc]init];
        _volumeLabel = volumeLabel;
       // volumeLabel.text = @"体积";
        volumeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        volumeLabel.textAlignment = NSTextAlignmentCenter;
        volumeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:volumeLabel];
        
        
        
        ranklabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0)
        .widthIs(SCW/3);
        
        ownerLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(ranklabel,0)
        .topSpaceToView(self.contentView,0)
        .centerXEqualToView(self.contentView)
        .bottomSpaceToView(self.contentView,0)
        .rightSpaceToView(volumeLabel,0)
        .widthIs(SCW/3);
        
        volumeLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(ownerLabel,0)
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .widthIs(SCW/3);
        
        
    }
    
    return self;
    
    
}

@end
