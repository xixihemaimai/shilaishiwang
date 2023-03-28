//
//  RSServiceMarketViewController.h
//  石来石往
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "XPhotoUploaderContentEntity.h"

#import <MobileCoreServices/MobileCoreServices.h>

#import "RSUserModel.h"

@interface RSServiceMarketViewController : RSAllViewController
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}


/**当前登录者*/
@property (nonatomic,strong)RSUserModel * usermodel;

/**服务者的ID*/
@property (nonatomic,strong)NSString * serviceId;
/**服务类型*/
@property (nonatomic,strong)NSString * type;

/**标识*/
@property (nonatomic,strong)NSString * search;
/**服务状态*/
@property (nonatomic,strong)NSString * status;





/**用来判断是从那个界面跳转过来的*/
@property (nonatomic,strong)NSString * jumpStr;



/**修改服务的状态*/
@property (nonatomic,strong)NSString * modifyStatusStr;


@end
