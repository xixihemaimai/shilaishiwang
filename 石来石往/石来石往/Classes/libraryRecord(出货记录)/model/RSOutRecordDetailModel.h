//
//  RSOutRecordDetailModel.h
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSOutRecordDetailModel : NSObject


/**出货的名字*/
@property (nonatomic,strong)NSString * blockName;
/**出货的荒料号*/
@property (nonatomic,strong)NSString * blockNo;

/**出货的数量*/
@property (nonatomic,strong)NSString * blockNum;
/**出货的匝数*/
@property (nonatomic,strong)NSString * blockTurns;

/**储位号*/
@property (nonatomic,strong)NSString * locationName;

/**匝位*/
@property (nonatomic,strong)NSString * turnsNo;

@end
