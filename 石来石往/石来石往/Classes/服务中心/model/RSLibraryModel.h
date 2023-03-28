//
//  RSLibraryModel.h
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSLibraryModel : NSObject
/**发起的时间*/
@property (nonatomic,strong)NSString * createTime;
/**出库的单号*/
@property (nonatomic,strong)NSString * outboundNo;
@end
