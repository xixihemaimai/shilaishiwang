//
//  MMImageListView.m
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MMImageListView.h"
#import "MMImagePreviewView.h"



#pragma mark - ------------------ 小图List显示视图 ------------------

@interface MMImageListView ()<XLPhotoBrowserDatasource>

// 预览视图
//@property (nonatomic, strong) MMImagePreviewView *previewView;

//@property (nonatomic,strong)NSMutableArray * tempImageArray;

@end

@implementation MMImageListView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        // 小图(九宫格)
//        _imageViewsArray = [[NSMutableArray alloc] init];
//        for (int i = 0; i < 9; i++) {
//            MMImageView *imageView = [[MMImageView alloc] initWithFrame:CGRectZero];
//            imageView.tag = 1000 + i;
////            [imageView setTapSmallView:^(MMImageView *imageView){
////                [self singleTapSmallViewCallback:imageView];
////            }];
//            [_imageViewsArray addObject:imageView];
//            [self addSubview:imageView];
//        }
//        // 预览视图
//        _previewView = [[MMImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

#pragma mark - Setter
- (void)setMoment:(Moment *)moment
{
    _moment = moment;
//    for (MMImageView *imageView in _imageViewsArray) {
//        imageView.hidden = YES;
//    }
    CGSize singleSize = CGSizeZero;
    if ([moment.viewType isEqualToString:@"picture"]) {
        // 图片区
        NSInteger count = moment.photos.count;
//        _tempImageArray = [NSMutableArray array];
        if (count == 0) {
            self.size = CGSizeZero;
            return;
        }
        // 更新视图数据
//        _previewView.pageNum = count;
//        _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
        // 添加图片
        
        for (NSInteger i = 0; i < count; i++)
        {
            if (i > 8) {
                break;
            }
            NSInteger rowNum = i/3;
            NSInteger colNum = i%3;
            if(count == 4) {
                rowNum = i/2;
                colNum = i%2;
            }
            
            CGFloat imageX = colNum * (Width_Real(111) + Width_Real(6));
            CGFloat imageY = rowNum * (Width_Real(111) + Width_Real(6));
            CGRect frame = CGRectMake(imageX, imageY, Width_Real(111), Width_Real(111));
            
            //单张图片需计算实际显示size
            if (count == 1) {
                 singleSize = [Utility getSingleSize:CGSizeMake(SCW/2, SCW * 0.75)];
                frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
            }
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.tag = 1000+i;
            imageView.hidden = NO;
            imageView.frame = frame;
            imageView.layer.cornerRadius = 5;
            imageView.layer.masksToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
//            imageView.clipsToBounds=YES;
           // imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"moment_pic_%d",(int)i]];
//            NSMutableArray * array = [NSMutableArray array];
//            for (int i = 0; i <moment.photos.count; i++) {
                //aaaaa.png -> aaaaa_mini.jpg
                NSString * str =moment.photos[i];
//                if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
//                    str = [str substringToIndex:str.length - 5];
//                    str = [str stringByAppendingString:@"_mini.jpg"];
//                }else{
//                    str = [str substringToIndex:str.length - 4];
//                    str = [str stringByAppendingString:@"_mini.jpg"];
//                }
//                [array addObject:str];
//                imageView.image = [UIImage imageNamed:moment.photos[i]];
            NSURL * url = [NSURL URLWithString:str];
            UIImage * cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
//            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"01"]];
            [imageView sd_setImageWithURL:url placeholderImage:cacheImage?cacheImage:[UIImage imageNamed:@"01"]];
//            }
           
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageback:)];
            [imageView addGestureRecognizer:tap];
            [self addSubview:imageView];
        }
        self.width = SCW - Width_Real(32);
        if (count <= 1 && count > 0) {
            self.height = singleSize.height;
        }else if (count <= 3) {
            self.height = 2 * Width_Real(6) + Width_Real(111);
        }else if (count <= 6){
            self.height = 3 * Width_Real(6) + 2 *  Width_Real(111);
        }else{
            self.height = 4 * Width_Real(6) + 3 * Width_Real(111);
        }
    }else if([moment.viewType isEqualToString:@"video"]){
        
        UIImageView * imageView = nil;
        //视频区
//        NSInteger count = moment.;
//        if (count == 0) {
//            self.size = CGSizeZero;
//            return;
//        }
         // 更新视图数据
       // _previewView.pageNum = 1;
       // _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
        //添加视频
        for (NSInteger i = 0; i < 1; i++)
        {
            //单张图片需计算实际显示size
//            if (i == 0) {
          // CGSize singleSize = [Utility getSingleSize:CGSizeMake(moment.coverWidth, moment.coverHeight)];
            CGSize singleSize = [Utility videogetSingleSize:CGSizeMake(moment.coverWidth, moment.coverHeight)];
           CGRect frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
//            }
            imageView = [[UIImageView alloc]init];
            imageView.tag = 1000+i;
            imageView.hidden = NO;
            imageView.frame = frame;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds=YES;
            
            NSURL * url = [NSURL URLWithString:moment.cover];
            UIImage * cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"01"]];
            [imageView sd_setImageWithURL:url placeholderImage:cacheImage?cacheImage:[UIImage imageNamed:@"512"]];
            
//            [imageView sd_setImageWithURL:[NSURL URLWithString:moment.cover] placeholderImage:[UIImage imageNamed:@"512"]];
            [self addSubview:imageView];

            //播放视频的图片
            UIImageView * playImage = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.yj_centerX - 15, imageView.yj_centerY - 15, 30, 30)];
            playImage.image = [UIImage imageNamed:@"shiping"];
            playImage.backgroundColor = [UIColor clearColor];
            [imageView addSubview:playImage];
            playImage.contentMode = UIViewContentModeScaleAspectFill;
            playImage.clipsToBounds  = YES;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickback:)];
            [imageView addGestureRecognizer:tap];
        }
        self.width = kTextWidth;
        self.height = imageView.bottom;
    }
}


- (void)clickback:(UITapGestureRecognizer *)tap{
    MMImageListView * imageListView =(MMImageListView *)tap.view.superview;
    if ([self.delegate respondsToSelector:@selector(tapCurrentImageView:)]) {
        [self.delegate tapCurrentImageView:imageListView.moment];
    }
}
- (void)showImageback:(UITapGestureRecognizer *)tap{
//    CLog(@"=+++++++++++++++#2++++++++++++++++++++++++");
    if ([self.delegate respondsToSelector:@selector(tapCurrentShowImageView)]) {
        [self.delegate tapCurrentShowImageView];
    }
    [XLPhotoBrowser showPhotoBrowserWithImages:self.moment.newphotos andMiniImage:self.moment.photos currentImageIndex:tap.view.tag - 1000];
//   [XLPhotoBrowser showPhotoBrowserWithImages:self.moment.photos currentImageIndex:tap.view.tag - 1000];
}








//#pragma mark - 小图单击
//- (void)singleTapSmallViewCallback:(MMImageView *)imageView
//{
//    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
//    // 解除隐藏
//    [window addSubview:_previewView];
//    [window bringSubviewToFront:_previewView];
//    // 清空
//    [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    // 添加子视图
//    NSInteger index = imageView.tag-1000;
//    NSInteger count = _moment.fileCount;
//    CGRect convertRect;
//    if (count == 1) {
//        [_previewView.pageControl removeFromSuperview];
//    }
//    for (NSInteger i = 0; i < count; i ++)
//    {
//        // 转换Frame
//        MMImageView *pImageView = (MMImageView *)[self viewWithTag:1000+i];
//        convertRect = [[pImageView superview] convertRect:pImageView.frame toView:window];
//        // 添加
//        MMScrollView *scrollView = [[MMScrollView alloc] initWithFrame:CGRectMake(i*_previewView.width, 0, _previewView.width, _previewView.height)];
//        scrollView.tag = 100+i;
//        scrollView.maximumZoomScale = 2.0;
//        scrollView.image = pImageView.image;
//        scrollView.contentRect = convertRect;
//        // 单击
//        [scrollView setTapBigView:^(MMScrollView *scrollView){
//                [self singleTapBigViewCallback:scrollView];
//        }];
//        // 长按
//        [scrollView setLongPressBigView:^(MMScrollView *scrollView){
//            [self longPresssBigViewCallback:scrollView];
//        }];
//        [_previewView.scrollView addSubview:scrollView];
//        if (i == index) {
//            [UIView animateWithDuration:0.3 animations:^{
//                _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
//                _previewView.pageControl.hidden = NO;
//                [scrollView updateOriginRect];
//            }];
//        } else {
//            [scrollView updateOriginRect];
//        }
//    }
//    // 更新offset
//    CGPoint offset = _previewView.scrollView.contentOffset;
//    offset.x = index * SCW;
//    _previewView.scrollView.contentOffset = offset;
//}
//
//#pragma mark - 大图单击||长按
//- (void)singleTapBigViewCallback:(MMScrollView *)scrollView
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        _previewView.pageControl.hidden = YES;
//        scrollView.contentRect = scrollView.contentRect;
//        scrollView.zoomScale = 1.0;
//    } completion:^(BOOL finished) {
//        [_previewView removeFromSuperview];
//    }];
//}
//
//- (void)longPresssBigViewCallback:(MMScrollView *)scrollView
//{
//
//}

@end

//#pragma mark - ------------------ 单个小图显示视图 ------------------
//@implementation MMImageView
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        self.clipsToBounds  = YES;
//        self.contentMode = UIViewContentModeScaleAspectFill;
//        self.contentScaleFactor = [[UIScreen mainScreen] scale];
//        self.userInteractionEnabled = YES;
////        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
////        [self addGestureRecognizer:tap];
//    }
//    return self;
//}
//
//- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture
//{
//
//}

//@end
