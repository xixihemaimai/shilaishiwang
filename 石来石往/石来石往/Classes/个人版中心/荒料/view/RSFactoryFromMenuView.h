//
//  RSFactoryFromMenuView.h
//  石来石往
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSWarehouseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSFactoryFromMenuView : UIView

/**加工跟单和出材率的筛选条件的区别，1为加工跟单2为出材率*/
@property (nonatomic,strong)NSString * menuType;

/**仓库选择位置*/
@property (nonatomic,assign)NSInteger wareHouseIndex;
/**加工厂选择的位置*/
@property (nonatomic,assign)NSInteger factoryIndex;
/**类型*/
@property (nonatomic,strong)NSString * selectyType;


@property (nonatomic,strong)void(^showSelectMenu)(NSString * selectyType,NSString * beginTime,NSString * endTime,NSString * wuliaoTextView,NSString * blockTextView,NSString * wareHouseView,NSInteger wareHouseIndex,NSString * factoryView,NSInteger factoryIndex);


@end

NS_ASSUME_NONNULL_END
