//
//  RSRTPBHeaderView.m
//  石来石往
//
//  Created by mac on 2021/4/13.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSRTPBHeaderView.h"

@implementation RSRTPBHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
        [self.contentView addSubview:showView];
        
        
        UILabel * countLabel = [[UILabel alloc]init];
        countLabel.text = @"序号";
        countLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        countLabel.font = [UIFont systemFontOfSize:13];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [showView addSubview:countLabel];
        
        UILabel * styleLabel = [[UILabel alloc]init];
        styleLabel.text = @"费用类型";
        styleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        styleLabel.font = [UIFont systemFontOfSize:13];
        styleLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:styleLabel];
        
        
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"金额(元)";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.font = [UIFont systemFontOfSize:13];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [showView addSubview:numberLabel];
        
        showView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
        countLabel.sd_layout.centerYEqualToView(showView).leftSpaceToView(showView, 15).widthIs(50).heightIs(44);
        styleLabel.sd_layout.centerYEqualToView(showView).centerXEqualToView(showView).widthIs(150).heightIs(44);
        numberLabel.sd_layout.centerYEqualToView(showView).rightSpaceToView(showView, 15).widthIs(150).heightIs(44);
        
        
        
    }
    return self;
}


@end
