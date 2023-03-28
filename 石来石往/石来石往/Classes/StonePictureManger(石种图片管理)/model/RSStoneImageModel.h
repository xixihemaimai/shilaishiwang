//
//  RSStoneImageModel.h
//  石来石往
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSStoneImageModel : NSObject
/**图片的ID*/
@property (nonatomic,strong)NSString * imageID;

/**图片的URL*/
@property (nonatomic,strong)NSString * url;

/**图片的审核的状态*/
@property (nonatomic,assign)NSInteger checkStatus;
/**图片不同的审核原因*/
@property (nonatomic,strong)NSString * checkMessage;



@end
