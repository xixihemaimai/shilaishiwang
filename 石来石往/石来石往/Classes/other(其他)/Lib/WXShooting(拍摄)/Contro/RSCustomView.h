//
//  RSCustomView.h
//  shiping
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RSCustomViewDelegate <NSObject>


//闪关灯
- (void)changeLightStatus:(BOOL)isSelect andShaBtn:(UIButton *)shaBtn;
//摄像头
- (void)changeQieSheXiangeStatus:(BOOL)isSelect andQieBtn:(UIButton *)qieBtn;

//抖动
- (void)changDouDongStatus:(BOOL)isSelect andDouDong:(UIButton *)douDong;

@end

@interface RSCustomView : UIView

/**闪关灯*/
//@property (nonatomic,strong)UIButton * shaBtn;

/**切换摄像头*/
@property (nonatomic,strong)UIButton * qieBtn;

/**防抖动*/
//@property (nonatomic,strong)UIButton * douDongBtn;

@property (nonatomic,weak)id<RSCustomViewDelegate>delegate;

@end
