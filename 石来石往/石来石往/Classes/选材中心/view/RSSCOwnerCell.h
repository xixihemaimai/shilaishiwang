//
//  RSSCOwnerCell.h
//  石来石往
//
//  Created by mac on 2021/10/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSCContentModel.h"
#import "RSOwnerStoneModel.h"
#import "RSSCLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSCOwnerCell : UITableViewCell

//地址和存储位置
@property (nonatomic,strong)RSSCLabel * companyAddressLabel;
//打电话
@property (nonatomic,strong)UIButton * companyPhoneNumberBtn;
//跳转地址
@property (nonatomic,strong)UIButton * companyAddressBtn;
//标识背景图片
@property (nonatomic,strong)UIImageView * signImage;
//标识
@property (nonatomic,strong)UILabel * signLabel;
//仓库位置
@property (nonatomic,strong)UILabel * stoneWarehouse;

@property (nonatomic,strong)RSSCContentModel * sccontentModel;

@property (nonatomic,strong)RSOwnerStoneModel * ownerStoneModel;



@end

NS_ASSUME_NONNULL_END
