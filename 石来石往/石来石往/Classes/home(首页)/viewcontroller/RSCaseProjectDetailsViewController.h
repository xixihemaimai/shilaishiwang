//
//  RSCaseProjectDetailsViewController.h
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSProjectCaseModel.h"
#import "RSProjectCaseImageModel.h"
#import "RSUserModel.h"
#import "RSProjectCaseThirdModel.h"

@interface RSCaseProjectDetailsViewController : RSAllViewController

@property (nonatomic,strong)NSString * ID;


@property (nonatomic,strong)RSUserModel * usermodel;


@property (nonatomic,strong)NSString  * userIdStr;

@end


