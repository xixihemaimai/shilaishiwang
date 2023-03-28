//
//  RSWeChatShareTool.m
//  石来石往
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSWeChatShareTool.h"

@implementation RSWeChatShareTool


+ (void)weChatShareStyleImageIndex:(NSInteger *)imageIndex andFriendModel:(RSFriendModel *)friendmodel{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [NSString stringWithFormat:@"%@",friendmodel.theme];
        message.description = [NSString stringWithFormat:@"%@",friendmodel.content];
        UIImage * newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[friendmodel.photos objectAtIndex:0]]]];
        NSData * data = [self imageWithImage:newImage scaledToSize:CGSizeMake(20, 20)];
        UIImage * image = [UIImage imageWithData:data];
        //[message setThumbImage:[UIImage imageNamed:@"这里是缩略图"]];
        [message setThumbImage:image];
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        // https://www.slsw.link
        //URL_HEADER_S
        webpageObject.webpageUrl = [NSString stringWithFormat:@"%@/slsw/sharewebview.html?friendId=%@",@"https://www.slsw.link",friendmodel.friendId];
        //http://117.29.162.206:8888/slsw/sharewebview.html?friendId=52
        //        ext.extInfo = @"Hi 天气";
        //        message.mediaObject = ext;
        message.mediaObject = webpageObject;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        if (imageIndex == 0) {
            req.scene = WXSceneSession;
        }else{
            req.scene = WXSceneTimeline;
        }
        req.message = message;
//        [WXApi sendReq:req];
        [WXApi sendReq:req completion:nil];
    } else {
        [SVProgressHUD showInfoWithStatus:@"你还没有安装微信"];
    }
}



+ (void)weChatShareStylemageIndex:(NSInteger *)imageIndex andTaobao:(RSTaoBaoUserLikeModel *)taobaoUserLikemodel{
    /*
     http://117.29.162.206:8888/slsw/taoshi/tsShare.html?id=156&type=daban
     type：   大板：daban；荒料：huangliao
     */
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [NSString stringWithFormat:@"%@",taobaoUserLikemodel.stoneName];
        if ([taobaoUserLikemodel.stockType isEqualToString:@"huangliao"]) {
            message.description = [NSString stringWithFormat:@"%@ 原价:%0.3lf/m³ 现价: %0.3lf/m³",taobaoUserLikemodel.shopName,[taobaoUserLikemodel.originalPrice floatValue],[taobaoUserLikemodel.price floatValue]];
        }else{
            message.description = [NSString stringWithFormat:@"%@ 原价:%0.3lf/m² 现价: %0.3lf/m²",taobaoUserLikemodel.shopName,[taobaoUserLikemodel.originalPrice floatValue],[taobaoUserLikemodel.price floatValue]];
        }
        RSTaobaoVideoAndPictureModel * taobaoVideoAndPictureModel = taobaoUserLikemodel.imageList[0];
        UIImage * newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:taobaoVideoAndPictureModel.imageUrl]]];
        NSData * data = [self imageWithImage:newImage scaledToSize:CGSizeMake(20, 20)];
        UIImage * image = [UIImage imageWithData:data];
        //[message setThumbImage:[UIImage imageNamed:@"这里是缩略图"]];
        [message setThumbImage:image];
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        // https://www.slsw.link
        //URL_HEADER_S
        webpageObject.webpageUrl = [NSString stringWithFormat:@"https://www.slsw.link/slsw/taoshi/tsShare.html?id=%ld&type=%@",taobaoUserLikemodel.userLikeID,taobaoUserLikemodel.stockType];
        //http://117.29.162.206:8888/slsw/sharewebview.html?friendId=52
        //        ext.extInfo = @"Hi 天气";
        //        message.mediaObject = ext;
        message.mediaObject = webpageObject;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        if (imageIndex == 0) {
            req.scene = WXSceneSession;
        }else{
            req.scene = WXSceneTimeline;
        }
        req.message = message;
//        [WXApi sendReq:req];
        [WXApi sendReq:req completion:nil];
    } else {
        [SVProgressHUD showInfoWithStatus:@"你还没有安装微信"];
    }
}


+ (void)weChatShareStyleImageIndex:(NSInteger *)imageIndex andMoment:(Moment *)moment{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [NSString stringWithFormat:@"%@",moment.content];
        message.description = [NSString stringWithFormat:@"%@",moment.content];
        UIImage * newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[moment.photos objectAtIndex:0]]]];
        NSData * data = [self imageWithImage:newImage scaledToSize:CGSizeMake(20, 20)];
        UIImage * image = [UIImage imageWithData:data];
        //[message setThumbImage:[UIImage imageNamed:@"这里是缩略图"]];
        [message setThumbImage:image];
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        // https://www.slsw.link
        //URL_HEADER_S
        webpageObject.webpageUrl = [NSString stringWithFormat:@"%@/slsw/sharewebview.html?friendId=%@",@"https://www.slsw.link",moment.friendId];
        //http://117.29.162.206:8888/slsw/sharewebview.html?friendId=52
        //        ext.extInfo = @"Hi 天气";
        //        message.mediaObject = ext;
        message.mediaObject = webpageObject;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        if (imageIndex == 0) {
            req.scene = WXSceneSession;
        }else{
            req.scene = WXSceneTimeline;
        }
        req.message = message;
//        [WXApi sendReq:req];
        [WXApi sendReq:req completion:nil];
    } else {
        [SVProgressHUD showInfoWithStatus:@"你还没有安装微信"];
    }
}



+ (void)codeSheetweChatShareStyleShareStrImageIndex:(NSInteger *)imageIndex andRSCodeSheetModel:(RSCodeSheetModel *)codeShetmodel andShareStr:(NSString *)shareStr{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [NSString stringWithFormat:@"码单分享"];
        message.description = [NSString stringWithFormat:@"码单分享"];
        UIImage * newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:codeShetmodel.img]]];
        //NSData * data = [self imageWithImage:newImage scaledToSize:CGSizeMake(20, 20)];
        //UIImage * image = [UIImage imageWithData:data];
        //[message setThumbImage:[UIImage imageNamed:@"这里是缩略图"]];
        [message setThumbImage:newImage];
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        webpageObject.webpageUrl = [NSString stringWithFormat:@"%@",codeShetmodel.url];
        message.mediaObject = webpageObject;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        if (imageIndex == 0) {
            req.scene = WXSceneSession;
        }else{
            req.scene = WXSceneTimeline;
        }
        req.message = message;
//        [WXApi sendReq:req];
        [WXApi sendReq:req completion:nil];
    } else {
        [SVProgressHUD showInfoWithStatus:@"你还没有安装微信"];
    }
}


+ (void)codeSheetweChatShareStyleShareStrImageIndex:(NSInteger *)imageIndex andRSCodeSheetModel:(RSCodeSheetModel *)codeShetmodel andShareStr:(NSString *)shareStr andTypeStr:(NSString *)typeStr{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [NSString stringWithFormat:@"%@",typeStr];
        message.description = [NSString stringWithFormat:@"%@",typeStr];
        UIImage * newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:codeShetmodel.img]]];
//        UIImage * newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=1&spn=0&di=74910&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=1514002029%2C2035215441&os=1877667074%2C2954420195&simid=3455148517%2C365567886&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=%E5%9B%BE%E7%89%87&objurl=https%3A%2F%2Fgimg2.baidu.com%2Fimage_search%2Fsrc%3Dhttp%3A%2F%2Fimg.16pic.com%2F00%2F88%2F44%2F16pic_8844212_s.jpg%26refer%3Dhttp%3A%2F%2Fimg.16pic.com%26app%3D2002%26size%3Df9999%2C10000%26q%3Da80%26n%3D0%26g%3D0n%26fmt%3Djpeg%3Fsec%3D1634673713%26t%3Dd1c77d889d715b891a74a4369105d7c0&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3B8mrtv_z%26e3Bv54AzdH3Ff7vwtAzdH3F9cdlndl_z%26e3Bip4s&gsm=2&islist=&querylist="]]];
        
        //NSData * data = [self imageWithImage:newImage scaledToSize:CGSizeMake(20, 20)];
        //UIImage * image = [UIImage imageWithData:data];
        //[message setThumbImage:[UIImage imageNamed:@"这里是缩略图"]];
        [message setThumbImage:newImage];
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        webpageObject.webpageUrl = [NSString stringWithFormat:@"%@",codeShetmodel.url];
        message.mediaObject = webpageObject;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        if (imageIndex == 0) {
            req.scene = WXSceneSession;
        }else{
            req.scene = WXSceneTimeline;
        }
        req.message = message;
//        [WXApi sendReq:req];
        [WXApi sendReq:req completion:nil];
    } else {
        [SVProgressHUD showInfoWithStatus:@"你还没有安装微信"];
    }
}




+ (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.4);
}



@end
