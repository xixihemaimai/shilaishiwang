//
//  RSStonePictureMangerViewController.h
//  石来石往
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPhotoUploaderContentEntity.h"
#import "PhotoUploadHelper.h"

#import "RSUserModel.h"




@interface RSStonePictureMangerViewController : UIViewController
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}

@property (nonatomic,strong)RSUserModel * userModel;




@end
