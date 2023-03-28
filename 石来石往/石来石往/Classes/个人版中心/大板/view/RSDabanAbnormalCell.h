//
//  RSDabanAbnormalCell.h
//  石来石往
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSChoosingInventoryModel.h"
#import "RSChoosingSliceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSDabanAbnormalCell : UITableViewCell

//@property (nonatomic,strong)NSMutableDictionary * dict;

@property (nonatomic,strong)UIButton * downBtn;


@property (nonatomic,strong)RSChoosingInventoryModel * choosingInventorymodel;


@property (nonatomic,strong)UIButton * productEidtBtn;


@property (nonatomic,strong) UIButton * productDeleteBtn;

@property (nonatomic,strong)UIImageView * downImageView;

@end

NS_ASSUME_NONNULL_END
