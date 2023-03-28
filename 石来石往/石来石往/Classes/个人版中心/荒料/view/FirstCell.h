//
//  FirstCell.h
//  TableViewFloat
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 singularity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSFirstProcessModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstCell : UITableViewCell

@property (nonatomic,strong)RSFirstProcessModel * firstprocessmodel;
@property (nonatomic,strong)UIButton * creatCurrentBtn;
@end

NS_ASSUME_NONNULL_END
