//
//  RSSCStoneHeaderView.m
//  石来石往
//
//  Created by mac on 2021/10/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCStoneHeaderView.h"
//#import "ZKImgRunLoopView.h"


@interface RSSCStoneHeaderView()

//@property (nonatomic,strong) ZKImgRunLoopView *imgRunView;

@end


@implementation RSSCStoneHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * imgRunImage = [[UIImageView alloc]init];
        imgRunImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"banner01" ofType:@".png"]];
        [self addSubview:imgRunImage];
        imgRunImage.sd_layout.leftSpaceToView(self, Width_Real(16)).topSpaceToView(self, 4).rightSpaceToView(self, Width_Real(16)).bottomSpaceToView(self, 4);
        imgRunImage.layer.cornerRadius = 4;
        imgRunImage.clipsToBounds = YES;
        //这边要设置图片轮播图
//        ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(Width_Real(16), Height_Real(4), SCW - Width_Real(32), ((SCW - Width_Real(32)) * Height_Real(120)) / Width_Real(343)) placeholderImg:[UIImage imageNamed:@"01"]];
////        imgRunView.backgroundColor = [UIColor yellowColor];
//        imgRunView.pageControl.hidden = NO;
//        [self addSubview:imgRunView];
//        imgRunView.pageControl.PageControlContentMode =  JhPageControlContentModeCenter;
//        imgRunView.pageControl.PageControlStyle = JhPageControlStyelDefault;
//        imgRunView.pageControl.currentColor = [UIColor colorWithHexColorStr:@"#3385ff"];
//        imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#ffffff" alpha:0.5];
//        imgRunView.pageControl.controlSpacing = Width_Real(10);
//        imgRunView.pageControl.yj_y = self.yj_height - Height_Real(8);
//        imgRunView.pageControl.yj_centerX = self.yj_centerX;
//        NSArray * array = @[@"banner01"];
//        imgRunView.imgArray = array;
//        _imgRunView = imgRunView;
    }
    return self;
}

@end
