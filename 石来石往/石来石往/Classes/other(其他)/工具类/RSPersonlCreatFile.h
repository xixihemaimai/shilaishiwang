//
//  RSPersonlCreatFile.h
//  石来石往
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSPersonlCreatFile : NSObject


+ (NSString*)getPathWithinDocumentDir:(NSString*)aPath;

+(BOOL)judgePathWithinDocumentDir:(NSString*)aPath;
@end

NS_ASSUME_NONNULL_END
