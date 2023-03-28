//
//  RSHistoryViewController.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "singerTon.h"
#import "RSUserModel.h"





@interface RSHistoryViewController : UIViewController





@property (nonatomic,strong)UICollectionView *rsSearchCollectionView;


@property (nonatomic,strong)UITextField * rsSearchTextField;

/**tableview*/
@property (nonatomic,strong)UITableView * tableview;

/**是选中的是大板还是荒料*/
//@property (nonatomic,strong)NSString * searchType;

/**登录的客户的模型*/
@property (nonatomic,strong)RSUserModel * userModel;



@end
