//
//  RSTurnsCountModel.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSTurnsCountModel.h"

@implementation RSTurnsCountModel
- (NSMutableArray *)pieces{
    if (!_pieces) {
        _pieces = [NSMutableArray array];
    }
    return _pieces;
}

@end
