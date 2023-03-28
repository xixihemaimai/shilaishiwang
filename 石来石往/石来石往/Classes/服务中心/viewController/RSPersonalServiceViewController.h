//
//  RSPersonalServiceViewController.h
//  石来石往
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "XPhotoUploaderContentEntity.h"
#import "RSUserModel.h"
@interface RSPersonalServiceViewController : RSAllViewController
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}

@property (nonatomic,strong)RSUserModel * usermodel;


/**用来判断是从那个界面跳转过来的*/
@property (nonatomic,strong)NSString * jumpStr;

@end
