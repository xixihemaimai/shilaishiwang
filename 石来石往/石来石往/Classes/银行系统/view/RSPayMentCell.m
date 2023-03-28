//
//  RSPayMentCell.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSPayMentCell.h"

@implementation RSPayMentCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
     
        //视图
        UIView * view = [[UIView alloc]init];
        view.layer.borderColor = [UIColor colorWithHexColorStr:@"#CACACA"].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,0);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 4;
        [self.contentView addSubview:view];
        
        //蓝点
        UIView * blueView = [[UIView alloc]init];
        blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        [view addSubview:blueView];
        
        
        //名称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"加工费用";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:nameLabel];
        
        
        //费用
        UILabel * moneyLabel = [[UILabel alloc]init];
        moneyLabel.text = @"233,343,23元";
        moneyLabel.font = [UIFont systemFontOfSize:16];
        moneyLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        moneyLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:moneyLabel];
        
        view.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 0).widthIs(SCW/2 - 22).heightEqualToWidth();
        
        blueView.sd_layout.leftSpaceToView(view, 11.5).topSpaceToView(view, 15).widthIs(8.5).heightEqualToWidth();
        
        nameLabel.sd_layout.leftSpaceToView(blueView, 7).topSpaceToView(view, 18).rightSpaceToView(view, 10).heightIs(22.5);
        
        moneyLabel.sd_layout.leftEqualToView(nameLabel).rightEqualToView(nameLabel).topSpaceToView(nameLabel, 8).heightIs(22.5);
        
        
        
    }
    return  self;
}



@end
