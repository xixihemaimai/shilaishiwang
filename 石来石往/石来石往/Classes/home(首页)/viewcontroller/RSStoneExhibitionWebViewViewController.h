//
//  RSStoneExhibitionWebViewViewController.h
//  石来石往
//
//  Created by mac on 2017/10/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "RSUserModel.h"
@interface RSStoneExhibitionWebViewViewController : UIViewController

@property (nonatomic,strong)RSUserModel *usermodel;

/**当前荒料号*/
@property (nonatomic,strong)NSString * mtlCode;

/**（1：荒料库存码单  2：荒料出库码单 3：荒料入库码单 4：大板库存码单 5：大板出库码单 6：大板入库码单）*/
@property (nonatomic,assign)NSInteger pageType;
/**（1：ios  2：安卓）*/
@property (nonatomic,assign)NSInteger appType;
/**（大板该码单的总片数）*/
@property (nonatomic,assign)double totalSheetSun;
/**（大板该码单的总面积）*/
@property (nonatomic,assign)double totalVol;
/**（荒料名称  筛选字段）*/
@property (nonatomic,strong)NSString * mtlName;
/**（荒料号  筛选字段）*/
@property (nonatomic,strong)NSString * blockno;
/**（匝号  筛选字段）*/
@property (nonatomic,strong)NSString * turnsno;
/**（开始日期  筛选字段）*/
@property (nonatomic,strong)NSString * datefrom;
/**（结束日期  筛选字段）*/
@property (nonatomic,strong)NSString * dateto;
/**仓库  筛选字段）*/
@property (nonatomic,strong)NSString * whsname;
/**（库区  筛选字段）*/
@property (nonatomic,strong)NSString * storeareaname;
/**（储位  筛选字段）*/
@property (nonatomic,strong)NSString * locationname;
/**网址*/
@property (nonatomic,strong)NSString * webStr;


/** selectedkeyArr：xxx,xxx,xxx   （selectedkey  list，多个匝的selectedkey用逗号分割）*/
@property (nonatomic,strong)NSString * selectedkeyArr;


@property (nonatomic,assign)NSInteger  length;

@property (nonatomic,assign)NSInteger lengthType;

//宽
@property (nonatomic,assign)NSInteger width;

@property (nonatomic,assign)NSInteger widthType;




/**
 
 pageType： 1   （1：荒料库存码单  2：荒料出库码单 3：荒料入库码单 4：大板库存码单 5：大板出库码单 6：大板入库码单）
 appType：1   （1：ios  2：安卓）
 userId：xxx   （当前用户的id）具体的键值由后台定
 mtlCode：ESB000295/DH-539  （当前荒料号）
 totalSheetSun：xxx   （大板该码单的总片数）
 totalVol：xxx    （大板该码单的总面积）

 
 mtlName：xxx   （荒料名称  筛选字段）
 blockno：xxx    （荒料号  筛选字段）
 turnsno：xxx    （匝号  筛选字段）
 datefrom：xxx   （开始日期  筛选字段）
 dateto：xxx     （结束日期  筛选字段）
 whsname：xxx   （仓库  筛选字段）
 storeareaname：xxx  （库区  筛选字段）
 locationname：xxx   （储位  筛选字段）
  selectedkeyArr：xxx,xxx,xxx   （selectedkey  list，多个匝的selectedkey用逗号分割）
 
 */


@end
