//
//  RSHandleViewController.h
//  石来石往
//
//  Created by mac on 17/6/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAllViewController.h"
#import "RSRecordViewController.h"

#import "RSUserModel.h"

@interface RSHandleViewController :RSRecordViewController

@property (nonatomic,strong)NSString * userID;

@property (nonatomic,strong)RSUserModel *usermodel;


@end
