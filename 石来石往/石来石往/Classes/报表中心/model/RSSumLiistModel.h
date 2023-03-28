//
//  RSSumLiistModel.h
//  石来石往
//
//  Created by mac on 2018/1/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSumLiistModel : NSObject
/**总条数*/
@property (nonatomic,assign)NSInteger datasize;
/**总扣尺面积*/
@property (nonatomic,assign)double totaldedarea;
/**总原始面积*/
@property (nonatomic,assign)double totalprearea;
/**总片数*/
@property (nonatomic,assign)NSInteger totalqty;
/**总实际面积*/
@property (nonatomic,assign)double sumarea;
/**合计片数*/
@property (nonatomic,assign)NSInteger sumqty;
/**合计实际面积*/
@property (nonatomic,assign)double totalarea;
/**合计扣尺面积*/
@property (nonatomic,assign)double sumdedarea;
/**合计原始面积*/
@property (nonatomic,assign)double sumprearea;
/**合计立方数*/
@property (nonatomic,assign)double sumvolume;
/**合计吨数*/
@property (nonatomic,assign)double sumweight;
/**总吨数*/
@property (nonatomic,assign)double totalweight;
/**总匝数*/
@property (nonatomic,assign)NSInteger totalturnsqty;

@end
