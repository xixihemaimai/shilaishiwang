//
//  RSTaoBaoProdectDetailViewController.h
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTaobaoUserModel.h"
#import "RSTaoBaoMangementModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoProdectDetailViewController : UIViewController

/**类型，有荒料，大板，店铺*/
@property (nonatomic,strong)NSString * type;

/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;

//是新增加，还是查看单条数据或者是修改数据------荒料 0.1.2
//是新增加，还是查看单条数据或者是修改数据------大板 3.4.5
@property (nonatomic,assign)NSInteger joinType;

@property (nonatomic,strong)RSTaoBaoMangementModel * taobaomangementmodel;
/**判断是未上架，还是已上架*/
@property (nonatomic,strong)NSString * typeStatus;



@end

NS_ASSUME_NONNULL_END
