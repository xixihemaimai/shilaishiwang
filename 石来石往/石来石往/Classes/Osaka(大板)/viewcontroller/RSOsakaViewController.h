//
//  RSOsakaViewController.h
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSUserModel.h"


#import "RSDirverContact.h"

@interface RSOsakaViewController : RSAllViewController

//货主自己选择出货的方式是按匝还是按片的的方式
@property (nonatomic,assign)NSInteger styleModel;

/**创建一个数组，用来接收从详细大板的控制中提交中出来的模型，添加到数组中*/
@property (nonatomic,strong)NSMutableArray *choiceOsakaArray;



/**用来接收接口参数的一个成员属性*/
@property (nonatomic,strong)NSString * userID;


@property (nonatomic,strong)RSUserModel *userModel;



@property (nonatomic,strong)RSDirverContact *contact;

@end
