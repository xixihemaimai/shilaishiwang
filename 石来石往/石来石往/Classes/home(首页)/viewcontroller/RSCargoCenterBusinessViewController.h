//
//  RSCargoCenterBusinessViewController.h
//  石来石往
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YNPageViewController.h"
#import "RSCargoHeaderView.h"
#import "RSUserModel.h"
#import "XPhotoUploaderContentEntity.h"
#import "PhotoUploadHelper.h"
#import "RSMyRingModel.h"

@interface RSCargoCenterBusinessViewController : YNPageViewController

{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}


+ (instancetype)suspendCenterPageVCUserModel:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr;
@property (nonatomic,strong)RSUserModel * usermodel;




@end
