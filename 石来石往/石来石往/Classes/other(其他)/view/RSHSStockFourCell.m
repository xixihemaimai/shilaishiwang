//
//  RSHSStockFourCell.m
//  石来石往
//
//  Created by mac on 2019/1/31.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSHSStockFourCell.h"
#import "WSLRollView.h"
#import "RSHSStockNewThirdCell.h"
#import "RSBrandEnterPriseModel.h"
#define margin 5
#define ECA 3

@interface RSHSStockFourCell()<WSLRollViewDelegate>

@end

@implementation RSHSStockFourCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
//        WSLRollView * stepRollView = [[WSLRollView alloc] initWithFrame:CGRectMake(0, 0, SCW, 121)];
//        stepRollView.backgroundColor = [UIColor whiteColor];
//
//        stepRollView.scrollStyle = WSLRollViewScrollStyleStep;
//        stepRollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        stepRollView.loopEnabled = YES;
//        stepRollView.speed = 30;
//        stepRollView.delegate = self;
//        [stepRollView registerClass:[RSHSStockNewThirdCell class] forCellWithReuseIdentifier:@"StepRollID"];
//        [self.contentView addSubview:stepRollView];
//
        
        
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
    CGFloat pictureViewW = (showView.bounds.size.width - (ECA + 1) * margin)/ECA;
    //NSLog(@"--------------%lf",pictureViewW);
    CGFloat pictureViewH = pictureViewW * 7/10;
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
         RSBrandEnterPriseModel * brandEnterPriseModel = _array[i];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpSearchHuangAndDabanViewIndex:)];
        [pictureView addGestureRecognizer:tap];
        
        UIImageView * contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pictureView.bounds.size.width, pictureView.bounds.size.height)];
        contentImageView.image = [UIImage imageNamed:@"圆角矩形 710 拷贝"];
        contentImageView.clipsToBounds = YES;
        contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        [pictureView addSubview:contentImageView];
        
        contentImageView.layer.borderColor = [UIColor colorWithHexColorStr:@"#f5f5f5"].CGColor;
        contentImageView.layer.borderWidth = 1;
        
        
        UIImageView * hsstockImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, contentImageView.bounds.size.width, contentImageView.bounds.size.height)];
//        hsstockImageView.contentMode = UIViewContentModeScaleAspectFill;
//        hsstockImageView.clipsToBounds = YES;
        hsstockImageView.userInteractionEnabled = YES;
        [contentImageView addSubview:hsstockImageView];
        
        
        UILabel * hsstockLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(hsstockImageView.frame), contentImageView.bounds.size.width - 12, contentImageView.bounds.size.height - CGRectGetMaxY(hsstockImageView.frame))];
        hsstockLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        hsstockLabel.font = [UIFont systemFontOfSize:15];
        hsstockLabel.textAlignment = NSTextAlignmentLeft;
        [contentImageView addSubview:hsstockLabel];
        hsstockLabel.text = @"火凤凰";
        
        [hsstockImageView sd_setImageWithURL:[NSURL URLWithString:brandEnterPriseModel.logo] placeholderImage:[UIImage imageNamed:@"512"]];
        hsstockLabel.text = brandEnterPriseModel.userName;
        pictureView.layer.cornerRadius = 5;
        pictureView.layer.masksToBounds = YES;
    }
}



- (void)jumpSearchHuangAndDabanViewIndex:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(jumpCompanyMainWebViewWithIndex:)]) {
        [self.delegate jumpCompanyMainWebViewWithIndex:tap.view.tag];
    }
}



//- (void)setArray:(NSArray *)array{
//    _array = array;
//    for (WSLRollView * stepRollView in self.contentView.subviews) {
//        [stepRollView removeFromSuperview];
//    }
//    WSLRollView * stepRollView = [[WSLRollView alloc] initWithFrame:CGRectMake(0, 0, SCW, 121)];
//    stepRollView.backgroundColor = [UIColor whiteColor];
//    stepRollView.sourceArray = [NSMutableArray arrayWithArray:_array];
//    stepRollView.scrollStyle = WSLRollViewScrollStyleStep;
//    stepRollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    stepRollView.loopEnabled = YES;
//    stepRollView.speed = 30;
//    stepRollView.delegate = self;
//    [stepRollView registerClass:[RSHSStockNewThirdCell class] forCellWithReuseIdentifier:@"StepRollID"];
//    [self.contentView addSubview:stepRollView];
//}
//
//- (CGSize)rollView:(WSLRollView *)rollView sizeForItemAtIndex:(NSInteger)index{
//    return CGSizeMake(152, 110);
//}
//
////间隔
//- (CGFloat)spaceOfItemInRollView:(WSLRollView *)rollView{
//    return 9;
//}
//
////内边距
//- (UIEdgeInsets)paddingOfRollView:(WSLRollView *)rollView{
//    return UIEdgeInsetsMake(1, 9, 4, 9);
//}
//
//
////点击事件
//- (void)rollView:(WSLRollView *)rollView didSelectItemAtIndex:(NSInteger)index{
//    if ([self.delegate respondsToSelector:@selector(jumpCompanyMainWebViewWithIndex:)]) {
//        [self.delegate jumpCompanyMainWebViewWithIndex:index];
//    }
//}


//返回自定义cell样式
//-(WSLRollViewCell *)rollView:(WSLRollView *)rollView cellForItemAtIndex:(NSInteger)index{
//    RSHSStockNewThirdCell * cell = (RSHSStockNewThirdCell *)[rollView dequeueReusableCellWithReuseIdentifier:@"StepRollID" forIndex:index];
//    RSBrandEnterPriseModel * brandEnterPriseModel = rollView.sourceArray[index];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:brandEnterPriseModel.logo] placeholderImage:[UIImage imageNamed:@"512"]];
//    cell.layer.shadowColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.14].CGColor;
//    cell.layer.shadowOffset = CGSizeMake(0,1);
//    cell.layer.shadowOpacity = 1;
//    cell.layer.shadowRadius = 3;
//    cell.layer.cornerRadius = 3;
//    cell.contentView.layer.masksToBounds = YES;
//    return cell;
//}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
