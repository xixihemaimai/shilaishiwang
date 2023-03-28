//
//  RSDabanPurchaseFootView.h
//  石来石往
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RSChoosingInventoryModel.h"
#import "RSSLStoragemanagementModel.h"
#import "RSChoosingSliceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSDabanPurchaseFootView : UITableViewHeaderFooterView


@property (nonatomic,strong)NSMutableDictionary * dict;

//@property (nonatomic,strong)RSChoosingInventoryModel * choosingInventorymodel;

@property (nonatomic,strong)RSSLStoragemanagementModel * slstoragemanagementmodel;

@end

NS_ASSUME_NONNULL_END
