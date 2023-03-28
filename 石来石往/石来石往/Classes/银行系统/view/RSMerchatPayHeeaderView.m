//
//  RSMerchatPayHeeaderView.m
//  石来石往
//
//  Created by mac on 2021/4/13.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSMerchatPayHeeaderView.h"

@implementation RSMerchatPayHeeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
        [self.contentView addSubview:showView];
        
        
        UILabel * countLabel = [[UILabel alloc]init];
        countLabel.text = @"付款时间";
        countLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        countLabel.font = [UIFont systemFontOfSize:15];
        countLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:countLabel];
        
        UILabel * styleLabel = [[UILabel alloc]init];
        styleLabel.text = @"金额(元)";
        styleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        styleLabel.font = [UIFont systemFontOfSize:15];
        styleLabel.textAlignment = NSTextAlignmentRight;
        [showView addSubview:styleLabel];
        
        
        showView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
        countLabel.sd_layout.centerYEqualToView(showView).leftSpaceToView(showView, 26).widthIs(SCW/2).heightIs(44);
        styleLabel.sd_layout.centerYEqualToView(showView).leftSpaceToView(countLabel, 0).rightSpaceToView(showView, 46).heightIs(44);
        
        
    }
    return self;
}

@end
