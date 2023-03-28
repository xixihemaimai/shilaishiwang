//
//  RSMaterialManagementViewController.m
//  石来石往
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSMaterialManagementViewController.h"
#import "RSMateriaManagementCell.h"
#import "RSMaterialDetailsViewController.h"
//新建物料
#import "RSAddingBlocksViewController.h"

#import "RSSalertView.h"


@interface RSMaterialManagementViewController ()<RSSalertViewDelegate>

@property (nonatomic,strong)RSSalertView * salertView;

/**物料名称数据库的数组*/
@property (nonatomic,strong)NSMutableArray * materiallArray;
/**Typelist物料类型数据库的数组*/
@property (nonatomic,strong)NSMutableArray * typeArray;
/**Colorlist颜色数据库的数组*/
@property (nonatomic,strong)NSMutableArray * colorArray;


@property (nonatomic,assign)NSInteger pageNum;

@end

@implementation RSMaterialManagementViewController
- (RSSalertView *)salertView{
    if (!_salertView) {
        //33, (SCH/2) - 175.5
        _salertView = [[RSSalertView alloc]initWithFrame:CGRectMake(33, (SCH/2) - 174, SCW - 66, 348)];
        _salertView.backgroundColor = [UIColor whiteColor];
        _salertView.delegate = self;
        _salertView.layer.cornerRadius = 15;
    }
    return _salertView;
}

- (NSMutableArray *)materiallArray{
    if (!_materiallArray) {
        if ( [[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]){
            if (_materiallArray == nil) {
                _materiallArray = [NSMutableArray array];
            }
        }else{
            RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
            _materiallArray = [personlPublishDB getAllContent];
        }
    }
    return _materiallArray;
}


- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:TYPESQL];
        _typeArray = [personlPublishDB getAllContent];
//        if (_typeArray == nil) {
//            _typeArray = [NSMutableArray array];
//        }
    }
    return _typeArray;
}

- (NSMutableArray *)colorArray{
    if (!_colorArray) {
        RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:COLORSQL];
        _colorArray = [personlPublishDB getAllContent];
//        if (_colorArray == nil) {
//            _colorArray = [NSMutableArray array];
//        }
    }
    return _colorArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"物料管理";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    [addBtn addTarget:self action:@selector(addNewFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    self.pageNum = 2;
    //增加搜索框
//    [self.view addSubview:self.tableview];
    
    [self addSearchBarView];
    if ( [[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]) {
        //从服务器里面那数据，然后在添加到数据库里面的物料名称，类型，颜色三个数据表里面
        [self reloadServiceMaterialNewData];
    }else{
        //这边直接就从物料名称，类型，颜色三个数据表里面拿
    }
}



- (void)reloadServiceMaterialNewData{

    /**
     页码    pageNum    Int
     每页条数    itemNum    Int
     用户id    userId    String
     物料类别    typeId    INTEGER    类别id
     颜色id    colorId    INTEGER    颜色id
     字典添加标识    dicKey    String    字典添加标识：Material
     */
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:@"" forKey:@"name"];
    [phoneDict setObject:@"Material" forKey:@"dicKey"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DICLOAD_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"] boolValue];
            if (isresult) {
                [weakSelf.materiallArray removeAllObjects];
                weakSelf.materiallArray = [RSMaterialModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                //这边怎么添加数据库里面
                [weakSelf.tableview reloadData];
                weakSelf.pageNum = 2;
                RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Materiallist.sqlite"];
                [db deleteAllContent];
                [db batchAddMutableArray:weakSelf.materiallArray];
            }else{
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
            }
        }else{
            weakSelf.pageNum = 2;
            [weakSelf.tableview reloadData];
        }
    }];
}


- (void)addSearchBarView{
    UIView * searchbar = [[UIView alloc]init];
    searchbar.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
   // searchbar.placeholder = @"请输入要搜索的物料";
    //searchbar.delegate = self;
    searchbar.frame =  CGRectMake(0, 0, SCW, 55);
    
    UITextField * textfield = [[UITextField alloc]initWithFrame:CGRectMake(12, 13, SCW - 26, 29)];
    textfield.layer.cornerRadius = 15;
    textfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    textfield.placeholder = @"请输入关键字";
    [searchbar addSubview:textfield];
    textfield.font = [UIFont systemFontOfSize:12];
    UIView * leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 18, 29)];
    leftview.backgroundColor = [UIColor clearColor];
    textfield.leftView = leftview;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    //textfield.borderStyle = UITextBorderStyleRoundedRect;
    [textfield addTarget:self action:@selector(showSearchText:) forControlEvents:UIControlEventEditingChanged];
    self.tableview.tableHeaderView = searchbar;

}


//新建物料
- (void)addNewFunctionAction:(UIButton *)addBtn{
    
    
    if (self.usermodel.pwmsUser.JCSJ_WLZD == 0) {
        
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"你当前没有物料字典权限,不能进行增删改操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
       
        
        
    }else{
        self.salertView.selectFunctionType = @"添加物料";
        self.salertView.materialProductName = @"请输入物料名称";
        RSColorModel * colormodel = self.colorArray[0];
        self.salertView.materialColorName = colormodel.name;
        RSTypeModel * typemodel = self.typeArray[0];
        self.salertView.materialTypeName = typemodel.name;
        self.salertView.index = 0;
        self.salertView.secondIndex = 0;
        self.salertView.typeArray = self.typeArray;
        self.salertView.colorArray = self.colorArray;
        self.salertView.selectType = @"new";
        self.salertView.indextag = self.materiallArray.count;
        [self.salertView showView];
        
        
    }
    
    
   
}


- (void)materialWithContent:(NSString *)content FristName:(NSString *)firstName andSecondName:(NSString *)secondName andColorId:(NSInteger)colorid andTypeID:(NSInteger)typeId andSelectType:(NSString *)selectType andTag:(NSInteger)tag{
    
    
    if ([selectType isEqualToString:@"edit"]) {
        // 动作标识    actKey    String  删除：delete
        
        // 要更改的名字    name    String    当动作标识为删除的时候则可以不传
        // 当前id    id    Int
        // 物料类型id    typeId    Int
        // 颜色id    colorId    Int
        // 字典添加标识    dicKey    String    字典添加标识：Material
        //这边都要对数据库进行处理
        //URL_DICUPDATE_IOS
        RSMaterialModel * materialmodel = self.materiallArray[tag];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:@"update" forKey:@"actKey"];
        [phoneDict setObject:content forKey:@"name"];
        
        //RSColorModel * colormodel = self.colorArray[secondIndex];
        //RSTypeModel * typemodel = self.typeArray[index];
        [phoneDict setObject:[NSNumber numberWithInteger:typeId] forKey:@"typeId"];
        [phoneDict setObject:[NSNumber numberWithInteger:colorid] forKey:@"colorId"];
        [phoneDict setObject:[NSNumber numberWithInteger:materialmodel.MAterialID]forKey:@"id"];
        [phoneDict setObject:@"Material" forKey:@"dicKey"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    [weakSelf reloadServiceMaterialNewData];
                }else{
                    //[SVProgressHUD showErrorWithStatus:@"修改失败"];
                    
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [weakSelf presentViewController:alertView animated:YES completion:nil];
                    
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }];
        
    }else{
        //  物料名称    name    String
        //  物料类别    typeId    INTEGER    类别id
        //  颜色id    colorId    INTEGER    颜色id
        //  字典添加标识    dicKey    String    字典添加标识：'Material'
        
        //URL_DICADD_IOS
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:content forKey:@"name"];
        //RSColorModel * colormodel = self.colorArray[secondIndex];
        //RSTypeModel * typemodel = self.typeArray[index];
        [phoneDict setObject:[NSNumber numberWithInteger:typeId] forKey:@"typeId"];
        [phoneDict setObject:[NSNumber numberWithInteger:colorid] forKey:@"colorId"];
        
        //[phoneDict setObject:selectFristName forKey:@"typeId"];
        //[phoneDict setObject:SecondName forKey:@"colorId"];
        [phoneDict setObject:@"Material" forKey:@"dicKey"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_DICADD_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    [weakSelf reloadServiceMaterialNewData];
                }else{
//                    [SVProgressHUD showErrorWithStatus:@"新增失败"];
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [weakSelf presentViewController:alertView animated:YES completion:nil];
                    
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"新增失败"];
            }
        }];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.materiallArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MATERIAMANAGERMENTID = @"MATERIAMANAGERMENTID";
    RSMateriaManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:MATERIAMANAGERMENTID];
    if (!cell) {
        cell = [[RSMateriaManagementCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MATERIAMANAGERMENTID];
    }
    
    RSMaterialModel * materialmodel = self.materiallArray[indexPath.row];
    if ([materialmodel.name length] > 0) {
       cell.materiaManagemnetNameLabel.text = [NSString stringWithFormat:@"%@",[materialmodel.name substringToIndex:1]];
    }
    cell.nameDetialLabel.text = materialmodel.name;
    cell.typeDetialLabel.text = materialmodel.type;
    cell.editBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    [cell.editBtn addTarget:self action:@selector(materialProductAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn addTarget:self action:@selector(materialProductAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ( [[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]) {
        //从服务器里面那数据，然后在添加到数据库里面的物料名称，类型，颜色三个数据表里面
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
      // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    return cell;
}



- (void)materialProductAction:(UIButton *)btn{
    
    if (self.usermodel.pwmsUser.JCSJ_WLZD == 0) {
        
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"你当前没有物料字典权限,不能进行增删改操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
        
        
        
        
    }else{
        
        RSMaterialModel * materialmodel = self.materiallArray[btn.tag];
        
        if ([self.selectType isEqualToString:@"huangliaoruku"] || [self.selectType isEqualToString:@"kucunguanli"] || [self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"kucunguanli1"]) {
            if ([btn.currentTitle isEqualToString:@"编辑"]) {
                if ([materialmodel.name isEqualToString:self.equallyStr]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该物料已使用,无法编辑" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                    
                }else{
                    // 动作标识    actKey    String    更新:update
                    self.salertView.selectFunctionType = @"添加物料";
                    self.salertView.materialProductName = materialmodel.name;
                    self.salertView.materialColorName = materialmodel.color;
                    self.salertView.materialTypeName = materialmodel.type;
                    self.salertView.typeArray = self.typeArray;
                    self.salertView.colorArray = self.colorArray;
                    self.salertView.selectType = @"edit";
                    self.salertView.indextag = btn.tag;
                    [self.salertView showView];
                }
            }else{
                if ([materialmodel.name isEqualToString:self.equallyStr]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该物料已使用,无法删除" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                    
                }else{
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该项" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                        [phoneDict setObject:@"delete" forKey:@"actKey"];
                        [phoneDict setObject:[NSNumber numberWithInteger:materialmodel.MAterialID]forKey:@"id"];
                        [phoneDict setObject:@"Material" forKey:@"dicKey"];
                        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
                        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                        RSWeakself
                        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                        [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                            if (success) {
                                BOOL isresult = [json[@"success"]boolValue];
                                if (isresult) {
                                    [weakSelf reloadServiceMaterialNewData];
                                }else{
                                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        
                                    }];
                                    [alertView addAction:alert];
                                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                    }
                                    [weakSelf presentViewController:alertView animated:YES completion:nil];
                                    
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"删除失败"];
                            }
                        }];
                    }];
                    [alertView addAction:alert];
                    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert1];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }
            }
        }else{
            if ([btn.currentTitle isEqualToString:@"编辑"]) {
                // 动作标识    actKey    String    更新:update
                self.salertView.selectFunctionType = @"添加物料";
                self.salertView.materialProductName = materialmodel.name;
                self.salertView.materialColorName = materialmodel.color;
                self.salertView.materialTypeName = materialmodel.type;
                self.salertView.typeArray = self.typeArray;
                self.salertView.colorArray = self.colorArray;
                self.salertView.selectType = @"edit";
                self.salertView.indextag = btn.tag;
                [self.salertView showView];
            }else{
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该项" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    // 动作标识    actKey    String  删除：delete
                    
                    // 要更改的名字    name    String    当动作标识为删除的时候则可以不传
                    // 当前id    id    Int
                    // 物料类型id    typeId    Int
                    // 颜色id    colorId    Int
                    // 字典添加标识    dicKey    String    字典添加标识：Material
                    //这边都要对数据库进行处理
                    //URL_DICUPDATE_IOS
                    
                    
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                    [phoneDict setObject:@"delete" forKey:@"actKey"];
                    [phoneDict setObject:[NSNumber numberWithInteger:materialmodel.MAterialID]forKey:@"id"];
                    [phoneDict setObject:@"Material" forKey:@"dicKey"];
                    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
                    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                    RSWeakself
                    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                    [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                        if (success) {
                            BOOL isresult = [json[@"success"]boolValue];
                            if (isresult) {
                                [weakSelf reloadServiceMaterialNewData];
                            }else{
                                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    
                                }];
                                [alertView addAction:alert];
                                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                }
                                [weakSelf presentViewController:alertView animated:YES completion:nil];
                                
                            }
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"删除失败"];
                        }
                    }];
                }];
                [alertView addAction:alert];
                UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertView addAction:alert1];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alertView animated:YES completion:nil];
               
            }
        }
        
    }
}


- (void)showSearchText:(UITextField *)searchTextField{
    NSString *temp = [searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        searchTextField.text = temp;
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
        [self.materiallArray removeAllObjects];
        self.materiallArray = [db serachContent:searchTextField.text];
        [self.tableview reloadData];
        
    }else{
        //取消的或者没有值的时候
        searchTextField.text = @"";
        [searchTextField resignFirstResponder];
        [self reloadServiceMaterialNewData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( [[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]) {
        //从服务器里面那数据，然后在添加到数据库里面的物料名称，类型，颜色三个数据表里面
        
        
        
    }else{
        //这边直接就从物料名称，类型，颜色三个数据表里面拿
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        //选中那条
        RSMaterialModel * materialmodel = self.materiallArray[indexPath.row];
        if ([self.selectType isEqualToString:@"huangliaoruku"] || [self.selectType isEqualToString:@"kucunguanli"] || [self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"kucunguanli1"]) {
            
            if ([materialmodel.name isEqualToString:self.equallyStr]) {
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该物料已使用,无法选择" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alertView animated:YES completion:nil];
                
            }else{
                if (self.selectIndexPathMatermodel) {
                    self.selectIndexPathMatermodel(materialmodel);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }
}



- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


@end
