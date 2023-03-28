//
//  RSSLFractureTreatmentView.h
//  石来石往
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDabanContentView.h"
#import "RSDabanContentFootView.h"

#import "RSSLStoragemanagementModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSSLFractureTreatmentViewDelegate <NSObject>

- (void)sendSection:(NSInteger)section andIndex:(NSInteger)index;

- (void)deleteSection:(NSInteger)section andIndex:(NSInteger)index;
@end


@interface RSSLFractureTreatmentView : UIView

@property (nonatomic,strong)RSDabanContentView * dabanContentView;

//@property (nonatomic,strong)RSDabanContentFootView * dabanContentFootView;

@property (nonatomic,strong)UIButton * productDeleteBtn;

@property (nonatomic,strong)UIButton * downBtn;

@property (nonatomic,strong)NSArray * contentArray;

@property (nonatomic,strong)NSString * editStr;

@property (nonatomic,weak)id<RSSLFractureTreatmentViewDelegate>delegate;

@property (nonatomic,strong)UILabel * chuliLabel;


@property (nonatomic,strong)UILabel * productNameLabel;

@property (nonatomic,strong)UILabel * productNumberLabel;
@property (nonatomic,strong)UILabel * productTurnLabel;

@end

NS_ASSUME_NONNULL_END
