//
//  RSServiceEvalModel.m
//  石来石往
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceEvalModel.h"

@implementation RSServiceEvalModel
- (NSMutableArray *)serviceUserEvalList{
    if (_serviceUserEvalList == nil) {
        _serviceUserEvalList = [NSMutableArray array];
    }
    return _serviceUserEvalList;
}

@end
