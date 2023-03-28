//
//  RSShowAuditiewController.h
//  石来石往
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSApplyListModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface RSShowAuditiewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)RSApplyListModel * applyylistmodel;
@end

NS_ASSUME_NONNULL_END
