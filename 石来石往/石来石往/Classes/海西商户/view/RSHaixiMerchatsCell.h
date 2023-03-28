//
//  RSHaixiMerchatsCell.h
//  石来石往
//
//  Created by mac on 2021/10/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RSHaixiMerchatsCell : UICollectionViewCell


@property (nonatomic,strong)UIView * showView;
@property (nonatomic,strong)UIImageView * haixiMerchatImage;

@property (nonatomic,strong)UILabel * namelabel;

@property (nonatomic,strong)UILabel * numLabel;

@property (nonatomic,strong)UILabel * companyLabel;


@property (nonatomic,copy)NSString * numStr;
@end

NS_ASSUME_NONNULL_END
