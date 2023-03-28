//
//  RSAccountDetailModel.m
//  石来石往
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSAccountDetailModel.h"

@implementation RSAccountDetailModel
- (NSMutableArray *)billDetailVos{
    if (!_billDetailVos) {
        _billDetailVos = [NSMutableArray array];
    }
    return _billDetailVos;
}



@end
