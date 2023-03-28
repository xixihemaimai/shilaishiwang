//
//  RSMyPublishViewController.h
//  石来石往
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSUserModel.h"
#import "XPhotoUploaderContentEntity.h"


@interface RSMyPublishViewController : UIViewController

{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}
@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSString * tempStr;

@end
