//
//  RSProcessingOutWareHouseView.h
//  石来石往
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdTableViewController.h"
#import "RSFirstProcessModel.h"
#import "RSSecondProcessModel.h"
#import "RSThirdProcessModel.h"
NS_ASSUME_NONNULL_BEGIN

//@protocol RSProcessingOutWareHouseViewDelegate <NSObject>
//
////添加进度
//- (void)addFristWithProcess:(NSString *)processStr andTime:(NSString *)timeStr andIsComplete:(BOOL)isComplete;
//
////添加费用
//
//- (void)addSecondWithName:(NSString *)name andPrice:(CGFloat)price andNumber:(NSInteger)number andMoney:(CGFloat)money;
//
////添加图片
//- (void)addThirdTitle:(NSString *)titleStr andImage:(UIImage *)image;
//
//
//
//@end



@interface RSProcessingOutWareHouseView : UIView


@property (nonatomic,strong)NSString * addType;

//@property (nonatomic,weak)id<RSProcessingOutWareHouseViewDelegate>delegate;

//相册需要的控制器
@property (nonatomic,strong)ThirdTableViewController * VC;

/**1是新建，2是修改*/
@property (nonatomic,strong)NSString * statusType;

//出库单唯一表示    billdtlid    Int
@property (nonatomic,assign)NSInteger billdtlid;

/**进程*/
@property (nonatomic,strong)RSFirstProcessModel * firstprocessmodel;

/**费用*/
@property (nonatomic,strong)RSSecondProcessModel * secondProcessmodel;
/**相册*/
@property (nonatomic,strong)RSThirdProcessModel * thirdProcessmodel;



@property (nonatomic,strong)void(^processReload)(BOOL isreload);


-(void)showView;
-(void)closeView;
@end

NS_ASSUME_NONNULL_END
