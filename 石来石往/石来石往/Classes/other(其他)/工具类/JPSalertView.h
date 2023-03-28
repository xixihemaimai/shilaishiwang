//
//  JPSalertView.h
//  PopViewOne
//
//  Created by 姜朋升 on 2017/5/22.
//  Copyright © 2017年 闪牛网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JPSalertViewdelegate <NSObject>

//-(void)requestEventAction:(UIButton *)button;

//新增
- (void)contactsInformationSelectype:(NSString *)selectype andContactsAddress:(NSString *)contactsAddress andContactsName:(NSString *)contactsName andContactsPhone:(NSString *)contactsPhone andIndex:(NSInteger)index andType:(NSString *)type andIs_default:(NSInteger)is_default;


//编辑
- (void)editContactsActAndAddressContactsType:(NSString *)selectype andType:(NSString *)type andContactsAddress:(NSString *)contactsAddress andContactsName:(NSString *)contactsName andContactsPhone:(NSString *)contactsPhone andIs_default:(NSInteger)is_default andContactsId:(NSString *)contactsId;
@end

@interface JPSalertView : UIView



/**1就是新增，2就是编辑 3就是删除*/
@property (nonatomic,strong)NSString * funtionType;

/**点击编辑还是删除的位置*/
@property (nonatomic,assign)NSInteger index;

/**名称还是地址的输入框*/
@property(nonatomic,strong)UITextView *firstField;
/**联系人电话的输入框，地址不显示*/
@property(nonatomic,strong)UITextView *secondField;

//标题
@property (nonatomic,strong)UILabel *label;
/**名称还是地址的标题*/
@property (nonatomic,strong)UILabel * nameLabel;
/**联系人电话的标题，地址不显示*/
@property (nonatomic,strong)UILabel * numberLabel;


@property(nonatomic,weak)id <JPSalertViewdelegate> delegate;

@property (nonatomic,strong)NSString * selectype;


/**是否是默认值*/
@property (nonatomic,assign)NSInteger IS_DEFAULT;


@property (nonatomic,strong) UIButton * settingBtn;

@property (nonatomic,strong)NSString * contactsId;

-(void)showView;
-(void)closeView;

@end
