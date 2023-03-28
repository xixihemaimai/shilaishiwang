//
//  RSSalertView.h
//  石来石往
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RSSalertViewDelegate <NSObject>


//选择功能界面的筛选
//入库时间 截止时间 物料名称 荒料号
- (void)screenFunctionWithWarehousingTime:(NSString *)warehousingTime andDeadline:(NSString *)deadlingTime andMaterialName:(NSString *)materialName andBlockNumber:(NSString *)blockNumber;

//仓库要有选中第几个仓库，位置是那个名称，还是就是仓库名称是什么
- (void)warehouseSelectName:(NSString *)selectName andWarehouseName:(NSString *)warehouseName andSelectType:(NSString *)selectType andTag:(NSInteger)tag;

//物料--有物料名称，物料类型，有第几个，名字叫什么，石种颜色，第几个，名称叫什么
- (void)materialWithContent:(NSString *)content FristName:(NSString *)firstName andSecondName:(NSString *)secondName andColorId:(NSInteger)colorid andTypeID:(NSInteger)typeId andSelectType:(NSString *)selectType andTag:(NSInteger)tag;

//这边是荒料库存余额边
 //这边要用起始时间 截止时间 入库类型的选择的位置 所在仓库的位置 物料名称 荒料号
- (void)balanceFunctionWithBeginTime:(NSString *)beginTime andEndTime:(NSString *)endTime andType:(NSInteger)index andWareHouseName:(NSString *)wareHouseName andWarehouseIndex:(NSInteger)secondIndex andName:(NSString *)name andBlockNo:(NSString *)blockNo;

//选择荒料筛选的代理 选择仓库 ，位置，和显示内容 ，物料名称 荒料号
-(void)blockFunctionWithWareHouseName:(NSString *)wareHouseName andName:(NSString *)name andBlockNo:(NSString *)blockNo;

//这边是荒料异常筛选的代理
- (void)abnormalFunctionWithWarehouseName:(NSString *)wareHouseName andIndex:(NSInteger)index andName:(NSString *)name andBlockNo:(NSString *)blockNo;


//大板入库修改厚度方法
- (void)changHeightNumber:(NSString *)heightNumber;


//加工厂
- (void)reloadFactoryName:(NSString *)name andType:(NSString *)selectType andTag:(NSInteger)tag;



@end





@interface RSSalertView : UIView
/**选择的类型*/
@property (nonatomic,strong)NSString * selectFunctionType;

@property (nonatomic,strong)NSArray * typeArray;

@property (nonatomic,strong)NSArray * colorArray;

@property (nonatomic,weak)id<RSSalertViewDelegate>delegate;

//仓库中选择的值
@property (nonatomic,strong)NSString * wareHouseTypeName;
//仓库的仓库名称
@property (nonatomic,strong)NSString * wareHouseProductName;
//要知道位置
@property (nonatomic,assign)NSInteger  indextag;


@property (nonatomic,assign)NSInteger index;

@property (nonatomic,assign)NSInteger secondIndex;

//物料中物料名称
@property (nonatomic,strong)NSString * materialProductName;
//物料中选择物料类型
@property (nonatomic,strong)NSString * materialTypeName;
//物料中选择的物料颜色
@property (nonatomic,strong)NSString * materialColorName;
//编辑的状态
@property (nonatomic,strong)NSString * selectType;


//appid
@property (nonatomic,assign)NSInteger applyID;

//用户ID
@property (nonatomic,assign)NSInteger userManagementID;


@property (nonatomic,strong)void(^reload)(BOOL istrue);

@property (nonatomic,strong)void(^modilfy)(NSString * phoneTextStr,NSString * compantTextStr);

-(void)showView;
-(void)closeView;
@end

NS_ASSUME_NONNULL_END
