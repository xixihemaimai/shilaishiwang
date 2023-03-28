//
//  RSCargoMainCampViewController.h
//  石来石往
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RSUserModel.h"
@interface RSCargoMainCampViewController : UIViewController

@property (nonatomic,strong)NSString * dataSoure;

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) RSUserModel * usermodel;

/**要的上半部分的接口的参数*/
@property (nonatomic,strong)NSString * erpCodeStr;


/**要的上半部分的接口参数*/
@property (nonatomic,strong)NSString * userIDStr;

@end
