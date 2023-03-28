//
//  RSSLDabanPurchaseThirdHeaderView.h
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLStoragemanagementModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLDabanPurchaseThirdHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong)RSSLStoragemanagementModel * slstoragemanagementmodel;

@property (nonatomic,strong)UIButton * downBtn;


@property (nonatomic,strong)UIButton * productEidtBtn;

@property (nonatomic,strong)UIButton * productDeleteBtn;

@property (nonatomic,strong) UILabel * productModiftyLabel;

@property (nonatomic,strong)UIImageView * downImageView;

@property (nonatomic,strong)UILabel * productNameLabel;

@property (nonatomic,strong)UILabel * productNumberLabel;

@property (nonatomic,strong)UILabel * productTurnLabel;
@end

NS_ASSUME_NONNULL_END
