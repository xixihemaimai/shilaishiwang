//
//  RSTaoBaoSCContentCell.h
//  石来石往
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTaobaoSCButton.h"
#import "RSTaoBaoUserLikeModel.h"


typedef void(^LYFTableViewCellScrollAction)(void);
typedef void(^LYFTableViewCellDeleteAction)(NSIndexPath *indexPath);
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoSCContentCell : UITableViewCell

/// 删除事件
@property (nonatomic, copy) LYFTableViewCellDeleteAction deleteAction;
/// 滑动事件
@property (nonatomic, copy) LYFTableViewCellScrollAction scrollAction;
/// 滑动视图
@property (nonatomic, strong) UIScrollView *mainScrollView;
/// 组数行数
@property (nonatomic, strong) NSIndexPath *indexPath;
/// 打开状态
@property (nonatomic, assign) BOOL isOpen;

/// 标题的背景
@property (nonatomic, strong) UIView *backView;


@property (nonatomic,strong)UIButton * joinBtn;



//界面本身
@property (nonatomic,strong)UIButton * rowNowRobBtn;

@property (nonatomic,strong)RSTaobaoSCButton * taoBaoSCBtn;

@property (nonatomic,strong)RSTaoBaoUserLikeModel * taobaoUserlikemodel;


@end

NS_ASSUME_NONNULL_END
