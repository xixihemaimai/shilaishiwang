//
//  RSPersonSettingViewController.m
//  石来石往
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPersonSettingViewController.h"


#import "RSPersonFirstCell.h"
#import "RSPersonSecondCell.h"

#import "RSRePasswordViewController.h"

#import "RSTwoPasswordView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
//,UIImagePickerControllerDelegate,UINavigationControllerDelegate
@interface RSPersonSettingViewController ()
{
    /**二级密码视图*/
     RSTwoPasswordView * _twoPasswordview;
    /**蒙板*/
    UIView * _menuview;
}

//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)NSArray * fristArray;

@property (nonatomic,strong)NSArray * secondArray;

@property (nonatomic,strong)NSArray * thirdArray;

@end

@implementation RSPersonSettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // self.hidesBottomBarWhenPushed = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.fristArray = @[@"昵称",@"联系方式"];
    self.secondArray = @[@"公司名称",@"所在职位"];
    self.thirdArray = @[@"修改密码"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    [self addCustomTableview];
}



#pragma mark --  货主是否有新昵称审核中
- (void)hxhzLoadNameIsAudit{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.userModel.userID forKey:@"userId"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_STATUSALERT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
                RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                cell.phoneLabel.text = [NSString stringWithFormat:@"%@审核中.......",json[@"Data"]];
                cell.phoneLabel.textColor = [UIColor redColor];
            }else{
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
                RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                cell.phoneLabel.text = self.userModel.userName;
            }
        }else{
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
            RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
            cell.phoneLabel.text = self.userModel.userName;
        }
    }];
}




//- (void)addCustomTableview{
//    CGFloat H = 0.0;
//    CGFloat bottom = 0.0;
//    if (iPhoneX_All) {
//        H = 88;
//        bottom = 34;
//    }else{
//        H = 64;
//        bottom = 0.0;
//    }
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, H, SCW, SCH - H - bottom) style:UITableViewStylePlain];
//    tableview.estimatedRowHeight = 0;
//    tableview.estimatedSectionHeaderHeight = 0;
//    tableview.estimatedSectionFooterHeight = 0;
//    tableview.scrollEnabled = NO;
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview = tableview;
//    [self.view addSubview:self.tableview];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PERSIONID = @"personid";
    if (indexPath.section == 0) {
        RSPersonFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSIONID];
        if (!cell) {
            cell = [[RSPersonFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSIONID];
        }
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.userModel.userHead]] placeholderImage:[UIImage imageNamed:@"求真像"]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        RSPersonSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSIONID];
        if (!cell) {
            cell = [[RSPersonSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSIONID];
        }
        if (indexPath.section == 1) {
             cell.nameLabel.text = self.fristArray[indexPath.row];
                if (indexPath.row == 0) {
                    if ([self.userModel.userType isEqualToString:@"hxhz"]) {
                        [self hxhzLoadNameIsAudit];
                    }else{
                         cell.phoneLabel.text = self.userModel.userName;
                    }
                }
                else{
                    cell.phoneLabel.text = self.userModel.userPhone;
                }
        }else if (indexPath.section == 2){
            cell.nameLabel.text = self.secondArray[indexPath.row];
                if (indexPath.row == 0) {
                    cell.phoneLabel.text = self.userModel.orgName;
                }else{
                    cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.userModel.inviteCode];
                }
        }else{
            cell.nameLabel.text = self.thirdArray[indexPath.row];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 68;
    }else{
        return 48;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //这边是一样的，修改
        //[self openPhotoAlbumAndOpenCamera];
        RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
        [selectTool openPhotoAlbumAndOpenCameraViewController:self];
        selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
            _photoEntityWillUpload = photoEntityWillUpload;
            [self uploadUserHead];
        };
    }else if (indexPath.section == 1){
        //货主
        if ([self.userModel.userType isEqualToString:@"hxhz"]) {
            //[SVProgressHUD showInfoWithStatus:@"货主不能修改电话和昵称,公司名称,所在职位"];
            if (indexPath.row == 0) {
                //这边要修改昵称的地方
                [self revampUserData:indexPath];
            }else{
                [SVProgressHUD showInfoWithStatus:@"货主不能修改电话,公司名称,所在职位"];
            }
        }
        else{
            if (indexPath.row == 0) {
                  [self revampUserData:indexPath];
            }else{
                if ([self.userModel.userType isEqualToString:@"hxyk"]) {
                     [SVProgressHUD showInfoWithStatus:@"不能修改联系方式"];
                }else{
                     [self revampUserData:indexPath];
                }
            }
        }
    }else if (indexPath.section == 2){
        if ([self.userModel.userType isEqualToString:@"hxhz"]) {
            [SVProgressHUD showInfoWithStatus:@"不能修改公司名称和所在职位"];
        }else{
            [self revampUserData:indexPath];
        }
    }else if (indexPath.section == 3) {
            RSRePasswordViewController * repasswordVc = [[RSRePasswordViewController alloc]init];
            repasswordVc.userModel = self.userModel;
            repasswordVc.isSecondPassword = false;
            [self.navigationController pushViewController:repasswordVc animated:YES];
    }
}

- (void)revampUserData:(NSIndexPath *)indexpath{
    _menuview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeMenuview)];
    [_menuview addGestureRecognizer:tap];
    [self.view addSubview:_menuview];
    _menuview.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.5];
    RSTwoPasswordView *twoPasswordview = [[RSTwoPasswordView alloc]init];
   // twoPasswordview.twoPasswordfield.delegate = self;
    [_twoPasswordview.twoPasswordfield becomeFirstResponder];
    _twoPasswordview = twoPasswordview;
    [twoPasswordview.sureBtn addTarget:self action:@selector(revampLoginUserData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoPasswordview];
    [twoPasswordview bringSubviewToFront:self.view];
    twoPasswordview.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .leftSpaceToView(self.view,12)
    .rightSpaceToView(self.view,12)
    .heightIs(150);
    if (indexpath.section == 1) {
        if (indexpath.row == 0) {
            _twoPasswordview.label.text = self.fristArray[indexpath.row];
           // [self sureViewTwoPassword:twoPassword andIndexpath:indexpath];
        }else{
             _twoPasswordview.label.text = self.fristArray[indexpath.row];
            // [self sureViewTwoPassword:twoPassword andIndexpath:indexpath];
        }
    }else if (indexpath.section == 2){
        if (indexpath.row == 0) {
            _twoPasswordview.label.text = self.secondArray[indexpath.row];
            // [self sureViewTwoPassword:twoPassword andIndexpath:indexpath];
        }else{
            _twoPasswordview.label.text = self.secondArray[indexpath.row];
             //[self sureViewTwoPassword:twoPassword andIndexpath:indexpath];
        }
    }
}

#pragma mark -- 修改当前用户的信息
- (void)revampLoginUserData:(UIButton *)btn{
    NSString * btnType = [NSString string];
    if ([self.userModel.userType isEqualToString:@"hxhz"]) {
        if ([_twoPasswordview.label.text isEqualToString:@"昵称"]) {
             btnType = @"userName";
        }else if ([_twoPasswordview.label.text isEqualToString:@"联系方式"] ){
            [SVProgressHUD showInfoWithStatus:@"货主不能修改电话,公司名称,所在职位"];
        }else if ( [_twoPasswordview.label.text isEqualToString:@"公司名称"]){
            [SVProgressHUD showInfoWithStatus:@"货主不能修改电话,公司名称,所在职位"];
        }else if ([_twoPasswordview.label.text isEqualToString:@"所在职位"]){
            [SVProgressHUD showInfoWithStatus:@"货主不能修改电话,公司名称,所在职位"];
        }
//        else{
//            if ([_twoPasswordview.label.text isEqualToString:@"公司名称"]) {
//                [dict setValue:_twoPasswordview.twoPasswordfield.text forKey:@"orgName"];
//                btnType = @"orgName";
//            }else {
//                 btnType = @"remark";
//            }
//        }
    }else if([self.userModel.userType isEqualToString:@"hxyk"]){
    if ([_twoPasswordview.label.text isEqualToString:@"联系方式"]){
          //  btnType = @"mobilePhone";
        [SVProgressHUD showInfoWithStatus:@"游客不能修改联系方式"];
    }else{
        if ([_twoPasswordview.label.text isEqualToString:@"昵称"]) {
            btnType = @"userName";
        }else if ([_twoPasswordview.label.text isEqualToString:@"公司名称"]){
            btnType = @"orgName";
        }else if ([_twoPasswordview.label.text isEqualToString:@"所在职位"]){
            btnType = @"remark";
        }
    }
    }else{
        if ([_twoPasswordview.label.text isEqualToString:@"联系方式"]){
            btnType = @"mobilePhone";
        }else if ([_twoPasswordview.label.text isEqualToString:@"昵称"]) {
            btnType = @"userName";
        }else if ([_twoPasswordview.label.text isEqualToString:@"公司名称"]){
            btnType = @"orgName";
        }else if ([_twoPasswordview.label.text isEqualToString:@"所在职位"]){
            btnType = @"remark";
        }
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.userModel.userID forKey:@"userId"];
    [phoneDict setObject:btnType forKey:@"type"];
   // NSMutableDictionary  * dict = [NSMutableDictionary dictionary];
    //[dict setObject:_twoPasswordview.twoPasswordfield.text forKey:[phoneDict objectForKey:@"type"]];
    if (![self.userModel.userType isEqualToString:@"hxyk"] && ![self.userModel.userType isEqualToString:@"hxhz"]) {
        if ([btnType isEqualToString:@"mobilePhone"]) {
            if (![self isTrueMobile:_twoPasswordview.twoPasswordfield.text]) {
                [SVProgressHUD showErrorWithStatus:@"电话错误"];
                return;
            }
        }
    }
    if ([btnType isEqualToString:@"userName"]) {
          NSString * temp = [_twoPasswordview.twoPasswordfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (temp.length < 1) {
            [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
            return;
        }
    }
    if ([btnType isEqualToString:@"orgName"]) {
        NSString * temp = [_twoPasswordview.twoPasswordfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (temp.length < 1) {
            [SVProgressHUD showErrorWithStatus:@"公司名字不能为空"];
            return;
        }
    }
    if ([btnType isEqualToString:@"remark"]) {
        NSString * temp = [_twoPasswordview.twoPasswordfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (temp.length < 1) {
            [SVProgressHUD showErrorWithStatus:@"职位不能为空"];
            return;
        }
    }
    [phoneDict setObject:_twoPasswordview.twoPasswordfield.text forKey:[phoneDict objectForKey:@"type"]];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_REVAMAP_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                if ([weakSelf.userModel.userType isEqualToString:@"hxhz"]) {
                    //货主
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",json[@"Data"]] message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
                        RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                        cell.phoneLabel.text = [NSString stringWithFormat:@"%@",json[@"Data"]];
                        cell.phoneLabel.textColor = [UIColor redColor];
                    }];
                    [alert addAction:action];
                    
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alert.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }else{
                    NSDictionary * dict = json[@"Data"];
                    for (NSString * key in dict.allKeys) {
                        if ([key isEqualToString:@"userName"]) {
                            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
                            RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                            cell.phoneLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userName"]];
                            weakSelf.userModel.userName = [dict objectForKey:@"userName"];
                            if ([weakSelf.delegate respondsToSelector:@selector(reRefreshUserNameType:andName:)]) {
                                [weakSelf.delegate reRefreshUserNameType:key andName:[dict objectForKey:@"userName"]];
                            }
                        }
                        else if ([key isEqualToString:@"orgName"]){
                            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:2];
                            RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                            cell.phoneLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orgName"]];
                            weakSelf.userModel.orgName = [dict objectForKey:@"orgName"];
                            if ([weakSelf.delegate respondsToSelector:@selector(reRefreshUserNameType:andName:)]) {
                                [weakSelf.delegate reRefreshUserNameType:key andName:[dict objectForKey:@"orgName"]];
                            }
                        }else if ([key isEqualToString:@"remark"]){
                            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:2];
                            RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                            cell.phoneLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"remark"]];
                            weakSelf.userModel.inviteCode =[dict objectForKey:@"remark"];
                            if ([weakSelf.delegate respondsToSelector:@selector(reRefreshUserNameType:andName:)]) {
                                [weakSelf.delegate reRefreshUserNameType:key andName:[dict objectForKey:@"remark"]];
                            }
                        }
                        if (![weakSelf.userModel.userType isEqualToString:@"hxhz"]&& ![weakSelf.userModel.userType isEqualToString:@"hxyk"] ) {
                            if ([key isEqualToString:@"mobilePhone"]){
                                NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:1];
                                RSPersonSecondCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                                cell.phoneLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"mobilePhone"]];
                                weakSelf.userModel.userPhone =  [dict objectForKey:@"mobilePhone"];
                                if ([weakSelf.delegate respondsToSelector:@selector(reRefreshUserNameType:andName:)]) {
                                    [weakSelf.delegate reRefreshUserNameType:key andName:[dict objectForKey:@"mobilePhone"]];
                                }
                                
                            }
                        }
                    }
                }
                [weakSelf.tableview reloadData];
            }else{
                if ([weakSelf.userModel.userType isEqualToString:@"hxhz"]) {
                    if ([btnType isEqualToString:@"userName"]) {
//                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]]];
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]] message:nil preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:action];
                        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                               alert.modalPresentationStyle = UIModalPresentationFullScreen;
                                           }
                        [weakSelf presentViewController:alert animated:YES completion:nil];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败"];
                }
                [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:weakSelf];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    }];
    [_menuview removeFromSuperview];
    [_twoPasswordview removeFromSuperview];
}

/*
- (void)sureViewTwoPassword:(RSTwoPasswordView *)twopassword andIndexpath:(NSIndexPath *)indexpath{
    //URL_HEADER_TEXT_IOS
     NSDictionary * dict = [NSDictionary dictionary];
    if ([self.userModel.userType isEqualToString:@"hxhz"]) {
        //这边是货主，不允许修改昵称和电话号码
        if (indexpath.section == 1) {
            [SVProgressHUD showInfoWithStatus:@"货主不能修改电话和昵称"];
        }else if (indexpath.section == 2) {
            if (indexpath.row == 0) {
                [dict setValue:twopassword.twoPasswordfield.text forKey:@"orgName"];
            }else{
                [dict setValue:twopassword.twoPasswordfield.text forKey:@"remark"];
            }
        }
    }else{
        if (indexpath.section == 1) {
            if (indexpath.row == 1) {
                [dict setValue:twopassword.twoPasswordfield.text forKey:@"userName"];
            }else{
                [dict setValue:twopassword.twoPasswordfield.text forKey:@"mobilePhone"];
            }
        }else if (indexpath.section == 2){
            if (indexpath.row == 0) {
                [dict setValue:twopassword.twoPasswordfield.text forKey:@"orgName"];
            }else{
                [dict setValue:twopassword.twoPasswordfield.text forKey:@"remark"];
            }
        }
    }
}
*/

//- (void)openPhotoAlbumAndOpenCamera{
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //打开系统相机
//        [self openCamera];
//    }];
//    [alert addAction:action1];
//    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //打开系统相册
//        [self openPhotoAlbum];
//    }];
//    [alert addAction:action2];
//    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //这边去取消操作
//        [alert dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [alert addAction:action3];
//    [self presentViewController:alert animated:YES completion:nil];
//}
//
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
//#pragma mark -- 使用系统的方式打开相机
//- (void)openCamera{
//    //调用系统的相机的功能
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
//    }
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
//             }];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//        } else {
//
//        }
//    }
//}
//
//- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
//{
//    //[[RSMessageView shareMessageView] showMessageWithType:@"努力加载中" messageType:kRSMessageTypeIndicator];
//    __weak typeof(self) weakSelf = self;
//    [PhotoUploadHelper
//     processPickedUIImage:[self scaleToSize:pickedImage ]
//     withMediaMetadata:mediaMetadata
//     completeBlock:^(XPhotoUploaderContentEntity *photo) {
//         _photoEntityWillUpload = photo;
//         [weakSelf uploadUserHead];
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userModel.userPhone forKey:@"mobilePhone"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //POST参数
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    NSArray *avatarArray = [NSArray arrayWithObject:_photoEntityWillUpload.image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    RSWeakself
    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
    [netWork getImageDataWithUrlString:URL_HEADER_SINGEPICTURE withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
//            if (selectIndex == 0) {
//                //这边是背景图片
//                [_oweImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_HEADER_IMAGEURL_PING_IOS,json[@"path"],json[@"fileName"]]] placeholderImage:[UIImage imageNamed:@"beijing"]];
//            }else{
//                //这边是头像
//                [_nameImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_HEADER_IMAGEURL_PING_IOS,json[@"path"],json[@"fileName"]]] placeholderImage:[UIImage imageNamed:@"iconfont-照相机"]];
//            }
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    RSPersonFirstCell * cell = [weakSelf.tableview cellForRowAtIndexPath:index];
                    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_HEADER_IMAGEURL_PING_IOS,json[@"path"],json[@"fileName"]]] placeholderImage:[UIImage imageNamed:@"iconfont-照相机"]];
                    if ([weakSelf.delegate respondsToSelector:@selector(reRefreshUserPicture:)]) {
                        [weakSelf.delegate reRefreshUserPicture:[NSString stringWithFormat:@"%@%@",json[@"path"],json[@"fileName"]]];
                    }
                    //[weakSelf.navigationController popViewControllerAnimated:YES];
                });
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"文件大小不能超过1M"];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
        }
    }];
}

//#pragma mark -- 对图片进行压缩
//- (UIImage *)scaleToSize:(UIImage *)img {
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
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

- (void)removeMenuview{
    [_menuview removeFromSuperview];
    [_twoPasswordview removeFromSuperview];
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
