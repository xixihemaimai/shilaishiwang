//
//  RSTaoBaoActivityCell.h
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTaobaoSCButton.h"
#import "RSTaoBaoUserLikeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoActivityCell : UITableViewCell
//界面本身
@property (nonatomic,strong)UIButton * rowNowRobBtn;


@property (nonatomic,strong)RSTaobaoSCButton * taoBaoSCBtn;

@property (nonatomic,strong)UIButton * showDisBtn;


@property (nonatomic,strong)RSTaoBaoUserLikeModel * taobaoUserlikemodel;
@end

NS_ASSUME_NONNULL_END
