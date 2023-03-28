//
//  RSCollectCell.h
//  石来石往
//
//  Created by mac on 17/5/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSCollectionModel.h"
@interface RSCollectCell : UITableViewCell
/**删除按键*/
@property (nonatomic,strong)UIButton *removeBtn;
/**打电话按键*/
@property (nonatomic,strong)UIButton *playPhoneBtn;

/**电话号码*/
@property (nonatomic,strong)UILabel *phoneLabel;

@property (nonatomic,strong)RSCollectionModel * collectionModel;

@end
