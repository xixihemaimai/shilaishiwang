//
//  RSHuangAndDaModel.h
//  石来石往
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSHuangAndDaModel : NSObject
/**公司的ID*/
@property (nonatomic,strong)NSString * companyId;
/**公司的名称*/
@property (nonatomic,strong)NSString * companyName;
/**公司的网址*/
@property (nonatomic,strong)NSString * companyUrl;
/**公司的图片*/
@property (nonatomic,strong)NSArray * imgUrl;
/**pagerank*/
@property (nonatomic,strong)NSString * pagerank;

/**石种ID*/
@property (nonatomic,strong)NSString * stoneId;

/**石种的名字*/
@property (nonatomic,strong)NSString * stoneName;

/**石种的次数*/
@property (nonatomic,strong)NSString * stoneNum;

/**石种的总共的信息*/
@property (nonatomic,strong)NSString * stoneTotalMessage;

/**石种的重量*/
@property (nonatomic,strong)NSString * stoneWeight;


/**石种的总数量*/
@property (nonatomic,strong)NSString * totalNum;

/**石种电话*/
@property (nonatomic,strong)NSString * phone;

/**erpCode*/
@property (nonatomic,strong)NSString * erpCode;

/**dataSource*/
@property (nonatomic,strong)NSString * dataSource;



@end
