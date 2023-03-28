//
//  TSVideoPlayback.m
//  avplayer
//
//  Created by Feng on 2018/7/1.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import "TSVideoPlayback.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"


@interface TSVideoPlayback ()<UIScrollViewDelegate>
{

    NSInteger imgIndex;
}


@property (nonatomic,strong) UIScrollView * scrolView;
@property (nonatomic,strong) UILabel *indexLab;//当前播放页数
@property (nonatomic,strong) UIButton *playBtn;//播放按钮
@property (nonatomic,strong) UIButton *videoBtn;//切换到视频
@property (nonatomic,strong) UIButton *imgBtn;//切换到图片
@property (nonatomic,strong) NSArray *dataArray;




@property (nonatomic, strong) SJVideoPlayer * player;

@end

@implementation TSVideoPlayback

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialControlUnit];
        }
    return self;
}

-(void)setWithIsVideo:(TSDETAILTYPE)type andDataArray:(NSArray *)array
{
    self.dataArray = array;
    self.scrolView.contentSize = CGSizeMake(self.dataArray.count*self.frame.size.width, self.frame.size.height);
    self.type = type;
    
    if (type == TSDETAILTYPEVIDEO) {
        [self.playBtn setHidden:NO];
        [self.videoBtn setHidden:NO];
        [self.imgBtn setHidden:NO];
    }else{
        [self.playBtn setHidden:YES];
        [self.videoBtn setHidden:YES];
        [self.imgBtn setHidden:YES];
    }
    for (int i = 0; i < _dataArray.count; i ++) {
        if (type == TSDETAILTYPEVIDEO) {
            if (i == 0) {
                
                NSURL *url = [NSURL URLWithString:self.dataArray[0]];
                _player = [SJVideoPlayer lightweightPlayer];
                _player.view.frame = CGRectMake(i*self.frame.size.width, 0, self.bounds.size.width, self.bounds.size.height);
                [self.scrolView addSubview:_player.view];

                _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithTitle:@"视频" URL:url playModel:[SJPlayModel new]];
                _player.URLAsset.title = @"视频";
                _player.view.userInteractionEnabled = NO;
                
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
            }
            else{
                UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
                img.userInteractionEnabled = YES;
                [img sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]] placeholderImage:[UIImage imageNamed:@"512"]];
                
                [self.scrolView addSubview:img];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapClick:)];
                [img addGestureRecognizer:tap];
                
            }
            
            if (_dataArray.count > 1) {
                self.indexLab.text = [NSString stringWithFormat:@"%d/%d",1,(int)self.dataArray.count - 1];
                self.indexLab.hidden = YES;
                self.videoBtn.selected = YES;
                self.imgBtn.selected = NO;
            }
            
        }else{//全图片
            UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [img sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]] placeholderImage:[UIImage imageNamed:@"512"]];
            img.userInteractionEnabled = YES;
            [self.scrolView addSubview:img];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapClick:)];
            [img addGestureRecognizer:tap];
            self.indexLab.text = [NSString stringWithFormat:@"%d/%d",1,(int)self.dataArray.count];
            self.indexLab.hidden = NO;
            self.videoBtn.selected = YES;
            self.imgBtn.selected = YES;
        }
    }
}

/** 视频播放结束 */
- (void)videoPlayEnd:(NSNotification *)notic
{
    if (!self.player) {
        return;
    }
    [self.playBtn setSelected:NO];
    [self.playBtn setHidden:NO];
    self.videoBtn.hidden = NO;
    self.imgBtn.hidden = NO;
    self.scrolView.scrollEnabled = YES;
    self.player.view.userInteractionEnabled = NO;
}







-(void)clearCache
{
//    [self.playerLayer removeFromSuperlayer];
//    self.playerLayer = nil;
//    self.myPlayer = nil;
//    [self.myPlayer replaceCurrentItemWithPlayerItem:nil];
}

#pragma mark - action
-(void)playClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
        if (btn.selected) {
                [self.player play];
                btn.hidden = YES;
            self.imgBtn.hidden = NO;
            self.videoBtn.hidden = NO;
            
            self.scrolView.scrollEnabled = NO;
            
        }else{
            
           
            [self.player pause];
            
            btn.hidden = NO;
            self.scrolView.scrollEnabled = YES;
            
            self.imgBtn.hidden = NO;
            self.videoBtn.hidden = NO;
        }
    
    _player.view.userInteractionEnabled = YES;

}




- (void)changeBtnClick:(UIButton *)btn{
    if (btn.tag == 1) {
        self.videoBtn.selected = YES;
        self.imgBtn.selected = NO;
        
        
        
        if (self.scrolView.scrollEnabled == NO) {
            
            [self.player pause];
            self.playBtn.selected = NO;
            self.playBtn.hidden = NO;
            self.player.view.userInteractionEnabled = YES;
            
        }else{
            
            [self.player pause];
            self.playBtn.selected = NO;
            self.playBtn.hidden = NO;
            self.player.view.userInteractionEnabled = NO;
        }
        [self.videoBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
        [self.imgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        if ([self.scrolView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [self.scrolView setContentOffset:CGPointMake(0, 0) animated:NO];
            [self scrollViewDidEndDecelerating:self.scrolView];
        }
    }
    else{
        if (self.dataArray.count < 2) {
            return;
        }
        self.videoBtn.selected = NO;
        self.imgBtn.selected = YES;
        if (self.scrolView.scrollEnabled == NO) {
            [self.player pause];
            self.playBtn.selected = NO;
            self.playBtn.hidden = NO;
            self.player.view.userInteractionEnabled = YES;
        }else{
            [self.player pause];
            self.playBtn.selected = NO;
            self.playBtn.hidden = NO;
            self.player.view.userInteractionEnabled = NO;
        }
        [self.videoBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [self.imgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
        
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            if ([self.scrolView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
                [self.scrolView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
                [self scrollViewDidEndDecelerating:self.scrolView];
            }
        }
    }
    return;
}

-(void)imgTapClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(videoView:didSelectItemAtIndexPath:andTap:)]) {
        if (self.type == TSDETAILTYPEVIDEO) {
            [self.delegate videoView:self didSelectItemAtIndexPath:imgIndex andTap:tap];
        }else{
            [self.delegate videoView:self didSelectItemAtIndexPath:imgIndex+1 andTap:tap];
        }
    }
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.bounds.size.width;
    imgIndex = index;
    if (self.type == TSDETAILTYPEVIDEO) {
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            self.indexLab.hidden = YES;
            [self.playBtn setHidden:NO];
        }
        else{
            self.indexLab.hidden = NO;
            [self.playBtn setHidden:YES];
        }
        
        if (self.scrolView.scrollEnabled == NO) {
            
           
            self.player.view.userInteractionEnabled = YES;
            
        }else{
            
            self.player.view.userInteractionEnabled = NO;
        }
        self.indexLab.text = [NSString stringWithFormat:@"%d/%d",(int)index,(int)self.dataArray.count - 1];
    }else{
//        self.toolView.hidden = YES;
       // isCliakVIew = false;
        self.indexLab.hidden = NO;
        self.indexLab.text = [NSString stringWithFormat:@"%d/%d",(int)index+1,(int)self.dataArray.count];
        
        if (self.scrolView.scrollEnabled == NO) {
            self.player.view.userInteractionEnabled = YES;
        }else{
            self.player.view.userInteractionEnabled = NO;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.type == TSDETAILTYPEVIDEO) {
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            self.videoBtn.selected = YES;
            self.imgBtn.selected = NO;
            
            [self.player pause];
            self.playBtn.hidden = NO;
            self.playBtn.selected = NO;
           
            [self.videoBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
            [self.imgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            
            
        } else{
            
            self.videoBtn.selected = NO;
            self.imgBtn.selected = YES;
           
            
            
            
            [self.player pause];
            self.playBtn.hidden = YES;
            self.playBtn.selected = NO;

            
            [self.videoBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [self.imgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
            
        }
    }else{
        return;
    }
    
}

-(void)initialControlUnit
{
//    isEndPlay = NO;
    _scrolView = [[UIScrollView alloc]init];
    _scrolView.pagingEnabled  = YES;
    _scrolView.delegate = self;
    _scrolView.showsVerticalScrollIndicator = NO;
    _scrolView.showsHorizontalScrollIndicator = NO;
    _scrolView.userInteractionEnabled = YES;
    [self addSubview:_scrolView];
    self.scrolView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
   // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playShowAndHidden)];
    //[self.scrolView addGestureRecognizer:tap];
    
    self.placeholderImg = [[UIImageView alloc]init];
    self.placeholderImg.image = [UIImage imageNamed:@"icon_play"];
    self.placeholderImg.contentMode = UIViewContentModeScaleAspectFill;
    self.placeholderImg.userInteractionEnabled = YES;
    self.placeholderImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.scrolView addSubview:self.placeholderImg];
    
    _playBtn = [[UIButton alloc]init];
    _playBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_playBtn setImage:[UIImage imageNamed:@"商店播放"] forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateSelected];
   // [_playBtn setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateSelected];
    [self addSubview:_playBtn];
    self.playBtn.frame = CGRectMake((self.frame.size.width - 60)/2.0, (self.frame.size.height - 60)/2.0, 60, 60);
    
    _indexLab = [[UILabel alloc]init];
    _indexLab.textColor = [UIColor whiteColor];
    _indexLab.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    _indexLab.font = [UIFont systemFontOfSize:11];
    _indexLab.textAlignment = 1;
    _indexLab.layer.cornerRadius = 24/2;
    _indexLab.layer.masksToBounds = YES;
    [self.indexLab setHidden:YES];
    [self addSubview:self.indexLab];
    self.indexLab.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 45, 50, 24);
    
    _videoBtn = [[UIButton alloc]init];
    [_videoBtn setTitle:@"视频" forState:UIControlStateNormal];
    [_videoBtn setImage:[UIImage imageNamed:@"右三角 向右 面性"] forState:UIControlStateNormal];
    [_videoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateSelected];
    [_videoBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
    _videoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_videoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    
    _videoBtn.layer.cornerRadius = 24/2;
    _videoBtn.layer.masksToBounds = YES;
    self.videoBtn.tag = 1;
    [self addSubview:_videoBtn];
    self.videoBtn.frame = CGRectMake(self.center.x - 70, self.frame.size.height - 45, 60, 24);
    
    _imgBtn = [[UIButton alloc]init];
    [_imgBtn setTitle:@"图片" forState:UIControlStateNormal];
    
    [_imgBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [_imgBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateSelected];
    //_imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    [_imgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    
    _imgBtn.titleLabel.font = [UIFont systemFontOfSize:13];
  
    _imgBtn.layer.cornerRadius = 24/2;
    _imgBtn.layer.masksToBounds = YES;
    self.imgBtn.tag = 2;
    [self addSubview:_imgBtn];
    self.imgBtn.frame = CGRectMake(self.center.x + 10, self.frame.size.height - 45, 60, 24);
    
    
    [self.videoBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imgBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
}





//#pragma mark - 定时器操作
//- (void)addProgressTimer
//{
//    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
//}
//
//#pragma mark -- 移除定时器
//- (void)removeProgressTimer
//{
//    [self.progressTimer invalidate];
//    self.progressTimer = nil;
//}
//
//
//#pragma mark -- 更新时间
//- (void)updateProgressInfo
//{
//    // 1.更新时间
//    self.beginTimeLabel.text = [self timeString];
//    self.progressSlider.value = CMTimeGetSeconds(self.myPlayer.currentTime) / CMTimeGetSeconds(self.myPlayer.currentItem.duration);
//}


//- (NSString *)timeString
//{
//    NSTimeInterval duration = CMTimeGetSeconds(self.myPlayer.currentItem.duration);
//    NSTimeInterval currentTime = CMTimeGetSeconds(self.myPlayer.currentTime);
//    return [self stringWithCurrentTime:currentTime duration:duration];
//}






//- (void)addShowTimer
//{
//    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateShowTime) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.showTimer forMode:NSRunLoopCommonModes];
//}
//
//- (void)removeShowTimer
//{
//    [self.showTimer invalidate];
//    self.showTimer = nil;
//}
//
//- (void)updateShowTime
//{
//    self.showTime += 1;
//
//    if (self.showTime > 2.0) {
//        [self tapAction:nil];
//        [self removeShowTimer];
//
//        self.showTime = 0;
//    }
//}

//- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration
//{
//    NSInteger dMin = duration / 60;
//    NSInteger dSec = (NSInteger)duration % 60;
//
//    NSInteger cMin = currentTime / 60;
//    NSInteger cSec = (NSInteger)currentTime % 60;
//
//    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", dMin, dSec];
//    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", cMin, cSec];
//
//    /**自动播放完成之后自动移除*/
//    if (currentString == durationString) {
//        self.videoBtn.hidden = NO;
//        self.imgBtn.hidden = NO;
//        [self.playBtn setImage:[UIImage imageNamed:@"商店播放"] forState:UIControlStateNormal];
//        //[self removeProgressTimer];
//    }
//   // return [NSString stringWithFormat:@"%@/%@", currentString, durationString];
//    return [NSString stringWithFormat:@"%@", currentString];
//}


//跳转大播放器
- (void)openViewController:(UIButton *)bigScreenBtn{
    NSURL *url = [NSURL URLWithString:self.dataArray[0]];
    _player = [SJVideoPlayer lightweightPlayer];
    _player.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:_player.view];
    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithTitle:@"视频" URL:url playModel:[SJPlayModel new]];
    _player.URLAsset.title = @"视频";
//    _player.URLAsset.alwaysShowTitle = YES;
//    _player.disableAutoRotation = NO;
}


@end
