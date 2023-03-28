//
//  RSMarketComplaintViewController.m
//  石来石往
//
//  Created by mac on 2022/9/12.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSMarketComplaintViewController.h"
#import "RSHistoryFeedbacklistViewController.h"
#import "RSMarketUploadImageModel.h"

@interface RSMarketComplaintViewController ()<UITextViewDelegate,TZImagePickerControllerDelegate>
{
    //联系方式
    UILabel * _phoneLabel;
    //提交
    UIButton * _sendBtn;
    
    UILabel * _pictureLabel;
}





//反馈的问题
@property (nonatomic,strong)UITextView * complaintTextView;

//联系方式
@property (nonatomic,strong)UITextView * phoneTextView;


@property (nonatomic,strong)UIScrollView * hoistoryScrollView;

//输入的次数
@property (nonatomic,strong)UILabel *  textViewNumberLabel;

@property (nonatomic,strong)UIButton * addPictureBtn;


@property (nonatomic,strong)UIView * addPictureView;




@end

@implementation RSMarketComplaintViewController

- (NSMutableArray *)imageArray{
    if (!_imageArray){
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
   

    _hoistoryScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_hoistoryScrollView];
    _hoistoryScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    _hoistoryScrollView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    
    
    UIButton * hoistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hoistoryBtn setTitle:@"     历史反馈记录" forState:UIControlStateNormal];
    [hoistoryBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    hoistoryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    hoistoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_hoistoryScrollView addSubview:hoistoryBtn];
    [hoistoryBtn addTarget:self action:@selector(hoistoryAction:) forControlEvents:UIControlEventTouchUpInside];
    
    hoistoryBtn.sd_layout.leftSpaceToView(_hoistoryScrollView, 0).rightSpaceToView(_hoistoryScrollView, 0).topSpaceToView(_hoistoryScrollView, 0).heightIs(50);
    
    
    UIImageView * rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"chevron-right"];
    [_hoistoryScrollView addSubview:rightImage];
    
    rightImage.sd_layout.centerYEqualToView(hoistoryBtn).rightSpaceToView(_hoistoryScrollView, 16).widthIs(16).heightEqualToWidth();
    
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
    [_hoistoryScrollView addSubview:midView];
    
    midView.sd_layout.leftSpaceToView(_hoistoryScrollView, 0).rightSpaceToView(_hoistoryScrollView, 0).topSpaceToView(hoistoryBtn, 0).heightIs(8);
    
    UILabel * complaintTitle = [[UILabel alloc]init];
    complaintTitle.text = @"意见反馈";
    complaintTitle.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    complaintTitle.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [_hoistoryScrollView addSubview:complaintTitle];
    
    
//    Frame
    UIImageView * frameImage = [[UIImageView alloc]init];
    frameImage.image = [UIImage imageNamed:@"Frame"];
    [_hoistoryScrollView addSubview:frameImage];
    
     
    complaintTitle.sd_layout.leftSpaceToView(_hoistoryScrollView, 16).topSpaceToView(midView, 12.5).heightIs(23).widthIs(70);
    
    frameImage.sd_layout.leftSpaceToView(complaintTitle, 6).widthIs(8).heightEqualToWidth().centerYEqualToView(complaintTitle);
    
    
    _complaintTextView = [[UITextView alloc]init];
    _complaintTextView.zw_placeHolder = @"请输入您要的反馈的问题";
    _complaintTextView.delegate = self;
    _complaintTextView.textContainerInset = UIEdgeInsetsMake(16, 16, 0, 0);
    _complaintTextView.font = [UIFont systemFontOfSize:14];
    _complaintTextView.zw_placeHolderColor = [UIColor colorWithHexColorStr:@"#999999"];
    _complaintTextView.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [_hoistoryScrollView addSubview:_complaintTextView];
    
    _complaintTextView.sd_layout.leftSpaceToView(_hoistoryScrollView, 16).topSpaceToView(complaintTitle, 11.5).rightSpaceToView(_hoistoryScrollView, 16).heightIs(150);
    
    _complaintTextView.layer.borderWidth = 1;
    _complaintTextView.layer.borderColor = [UIColor colorWithHexColorStr:@"#DCDFE6"].CGColor;
    _complaintTextView.layer.cornerRadius = 4;
    
    
    
    _textViewNumberLabel = [[UILabel alloc]init];
    _textViewNumberLabel.text = @"0/1000";
    _textViewNumberLabel.textAlignment = NSTextAlignmentRight;
    _textViewNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    _textViewNumberLabel.font = [UIFont systemFontOfSize: 14];
    [_hoistoryScrollView addSubview:_textViewNumberLabel];
    
    
    _textViewNumberLabel.sd_layout.rightSpaceToView(_hoistoryScrollView, 20).topSpaceToView(_complaintTextView, -32).heightIs(39).widthIs(100);
    
    
    //图片补充
    UILabel * pictureLabel = [[UILabel alloc]init];
    pictureLabel.text = @"图片补充";
    pictureLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    pictureLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [_hoistoryScrollView addSubview:pictureLabel];
    pictureLabel.sd_layout.leftSpaceToView(_hoistoryScrollView, 16).topSpaceToView(_complaintTextView, 15).heightIs(23).widthIs(80);
    _pictureLabel = pictureLabel;
    
    //图片添加的按键 ---这边要弄成一个UIview view里面设置为按键，这里图片可以一直加
    
    //添加图片的view
    UIView * addPictureView = [[UIView alloc]init];
    addPictureView.backgroundColor = [UIColor clearColor];
    [_hoistoryScrollView addSubview:addPictureView];
    _addPictureView = addPictureView;
    
    
    
    //添加图片的按键
    UIButton * addPictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //_addPic.frame = CGRectMake(0, 0, 62.5, 62.5);
    [addPictureBtn setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
    [addPictureBtn addTarget:self action:@selector(addServicePicture:) forControlEvents:UIControlEventTouchUpInside];
    [addPictureView addSubview:addPictureBtn];
    _addPictureBtn = addPictureBtn;
    
    
    
    addPictureView.sd_layout
    .leftSpaceToView(_hoistoryScrollView, 0)
    .rightSpaceToView(_hoistoryScrollView, 0)
    .topSpaceToView(pictureLabel, 15)
    .heightIs(80);
    
//    addPictureView.layer.cornerRadius = 5;
//    addPictureView.layer.borderWidth = 1;
//    addPictureView.layer.borderColor = [UIColor colorWithHexColorStr:@"#f9f9f9"].CGColor;
//    addPictureView.layer.masksToBounds = YES;
    
    
    addPictureBtn.sd_layout
    .centerYEqualToView(addPictureView)
    .leftSpaceToView(addPictureView, 12)
    .widthIs(62.5)
    .heightIs(62.5);
    
    
    UILabel * phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"联系方式";
    phoneLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [_hoistoryScrollView addSubview:phoneLabel];
    
    phoneLabel.sd_layout.leftSpaceToView(_hoistoryScrollView, 16).topSpaceToView(addPictureView, 15).heightIs(23).widthIs(80);
    _phoneLabel = phoneLabel;
     
    _phoneTextView = [[UITextView alloc]init];
    _phoneTextView.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextView.delegate = self;
    _phoneTextView.zw_placeHolder = @"手机号码,方便我们与您联系";
    _phoneTextView.textContainerInset = UIEdgeInsetsMake(13, 11.5, 13, 0);
    _phoneTextView.font = [UIFont systemFontOfSize:14];
    _phoneTextView.zw_placeHolderColor = [UIColor colorWithHexColorStr:@"#999999"];
    _phoneTextView.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [_hoistoryScrollView addSubview:_phoneTextView];
    
    _phoneTextView.sd_layout.leftSpaceToView(_hoistoryScrollView, 16).topSpaceToView(phoneLabel,15).heightIs(45).rightSpaceToView(_hoistoryScrollView,16);
    
    _phoneTextView.layer.borderWidth = 1;
    _phoneTextView.layer.borderColor = [UIColor colorWithHexColorStr:@"#DCDFE6"].CGColor;
    _phoneTextView.layer.cornerRadius = 4;
    
    
    UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sendBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [_hoistoryScrollView addSubview:sendBtn];
    
    sendBtn.sd_layout.leftSpaceToView(_hoistoryScrollView, 35).rightSpaceToView(_hoistoryScrollView, 35).heightIs(45).topSpaceToView(_phoneTextView, 52.5);
    _sendBtn = sendBtn;
    
    sendBtn.layer.cornerRadius = 20;
    sendBtn.layer.masksToBounds = true;
    
    [sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_hoistoryScrollView setupAutoContentSizeWithBottomView:_sendBtn bottomMargin:30];
    _hoistoryScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(sendBtn.frame) + 100);
    
    [self nineGrid];
    
    if (self.isShow){
        
        hoistoryBtn.hidden = true;
//        sendBtn.isHidden = true;
        sendBtn.hidden = true;
        _phoneTextView.editable = false;
        _complaintTextView.editable = false;
        [_hoistoryScrollView setupAutoContentSizeWithBottomView:_phoneTextView bottomMargin:30];
        _hoistoryScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_phoneTextView.frame) + 100);
   
        midView.sd_layout.leftSpaceToView(_hoistoryScrollView, 0).rightSpaceToView(_hoistoryScrollView, 0).topSpaceToView(_hoistoryScrollView, 0).heightIs(8);
        
        _complaintTextView.text = self.content;
        _phoneTextView.text = self.contactNumber;
        
        
    }else{
        
        hoistoryBtn.hidden = false;
        sendBtn.hidden = false;
        _complaintTextView.editable = true;
        _phoneTextView.editable = true;
        midView.sd_layout.leftSpaceToView(_hoistoryScrollView, 0).rightSpaceToView(_hoistoryScrollView, 0).topSpaceToView(hoistoryBtn, 0).heightIs(8);
        [_hoistoryScrollView setupAutoContentSizeWithBottomView:_sendBtn bottomMargin:30];
        _hoistoryScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(sendBtn.frame) + 100);
        
    }
    
    
    
    
    
}

- (void)sendAction:(UIButton *)sendBtn{

    if (_complaintTextView.text.length <= 0){
        [SVProgressHUD showErrorWithStatus:@"请填写意见反馈"];
        return;
    }
    
    if (_phoneTextView.text.length <= 0){
        [SVProgressHUD showErrorWithStatus:@"请填写联系方式"];
        return;
    }
    
//    if (_phoneTextView.text )
    
    if (![self isTrueMobile:_phoneTextView.text]){
        [SVProgressHUD showErrorWithStatus:@"电话号码错误"];
        return;
    }
    
    
    
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否确定提交投诉" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
            
        } confirm:^{
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setValue:_complaintTextView.text forKey:@"content"];
            [phoneDict setValue:_phoneTextView.text forKey:@"contactNumber"];
            
            NSMutableArray * tempArray = [NSMutableArray array];
            for (int i = 0; i < self.imageArray.count; i++) {
                RSMarketUploadImageModel * marketUploadImageModel = _imageArray[i];
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                [dict setValue:marketUploadImageModel.fileName forKey:@"fileName"];
                [dict setValue:[NSNumber numberWithInteger:marketUploadImageModel.fileSize] forKey:@"fileSize"];
                [dict setValue:marketUploadImageModel.fileType forKey:@"fileType"];
                [dict setValue:marketUploadImageModel.uploadImageId forKey:@"id"];
                [dict setValue:[NSNumber numberWithInteger:marketUploadImageModel.operatorId] forKey:@"operator"];
                [dict setValue:marketUploadImageModel.path forKey:@"path"];
                [dict setValue:[NSNumber numberWithInteger:marketUploadImageModel.status] forKey:@"status"];
                [dict setValue:marketUploadImageModel.url forKey:@"url"];
                [dict setValue:marketUploadImageModel.urlOrigin forKey:@"urlOrigin"];
                [tempArray addObject:dict];
            }
            [phoneDict setValue:tempArray forKey:@"imageList"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            RSWeakself;
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_MARKET_FEEDBACK_SAVE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL isresult = [json[@"success"]boolValue];
                    if (isresult) {
//                        [self.navigationController popViewControllerAnimated:true];
                        
                        RSHistoryFeedbacklistViewController * historyFeedBackListVc = [[RSHistoryFeedbacklistViewController alloc]init];
                        [weakSelf.navigationController pushViewController:historyFeedBackListVc animated:true];
                        NSMutableArray<UIViewController *> * array1 = [NSMutableArray array];
                        array1 = weakSelf.navigationController.viewControllers.mutableCopy;
                        for (int i = 0; i < array1.count; i++) {
                            UIViewController * viewController = array1[i];
                            if ([viewController isKindOfClass:[RSMarketComplaintViewController class]]){
                                [array1 removeObject:viewController];
                                break;
                            }
                        }
                        weakSelf.navigationController.viewControllers = array1;
                        
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"保存失败"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"保存失败"];
                }
            }];
        }];
}



- (void)hoistoryAction:(UIButton *)hoistoryBtn{
    NSLog(@"点击了历史反馈记录");
    RSHistoryFeedbacklistViewController * historyFeedBackListVc = [[RSHistoryFeedbacklistViewController alloc]init];
    [self.navigationController pushViewController:historyFeedBackListVc animated:true];
}





// 9宫格图片布局
- (void)nineGrid
{
    for (UIImageView *imgv in _addPictureView.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
            // [_addPic removeFromSuperview];
        }
    }
    
    CGFloat width = 62.5;
    CGFloat height = 62.5;
    NSInteger count = _imageArray.count;
//    _imageArray.count > 3 ? (count = 3) : (count = _imageArray.count);
    
    if (count < 1) {
        
        
        _addPictureView.sd_layout
        .leftSpaceToView(_hoistoryScrollView, 0)
        .rightSpaceToView(_hoistoryScrollView, 0)
        .topSpaceToView(_pictureLabel, 15)
        .heightIs(80);
        
        
        _addPictureBtn.sd_layout
        .centerYEqualToView(_addPictureView)
        .leftSpaceToView(_addPictureView, 12)
        .topSpaceToView(_addPictureView, 8.75)
        .bottomSpaceToView(_addPictureView, 8.75)
        .widthIs(62.5);
        
        
//        _addPictureMenView.uploadBtn.enabled = NO;
//        [_addPictureMenView.uploadBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
    }else{
//        _addPictureMenView.uploadBtn.enabled = YES;
//        [_addPictureMenView.uploadBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"3385ff"]];
        
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / 4;
            NSInteger colom = i % 4;
            //WithFrame:CGRectMake(14+(width+widthSpace)*(i%4), (i/4)*(width+heightSpace)+14, width, width)
            UIImageView *imgv = [[UIImageView alloc] init];
            CGFloat imgX =  colom * (10 + width) + 10;
            CGFloat imgY =  row * (10 + height) + 10;
            imgv.frame = CGRectMake(imgX, imgY, width, height);
            RSMarketUploadImageModel * marketUploadImageModel = _imageArray[i];
            
            NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
            [imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,marketUploadImageModel.url]] placeholderImage:[UIImage imageNamed:@""]];
//            RSPersonlNetworkPictureModel * personlNetworkPicturemodel = _imageArray[i];
//            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:personlNetworkPicturemodel.img]];
//            imgv.image = [UIImage imageWithData:data];
            imgv.userInteractionEnabled = YES;
            [_addPictureView addSubview:imgv];
            //添加手势
            imgv.tag = 100000+i;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showQuestionPicture:)];
            [imgv addGestureRecognizer:tap];
            tap.view.tag = 100000+i;
            //这边是已完成的状态
//            if ([temp isEqualToString:@"5"]) {
//                _addPictureBtn.hidden = YES;
//                _addPictureBtn.enabled = NO;
//            }else{
                
                _addPictureBtn.hidden = NO;
                _addPictureBtn.enabled = YES;
                UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
                delete.frame = CGRectMake(width-16, 0, 16, 16);
                [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
                [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
                delete.tag = 1000000000+i;
                [imgv addSubview:delete];
                
            
            if (self.isShow){
                _addPictureBtn.hidden = true;
                delete.hidden = true;
                if (i == _imageArray.count - 1){
                    if (_imageArray.count % 4 == 0){
                        _addPictureView.sd_layout
                        .leftSpaceToView(_hoistoryScrollView, 0)
                        .rightSpaceToView(_hoistoryScrollView, 0)
                        .topSpaceToView(_pictureLabel, 15)
                        .heightIs((_imageArray.count / 4) * 80);
                    }else{
                        _addPictureView.sd_layout
                        .leftSpaceToView(_hoistoryScrollView, 0)
                        .rightSpaceToView(_hoistoryScrollView, 0)
                        .topSpaceToView(_pictureLabel, 15)
                        .heightIs(((_imageArray.count / 4) + 1)* 80);
                    }
                }
            }else{
                _addPictureBtn.hidden = false;
                delete.hidden = false;
                if (i == _imageArray.count - 1){
                    if (_imageArray.count % 4 == 0) {

                        _addPictureBtn.sd_layout.leftSpaceToView(_addPictureView, 12).topSpaceToView(imgv, 10).widthIs(62.5).heightEqualToWidth();

                    } else {
                        
                        _addPictureBtn.sd_layout.leftSpaceToView(imgv, 10).topEqualToView(imgv).widthIs(62.5).heightEqualToWidth();
                    }

                    _addPictureView.sd_layout
                    .leftSpaceToView(_hoistoryScrollView, 0)
                    .rightSpaceToView(_hoistoryScrollView, 0)
                    .topSpaceToView(_pictureLabel, 15)
                    .heightIs(((_imageArray.count / 4) + 1) * 80);
                       
                    }
                }
            }
            
           
            
    }

    //这边要设置
    _phoneLabel.sd_layout.leftSpaceToView(_hoistoryScrollView, 16).topSpaceToView(_addPictureView, 15).heightIs(23).widthIs(80);
    
    _phoneTextView.sd_layout.leftSpaceToView(_hoistoryScrollView, 16).topSpaceToView(_phoneLabel,15).heightIs(45).rightSpaceToView(_hoistoryScrollView,16);
    
    _sendBtn.sd_layout.leftSpaceToView(_hoistoryScrollView, 35).rightSpaceToView(_hoistoryScrollView, 35).heightIs(45).topSpaceToView(_phoneTextView, 52.5);
    
    [_hoistoryScrollView setupAutoContentSizeWithBottomView:_sendBtn bottomMargin:30];
    
    
    _hoistoryScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_sendBtn.frame) + 100);
    
}


//选择图片
- (void)addServicePicture:(UIButton *)addPictrueBtn{
    NSLog(@"=23=2=3=2=3=2=3=2=3");
    
    if (self.isShow){
        [SVProgressHUD showInfoWithStatus:@"该模式下不能上传图片"];
    }else{
        TZImagePickerController * imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        //是否显示可选原图按钮
        imagePicker.allowPickingOriginalPhoto = NO;
        // 是否允许显示视频
        imagePicker.allowPickingVideo = NO;
        // 是否允许显示图片
        imagePicker.allowPickingImage = YES;
        // 这是一个navigation 只能present
        // 设置 模态弹出模式。 iOS 13默认非全屏
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePicker animated:true completion:^{
        }];
    }
//    [self nineGrid];

}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    //URL_MARKET_UPDATE_PICTURE_IOS
    //getLeafletsImageDataWithUrlString
    [self loadUpdateImage:photos.firstObject];

}


- (void)loadUpdateImage:(UIImage *)image{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getLeafletsImageDataWithUrlString:URL_MARKET_UPDATE_PICTURE_IOS withParameters:parameters andImage:image withBlock:^(id json, BOOL success){
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
              [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
//                [_changePictureBtn setImage:image forState:UIControlStateNormal];
                RSMarketUploadImageModel * marketUploadImageModel = [RSMarketUploadImageModel mj_objectWithKeyValues:json[@"data"]];
                [weakSelf.imageArray addObject:marketUploadImageModel];
                [weakSelf nineGrid];
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
        }
    }];
}


//显示大图
- (void)showQuestionPicture:(UITapGestureRecognizer *)tap{
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * miniImages = [NSMutableArray array];
    for (int i = 0; i < self.imageArray.count; i++) {
        RSMarketUploadImageModel * marketUploadImageModel = self.imageArray[i];
        [images addObject:[NSString stringWithFormat:@"%@%@",url,marketUploadImageModel.urlOrigin]];
        [miniImages addObject:[NSString stringWithFormat:@"%@%@",url,marketUploadImageModel.url]];
    }
    [XLPhotoBrowser showPhotoBrowserWithImages:images andMiniImage:miniImages currentImageIndex:tap.view.tag - 100000];
}

//删除
- (void)deleteEvent:(UIButton *)deleteBtn{
    [self.imageArray removeObjectAtIndex:deleteBtn.tag - 1000000000];
    [self nineGrid];
}



-(void)textViewDidChange:(UITextView *)textView{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if(textView == _complaintTextView){
        _textViewNumberLabel.text = [NSString stringWithFormat:@"%ld/1000",existTextNum];
           if (textView.markedTextRange == nil) {
               // 没有预输入文字
               if (existTextNum > 1000){
                   //截取到最大位置的字符
                   NSString *s = [nsTextContent substringToIndex:1000];
                   [textView setText:s];
               }
           }
    }else{
        if (textView.markedTextRange == nil) {
            // 没有预输入文字
            if (existTextNum > 11){
                //截取到最大位置的字符
                NSString *s = [nsTextContent substringToIndex:11];
                [textView setText:s];
            }
        }
    }
}





@end
