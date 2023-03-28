//
//  RSSearchCollectionViewCell.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RSSearchCollectionViewCell;
@protocol SelectCollectionCellDelegate <NSObject>
- (void)selectButttonClick:(RSSearchCollectionViewCell *)cell;
- (void)longSelectButttonClick:(UILongPressGestureRecognizer *)longPress;
@end


@interface RSSearchCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIButton *contentButton;

@property (weak, nonatomic) id<SelectCollectionCellDelegate> selectDelegate;
+ (CGSize) getSizeWithText:(NSString*)text;


@end
