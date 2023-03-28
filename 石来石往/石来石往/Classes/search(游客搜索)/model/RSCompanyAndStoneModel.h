//
//  RSCompanyAndStoneModel.h
//  石来石往
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSCompanyAndStoneModel : NSObject


/**石料ID*/
@property (nonatomic,strong)NSString * blockId;

/**石料的内容*/
@property (nonatomic,strong)NSString * content;

/**石料的创建时间*/
@property (nonatomic,strong)NSString * createTime;

/**石料erpCode*/
@property (nonatomic,strong)NSString * erpCode;

/**石料的friendId*/
@property (nonatomic,strong)NSString * friendId;


/**石料的图片*/
@property (nonatomic,strong)NSString * imgUrl;

/**石料的qty*/
@property (nonatomic,strong)NSString * qty;
/**石料的stockType*/
@property (nonatomic,strong)NSString * stockType;

/**石料的stoneId*/
@property (nonatomic,strong)NSString * stoneId;


/**石料的turnsQty*/
@property (nonatomic,strong)NSString * turnsQty;


/**石料的type*/
@property (nonatomic,strong)NSString * type;

/**石料的vaqty*/
@property (nonatomic,strong)NSString * vaqty;

/**公司名称*/
@property (nonatomic,strong)NSString * companyName;


/**电话号码*/
@property (nonatomic,strong)NSString * phone;

/**重量*/
@property (nonatomic,strong)NSString * weight;





@end
