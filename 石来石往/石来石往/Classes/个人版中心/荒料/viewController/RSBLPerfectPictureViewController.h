//
//  RSBLPerfectPictureViewController.h
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSBLSpotModel.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSBLPerfectPictureViewController : UIViewController

@property (nonatomic,strong)RSBLSpotModel * blspotmodel;

@property (nonatomic,strong)RSUserModel * usermodel;



@property (nonatomic,strong)NSString * stockType;
@property (nonatomic,strong)NSString * mtlName;
@property (nonatomic,strong)NSString * blockNo;
@property (nonatomic,strong)NSString * turnsNo;

//库存类型    stockType    String    SL大板 BL荒料
//物料名称    mtlName    String
//荒料号    blockNo    String
//匝号    turnsNo    String

@end

NS_ASSUME_NONNULL_END
