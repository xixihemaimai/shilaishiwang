//
//  RSMarketComplaintViewController.h
//  石来石往
//
//  Created by mac on 2022/9/12.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSAllViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSMarketComplaintViewController : RSAllViewController

//是否显示历史反馈记录
@property (nonatomic,assign)BOOL isShow;

//图片的数组
@property (nonatomic,strong)NSMutableArray * imageArray;

//反馈意见内容
@property (nonatomic,copy)NSString * content;

//联系电话号码
@property (nonatomic,copy)NSString * contactNumber;



@end

NS_ASSUME_NONNULL_END
