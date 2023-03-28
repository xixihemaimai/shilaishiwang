//
//  RSDiBuView.m
//  石来石往
//
//  Created by Santorini on 2017/9/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDiBuView.h"

@implementation RSDiBuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        
        
       
    }
    return self;
}

- (void)setup
{
    
    //
    //点赞按钮
    RSSignOutButton *upvoteBtn = [[RSSignOutButton alloc]initWithFrame:CGRectMake(0, 0, SCW/3, 40)];
    _upvoteBtn = upvoteBtn;
    //   _upvoteBtn.isOnce =YES;
    upvoteBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [_upvoteBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [_upvoteBtn setBackgroundColor:[UIColor clearColor]];
    [_upvoteBtn setTitle:@"(0)" forState:UIControlStateNormal];
    [_upvoteBtn setTitle:@"(0)" forState:UIControlStateSelected];
    [_upvoteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_upvoteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#e14527"] forState:UIControlStateSelected];
    _upvoteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _upvoteBtn.particleScale = 0.05f;
    _upvoteBtn.particleScaleRange = 0.02f;
    _upvoteBtn.particleImage = [UIImage imageNamed:@"原点"];
    
    
    //评论按钮
    RSSignOutButton *commentBtn = [[RSSignOutButton alloc]initWithFrame:CGRectMake(SCW/3, 0, SCW/3, 40)];
    _commentBtn =commentBtn;
   // [_commentBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f8f8f8"]];
      [_commentBtn setBackgroundColor:[UIColor clearColor]];
    commentBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [_commentBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [_commentBtn setTitle:@"(0)" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
  
    
    //分享按钮
    RSSignOutButton *shareBtn = [[RSSignOutButton alloc]initWithFrame:CGRectMake(SCW/3*2, 0, SCW/3, 40) ];
   // [shareBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f8f8f8"]];
    
     [_shareBtn setBackgroundColor:[UIColor clearColor]];
    _shareBtn =shareBtn;
    [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];

  //  UIView*zhong =[[UIView alloc]initWithFrame:CGRectMake(SCW/2-0.5,20, 1, 20)];
    //zhong.backgroundColor=[UIColor groupTableViewBackgroundColor];
    //UIView *dibuline=[[UIView alloc]initWithFrame:CGRectMake(0, 50, SCW, 1)];
    //dibuline.backgroundColor=[UIColor redColor];
//[UIColor groupTableViewBackgroundColor]
    //dibuline
    [self sd_addSubviews:@[_commentBtn,_upvoteBtn,_shareBtn]];
    [self setupAutoHeightWithBottomView:_commentBtn bottomMargin:0];
    
    
}
@end
