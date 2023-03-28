//
//  RSStoneFlowLayout.m
//  石来石往
//
//  Created by mac on 2017/9/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSStoneFlowLayout.h"

@implementation RSStoneFlowLayout



- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize   = CGSizeMake(100, 100); // 单元格尺寸
        self.sectionInset    = UIEdgeInsetsMake(10, 10, 10, 10);                                   // 单元格边缘
        self.minimumInteritemSpacing = 10;                                                              // 横排单元格最小间隔
        self.minimumLineSpacing      = 10;                                                              // 单元格最小行间距
    }
    return self;
}
@end
