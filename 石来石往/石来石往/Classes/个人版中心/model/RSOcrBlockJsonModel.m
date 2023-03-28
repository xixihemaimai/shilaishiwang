//
//  RSOcrBlockJsonModel.m
//  石来石往
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSOcrBlockJsonModel.h"

@implementation RSOcrBlockJsonModel

- (NSMutableArray *)noteDtl{
    if (!_noteDtl) {
        _noteDtl = [NSMutableArray array];
    }
    return _noteDtl;
}


@end
