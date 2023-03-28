//
//  RSHSStockCell.m
//  石来石往
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHSStockCell.h"
#define margin 9
#define ECA 2
#import "RSPublishButton.h"
@interface RSHSStockCell()

@end


@implementation RSHSStockCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
    }
    return self;
}





- (void)setArray:(NSArray *)array{
    
    _array = array;    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView * showView = [[UIView alloc]initWithFrame:CGRectMake(3, 0, SCW - 6, 392)];
    showView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:showView];
    CGFloat pictureViewW = (showView.bounds.size.width - (ECA + 1)*margin)/ECA;
    CGFloat pictureViewH = 187;
    for (int i = 0 ; i < _array.count; i++) {
        UIView * pictureView = [[UIView alloc]init];
        pictureView.userInteractionEnabled = YES;
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        pictureView.tag = 10000 + i;
        CGFloat pictureViewX =  colom * (margin + pictureViewW) + margin;
        CGFloat pictureViewXY =  row * (margin + pictureViewH) + margin;
        pictureView.frame = CGRectMake(pictureViewX, pictureViewXY, pictureViewW, pictureViewH);
        [showView addSubview:pictureView];
        RSHotStoneModel * hotStoneModel = _array[i];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpSearchHuangAndDabanViewIndex:)];
        [pictureView addGestureRecognizer:tap];
        
        UIImageView * contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 0, pictureView.bounds.size.width - 2, pictureView.bounds.size.height)];
        contentImageView.image = [UIImage imageNamed:@"圆角矩形 710 拷贝"];
        contentImageView.clipsToBounds = YES;
        contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        [pictureView addSubview:contentImageView];
        

        UIImageView * hsstockImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, contentImageView.bounds.size.width, 154)];
        hsstockImageView.contentMode = UIViewContentModeScaleAspectFill;
        hsstockImageView.clipsToBounds = YES;
        hsstockImageView.userInteractionEnabled = YES;
        [contentImageView addSubview:hsstockImageView];
        
        
        UILabel * hsstockLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(hsstockImageView.frame), contentImageView.bounds.size.width - 12, contentImageView.bounds.size.height - CGRectGetMaxY(hsstockImageView.frame))];
        hsstockLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        hsstockLabel.font = [UIFont systemFontOfSize:15];
        hsstockLabel.textAlignment = NSTextAlignmentLeft;
        [contentImageView addSubview:hsstockLabel];
        hsstockLabel.text = @"火凤凰";
        
        
        [hsstockImageView sd_setImageWithURL:[NSURL URLWithString:hotStoneModel.stoneImg] placeholderImage:[UIImage imageNamed:@"512"]];
        hsstockLabel.text = hotStoneModel.stoneName;
        
        pictureView.layer.cornerRadius = 5;
        pictureView.layer.masksToBounds = YES;
    }
}

- (void)jumpSearchHuangAndDabanViewIndex:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(jumpSearchAndDabanViewControllerIndex:)]) {
        [self.delegate jumpSearchAndDabanViewControllerIndex:tap.view.tag];
    }
}




@end
