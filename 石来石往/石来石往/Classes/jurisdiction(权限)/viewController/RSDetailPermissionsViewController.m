//
//  RSDetailPermissionsViewController.m
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "RSDetailPermissionsViewController.h"
#import "RSDetailPermissionsHeaderview.h"
#import "RSAccountDetailCell.h"
#import "RSDetailePermissionsCell.h"
#import "RSPermissionsModel.h"
#import "UIColor+HexColor.h"
#import <SDAutoLayout.h>
//#define SCW [UIScreen mainScreen].bounds.size.width
//#define SCH [UIScreen mainScreen].bounds.size.height
#import <SVProgressHUD.h>
#import "RSAccessModel.h"

@interface RSDetailPermissionsViewController ()<UITextFieldDelegate>
{
    UIView * _naviBarview;
    /**第一组图片的数组*/
    NSArray * imageArray;
    /**第一组名字数组*/
    NSArray * nameArray;
    /**textfield中Pla的内容*/
    NSArray * placeArray;
    /**临时保存姓名*/
    NSString * tempName;
    /**临时保存身份证*/
    NSString * tempCard;
    /**临时电话号码*/
    NSString * tempPhone;
    /**临时电话的验证码*/
    NSString * tempPhoneCard;
    NSString * firstStr;
    NSString * secondStr;
    NSString * thirdStr;
    NSString * fourStr;
}
// 用来存放Cell的唯一标示符未完成
@property (nonatomic, strong) NSMutableDictionary *cellDeatailCompelteDic;

@property (nonatomic,strong)NSMutableArray * secondNameArray;

@property (nonatomic,strong)NSMutableArray * secondImageArray;

//@property (nonatomic,strong)UITableView * tableview;
/**用来判断是用修改还是添加*/
@property (nonatomic,assign)BOOL isADDAcount;
/**定时器*/
@property (nonatomic,strong)NSTimer * timer;
/**定时器的时间*/
@property (nonatomic,assign)NSInteger count;

@end

@implementation RSDetailPermissionsViewController

- (NSMutableArray *)secondNameArray{
    if (_secondNameArray == nil) {
        _secondNameArray = [NSMutableArray array];
    }
    return _secondNameArray;
}

- (NSMutableArray *)secondImageArray{
    if (_secondImageArray == nil) {
        _secondImageArray = [NSMutableArray array];
    }
    return _secondImageArray;
}

static NSString * detailCell = @"detailCell";
//static NSString * detaiSecondCell = @"detaSecondCell";
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 60;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [self isAddjust];
    
    //@"账号",
    imageArray = @[@"姓名",@"身份证号码",@"电话号码",@"验证码"];
    //@"账号",
    nameArray = @[@"姓名",@"身份证号码",@"电话号码",@"验证码"];
    //@"请输入账号",
    placeArray = @[@"请输入姓名",@"请输入身份证号码",@"请输入电话号码",@"请输入验证码"];
    //荒料出库
    //self.userModel.access.appManage_ywbl_hlck == 1
    if (self.userModel.appManage_ywbl_hlck == 1) {
        NSString * str = @"荒料出库";
        NSString * imageStr = @"荒料出库1";
        [self.secondNameArray addObject:str];
        [self.secondImageArray addObject:imageStr];
    }
    //大板出库
    //self.userModel.access.appManage_ywbl_dbck == 1
    if (self.userModel.appManage_ywbl_dbck == 1) {
        NSString * str = @"大板出库";
        NSString * imageStr = @"大板出库1";
        [self.secondNameArray addObject:str];
        [self.secondImageArray addObject:imageStr];
    }
    //结算中心
//    if (self.userModel.access.appManage_ywbl_jszx == 1) {
//        NSString * str = @"结算中心";
//        NSString * imageStr = @"结算中心1";
//        [self.secondNameArray addObject:str];
//
//        [self.secondImageArray addObject:imageStr];
//    }
    //报表中心
    //self.userModel.access.appManage_ywbl_bbzx == 1
    if (self.userModel.appManage_ywbl_bbzx == 1) {
        NSString * str = @"报表中心";
        NSString * imageStr = @"报表中心1";
        [self.secondNameArray addObject:str];
        [self.secondImageArray addObject:imageStr];
    }
    //等级评定
//    if (self.userModel.access.appManage_ywbl_djpd == 1) {
//        NSString * str = @"等级评定";
//        NSString * imageStr = @"等级评定1";
//        [self.secondNameArray addObject:str];
//
//        [self.secondImageArray addObject:imageStr];
//    }
    //出库记录
    //self.userModel.access.appManage_ywbl_ckjl == 1
    if (self.userModel.appManage_ywbl_ckjl == 1) {
        NSString * str = @"出库记录";
        NSString * imageStr = @"出库记录1";
        [self.secondNameArray addObject:str];
        [self.secondImageArray addObject:imageStr];
    }
//    //业务办理
//    if (self.userModel.access.appManage_ywbl == 1) {
//
//        NSString * str = @"业务办理";
//        NSString * imageStr = @"石来石往图标设计_44";
//
//        [self.secondNameArray addObject:str];
//
//        [self.secondImageArray addObject:imageStr];
//
//    }
    //我的收藏
    //self.userModel.access.appManage_sc == 1
    if (self.userModel.appManage_sc == 1) {
        NSString * str = @"我的收藏";
        NSString * imageStr = @"收藏1";
        [self.secondNameArray addObject:str];
        [self.secondImageArray addObject:imageStr];
    }
    //商圈
    //self.userModel.access.appManage_sq == 1
//    if (self.userModel.appManage_sq == 1) {
//
//        NSString * str = @"商圈管理";
//        NSString * imageStr = @"商圈管理";
//        [self.secondNameArray addObject:str];
//
//        [self.secondImageArray addObject:imageStr];
//    }
    //石种图片上传
    //self.userModel.access.appManage_tppp == 1
    if (self.userModel.appManage_tppp == 1) {
        NSString * str = @"图片上传";
        NSString * imageStr = @"图片上传";
        [self.secondNameArray addObject:str];
        [self.secondImageArray addObject:imageStr];
    }
    
    //账单付款
//    if (self.userModel.appManage_tppp == 1) {
//        NSString * str = @"账单付款";
//        NSString * imageStr = @" 补充切图 copy 35备份1003";
//        [self.secondNameArray addObject:str];
//        [self.secondImageArray addObject:imageStr];
//    }
    
    
    //财务付款
//    if (self.userModel.appManage_tppp == 1) {
//        NSString * str = @"财务付款";
//        NSString * imageStr = @" 补充切图 copy 35备份1002";
//        [self.secondNameArray addObject:str];
//        [self.secondImageArray addObject:imageStr];
//    }
    
    
    //权限管理
//    if (self.userModel.access.appManage_qxgl == 1) {
//        NSString * str = @"权限管理";
//        NSString * imageStr = @"石来石往图标设计_42";
//        [self.secondNameArray addObject:str];
//        [self.secondImageArray addObject:imageStr];
//    }
    //secondImageArray = @[@"荒料出库",@"大板出库",@"结算中心",@"报表中心",@"等级评定"];
    //secondNameArray = @[@"荒料出库",@"大板出库",@"结算中心",@"报表中心",@"等级评定"];
    self.title = @"权限设置";
    [self addCustomNavigationBar];
    [self addCustonTableview];
    [self.view addSubview:self.tableview];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isADDAcount = YES;
    NSInteger sections = self.tableview.numberOfSections;
    [self cellsForTableView:self.tableview];
    for (int section = 0; section < sections; section++) {
        if (section == 0) {
            NSInteger rows =  [self.tableview numberOfRowsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                RSAccountDetailCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
              //  _cell = cell;
                if (row == 0) {
                    firstStr = cell.textfield.text;
                    if (![firstStr isEqualToString:@""]) {
                        cell.textfield.enabled = NO;
                        cell.textfield.textColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1.0];
                    }
                }else if (row == 1){
                    secondStr = cell.textfield.text;
                    if (![secondStr isEqualToString:@""]) {
                        cell.textfield.enabled = NO;
                        cell.textfield.textColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1.0];
                    }
                }else if (row == 2){
                    thirdStr = cell.textfield.text;
                    if (![thirdStr isEqualToString:@""]) {
                        cell.textfield.enabled = NO;
                        cell.textfield.textColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1.0];
                    }
                }else if (row == 3){
                    if (![firstStr isEqualToString:@""] && ![secondStr isEqualToString:@""] && ![thirdStr isEqualToString:@""]) {
                        cell.textfield.enabled = NO;
                        cell.sendMsgBtn.enabled = NO;
                        cell.textfield.textColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1.0];
                        fourStr = @"1";
                        [cell.sendMsgBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
                    }else{
                        cell.sendMsgBtn.enabled = YES;
                        fourStr = @"";
                        [cell.sendMsgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
                    }
                }
            }
        }
    }
    if ([firstStr isEqualToString:@""]&& [secondStr isEqualToString:@""] && [thirdStr isEqualToString:@""] && [fourStr isEqualToString:@""]) {
        self.isADDAcount = YES;
    }else{
        self.isADDAcount = NO;
    }
//    if ([tempAccount isEqualToString:@""] && [tempName isEqualToString:@""] && [tempCard isEqualToString:@""] && [tempPhone isEqualToString:@""]) {
//        self.isADDAcount = YES;
//    }else{
//        self.isADDAcount = NO;
//    }
}

#pragma mark -- 返回时候的要传的值
-(void)cellsForTableView:(UITableView *)tableView
{
    NSInteger sections = tableView.numberOfSections;
    for (int section = 0; section < sections; section++) {
        if (section == 0) {
            NSInteger rows =  [tableView numberOfRowsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                RSAccountDetailCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
                if (row == 0) {
                    cell.textfield.text = self.perModel.userName;
                    tempName = self.perModel.userName;
                }else if (row == 1){
                    cell.textfield.text = self.perModel.userIdentity;
                    tempCard = self.perModel.userIdentity;
                }else if (row == 2){
                    cell.textfield.text = self.perModel.mobilePhone;
                    tempPhone = self.perModel.mobilePhone;
                }
                else{
                    if (![tempName isEqualToString:@""] && ![tempCard isEqualToString:@""] && ![tempPhone isEqualToString:@""]) {
                         tempPhoneCard = @"";
                    }
                   cell.textfield.text = @"";
                }
            }
        }else{
            NSInteger rows =  [tableView numberOfRowsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                
                NSString * str = self.secondNameArray[row];
                RSDetailePermissionsCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
                if ([str isEqualToString:@"荒料出库"]) {
                    if (self.perModel.acc.appManage_ywbl_hlck == 1) {
                        cell.sw.on = YES;
                    }else{
                        cell.sw.on = NO;
                    }
                }else if ([str isEqualToString:@"大板出库"]){
                 
                    if (self.perModel.acc.appManage_ywbl_dbck == 1) {
                        cell.sw.on = YES;
                    }else{
                        cell.sw.on = NO;
                    }
                }else if ([str isEqualToString:@"结算中心"]){
                    
//                    if (self.perModel.acc.appManage_ywbl_jszx == 1) {
//                        cell.sw.on = YES;
//                    }else{
                        cell.sw.on = NO;
                    cell.sw.enabled = NO;
                   // }
                }else if ([str isEqualToString:@"报表中心"]){
                   
                    if (self.perModel.acc.appManage_ywbl_bbzx == 1) {
                        cell.sw.on = YES;
                    }else{
                        cell.sw.on = NO;
                    }
                }else if ([str isEqualToString:@"等级评定"]){
                    
//                    if (self.perModel.acc.appManage_ywbl_djpd == 1) {
//                        cell.sw.on = YES;
//                    }else{
                        cell.sw.on = NO;
                    cell.sw.enabled = NO;
//                    }
                }else if ([str isEqualToString:@"出库记录"]){
                    
                    if (self.perModel.acc.appManage_ywbl_ckjl == 1) {
                        cell.sw.on = YES;
                    }else{
                        cell.sw.on = NO;
                    }
                }
//                else if ([str isEqualToString:@"业务办理"]){
//                    if (self.perModel.acc.appManage_ywbl == 1) {
//                        cell.sw.on = YES;
//                    }else{
//                        cell.sw.on = NO;
//                    }
//                }
                else if ([str isEqualToString:@"我的收藏"]){
                   
//                    if (self.perModel.acc.appManage_sc == 1) {
                        cell.sw.on = YES;
                    cell.sw.enabled = NO;
//                    }else{
//                        cell.sw.on = NO;
//                    }
                }
//                else if ([str isEqualToString:@"商圈管理"]){
//
//                    if (self.perModel.acc.appManage_sq == 1) {
//                        cell.sw.on = YES;
//                    }else{
//                        cell.sw.on = NO;
//                    }
//                }
                else if ([str isEqualToString:@"图片上传"]){
                    if (self.perModel.acc.appManage_tppp == 1) {
                        cell.sw.on = YES;
                    }else{
                        cell.sw.on = NO;
                    }
                }else if ([str isEqualToString:@"权限管理"]){
                  
//                    if (self.perModel.acc.appManage_qxgl == 1) {
//                        cell.sw.on = YES;
//                    }else{
                        cell.sw.on = NO;
                    cell.sw.enabled = NO;
//                    }
                }
                //还是需要修改的俩个部分
//                else if ([str isEqualToString:@"账单付款"]){
//
//                    if (self.perModel.acc.appManage_qxgl == 1) {
//                        cell.sw.on = YES;
//                    }else{
//                        cell.sw.on = NO;
//                    }
//                }
//                else if ([str isEqualToString:@"财务付款"]){
//
//                    if (self.perModel.acc.appManage_qxgl == 1) {
//                        cell.sw.on = YES;
//                    }else{
//                        cell.sw.on = NO;
//                    }
//                }
            }
        }
    }
}

static NSString * DetailPER = @"detailPER";
- (void)addCustonTableview{
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIButton * delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delectBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delectBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ededed"]];
    [delectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    delectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:delectBtn];
    delectBtn.layer.cornerRadius = 10;
    delectBtn.layer.masksToBounds = YES;
    [delectBtn addTarget:self action:@selector(delectAccountDate:) forControlEvents:UIControlEventTouchUpInside];
    
    bottomView.sd_layout
    .heightIs(80);
    
    delectBtn.sd_layout
    .centerYEqualToView(bottomView)
    .leftSpaceToView(bottomView, 38)
    .rightSpaceToView(bottomView, 41)
    .heightIs(35);
    self.tableview.tableFooterView = bottomView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return imageArray.count;
    }else{
        return self.secondNameArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RSAccountDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:detailCell];
        if (!cell) {
            cell = [[RSAccountDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailCell];
        }
            cell.cellImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
           cell.cellImage.contentMode = UIViewContentModeScaleAspectFill;
            cell.titleNameLabel.text = [NSString stringWithFormat:@"%@", nameArray[indexPath.row]];
            cell.textfield.placeholder = [NSString stringWithFormat:@"%@", placeArray[indexPath.row]];
            cell.textfield.tag = 1000+indexPath.row;
           [cell.textfield addTarget:self action:@selector(showTextfieldData:) forControlEvents:UIControlEventEditingChanged];
            cell.textfield.delegate = self;
        if (indexPath.row <= 2) {
            cell.sendMsgBtn.hidden = YES;
            cell.sendMsgBtn.sd_layout
            .widthIs(1);
        }else{
            cell.sendMsgBtn.hidden = false;
            cell.sendMsgBtn.sd_layout
            .widthIs(80);
        }
        [cell.sendMsgBtn addTarget:self action:@selector(sendMessageMethod:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *identifier = [_cellDeatailCompelteDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
        if (identifier == nil) {
            identifier = [NSString stringWithFormat:@"%@%@", @"detaSecondCell", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDeatailCompelteDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
            [self.tableview registerClass:[RSDetailePermissionsCell class] forCellReuseIdentifier:identifier];
        }
        RSDetailePermissionsCell * detailePermissionsCell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (!detailePermissionsCell) {
//            detailePermissionsCell = [[RSDetailePermissionsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//        }
        //if (indexPath.row == 0) {
            detailePermissionsCell.permissionsImage.image = [UIImage imageNamed:self.secondImageArray[indexPath.row]];
        detailePermissionsCell.permissionsImage.contentMode = UIViewContentModeScaleAspectFill;
            detailePermissionsCell.permissionsNameLabel.text =[NSString stringWithFormat:@"%@",self.secondNameArray[indexPath.row]];
        
            detailePermissionsCell.sw.tag = 10000+indexPath.row;
         detailePermissionsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detailePermissionsCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (iPhone4 || iPhone5) {
        if (indexPath.section == 1) {
            return 42;
        }else{
            return 40;
        }
    }else{
       return 50;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
   // [self reloadTableviewSwithStatus];
}

#pragma mark -- 子账号信息
- (void)showTextfieldData:(UITextField *)textfield{
    //要满足正则
    switch (textfield.tag) {
        case 1000:
            tempName = textfield.text;
            break;
        case 1001:
            tempCard = textfield.text;
            break;
        case  1002:
            //这边要对电话号码进行判断是货主还是游客，还是没有注册的情况
        {
            NSString * temp2 = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (temp2.length == 11 && [self isTrueMobile:temp2]) {
                //对电话号码进行判断
                tempPhone = temp2;
            }else{
                tempPhone = @"";
                //[SVProgressHUD showInfoWithStatus:@"手机号码不对"];
            }
        }
            break;
       case 1003:
            tempPhoneCard = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            break;
    }
}

#pragma mark -- 发送短信的按键
- (void)sendMessageMethod:(UIButton *)sendMsg{
    if (tempPhone.length == 11) {
        [self startTime];
        [self verifyPhoneNumber:tempPhone];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请重新输入电话号码"];
    }
}

#pragma mark -- 定时器
- (void)startTime{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendMsgTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark -- 接收定时器
- (void)stopTime{
    [self.timer invalidate];
    self.timer = nil;
    self.count = 60;
    NSInteger sections = self.tableview.numberOfSections;
    for (int section = 0; section < sections; section++) {
        if (section == 0) {
            NSInteger rows =  [self.tableview numberOfRowsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                RSAccountDetailCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
                if (row == 3) {
                    [cell.sendMsgBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                   // [[cell.sendMsgBtn setBackgroundImage:[UIColor colorWithHexColorStr:@"#1c98e6"] forState:UIControlStateNormal]];
                    [cell.sendMsgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
                }
            }
        }
    }
}

#pragma mark -- 定时器每个一秒执行的动作
- (void)sendMsgTime{
    self.count--;
    NSInteger sections = self.tableview.numberOfSections;
    for (int section = 0; section < sections; section++) {
        if (section == 0) {
            NSInteger rows =  [self.tableview numberOfRowsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                RSAccountDetailCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
                if (row == 3) {
                    [cell.sendMsgBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)self.count] forState:UIControlStateNormal];
                    cell.sendMsgBtn.enabled = NO;
                    [cell.sendMsgBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
                    
                    if (self.count <= 0) {
                        [cell.sendMsgBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        cell.sendMsgBtn.enabled = YES;
                        [cell.sendMsgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
                        self.count = 60;
                        [self stopTime];
                    }
                    //break;
                }
            }
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [self stopTime];
}

- (void)verifyPhoneNumber:(NSString *)phoneStr{
    if (phoneStr.length == 11 && [self isTrueMobile:tempPhone]) {
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:phoneStr forKey:@"mobilePhone"];
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        RSWeakself
        [network getDataWithUrlString:URL_CHILDACCOUNT_PHONESTYLE withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    [SVProgressHUD showSuccessWithStatus:json[@"MSG_CODE"]];
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:json[@"MSG_CODE"]];
                    [weakSelf stopTime];
                }
            }else{
                [weakSelf stopTime];
                [SVProgressHUD showInfoWithStatus:@"电话已注册"];
            }
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"电话号码不对"];
    }
}

#pragma mark -- 删除地方
- (void)delectAccountDate:(UIButton *)btn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除子账号" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
    } confirm:^{
       //URL_DELCHILDACCESS_IOS
          //入参：childId -->子账户id
          //if (self.isADDAcount == NO) {
          NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
          NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
          NSMutableDictionary * registerDict = [NSMutableDictionary dictionary];
          [registerDict setObject:self.perModel.childId forKey:@"childId"];
          //二进制数
          NSData *data = [NSJSONSerialization dataWithJSONObject:registerDict options:0 error:nil];
          NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
          NSDictionary *parameters = @{@"key":[NSString get_uuid],@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
          XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
          [network getDataWithUrlString:URL_DELCHILDACCESS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
              if (success) {
                  BOOL Result = [json[@"Result"] boolValue];
                  if (Result) {
                      //返回上一个页面
                      [self.navigationController popViewControllerAnimated:YES];
                      [[NSNotificationCenter defaultCenter]postNotificationName:@"deletePermissionsdata" object:nil];
                      [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                  }else{
                      [SVProgressHUD showInfoWithStatus:@"删除失败"];
                  }
              }else{
                  [SVProgressHUD showInfoWithStatus:@"删除失败"];
              }
          }];
        
        
    }];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSDetailPermissionsHeaderview *deatilPermissions = [[RSDetailPermissionsHeaderview alloc]initWithReuseIdentifier:DetailPER];
    deatilPermissions.contentView.backgroundColor = [UIColor whiteColor];
    if (section == 0) {
        deatilPermissions.nameLabel.text = @"子账号信息";
    }else{
        deatilPermissions.nameLabel.text = @"权限";
    }
    return deatilPermissions;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark -- 界面导航栏
- (void)addCustomNavigationBar{
    UIButton * saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveSetingDate:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
}

#pragma mark -- 保存权限设置的里面的数据
- (void)saveSetingDate:(UIButton *)btn{
    
//    if (![self isEnglishAndChinese:tempAccount]) {
//        [SVProgressHUD showErrorWithStatus:@"账号错误"];
//        return;
//    }
//    if ([self isNameValid:tempName]) {
//        [SVProgressHUD showErrorWithStatus:@"姓名错误"];
//        return;
//    }
    NSString *temp = [tempName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (temp.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"姓名错误"];
        return;
    }
    if (![self checkUserID:tempCard]) {
        [SVProgressHUD showErrorWithStatus:@"身份证错误"];
        return;
    }
    if (![self isTrueMobile:tempPhone]) {
        [SVProgressHUD showErrorWithStatus:@"电话错误"];
        return;
    }
    if (self.isADDAcount == YES) {
        //添加
        NSString * str = [NSString stringWithFormat:@"电话号码:%@\n" @"初始密码:123456",tempPhone];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"子账号生成" message:str preferredStyle:UIAlertControllerStyleAlert];
        RSWeakself
       UIAlertAction  * sureAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf saveChildAccountNetworkDataAndPermissionsName:tempName andMobilePhone:tempPhone andUserIdentity:tempCard andPhoneCard:tempPhoneCard];
        }];
        UIAlertAction * deleteAction = [UIAlertAction actionWithTitle:@"我取消了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [SVProgressHUD showInfoWithStatus:@"你取消了创建子账号"];
        }];
        [alert addAction:sureAction];
        [alert addAction:deleteAction];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                               alert.modalPresentationStyle = UIModalPresentationFullScreen;
                           }
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        // 修改
        // self.perModel.accountLabel = tempAccount;
        // self.perModel.userName = tempName;
        // self.perModel.userIdentity = tempCard;
        // self.perModel.mobilePhone = tempPhone;
        // self.perModel.isHuangliao = isTempHuanLiao;
        // self.perModel.isdaban = isTempDaBan;
        // self.perModel.isjiesuan = isTempJieSuan;
        // self.perModel.isbaobiao = isTempBaoBiao;
        // self.perModel.isdengji = isTempDenJi;
        [self modificationChildAccountNetworkDataAndAndPermissionsName:tempName andMobilePhone:tempPhone andUserIdentity:tempCard];
    }
}

- (NSMutableArray *)comparePermissionsChoice{
    NSMutableArray * array = [NSMutableArray array];
    NSInteger sections = self.tableview.numberOfSections;
    for (int section = 0; section < sections; section++) {
        if (section == 1) {
            NSInteger rows =  [self.tableview numberOfRowsInSection:section];
            for (int row = 0; row < rows; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                NSString * str = self.secondNameArray[row];
                RSDetailePermissionsCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
                if ([str isEqualToString:@"荒料出库"]) {
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_ywbl_hlck";
                        [array addObject:str];
                    }
                }else if ([str isEqualToString:@"大板出库"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_ywbl_dbck";
                        [array addObject:str];
                    }
                }
                else if ([str isEqualToString:@"结算中心"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_ywbl_jszx";
                        [array addObject:str];
                    }
                }
                else if ([str isEqualToString:@"报表中心"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_ywbl_bbzx";
                        [array addObject:str];
                    }
                }
                else if ([str isEqualToString:@"等级评定"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_ywbl_djpd";
                        [array addObject:str];
                    }
                }
                else if ([str isEqualToString:@"出库记录"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_ywbl_ckjl";
                        [array addObject:str];
                    }
                }
//                else if ([str isEqualToString:@"业务办理"]){
//                    if (cell.sw.on == YES) {
//                        NSString * str = @"appManage_ywbl";
//                        [array addObject:str];
//                    }
//                }
                else if ([str isEqualToString:@"我的收藏"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_sc";
                        [array addObject:str];
                    }
                }
//                else if ([str isEqualToString:@"商圈管理"]){
//                    if (cell.sw.on == YES) {
//                        NSString * str = @"appManage_sq";
//                        [array addObject:str];
//                    }
//                }
                else if ([str isEqualToString:@"图片上传"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_tppp";
                        [array addObject:str];
                    }
                }else if ([str isEqualToString:@"权限管理"]){
                    if (cell.sw.on == YES) {
                        NSString * str = @"appManage_qxgl";
                        [array addObject:str];
                    }
                }
                //这还需要修改权限字符串
//                else if ([str isEqualToString:@"账单付款"]){
//                    if (cell.sw.on == YES) {
//                        NSString * str = @"appManage_qxgl";
//                        [array addObject:str];
//                    }
//                }
//                else if ([str isEqualToString:@"财务付款"]){
//                    if (cell.sw.on == YES) {
//                        NSString * str = @"appManage_qxgl";
//                        [array addObject:str];
//                    }
//                }
            }
        }
    }
    return array;
}

#pragma mark -- 保存的子账号的网络请求
//andIsTempHuanLiao:(BOOL)isHuanLiao andIsTempDaBan:(BOOL)isDaBan andIsTempJieSuan:(BOOL)isJieSuan andIsTempBaoBiao:(BOOL)isBaoBiao andIsTempDenJi:(BOOL)isDenJi andIsTempChuku:(BOOL)isChuku
- (void)saveChildAccountNetworkDataAndPermissionsName:(NSString *)userName andMobilePhone:(NSString *)mobilePhone andUserIdentity:(NSString *)userIdentity andPhoneCard:(NSString *)phoneCard{
    NSMutableDictionary * registerDict = [NSMutableDictionary dictionary];
    [registerDict setObject:userIdentity forKey:@"userIdentity"];
    [registerDict setObject:userName forKey:@"userName"];
    [registerDict setObject:mobilePhone forKey:@"mobilePhone"];
    [registerDict setObject:[NSString stringWithFormat:@"%@",@"feiyouke"] forKey:@"flag"];
    [registerDict setObject:self.userModel.userID forKey:@"userId"];
    [registerDict setObject:phoneCard forKey:@"phoneCode"];
    [registerDict setObject:self.userModel.curErpUserCode forKey:@"erpUserCode"];
    //要去对比下
    NSMutableArray * array = nil;
    array = [self comparePermissionsChoice];
    [registerDict setObject:array forKey:@"childAccess"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:registerDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    RSWeakself
    [network getDataWithUrlString:URL_REGISTE_OFFICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"deletePermissionsdata" object:nil];
                [weakSelf stopTime];
                
            }else{
                NSString * str = [NSString stringWithFormat:@"%@",json[@"MSG_CODE"]];
                [SVProgressHUD showErrorWithStatus:str];
                [weakSelf stopTime];
            }
        }else{
            [weakSelf stopTime];
            [SVProgressHUD showErrorWithStatus:@"添加子账号失败"];
        }
    }];
}
#pragma mark -- 修改子账号的权限的网络请求
//andIsTempHuanLiao:(BOOL)isHuanLiao andIsTempDaBan:(BOOL)isDaBan andIsTempJieSuan:(BOOL)isJieSuan andIsTempBaoBiao:(BOOL)isBaoBiao andIsTempDenJi:(BOOL)isDenJi andIsTempChuku:(BOOL)isChuku
- (void)modificationChildAccountNetworkDataAndAndPermissionsName:(NSString *)userName andMobilePhone:(NSString *)mobilePhone andUserIdentity:(NSString *)userIdentity {
    //URL_UPDATECHILDACCESS_IOS
    //childId ：子账户id
    //childAccess ：权限集合
    NSMutableDictionary * registerDict = [NSMutableDictionary dictionary];
    [registerDict setObject:self.perModel.childId forKey:@"childId"];
    //[registerDict setObject:self.userModel.userID forKey:@"userId"];
    NSMutableArray * array = nil;
    array = [self comparePermissionsChoice];
    [registerDict setObject:array forKey:@"childAccess"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:registerDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_UPDATECHILDACCESS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"deletePermissionsdata" object:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:@"添加子账号失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"添加子账号失败"];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
