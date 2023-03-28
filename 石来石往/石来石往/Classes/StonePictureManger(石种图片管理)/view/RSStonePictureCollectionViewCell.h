//
//  RSStonePictureCollectionViewCell.h
//  石来石往
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSStoneImageModel.h"

@class RSStonePictureCollectionViewCell;
@protocol RSStonePictureCollectionViewCellDelegate <NSObject>

- (void)deleteShowPicturestonePicturecell:(RSStonePictureCollectionViewCell *)stonePicturecell;

@end


@interface RSStonePictureCollectionViewCell : UICollectionViewCell


/**添加图片按键*/
@property (nonatomic,strong)UIImageView * addImage;
/**删除按键*/
@property (nonatomic,strong)UIButton * deleteBtn;
/**显示添加图片*/
@property (nonatomic,strong)UILabel * noLabel;
/**显示审核不通过*/
@property (nonatomic,strong)UILabel * secondNoLabel;

@property (nonatomic,strong)id<RSStonePictureCollectionViewCellDelegate>delegate;

@property (nonatomic,strong)RSStoneImageModel * stoneImagemodel;

@property (nonatomic,strong)UIImageView *  adoptImage;


@end
