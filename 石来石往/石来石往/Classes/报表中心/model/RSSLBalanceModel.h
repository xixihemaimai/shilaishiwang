//
//  RSSLBalanceModel.h
//  石来石往
//
//  Created by mac on 2018/1/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSLBalanceModel : NSObject
/**匝数*/
@property (nonatomic,assign)NSInteger turnsqty;
 /**平方数*/
@property (nonatomic,assign)double area;
/**系统（海西）荒料号*/
@property (nonatomic,strong)NSString * msid;
/**序号*/
@property (nonatomic,assign)NSInteger n;
/**片数*/
@property (nonatomic,assign)NSInteger qty;
/**客户荒料号*/
@property (nonatomic,strong)NSString * csid;

/**石种名称*/
@property (nonatomic,strong)NSString * mtlname;

/**selectedKey获取片*/
@property (nonatomic,strong)NSString * selectedKey;


@end
