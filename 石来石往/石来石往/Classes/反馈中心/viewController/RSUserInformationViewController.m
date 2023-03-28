//
//  RSUserInformationViewController.m
//  石来石往
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSUserInformationViewController.h"

/**显示进度条*/
#import "RSViewProgressLine.h"


@interface RSUserInformationViewController ()<WKNavigationDelegate,UINavigationControllerDelegate>



@property (nonatomic,strong)RSViewProgressLine * progressLineview;

@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)WKWebView * webView;


@end

@implementation RSUserInformationViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.allowRotation = true;
//    [self setNewOrientation:NO];
    
    if ([[[UIDevice currentDevice]systemVersion]intValue ] >= 9.0) {
        NSArray * types =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]; // 9.0之后才有的
        NSSet *websiteDataTypes = [NSSet setWithArray:types];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
        }];
    }else{
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSLog(@"%@", cookiesFolderPath);
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        
    }
    
    //self.navigationItem.leftBarButtonItem.customView.hidden = YES;
//    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 50, 50);
//    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(outH5WebviewAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.htmlView = [[UIView alloc]init];
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    self.progressLineview = [[RSViewProgressLine alloc] init];
    self.progressLineview.lineColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    [self.htmlView addSubview:self.progressLineview];
    
    
    //WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height) configuration:config];
    
    WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height) ];
    _webView = webview;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = YES;
    //@"http://192.168.1.191:8080/"
    //http://192.168.1.152:8888/slsw/pwms/reportList.html
    NSString * stoneUrlStr = [NSString string];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        stoneUrlStr = [self.urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
    }else{
        stoneUrlStr= [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    NSURL * urlStr = [[NSURL alloc]initWithString:stoneUrlStr];
    NSMutableURLRequest *requst = [[NSMutableURLRequest alloc]initWithURL:urlStr];
    [_webView loadRequest:requst];
    [self.htmlView addSubview:webview];
    self.htmlView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0);
    self.progressLineview.sd_layout
    .leftSpaceToView(self.htmlView, 0)
    .rightSpaceToView(self.htmlView, 0)
    .topSpaceToView(self.htmlView, 0)
    .heightIs(1);
    self.webView.sd_layout
    .leftSpaceToView(self.htmlView, 0)
    .rightSpaceToView(self.htmlView, 0)
    .topSpaceToView(self.progressLineview, 0)
    .bottomSpaceToView(self.htmlView, 0);
    
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview startLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}

//- (void)setNewOrientation:(BOOL)fullscreen{
//    if (fullscreen) {
//        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
//        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//
//    }else{
//        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
//        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
//        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//    }
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAll;  //支持横向
//}

//设置为允许旋转
//- (BOOL) shouldAutorotate {
//    return no;
//}

//-(void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
//    UIDevice *device = [UIDevice currentDevice] ;
//    switch (device.orientation) {
//        case UIDeviceOrientationFaceUp:
//            //NSLog(@"屏幕朝上平躺");
//            break;
//        case UIDeviceOrientationFaceDown:
//            //NSLog(@"屏幕朝下平躺");
//            break;
//        case UIDeviceOrientationUnknown:
//            //NSLog(@"未知方向");
//            break;
//        case UIDeviceOrientationLandscapeLeft:
//            //NSLog(@"屏幕向左");
//            break;
//        case UIDeviceOrientationLandscapeRight:
//            //NSLog(@"屏幕向右");
//            break;
//        case UIDeviceOrientationPortrait:
//            //NSLog(@"屏幕向上");
//            break;
//        case UIDeviceOrientationPortraitUpsideDown:
//            //NSLog(@"屏幕向下");
//            break;
//    }
//}

//- (void)outH5WebviewAction{
////    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
////    appDelegate.allowRotation = false;//关闭横屏仅允许竖屏
////    [self setNewOrientation:YES];
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
