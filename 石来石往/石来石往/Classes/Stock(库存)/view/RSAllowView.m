//
//  RSAllowView.m
//  石来石往
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAllowView.h"
@interface RSAllowView ()
//<UITextViewDelegate>

@property (nonatomic,assign)CGFloat height;

@end

@implementation RSAllowView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        UIView *menView = [[UIView alloc]initWithFrame:self.bounds];
        menView.backgroundColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:0.5];
        [self addSubview:menView];
        
        //最外层视图
        UIView * allowArgeeView = [[UIView alloc]initWithFrame:CGRectMake(12, (SCH/2)/2 , CGRectGetWidth(menView.frame) - 24, 200)];
        allowArgeeView.backgroundColor = [UIColor whiteColor];
        //allowArgeeView.userInteractionEnabled = YES;
        [menView addSubview:allowArgeeView];
//        allowArgeeView.layer.cornerRadius = 10;
//        allowArgeeView.layer.masksToBounds = YES;
    
        
        //标题
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(allowArgeeView.frame), 50)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.text = @"市场服务满意度评价";
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [allowArgeeView addSubview:titleLabel];
        
        //标题和下面对的分界线
//        UIView * midview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(allowArgeeView.frame), 1)];
//        midview.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
//        [allowArgeeView addSubview:midview];
        
        
        //责任方 (甲)
//        UILabel * nailLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(midview.frame), CGRectGetWidth(allowArgeeView.frame) - 24, 30)];
//        nailLabel.text = @"甲方:福建海西石材交易中心有限公司";
//        nailLabel.textColor = [UIColor colorWithRed:112/255.0 green:162/255.0 blue:255/255.0 alpha:1.0];
//        nailLabel.backgroundColor = [UIColor whiteColor];
//        nailLabel.textAlignment = NSTextAlignmentLeft;
        
//        if (iPhone5 || iPhone4) {
//             nailLabel.font = [UIFont systemFontOfSize:16];
//        }else{
//        nailLabel.font = [UIFont systemFontOfSize:17];
//        }
//        [allowArgeeView addSubview:nailLabel];
        
        
        //责任方（乙）
//        UILabel * bLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(nailLabel.frame), CGRectGetWidth(allowArgeeView.frame) -24, 30)];
//        bLabel.textColor = [UIColor colorWithRed:112/255.0 green:162/255.0 blue:255/255.0 alpha:1.0];
//        bLabel.textAlignment = NSTextAlignmentLeft;
//        _bLabel = bLabel;
//        bLabel.font = [UIFont systemFontOfSize:17];
//        [allowArgeeView addSubview:bLabel];
//        bLabel.backgroundColor = [UIColor whiteColor];
        

        UITextView * text = [[UITextView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(titleLabel.frame) + 1, CGRectGetWidth(allowArgeeView.frame) - 24, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(titleLabel.frame) - 10 - 40)];
        text.text = @"尊敬的海西货主:\n       您好！很高兴为您服务，请您对我们的服务进行评价！\n ";
        text.showsVerticalScrollIndicator = NO;
        text.showsHorizontalScrollIndicator = NO;
        text.textColor = [UIColor colorWithHexColorStr:@"#4D4D4D"];
        text.editable = NO;
        text.font = [UIFont systemFontOfSize:16];
        [allowArgeeView addSubview:text];
//        text.delegate = self;
        
//        self.height = [self getHeightByTextView:text withContent:text.text withFontSize:17 withTextColor:[UIColor colorWithHexColorStr:@"#4D4D4D"]];
        
        

        UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(text.frame), CGRectGetWidth(allowArgeeView.frame), 2)];
        bottomview.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [allowArgeeView addSubview:bottomview];
        
        UIButton * noagreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomview.frame), allowArgeeView.frame.size.width/2 - 1, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(bottomview.frame))];
        [noagreeBtn setTitle:@"不满意" forState:UIControlStateNormal];
        [noagreeBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
        [noagreeBtn setBackgroundColor:[UIColor whiteColor]];
        [allowArgeeView addSubview:noagreeBtn];
        _noagreeBtn = noagreeBtn;
        UIView * btnMidView = [[UIView alloc]initWithFrame:CGRectMake(allowArgeeView.frame.size.width/2 - 1, CGRectGetMaxY(bottomview.frame), 2, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(bottomview.frame))];
        btnMidView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [allowArgeeView addSubview:btnMidView];
        
        
        
        UIButton * agreenBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnMidView.frame), CGRectGetMaxY(bottomview.frame), allowArgeeView.frame.size.width/2 - 1, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(bottomview.frame))];
        [agreenBtn setTitle:@"满意" forState:UIControlStateNormal];
        [agreenBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
        [agreenBtn setBackgroundColor:[UIColor whiteColor]];
        [allowArgeeView addSubview:agreenBtn];
        _agreenBtn = agreenBtn;
    }
    return self;
}

//计算UITextView的滑动高度
//- (CGFloat)getHeightByTextView:(UITextView *)myTextView withContent:(NSString *)content withFontSize:(CGFloat)size withTextColor:(UIColor *)color
//{
//     CGFloat newSizeH = 0.;
//     //UITextView的实际高度
//    if (@available(iOS 7.0,*)) {
//        //7.0以后需要自己计算高度
//        float fPadding = 48; //8.0px x 2
//        CGSize constraint = CGSizeMake(myTextView.contentSize.width - fPadding, CGFLOAT_MAX);
//        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica Neue" size:size],NSFontAttributeName,color,NSForegroundColorAttributeName, nil];
//        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//        CGRect rect = [myTextView.text boundingRectWithSize:constraint options:options  attributes:attrsDictionary context:nil];
//        newSizeH = rect.size.height;
//    }else{
//        newSizeH = myTextView.contentSize.height + 10;
//    }
//    return newSizeH;
//}




//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat postion = 300;
//    if (iPhone6){
//        postion = 300;
//    }else if (iPhone6p || iphonex || iPhoneXS) {
//        postion = 450;
//    }
//    else{
//        postion = 600;
//    }
//    if (scrollView.contentOffset.y > self.height - postion) {
//        _noagreeBtn.enabled = YES;
//        _agreenBtn.enabled = YES;
//        [_agreenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    }else{
//        _noagreeBtn.enabled = YES;
//        _agreenBtn.enabled = NO;
//        [_agreenBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
//    }
//}








@end
