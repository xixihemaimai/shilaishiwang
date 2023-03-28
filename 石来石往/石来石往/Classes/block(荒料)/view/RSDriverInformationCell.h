//
//  RSDriverInformationCell.h
//  石来石往
//
//  Created by mac on 17/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDirverContact.h"
@interface RSDriverInformationCell : UITableViewCell



@property (nonatomic,strong)UIView *  editview;
//@property (nonatomic,strong)UIButton *editBtn;

@property (nonatomic,strong)UIButton *removeBtn;

@property (nonatomic,strong)RSDirverContact * contact;


@end
