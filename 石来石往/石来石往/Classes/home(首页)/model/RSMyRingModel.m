//
//  RSMyRingModel.m
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyRingModel.h"

@implementation RSMyRingModel

- (NSMutableArray *)ownerLinkMan{
    if (!_ownerLinkMan) {
        _ownerLinkMan = [NSMutableArray array];
    }
    return _ownerLinkMan;
}

@end
