//
//  RSOsakaModel.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSOsakaModel.h"

@implementation RSOsakaModel

- (NSMutableArray *)turns{
    if (!_turns) {
        _turns = [NSMutableArray array];
    }
    return _turns;
}
@end
