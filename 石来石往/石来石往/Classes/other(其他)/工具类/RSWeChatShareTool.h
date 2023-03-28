//
//  RSWeChatShareTool.h
//  石来石往
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSFriendModel.h"
#import "RSCodeSheetModel.h"
#import "Moment.h"
//#import <WXApi.h>
#import "WXApi.h"
#import "RSTaoBaoUserLikeModel.h"
@interface RSWeChatShareTool : NSObject



/**朋友圈的分享*/
+ (void)weChatShareStyleImageIndex:(NSInteger *)imageIndex andFriendModel:(RSFriendModel *)friendmodel;


/**朋友圈新的方式*/
+ (void)weChatShareStyleImageIndex:(NSInteger *)imageIndex andMoment:(Moment *)moment;


/**报表中心码单分享*/
+ (void)codeSheetweChatShareStyleShareStrImageIndex:(NSInteger *)imageIndex andRSCodeSheetModel:(RSCodeSheetModel *)codeShetmodel andShareStr:(NSString *)shareStr;


//个人版报表中心的分享
+ (void)codeSheetweChatShareStyleShareStrImageIndex:(NSInteger *)imageIndex andRSCodeSheetModel:(RSCodeSheetModel *)codeShetmodel andShareStr:(NSString *)shareStr andTypeStr:(NSString *)typeStr;



/**淘石专区商品分享方式*/
+ (void)weChatShareStylemageIndex:(NSInteger *)imageIndex andTaobao:(RSTaoBaoUserLikeModel *)taobaoUserLikemodel;



@end
