//
//  RSTaobaoSCShopCell.h
//  石来石往
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTaoBaoShopInformationModel.h"


typedef void(^LYFTableViewCellScrollAction)(void);
typedef void(^LYFTableViewCellDeleteAction)(NSIndexPath *indexPath);
NS_ASSUME_NONNULL_BEGIN

@interface RSTaobaoSCShopCell : UITableViewCell
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

@property (nonatomic,strong)UIButton * joinBtn;


@property (nonatomic,strong)RSTaoBaoShopInformationModel * taobaoShopInformationmodel;

@property (nonatomic,strong)UIButton * joinShopBtn;


@end

NS_ASSUME_NONNULL_END
