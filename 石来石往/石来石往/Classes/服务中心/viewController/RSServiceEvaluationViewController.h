//
//  RSServiceEvaluationViewController.h
//  石来石往
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"

#import "RSServicePepleModel.h"
#import "RSUserModel.h"



typedef void(^CompleteSubmit) ();
@interface RSServiceEvaluationViewController : RSAllViewController

@property (nonatomic,strong)RSUserModel * usermodel;

/**方式*/
@property (nonatomic,strong)NSString * type;

/**服务ID*/
@property (nonatomic,strong)NSString * serviceId;


@property (nonatomic,strong)CompleteSubmit completesubmit;

@end
