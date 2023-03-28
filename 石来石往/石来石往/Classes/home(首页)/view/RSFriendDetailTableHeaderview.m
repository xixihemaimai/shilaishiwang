//
//  RSFriendDetailTableHeaderview.m
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFriendDetailTableHeaderview.h"
// #define PHONEREGULAR @"\\d{3,4}[- ]?\\d{7,8}"
#import "RSGetPhoneNumberTool.h"

@interface RSFriendDetailTableHeaderview ()<TTTAttributedLabelDelegate,RSFriendViewDelegate>



@end


@implementation RSFriendDetailTableHeaderview

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        
        
        
        [self setTablevieHeaderViewUI];
        
        
        
        
    }
    return self;
    
}


- (void)setTablevieHeaderViewUI{
    
    
    UIImageView * HZLogo = [[UIImageView alloc]init];
    _HZLogo = HZLogo;
    [self addSubview:HZLogo];
    
    
    //给货主头像框
    UIImageView * touImage = [[UIImageView alloc]init];
    touImage.image = [UIImage imageNamed:@"货主头像框"];
    [self addSubview:touImage];
    _touImage = touImage;
    
    
    
    
    
    
    
    
    //朋友圈的名字
    UILabel * HZName = [[UILabel alloc]init];
    _HZName = HZName;
    HZName.textColor = [UIColor colorWithHexColorStr:@"#7683a4"];
    HZName.textAlignment = NSTextAlignmentLeft;
    HZName.font = [UIFont systemFontOfSize:16];
    [self addSubview:HZName];
    
    
    
    //关注的按键
    UIButton * followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    followBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [followBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
    [followBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
    [followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [followBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCFCFC"]];
    followBtn.layer.cornerRadius = 2;
    followBtn.layer.borderWidth = 1;
    followBtn.imageEdgeInsets = UIEdgeInsetsMake(9, 5, 9, 5);

    followBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    followBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
    followBtn.layer.masksToBounds = YES;
    [self addSubview:followBtn];
    _followBtn = followBtn;
    
    
    
    
    //朋友圈的时间
    UILabel * HZtimeLabel = [[UILabel alloc]init];
    HZtimeLabel.textColor = [UIColor colorWithHexColorStr:@"#7683a4"];
    HZtimeLabel.textAlignment = NSTextAlignmentLeft;
    HZtimeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:HZtimeLabel];
    _HZtimeLabel = HZtimeLabel;
    
    
    
    
    //朋友圈的内容
    TTTAttributedLabel * content = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    
    content.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    content.numberOfLines = 0;
    content.delegate = self;
    content.enabledTextCheckingTypes = NSTextCheckingAllTypes;
    content.font =[UIFont systemFontOfSize:16];
    [self addSubview:content];
    _content = content;
    

    
    RSFriendView *friendview =[[RSFriendView alloc]init];
    friendview.backgroundColor = [UIColor whiteColor];
    _friendview = friendview;
    [self addSubview:friendview];
    
    
    
    HZLogo.sd_layout
    .leftSpaceToView(self,12)
    .topSpaceToView(self,21)
    .widthIs(38)
    .heightIs(38);
    
    touImage.sd_layout
    .leftSpaceToView(HZLogo,12)
    .topEqualToView(HZLogo)
    .widthIs(20)
    .heightIs(20);
    
    followBtn.sd_layout
    .rightSpaceToView(self, 12)
    .topEqualToView(HZLogo)
    .widthIs(60)
    .heightIs(30);
    
    HZName.sd_layout
    .leftSpaceToView(touImage,5)
    .rightSpaceToView(followBtn,12)
    //.rightSpaceToView(self, 12)
    .topEqualToView(HZLogo)
    .heightIs(20);
    
    HZtimeLabel.sd_layout
    .leftEqualToView(touImage)
    .rightEqualToView(HZName)
    .topSpaceToView(HZName,5)
    .heightIs(20);
    
    content.sd_layout
    .leftEqualToView(HZLogo)
    .rightSpaceToView(self, 12)
    .topSpaceToView(HZLogo,10)
    .heightIs(20);
    
    friendview.sd_layout
    .topSpaceToView(content,10)
    .leftEqualToView(content)
    //.rightEqualToView(content)
    .heightIs(0);
}

- (void)setFriendmodel:(RSFriendModel *)friendmodel{
    _friendmodel = friendmodel;
    _HZLogo.layer.cornerRadius = 4;
    _HZLogo.layer.masksToBounds = YES;
    _HZLogo.layer.borderColor = [UIColor colorWithHexColorStr:@"#f0f0f0"].CGColor;
    _HZLogo.layer.borderWidth = 1;
    if ([friendmodel.userType isEqualToString:@"hxhz"]) {
        _touImage.image = [UIImage imageNamed:@"vip"];
        _touImage.sd_layout
        .widthIs(20);
    }else{
        _touImage.image = [UIImage imageNamed:@""];
        _touImage.sd_layout
        .widthIs(0);
    }
    [_HZLogo sd_setImageWithURL:[NSURL URLWithString:friendmodel.HZLogo] placeholderImage:[UIImage imageNamed:@"512"]];
    _HZLogo.contentMode = UIViewContentModeScaleAspectFill;
    //_HZtimeLabel.text = [NSString stringWithFormat:@"%@",friendmodel.create_time];
    NSString * str = friendmodel.create_time;
    NSRange range = [str rangeOfString:@"."];
    str = [str substringToIndex:range.location];
    _HZtimeLabel.text = [NSString stringWithFormat:@"%@发布",str];
    _HZName.text = friendmodel.HZName;
    //这边是对于关注的按键状态的判断
    NSString *string;
    string = [self delSpaceAndNewline:friendmodel.content];
    _content.text = string;
    [RSGetPhoneNumberTool getPhoneNumberToolString:string andContent:_content];
    _content.sd_layout
    .autoHeightRatio(0);
    //这边要判断是图片还是视频的地方，视频还要判断是横的还是竖的
    if ([_friendmodel.viewType isEqualToString:@"picture"]) {
        //图片
        _friendview.sd_layout
        .rightEqualToView(_content);
        if (friendmodel.photos == nil|| friendmodel.photos.count < 1) {
            [_friendview removeFromSuperview];
            [self setupAutoHeightWithBottomView:_content bottomMargin:5];
        }
        else {
            _friendview.sd_layout
            .topSpaceToView(_content,10);
            _friendview.imageArray = friendmodel.photos;
            [_friendview addImageArrayAndVideoImageArray:friendmodel.photos andFriendModel:friendmodel];
            [self setupAutoHeightWithBottomView:_friendview bottomMargin:5];
        }
    }else{
        //视频
        [self addSubview:_friendview];
        for (UIView *view in _friendview.subviews) {
            [view removeFromSuperview];
        }
        _friendview.tag = _friendmodel.index;
        //_friendview.videoImageUrl = _friendmodel.cover;
        
        NSMutableArray * videoImageArray = [NSMutableArray array];
        [videoImageArray addObject:friendmodel.cover];
        [_friendview addImageArrayAndVideoImageArray:videoImageArray andFriendModel:friendmodel];
        
        _friendview.delegate = self;
        
        if (iPhone4 || iPhone5) {
            
            _friendview.sd_resetLayout
            .topSpaceToView(_content, 10)
            .leftSpaceToView(self, 12)
            .widthIs(SCW - 24)
            .heightIs(200);
            
        }else{
            
            if (_friendmodel.coverWidth > SCW - 24) {
                
                if (_friendmodel.coverHeight > 200 ) {
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self, 12)
                    .widthIs((200/_friendmodel.coverHeight) * _friendmodel.coverWidth)
                    .heightIs(200);
                }else{
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self, 12)
                    .widthIs(SCW - 24)
                    .heightIs(_friendmodel.coverHeight);
                }
            }else{
                if (_friendmodel.coverHeight > 200) {
                    
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self, 12)
                    .widthIs((200/_friendmodel.coverHeight) * _friendmodel.coverWidth)
                    .heightIs(200);
                }else{
                    _friendview.sd_resetLayout
                    .topSpaceToView(_content, 10)
                    .leftSpaceToView(self, 12)
                    .widthIs(_friendmodel.coverWidth)
                    .heightIs(_friendmodel.coverHeight);
                }
                
            }
        }
        
        
        
        [self setupAutoHeightWithBottomView:_friendview bottomMargin:0];
    }
}

- (void)choiceVideoIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(showFriendHeaderVideoIndex:)]) {
        [self.delegate showFriendHeaderVideoIndex:index];
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
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
