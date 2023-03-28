//
//  RSNewTemplateViewController.h
//  石来石往
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
//#import "XPhotoUploaderContentEntity.h"
//#import "PhotoUploadHelper.h"
#import "RSTemplateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSNewTemplateViewController : UIViewController
//{
//    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
//}

@property (nonatomic,strong)RSTemplateModel * templatemodel;

@property (nonatomic,strong)NSString * ismodifyStr;

@property (nonatomic,strong)NSString * selectType;


@property (nonatomic,strong)void(^reload)(BOOL isreload);

@end

NS_ASSUME_NONNULL_END
