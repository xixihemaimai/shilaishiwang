//
//  RSCustomView.m
//  shiping
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCustomView.h"
#import "SDAutoLayout.h"
@interface RSCustomView()

/**设置view*/
@property (nonatomic,strong)UIView * settingView;







@end
@implementation RSCustomView
- (UIView *)settingView{
    if (_settingView == nil) {
        _settingView = [[UIView alloc]init];
                       // WithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];
        _settingView.backgroundColor = [UIColor clearColor];
    }
    return _settingView;
}

//- (UIButton *)shaBtn{
//    if (_shaBtn == nil) {
//        _shaBtn = [[UIButton alloc]init];
//                   //WithFrame:CGRectMake(12, 30, 30, 30)];
//        [_shaBtn setImage:[UIImage imageNamed:@"闪光灯-关闭"] forState:(UIControlState)UIControlStateNormal];
//        [_shaBtn addTarget:self action:@selector(changeShareAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _shaBtn;
//}

- (UIButton *)qieBtn{
    if (!_qieBtn) {
        _qieBtn = [[UIButton alloc]init];
                   //WithFrame:CGRectMake(self.bounds.size.width - 52, 30, 30, 30)];
        //[_qieBtn setBackgroundColor:[UIColor redColor]];
        [_qieBtn setImage:[UIImage imageNamed:@"switchover"] forState:UIControlStateNormal];
      //  [_qieBtn setBackgroundImage:[UIImage imageNamed:@"切换摄像头"] forState:UIControlStateNormal];
        [_qieBtn addTarget:self action:@selector(changQieSheXiangAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qieBtn;
}



//- (UIButton *)douDongBtn{
//    if (_douDongBtn) {
//        _douDongBtn = [[UIButton alloc]init];
//        [_douDongBtn setImage:[UIImage imageNamed:@"抖动"] forState:UIControlStateNormal];
//        [_douDongBtn addTarget:self action:@selector(douDongAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _douDongBtn;
//
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.settingView];
        //[self.settingView addSubview:self.shaBtn];
        [self.settingView addSubview:self.qieBtn];
        self.settingView.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
//        self.shaBtn.sd_layout
//        .leftSpaceToView(self.settingView, 12)
//        .topSpaceToView(self.settingView, 30)
//        .widthIs(30)
//        .heightIs(30);
        
//        self.douDongBtn.sd_layout
//        .leftSpaceToView(self.shaBtn, 10)
//        .topEqualToView(self.shaBtn)
//        .bottomEqualToView(self.shaBtn)
//        .widthIs(30);
        
        self.qieBtn.sd_layout
        .rightSpaceToView(self.settingView, 0)
        .topSpaceToView(self.settingView, 0)
        .leftSpaceToView(self.settingView, 0)
        .bottomSpaceToView(self.settingView, 0);
        
    }
    return self;
}

////闪关灯
//- (void)changeShareAction:(UIButton *)shaBtn{
//    shaBtn.selected = !shaBtn.selected;
//    if ([self.delegate respondsToSelector:@selector(changeLightStatus:andShaBtn:)]) {
//        [self.delegate changeLightStatus:shaBtn.selected andShaBtn:shaBtn];
//    }
//}

//摄像头
- (void)changQieSheXiangAction:(UIButton *)qieBtn{
    
    qieBtn.selected = !qieBtn.selected;
    if ([self.delegate respondsToSelector:@selector(changeQieSheXiangeStatus:andQieBtn:)]) {
        [self.delegate changeQieSheXiangeStatus:qieBtn.selected andQieBtn:qieBtn];
    }
}

////抖动
//- (void)douDongAction:(UIButton *)btn{
//    btn.selected = !btn.selected;
//
//
//}
@end
