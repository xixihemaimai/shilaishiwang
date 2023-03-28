//
//  RSDZYCMainCargoCenterViewController.h
//  石来石往
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "YNPageViewController.h"
#import "YNPageViewController.h"
#import "RSCargoHeaderView.h"
#import "RSUserModel.h"
#import "XPhotoUploaderContentEntity.h"
#import "PhotoUploadHelper.h"
#import "RSMyRingModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface RSDZYCMainCargoCenterViewController : YNPageViewController
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}


+ (instancetype)suspendCenterPageVCUserModel:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr;

+ (instancetype)suspendCenterPageVCUserModel:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr andDataSoure:(NSString *)dataSoure;



@property (nonatomic,strong)RSUserModel * usermodel;
@end

NS_ASSUME_NONNULL_END
