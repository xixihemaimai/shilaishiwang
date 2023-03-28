//
//  RSTwoPasswordView.h
//  石来石往
//
//  Created by mac on 17/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTwoPasswordView : UIView<UITextFieldDelegate>
/**确定密码是不是正确的*/
@property (nonatomic,strong)UIButton *sureBtn;
/**要修改的内容*/
@property (nonatomic,strong)UITextField *twoPasswordfield;


/**要修改的内容*/
@property (nonatomic,strong)UILabel * label;
@end
