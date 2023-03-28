//
//  RSReportFormSLShareViewController.h
//  石来石往
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSReportFormSLShareViewController : RSPersonalBaseViewController
@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,assign)NSInteger searchTypeIndex;

//@property (nonatomic,strong)NSMutableDictionary * blockDict;


@property (nonatomic,strong)NSString * blocknos;

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
/**匝号筛选*/
@property (nonatomic,strong)NSString * turnsno;
/**开始日期*/
@property (nonatomic,strong)NSString * datefrom;
/**结束日期*/
@property (nonatomic,strong)NSString * Dateto;



@end

NS_ASSUME_NONNULL_END
