//
//  RSMyRingViewController.h
//  石来石往
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSMyRingModel.h"
#import "XPhotoUploaderContentEntity.h"
#import "PhotoUploadHelper.h"

#import "RSFriendModel.h"

#import "RSUserModel.h"
#import "RSVideoScreenViewController.h"

@interface RSMyRingViewController : RSAllViewController
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}
/**背景图片*/
@property (nonatomic,strong)UIImageView * oweImage;
/**背景头像图片*/
@property (nonatomic,strong)UIImageView * nameImage;
/**调用相册*/
@property (nonatomic,strong)UIButton * alassetviewBtn;
/**背景头像的名称*/
@property (nonatomic,strong)UILabel * oweName;
/**用来判断是是游客还是货主*/
@property (nonatomic,strong)NSString * userType;

@property (nonatomic,strong)RSMyRingModel * mymodel;
/**要的上半部分的接口的参数*/
@property (nonatomic,strong)NSString * erpCodeStr;
/**要的上半部分的接口参数*/
@property (nonatomic,strong)NSString * userIDStr;
/**朋友圈的数据*/
@property (nonatomic,strong)NSString * creat_userIDStr;
/**朋友圈的模型*/
//@property (nonatomic,strong)RSFriendModel * friendmodel;
/**用户的数据*/
@property (nonatomic,strong)RSUserModel * userModel;

@end
