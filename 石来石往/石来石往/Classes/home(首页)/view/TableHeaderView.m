//
//  TableHeaderView.m
//  SJVideoPlayerProject
//
//  Created by BlueDancer on 2018/2/27.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "TableHeaderView.h"

#import <Masonry.h>

@interface TableHeaderView ()<TTTAttributedLabelDelegate>



@end

@implementation TableHeaderView

@synthesize playBtn = _playBtn;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _setupViews];
    return self;
}

- (void)_setupViews {
    
    
    
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
    content.font =[UIFont systemFontOfSize:16];
    [self addSubview:content];
    _content = content;
    
    
    
//    [self.HZLogo mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self).offset(12);
//        make.top.equalTo(self).offset(21);
//        make.width.mas_equalTo(38);
//        make.height.mas_equalTo(38);
//    }];
//
//    [self.touImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.HZLogo.mas_right).offset(12);
//        make.top.equalTo(self.HZLogo.mas_top);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(20);
//    }];
//
//
//    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(self.mas_right).offset(12);
//        make.top.mas_equalTo(self.HZLogo.mas_top);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(30);
//    }];
//
//    [self.HZName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.touImage.mas_right).offset(5);
//        make.right.mas_equalTo(self.followBtn.mas_left).offset(12);
//        make.top.mas_equalTo(HZLogo.mas_top);
//        make.height.mas_equalTo(20);
//    }];
//
//    [self.HZtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(self.touImage.mas_right);
//        make.right.mas_equalTo(self.HZName.mas_left);
//        make.top.mas_equalTo(HZName.mas_bottom).offset(5);
//        make.height.mas_equalTo(20);
//    }];
//
//    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.HZLogo.mas_right);
//        make.right.mas_equalTo(self).offset(12);
//        make.top.mas_equalTo(self.HZLogo.mas_bottom).offset(10);
//        make.height.mas_equalTo(20);
//    }];
    
    
    
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
    
    
    
    
    //这边添加一个view的界面
    UIImageView * playView = [[UIImageView alloc]init];
    playView.image = [UIImage imageNamed:@"cover2"];
    [self addSubview:playView];
    _playView = playView;
    
//    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self);
//        make.right.mas_equalTo(self);
//        make.top.mas_equalTo(self.content.mas_bottom).offset(0);
//        make.bottom.mas_equalTo(self);
//    }];
//
    
    playView.userInteractionEnabled = YES;
    playView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self.content, 0)
    .bottomSpaceToView(self, 0);
    
    
    UIButton * playBtn = [[UIButton alloc]init];
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playView addSubview:playBtn];
    _playBtn = playBtn;
    playBtn.tag = 0;
    
    playBtn.sd_layout
    .centerXEqualToView(playView)
    .centerYEqualToView(playView)
    .heightIs(50)
    .widthEqualToHeight();
    
    
 
    
    
}

//- (UIButton *)playBtn {
//    if ( _playBtn ) return _playBtn;
//    _playBtn = [SJUIButtonFactory buttonWithImageName:@"play" target:self sel:@selector(clicked:) tag:0];
//    return _playBtn;
//}
//
//- (void)clicked:(UIButton *)playBtn{
//        if ( self.clickedPlayBtn ) self.clickedPlayBtn(self);
//}

@end
