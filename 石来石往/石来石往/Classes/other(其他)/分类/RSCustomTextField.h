//
//  RSCustomTextField.h
//  石来石往
//
//  Created by mac on 2018/3/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RSCustomTextFieldDelegate <NSObject>

- (void)textViewShowAndHidden:(UITextField *)textField;

- (void)textViewShowDeletel:(UITextField *)textField;
@end


@interface RSCustomTextField : UITextField<UITextFieldDelegate>


/**
 *  自定义初始化方法
 *
 *  @param frame       frame
 *  @param placeholder 提示语
 *  @param clear       是否显示清空按钮 YES为显示
 *  @param view        是否设置leftView不设置传nil
 *  @param font        设置字号
 *
 */
-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clear:(BOOL)clear leftView:(id)view fontSize:(CGFloat)font;

@property (nonatomic,weak)id<RSCustomTextFieldDelegate> Customdelegate;

@end
