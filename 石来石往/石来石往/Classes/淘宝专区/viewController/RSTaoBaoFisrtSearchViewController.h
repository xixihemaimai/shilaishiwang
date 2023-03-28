//
//  RSTaoBaoFisrtSearchViewController.h
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//淘宝专区用户
#import "RSTaobaoUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSTaoBaoFisrtSearchViewControllerDelegate <NSObject>

- (void)selectItemSearchContent:(NSString *)itemName;

@end




@interface RSTaoBaoFisrtSearchViewController : UIViewController

@property (nonatomic,strong)UICollectionView *rsSearchCollectionView;

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,weak)id<RSTaoBaoFisrtSearchViewControllerDelegate>delegate;

/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;

- (void)reloadInTextContent:(NSString *)searchText;

- (void)reloadShopInformationNewData:(NSString *)stoneName;

@end

NS_ASSUME_NONNULL_END
