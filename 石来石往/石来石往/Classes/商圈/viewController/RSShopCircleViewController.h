//
//  RSShopCircleViewController.h
//  石来石往
//
//  Created by mac on 2021/11/1.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSAllViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RSShopCircleViewControllerDelegate <NSObject>

- (void)changAttatitionDataMoment:(Moment *)moment andSelectStr:(NSString *)selectStr;

@end


@interface RSShopCircleViewController : RSAllViewController

@property (nonatomic,strong)NSMutableArray * momentList;

@property (nonatomic,weak)id<RSShopCircleViewControllerDelegate>delegate;
//搜索部分内容
@property (nonatomic,strong)NSString * searchStr;

//方式1为没有搜索内容的 2为有搜索内容
@property (nonatomic,assign)NSInteger searchType;


- (void)loadNewDataWithPageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead;

@end



NS_ASSUME_NONNULL_END
