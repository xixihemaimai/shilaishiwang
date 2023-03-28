//
//  MADCameraCaptureController.h
//  MADDocScan
//
//  Created by 梁宪松 on 2017/10/28.
//  Copyright © 2017年 梁宪松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSOcrBlockJsonModel.h"
#import "RSOcrBlockDetailModel.h"

@interface MADCameraCaptureController : UIViewController


@property (nonatomic,strong)NSArray * templateArray;

@property (nonatomic,strong)NSString * selectType;
//扫描并传到第三方在从后台传回来
@property (nonatomic,strong)void(^scanSuccess)(RSOcrBlockJsonModel *ocrblockjsonmodel);
//模板ID
/**
可选   模板id 传了后使用指定ID 模板解析  不传使用当期前用户默认模板解析*/
@property (nonatomic,assign)NSInteger modelId;

@property (nonatomic,strong)void(^scanHuangLuSuccess)(NSArray * array);

@end
