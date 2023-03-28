//
//  RSStonePictureModel.h
//  石来石往
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSStonePictureModel : NSObject

/**图片的ID*/
@property (nonatomic,strong)NSString * sysUserId;

/**图片名字*/
@property (nonatomic,strong)NSString * proName;

/**图片*/
@property (nonatomic,strong)NSArray * photos;
/**范围*/
@property (nonatomic,strong)NSString * pagerank;
@end
