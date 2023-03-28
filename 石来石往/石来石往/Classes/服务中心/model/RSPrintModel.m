//
//  RSPrintModel.m
//  石来石往
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPrintModel.h"

@implementation RSPrintModel

- (NSMutableArray *)bolcks{
    if (_bolcks == nil) {
        _bolcks = [NSMutableArray array];
    }
    return _bolcks;
}

@end
