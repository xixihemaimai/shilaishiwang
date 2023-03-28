//
//  RSSCCompanyHeaderView.h
//  石来石往
//
//  Created by mac on 2021/10/30.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSCCompanyHeaderModel.h"
#import "RSSCCompanyHeaderStoreModel.h"
#import "RSSCCompanyHeaderContactModel.h"
#import "RSBusinessLicenseListModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RSSCCompanyHeaderViewDelegate <NSObject>

- (void)moreCheckBtnSelectStatus:(BOOL)isStatus andHeight:(CGFloat)height isCollection:(NSInteger)collectionState;

- (void)jumpCompanyAddressActionDestination:(NSString *)destination andLat:(NSString *)lat andLon:(NSString *)lon;

- (void)showStoreContentWithArray:(NSMutableArray *)array andType:(NSString *)type;


- (void)showPitrueArray:(NSMutableArray *)pictrueArray andTag:(NSInteger)tag;


@end

@interface RSSCCompanyHeaderView : UIView
//设置一个高度值
@property (nonatomic,assign)CGFloat height;
//门店
@property (nonatomic,strong)UIButton * storeBtn;


@property (nonatomic,strong)MLLinkLabel * linkLabel;

@property (nonatomic,strong)UIButton * moreBtn;

-(instancetype)initWithFrame:(CGRect)frame withHeight:(CGFloat)height andEnterpriseId:(NSInteger)enterpriseId;

@property (nonatomic,weak)id<RSSCCompanyHeaderViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
