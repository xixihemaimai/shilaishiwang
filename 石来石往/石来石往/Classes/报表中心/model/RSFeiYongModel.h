//
//  RSFeiYongModel.h
//  石来石往
//
//  Created by mac on 2018/1/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSFeiYongModel : NSObject
/**费用日期*/
@property (nonatomic,strong)NSString * billdate;
/**费用名称*/
@property (nonatomic,strong)NSString * feename;
/**费用类别*/
@property (nonatomic,strong)NSString * businesstype;
/**费用金额*/
@property (nonatomic,assign)double money;
/**货主代码*/
@property (nonatomic,strong)NSString * dealercode;
/**货主名称*/
@property (nonatomic,strong)NSString * dealername;
/**序号*/
@property (nonatomic,assign)NSInteger n;



@end
