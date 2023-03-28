//
//  RSCompayWebviewViewController.m
//  石来石往
//
//  Created by mac on 17/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSCompayWebviewViewController.h"


#import <Photos/Photos.h>


#import "ShowView.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoUploadHelper.h"
#import "UIView+Frame.h"

#import "RSPictureViewController.h"

/**显示进度条*/
#import "RSViewProgressLine.h"
/**帮助引导图*/
#import "RSGuide.h"

//#import "AFHTTPSessionManager+ShareManger.h"



//typedef void(^showActionSheet)(NSString *itmes);





//,UIImagePickerControllerDelegate,UINavigationControllerDelegate
@interface RSCompayWebviewViewController ()<WKNavigationDelegate,selectDelegate,UIAlertViewDelegate>

{
    UIView * _navigationview;
    
    
    //获取用户交互的
    NSArray * _dateArr;
    
    
    NSString *cacelString;//Alt取消标题
    NSString *sureString;//Alt确定标题
    
    
    int i;
    NSArray * guideArr;
    UIButton  *imageBtn;
    
    
    
}
/**显示进度条*/
@property (nonatomic,strong) RSViewProgressLine  *progressLine;

//@property (nonatomic,strong)showActionSheet actionSheet;
@property (nonatomic,strong)WKWebView * webView;

//获取到选中图片的图片
//@property (nonatomic,strong)NSString * imageName;



@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)JSContext * context;





@end

@implementation RSCompayWebviewViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    //用来判断用户的账号是否被人家使用了
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:self];
    
    
    
//    self.navigationController.navigationBar.hidden = NO;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = _titleStr;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    //添加自定义导航栏
   // [self addCustomNavigation];
    
    
    //显示引导图
    
    
    if ([self.urlStr isEqualToString:self.tempUrl]) {
        i=1;
        NSUserDefaults *deralt = [NSUserDefaults standardUserDefaults];
        if (![[deralt objectForKey:@"First11"] isEqual:@"1"]) {
            RSGuide *guide = [[RSGuide alloc]init];
            guideArr =[guide image:9];
            NSString *string = guideArr[0];
            imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
            [imageBtn setImage:[UIImage imageNamed:string]  forState:UIControlStateNormal];
            [imageBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:imageBtn];
        }
    }
    
    self.htmlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar)];
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    self.progressLine = [[RSViewProgressLine alloc] initWithFrame:CGRectMake(0, 0, SCW, 1)];
    self.progressLine.lineColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    [self.htmlView addSubview:self.progressLine];
    
    if (_showRightBtn) {
        [self creatRightClickBtnTitle:_saveBtnStr];
        
    }
   
    
    WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height)];
    _webView = webview;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = YES;
    
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        
        _urlStr = [_urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
        
        
    }else{
        _urlStr= [_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    
//    NSURL *urlStr = [[NSURL alloc]initWithString:[_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURL * urlStr = [[NSURL alloc]initWithString:_urlStr];
    
    
   
    NSMutableURLRequest *requst = [[NSMutableURLRequest alloc]initWithURL:urlStr];
    
    
    
    
    [ requst setValue:verifykey forHTTPHeaderField:@"VerifyKey"];
    NSString *vericode =[NSString get_verifyCode];
    
    [requst setValue:vericode forHTTPHeaderField:@"VerifyCode"];
    [_webView loadRequest:requst];
    [self.htmlView addSubview:webview];
   
    
//    self.context = [_webView  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    //window.control.showHaiXiMap(mtype)
//    
//    
//    self.context.exceptionHandler =
//    ^(JSContext *context, JSValue *exceptionValue)
//    {
//        context.exception = exceptionValue;

//    };
//    
//    __weak typeof(self) weakself = self;
//    self.context[@"ActionshowHaiXiMap"] = ^() {
//        NSArray *args = [JSContext currentArguments];
//        for (JSValue *jsVal in args) {

//            if ([jsVal.toString isEqualToString:@"0"]) {
//                RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
//                pictureVc.mtypeStr = @"0";
//                pictureVc.titleStr = @"荒料界面显示图片";
//                [weakself presentViewController:pictureVc animated:YES completion:nil];
//            }else{
//                RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
//                pictureVc.mtypeStr = @"1";
//                pictureVc.titleStr = @"大板界面显示图片";
//                [weakself presentViewController:pictureVc animated:YES completion:nil];
//            }   
//        }
//    };
}




-(void)click:(UIButton *)sender{
    if (i==guideArr.count) {
        imageBtn.hidden =YES;
    }else{
        NSString *str = guideArr[i];
        [imageBtn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    }
    NSUserDefaults *defalts = [NSUserDefaults standardUserDefaults];
    [defalts setObject:@"1" forKey:@"First11"];
    i++;
}



- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    NSURLRequest *request = navigationAction.request;
    NSString *urlStr = [[request URL]absoluteString];
    
    
    NSArray *components = [urlStr componentsSeparatedByString:@"#"];
    if ([components count] > 1 && ![(NSString *)[components objectAtIndex:0] isEqual:@""]) {
        
       
        
        NSString *transString = [NSString stringWithString:[components[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
       
        
        
        
        _dateArr = [transString componentsSeparatedByString:@","];
        
        
        if ([_dateArr[0] isEqual:@"uploadImage"])
        {
            
            
            //相机和相册
            //[self savefunc];
            
            
            RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
            [selectTool openPhotoAlbumAndOpenCameraViewController:self];
            selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
                _photoEntityWillUpload = photoEntityWillUpload;
                [self uploadUserHead];
            };
            
            
            
            
            
            
            
        }
        else if([_dateArr[0] isEqual:@"showAlertDialog"])
        {
            
            //创建弹窗
            [self showAlertDialog:_dateArr];
        }else if([_dateArr[0] isEqualToString:@"reloadpage"]){
            
            //更新界面
            
            [self reLoadPage:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"CreateNormalWindow"]){
            //创建新的界面
            
            [self CreateNormalWindow:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"CreateWindowByTitleBarCompat"]){
            //创建新的导航栏的标题和内容
            
            [self CreateWindowByTitleBarCompat:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"showSingleChoiceDialog"]){
            //创建单选和多选视图框
            
            [self showSingleChoiceDialog:_dateArr];
        }else if([_dateArr[0] isEqualToString:@"showConfirmDialog"]){
            //弹出确认框
            [self showConfirmDialog:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"CloseWidowByID"]){
            //关闭当前的窗口
            [self CloseWidowByID:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"GetCurrentWindowID"]){
            //获取当前的窗口
            [self GetCurrentWindowID:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"createGenShareableWindow"]){
            [self createGenShareableWindow:transString andType:_dateArr[0]];
            
        }
        else if ([_dateArr[0] isEqual:@"openImageBrowser"])
        {//创建图片浏览器窗口
            [self createrOpenImageBrowser:_dateArr[1] andIndexImgStr:_dateArr[2]];
            
        } else if ([_dateArr[0] isEqualToString:@"updateNavigationBar"])
        {
            
            //更新自定义导航视图的文字
            [self updateNavigationBar:_dateArr];
        }else if([_dateArr[0] isEqualToString:@"showHaiXiMap"]){
            
            [self showHaiXiMap:_dateArr];
            
        } //获取版本
        else if ([_dateArr[0] isEqualToString:@"getH5VersionCode"])
        {
            [self getH5VersionCode:_dateArr];
        }
}

}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    decisionHandler(WKNavigationResponsePolicyAllow);

    NSURLRequest *request = [NSURLRequest requestWithURL:navigationResponse.response.URL];
    NSString *urlStr = [[request URL]absoluteString];
   
    NSArray *components = [urlStr componentsSeparatedByString:@"#"];
    if ([components count] > 1 && ![(NSString *)[components objectAtIndex:0] isEqual:@""]) {
        NSString *transString = [NSString stringWithString:[components[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        _dateArr = [transString componentsSeparatedByString:@","];
        if ([_dateArr[0] isEqual:@"uploadImage"])
        {
            //相机和相册
            //[self savefunc];
            
            
            RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
            [selectTool openPhotoAlbumAndOpenCameraViewController:self];
            selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
                _photoEntityWillUpload = photoEntityWillUpload;
                [self uploadUserHead];
            };
            
            
            
            
        }
        else if([_dateArr[0] isEqual:@"showAlertDialog"])
        {
            //创建弹窗
            [self showAlertDialog:_dateArr];
        }else if([_dateArr[0] isEqualToString:@"reloadpage"]){
            //更新界面
            [self reLoadPage:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"CreateNormalWindow"]){
            //创建新的界面
            [self CreateNormalWindow:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"CreateWindowByTitleBarCompat"]){
            //创建新的导航栏的标题和内容
            [self CreateWindowByTitleBarCompat:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"showSingleChoiceDialog"]){
            //创建单选和多选视图框
            [self showSingleChoiceDialog:_dateArr];
        }else if([_dateArr[0] isEqualToString:@"showConfirmDialog"]){
            //弹出确认框
            [self showConfirmDialog:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"CloseWidowByID"]){
            //关闭当前的窗口
            [self CloseWidowByID:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"GetCurrentWindowID"]){
            //获取当前的窗口
            [self GetCurrentWindowID:_dateArr];
        }else if ([_dateArr[0] isEqualToString:@"createGenShareableWindow"]){
            [self createGenShareableWindow:transString andType:_dateArr[0]];
        }
        else if ([_dateArr[0] isEqual:@"openImageBrowser"])
        {//创建图片浏览器窗口
            [self createrOpenImageBrowser:_dateArr[1] andIndexImgStr:_dateArr[2]];
        } else if ([_dateArr[0] isEqualToString:@"updateNavigationBar"])
        {
            //更新自定义导航视图的文字
            [self updateNavigationBar:_dateArr];
        }else if([_dateArr[0] isEqualToString:@"showHaiXiMap"]){
            [self showHaiXiMap:_dateArr];
        } //获取版本
        else if ([_dateArr[0] isEqualToString:@"getH5VersionCode"])
        {
            [self getH5VersionCode:_dateArr];
        }
    }
}

//  获取版本号
-(void)getH5VersionCode:(NSArray *)arr{
    
    //   NSString *viersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *jsCode=[NSString stringWithFormat:@"%@('%@')",arr[1],@"38"];
    //[_webView stringByEvaluatingJavaScriptFromString:jsCode];
    [_webView evaluateJavaScript:jsCode completionHandler:nil];
}




- (void)showHaiXiMap:(NSArray *)viewARR{
    
    
    if ([viewARR[1] isEqualToString:@"0"]) {
                        RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
                        pictureVc.mtypeStr = @"0";
                        pictureVc.titleStr = @"荒料界面显示图片";
                        //[self presentViewController:pictureVc animated:YES completion:nil];
        [self.navigationController pushViewController:pictureVc animated:YES];
        
                    }else{
                        RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
                        pictureVc.mtypeStr = @"1";
                        pictureVc.titleStr = @"大板界面显示图片";
                        [self.navigationController pushViewController:pictureVc animated:YES];
                    }   

}






//1.文字，2.图片，3.文字+文字 4文字加图片，5图片加文字，6图片加图片
-(void)updateNavigationBar:(NSArray *)viewARR{
    self.title =viewARR[1];
    switch ([viewARR[2] integerValue]) {
        case 1:
            [self.saveBtn setTitle:viewARR[3] forState:UIControlStateNormal];
            break;
        case 2:
            [self.saveBtn setTitle:viewARR[3] forState:UIControlStateNormal];
            break;
        case 3:
            //            [self createRightBarButtonWithBgTittleOneName: viewARR[3]titleName:  viewARR[4] ];
            
            break;
        case 4:
            //            [self createRightBarButtonWithBgImgName:viewARR[3] titleName:viewARR[4] ];
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        default:
            break;
    }
    _showRightBtn =YES;
    
}

#pragma mark ----创建图片浏览器窗口
-(void)createrOpenImageBrowser:(NSString *)imgStr andIndexImgStr:(NSString *)idnexImgSrt
{
    
    
    /// Local declaration of 'i' hides instance variable
    NSString *STR=[imgStr stringByReplacingOccurrencesOfString:@"'" withString:@""];
    NSString *indexStr=[idnexImgSrt stringByReplacingOccurrencesOfString:@"'" withString:@""];
    int index=0;
    NSArray *imgArr=[STR componentsSeparatedByString:@";"];
    //NSMutableArray *marr=[NSMutableArray new];
    for (int j=0; j<imgArr.count; j++)
    {
        if ([indexStr isEqualToString:imgArr[j]])
        {
            index=j;
        }
    }
    //FIXME:这边要特别注意了，这边没有添加进来图片浏览器
    //进入图片浏览器中（第三方框架）
    //[XLPhotoBrowser showPhotoBrowserWithImages:imgArr currentImageIndex:index];
    
    
}

#pragma mark ---获取当前窗口的id
-(void)GetCurrentWindowID:(NSArray *)ViewARR{
    RSCompayWebviewViewController *fn =(RSCompayWebviewViewController *)self.presentedViewController;
    NSString *jsCode = [NSString stringWithFormat:@"%@('%ld');",_dateArr[3],fn.webtag];
//    [_webView stringByEvaluatingJavaScriptFromString:jsCode];
    [_webView evaluateJavaScript:jsCode completionHandler:nil];
}


#pragma mark ---关闭窗口
-(void)CloseWidowByID:(NSArray *)ViewARR
{
    
    
    
    
    NSArray *arrVC = self.navigationController.viewControllers;
    UIViewController *fn = arrVC[arrVC.count-2];
    
    //UIViewController *fn = self.presentingViewController;
    
    if ([fn isKindOfClass:[RSCompayWebviewViewController class]])
    {
        
        //要对之前的控制器里面的内容进行刷新
        RSCompayWebviewViewController * fn1 = [[RSCompayWebviewViewController alloc]init];
        fn1 = fn;
        [fn1.webView reload];
        
        
     [self.navigationController popViewControllerAnimated:YES];
      // [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
              // [self.navigationController popToRootViewControllerAnimated:YES];
        
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [self.progressLine startLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progressLine endLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.progressLine endLoadingAnimation];
}

//
//
//
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [self.progressLine startLoadingAnimation];
//}
//
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//    [self.progressLine endLoadingAnimation];
//}
//
//
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [self.progressLine endLoadingAnimation];
//}
//
//
#pragma mark ---弹出确认框
-(void)showConfirmDialog:(NSArray *)ViewARR{
    UIAlertView *alt;
    if ([ViewARR[3]isEqual:@"1"]) {
        alt = [[UIAlertView alloc]initWithTitle:ViewARR[1]
                                        message:ViewARR[2]
                                       delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"确定", nil];
        
    }else{
        alt = [[UIAlertView alloc]initWithTitle:ViewARR[1]
                                        message:ViewARR[2]
                                       delegate:self
                              cancelButtonTitle:@"否"
                              otherButtonTitles:@"是", nil];
        
        
    }
    alt.tag =102;
    [alt show];
    
    
}






#pragma mark ---弹出单选框
-(void)showSingleChoiceDialog:(NSArray *)ViewARR{
    
    ShowView *fv = [[ShowView alloc]initWithFrame:CGRectMake(0, 0, self.view.yj_width, self.view.yj_height) arr:ViewARR andType:kGQXXDataTypeOneSelect];
    fv.lblTitle.text =ViewARR[1];
    fv.delegate =self;
    fv.dataType =kGQXXDataTypeOneSelect;
    
    [self.view addSubview:fv];
}


#pragma mark ----创建分享与收藏
-(void)createGenShareableWindow:(NSString *)dataString andType:(NSString *)type
{
    
    
    
    NSString *string=[dataString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@,",type] withString:@""];
    NSDictionary *dataDic=[self dictionaryWithJsonString:string];
    
    
    
    
    
    
    
    
    
    

    //这边要在新的控制器上面进行界面的设置
    
    RSCompayWebviewViewController * fn = [[RSCompayWebviewViewController alloc]init];
    fn.titleStr = dataDic[@"title"];
    
    
    NSString * newUrl = [NSString stringWithFormat:@"%@",dataDic[@"url"]];
    
    //NSURL * newUrl = [NSURL URLWithString:dataDic[@"url"]];
    fn.urlStr =  newUrl;
    
    
    
    //TOWebViewController *  towebview = [[TOWebViewController alloc]initWithURLString:newUrl];
    
    
//    NSString *jsCode = [NSString stringWithFormat:@"window.control.showHaiXiMap('%d');",0];
//    
//    [_webView stringByEvaluatingJavaScriptFromString:jsCode];
    
    //[self presentViewController:fn animated:YES completion:nil];
    [self.navigationController pushViewController:fn animated:YES];
}

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}





//创建右按钮
-(void)CreateWindowByTitleBarCompat:(NSArray *)ViewARR
{
    
    RSCompayWebviewViewController *fn = [[RSCompayWebviewViewController alloc]init];
    fn.showRightBtn = YES;
    fn.urlStr = ViewARR[6];
    fn.webtag =[ViewARR[1] intValue];
    
    fn.titleStr = ViewARR[2];
     fn.titleLabel.text =[NSString stringWithFormat:@"%@",_titleStr];
    
    
   
    
    fn.rightBtnArr =ViewARR;
    //fn.isNOFrist =YES;
    //fn.isWebRight =YES;
    fn.showRightBtn = YES;
    
   
    
    
//    [fn.saveBtn setTitle:[NSString stringWithFormat:@"%@",ViewARR[3]] forState:UIControlStateNormal];
    
    fn.saveBtnStr = ViewARR[3];
    [fn creatRightClickBtnTitle:_saveBtnStr];
    
//    [self presentViewController:fn animated:YES completion:nil];
    [self.navigationController pushViewController:fn animated:YES];
}



#pragma mark  -------------uiview
-(void)CreateNormalWindow:(NSArray *)ViewARR{
    RSCompayWebviewViewController *fn = [[RSCompayWebviewViewController alloc]init];
    fn.urlStr = ViewARR[9];
    fn.webtag =[ViewARR[1] intValue];
    fn.titleLabel.text = ViewARR[2];
   // fn.isNOFrist =YES;
    //[fn createRightBarButtonImage:ViewARR[4]];
    //[self presentViewController:fn animated:YES completion:nil];
    [self.navigationController pushViewController:fn animated:YES];
}



#pragma mark----创建接口方法--上传图片成功
-(void)showAlertDialog:(NSArray *)altArr{
    //    NSString *jsCode = [NSString stringWithFormat:@"startSearch();"];
    //    [_mainWeb stringByEvaluatingJavaScriptFromString:jsCode];
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:altArr[1] message:altArr[2] delegate:self cancelButtonTitle:nil otherButtonTitles: @"确定",nil];
    alt.tag =101;
    [alt show];
}



-(UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}





//#pragma mark -- 底部提示框（相机和相册）
//- (void)savefunc{
//
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        //打开系统相机
//        [self openCamera];
//    }];
//    [alert addAction:action1];
//
//
//    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//
//        //打开系统相册
//        [self openPhotoAlbum];
//    }];
//    [alert addAction:action2];
//
//
//    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //这边去取消操作
//        [alert dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [alert addAction:action3];
//    [self presentViewController:alert animated:YES completion:nil];
//}

//#pragma mark -- 使用系统的方式打开相册
//- (void)openPhotoAlbum{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//    //设置选择后的图片可被编辑
//    picker.allowsEditing = YES;
//    [self presentViewController:picker animated:YES completion:nil];
//}
//
//
//
//#pragma mark -- 当用户选取完成后调用
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//
//        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
//        if (mediaMetadata)
//        {
//
//        } else {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//        }
//
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//
//        } else {
//
//        }
//    }
//}
//
//- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
//{
//    //[[RSMessageView shareMessageView] showMessageWithType:@"努力加载中" messageType:kRSMessageTypeIndicator];
//
//    [PhotoUploadHelper
//     processPickedUIImage:[self scaleToSize:pickedImage ]
//     withMediaMetadata:mediaMetadata
//     completeBlock:^(XPhotoUploaderContentEntity *photo) {
//
//         _photoEntityWillUpload = photo;
//
//
//         [self uploadUserHead];
//     }
//     failedBlock:^(NSDictionary *errorInfo) {
//
//     }];
//}


#pragma mark -- 进行上传图片
- (void)uploadUserHead
{
    [SVProgressHUD showWithStatus:@"正在上传中....."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //POST参数
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : @"", @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    
    NSArray *avatarArray = [NSArray arrayWithObject:_photoEntityWillUpload.image];

    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        
        
        
        [dataArray addObject:imageData];        
    }
    
    
    
    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
    [netWork getImageDataWithUrlString:_dateArr[1] withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
    
        if (success) {
            
           
            [SVProgressHUD dismiss];
            NSString * code = json[@"MSG_CODE"];
            NSString * data = json[@"Data"];
            NSString *jsCode = [NSString stringWithFormat:@"%@('%@','%@');",_dateArr[2],code,data];
            //        //[_webView stringByEvaluatingJavaScriptFromString:jsCode];
                  [_webView evaluateJavaScript:jsCode completionHandler:nil];
        }
        else{
            
            
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
            
        }
        
        
        
    }];
    
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    [mgr POST:_dateArr[1] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (NSData *formImageData in dataArray)
//        {
//            [formData appendPartWithFileData:formImageData name:@"files" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
//            
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        

//        
//        [SVProgressHUD dismiss];
//        
//        NSString * code = responseObject[@"MSG_CODE"];
//        NSString * data = responseObject[@"Data"];
//        
//        
//        NSString *jsCode = [NSString stringWithFormat:@"%@('%@','%@');",_dateArr[2],code,data];
//        //[_webView stringByEvaluatingJavaScriptFromString:jsCode];
//      [_webView evaluateJavaScript:jsCode completionHandler:nil];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

//        [SVProgressHUD showErrorWithStatus:@"上传失败"];
//    }];
}



#pragma mark  ---- selectdeletage
-(void)selectCodes:(NSString *)Codes andNames:(NSString *)Names{
    
    NSString *transString = [NSString stringWithString:[Names stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *jsCode = [NSString stringWithFormat:@"%@('%@','%@');",_dateArr[5],Codes,transString];
    
//    [_webView stringByEvaluatingJavaScriptFromString:jsCode];
    [_webView evaluateJavaScript:jsCode completionHandler:nil];
    
    
}

//#pragma mark -- 对图片进行压缩
//- (UIImage *)scaleToSize:(UIImage *)img {
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
//
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    //返回新的改变大小后的图片
//    return scaledImage;
//}
//
//
//
//
////#pragma mark - 保存图片至本地沙盒
////
////- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
////{
////    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
////    
////    // 获取沙盒目录
////    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
////    // 将图片写入文件
////    [imageData writeToFile:fullPath atomically:NO];
////
////}
//
//
//
//
//
//
//#pragma mark -- 当用户取消调用
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


//////压缩图片质量
////-(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
////{
////    NSData *imageData = UIImageJPEGRepresentation(image, percent);
////    UIImage *newImage = [UIImage imageWithData:imageData];
////    return newImage;
////}
//////压缩图片尺寸
////- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
////{
////    UIGraphicsBeginImageContext(newSize);
////    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
////    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
////    return newImage;
////}
//
//
//
//#pragma mark -- 使用系统的方式打开相机
//- (void)openCamera{
//        //调用系统的相机的功能
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        picker.delegate = self;
//        //设置拍照后的图片可被编辑
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        //先检查相机可用是否
//        BOOL cameraIsAvailable = [self checkCamera];
//        if (YES == cameraIsAvailable) {
//            [self presentViewController:picker animated:YES completion:nil];
//        }else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
//            [alert show];
//        }
//
//    }
//
//}
//
//#pragma mark -- 检查相机是否可用
//- (BOOL)checkCamera
//{
//    NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    if(AVAuthorizationStatusRestricted == authStatus ||
//       AVAuthorizationStatusDenied == authStatus)
//    {
//        //相机不可用
//        return NO;
//    }
//    //相机可用
//    return YES;
//}

#pragma mark ---刷新页面
-(void)reLoadPage:(NSArray *)ViewARR
{
    // UIViewController *fn = self.presentingViewController
    
    NSArray *arrVC = self.navigationController.viewControllers;
    UIViewController *fn = arrVC[arrVC.count-2];
    if ([fn isKindOfClass:[RSCompayWebviewViewController class]])
    {
        for (RSCompayWebviewViewController *comFn in arrVC)
        {
            if ([comFn isKindOfClass:[RSCompayWebviewViewController class]])
            {
                if (comFn.webtag == [ViewARR[1] intValue])
                {
                    [comFn.webView reload];
                    return;
                }
            }
            
        }
    }
    else
    {
        return;
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag ==100) {
        if (buttonIndex ==0) {
            
        }else if (buttonIndex ==1)
        {
            NSString *jsCode = [NSString stringWithFormat:@"setQuestionContent('%@')",[alertView textFieldAtIndex:0].text];
//            [_webView stringByEvaluatingJavaScriptFromString:];
            [_webView evaluateJavaScript:jsCode completionHandler:nil];
        }
        
    }else if (alertView.tag ==101){
        
        if (buttonIndex ==0) {
            if (_dateArr.count>2) {
                if (_dateArr.count>3) {
                    NSString *jsCode = [NSString stringWithFormat:@"%@('1');",_dateArr[3]];
//                    [_webView stringByEvaluatingJavaScriptFromString:jsCode];
                    [_webView evaluateJavaScript:jsCode completionHandler:nil];
                }
                if ([_dateArr[0] isEqualToString:@"callLastWindowInvokeJsMethod"]) {
                    return ;
                }
                if (_dateArr.count>2) {
                    if ([_dateArr[2] isEqualToString:@"删除成功。"])
                    {
                        [self.webView reload];
                    }
                }
            }
        }
    }else if (alertView.tag ==102)
    {
        if (buttonIndex ==1) {
            NSString * jsCode = [NSString stringWithFormat:@"%@();",_dateArr[4]];
            //[_webView stringByEvaluatingJavaScriptFromString:]];
            [_webView evaluateJavaScript:jsCode completionHandler:nil];
        }else{
            if ([cacelString isEqual:@"否"]) {
                NSString * jsCode = [NSString stringWithFormat:@"%@();",_dateArr[4]];
                //[_webView stringByEvaluatingJavaScriptFromString:]];
                [_webView evaluateJavaScript:jsCode completionHandler:nil];
            }else if ([cacelString isEqual:@"取消"]){
                NSString * jsCode = [NSString stringWithFormat:@"%@();",_dateArr[4]];
                //[_webView stringByEvaluatingJavaScriptFromString:]];
                [_webView evaluateJavaScript:jsCode completionHandler:nil];
            }
        }
    }
//        else if (alertView.tag ==1500){
//        if ([alertView cancelButtonIndex] != buttonIndex) {
//            UITextField *messageTextField = [alertView textFieldAtIndex:0];
//            NSString *messageStr = @"";
//            if (messageTextField.text.length > 0) {
//          messageStr = [NSString stringWithFormat:@"%@：%@",[[[Accountx currentAccount] sysUser] userName],messageTextField.text];
//                applyMess =messageStr;
//            }
//            else{
//         messageStr = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyInvite", @"%@ invite you as a friend"),  [[[Accountx currentAccount] sysUser] userName]];
//            }
//            [self sendFriendApplyAtIndexPath:nil
//                                     message:messageStr];
//        }
//    }
}




#pragma mark -- 点击右边的保存按键
- (void)saveInformation:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"保存"]) {
        NSString * jsCode = [NSString stringWithFormat:@"savefunc()"];
//        [_webView stringByEvaluatingJavaScriptFromString:jsCode];
        [_webView evaluateJavaScript:jsCode completionHandler:nil];
    }else if ([btn.titleLabel.text isEqualToString:@"发表"]){
        NSString * jsCode = [NSString stringWithFormat:@"savedata()"];
//        [_webView stringByEvaluatingJavaScriptFromString:jsCode];
        [_webView evaluateJavaScript:jsCode completionHandler:nil];
    }
    
    
   
}



//- (void)addCustomNavigation{
    
    
    /*
    UIView *navigationview = [[UIView alloc]init];
    _navigationview = navigationview;
    navigationview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    [self.view addSubview:navigationview];
    navigationview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(64);
    */

    
    
    //[navigationview addSubview:backItem];
    
    /*
    UILabel * titleLabel = [[UILabel alloc]init];
    //titleLabel.text = @"修改企业信息";
    titleLabel.text = _titleStr;
    _titleLabel = titleLabel;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [navigationview addSubview:titleLabel];
    
  
    
    
    
    backItem.sd_layout
    .leftSpaceToView(navigationview,8)
    .topSpaceToView(navigationview,27)
    .widthIs(40)
    .heightIs(30);
    
    
    if (self.showRightBtn == NO) {
        //这边是没有右边显示的时候
        
        titleLabel.sd_layout
        .centerXEqualToView(navigationview)
        .topSpaceToView(navigationview,30)
        
        .widthRatioToView(navigationview,0.8)
        .heightIs(20);
    }else{
        
        //这边是右边有显示的时候
        titleLabel.sd_layout
        .centerXEqualToView(navigationview)
        .topSpaceToView(navigationview,30)
        
        .widthRatioToView(navigationview,0.65)
        .heightIs(20);
    }
    
   */
    
    
    
//    self.progressView = [[UIProgressView alloc]init];
//    self.progressView.progressTintColor = [UIColor blueColor];
//    self.progressView.trackTintColor = [UIColor darkGrayColor];
//    
//    [self.view addSubview:self.progressView];
//    
//    
//    self.progressView.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .topSpaceToView(_navigationview,0)
//    .heightIs(1.5);
    

//}



- (void)creatRightClickBtnTitle:(NSString *)name{
    if (_showRightBtn) {
        
        RSHomeButtom * saveBtn = [[RSHomeButtom alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
        //[saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        
        [saveBtn setTitle:name forState:UIControlStateNormal];
        
        [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.saveBtn = saveBtn;
        saveBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        //[_navigationview addSubview:saveBtn];
        [saveBtn addTarget:self action:@selector(saveInformation:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
        self.navigationItem.rightBarButtonItem = rightitem;
        
        
        
        /*
        self.saveBtn.sd_layout
        .rightSpaceToView(_navigationview,12)
        .topSpaceToView(_navigationview,30)
        .widthIs(50)
        .heightIs(25);
         */
    }
}




#pragma mark -- 移除kvo监督模式
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    //[_webView removeObserver:self forKeyPath:@"estimatedProgress"];
//}



//#pragma mark -- 移除和h5的交互
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    WKUserContentController *userCC = _webView.configuration.userContentController;
//    [userCC removeScriptMessageHandlerForName:@"savefunc"];
//}



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
