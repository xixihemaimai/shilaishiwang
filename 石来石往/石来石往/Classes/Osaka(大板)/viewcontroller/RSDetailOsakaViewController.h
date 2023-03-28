//
//  RSDetailOsakaViewController.h
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSOsakaModel.h"
#import "RSTurnsCountModel.h"
#import "RSPiecesModel.h"



typedef enum{
    topicOsaka = 1,
    topicDetail = 2
    
    
}leixi;


@protocol RSDetailOsakaViewControllerDelegate <NSObject>


/**把选中的一些模型发送到前一个控制器上面的数组中*/
- (void)choiceDataWithSendOsakaModel:(RSOsakaModel *)osakaModel;


- (void)removeDataWithSendOsakaModel:(RSOsakaModel *)osakaModel;

@end




@interface RSDetailOsakaViewController : UIViewController

/**出货的选择方式*/
@property (nonatomic,assign)NSInteger styleModel;
/**用来接收你点击的那个cell里面的详细信息*/
@property (nonatomic,strong)RSOsakaModel *osakaModel;
///**获取里面有多少匝号和片数*/
//@property (nonatomic,strong)RSTurnsCountModel *turnsModel;

@property (nonatomic,weak)id<RSDetailOsakaViewControllerDelegate>delegate;

/**用来存放改变片选之后里面模型里面的状态的模型的数组*/
@property (nonatomic, strong) NSMutableArray *btnStatueArr;


/**用来存放改变匝选之后里面的模型里面的状态的模型的数组*/
@property (nonatomic,strong) NSMutableArray * turnsStatueArr;

/**选中按键的名字的数组*/
@property (nonatomic, strong) NSMutableArray *tmpArray;
/**用来计数按匝选择的片数*/
@property (nonatomic) NSUInteger tmpZhaPianCount;
/**进来的类型*/
@property (nonatomic,assign)leixi leixi;

@end
