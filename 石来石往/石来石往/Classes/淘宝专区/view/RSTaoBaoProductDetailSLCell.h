//
//  RSTaoBaoProductDetailSLCell.h
//  石来石往
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAllMessageUIButton.h"


NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoProductDetailSLCell : UITableViewCell
@property (nonatomic,strong)RSAllMessageUIButton * checkBtn;

@property (nonatomic,strong)UILabel * blockNoLabel;

@property (nonatomic,strong)UILabel * typeDetailLabel;

@property (nonatomic,strong)UILabel * numberDetailLabel;

@property (nonatomic,strong)UILabel * areaDetailLabel;

@property (nonatomic,strong)UILabel * addressDetailLabel;

@end

NS_ASSUME_NONNULL_END
