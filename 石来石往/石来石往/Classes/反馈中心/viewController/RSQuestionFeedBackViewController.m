//
//  RSQuestionFeedBackViewController.m
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSQuestionFeedBackViewController.h"
#import "RSQuestionFeedBackHeaderView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "RSQuestionFeedBackFirstCell.h"
#import "RSQuestionFeedBackSecondCell.h"
#import "PhotoUploadHelper.h"
#define ECA 4
#define margin 10
//UITableViewDelegate,UITableViewDataSource,
@interface RSQuestionFeedBackViewController ()<RSQuestionFeedBackFirstCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,RSQuestionFeedBackSecondCellDelegate>
{
    NSMutableArray       *_imageArray;
    
}

//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)UIView * tableviewFootView;


@property (nonatomic,strong)UIButton * selectImageBtn;

/**用来接收问题类型*/
@property (nonatomic,strong)NSString * searchType;
/**用来接收问题的意见*/
@property (nonatomic,strong)NSString * questionType;

@end

@implementation RSQuestionFeedBackViewController

//- (UITableView *)tableview{
//    if (!_tableview) {
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//        _tableviewFootView.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    }
//    return _tableview;
//}


- (UIView *)tableviewFootView{
    if (!_tableviewFootView) {
        _tableviewFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 100)];
        _tableviewFootView.backgroundColor = [UIColor clearColor];
    }
    return _tableviewFootView;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    _imageArray = [NSMutableArray array];
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//
    [self isAddjust];
    
    
    
    
    RSRightNavigationButton * showQRBtn = [[RSRightNavigationButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    [showQRBtn setTitle:@"提交" forState:UIControlStateNormal];
    [showQRBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [showQRBtn setImage:[UIImage imageNamed:@"扫二维码用的"] forState:UIControlStateNormal];
    [showQRBtn addTarget:self action:@selector(submissionAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:showQRBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    
    [self.view addSubview:self.tableview];
    
    self.searchType = @"bug";
    
    //这边设置tableview尾部视图

    self.tableview.tableFooterView = self.tableviewFootView;
    
    //这边设置添加图片的视图
    
    UIButton * selectImageBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [selectImageBtn setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
    [selectImageBtn addTarget:self action:@selector(selectImageViewControllerImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableviewFootView addSubview:selectImageBtn];
    
    selectImageBtn.sd_layout
    .leftSpaceToView(self.tableviewFootView, 12)
    .topSpaceToView(self.tableviewFootView, 15)
    .widthIs(70)
    .heightEqualToWidth();
    
    _selectImageBtn = selectImageBtn;
    [self.tableviewFootView setupAutoWidthWithRightView:selectImageBtn rightMargin:15];
    
    
}

- (void)selectImageViewControllerImage:(UIButton *)selectImageBtn{
    //这边要开始调用相册了
    if (_imageArray.count >= 3) {
         [SVProgressHUD showInfoWithStatus:@"最多只能选择3张图片"];
    }else{
        __weak typeof(self) weakSelf = self;
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //打开系统相机
            [weakSelf openCamera];
        }];
        [alert addAction:action1];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //打开系统相册
            [weakSelf selectPictures];
        }];
        [alert addAction:action2];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //这边去取消操作
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action3];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alert.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alert animated:YES completion:nil];
    }
}


//FIXME:提交
- (void)submissionAction:(UIButton *)btn{
    if (self.questionType.length < 1) {
       
        [SVProgressHUD showInfoWithStatus:@"请描述问题"];
    }else{
        //URL_FEEDBACKSUBMIT_IOS getMoreImageDataWithUrlString
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dict setObject:self.searchType forKey:@"type"];
        [dict setObject:self.questionType forKey:@"feedback"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getMoreImageDataWithUrlString:URL_FEEDBACKSUBMIT_IOS withParameters:parameters andDataArray:_imageArray withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"]boolValue];
                if (Result) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    btn.selected = YES;
                }else{
                    btn.selected = YES;
                }
            }else{
                btn.selected = YES;
            }
        }];
    }
}


#pragma mark -- 使用系统的方式打开相机
- (void)openCamera{
    //调用系统的相机的功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //先检查相机可用是否
        BOOL cameraIsAvailable = [self checkCamera];
        if (YES == cameraIsAvailable) {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                picker.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
}

#pragma mark -- 检查相机是否可用
- (BOOL)checkCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(AVAuthorizationStatusRestricted == authStatus ||
       AVAuthorizationStatusDenied == authStatus)
    {
        //相机不可用
        return NO;
    }
    //相机可用
    return YES;
}



#pragma mark -- 当用户选取完成后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
        if (mediaMetadata)
        {
            
        } else {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            __block NSDictionary *blockMediaMetadata = mediaMetadata;
            __block UIImage *blockImage = pickedImage;
            [library
             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
             resultBlock: ^ (ALAsset *asset) {
                 ALAssetRepresentation *representation = [asset defaultRepresentation];
                 blockMediaMetadata = [representation metadata];
                 [picker dismissViewControllerAnimated:YES completion:nil];
                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
             }
             failureBlock: ^ (NSError *error) {
                 
             }];
        }
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            __block NSDictionary *blockMediaMetadata = mediaMetadata;
            __block UIImage *blockImage = pickedImage;
            [library
             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
             resultBlock: ^ (ALAsset *asset) {
                 ALAssetRepresentation *representation = [asset defaultRepresentation];
                 blockMediaMetadata = [representation metadata];
                 [picker dismissViewControllerAnimated:YES completion:nil];
                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
             }
             failureBlock: ^ (NSError *error) {
                 
             }];
            [picker dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
        }
    }
}

- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
{
    //[[RSMessageView shareMessageView] showMessageWithType:@"努力加载中" messageType:kRSMessageTypeIndicator];
    RSWeakself
    [PhotoUploadHelper
     processPickedUIImage:[self scaleToSize:pickedImage ]
     withMediaMetadata:mediaMetadata
     completeBlock:^(XPhotoUploaderContentEntity *photo) {
         
         _photoEntityWillUpload = photo;
         
         [_imageArray addObject:_photoEntityWillUpload.image];
         [weakSelf nineGrid];
     }
     failedBlock:^(NSDictionary *errorInfo) {
         
     }];
}

#pragma mark -- 对图片进行压缩
- (UIImage *)scaleToSize:(UIImage *)img {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}



// 本地相册选择多张照片
- (void)selectPictures
{
    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:3 delegate:self];
    RSWeakself
    imagePickerVc.allowPickingVideo = false;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           for (int i=0; i<photos.count; i++)
                           {
                               // = photos[i]
                               // ALAsset *asset = assets[i];
                               //UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                               UIImage * tempImg = photos[i];
                               [_imageArray addObject:tempImg];
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [weakSelf nineGrid];
                               });
                           }
                       });
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)nineGrid
{
    for (UIImageView *imgv in self.tableviewFootView.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
        }
    }
    
    CGFloat width = 70;
    CGFloat height = 70;
    
    NSInteger count = _imageArray.count;
    
    _imageArray.count > 3 ? (count = 3) : (count = _imageArray.count);
    if (count < 1) {
        self.selectImageBtn.sd_layout
        .leftSpaceToView(self.tableviewFootView,12)
        .topSpaceToView(self.tableviewFootView, 15)
        .bottomSpaceToView(self.tableviewFootView, 15)
        .widthIs(width)
        .heightEqualToWidth();
       // [self.tableviewFootView setupAutoHeightWithBottomView:self.selectImageBtn bottomMargin:15];
    }else{
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / ECA;
            NSInteger colom = i % ECA;
            UIImageView *imgv = [[UIImageView alloc] init];
            CGFloat imgX =  colom * (margin + width) + margin;
            CGFloat imgY =  row * (margin + height) + margin;
            imgv.frame = CGRectMake(imgX, imgY, width, height);
            imgv.image = _imageArray[i];
            imgv.userInteractionEnabled = YES;
            [self.tableviewFootView addSubview:imgv];
            //添加手势
            imgv.tag = 100000+i;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showQuestionFeedBackPicture:)];
            tap.view.tag = 100000+i;
            [imgv addGestureRecognizer:tap];
            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
            delete.frame = CGRectMake(width-16, 0, 16, 16);
            [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteQuestionFeedBackEvent:) forControlEvents:UIControlEventTouchUpInside];
            delete.tag = 10+i;
            [imgv addSubview:delete];
            self.selectImageBtn.sd_layout
            .leftSpaceToView(imgv, margin)
            .topSpaceToView(imgv, imgY)
            .bottomEqualToView(imgv)
            .widthIs(70);
            [self.tableviewFootView setupAutoHeightWithBottomView:self.selectImageBtn bottomMargin:15];
            //[_headerview setupAutoHeightWithBottomView:_reservationBtn bottomMargin:0];
            //[_headerview setupAutoHeightWithBottomView:_alertLabel bottomMargin:0];
      }
    }
}


//FIXME:查看大图
- (void)showQuestionFeedBackPicture:(UITapGestureRecognizer *)tap{
    UIImageView * imageView = (UIImageView *)self.tableviewFootView.subviews[tap.view.tag - 100000];
    [HUPhotoBrowser showFromImageView:imageView withImages:_imageArray atIndex:tap.view.tag - 100000];
}


//FIXME:删除
- (void)deleteQuestionFeedBackEvent:(UIButton *)deleteBtn{
    [_imageArray removeObjectAtIndex:deleteBtn.tag-10];
    [self nineGrid];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return 0;
    }else{
      return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString * RSQUESTIONFEEDBACKFIRSTCELL = @"RSQUESTIONFEEDBACKFIRSTCELL";
        RSQuestionFeedBackFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:RSQUESTIONFEEDBACKFIRSTCELL];
        if (!cell) {
            cell = [[RSQuestionFeedBackFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSQUESTIONFEEDBACKFIRSTCELL];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        //if (indexPath.section == 1)
        
        static NSString * RSQUESTIONFEEDBACKSECONDCELL = @"RSQUESTIONFEEDBACKSECONDCELL";
        RSQuestionFeedBackSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:RSQUESTIONFEEDBACKSECONDCELL];
        if (!cell) {
            cell = [[RSQuestionFeedBackSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSQUESTIONFEEDBACKSECONDCELL];
            
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
   // else{


//        static NSString * RSQUESTIONFEEDBACKFIRSTCELL = @"RSQUESTIONFEEDBACKFIRSTCELL";
//        RSQuestionFeedBackFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:RSQUESTIONFEEDBACKFIRSTCELL];
//        if (!cell) {
//            cell = [[RSQuestionFeedBackFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSQUESTIONFEEDBACKFIRSTCELL];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
   // }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * QUESTIONFEEDBACKHEADERVIEW = @"QUESTIONFEEDBACKHEADERVIEW";
    RSQuestionFeedBackHeaderView * questionFeedBackHeaderview = [[RSQuestionFeedBackHeaderView alloc]initWithReuseIdentifier:QUESTIONFEEDBACKHEADERVIEW];
    if (section == 0) {
        
        questionFeedBackHeaderview.titleLabel.text = @"请选择反馈类型的类型";
    }else if (section == 1){
        questionFeedBackHeaderview.titleLabel.text = @"请选择问题和意见类型问题和意见类型";
    }else{
        questionFeedBackHeaderview.titleLabel.text = @"添加图片(提供问题截图)";
    }
    return questionFeedBackHeaderview;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37;
}




#pragma mark -- RSQuestionFeedBackFirstCellDelegate

- (void)currentSelectQuestionBtnTitle:(NSString *)title{
    
    self.searchType = title;
}

#pragma mark -- RSQuestionFeedBackSecondCellDelegate
- (void)inputTextViewContent:(NSString *)contentStr{
    self.questionType = contentStr;
    
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
