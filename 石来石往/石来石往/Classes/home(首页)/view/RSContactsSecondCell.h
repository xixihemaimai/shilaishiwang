//
//  RSContactsSecondCell.h
//  石来石往
//
//  Created by mac on 2019/1/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSContactsSecondCell : UITableViewCell
/**编辑*/
@property (nonatomic,strong) UIButton * contactsEditBtn;
/**删除*/
@property (nonatomic,strong) UIButton * contactsDeletBtn;

@property (nonatomic,strong)UILabel * contactsNameLabel;


@property (nonatomic,strong)UIImageView * defultImageView;
@end

NS_ASSUME_NONNULL_END
