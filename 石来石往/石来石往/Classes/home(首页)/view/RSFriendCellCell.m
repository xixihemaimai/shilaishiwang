//
//  RSFriendCellCell.m
//  石来石往
//
//  Created by mac on 17/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFriendCellCell.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
 //#define PHONEREGULAR @"\\d{3,4}[- ]?\\d{7,8}"


#import "RSGetPhoneNumberTool.h"
#import "UIImage+GIF.h"




@interface RSFriendCellCell()<TTTAttributedLabelDelegate,RSFriendViewDelegate>
{
    UIView * lineview;
    
}




@end


@implementation RSFriendCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //朋友圈的头像图片
        UIImageView * HZLogo = [[UIImageView alloc]init];
        _HZLogo = HZLogo;
        [self.contentView addSubview:HZLogo];
        
        //是否是货主头像框
        UIImageView * touImage = [[UIImageView alloc]init];
       // touImage.image = [UIImage imageNamed:@"货主头像框"];
        [self.contentView addSubview:touImage];
        _touImage = touImage;
        
        //朋友圈的名字
        UILabel * HZName = [[UILabel alloc]init];
        _HZName = HZName;
        HZName.textColor = [UIColor colorWithHexColorStr:@"#7683a4"];
        HZName.textAlignment = NSTextAlignmentLeft;
        HZName.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:HZName];

        //朋友圈的时间
        UILabel * HZtimeLabel = [[UILabel alloc]init];
        HZtimeLabel.textColor = [UIColor colorWithHexColorStr:@"#7683a4"];
        HZtimeLabel.textAlignment = NSTextAlignmentLeft;
        HZtimeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:HZtimeLabel];
        _HZtimeLabel = HZtimeLabel;
        
        UIButton * followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        followBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [followBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        [followBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        [followBtn setTitle:@"关注" forState:UIControlStateNormal];
        [followBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCFCFC"]];
        followBtn.layer.cornerRadius = 2;
        followBtn.layer.borderWidth = 1;
        followBtn.imageEdgeInsets = UIEdgeInsetsMake(9, 5, 9, 5);
      //  followBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 2);
        followBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        followBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
        followBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:followBtn];
        _followBtn = followBtn;
        //朋友圈的内容
        TTTAttributedLabel * content = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
        content.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        content.numberOfLines = 0;
        content.font =[UIFont systemFontOfSize:16];
        content.enabledTextCheckingTypes = NSTextCheckingAllTypes;
        content.delegate = self;
        [self.contentView addSubview:content];
        _content = content;
        
        RSFriendView *friendview =[[RSFriendView alloc]init];
        friendview.userInteractionEnabled = YES;
        friendview.backgroundColor = [UIColor whiteColor];
        _friendview = friendview;
        [self.contentView addSubview:friendview];
        lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:lineview];
        
       
        
        RSDiBuView * dibuview = [[RSDiBuView alloc]init];
        dibuview.userInteractionEnabled = YES;
        dibuview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
        _dibuview = dibuview;
        [self.contentView addSubview:dibuview];
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        [self.contentView addSubview:bottomview];
        _bottomview = bottomview;
        
        HZLogo.sd_layout
        .leftSpaceToView(self.contentView,12)
        .topSpaceToView(self.contentView,21)
        .widthIs(38)
        .heightIs(38);
        
        touImage.sd_layout
        .leftSpaceToView(HZLogo,12)
        .topEqualToView(HZLogo)
        .widthIs(20)
        .heightIs(20);
        
        followBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .topEqualToView(HZLogo)
        .widthIs(60)
        .heightIs(30);
      
        HZName.sd_layout
        .leftSpaceToView(touImage,5)
        .rightSpaceToView(followBtn,10)
        .topEqualToView(HZLogo)
        .heightIs(20);

        HZtimeLabel.sd_layout
        .leftEqualToView(touImage)
        .rightEqualToView(HZName)
        .topSpaceToView(HZName,5)
        .heightIs(20);

        content.sd_layout
        .leftEqualToView(HZLogo)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(HZLogo,10)
        .heightIs(20);

        friendview.sd_layout
        .topSpaceToView(_content,10)
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(0);
        
        
        
        lineview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(friendview, 10)
        .heightIs(0);

        dibuview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(lineview, 0)
        .heightIs(40);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(dibuview, 0)
        .heightIs(10);
    }
    return self;
}

- (void)setFriendModel:(RSFriendModel *)friendModel{
    _friendModel = friendModel;
    _HZLogo.layer.cornerRadius = 4;
    _HZLogo.layer.masksToBounds = YES;
    _HZLogo.layer.borderColor = [UIColor colorWithHexColorStr:@"#f0f0f0"].CGColor;
    _HZLogo.layer.borderWidth = 1;
    [_HZLogo sd_setImageWithURL:[NSURL URLWithString:friendModel.HZLogo] placeholderImage:[UIImage imageNamed:@"512"]];
    _HZLogo.contentMode = UIViewContentModeScaleAspectFill;
    if ([friendModel.userType isEqualToString:@"hxhz"]) {
        _touImage.image = [UIImage imageNamed:@"vip"];
        _touImage.sd_layout
        .widthIs(20);
    }else{
        _touImage.image = [UIImage imageNamed:@""];
        _touImage.sd_layout
        .widthIs(0);
    }
    NSString * str = friendModel.create_time;
    NSRange range = [str rangeOfString:@"."];
    str = [str substringToIndex:range.location];
    _HZtimeLabel.text = [NSString stringWithFormat:@"%@发布",str];
    _HZtimeLabel.textColor = [UIColor darkGrayColor];
    _HZName.text = friendModel.HZName;
    NSString *string;
    string = [self delSpaceAndNewline:friendModel.content];
    _content.text = string;
    [RSGetPhoneNumberTool getPhoneNumberToolString:string andContent:_content];
    
    _content.sd_layout
    .autoHeightRatio(0);
    //这边要判断是图片还是视频的地方，视频还要判断是横的还是竖的
    if ([_friendModel.viewType isEqualToString:@"picture"]) {
        
        //图片
        if (friendModel.photos == nil|| friendModel.photos.count < 1) {
            [_friendview removeFromSuperview];
            lineview.sd_layout
            .topSpaceToView(_content, 10);
            _friendview.sd_resetLayout
            .leftSpaceToView(self.contentView, 12)
            .topSpaceToView(_content, 10);
            [self setupAutoHeightWithBottomView:_bottomview bottomMargin:0];
        }else {
            [self.contentView addSubview:_friendview];
            for (UIView *view in _friendview.subviews) {
                [view removeFromSuperview];
            }
            lineview.sd_layout
            .topSpaceToView(_friendview, 10);


            _friendview.sd_resetLayout
            .leftSpaceToView(self.contentView, 12)
            .rightSpaceToView(self.contentView, 12)
            .topSpaceToView(_content, 10)
            .autoHeightRatio(0);
            _friendview.imageArray = friendModel.photos;
            [_friendview addImageArrayAndVideoImageArray:friendModel.photos andFriendModel:friendModel];
            [self setupAutoHeightWithBottomView:_bottomview bottomMargin:0];
        }
    }else{
        //视频
        [self.contentView addSubview:_friendview];
        for (UIView *view in _friendview.subviews) {
            [view removeFromSuperview];
        }
        
        
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:friendModel.cover]];
//        UIImage * image = [UIImage imageWithData:data];
        
        
        
        _friendview.tag = friendModel.index;
        NSMutableArray * videoImageArray = [NSMutableArray array];
        [videoImageArray addObject:friendModel.cover];
        [_friendview addImageArrayAndVideoImageArray:videoImageArray andFriendModel:friendModel];
        _friendview.delegate = self;
        
        if (iPhone4 || iPhone5) {
            
            _friendview.sd_resetLayout
            .topSpaceToView(_content, 10)
            .leftSpaceToView(self.contentView, 12)
            .widthIs(SCW - 24)
            .heightIs(200);
            
        }else{
            
            
            /**
            
             coverHeight = 450;
             coverWidth = 253;
            */
            if (_friendModel.coverWidth > SCW - 24) {
                if (_friendModel.coverHeight > 200) {
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self.contentView, 12)
                    .widthIs((200/_friendModel.coverHeight) * _friendModel.coverWidth)
                    .heightIs(200);
                }else{
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self.contentView, 12)
                    .widthIs(SCW - 24)
                    .heightIs(_friendModel.coverHeight);
                }
            }else{
         
                if (_friendModel.coverHeight > 200) {
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self.contentView, 12)
                    .widthIs((200/_friendModel.coverHeight) * _friendModel.coverWidth)
                    .heightIs(200);
                }else{
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self.contentView, 12)
                    .widthIs(_friendModel.coverWidth)
                    .heightIs(_friendModel.coverHeight);
                }
            }
        }
        
       

            lineview.sd_layout
            .topSpaceToView(_friendview, 10);
            [self setupAutoHeightWithBottomView:_bottomview bottomMargin:0];
        }
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber{
    if (label.enabledTextCheckingTypes == NSTextCheckingTypeLink) {
    }else{
        NSMutableString *  phoneMutableStr = [[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneMutableStr]];
    }

}

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (void)choiceVideoIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(showVideoPlayIndex:)]) {
        [self.delegate showVideoPlayIndex:index];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
