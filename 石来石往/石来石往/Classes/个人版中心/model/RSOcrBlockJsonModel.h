//
//  RSOcrBlockJsonModel.h
//  石来石往
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

//石材码单类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOcrBlockJsonModel : NSObject


//isbool是否打开和展开
//选择料的数组
//


// 码单头标题
//@property (nonatomic,strong)NSString * noteTitle;
// 码单类型
//@property (nonatomic,strong)NSString * noteType;
// 客户名称
//@property (nonatomic,strong)NSString * customer;
// 供应商名称
//@property (nonatomic,strong)NSString * supplier;
// 码单日期
//@property (nonatomic,strong)NSString * noteDate;
// 码单单号
//@property (nonatomic,strong)NSString * noteNo;
// 明细数量
//@property (nonatomic,assign)int dtlCount;
// 码单明细
@property (nonatomic,strong)NSMutableArray * noteDtl;






@end

NS_ASSUME_NONNULL_END
