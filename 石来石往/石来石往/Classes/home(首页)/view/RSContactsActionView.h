//
//  RSContactsActionView.h
//  石来石往
//
//  Created by mac on 2019/1/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSContactsActionViewDelegate;
@interface RSContactsActionView : UIView

@property (nonatomic,strong)NSArray * contactsArray;

/**1是联系人 2是地址 3是新版的门店*/
@property (nonatomic,strong)NSString * selectype;


@property (nonatomic,weak)id<RSContactsActionViewDelegate> delegate;

/**是否显示编辑按键*/
@property (nonatomic,assign)BOOL isCurrent;

@property (nonatomic,strong)RSUserModel * usermodel;

@end


@protocol RSContactsActionViewDelegate <NSObject>

@optional
- (void)hideCurrentShowView:(RSContactsActionView *)contactsActionView;



- (void)selectChangeContactsFuntionSelectype:(NSString *)selectype andRSContactsActionView:(RSContactsActionView *)contactsActionView;



- (void)selectChangeContactsFuntionIndex:(NSInteger)index andContactsArrayStr:(NSString *)str andRSContactsActionView:(RSContactsActionView *)contactsActionView;

@end

NS_ASSUME_NONNULL_END
