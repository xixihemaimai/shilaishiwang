//
//  RSDabanPurchaseCell.h
//  石来石往
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLStoragemanagementModel.h"

typedef void(^LYFTableViewCellScrollAction)(void);
typedef void(^LYFTableViewCellDeleteAction)(NSIndexPath *indexPath);

NS_ASSUME_NONNULL_BEGIN

@interface RSDabanPurchaseCell : UITableViewCell


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
/// 名字
//@property (nonatomic, copy) NSString *name;


//片号
@property (nonatomic,strong) UILabel * filmNumberLabel;
//长的值
@property (nonatomic,strong)UILabel * longDetailLabel;
//宽的值
@property (nonatomic,strong)UILabel * wideDetialLabel;
//厚的值
@property (nonatomic,strong)UILabel * thickDeitalLabel;
//原生面积的值
@property (nonatomic,strong)UILabel * originalAreaDetailLabel;
//扣尺面积的值
@property (nonatomic,strong)UILabel * deductionAreaDetailLabel;
//实际面积的值
@property (nonatomic,strong)UILabel * actualAreaDetailLabel;

@end

NS_ASSUME_NONNULL_END
