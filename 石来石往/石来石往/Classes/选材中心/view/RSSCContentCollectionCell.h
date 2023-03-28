//
//  RSSCContentCollectionCell.h
//  石来石往
//
//  Created by mac on 2021/10/26.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSCContentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSCContentCollectionCell : UICollectionViewCell

@property (nonatomic,strong)RSSCContentModel * sccontentModel;

//判断需不需要显示仓库的位置 true是显示，false不显示
@property (nonatomic,assign)BOOL isExhibitionLocation;


@end

NS_ASSUME_NONNULL_END
