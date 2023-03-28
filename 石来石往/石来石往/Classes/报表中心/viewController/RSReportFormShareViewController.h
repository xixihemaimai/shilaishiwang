//
//  RSReportFormShareViewController.h
//  石来石往
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSReportFormShareViewController : RSPersonalBaseViewController

//@property (nonatomic,strong)NSMutableDictionary * blockDict;

@property (nonatomic,strong)RSUserModel * usermodel;


/**
 当前用户ID    id    Int    
 市场ID    erpId    Int    固定1
 页码    nowpage    int       1
 每页条数    pagesize    int    10
 
 荒料号筛选    blockno    String    
 筛选条件（长）    length    int    
 筛选条件类型（长）    lengthType    int    -1 不筛选 1 大于 2 等于 3小于
 筛选条件（宽）    width    int    
 筛选条件类型（宽）    widthType    int    -1 不筛选 1 大于 2 等于 3小于
 石种名称筛选    mtlname    String    筛选条件
 石种名称选定    mtlnames    String    必填项，为点击进入页面的石种名称
 仓库名称筛选    whsName    String    
 库区名称筛选    storeareaName    String    
 储位名称筛选    locationName    String
 
 
 
 开始日期    datefrom    String    YYYY-MM-dd
 结束日期    Dateto    String    YYYY-MM-dd

 */
/**荒料号*/
@property (nonatomic,strong)NSString * blockno;
/**筛选条件长*/
@property (nonatomic,assign)NSInteger length;
/**筛选条件类型(长)*/
@property (nonatomic,assign)NSInteger lengthType;
/**筛选条件宽*/
@property (nonatomic,assign)NSInteger width;
/**筛选条件类型(宽)*/
@property (nonatomic,assign)NSInteger widthType;
/**石种名称筛选*/
@property (nonatomic,strong)NSString * mtlname;
/**石种名称选定*/
@property (nonatomic,strong)NSString * mtlnames;
/**仓库名称筛选*/
@property (nonatomic,strong)NSString * whsName;
/**库区名称筛选*/
@property (nonatomic,strong)NSString * storeareaName;
/**储位名称筛选*/
@property (nonatomic,strong)NSString * locationName;

/**开始日期*/
@property (nonatomic,strong)NSString * datefrom;
/**结束日期*/
@property (nonatomic,strong)NSString * Dateto;


@end

NS_ASSUME_NONNULL_END
