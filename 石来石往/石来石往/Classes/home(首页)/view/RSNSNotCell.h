//
//  RSNSNotCell.h
//  石来石往
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSNSNotCell : UITableViewCell
/*图片*/
@property (nonatomic,strong)UIImageView * nsnotImage;
/**内容*/
@property (nonatomic,strong)UILabel * nsnotLabel;

/**次数*/
@property (nonatomic,strong)UILabel * nsnotNumberLabel;


@end
