//
//  RSDabanContentView.h
//  石来石往
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSChoosingInventoryModel.h"
#import "RSChoosingSliceModel.h"

#import "RSSLStoragemanagementModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSDabanContentViewDelegate <NSObject>


- (void)sendIndex:(NSInteger)row;


- (void)deleteIndex:(NSInteger)row;

@end


@interface RSDabanContentView : UIView
@property (nonatomic,strong)UIButton * deleteBtn;

@property (nonatomic,strong)UIButton * addBtn;

@property (nonatomic,strong)NSArray * dataArray;

@property (nonatomic,weak)id<RSDabanContentViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
