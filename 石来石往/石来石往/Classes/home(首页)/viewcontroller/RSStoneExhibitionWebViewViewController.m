//
//  RSStoneExhibitionWebViewViewController.m
//  石来石往
//
//  Created by mac on 2017/10/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSStoneExhibitionWebViewViewController.h"
/**显示进度条*/
#import "RSViewProgressLine.h"
#import "AppDelegate.h"
#import "RSCodeSheetModel.h"
#import "RSWeChatShareTool.h"
#import "LXActivity.h"

@interface RSStoneExhibitionWebViewViewController ()<WKNavigationDelegate,UINavigationControllerDelegate,WKScriptMessageHandler,LXActivityDelegate>
{
    NSString * shareStr;
}

@property (nonatomic,strong)RSViewProgressLine * progressLineview;

@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)WKWebView * webView;

@end

@implementation RSStoneExhibitionWebViewViewController

- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    // 关键1：提前锁死横屏权限，不让系统走竖屏流程
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = YES;
        [self setNewOrientation:NO]; // 触发横屏
        
        // 关键2：隐藏WebView直到横屏就绪（避免竖屏被看到）
//        self.htmlView.hidden = YES;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            self.htmlView.hidden = NO; // 横屏稳定后显示
//        });
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
    
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(outH5WebviewAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    //通过通知监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.htmlView = [[UIView alloc]init];
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    self.progressLineview = [[RSViewProgressLine alloc] init];
    self.progressLineview.lineColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    [self.htmlView addSubview:self.progressLineview];
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController * userContent = [[WKUserContentController alloc]init];
    [userContent addScriptMessageHandler:self name:@"tixing"];
    [userContent addScriptMessageHandler:self name:@"load"];
    [userContent addScriptMessageHandler:self name:@"cancel"];
    [userContent addScriptMessageHandler:self name:@"share"];
    config.userContentController = userContent;
    WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height) configuration:config];
    _webView = webview;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = YES;
    //@"http://192.168.1.191:8080/"
    NSString * stoneUrlStr = [NSString stringWithFormat:@"%@%@?pageType=%ld&appType=%ld&userId=%@&mtlCode=%@&totalSheetSun=%lf&totalVol=%lf&selectedkeyArr=%@&mtlName=%@&blockno=%@&turnsno=%@&datefrom=%@&dateto=%@&whsname=%@&storeareaname=%@&locationname=%@&length=%ld&width=%ld&lengthType=%ld&widthType=%ld",URL_HEADER_TEXT_IOS,self.webStr,self.pageType,self.appType,self.usermodel.userID,self.mtlCode,self.totalSheetSun,self.totalVol,self.selectedkeyArr,self.mtlName,self.blockno,self.turnsno,self.datefrom,self.dateto,self.whsname,self.storeareaname,self.locationname,self.length,self.width,self.lengthType,self.widthType];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        stoneUrlStr = [stoneUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
    }else{
        stoneUrlStr= [stoneUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)outH5WebviewAction{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = false;//关闭横屏仅允许竖屏
    [self setNewOrientation:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

// 强制初始方向为横屏
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}


- (void)setNewOrientation:(BOOL)fullscreen{
    // 获取当前活跃的窗口场景（兼容iOS 13+）
        UIWindowScene *windowScene = nil;
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]] &&
                scene.activationState == UISceneActivationStateForegroundActive) {
                windowScene = (UIWindowScene *)scene;
                break;
            }
        }
        if (!windowScene) return;
        
        // 直接设置目标方向，不做重置（避免中间状态）
        if (fullscreen) {
            // 切换到竖屏
            if (@available(iOS 16.0, *)) {
                UIWindowSceneGeometryPreferencesIOS *preferences =
                    [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:UIInterfaceOrientationMaskPortrait];
                [windowScene requestGeometryUpdateWithPreferences:preferences errorHandler:nil];
            } else {
                [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
                [UIViewController attemptRotationToDeviceOrientation];
            }
        } else {
            // 切换到横屏（直接设置，不经过竖屏）
            if (@available(iOS 16.0, *)) {
                UIWindowSceneGeometryPreferencesIOS *preferences =
                    [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:UIInterfaceOrientationMaskLandscapeRight];
                [windowScene requestGeometryUpdateWithPreferences:preferences errorHandler:nil];
            } else {
                [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
                [UIViewController attemptRotationToDeviceOrientation];
            }
        }
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"tixing"]) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",message.body]];
    }
    if ([message.name isEqualToString:@"load"]) {
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",message.body]];
    }
    if ([message.name isEqualToString:@"cancel"]) {
        [SVProgressHUD dismiss];
    }
    if ([message.name isEqualToString:@"share"]) {
        shareStr = message.body;
    }
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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [SVProgressHUD dismiss];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"xiaoxin"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"load"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"cancel"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"share"];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

//- (void)setNewOrientation:(BOOL)fullscreen{
//    if (fullscreen) {
//        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
//        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//    }else{
//        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
//        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
//        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//    }
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;  //支持横向
}

//设置为允许旋转
- (BOOL) shouldAutorotate {
    return YES;
}

#pragma mark -- 分享
- (void)shareAction{
    RSWeakself
    [JHSysAlertUtil presentAlertViewWithTitle:@"确定是否分享该数据" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
    } confirm:^{
        //这边是确定的东西
        [weakSelf shareReloadNetworkString:shareStr];
    }];
}

//FIXME:这边要把从H5页面上面拿到的值，发送到后台去，然后在返回一个URL网址进行分享
- (void)shareReloadNetworkString:(NSString *)shareStr{
    /**
     分享标题    title    String    默认填（码单分享）
     分享页面    content    String    存页面
     分享描述    describe    String    默认填（码单分享）
     分享类别    shareType    String    默认填（码单分享）
     石种名称    proName    String    石种名称（用户返回默认图，不传返回石来石往默认图标）
     */
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:shareStr forKey:@"content"];
    [phoneDict setObject:self.mtlName forKey:@"proName"];
    [phoneDict setObject:@"报表分享" forKey:@"title"];
    [phoneDict setObject:@"报表分享" forKey:@"describe"];
    [phoneDict setObject:@"报表分享" forKey:@"shareType"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SHAREPAGES_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                RSCodeSheetModel * codeSheetmodel = [[RSCodeSheetModel alloc]init];
                codeSheetmodel.img = json[@"Data"][@"img"];
                codeSheetmodel.url = json[@"Data"][@"url"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf showChoiceShareView:codeSheetmodel];
                    });
            }
            else{
               // [SVProgressHUD showErrorWithStatus:@"分享失败"];
            }
        }else{
            // [SVProgressHUD showErrorWithStatus:@"分享失败"];
        }
    }];
}

- (void)showChoiceShareView:(RSCodeSheetModel *)codeSheetmodel{
    NSArray *shareButtonTitleArray = nil;
    NSArray *shareButtonImageNameArray = nil;
    shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
    shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
    LXActivity * lxActivity= [[LXActivity alloc]initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andRSCodeSheetModel:codeSheetmodel];
    [lxActivity showInView:self.view];
}

- (void)didClickOnImageIndex:(NSInteger *)imageIndex andRSCodeSheetModel:(RSCodeSheetModel *)codeSheetModel{
    [RSWeChatShareTool codeSheetweChatShareStyleShareStrImageIndex:imageIndex andRSCodeSheetModel:codeSheetModel andShareStr:shareStr];
}

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    UIDevice *device = [UIDevice currentDevice] ;
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            //NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            //NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
            //NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            //NSLog(@"屏幕向左");
            break;
        case UIDeviceOrientationLandscapeRight:
            //NSLog(@"屏幕向右");
            break;
        case UIDeviceOrientationPortrait:
            //NSLog(@"屏幕向上");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            //NSLog(@"屏幕向下");
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
