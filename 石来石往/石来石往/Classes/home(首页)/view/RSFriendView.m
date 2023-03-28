//
//  RSFriendView.m
//  石来石往
//
//  Created by mac on 17/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFriendView.h"
#import "UIImageView+WebCache.h"
#import <HUPhotoBrowser.h>


@interface RSFriendView ()


@end

@implementation RSFriendView




- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}


- (void)addImageArrayAndVideoImageArray:(NSArray *)imageArray andFriendModel:(RSFriendModel *)friendmodel{
    NSMutableArray * temp = [NSMutableArray array];
    if ([friendmodel.viewType isEqualToString:@"picture"]) {
        [temp removeAllObjects];
        for (int i = 0; i < imageArray.count; i++) {
            
            UIImageView *friendimage = [[UIImageView alloc]init];
            friendimage.contentMode =  UIViewContentModeScaleAspectFill;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
            [friendimage addGestureRecognizer:tap];
            friendimage.userInteractionEnabled = YES;
            friendimage.tag = 100+i;
            [friendimage sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:@"512"]];
            
            friendimage.clipsToBounds  = YES;
            [self addSubview:friendimage];
            [temp addObject:friendimage];
            friendimage.sd_layout
            .widthIs(100)
            .heightIs(100);
        }
        [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:3 verticalMargin:2 horizontalMargin:2 verticalEdgeInset:2 horizontalEdgeInset:2];
        
    }else{
         [temp removeAllObjects];
        for (int i = 0; i < imageArray.count; i++) {
            UIImageView * playshowImage = [[UIImageView alloc]init];
            playshowImage.backgroundColor = [UIColor whiteColor];
            playshowImage.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playNetworkVideoUrl:)];
            playshowImage.contentMode = UIViewContentModeScaleAspectFill;
            [playshowImage addGestureRecognizer:tap];
            playshowImage.clipsToBounds  = YES;
            playshowImage.tag = 100 + i;
            //播放视频的图片
            UIImageView * playImage = [[UIImageView alloc]init];
            playImage.image = [UIImage imageNamed:@"shiping"];
            playImage.backgroundColor = [UIColor clearColor];
            [playshowImage addSubview:playImage];
            //UIViewContentModeScaleAspectFit
            playImage.contentMode = UIViewContentModeScaleAspectFill;
            [playshowImage sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:@"512"]];
            
            [self addSubview:playshowImage];
            [temp addObject:playshowImage];
            playImage.clipsToBounds  = YES;

            playshowImage.sd_layout
            .leftSpaceToView(self, 0)
            .topSpaceToView(self, 0)
            .rightSpaceToView(self,0)
            .bottomSpaceToView(self, 0);

            playImage.sd_layout
            .centerXEqualToView(playshowImage)
            .centerYEqualToView(playshowImage)
            .widthIs(30)
            .heightIs(30);
        }
        [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:1 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
        
    }
}



- (void)playNetworkVideoUrl:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(choiceVideoIndex:)]) {
        [self.delegate choiceVideoIndex:self.tag];
    }
}


#pragma mark -- 点击图片进入图片浏览器
- (void)choiceImageBrowser:(UITapGestureRecognizer *)tap{
    //进入图片浏览器中（第三方框架）
        [HUPhotoBrowser showFromImageView:self.subviews[tap.view.tag-100] withURLStrings:_imageArray atIndex:tap.view.tag-100];
}

@end
