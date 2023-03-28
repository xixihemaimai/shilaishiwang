//
//  RSTaoBaoSecondSearchViewController.h
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOPDropDownMenu.h"


#import "RSTaobaoSearchScreenView.h"
#import "RSTaobaoSearchFunctionScreenView.h"


#import "RSAllMessageUIButton.h"
//淘宝专区用户
#import "RSTaobaoUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoSecondSearchViewController : UIViewController

@property (nonatomic, weak) DOPDropDownMenu *menu;


@property (nonatomic,strong)RSTaobaoSearchFunctionScreenView * leftview;


@property (nonatomic,strong)RSTaobaoSearchScreenView *showRightview;


/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;


- (void)reloadInTextContent:(NSString *)searchText;

- (void)reloadShopInformationNewData:(NSString *)stoneName;

@end

NS_ASSUME_NONNULL_END
