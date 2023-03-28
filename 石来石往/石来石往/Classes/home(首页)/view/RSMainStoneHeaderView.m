//
//  RSMainStoneHeaderView.m
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMainStoneHeaderView.h"

@implementation RSMainStoneHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView * CurrentView = [[UIView alloc]init];
        CurrentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [self.contentView addSubview:CurrentView];
        _CurrentView = CurrentView;
        //荒料
        UIButton * huangliaoBtn = [[UIButton alloc]init];
        [huangliaoBtn setTitle:@"荒料(3)" forState:UIControlStateNormal];
        [huangliaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        huangliaoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [huangliaoBtn setBackgroundColor:[UIColor clearColor]];
        [CurrentView addSubview:huangliaoBtn];
        _huangliaoBtn = huangliaoBtn;
        
        //大板
        UIButton * dabanBtn = [[UIButton alloc]init];
        [dabanBtn setTitle:@"大板(3)" forState:UIControlStateNormal];
        [dabanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        dabanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [dabanBtn setBackgroundColor:[UIColor clearColor]];
        [CurrentView addSubview:dabanBtn];
        _dabanBtn = dabanBtn;
        //底下的视图
        UIView * huangliaoView = [[UIView alloc]init];
        huangliaoView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        [CurrentView addSubview:huangliaoView];
        _huangliaoView = huangliaoView;
        
        UIView * dabanView = [[UIView alloc]init];
        dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
        [CurrentView addSubview:dabanView];
        _dabanView = dabanView;
        
        CurrentView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        huangliaoBtn.sd_layout
        .leftSpaceToView(CurrentView, 0)
        .topSpaceToView(CurrentView, 0)
        .widthIs(SCW/2)
        .bottomSpaceToView(CurrentView, 0);
        
        dabanBtn.sd_layout
        .leftSpaceToView(huangliaoBtn, 0)
        .rightSpaceToView(CurrentView, 0)
        .topSpaceToView(CurrentView, 0)
        .bottomSpaceToView(CurrentView, 0);
    
        huangliaoView.sd_layout
        .leftSpaceToView(CurrentView, 0)
        .heightIs(2)
        .widthIs(SCW/2)
        .bottomSpaceToView(CurrentView, 0);
        
        dabanView.sd_layout
        .leftSpaceToView(huangliaoView, 0)
        .rightSpaceToView(CurrentView, 0)
        .heightIs(1)
        .bottomSpaceToView(CurrentView, 0);
        
   
    }
    return self;
}

@end
