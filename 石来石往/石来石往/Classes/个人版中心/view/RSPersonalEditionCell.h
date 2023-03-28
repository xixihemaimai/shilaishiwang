//
//  RSPersonalEditionCell.h
//  石来石往
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol RSPersonalEditionCellDelegate <NSObject>

- (void)selectPublishCurrentImage:(UIImage *)CurrentImage;

@end


@interface RSPersonalEditionCell : UITableViewCell


@property (nonatomic,strong)NSString * tyle;


@property (nonatomic,weak)id<RSPersonalEditionCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
