//
//  RSChoosingInventoryModel.m
//  石来石往
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSChoosingInventoryModel.h"

@implementation RSChoosingInventoryModel

- (NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray *)sliceArray{
    
    if (!_sliceArray) {
        _sliceArray = [NSMutableArray array];
    }
    return _sliceArray;
}

@end
