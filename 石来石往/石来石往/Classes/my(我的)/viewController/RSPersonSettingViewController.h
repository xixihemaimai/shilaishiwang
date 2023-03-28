//
//  RSPersonSettingViewController.h
//  石来石往
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPhotoUploaderContentEntity.h"
#import "PhotoUploadHelper.h"
#import "RSUserModel.h"
#import "RSAllViewController.h"


@protocol RSPersonSettingViewControllerDelegate <NSObject>

- (void)reRefreshUserPicture:(NSString *)picutre;


/**这边是修改了昵称和公司和职位*/
- (void)reRefreshUserNameType:(NSString *)btnType andName:(NSString *)reStr;

@end


@interface RSPersonSettingViewController :RSAllViewController
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}
@property (nonatomic,strong)RSUserModel * userModel;


@property (nonatomic,weak)id<RSPersonSettingViewControllerDelegate> delegate;

@end
