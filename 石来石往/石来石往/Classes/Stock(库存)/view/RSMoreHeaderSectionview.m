//
//  RSMoreHeaderSectionview.m
//  石来石往
//
//  Created by mac on 17/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMoreHeaderSectionview.h"

@implementation RSMoreHeaderSectionview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
        view.layer.cornerRadius = 2;
        view.layer.masksToBounds = YES;
        [self.contentView addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"信息标题";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor whiteColor];
        [view addSubview:titleLabel];
        
        
        //        UILabel * informatonLabel = [[UILabel alloc]init];
        //        informatonLabel.text = @"信息类型";
        //        informatonLabel.textAlignment = NSTextAlignmentCenter;
        //        informatonLabel.textColor = [UIColor whiteColor];
        //        informatonLabel.font = [UIFont systemFontOfSize:12];
        //        [view addSubview:informatonLabel];
        //
        //
        //
        //        UILabel * publisherLabell = [[UILabel alloc]init];
        //        publisherLabell.textColor = [UIColor whiteColor];
        //        publisherLabell.textAlignment = NSTextAlignmentCenter;
        //
        //        publisherLabell.font = [UIFont systemFontOfSize:12];
        //        publisherLabell.text = @"发布人";
        
        
        UILabel * dateLabel = [[UILabel alloc]init];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.text = @"发布时间";
        [view addSubview:dateLabel];
        
        
        view.sd_layout
        .topSpaceToView(self.contentView,0)
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0);
        
        
        
        titleLabel.sd_layout
        .leftSpaceToView(view,20)
        .topSpaceToView(view,0)
        .bottomSpaceToView(view,0)
        .widthIs((SCW/2)/2);
        
        
        
        //        informatonLabel.sd_layout
        //        .leftSpaceToView(titleLabel,0)
        //        .topSpaceToView(view,0)
        //        .bottomSpaceToView(view,0)
        //        .widthIs((SCW - (12+12))/4);
        
        
        
        //        [view addSubview:publisherLabell];
        //        publisherLabell.sd_layout
        //        .leftSpaceToView(informatonLabel,0)
        //        .topSpaceToView(view,0)
        //        .bottomSpaceToView(view,0)
        //        .widthIs((SCW - (12+12))/4);
        
        
        
        dateLabel.sd_layout
        .leftSpaceToView(titleLabel,60)
        .rightSpaceToView(view,20)
        .widthIs((SCW/2)/2)
        .topSpaceToView(view,0)
        .bottomSpaceToView(view,0);
        
        
    }
    
    return self;
    
    
}

@end
