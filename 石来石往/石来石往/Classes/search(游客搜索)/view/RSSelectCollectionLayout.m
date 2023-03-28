//
//  RSSelectCollectionLayout.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSelectCollectionLayout.h"

@implementation RSSelectCollectionLayout


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
    
}

- (void)prepareLayout{
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(25, 0, 0, 0);
    self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 25);
    self.minimumInteritemSpacing = 15;

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    
    
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        
        if (prevLayoutAttributes.indexPath.section == currentLayoutAttributes.indexPath.section) {
            //我们想设置的最大间距，可根据需要改
            NSInteger maximumSpacing = 15;
            //前一个cell的最右边
            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
            //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
            //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
            if((origin + maximumSpacing + currentLayoutAttributes.frame.size.width) < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + maximumSpacing;
                currentLayoutAttributes.frame = frame;
            }
        }
    }
    return attributes;
}
@end
