//
//  MLLabelUtil.m
//  MomentKit
//
//  Created by LEA on 2017/12/13.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MLLabelUtil.h"

@implementation MLLabelUtil

MLLinkLabel *kMLLinkLabel()
{
    
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 0;
    
    NSMutableDictionary * linkTextAttributes = [NSMutableDictionary dictionary];
    [linkTextAttributes setObject:[UIColor colorWithHexColorStr:@"#333333"] forKey:NSForegroundColorAttributeName]; // 前景色
    [linkTextAttributes setObject:style forKey:NSParagraphStyleAttributeName];// 行距
    
    
    NSMutableDictionary * activeLinkTextAttributes = [NSMutableDictionary dictionary];
    [activeLinkTextAttributes setObject:[UIColor colorWithHexColorStr:@"#333333"] forKey:NSForegroundColorAttributeName]; //前景色
    [activeLinkTextAttributes setObject:kHLBgColor forKey:NSBackgroundColorAttributeName]; // 背景色
    [activeLinkTextAttributes setObject:style forKey:NSParagraphStyleAttributeName]; // 行距
    
    
    MLLinkLabel *_linkLabel = [MLLinkLabel new];
    _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _linkLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    _linkLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    _linkLabel.numberOfLines = 0;
    _linkLabel.linkTextAttributes = linkTextAttributes;
    _linkLabel.activeLinkTextAttributes = activeLinkTextAttributes;
//    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#333333"]};
//    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#333333"],NSBackgroundColorAttributeName:kHLBgColor};
    _linkLabel.activeLinkToNilDelay = 0.3;
    return _linkLabel;
}

NSMutableAttributedString *kMLLinkLabelAttributedText(id object)
{
    NSMutableAttributedString *attributedText = nil;
    if ([object isKindOfClass:[Comment class]])
    {
        Comment * comment = (Comment *)object;
        if (comment.commentmod == 2) {
            NSString *likeString  = [NSString stringWithFormat:@"%@回复%@:%@",comment.commentName,comment.relUser,comment.comment];
            attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:Width_Real(14)],NSLinkAttributeName:[NSString stringWithFormat:@"%@",comment.commentName]}
                                    range:[likeString rangeOfString:[NSString stringWithFormat:@"%@",comment.commentName]]];
            
            
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:Width_Real(14)],NSLinkAttributeName:[NSString stringWithFormat:@"%@:",comment.relUser]}
                                    range:[likeString rangeOfString:[NSString stringWithFormat:@"%@:",comment.relUser]]];
        } else {
            NSString *likeString  = [NSString stringWithFormat:@"%@:%@",comment.commentName,comment.comment];
            attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:Width_Real(14)],NSLinkAttributeName:[NSString stringWithFormat:@"%@:",comment.commentName]}
                                    range:[likeString rangeOfString:[NSString stringWithFormat:@"%@:",comment.commentName]]];
        }
    }
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *content = (NSString *)object;
        NSString *likeString = [NSString stringWithFormat:@"[赞] %@",content];
        attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
        NSArray *nameList = [content componentsSeparatedByString:@"，"];
        for (NSString *name in nameList) {
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSLinkAttributeName:name,NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#4C618E"]}
                                    range:[likeString rangeOfString:name]];
        }
        
        //添加'赞'的图片
        NSRange range = NSMakeRange(0, 3);
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"Path1"];
        textAttachment.bounds = CGRectMake(0, -3, textAttachment.image.size.width, textAttachment.image.size.height);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attributedText replaceCharactersInRange:range withAttributedString:imageStr];
    }
    return attributedText;
}


@end
