//
//  RSRevokeCell.h
//  石来石往
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRevokeCell : UITableViewCell

@property (nonatomic,strong)UIView * upView;

@property (nonatomic,strong)UIView * midView;

@property (nonatomic,strong)UIView * lowView;

@property (nonatomic,strong)UILabel * titleLabel;

@property (nonatomic,strong)UILabel * contactLabel;

@property (nonatomic,strong)UILabel * timeLabel;

@property (nonatomic,strong)UIView * bottomview;


@end

NS_ASSUME_NONNULL_END
