//
//  RSAuditStatusCustomTableViewCell.h
//  石来石往
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAuditStatusCustomTableViewCell : UITableViewCell

@property (nonatomic,strong)UIView * upView;

@property (nonatomic,strong)UIView * lowView;


@property (nonatomic,strong) UIButton * centerBtn;


/**标题*/
@property (nonatomic,strong) UILabel * titleLabel;
/**联系人*/
@property (nonatomic,strong)UILabel * contactLabel;
/**时间*/
@property (nonatomic,strong) UILabel * timeLabel ;

@end
