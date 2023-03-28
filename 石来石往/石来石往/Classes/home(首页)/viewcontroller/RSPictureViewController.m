//
//  RSPictureViewController.m
//  石来石往
//
//  Created by mac on 17/6/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPictureViewController.h"
#define PHOTONUMBERS 1
@interface RSPictureViewController (){
    
    UIView * _navigationview;
}


@property (nonatomic,strong)UIImageView * imageview;

@end

@implementation RSPictureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
    self.title = self.titleStr;
    offset = 0.0;
    //self.title = @"测试";
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCH/2/2, SCW, SCH/2)];
    self.imageScrollView.backgroundColor = [UIColor clearColor];
    self.imageScrollView.scrollEnabled = YES;
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.delegate = self;
    UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    UIScrollView *s = [[UIScrollView alloc] initWithFrame:self.imageScrollView.bounds];
        s.backgroundColor = [UIColor clearColor];
        s.contentSize = CGSizeMake(320, 460);
        s.delegate = self;
        s.minimumZoomScale = 1.0;
        s.maximumZoomScale = 3.0;
        //        s.tag = i+1;
        [s setZoomScale:1.0];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageScrollView.bounds.size.width, self.imageScrollView.bounds.size.height)];
    if ([self.mtypeStr isEqualToString:@"0"]) {
        imageview.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"img_map_block@2x" ofType:@".png"]];
//        imageview.image = [UIImage imageNamed:@"img_map_block@2x"];
    }else{
        imageview.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"img_map_plate@2x" ofType:@".png"]];
//        imageview.image = [UIImage imageNamed:@"img_map_plate@2x"];
    }
    imageview.userInteractionEnabled = YES;
    [imageview addGestureRecognizer:doubleTap];
    [s addSubview:imageview];
    [self.imageScrollView addSubview:s];
    [self.view addSubview:self.imageScrollView];
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.imageScrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){
        }
        else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                }
            }
        }
    }
}

#pragma mark -
-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
}

#pragma mark - Utility methods
- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
