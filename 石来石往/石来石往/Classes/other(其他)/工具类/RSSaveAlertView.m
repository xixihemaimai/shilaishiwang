//
//  RSSaveAlertView.m
//  石来石往
//
//  Created by mac on 2019/2/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSSaveAlertView.h"


@interface RSSaveAlertView()

@property(nonatomic,strong)UIView *bgView;
@end

@implementation RSSaveAlertView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // [self createView];
        //[self cleateDabanView];
        
    }
    return self;
}




- (void)cleateDabanView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self addSubview:view];
    
    UIView * topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 1)];
    topview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [view addSubview:topview];
    
//    UIView * totalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 36)];
//    totalView.backgroundColor = [UIColor clearColor];
//    [view addSubview:totalView];
//
//
//    UILabel * totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCW, 36)];
//    totalLabel.backgroundColor = [UIColor clearColor];
//    totalLabel.text = @"合计";
//    totalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    totalLabel.font = [UIFont systemFontOfSize:15];
//    totalLabel.textAlignment = NSTextAlignmentCenter;
//    [totalView addSubview:totalLabel];
//
//
//    UIImageView * totalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 + 4 + 12, 14.5, 12, 7)];
//    totalImageView.image = [UIImage imageNamed:@"system-pull-down"];
//    totalImageView.contentMode = UIViewContentModeScaleAspectFill;
//    totalImageView.clipsToBounds = YES;
//    [totalView addSubview:totalImageView];
//
//
//    UIView * bottomView  = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SCW, 1)];
//    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
//    [totalView addSubview:bottomView];
    
    
    //底部视图
    UILabel * totalTurnsLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(topview.frame)+ 11, 72, 21)];
    totalTurnsLabel.text = @"总匝数";
    totalTurnsLabel.textAlignment = NSTextAlignmentLeft;
    totalTurnsLabel.font = [UIFont systemFontOfSize:15];
    totalTurnsLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalTurnsLabel];
    
    UILabel * totalTurnsDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(topview.frame)+ 11, 100, 21)];
    totalTurnsDetailLabel.text = @"0";
    totalTurnsDetailLabel.textAlignment = NSTextAlignmentRight;
    totalTurnsDetailLabel.font = [UIFont systemFontOfSize:15];
    totalTurnsDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalTurnsDetailLabel];
    //总匝数
    totalTurnsDetailLabel.text = self.totalWeight;
    
    UILabel * totalNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalTurnsLabel.frame)+ 6, 80, 21)];
    totalNumberLabel.text = @"总片数";
    totalNumberLabel.textAlignment = NSTextAlignmentLeft;
    totalNumberLabel.font = [UIFont systemFontOfSize:15];
    totalNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalNumberLabel];
    
    UILabel * totalNumberDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalTurnsDetailLabel.frame)+ 6, 100, 21)];
    totalNumberDetailLabel.text = @"0";
    totalNumberDetailLabel.textAlignment = NSTextAlignmentRight;
    totalNumberDetailLabel.font = [UIFont systemFontOfSize:15];
    totalNumberDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalNumberDetailLabel];
    //总片数
    totalNumberDetailLabel.text = self.totalNumber;
    
    
    
    UILabel * totalOriginalAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalNumberLabel.frame)+ 6, 120, 21)];
    totalOriginalAreaLabel.text = @"总原始面积(m²)";
    totalOriginalAreaLabel.textAlignment = NSTextAlignmentLeft;
    totalOriginalAreaLabel.font = [UIFont systemFontOfSize:15];
    totalOriginalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalOriginalAreaLabel];
    
    UILabel * totalOriginalDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalNumberDetailLabel.frame)+ 6, 100, 21)];
    totalOriginalDetailLabel.text = @"0";
    totalOriginalDetailLabel.textAlignment = NSTextAlignmentRight;
    totalOriginalDetailLabel.font = [UIFont systemFontOfSize:15];
    totalOriginalDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalOriginalDetailLabel];
    totalOriginalDetailLabel.text = self.totalPreArea;
    //总原始面积
    UILabel * totalBuckleAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalOriginalAreaLabel.frame)+ 6, 120, 21)];
    totalBuckleAreaLabel.text = @"总扣尺面积(m²)";
    totalBuckleAreaLabel.textAlignment = NSTextAlignmentLeft;
    totalBuckleAreaLabel.font = [UIFont systemFontOfSize:15];
    totalBuckleAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalBuckleAreaLabel];
    
    UILabel * totalBuckleDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalOriginalDetailLabel.frame)+ 6, 100, 21)];
    totalBuckleDetailLabel.text = @"0";
    totalBuckleDetailLabel.textAlignment = NSTextAlignmentRight;
    totalBuckleDetailLabel.font = [UIFont systemFontOfSize:15];
    totalBuckleDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalBuckleDetailLabel];
    totalBuckleDetailLabel.text = self.totalDedArea;
    //总扣尺面积
   
    UILabel * totalActualAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalBuckleAreaLabel.frame)+ 6, 120, 21)];
    totalActualAreaLabel.text = @"总实际面积(m²)";
    totalActualAreaLabel.textAlignment = NSTextAlignmentLeft;
    totalActualAreaLabel.font = [UIFont systemFontOfSize:15];
    totalActualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalActualAreaLabel];
    
    UILabel * totalActualDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalBuckleDetailLabel.frame)+ 6, 100, 21)];
    totalActualDetailLabel.text = @"0";
    totalActualDetailLabel.textAlignment = NSTextAlignmentRight;
    totalActualDetailLabel.font = [UIFont systemFontOfSize:15];
    totalActualDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalActualDetailLabel];
    //总实际面积
    totalActualDetailLabel.text = self.totalArea;
    
}

- (void)createTwoDabanView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self addSubview:view];
    
    
    UIView * topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 1)];
    topview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [view addSubview:topview];
    
//    UIView * totalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 36)];
//    totalView.backgroundColor = [UIColor clearColor];
//    [view addSubview:totalView];
//
//
//    UILabel * totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCW, 36)];
//    totalLabel.backgroundColor = [UIColor clearColor];
//    totalLabel.text = @"合计";
//    totalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    totalLabel.font = [UIFont systemFontOfSize:15];
//    totalLabel.textAlignment = NSTextAlignmentCenter;
//    [totalView addSubview:totalLabel];
//
//
//    UIImageView * totalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 + 4 + 12, 14.5, 12, 7)];
//    totalImageView.image = [UIImage imageNamed:@"system-pull-down"];
//    totalImageView.contentMode = UIViewContentModeScaleAspectFill;
//    totalImageView.clipsToBounds = YES;
//    [totalView addSubview:totalImageView];
//
//
//    UIView * bottomView  = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SCW, 1)];
//    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
//    [totalView addSubview:bottomView];
    
    
    //底部视图
    UILabel * totalNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(topview.frame)+ 13, 120, 21)];
    totalNumberLabel.text = @"总原始面积(m²)";
    totalNumberLabel.textAlignment = NSTextAlignmentLeft;
    totalNumberLabel.font = [UIFont systemFontOfSize:15];
    totalNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalNumberLabel];
    
    
    
    UILabel * totalNumberDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(topview.frame)+ 13, 100, 21)];
    totalNumberDetailLabel.text = @"0";
    totalNumberDetailLabel.textAlignment = NSTextAlignmentRight;
    totalNumberDetailLabel.font = [UIFont systemFontOfSize:15];
    totalNumberDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalNumberDetailLabel];
    totalNumberDetailLabel.text = self.totalNumber;
    
    
    UILabel * totalAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalNumberLabel.frame)+ 6, 120, 21)];
    totalAreaLabel.text = @"总扣尺面积(m²)";
    totalAreaLabel.textAlignment = NSTextAlignmentLeft;
    totalAreaLabel.font = [UIFont systemFontOfSize:15];
    totalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalAreaLabel];
    
    UILabel * totalAreaDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalNumberDetailLabel.frame)+ 6, 100, 21)];
    totalAreaDetailLabel.text = @"0";
    totalAreaDetailLabel.textAlignment = NSTextAlignmentRight;
    totalAreaDetailLabel.font = [UIFont systemFontOfSize:15];
    totalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalAreaDetailLabel];
    totalAreaDetailLabel.text = self.totalArea;
    
    UILabel * totalWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalAreaLabel.frame)+ 6, 120, 21)];
    totalWeightLabel.text = @"总实际面积(m²)";
    totalWeightLabel.textAlignment = NSTextAlignmentLeft;
    totalWeightLabel.font = [UIFont systemFontOfSize:15];
    totalWeightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalWeightLabel];
    
    UILabel * totalWeightDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalAreaDetailLabel.frame)+ 6, 100, 21)];
    totalWeightDetailLabel.text = @"0";
    totalWeightDetailLabel.textAlignment = NSTextAlignmentRight;
    totalWeightDetailLabel.font = [UIFont systemFontOfSize:15];
    totalWeightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalWeightDetailLabel];
    totalAreaDetailLabel.text = self.totalWeight;
}




- (void)createView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self addSubview:view];
    
    
    UIView * topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 1)];
    topview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [view addSubview:topview];
    
    
//    UIView * totalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 36)];
//    totalView.backgroundColor = [UIColor clearColor];
//    [view addSubview:totalView];
//
//
//    UILabel * totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCW, 36)];
//    totalLabel.backgroundColor = [UIColor clearColor];
//    totalLabel.text = @"合计";
//    totalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    totalLabel.font = [UIFont systemFontOfSize:15];
//    totalLabel.textAlignment = NSTextAlignmentCenter;
//    [totalView addSubview:totalLabel];
//
//
//    UIImageView * totalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 + 4 + 12, 14.5, 12, 7)];
//    totalImageView.image = [UIImage imageNamed:@"system-pull-down"];
//    totalImageView.contentMode = UIViewContentModeScaleAspectFill;
//    totalImageView.clipsToBounds = YES;
//    [totalView addSubview:totalImageView];
//
//
//    UIView * bottomView  = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SCW, 1)];
//    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
//    [totalView addSubview:bottomView];
    
    
    //底部视图
    UILabel * totalNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(topview.frame)+ 13, 90, 21)];
    totalNumberLabel.text = @"总数量(颗)";
    totalNumberLabel.textAlignment = NSTextAlignmentLeft;
    totalNumberLabel.font = [UIFont systemFontOfSize:15];
    totalNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalNumberLabel];
    
    UILabel * totalNumberDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(topview.frame)+ 13, 100, 21)];
    totalNumberDetailLabel.text = @"0";
    totalNumberDetailLabel.textAlignment = NSTextAlignmentRight;
    totalNumberDetailLabel.font = [UIFont systemFontOfSize:15];
    totalNumberDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalNumberDetailLabel];
    totalNumberDetailLabel.text = self.totalNumber;
    
    
    UILabel * totalAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalNumberLabel.frame)+ 6, 90, 21)];
    totalAreaLabel.text = @"总体积(m³)";
    totalAreaLabel.textAlignment = NSTextAlignmentLeft;
    totalAreaLabel.font = [UIFont systemFontOfSize:15];
    totalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalAreaLabel];
    
    UILabel * totalAreaDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalNumberDetailLabel.frame)+ 6, 100, 21)];
    totalAreaDetailLabel.text = @"0";
    totalAreaDetailLabel.textAlignment = NSTextAlignmentRight;
    totalAreaDetailLabel.font = [UIFont systemFontOfSize:15];
    totalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalAreaDetailLabel];
    totalAreaDetailLabel.text = self.totalArea;
    
    
    UILabel * totalWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake( 12, CGRectGetMaxY(totalAreaLabel.frame)+ 6, 90, 21)];
    totalWeightLabel.text = @"总重量(吨)";
    totalWeightLabel.textAlignment = NSTextAlignmentLeft;
    totalWeightLabel.font = [UIFont systemFontOfSize:15];
    totalWeightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalWeightLabel];
    
    UILabel * totalWeightDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 12 - 100, CGRectGetMaxY(totalAreaDetailLabel.frame)+ 6, 100, 21)];
    totalWeightDetailLabel.text = @"0";
    totalWeightDetailLabel.textAlignment = NSTextAlignmentRight;
    totalWeightDetailLabel.font = [UIFont systemFontOfSize:15];
    totalWeightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [view addSubview:totalWeightDetailLabel];
    totalWeightDetailLabel.text = self.totalWeight;
    
}




- (void)showView
{
    if (self.bgView) {
        return;
    }
    /**
     else if ([self.selectType isEqualToString:@"dabanruku"]){
     [self createTwoDabanView];
     }
     */
    
    if ([self.selectType isEqualToString:@"huangliaoruku"] || [self.selectType isEqualToString:@"huangliaochuku"]) {
        [self createView];
    }else if ([self.selectType isEqualToString:@"dabanchuku"] || [self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"kucunguanli1"]){
        [self cleateDabanView];
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        if ([self.selectFunctionType isEqualToString:@"调拨"]) {
              [self createView];
        }
    }
//    else if ([self.selectType isEqualToString:@"kucunguanli1"]){
//        if ([self.selectFunctionType isEqualToString:@"调拨"]) {
//             [self createTwoDabanView];
//        }
//    }

    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [self.bgView addGestureRecognizer:tap];
//    self.bgView.userInteractionEnabled = YES;
//    self.bgView.backgroundColor = [UIColor blackColor];
//    self.bgView.alpha = 0.4;
//    [window addSubview:self.bgView];
    [window addSubview:self];
    
}
-(void)tap:(UIGestureRecognizer *)tap
{
  //  [self.bgView removeFromSuperview];
  //  self.bgView = nil;
    [self removeFromSuperview];
}


- (void)cancelAction:(UIButton *)cancelBtn{
    [self closeView];
}

- (void)closeView
{
   // [self.bgView removeFromSuperview];
    //self.bgView = nil;
    [self removeFromSuperview];
}
-(void)resetAction:(UIButton *)sender
{
    [self closeView];
}



@end
