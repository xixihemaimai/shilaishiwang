//
//  RSContactsViewController.m
//  石来石往
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSContactsViewController.h"
#import "RSContactsCell.h"
#import "JPSalertView.h"

#import "RSContactsSecondCell.h"
#import "RSContactsModel.h"
#import "RSContactsAddressModel.h"
@interface RSContactsViewController ()<UITableViewDataSource,UITableViewDelegate,JPSalertViewdelegate>

@property (nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)JPSalertView *alertView;
/**1就是新增，2就是编辑 */
@property (nonatomic,strong)NSString * funtionType;

/**点击编辑还是删除的位置*/
@property (nonatomic,assign)NSInteger index;


@property (nonatomic,strong)NSMutableArray * contactsArray;

@end

@implementation RSContactsViewController

-(UITableView *)tableview{
    if (!_tableview) {
        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navHeight + navY, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
        _tableview.delegate =self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (JPSalertView *)alertView
{
    if (!_alertView) {
        self.alertView = [[JPSalertView alloc] initWithFrame:CGRectMake(38, (SCH/2) - 148, SCW - 76 , 296)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.delegate = self;
    }
    return _alertView;
}

-(NSMutableArray *)contactsArray{
    if (!_contactsArray) {
        _contactsArray = [NSMutableArray array];
    }
    return _contactsArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.selectype isEqualToString:@"1"]) {
         self.title = @"联系人管理";
    }else{
         self.title = @"联系地址管理";
    }
   
    self.index = 0;
    self.funtionType = @"1";
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableview];
    UIButton * deletBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [deletBtn setTitle:@"新增" forState:UIControlStateNormal];
    [deletBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:deletBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [deletBtn addTarget:self action:@selector(addContactsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadContactsAndAddress];
    
    //URL_ADDCONTACTS_IOS
}



//新增联系人和地址
/**
  * contactsType 联系人类型 person：对应添加联系人和联系电话 address：对应添加联系地址
  * userId 当前用户id
  * contactsAddress  String    Person情况下该值可以不传或者传空  Address情况下该值必传
  * contactsName String    Person情况下该值必传 Address情况下该值可以不传或者传空
  * contactsPhone String    Person情况下该值必传 Address情况下该值可以不传或者传空
  * index UItableviewcell的位置 新增为nil
  * type 可以为新增，编辑，删除
  */
- (void)addContactsAndAddressContactsType:(NSString *)selectype andContactsAddress:(NSString *)contactsAddress andContactsName:(NSString *)contactsName andcontactsPhone:(NSString *)contactsPhone andIndex:(NSInteger)index andType:(NSString *)type andIs_default:(NSInteger)is_default{
    NSString * str = [NSString string];
    if ([selectype isEqualToString:@"1"]) {
        str = @"person";
    }else{
        str = @"address";
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:str forKey:@"contactsType"];
    [phoneDict setObject:contactsAddress forKey:@"contactsAddress"];
    [phoneDict setObject:contactsName forKey:@"contactsName"];
    [phoneDict setObject:contactsPhone forKey:@"contactsPhone"];
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",is_default] forKey:@"is_default"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ADDCONTACTS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"]boolValue];
            if (result) {
                [weakSelf loadContactsAndAddress];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changContacts" object:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
                [weakSelf.tableview reloadData];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableview reloadData];
        }
    }];
}




//联系表操作接口（/contactsAct.do）
//URL_CONTACTSACT_IOS
- (void)loadContactsActAndAddressContactsType:(NSString *)selectype andType:(NSString *)type andContactsAddress:(NSString *)contactsAddress andContactsName:(NSString *)contactsName andContactsPhone:(NSString *)contactsPhone andIs_default:(NSInteger)is_default andContactsId:(NSString *)contactsId{
    /**
     数据项含义    字段名    字段类型    说明
     联系人类型    contactsType    String    联系人类型
     person：对应查询联系人和联系电话
     address：对应查询联系地址
     当前用户id    userId    int
     查询类型    type    String
     删除：delete
     修改:edit
     联系人或联系地址id    contactsId    int
     type=edit的时候需要下列传参
     修改联系地址    contactsAddress    String    修改地址的时候必传
     修改的联系人姓名    contactsName    String    修改联系人的时候 如果只改电话号码则可以不传
     修改的联系人电话    contactsPhone    String    修改联系人的时候 如果只改姓名则可以不传
     */
    NSString * str = [NSString string];
    if ([selectype isEqualToString:@"1"]) {
        str = @"person";
    }else{
        str = @"address";
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:str forKey:@"contactsType"];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:contactsAddress forKey:@"contactsAddress"];
    [phoneDict setObject:contactsName forKey:@"contactsName"];
    [phoneDict setObject:contactsPhone forKey:@"contactsPhone"];
    [phoneDict setObject:type forKey:@"type"];
    [phoneDict setObject:contactsId forKey:@"contactsId"];
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)is_default] forKey:@"is_default"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CONTACTSACT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"]boolValue];
            if (result) {
                 [weakSelf loadContactsAndAddress];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changContacts" object:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
                [weakSelf.tableview reloadData];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableview reloadData];
        }
    }];
}




//获取联系人和地址
- (void)loadContactsAndAddress{
    //URL_GETCONTACTSLIST_IOS
    /**
     联系人类型    contactsType    String    联系人类型
     person：对应查询联系人和联系电话
     address：对应查询联系地址
     当前用户id    userId    int
     查询类型    type    String    查询前三条就传mix
     查询全部则传空或者不传
     */
    NSString * str = [NSString string];
    if ([self.selectype isEqualToString:@"1"]) {
        str = @"person";
    }else{
        str = @"address";
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:str forKey:@"contactsType"];
    [phoneDict setObject:@"" forKey:@"type"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETCONTACTSLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                [weakSelf.contactsArray removeAllObjects];
                if ([weakSelf.selectype isEqualToString:@"1"]) {
                   weakSelf.contactsArray = [RSContactsModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                }else{
                    weakSelf.contactsArray = [RSContactsAddressModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                }
                [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
                [weakSelf.tableview reloadData];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableview reloadData];
        }
    }];
}



//新增
- (void)addContactsAction:(UIButton *)addBtn{
    if ([self.selectype isEqualToString:@"1"]) {
        //这边是添加联系人和电话
        self.alertView.contactsId = @"0";
        self.alertView.IS_DEFAULT = 0;
        self.alertView.selectype = self.selectype;
        self.alertView.firstField.zw_placeHolder = @"联系人";
        self.alertView.secondField.zw_placeHolder = @"联系人电话";
        /**新增*/
        self.alertView.funtionType = @"1";
        self.alertView.label.text = @"新增联系人";
        self.alertView.numberLabel.text = @"联系人电话";
        self.alertView.nameLabel.text = @"名称";
    }else{
        //这变是添加地址
        self.alertView.contactsId = @"0";
        self.alertView.IS_DEFAULT = 0;
        self.alertView.selectype = self.selectype;
        self.alertView.firstField.zw_placeHolder = @"请填写地址";
        self.alertView.numberLabel.hidden = YES;
        self.alertView.secondField.hidden = YES;
        self.alertView.funtionType = @"1";
        self.alertView.label.text = @"联系地址";
        self.alertView.nameLabel.text = @"地址";
    }
    [self.alertView showView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contactsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectype isEqualToString:@"1"]) {
        static NSString * CONTACTSID = @"CONTACTSID";
        RSContactsCell * cell = [tableView dequeueReusableCellWithIdentifier:CONTACTSID];
        if (!cell) {
            cell = [[RSContactsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CONTACTSID];
        }
        RSContactsModel * contactsmodel = self.contactsArray[indexPath.row];
        
       CGSize size = [contactsmodel.CONTACTS_NAME boundingRectWithSize:CGSizeMake(SCW/2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.contactsNameLabel.font} context:nil].size;

        cell.contactsNameLabel.text = contactsmodel.CONTACTS_NAME;
        cell.contactNameNumberLabel.text = contactsmodel.CONTACTS_PHONE;
        
       
        if (contactsmodel.IS_DEFAULT == 1) {
            cell.contactsNameLabel.sd_layout
            .widthIs(size.width);
            cell.defultImageView.hidden = NO;
        }else{
            cell.defultImageView.hidden = YES;
        }
        cell.contactsEditBtn.tag = 100000000 + indexPath.row;
        cell.contactsDeletBtn.tag = 100000000 + indexPath.row;
        [cell.contactsEditBtn addTarget:self action:@selector(editContactsInformation:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contactsDeletBtn addTarget:self action:@selector(cancelContactsInformation:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else{
        static NSString * CONTACTSSECONDID = @"CONTACTSSECONDID";
        RSContactsSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:CONTACTSSECONDID];
        if (!cell) {
            cell = [[RSContactsSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CONTACTSSECONDID];
        }
        RSContactsAddressModel * contactsAddressmodel = self.contactsArray[indexPath.row];
        cell.contactsNameLabel.text = contactsAddressmodel.CONTACTS_ADDRESS;
        CGSize size = [contactsAddressmodel.CONTACTS_ADDRESS boundingRectWithSize:CGSizeMake(SCW/2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.contactsNameLabel.font} context:nil].size;
        cell.contactsNameLabel.sd_layout
        .widthIs(size.width);
        if (contactsAddressmodel.IS_DEFAULT == 1) {
            cell.defultImageView.hidden = NO;
        }else{
            cell.defultImageView.hidden = YES;
        }
        cell.contactsEditBtn.tag = 100000000 + indexPath.row;
        cell.contactsDeletBtn.tag = 100000000 + indexPath.row;
        [cell.contactsEditBtn addTarget:self action:@selector(editContactsInformation:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contactsDeletBtn addTarget:self action:@selector(cancelContactsInformation:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


//编辑
- (void)editContactsInformation:(UIButton *)contactsEditBtn{
    self.index = contactsEditBtn.tag - 100000000;
    //这边可以拿到当前的模型
    if ([self.selectype isEqualToString:@"1"]) {
        RSContactsModel * contactsmodel = self.contactsArray[contactsEditBtn.tag - 100000000];
        //这边是添加联系人和电话
        //是否是默认值
        self.alertView.contactsId = contactsmodel.ContactsId;
        self.alertView.IS_DEFAULT = contactsmodel.IS_DEFAULT;
        self.alertView.selectype = self.selectype;
        self.alertView.firstField.zw_placeHolder = @"联系人";
        self.alertView.secondField.zw_placeHolder = @"联系人电话";
        self.alertView.funtionType = @"2";
        self.alertView.label.text = @"联系人修改";
        self.alertView.numberLabel.text = @"联系人电话";
        self.alertView.nameLabel.text = @"名称";
        self.alertView.firstField.text = contactsmodel.CONTACTS_NAME;
        self.alertView.secondField.text = contactsmodel.CONTACTS_PHONE;
        self.alertView.index = self.index;
    }else{
        //这变是添加地址
        RSContactsAddressModel * contactsAddressmodel = self.contactsArray[contactsEditBtn.tag - 100000000];
        //是否是默认值
        self.alertView.IS_DEFAULT = contactsAddressmodel.IS_DEFAULT;
        self.alertView.contactsId = contactsAddressmodel.ContactsId;
        self.alertView.selectype = self.selectype;
        self.alertView.firstField.zw_placeHolder = @"请填写地址";
        self.alertView.numberLabel.hidden = YES;
        self.alertView.secondField.hidden = YES;
        self.alertView.funtionType = @"2";
        self.alertView.label.text = @"联系地址修改";
        self.alertView.nameLabel.text = @"地址";
        self.alertView.firstField.text = contactsAddressmodel.CONTACTS_ADDRESS;
        //self.alertView.secondField.text = @"";
        self.alertView.secondField.hidden = YES;
        self.alertView.numberLabel.hidden = YES;
        self.alertView.index = self.index;
    }
     [self.alertView showView];
}


//删除
- (void)cancelContactsInformation:(UIButton *)contactsDeletBtn{
     self.index = contactsDeletBtn.tag - 100000000;
    //删除
    //这边可以拿到当前模型
    if ([self.selectype isEqualToString:@"1"]) {
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除联系人" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
            
            RSContactsModel * contactsmodel = self.contactsArray[contactsDeletBtn.tag - 100000000];
            [self loadContactsActAndAddressContactsType:self.selectype andType:@"delete" andContactsAddress:@"" andContactsName:contactsmodel.CONTACTS_NAME andContactsPhone:contactsmodel.CONTACTS_PHONE andIs_default:contactsmodel.IS_DEFAULT andContactsId:contactsmodel.ContactsId];
        }];
    }else{
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除联系地址" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
            RSContactsAddressModel * contactsAddressmodel = self.contactsArray[contactsDeletBtn.tag - 100000000];
            [self loadContactsActAndAddressContactsType:self.selectype andType:@"delete" andContactsAddress:contactsAddressmodel.CONTACTS_ADDRESS andContactsName:@"" andContactsPhone:@"" andIs_default:contactsAddressmodel.IS_DEFAULT andContactsId:contactsAddressmodel.ContactsId];
        }];
    }
//    if ([self.selectype isEqualToString:@"1"]) {
//        //这边是添加联系人和电话
//        RSContactsModel * contactsmodel = self.contactsArray[contactsDeletBtn.tag - 100000000];
//        self.alertView.IS_DEFAULT = contactsmodel.IS_DEFAULT;
//
//        self.alertView.selectype = self.selectype;
//        self.alertView.firstField.zw_placeHolder = @"联系人";
//        self.alertView.secondField.zw_placeHolder = @"联系人电话";
//        self.alertView.funtionType = @"3";
//        self.alertView.label.text = @"删除联系人";
//        self.alertView.numberLabel.text = @"联系人电话";
//        self.alertView.nameLabel.text = @"名称";
//        self.alertView.firstField.text = @"陈先生";
//        self.alertView.secondField.text = @"13950800188";
//        self.alertView.index = self.index;
//    }else{
//        //这变是添加地址
//
//        RSContactsAddressModel * contactsAddressmodel = self.contactsArray[contactsDeletBtn.tag - 100000000];
//        self.alertView.IS_DEFAULT = contactsAddressmodel.IS_DEFAULT;
//
//        self.alertView.selectype = self.selectype;
//        self.alertView.firstField.zw_placeHolder = @"请填写地址";
//        self.alertView.numberLabel.hidden = YES;
//        self.alertView.secondField.hidden = YES;
//        self.alertView.funtionType = @"3";
//        self.alertView.label.text = @"删除地址";
//        self.alertView.nameLabel.text = @"地址";
//        self.alertView.firstField.text = @"市场一部";
//        self.alertView.secondField.hidden = YES;
//        self.alertView.numberLabel.hidden = YES;
//        self.alertView.index = self.index;
//    }
//    [self.alertView showView];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


//新增
- (void)contactsInformationSelectype:(NSString *)selectype andContactsAddress:(NSString *)contactsAddress andContactsName:(NSString *)contactsName andContactsPhone:(NSString *)contactsPhone andIndex:(NSInteger)index andType:(NSString *)type andIs_default:(NSInteger)is_default{
    [self addContactsAndAddressContactsType:selectype andContactsAddress:contactsAddress andContactsName:contactsName andcontactsPhone:contactsPhone andIndex:index andType:type andIs_default:is_default];
    [self.alertView closeView];
}


//编辑
- (void)editContactsActAndAddressContactsType:(NSString *)selectype andType:(NSString *)type andContactsAddress:(NSString *)contactsAddress andContactsName:(NSString *)contactsName andContactsPhone:(NSString *)contactsPhone andIs_default:(NSInteger)is_default andContactsId:(NSString *)contactsId{
    [self loadContactsActAndAddressContactsType:selectype andType:type andContactsAddress:contactsAddress andContactsName:contactsName andContactsPhone:contactsPhone andIs_default:is_default andContactsId:contactsId];
    [self.alertView closeView];
}

//- (void)requestEventAction:(UIButton *)button
//{
//     //这边要分是新增还是编辑还是删除
//    if ([self.selectype isEqualToString:@"1"]) {
//        //这边是联系人
//
//
//
//
//
//
//    }else{
//        //这边是地址
//
//
//
//    }
//
//    [self.alertView closeView];
//   // self.firstfield.text = self.alertView.firstField.text;
//    //self.secondfield.text = self.alertView.secondField.text;
//}

@end
