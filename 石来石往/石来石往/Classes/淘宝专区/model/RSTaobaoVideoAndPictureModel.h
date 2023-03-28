//
//  RSTaobaoVideoAndPictureModel.h
//  石来石往
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaobaoVideoAndPictureModel : NSObject
@property (nonatomic,strong)NSString * imageUrl;
@property (nonatomic,strong)NSString * videoUrl;
@property (nonatomic,assign)NSInteger imageId;
@property (nonatomic,assign)NSInteger videoId;
@end

NS_ASSUME_NONNULL_END
