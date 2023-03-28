//
//  ShootingToolBar.m
//  WeChart
//
//  Created by lk06 on 2018/4/25.
//  Copyright © 2018年 lk06. All rights reserved.
//

#import "ShootingToolBar.h"
#import "ShootingButton.h"

@interface ShootingToolBar()<shootingButtonDelegate>
@property (nonatomic , strong) ShootingButton * shootingButton;
@property (nonatomic , strong) UIButton * colseButton;
@property (nonatomic , strong) UIButton * leftButton;
@property (nonatomic , strong) UIButton * rightButton;
@property (nonatomic , strong) UIButton * editorButton;

/**添加文字*/
//@property (nonatomic , strong) UIButton * textBtn;

/**添加表情*/
//@property (nonatomic , strong) UIButton * expressionBtn;
/**编辑视频*/
@property (nonatomic , strong) UIButton * editBtn;
/**添加水印*/
@property (nonatomic , strong) UIButton * watermarkBtn;

@end
@implementation ShootingToolBar

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setingSubViews];
    }
    return self;
}

/**
 设置子控件
 */
-(void)setingSubViews
{
    
    //,self.editorButton
    [self sd_addSubviews:@[self.shootingButton,self.colseButton,self.leftButton,self.rightButton,self.editorButton,self.editBtn,self.watermarkBtn]];
    self.shootingButton.sd_layout
    .widthIs(85)
    .centerYEqualToView(self)
    .centerXEqualToView(self)
    .heightIs(85);
    
    self.colseButton.sd_layout
    .widthIs(40)
    .centerYEqualToView(self)
    .rightSpaceToView(self.shootingButton, 30)
    .heightIs(40);
    
    
    
    if (iPhone4 || iPhone5) {
        
        self.leftButton.sd_layout
        .widthIs(70)
        .heightIs(70)
        .leftSpaceToView(self, 90)
        .centerYEqualToView(self);
        
        
        self.rightButton.sd_layout
        .widthIs(70)
        .heightIs(70)
        .rightSpaceToView(self, 90)
        .centerYEqualToView(self);
        
    }else{
        
        self.leftButton.sd_layout
        .widthIs(70)
        .heightIs(70)
        .leftSpaceToView(self, 70)
        .centerYEqualToView(self);
        
        
        self.rightButton.sd_layout
        .widthIs(70)
        .heightIs(70)
        .rightSpaceToView(self, 70)
        .centerYEqualToView(self);

    }

    self.editorButton.sd_layout
    .widthIs(70)
    .heightIs(70)
    .centerYEqualToView(self)
    .centerXEqualToView(self);
    

    self.watermarkBtn.sd_layout
    .leftSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .heightIs(45)
    .widthRatioToView(self, 0.5);

    
    self.editBtn.sd_layout
    .leftSpaceToView(self.watermarkBtn, 0)
    .heightIs(45)
    .bottomSpaceToView(self, 0)
    .rightSpaceToView(self, 0);
}

/**
 小中心录制，拍照按钮

 @return ShootingButton
 */
-(ShootingButton*)shootingButton
{
    if (!_shootingButton) {
        _shootingButton =[ShootingButton getShootingButton];
        _shootingButton.shootingButtonrDelegate=self;
    }
    return _shootingButton;
}
/**
 关闭按钮

 @return UIButton
 */
-(UIButton*)colseButton
{
    if (!_colseButton) {
        _colseButton = [[UIButton alloc]init];
        [_colseButton setImage:[UIImage imageNamed:@"icon_cancel"] forState:normal];
        _colseButton.tag = 3;
        [_colseButton addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colseButton;
}

/**
 左侧按钮
 
 @return UIButton
 */
-(UIButton*)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]init];
        _leftButton.hidden = YES;
        _leftButton.tag = 1;
        _leftButton.backgroundColor = [UIColor greenColor];
        [_leftButton setImage:[UIImage imageNamed:@"btn_return"] forState:normal];
        _leftButton.layer.cornerRadius=35;
        _leftButton.layer.masksToBounds = YES;
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

/**
 右侧按钮
 
 @return UIButton
 */
-(UIButton*)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]init];
        _rightButton.hidden = YES;
        _rightButton.layer.cornerRadius=35;
        _rightButton.tag = 4;
        _rightButton.layer.masksToBounds = YES;
        [_rightButton setImage:[UIImage imageNamed:@"btn_sure"] forState:normal];
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
/**
 编辑按钮
 
 @return UIButton
 */
-(UIButton*)editorButton
{
    if (!_editorButton) {
        _editorButton = [[UIButton alloc]init];
        _editorButton.hidden = YES;
        [_editorButton setBackgroundColor:[UIColor lightTextColor]];
        _editorButton.layer.cornerRadius=35;
        _editorButton.tag = 2;
        _editorButton.layer.masksToBounds = YES;
        [_editorButton setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [_editorButton addTarget:self action:@selector(editorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editorButton;
}


//添加文字
//- (UIButton *)textBtn{
//
//    if (!_textBtn) {
//        _textBtn = [[UIButton alloc]init];
//        _textBtn.hidden = YES;
//        [_textBtn setBackgroundColor:[UIColor lightTextColor]];
//        _textBtn.tag = 5;
//        //[_textBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
//        [_textBtn setBackgroundColor:[UIColor clearColor]];
//        [_textBtn setTitle:@"添加文字" forState:UIControlStateNormal];
//        [_textBtn addTarget:self action:@selector(textButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    }
//    return _textBtn;
//}


//添加水印
- (UIButton *)watermarkBtn{
    if (!_watermarkBtn) {
        _watermarkBtn = [[UIButton alloc]init];
        _watermarkBtn.hidden = YES;
        [_watermarkBtn setBackgroundColor:[UIColor lightTextColor]];
        _watermarkBtn.tag = 7;
        //[_textBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [_watermarkBtn setBackgroundColor:[UIColor clearColor]];
        [_watermarkBtn setTitle:@"添加其他功能" forState:UIControlStateNormal];
        [_watermarkBtn addTarget:self action:@selector(watermarkBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _watermarkBtn;
}



//添加表情
//- (UIButton *)expressionBtn{
//    if (!_expressionBtn) {
//        _expressionBtn = [[UIButton alloc]init];
//        _expressionBtn.hidden = YES;
//        [_expressionBtn setBackgroundColor:[UIColor lightTextColor]];
//        _expressionBtn.tag = 6;
//        //[_textBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
//        [_expressionBtn setBackgroundColor:[UIColor clearColor]];
//        [_expressionBtn setTitle:@"添加表情" forState:UIControlStateNormal];
//        [_expressionBtn addTarget:self action:@selector(expressionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    }
//    return _expressionBtn;
//}


- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc]init];
        _editBtn.hidden = YES;
        [_editBtn setBackgroundColor:[UIColor lightTextColor]];
        _editBtn.tag = 7;
        //[_textBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [_editBtn setBackgroundColor:[UIColor clearColor]];
        [_editBtn setTitle:@"添加编辑" forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _editBtn;
    
    
}


//添加其他功能
- (void)watermarkBtnButtonClick:(UIButton *)watermarkBtn{
    
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(videoOtherFunction)]) {
        
        [self.shootingToolBarDelegate videoOtherFunction];
    }
    
}

//添加文字按钮
//- (void)textButtonClick:(UIButton *)textBtn{
//}

//添加表情
//- (void)expressionButtonClick:(UIButton *)expressionBtn{
//}

//添加编辑
- (void)editButtonClick:(UIButton *)editBtn{
   // NSLog(@"编辑视频");
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(videoUrlPath)]) {
        [self.shootingToolBarDelegate videoUrlPath];
    }
}




#pragma actionClick 事件逻辑
//关闭按钮
-(void)closeClick:(UIButton*)button
{
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(shootingToolBarAction:buttonIndex:)]) {
        
        [self.shootingToolBarDelegate shootingToolBarAction:self buttonIndex:button.tag];
    }
}
//左侧取消按钮
-(void)leftButtonClick:(UIButton*)button
{
     [self buttonAnimation:NO];
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(shootingToolBarAction:buttonIndex:)]) {
        
        
        
        [self.shootingToolBarDelegate shootingToolBarAction:self buttonIndex:button.tag];
    }
}
//右侧确定按钮
-(void)rightButtonClick:(UIButton*)button
{
    
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(shootingToolBarAction:buttonIndex:)]) {
        
        [self.shootingToolBarDelegate shootingToolBarAction:self buttonIndex:button.tag];
    }
}
//编辑按钮
-(void)editorButtonClick:(UIButton*)button
{
    [self showExpression:YES];
    [self buttonAnimation:NO];
    self.shootingButton.hidden = YES;
    self.colseButton.hidden = YES;
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(shootingToolBarAction:buttonIndex:)]) {
        [self.shootingToolBarDelegate shootingToolBarAction:self buttonIndex:button.tag];
    }
}


/**
 显示自己添加的动画效果
 */

- (void)showExpression:(BOOL)open{
    _editBtn.hidden = !open;
    //_expressionBtn.hidden = !open;
    //_textBtn.hidden = !open;
    _watermarkBtn.hidden = !open;
}


/**
 左侧和右侧按钮的动画效果

 @param open 打开还是关闭
 */
-(void)buttonAnimation:(BOOL)open
{
    _colseButton.hidden = open;
    _shootingButton.hidden =open;
    _editorButton.hidden = !open;
    _leftButton.hidden = !open;
    _rightButton.hidden = !open;
    //_textBtn.hidden = !open;
    //_expressionBtn.hidden = !open;
    //_editBtn.hidden = !open;
    if (open) {
        [UIView animateWithDuration:0.4 animations:^{
            _leftButton.transform = CGAffineTransformTranslate(_leftButton.transform, -70, 0);
            _rightButton.transform = CGAffineTransformTranslate(_rightButton.transform, 70, 0);
        }];
        return;
    }
    //隐藏
    _leftButton.transform = CGAffineTransformIdentity;
    _rightButton.transform = CGAffineTransformIdentity;
    
}


#pragma mark 中心按钮的代理方法

/**
 停止录制

 @param button ShootingButton 对象
 @param type 拍照，还是录制
 */
-(void)shootingStop:(ShootingButton *)button shootingType:(shootingType)type
{
    [self buttonAnimation:YES];
     button.hidden = YES;
    //回调自己的代理
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(shootingStop:shootingType:)]) {
        [self.shootingToolBarDelegate shootingStop:self shootingType:type];
    }
 
}

/**
 开始录制

 @param button 对象
 @param type 拍照，录制类型
 @param value 录制有进度值
 */
-(void)shootingStarting:(ShootingButton *)button shootingType:(shootingType)type progress:(CGFloat)value
{
    //回调自己的代理
    if ([self.shootingToolBarDelegate respondsToSelector:@selector(shooingStart:actionType:progress:)]) {
        
        [self.shootingToolBarDelegate shooingStart:self actionType:type progress:value];
    }
}

/**录制时间到了的代理*/
- (void)recordStop{
    [self buttonAnimation:YES];
}


@end
