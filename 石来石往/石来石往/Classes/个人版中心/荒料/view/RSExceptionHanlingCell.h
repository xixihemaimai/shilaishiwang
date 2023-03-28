//
//  RSExceptionHanlingCell.h
//  石来石往
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSStoragemanagementModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSExceptionHanlingCell : UITableViewCell


@property (nonatomic,strong)UILabel * handleLabel;

//@property (nonatomic,strong)UIButton * productEidtBtn;

@property (nonatomic,strong)UIButton * productDeleteBtn;


@property (nonatomic,strong)UIButton * handBtn;

@property (nonatomic,strong)RSStoragemanagementModel * storagemanagementmodel;


@end

NS_ASSUME_NONNULL_END
