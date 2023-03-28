//
//  RSTaoBaoApplyShopViewController.m
//  石来石往
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoApplyShopViewController.h"

@interface RSTaoBaoApplyShopViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,TZImagePickerControllerDelegate>
{
    //店铺名字
    
    UILabel * _shopNameLabel;
    UITextView * _shopNameDetialTextfield;
    UIView * _midView;
    //联系电话
    UILabel * _phoneLabel;
    UITextView * _phoneTextfield;
    UIView * _firstView;
    //联系地址
    UILabel * _addressLabel;
    UITextView * _addressTextfield;
    UIView * _secondView;
    UIView * _thirdView;
    
    UIView * _headerView;
    
    UIButton * _applyShopBtn;
    
    //图片按键
    UIButton * _changePictureBtn;
}
@property (nonatomic,strong)UITableView * tableview;
@end

@implementation RSTaoBaoApplyShopViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
         self.title = @"申请店铺";
        UITableView * tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableview = tableview;
    }else{
        
        UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) style:UITableViewStylePlain];
        self.tableview = tableview;
    }
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    [self setTableViewCustomHeaderView];
    
   
    
}

- (void)setTableViewCustomHeaderView{
    
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    _headerView = headerView;
    
    
    UIButton * changePictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changePictureBtn setImage:[UIImage imageNamed:@"512"] forState:UIControlStateNormal];
    [headerView addSubview:changePictureBtn];
    [changePictureBtn addTarget:self action:@selector(changePictureAction:) forControlEvents:UIControlEventTouchUpInside];
    changePictureBtn.frame = CGRectMake(SCW/2 - 30, 16, 60, 60);
    _changePictureBtn = changePictureBtn;
    
    UILabel * pictureLabel = [[UILabel alloc]init];
    pictureLabel.text = @"点击修改店铺头像";
    pictureLabel.frame = CGRectMake(0, CGRectGetMaxY(changePictureBtn.frame) + 12, SCW, 17);
    pictureLabel.font = [UIFont systemFontOfSize:12];
    pictureLabel.textAlignment = NSTextAlignmentCenter;
    pictureLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerView addSubview:pictureLabel];
    
    //fenge
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pictureLabel.frame) + 17, SCW, 7)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    [headerView addSubview:midView];
    _midView = midView;
    
    UILabel * shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(midView.frame), 77, 50)];
    shopNameLabel.text = @"店铺名字:";
    shopNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    shopNameLabel.textAlignment = NSTextAlignmentLeft;
    shopNameLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:shopNameLabel];
    _shopNameLabel = shopNameLabel;
    
    UITextView * shopNameDetialTextfield = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shopNameLabel.frame) + 20, CGRectGetMaxY(midView.frame), SCW - 12 - CGRectGetMaxX(shopNameLabel.frame) - 20, 50)];
    shopNameDetialTextfield.delegate = self;
    shopNameDetialTextfield.returnKeyType = UIReturnKeyDone;
    [headerView addSubview:shopNameDetialTextfield];
    _shopNameDetialTextfield = shopNameDetialTextfield;
    
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(shopNameDetialTextfield.frame) , SCW - 24, 1)];
    firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [headerView addSubview:firstView];
    _firstView = firstView;
    
    
    
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(firstView.frame), 77, 50)];
    phoneLabel.text = @"联系电话:";
    phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:phoneLabel];
    _phoneLabel = phoneLabel;
    
    
    UITextView * phoneTextfield = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLabel.frame) + 20, CGRectGetMaxY(firstView.frame), SCW - 12 - CGRectGetMaxX(phoneLabel.frame) - 20, 50)];
    phoneTextfield.delegate = self;
    phoneTextfield.keyboardType = UIKeyboardTypePhonePad;
    phoneTextfield.returnKeyType = UIReturnKeyDone;
    [headerView addSubview:phoneTextfield];
    _phoneTextfield = phoneTextfield;
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(phoneTextfield.frame) , SCW - 24, 1)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [headerView addSubview:secondView];
    _secondView = secondView;
    
    
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(secondView.frame), 77, 50)];
    addressLabel.text = @"联系地址:";
    addressLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:addressLabel];
    _addressLabel = addressLabel;
    
    UITextView * addressTextfield = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressLabel.frame) + 20, CGRectGetMaxY(secondView.frame), SCW - 12 - CGRectGetMaxX(addressLabel.frame) - 20, 50)];
    addressTextfield.delegate = self;
    addressTextfield.returnKeyType = UIReturnKeyDone;
    [headerView addSubview:addressTextfield];
    _addressTextfield = addressTextfield;
    
    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(addressTextfield.frame) , SCW - 24, 1)];
    thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [headerView addSubview:thirdView];
    _thirdView = thirdView;
    
    
    UIButton * applyShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyShopBtn setTitle:@"申请开通" forState:UIControlStateNormal];
    [applyShopBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF4B33"]];
    [applyShopBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    applyShopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    applyShopBtn.frame = CGRectMake(12, CGRectGetMaxY(thirdView.frame) + 20, SCW - 24, 40);
    [applyShopBtn addTarget:self action:@selector(applyShopAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:applyShopBtn];
    applyShopBtn.layer.cornerRadius = 12;
    applyShopBtn.layer.masksToBounds = YES;
    _applyShopBtn = applyShopBtn;
    
    if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
        
        
        if (self.taobaoUsermodel.status == 1) {
            //正常
            applyShopBtn.enabled = YES;
            changePictureBtn.enabled = YES;
            shopNameDetialTextfield.editable = YES;
            phoneTextfield.editable = YES;
            addressTextfield.editable = YES;
            
        }else if (self.taobaoUsermodel.status == 0 || self.taobaoUsermodel.status == 3){
            //审核中
            
            
            //图片
//            UIImageView * imageview = [[UIImageView alloc]init];
//            [imageview sd_setImageWithURL:[NSURL URLWithString:self.taobaoUsermodel.shopLogo] placeholderImage:[UIImage imageNamed:@"512"]];
//            [_changePictureBtn setImage:imageview.image forState:UIControlStateNormal];
            
            
             [_changePictureBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.taobaoUsermodel.shopLogo]]] forState:UIControlStateNormal];
            
            
            
            //店铺名称
            _shopNameDetialTextfield.text = self.taobaoUsermodel.shopName;
            //电话号码
            _phoneTextfield.text = self.taobaoUsermodel.phone;
            //地址
            _addressTextfield.text = self.taobaoUsermodel.address;
            CGRect size =  [self remarksContent:shopNameDetialTextfield];
            //重新调整textView的高度
            if (size.size.height < 50) {
                shopNameDetialTextfield.frame = CGRectMake(CGRectGetMaxX(shopNameLabel.frame) + 20,CGRectGetMaxY(midView.frame),SCW - 12 - CGRectGetMaxX(shopNameLabel.frame) - 20, 50);
            }else{
                shopNameDetialTextfield.frame = CGRectMake(CGRectGetMaxX(shopNameLabel.frame) + 20,CGRectGetMaxY(midView.frame),SCW - 12 - CGRectGetMaxX(shopNameLabel.frame) - 20, size.size.height);
            }
            firstView.frame = CGRectMake(12, CGRectGetMaxY(shopNameDetialTextfield.frame), SCW - 24, 1);
            phoneLabel.frame = CGRectMake(12, CGRectGetMaxY(firstView.frame), 77, 50);
            CGRect size1 =  [self remarksContent:phoneTextfield];
            if (size1.size.height < 50) {
                phoneTextfield.frame = CGRectMake(CGRectGetMaxX(phoneLabel.frame) + 20, CGRectGetMaxY(firstView.frame), SCW - 12 - CGRectGetMaxX(phoneLabel.frame) - 20, 50);
            }else{
                phoneTextfield.frame = CGRectMake(CGRectGetMaxX(phoneLabel.frame) + 20, CGRectGetMaxY(firstView.frame), SCW - 12 - CGRectGetMaxX(phoneLabel.frame) - 20, size1.size.height);
            }
            secondView.frame = CGRectMake(12, CGRectGetMaxY(phoneTextfield.frame) , SCW - 24, 1);
            addressLabel.frame = CGRectMake(12, CGRectGetMaxY(secondView.frame), 77, 50);
            CGRect size2 =  [self remarksContent:addressTextfield];
            if (size2.size.height < 50) {
                addressTextfield.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame) + 20, CGRectGetMaxY(secondView.frame), SCW - 12 - CGRectGetMaxX(addressLabel.frame) - 20, 50);
            }else{
                addressTextfield.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame) + 20, CGRectGetMaxY(secondView.frame), SCW - 12 - CGRectGetMaxX(addressLabel.frame) - 20, size2.size.height);
            }
            thirdView.frame = CGRectMake(12, CGRectGetMaxY(addressTextfield.frame) , SCW - 24, 1);
            applyShopBtn.frame = CGRectMake(12, CGRectGetMaxY(thirdView.frame) + 20, SCW - 24, 40);
            //申请按键名称
            if (self.taobaoUsermodel.status == 0) {
                [applyShopBtn setTitle:@"审核中" forState:UIControlStateNormal];
                applyShopBtn.enabled = NO;
                changePictureBtn.enabled = NO;
                [applyShopBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF4B33"]];
                [applyShopBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                shopNameDetialTextfield.editable = NO;
                phoneTextfield.editable = NO;
                addressTextfield.editable = NO;
            }else if (self.taobaoUsermodel.status == 3){
                [applyShopBtn setTitle:@"审核不通过" forState:UIControlStateNormal];
                applyShopBtn.enabled = YES;
                changePictureBtn.enabled = YES;
                [applyShopBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF4B33"]];
                [applyShopBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                shopNameDetialTextfield.editable = YES;
                phoneTextfield.editable = YES;
                addressTextfield.editable = YES;
            }
        }
    }else{
        
        applyShopBtn.enabled = YES;
        changePictureBtn.enabled = YES;
        shopNameDetialTextfield.editable = YES;
        phoneTextfield.editable = YES;
        addressTextfield.editable = YES;
        
       
        
        //图片
        //UIImageView * imageview = [[UIImageView alloc]init];
       // [imageview sd_setImageWithURL:[NSURL URLWithString:self.taobaoUsermodel.shopLogo] placeholderImage:[UIImage imageNamed:@"512"]];
        
       // [_changePictureBtn setImage:imageview.image forState:UIControlStateNormal];
        [_changePictureBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.taobaoUsermodel.shopLogo]]] forState:UIControlStateNormal];
        
        
        
        //店铺名称
        _shopNameDetialTextfield.text = self.taobaoUsermodel.shopName;
        //电话号码
        _phoneTextfield.text = self.taobaoUsermodel.phone;
        //地址
        _addressTextfield.text = self.taobaoUsermodel.address;
        CGRect size =  [self remarksContent:shopNameDetialTextfield];
        //重新调整textView的高度
        if (size.size.height < 50) {
            shopNameDetialTextfield.frame = CGRectMake(CGRectGetMaxX(shopNameLabel.frame) + 20,CGRectGetMaxY(midView.frame),SCW - 12 - CGRectGetMaxX(shopNameLabel.frame) - 20, 50);
        }else{
            shopNameDetialTextfield.frame = CGRectMake(CGRectGetMaxX(shopNameLabel.frame) + 20,CGRectGetMaxY(midView.frame),SCW - 12 - CGRectGetMaxX(shopNameLabel.frame) - 20, size.size.height);
        }
        firstView.frame = CGRectMake(12, CGRectGetMaxY(shopNameDetialTextfield.frame), SCW - 24, 1);
        phoneLabel.frame = CGRectMake(12, CGRectGetMaxY(firstView.frame), 77, 50);
        CGRect size1 =  [self remarksContent:phoneTextfield];
        if (size1.size.height < 50) {
            phoneTextfield.frame = CGRectMake(CGRectGetMaxX(phoneLabel.frame) + 20, CGRectGetMaxY(firstView.frame), SCW - 12 - CGRectGetMaxX(phoneLabel.frame) - 20, 50);
        }else{
            phoneTextfield.frame = CGRectMake(CGRectGetMaxX(phoneLabel.frame) + 20, CGRectGetMaxY(firstView.frame), SCW - 12 - CGRectGetMaxX(phoneLabel.frame) - 20, size1.size.height);
        }
        secondView.frame = CGRectMake(12, CGRectGetMaxY(phoneTextfield.frame) , SCW - 24, 1);
        addressLabel.frame = CGRectMake(12, CGRectGetMaxY(secondView.frame), 77, 50);
        CGRect size2 =  [self remarksContent:addressTextfield];
        if (size2.size.height < 50) {
            addressTextfield.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame) + 20, CGRectGetMaxY(secondView.frame), SCW - 12 - CGRectGetMaxX(addressLabel.frame) - 20, 50);
        }else{
            addressTextfield.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame) + 20, CGRectGetMaxY(secondView.frame), SCW - 12 - CGRectGetMaxX(addressLabel.frame) - 20, size2.size.height);
        }
        thirdView.frame = CGRectMake(12, CGRectGetMaxY(addressTextfield.frame) , SCW - 24, 1);
        applyShopBtn.frame = CGRectMake(12, CGRectGetMaxY(thirdView.frame) + 20, SCW - 24, 40);
        [applyShopBtn setTitle:@"修改店铺信息" forState:UIControlStateNormal];
        applyShopBtn.enabled = YES;
        [applyShopBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF4B33"]];
    }
    [headerView setupAutoHeightWithBottomView:applyShopBtn bottomMargin:30];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}



- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString * temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        if (textView == _shopNameDetialTextfield) {
            _shopNameDetialTextfield.text = temp;
        }else if (textView == _phoneTextfield){
            _phoneTextfield.text = temp;
        }else if (textView == _addressTextfield){
            _addressTextfield.text = temp;
        }
    }else{
        if (textView == _shopNameDetialTextfield) {
            _shopNameDetialTextfield.text = @"";
        }else if (textView == _phoneTextfield){
            _phoneTextfield.text = @"";
        }else if (textView == _addressTextfield){
            _addressTextfield.text = @"";
        }
    }
}




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //控制文本输入内容
    if (range.location >= 200){
        //控制输入文本的长度
        return  NO;
    }
    if ([text isEqualToString:@"\n"]){
        //禁止输入换行
        return NO;
    }
    return YES;
}


- (CGRect)remarksContent:(UITextView *)textView{
    CGSize constraint = CGSizeMake(SCW - 97, CGFLOAT_MAX);
    CGRect size = [textView.text boundingRectWithSize:constraint
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}
                                              context:nil];
    return size;
}



- (void)textViewDidChange:(UITextView *)textView{
    CGRect size =  [self remarksContent:textView];
    if (textView == _shopNameDetialTextfield) {
        //重新调整textView的高度
        if (size.size.height < 50) {
            _shopNameDetialTextfield.frame = CGRectMake(CGRectGetMaxX(_shopNameLabel.frame) + 20,CGRectGetMaxY(_midView.frame),SCW - 12 - CGRectGetMaxX(_shopNameLabel.frame) - 20, 50);
        }else{
            _shopNameDetialTextfield.frame = CGRectMake(CGRectGetMaxX(_shopNameLabel.frame) + 20,CGRectGetMaxY(_midView.frame),SCW - 12 - CGRectGetMaxX(_shopNameLabel.frame) - 20, size.size.height);
        }
        _firstView.frame = CGRectMake(12, CGRectGetMaxY(_shopNameDetialTextfield.frame), SCW - 24, 1);
        _phoneLabel.frame = CGRectMake(12, CGRectGetMaxY(_firstView.frame), 77, 50);
        _phoneTextfield.frame = CGRectMake(CGRectGetMaxX(_phoneLabel.frame) + 20, CGRectGetMaxY(_firstView.frame), SCW - 12 - CGRectGetMaxX(_phoneLabel.frame) - 20, 50);
        _secondView.frame = CGRectMake(12, CGRectGetMaxY(_phoneTextfield.frame) , SCW - 24, 1);
        _addressLabel.frame = CGRectMake(12, CGRectGetMaxY(_secondView.frame), 77, 50);
        _addressTextfield.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) + 20, CGRectGetMaxY(_secondView.frame), SCW - 12 - CGRectGetMaxX(_addressLabel.frame) - 20, 50);
        _thirdView.frame = CGRectMake(12, CGRectGetMaxY(_addressTextfield.frame) , SCW - 24, 1);
        _applyShopBtn.frame = CGRectMake(12, CGRectGetMaxY(_thirdView.frame) + 20, SCW - 24, 40);
    }else if (textView == _phoneTextfield){
        if (size.size.height < 50) {
            _phoneTextfield.frame = CGRectMake(CGRectGetMaxX(_phoneLabel.frame) + 20, CGRectGetMaxY(_firstView.frame), SCW - 12 - CGRectGetMaxX(_phoneLabel.frame) - 20, 50);
        }else{
            _phoneTextfield.frame = CGRectMake(CGRectGetMaxX(_phoneLabel.frame) + 20, CGRectGetMaxY(_firstView.frame), SCW - 12 - CGRectGetMaxX(_phoneLabel.frame) - 20, size.size.height);
        }
        _secondView.frame = CGRectMake(12, CGRectGetMaxY(_phoneTextfield.frame) , SCW - 24, 1);
        _addressLabel.frame = CGRectMake(12, CGRectGetMaxY(_secondView.frame), 77, 50);
        _addressTextfield.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) + 20, CGRectGetMaxY(_secondView.frame), SCW - 12 - CGRectGetMaxX(_addressLabel.frame) - 20, 50);
        _thirdView.frame = CGRectMake(12, CGRectGetMaxY(_addressTextfield.frame) , SCW - 24, 1);
        _applyShopBtn.frame = CGRectMake(12, CGRectGetMaxY(_thirdView.frame) + 20, SCW - 24, 40);
    }else if (textView == _addressTextfield){
        if (size.size.height < 50) {
             _addressTextfield.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) + 20, CGRectGetMaxY(_secondView.frame), SCW - 12 - CGRectGetMaxX(_addressLabel.frame) - 20, 50);
        }else{
             _addressTextfield.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) + 20, CGRectGetMaxY(_secondView.frame), SCW - 12 - CGRectGetMaxX(_addressLabel.frame) - 20, size.size.height);
        }
        _thirdView.frame = CGRectMake(12, CGRectGetMaxY(_addressTextfield.frame) , SCW - 24, 1);
        _applyShopBtn.frame = CGRectMake(12, CGRectGetMaxY(_thirdView.frame) + 20, SCW - 24, 40);
    }
    [_headerView setupAutoHeightWithBottomView:_applyShopBtn bottomMargin:30];
    [_headerView layoutIfNeeded];
    self.tableview.tableHeaderView = _headerView;
    [self.tableview reloadData];
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * THIRDCELLID = @"THIRDCELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:THIRDCELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:THIRDCELLID];
    }
    return cell;
}

//更改图片
- (void)changePictureAction:(UIButton *)changePictureBtn{
    RSWeakself
    TZImagePickerController * tzimagepicker = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
//    tzimagepicker.allowTakeVideo = NO;
    tzimagepicker.allowPickingVideo = false;
    tzimagepicker.allowTakePicture = YES;
    [tzimagepicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           for (int i=0; i<photos.count; i++)
                           {
                               UIImage * tempImg = photos[i];
                               dispatch_async(dispatch_get_main_queue(), ^{
                                    [weakSelf loadUpdateImage:tempImg];
                               });
                           }
                       });
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        tzimagepicker.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:tzimagepicker animated:YES completion:nil];
    
}

- (void)loadUpdateImage:(UIImage *)image{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getLeafletsImageDataWithUrlString:URL_TAOBAOLOGO_IOS withParameters:parameters andImage:image withBlock:^(id json, BOOL success){
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
              [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
                [_changePictureBtn setImage:image forState:UIControlStateNormal];
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
        }
    }];
}

- (void)applyShopAction:(UIButton *)applyShopAction{
    if ([_addressTextfield.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"没有填写地址"];
        return;
    }else if ([_shopNameDetialTextfield.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"没有填写店铺名称"];
        return;
    }else if ([_phoneTextfield.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"没有填写电话号码"];
        return;
    }else if (![self isTrueMobile:_phoneTextfield.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号错误"];
        return;
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSMutableDictionary * infromationDict = [NSMutableDictionary dictionary];
    [infromationDict setObject:_shopNameDetialTextfield.text forKey:@"shopName"];
    [infromationDict setObject:_phoneTextfield.text forKey:@"phone"];
    [infromationDict setObject:_addressTextfield.text forKey:@"address"];
    [phoneDict setObject:infromationDict forKey:@"tsUser"];
    NSString * str = [NSString string];
    if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
        str = URL_TAOBAOAPPLYSHOPUSER_IOS;
    }else{
        str = URL_TAOBAOSHOPUSER_IOS;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:str withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
                    [_applyShopBtn setTitle:@"审核中" forState:UIControlStateNormal];
                    _applyShopBtn.enabled = NO;
                    _changePictureBtn.enabled = NO;
                    [_applyShopBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
                    [_applyShopBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF4B33"] forState:UIControlStateNormal];
                    _shopNameDetialTextfield.editable = NO;
                    _phoneTextfield.editable = NO;
                    _addressTextfield.editable = NO;
                }else{
                    //修改店铺内容
                    [SVProgressHUD showSuccessWithStatus:@"修改商店信息成功"];
                }
            }else{
                if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
                   [SVProgressHUD showErrorWithStatus:@"申请商店失败"];
                }else{
                    //修改店铺内容
                   [SVProgressHUD showErrorWithStatus:@"修改商店信息失败"];
                }
            }
        }else{
            if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
                [SVProgressHUD showErrorWithStatus:@"申请商店失败"];
            }else{
                //修改店铺内容
                [SVProgressHUD showErrorWithStatus:@"修改商店信息失败"];
            }
        }
    }];
}

- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    
    // NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
    
}

@end
