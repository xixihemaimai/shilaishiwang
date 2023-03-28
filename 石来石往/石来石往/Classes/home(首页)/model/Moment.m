//
//  Moment.m
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "Moment.h"

@implementation Moment

- (NSMutableArray *)commentList{
    if (_commentList == nil) {
        _commentList = [NSMutableArray array];
    }
    return _commentList;
}

- (NSMutableArray *)likeList{
    if (!_likeList) {
        _likeList = [NSMutableArray array];
    }
    return _likeList;
}


@end
