//
//  RSSearchContentView.h
//  石来石往
//
//  Created by mac on 2021/10/26.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSearchContentViewDelegate <NSObject>

@optional
//打开二维码扫描
- (void)openScanQRCode;
//开始编辑的时候需要跳转到新的界面
- (void)jumpNewController;
//获取搜索框内容
- (void)searchTextViewWithContentStr:(NSString *)searchStr;
//这边是电话簿，信息，发布
- (void)implementActionWithTag:(NSInteger)tag andActionName:(NSString *)actionName andButton:(UIButton *)btn;

//实时搜索
- (void)rowNowSearchTextFieldStr:(NSString *)searchStr;

@end


@interface RSSearchContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andShowQRCode:(BOOL)qrCode andShopBusiness:(BOOL)isBusiness andIsEdit:(BOOL)isEdit;

@property (nonatomic,weak)UITextField * searchTextView;

@property (nonatomic,weak)id<RSSearchContentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
