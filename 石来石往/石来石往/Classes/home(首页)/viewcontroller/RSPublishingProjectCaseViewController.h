//
//  RSPublishingProjectCaseViewController.h
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPhotoUploaderContentEntity.h"
#import "RSUserModel.h"
#import "RSProjectCaseThirdModel.h"




@protocol RSPublishingProjectCaseViewControllerDelegate <NSObject>

/**重新获取数据*/
- (void)reDraft;


@end

@interface RSPublishingProjectCaseViewController : UIViewController
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}


@property (nonatomic,assign)NSInteger engineeringID;

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,weak)id<RSPublishingProjectCaseViewControllerDelegate>delegate;


/**用来判断是是新建还是草稿 0表示新建 1表示草稿*/
@property (nonatomic,strong)NSString * goodCreat;

/**获取主题出来*/
@property (nonatomic,strong)NSString * loadtitle;

@end
