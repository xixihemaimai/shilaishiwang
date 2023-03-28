//
//  RSPersonalEditionViewController.m
//  石来石往
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonalEditionViewController.h"
#import "RSPersonlEditionHeaderView.h"
#import "RSPersonalEditionCell.h"
#import "RSVariousFunctionsViewController.h"
#import "RSWarehouseManagementViewController.h"

//角色管理
#import "RSMaterialDetailsViewController.h"
//用户管理
#import "RSUserManagementViewController.h"
//物料管理
#import "RSMaterialManagementViewController.h"
//切换账户
#import "RSPwmsUserViewController.h"

//个人版码单模板
#import "RSTemplateViewController.h"
//加工厂
#import "RSProcessingFactoryViewController.h"


#import "RSColorModel.h"
#import "RSTypeModel.h"
#import "RSWarehouseModel.h"
#import "RSMaterialModel.h"

@interface RSPersonalEditionViewController ()<UITableViewDataSource,UITableViewDelegate,RSPersonalEditionCellDelegate>

{
    //账号名称
    UIButton * _roleBtn;
    //颗数
    UILabel * _numberfirstLabel;
    //体积
    UILabel * _areaFirstLabel;
    //重量
    UILabel * _wightFirstLabel;
    //大板
    UILabel * _dabanFirstTurnLabel;
    //大板面积
    UILabel * _dabanAreaFirstView;
    //今日入库
    UILabel * _dayAreaFirstLabel;
    UILabel * _dayWightFirstLabel;
    
    UILabel * _dayDabanFirstAreaLabel;
    //今日出库
    UILabel * _dayOutAreaFirstLabel;
    
    UILabel * _dayOutWightFirstLabel;
    UILabel * _dayOutDabanFirstAreaLabel;
    
}


@property (nonatomic,strong)UITableView * tableview;
/**Typelist物料类型数据库的数组*/
@property (nonatomic,strong)NSMutableArray * typeArray;
/**Colorlist颜色数据库的数组*/
@property (nonatomic,strong)NSMutableArray * colorArray;
/**仓库的数据库数组*/
@property (nonatomic,strong)NSMutableArray * wareHouseArray;
/**物料的数据库数组*/
@property (nonatomic,strong)NSMutableArray * materialArray;
/**加工厂数据库数组*/
@property (nonatomic,strong)NSMutableArray * factoryArray;

@end

@implementation RSPersonalEditionViewController

- (NSMutableArray *)wareHouseArray{
    if (!_wareHouseArray) {
        _wareHouseArray = [NSMutableArray array];
    }
    return _wareHouseArray;
}
- (NSMutableArray *)materialArray{
    if (!_materialArray) {
        _materialArray = [NSMutableArray array];
    }
    return _materialArray;
}



- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        if (_typeArray == nil) {
            _typeArray = [NSMutableArray array];
        }
    }
    return _typeArray;
}

- (NSMutableArray *)colorArray{
    if (!_colorArray) {
        if (_colorArray == nil) {
            _colorArray = [NSMutableArray array];
        }
    }
    return _colorArray;
}

- (NSMutableArray *)factoryArray{
    if (!_factoryArray) {
        _factoryArray = [NSMutableArray array];
    }
    return _factoryArray;
}


- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(retrievingUserInformationAction) name:@"retrievingUserInformation" object:nil];
}

//重新获取用户信息
- (void)retrievingUserInformationAction{
    
//    NSLog(@"==新的====222222===============================================");
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSData * data = [user objectForKey:@"oneUserModel"];
    RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.usermodel = userModel;
    
   // [_roleBtn setTitle:[NSString stringWithFormat:@"%@",self.usermodel.pwmsUser.companyName] forState:UIControlStateNormal];
    

    for (int i = 0; i < 5; i++) {
        if (i == 0) {
            [self reloadServiceColorAndTypeNewData:@"color"];
        }else if(i == 1){
            [self reloadServiceColorAndTypeNewData:@"type"];
        }else if (i == 2){
            [self reloadServiceColorAndTypeNewData:@"warehouse"];
        }else if (i == 3){
            [self reloadServiceColorAndTypeNewData:@"material"];
        }else if (i == 4){
            [self reloadServiceColorAndTypeNewData:@"factory"];
        }
    }
    [self reloadUserInformationData];
    //[self.tableview reloadData];
}







- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    //创建四张数据表
    for (int i = 0; i < 5; i++) {
        NSString * creatType = [NSString string];
        if (i == 0) {
            creatType = WAREHOUSERSQL;
        }else if (i == 1){
             creatType = MATERIALSQL;
        }else if (i == 2){
            creatType = TYPESQL;
        }else if (i == 3){
            creatType = COLORSQL;
        }else if (i == 4){
            creatType = FACTORY;
        }
        RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:creatType];
        BOOL iscreat = [personlPublishDB createContentTable];
        if (iscreat) {
        }else{
            [SVProgressHUD showErrorWithStatus:@"创建失败"];
        }
    }
    
    for (int i = 0; i < 5; i++) {
        if (i == 0) {
            [self reloadServiceColorAndTypeNewData:@"color"];
        }else if(i == 1){
            [self reloadServiceColorAndTypeNewData:@"type"];
        }else if (i == 2){
            [self reloadServiceColorAndTypeNewData:@"warehouse"];
        }else if (i == 3){
            [self reloadServiceColorAndTypeNewData:@"material"];
        }else if (i == 4){
            [self reloadServiceColorAndTypeNewData:@"factory"];
        }
    }
    

}



- (void)reloadServiceColorAndTypeNewData:(NSString *)type{
    
    
    
    /** 页码    pageNum    Int
     每页条数    itemNum    Int
     字典添加标识    dicKey    String    字典添加标识：Color*/
   
    
    
    // 页码    pageNum    Int
    // 每页条数    itemNum    Int
    // 字典添加标识    dicKey    String    字典添加标识：MtlType
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    if ([type isEqualToString:@"color"]) {
        //颜色
        [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
        [phoneDict setObject:@"Color" forKey:@"dicKey"];
    }else if([type isEqualToString:@"type"]){
        //类别
        [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
        [phoneDict setObject:@"MtlType" forKey:@"dicKey"];
    }else if ([type isEqualToString:@"warehouse"]){
        //仓库
        [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
        [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
        [phoneDict setObject:@"WareHouse" forKey:@"dicKey"];
    }else if ([type isEqualToString:@"material"]){
        //物料
        [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
        [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
        [phoneDict setObject:@"" forKey:@"name"];
        [phoneDict setObject:@"Material" forKey:@"dicKey"];
    }else if ([type isEqualToString:@"factory"]){
        //加工厂
        [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
        [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
        [phoneDict setObject:@"" forKey:@"name"];
        [phoneDict setObject:@"Factory" forKey:@"dicKey"];
    }
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
                if ([type isEqualToString:@"color"]) {
                    [weakSelf.colorArray removeAllObjects];
                    weakSelf.colorArray = [RSColorModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:COLORSQL];
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.colorArray];
                }else if([type isEqualToString:@"type"]){
                    [weakSelf.typeArray removeAllObjects];
                    weakSelf.typeArray = [RSTypeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:TYPESQL];
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.typeArray];
                }else if ([type isEqualToString:@"warehouse"]){
                    [weakSelf.wareHouseArray removeAllObjects];
                    weakSelf.wareHouseArray = [RSWarehouseModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:WAREHOUSERSQL];
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.wareHouseArray];
                }else if([type isEqualToString:@"material"]){
                    [weakSelf.materialArray removeAllObjects];
                    weakSelf.materialArray = [RSMaterialModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.materialArray];
                }else if ([type isEqualToString:@"factory"]){
                    [weakSelf.factoryArray removeAllObjects];
                     weakSelf.factoryArray = [RSWarehouseModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:FACTORY];
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.factoryArray];
                }
            }else{
                if ([type isEqualToString:@"color"]) {
                    [SVProgressHUD showErrorWithStatus:@"获取颜色失败"];
                }else if([type isEqualToString:@"type"]){
                    [SVProgressHUD showErrorWithStatus:@"获取类型失败"];
                }else if ([type isEqualToString:@"warehouse"]){
                    [SVProgressHUD showErrorWithStatus:@"获取仓库失败"];
                }else if ([type isEqualToString:@"material"]){
                    [SVProgressHUD showErrorWithStatus:@"获取物料失败"];
                }else if ([type isEqualToString:@"factory"]){
                    [SVProgressHUD showErrorWithStatus:@"获取加工厂失败"];
                }
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}

- (void)setUI{
    self.extendedLayoutIncludesOpaqueBars = YES;
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [self.view addSubview:self.tableview];
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        self.tableview.contentInset = UIEdgeInsetsMake(-44, 0, 30, 0);
    }else{
        self.tableview.contentInset = UIEdgeInsetsMake(-20, 0, 30, 0);
    }
    //这边是tableview的头部视图
    //WithFrame:CGRectMake(0, 0, SCW, 300)
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    //蓝色视图
    UIView * blueView = [[UIView alloc]init];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,SCW,150);
    gl.startPoint = CGPointMake(0.02, 0.04);
    gl.endPoint = CGPointMake(1, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:90/255.0 green:158/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:107/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:107/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f), @(1.0f)];
    [blueView.layer addSublayer:gl];
    [headerView addSubview:blueView];
    blueView.userInteractionEnabled = YES;
    
    //账号名称
    UIButton * roleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // [roleBtn setTitle:[NSString stringWithFormat:@"%@",self.usermodel.pwmsUser.companyName] forState:UIControlStateNormal];
    [roleBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [roleBtn setBackgroundColor:[UIColor clearColor]];
    [roleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    roleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [blueView addSubview:roleBtn];
    [roleBtn bringSubviewToFront:self.view];
    [roleBtn addTarget:self action:@selector(switchRolesAction:) forControlEvents:UIControlEventTouchUpInside];
    _roleBtn = roleBtn;
    
    //标题
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"大众云仓";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [blueView addSubview:titleLabel];
    
    
    
    //总库存数量view
    UIView * totalView = [[UIView alloc]init];
    totalView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:totalView];
    
    
    
    //第一个界面
    UIView * firstView = [[UIView alloc]init];
    [totalView addSubview:firstView];
    
    
    //第二个界面
    UIView * secondView = [[UIView alloc]init];
    [totalView addSubview:secondView];
    
    
    //第三个界面
    UIView * thirdView = [[UIView alloc]init];
    [totalView addSubview:thirdView];
    
    
    
    
    
    UILabel * numberLabel = [[UILabel alloc]init];
    numberLabel.text = @"总库存数量";
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.textColor = [UIColor colorWithHexColorStr:@"#5A6D7F"];
    [totalView addSubview:numberLabel];
    [numberLabel bringSubviewToFront:totalView];
    
    
    
    UILabel * huangLabel = [[UILabel alloc]init];
    huangLabel.text = @"荒料";
    huangLabel.textAlignment = NSTextAlignmentLeft;
    huangLabel.font = [UIFont systemFontOfSize:14];
    huangLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:huangLabel];
    
    
    UIView * firstBlueView = [[UIView alloc]init];
    firstBlueView.backgroundColor = [UIColor colorWithHexColorStr:@"#75C1FB"];
    [totalView addSubview:firstBlueView];
    
    
    
    //颗数
    UILabel * numberfirstLabel =  [[UILabel alloc]init];
    numberfirstLabel.text = @"545颗";
    numberfirstLabel.textAlignment = NSTextAlignmentLeft;
    numberfirstLabel.font = [UIFont systemFontOfSize:14];
    numberfirstLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    //_huangLabel = huangLabel;
    [totalView addSubview:numberfirstLabel];
    _numberfirstLabel = numberfirstLabel;
    
    
    UIView * firstRedView = [[UIView alloc]init];
    firstRedView.backgroundColor = [UIColor colorWithHexColorStr:@"#F07A83"];
    [totalView addSubview:firstRedView];
    
    
    //体积
    UILabel * areaFirstLabel = [[UILabel alloc]init];
    areaFirstLabel.text = @"76474657m³";
    areaFirstLabel.textAlignment = NSTextAlignmentLeft;
    areaFirstLabel.font = [UIFont systemFontOfSize:14];
    areaFirstLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    //_huangLabel = huangLabel;
    [totalView addSubview:areaFirstLabel];
    _areaFirstLabel = areaFirstLabel;
    
    
    UIView * firstGreenLabel = [[UIView alloc]init];
    firstGreenLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#88E0C3"];
    [totalView addSubview:firstGreenLabel];
    
    
    //重量
    UILabel * wightFirstLabel = [[UILabel alloc]init];
    wightFirstLabel.text = @"3836434吨";
    wightFirstLabel.textAlignment = NSTextAlignmentLeft;
    wightFirstLabel.font = [UIFont systemFontOfSize:14];
    wightFirstLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    //_huangLabel = huangLabel;
    [totalView addSubview:wightFirstLabel];
    _wightFirstLabel = wightFirstLabel;
    
    
    
    UILabel * dabanLabel = [[UILabel alloc]init];
    dabanLabel.text = @"大板";
    dabanLabel.textAlignment = NSTextAlignmentLeft;
    dabanLabel.font = [UIFont systemFontOfSize:14];
    dabanLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dabanLabel];
    
    
    UIView * dabanFirstBlueView = [[UIView alloc]init];
    dabanFirstBlueView.backgroundColor = [UIColor colorWithHexColorStr:@"#75C1FB"];
    [totalView addSubview:dabanFirstBlueView];
    
    
    //匝数
    UILabel * dabanFirstTurnLabel = [[UILabel alloc]init];
    dabanFirstTurnLabel.text = @"545匝";
    dabanFirstTurnLabel.textAlignment = NSTextAlignmentLeft;
    dabanFirstTurnLabel.font = [UIFont systemFontOfSize:14];
    dabanFirstTurnLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dabanFirstTurnLabel];
    _dabanFirstTurnLabel = dabanFirstTurnLabel;
    
    
    
    UIView * dabanFirstRedView = [[UIView alloc]init];
    dabanFirstRedView.backgroundColor = [UIColor colorWithHexColorStr:@"#F07A83"];
    [totalView addSubview:dabanFirstRedView];
    
    
    UILabel * dabanAreaFirstView = [[UILabel alloc]init];
    dabanAreaFirstView.text = @"76474657m²";
    dabanAreaFirstView.textAlignment = NSTextAlignmentLeft;
    dabanAreaFirstView.font = [UIFont systemFontOfSize:14];
    dabanAreaFirstView.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dabanAreaFirstView];
    _dabanAreaFirstView = dabanAreaFirstView;
    
    
    
    
    
   
    
    UILabel * dayLabel = [[UILabel alloc]init];
    dayLabel.text = @"今日入库";
    dayLabel.textAlignment = NSTextAlignmentLeft;
    dayLabel.font = [UIFont systemFontOfSize:15];
    dayLabel.textColor = [UIColor colorWithHexColorStr:@"#5A6D7F"];
    [totalView addSubview:dayLabel];
    
    
    
    
    
    
    
    UILabel * dayhuangLabel = [[UILabel alloc]init];
    dayhuangLabel.text = @"荒料";
    dayhuangLabel.textAlignment = NSTextAlignmentLeft;
    dayhuangLabel.font = [UIFont systemFontOfSize:14];
    dayhuangLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayhuangLabel];
    
    
    UIView * dayfirstRedView = [[UIView alloc]init];
    dayfirstRedView.backgroundColor = [UIColor colorWithHexColorStr:@"#F07A83"];
    [totalView addSubview:dayfirstRedView];
    
    UILabel * dayAreaFirstLabel = [[UILabel alloc]init];
    dayAreaFirstLabel.text = @"76474657m³";
    dayAreaFirstLabel.textAlignment = NSTextAlignmentLeft;
    dayAreaFirstLabel.font = [UIFont systemFontOfSize:14];
    dayAreaFirstLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayAreaFirstLabel];
    _dayAreaFirstLabel = dayAreaFirstLabel;
    
    
    
    
    UIView * dayfirstGreenLabel = [[UIView alloc]init];
    dayfirstGreenLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#88E0C3"];
    [totalView addSubview:dayfirstGreenLabel];
    
    UILabel * dayWightFirstLabel = [[UILabel alloc]init];
    dayWightFirstLabel.text = @"3836434吨";
    dayWightFirstLabel.textAlignment = NSTextAlignmentLeft;
    dayWightFirstLabel.font = [UIFont systemFontOfSize:14];
    dayWightFirstLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayWightFirstLabel];
    _dayWightFirstLabel = dayWightFirstLabel;
    
    
    
    
    UILabel * daydabanLabel = [[UILabel alloc]init];
    daydabanLabel.text = @"大板";
    daydabanLabel.textAlignment = NSTextAlignmentLeft;
    daydabanLabel.font = [UIFont systemFontOfSize:14];
    daydabanLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:daydabanLabel];
    
    
    UIView * dayDabanFirstRedView = [[UIView alloc]init];
    dayDabanFirstRedView.backgroundColor = [UIColor colorWithHexColorStr:@"#F07A83"];
    [totalView addSubview:dayDabanFirstRedView];
    
    
    UILabel * dayDabanFirstAreaLabel = [[UILabel alloc]init];
    dayDabanFirstAreaLabel.text = @"76474657m²";
    dayDabanFirstAreaLabel.textAlignment = NSTextAlignmentLeft;
    dayDabanFirstAreaLabel.font = [UIFont systemFontOfSize:14];
    dayDabanFirstAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayDabanFirstAreaLabel];
    _dayDabanFirstAreaLabel = dayDabanFirstAreaLabel;
    
    
    
   
    
    UILabel * dayOutLabel = [[UILabel alloc]init];
    dayOutLabel.text = @"今日出库";
    dayOutLabel.textAlignment = NSTextAlignmentLeft;
    dayOutLabel.font = [UIFont systemFontOfSize:15];
    dayOutLabel.textColor = [UIColor colorWithHexColorStr:@"#5A6D7F"];
    [totalView addSubview:dayOutLabel];
    
    
    
    
    
    
    UILabel * dayOuthuangLabel = [[UILabel alloc]init];
    dayOuthuangLabel.text = @"荒料";
    dayOuthuangLabel.textAlignment = NSTextAlignmentLeft;
    dayOuthuangLabel.font = [UIFont systemFontOfSize:14];
    dayOuthuangLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayOuthuangLabel];
    
    
    
    
    
    
    
    
    UIView * dayOutfirstRedView = [[UIView alloc]init];
    dayOutfirstRedView.backgroundColor = [UIColor colorWithHexColorStr:@"#F07A83"];
    [totalView addSubview:dayOutfirstRedView];
    
    UILabel * dayOutAreaFirstLabel = [[UILabel alloc]init];
    dayOutAreaFirstLabel.text = @"76474657m³";
    dayOutAreaFirstLabel.textAlignment = NSTextAlignmentLeft;
    dayOutAreaFirstLabel.font = [UIFont systemFontOfSize:14];
    dayOutAreaFirstLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayOutAreaFirstLabel];
    _dayOutAreaFirstLabel = dayOutAreaFirstLabel;
    
    
    
    
    UIView * dayOutfirstGreenLabel = [[UIView alloc]init];
    dayOutfirstGreenLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#88E0C3"];
    [totalView addSubview:dayOutfirstGreenLabel];
    
    UILabel * dayOutWightFirstLabel = [[UILabel alloc]init];
    dayOutWightFirstLabel.text = @"3836434吨";
    dayOutWightFirstLabel.textAlignment = NSTextAlignmentLeft;
    dayOutWightFirstLabel.font = [UIFont systemFontOfSize:14];
    dayOutWightFirstLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayOutWightFirstLabel];
    _dayOutWightFirstLabel = dayOutWightFirstLabel;
    
    
    
    
    
    
    
    
    
    
    
    UILabel * dayOutdabanLabel = [[UILabel alloc]init];
    dayOutdabanLabel.text = @"大板";
    dayOutdabanLabel.textAlignment = NSTextAlignmentLeft;
    dayOutdabanLabel.font = [UIFont systemFontOfSize:14];
    dayOutdabanLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
   // [blueView addSubview:dayOutdabanLabel];
     [totalView addSubview:dayOutdabanLabel];
    
    
    UIView * dayOutDabanFirstRedView = [[UIView alloc]init];
    dayOutDabanFirstRedView.backgroundColor = [UIColor colorWithHexColorStr:@"#F07A83"];
    [totalView addSubview:dayOutDabanFirstRedView];
    
    
    UILabel * dayOutDabanFirstAreaLabel = [[UILabel alloc]init];
    dayOutDabanFirstAreaLabel.text = @"76474657m²";
    dayOutDabanFirstAreaLabel.textAlignment = NSTextAlignmentLeft;
    dayOutDabanFirstAreaLabel.font = [UIFont systemFontOfSize:14];
    dayOutDabanFirstAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
    [totalView addSubview:dayOutDabanFirstAreaLabel];
    _dayOutDabanFirstAreaLabel = dayOutDabanFirstAreaLabel;
    
    
    
    

    //底部视图
    UIView * alertView = [[UIView alloc]init];
    alertView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:alertView];
    
    UIImageView * alertImageView = [[UIImageView alloc]init];
    alertImageView.image = [UIImage imageNamed:@"公告"];
    alertImageView.contentMode = UIViewContentModeScaleAspectFill;
    alertImageView.clipsToBounds = YES;
    [alertView addSubview:alertImageView];
    
    UILabel * alertLabel = [[UILabel alloc]init];
    alertLabel.text = @"欢迎试用石来石往货物管理系统试用版";
    alertLabel.textAlignment = NSTextAlignmentLeft;
    alertLabel.font = [UIFont systemFontOfSize:14];
    alertLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [alertView addSubview:alertLabel];
    
    UIImageView * fangImageView = [[UIImageView alloc]init];
    fangImageView.image = [UIImage imageNamed:@"system-moreb"];
    fangImageView.contentMode = UIViewContentModeScaleAspectFill;
    fangImageView.clipsToBounds = YES;
    [alertView addSubview:fangImageView];
    //fangImageView.hidden = YES;
    
    
    
    blueView.sd_layout
    .leftSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 0)
    .topSpaceToView(headerView, 0)
    .heightIs(150);
    
    
    CGRect rect1 = CGRectMake(0, 0, SCW, 150);
    CGRect oldRect = rect1;
    oldRect.size.width = SCW;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(33, 33)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = oldRect;
    blueView.layer.mask = maskLayer;
    
    
 
    
    roleBtn.sd_layout
    .topSpaceToView(blueView, 36)
    .rightSpaceToView(blueView, 15)
    .widthIs(30)
    .heightIs(30);
    
    roleBtn.imageView.sd_layout
    .leftSpaceToView(roleBtn, 4)
    .widthIs(30)
    .heightIs(30);
    
    roleBtn.titleLabel.sd_layout
    .leftSpaceToView(roleBtn.imageView, 5)
    .rightSpaceToView(roleBtn, 0);
    
    
    titleLabel.sd_layout
    .topSpaceToView(blueView, 36)
    .leftSpaceToView(blueView, 15)
    .widthRatioToView(blueView, 0.4)
    .heightIs(34);
    
    
    totalView.sd_layout
    .leftSpaceToView(headerView, 15)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(headerView, 89)
    .heightIs(276);
    
    totalView.layer.cornerRadius = 16;
    totalView.layer.borderColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.2].CGColor;
    totalView.layer.shadowOffset = CGSizeMake(0,0.1);
    totalView.layer.shadowOpacity = 0.1;
    totalView.layer.shadowRadius = 5;
    
    
    firstView.sd_layout
    .leftSpaceToView(totalView, 11)
    .rightSpaceToView(totalView, 11)
    .topSpaceToView(totalView, 12)
    .heightIs(98);
    firstView.layer.cornerRadius = 18;
    
    CAGradientLayer * gradientlayer1 = [[CAGradientLayer alloc]init];
    CGRect rect2 = CGRectMake(0, 0, SCW - 22 - 30, 98);
    [firstView.layer addSublayer:gradientlayer1];
    gradientlayer1.frame = rect2;
    gradientlayer1.startPoint = CGPointMake(0.5, -3.07);
    gradientlayer1.endPoint = CGPointMake(0.5, 1);
    gradientlayer1.colors = @[(__bridge id)[UIColor colorWithRed:47/255.0 green:133/255.0 blue:255/255.0 alpha:0.21].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2].CGColor];
    gradientlayer1.locations = @[@(0), @(1.0f)];
    //firstView.layer.cornerRadius = 18;
    
    
    CGRect rect6 = CGRectMake(0, 0, SCW - 22 - 30, 98);
    CGRect oldRect2 = rect6;
    oldRect2.size.width = SCW - 22 - 30;
    UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect2 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(18, 18)];
    CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.path = maskPath2.CGPath;
    maskLayer2.frame = oldRect2;
    firstView.layer.mask = maskLayer2;
    
    
    
    
    secondView.sd_layout
    .leftEqualToView(firstView)
    .rightEqualToView(firstView)
    .topSpaceToView(firstView, 3)
    .heightIs(78);
    
    
    
    CAGradientLayer * gradientlayer2 = [[CAGradientLayer alloc]init];
    CGRect rect3 = CGRectMake(0, 0, SCW - 22 - 30, 78);
     [secondView.layer addSublayer:gradientlayer2];
    gradientlayer2.frame = rect3;
    gradientlayer2.startPoint = CGPointMake(0.5, -3.07);
    gradientlayer2.endPoint = CGPointMake(0.5, 1);
    gradientlayer2.colors = @[(__bridge id)[UIColor colorWithRed:47/255.0 green:133/255.0 blue:255/255.0 alpha:0.21].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2].CGColor];
    gradientlayer2.locations = @[@(0), @(1.0f)];
    //secondView.layer.cornerRadius = 18;
    
    
    CGRect rect5 = CGRectMake(0, 0, SCW - 22 - 30, 78);
    CGRect oldRect1 = rect5;
    oldRect1.size.width = SCW - 22 - 30;
    UIBezierPath * maskPath1 = [UIBezierPath bezierPathWithRoundedRect:oldRect1 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(18, 18)];
    CAShapeLayer * maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.path = maskPath1.CGPath;
    maskLayer1.frame = oldRect1;
    secondView.layer.mask = maskLayer1;
    
    
    
    
    thirdView.sd_layout
    .leftEqualToView(secondView)
    .rightEqualToView(secondView)
    .topSpaceToView(secondView, 3)
    .heightIs(78);
    
    
    
    CAGradientLayer * gradientlayer3 = [[CAGradientLayer alloc]init];
    CGRect rect4 = CGRectMake(0, 0, SCW - 22 - 30, 78);
    [thirdView.layer addSublayer:gradientlayer3];
    gradientlayer3.frame = rect4;
    gradientlayer3.startPoint = CGPointMake(0.5, -3.07);
    gradientlayer3.endPoint = CGPointMake(0.5, 1);
    gradientlayer3.colors = @[(__bridge id)[UIColor colorWithRed:47/255.0 green:133/255.0 blue:255/255.0 alpha:0.21].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2].CGColor];
    gradientlayer3.locations = @[@(0), @(1.0f)];
    
    
    
    CGRect rect7 = CGRectMake(0, 0, SCW - 22 - 30, 78);
    CGRect oldRect3 = rect7;
    oldRect3.size.width = SCW - 22 - 30;
    UIBezierPath * maskPath3 = [UIBezierPath bezierPathWithRoundedRect:oldRect3 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(18, 18)];
    CAShapeLayer * maskLayer3 = [[CAShapeLayer alloc] init];
    maskLayer3.path = maskPath3.CGPath;
    maskLayer3.frame = oldRect3;
    thirdView.layer.mask = maskLayer3;
    
    
    
    
    
    
    //thirdView.layer.cornerRadius = 18;
    
    
    /**
     area = "2819.203";
     areaIn = 0;
     areaOut = 0;
     qty = 431;
     qtyIn = 2;
     qtyOut = 3;
     turns = 26;
     turnsIn = 0;
     turnsOut = 0;
     volume = "174256.991";
     volumeIn = "15.12";
     volumeOut = "1407.291";
     weight = "704.74";
     */
    
    
    numberLabel.sd_layout
    .leftSpaceToView(totalView, 21)
    .topSpaceToView(totalView, 19)
    .rightSpaceToView(totalView, 21)
    .heightIs(21);
    
    huangLabel.sd_layout
    .leftEqualToView(numberLabel)
    .topSpaceToView(numberLabel, 2)
    .widthIs(30)
    .heightIs(20);
    
    
    firstBlueView.sd_layout
    .heightIs(9)
    .widthEqualToHeight()
    .leftSpaceToView(huangLabel, 5)
    .topSpaceToView(numberLabel, 8);
    
    
    firstBlueView.layer.cornerRadius = firstBlueView.yj_width * 0.5;
    
    
    numberfirstLabel.sd_layout
    .leftSpaceToView(firstBlueView, 5)
    .topEqualToView(huangLabel)
    .bottomEqualToView(huangLabel)
    .widthRatioToView(totalView, 0.3);
    
    
    firstRedView.sd_layout
    .leftEqualToView(firstBlueView)
    .rightEqualToView(firstBlueView)
    .topSpaceToView(firstBlueView, 10)
    .widthIs(9)
    .heightIs(9);
    
    
     firstRedView.layer.cornerRadius = firstRedView.yj_width * 0.5;
    
    areaFirstLabel.sd_layout
    .leftEqualToView(numberfirstLabel)
    .rightEqualToView(numberfirstLabel)
    .topSpaceToView(numberfirstLabel, 0)
    .heightIs(20);
    
    
    firstGreenLabel.sd_layout
    .leftEqualToView(firstRedView)
    .rightEqualToView(firstRedView)
    .topSpaceToView(firstRedView, 10)
    .widthIs(9)
    .heightIs(9);
    
     firstGreenLabel.layer.cornerRadius = firstGreenLabel.yj_width * 0.5;
    
    wightFirstLabel.sd_layout
    .leftEqualToView(areaFirstLabel)
    .topSpaceToView(areaFirstLabel, 0)
    .leftEqualToView(areaFirstLabel)
    .rightEqualToView(areaFirstLabel)
    .heightIs(20);
    
 
    dabanLabel.sd_layout
    .topEqualToView(huangLabel)
    .bottomEqualToView(huangLabel)
    .leftSpaceToView(totalView, SCW/2 )
    .widthIs(30);
    
    
    
    dabanFirstBlueView.sd_layout
    .leftSpaceToView(dabanLabel, 5)
    .heightIs(9)
    .widthEqualToHeight()
    .topSpaceToView(numberLabel, 8);
    dabanFirstBlueView.layer.cornerRadius = dabanFirstBlueView.yj_width * 0.5;
    
    dabanFirstTurnLabel.sd_layout
    .leftSpaceToView(dabanFirstBlueView, 5)
    .topEqualToView(huangLabel)
    .bottomEqualToView(huangLabel)
    .widthRatioToView(totalView, 0.3);
    
    
    dabanFirstRedView.sd_layout
    .leftEqualToView(dabanFirstBlueView)
    .rightEqualToView(dabanFirstBlueView)
    .topSpaceToView(dabanFirstBlueView, 10)
    .heightIs(9)
    .widthEqualToHeight();
    
     dabanFirstRedView.layer.cornerRadius = dabanFirstRedView.yj_width * 0.5;
    
    dabanAreaFirstView.sd_layout
    .leftEqualToView(dabanFirstTurnLabel)
    .rightEqualToView(dabanFirstTurnLabel)
    .topSpaceToView(dabanFirstTurnLabel, 0)
    .heightIs(20);
    
    
    
    dayLabel.sd_layout
    .leftEqualToView(numberLabel)
    .topSpaceToView(wightFirstLabel, 17)
    .rightEqualToView(numberLabel)
    .heightIs(21);
    
    
    
    dayhuangLabel.sd_layout
    .leftEqualToView(dayLabel)
    .topSpaceToView(dayLabel, 2)
    .widthIs(30)
    .heightIs(20);
    
    
    
    dayfirstRedView.sd_layout
    .heightIs(9)
    .widthEqualToHeight()
    .leftSpaceToView(dayhuangLabel, 5)
    .topSpaceToView(dayLabel, 8);
    dayfirstRedView.layer.cornerRadius = dayfirstRedView.yj_width * 0.5;
    
    
    dayAreaFirstLabel.sd_layout
    .leftSpaceToView(dayfirstRedView, 5)
    .topEqualToView(dayhuangLabel)
    .bottomEqualToView(dayhuangLabel)
    .widthRatioToView(totalView, 0.3);
    
    
    
    dayfirstGreenLabel.sd_layout
    .leftEqualToView(dayfirstRedView)
    .rightEqualToView(dayfirstRedView)
    .heightIs(9)
    .widthEqualToHeight()
    .topSpaceToView(dayfirstRedView, 10);
    
     dayfirstGreenLabel.layer.cornerRadius = dayfirstGreenLabel.yj_width * 0.5;
    dayWightFirstLabel.sd_layout
    .leftEqualToView(dayAreaFirstLabel)
    .rightEqualToView(dayAreaFirstLabel)
    .topSpaceToView(dayAreaFirstLabel, 0)
    .heightIs(20);
    
    daydabanLabel.sd_layout
    .leftSpaceToView(totalView, SCW/2)
    .topEqualToView(dayhuangLabel)
    .bottomEqualToView(dayhuangLabel)
    .widthIs(30);
    
   dayDabanFirstRedView.sd_layout
    .heightIs(9)
    .widthEqualToHeight()
    .leftSpaceToView(daydabanLabel, 5)
    .topSpaceToView(dayLabel, 8);
    
    dayDabanFirstRedView.layer.cornerRadius = dayDabanFirstRedView.yj_width * 0.5;
    
    
    
    dayDabanFirstAreaLabel.sd_layout
    .leftSpaceToView(dayDabanFirstRedView, 5)
    .topEqualToView(daydabanLabel)
    .bottomEqualToView(daydabanLabel)
    .widthRatioToView(totalView, 0.3);
    
    
    
    dayOutLabel.sd_layout
    .leftEqualToView(dayLabel)
    .topSpaceToView(dayWightFirstLabel, 14)
    .rightEqualToView(dayLabel)
    .heightIs(21);
    
    
    dayOuthuangLabel.sd_layout
    .leftEqualToView(dayOutLabel)
    .topSpaceToView(dayOutLabel, 2)
    .widthIs(30)
    .heightIs(20);
    
    
    dayOutfirstRedView.sd_layout
    .heightIs(9)
    .widthEqualToHeight()
    .leftSpaceToView(dayOuthuangLabel, 5)
    .topSpaceToView(dayOutLabel, 8);
    dayOutfirstRedView.layer.cornerRadius = dayOutfirstRedView.yj_width * 0.5;
    
    
    dayOutAreaFirstLabel.sd_layout
    .leftSpaceToView(dayOutfirstRedView, 5)
    .topEqualToView(dayOuthuangLabel)
    .bottomEqualToView(dayOuthuangLabel)
    .widthRatioToView(totalView, 0.3);
    
    
    dayOutfirstGreenLabel.sd_layout
    .leftEqualToView(dayOutfirstRedView)
    .rightEqualToView(dayOutfirstRedView)
    .heightIs(9)
    .widthEqualToHeight()
    .topSpaceToView(dayOutfirstRedView, 10);
    
    
    dayOutfirstGreenLabel.layer.cornerRadius = dayOutfirstGreenLabel.yj_width * 0.5;
    
    
    dayOutWightFirstLabel.sd_layout
    .leftEqualToView(dayOutAreaFirstLabel)
    .rightEqualToView(dayOutAreaFirstLabel)
    .topSpaceToView(dayOutAreaFirstLabel, 0)
    .heightIs(20);
    
    
    
    
    
    
    
    
    dayOutdabanLabel.sd_layout
    .leftSpaceToView(totalView, SCW/2)
    .topEqualToView(dayOuthuangLabel)
    .bottomEqualToView(dayOuthuangLabel)
    .widthIs(30);
    
    
    
    dayOutDabanFirstRedView.sd_layout
    .heightIs(9)
    .widthEqualToHeight()
    .leftSpaceToView(dayOutdabanLabel, 5)
    .topSpaceToView(dayOutLabel, 8);
    
    dayOutDabanFirstRedView.layer.cornerRadius = dayOutDabanFirstRedView.yj_width * 0.5;
    
    dayOutDabanFirstAreaLabel.sd_layout
    .leftSpaceToView(dayOutDabanFirstRedView, 5)
    .topEqualToView(dayOutdabanLabel)
    .bottomEqualToView(dayOutdabanLabel)
    .widthRatioToView(totalView, 0.3);
    
    
    
    
    
    
    
    
    
    alertView.sd_layout
    .leftSpaceToView(headerView, 15)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(totalView, 10)
    .heightIs(40);
    alertView.layer.cornerRadius = 13;
    
    alertView.layer.shadowColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.2].CGColor;
    alertView.layer.shadowOffset = CGSizeMake(0,1);
    alertView.layer.shadowOpacity = 1;
    alertView.layer.shadowRadius = 5;
    
    
    

    alertImageView.sd_layout
    .leftSpaceToView(alertView, 15)
    .centerYEqualToView(alertView)
    .heightIs(17)
    .widthIs(40);
    
    alertLabel.sd_layout
    .leftSpaceToView(alertImageView, 13)
    .centerYEqualToView(alertView)
    .heightIs(20)
    .rightSpaceToView(alertView, 25);
    
    fangImageView.sd_layout
    .centerYEqualToView(alertView)
    .rightSpaceToView(alertView, 17)
    .heightIs(12)
    .widthIs(7);
    
    [headerView setupAutoHeightWithBottomView:alertView bottomMargin:10];
    [headerView layoutSubviews];
    self.tableview.tableHeaderView = headerView;
    [self reloadUserInformationData];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadUserInformationData];
    }];
   // self.tableview.frame = CGRectMake(0, 0, SCW, SCH + 200);
}

- (void)reloadUserInformationData{
 //URL_INDEXDATA_IOS
     [SVProgressHUD showWithStatus:@"正在获取中....."];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_INDEXDATA_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                //huangLabel.text = @"荒料 545颗 76474657m³";
                _numberfirstLabel.text = [NSString stringWithFormat:@" %ld颗",(long)[json[@"data"][@"stockCountVo"][@"qty"] integerValue]];
                _areaFirstLabel.text = [NSString stringWithFormat:@"%0.3lfm³",[json
                                                                               [@"data"][@"stockCountVo"][@"volume"] doubleValue]];
                _wightFirstLabel.text = [NSString stringWithFormat:@"%0.3lf吨",[json[@"data"][@"stockCountVo"][@"weight"] doubleValue]];
                _dabanFirstTurnLabel.text = [NSString stringWithFormat:@" %ld匝",(long)[json[@"data"][@"stockCountVo"][@"turns"] integerValue]];
                _dabanAreaFirstView.text = [NSString stringWithFormat:@"%0.3lfm²",[json
                                                                                   [@"data"][@"stockCountVo"][@"area"] doubleValue]];
                _dayWightFirstLabel.text = [NSString stringWithFormat:@"%0.3lf吨",[json[@"data"][@"stockCountVo"][@"weightIn"] doubleValue]];
                _dayAreaFirstLabel.text = [NSString stringWithFormat:@" %0.3lfm³",[json[@"data"][@"stockCountVo"][@"volumeIn"] doubleValue]];
                _dayDabanFirstAreaLabel.text = [NSString stringWithFormat:@" %0.3lfm³",[json[@"data"][@"stockCountVo"][@"areaIn"] doubleValue]];
                _dayOutAreaFirstLabel.text = [NSString stringWithFormat:@" %0.3lfm³",[json[@"data"][@"stockCountVo"][@"volumeOut"] doubleValue]];
                _dayOutWightFirstLabel.text = [NSString stringWithFormat:@"%0.3lf吨",[json[@"data"][@"stockCountVo"][@"weightOut"] doubleValue]];
                _dayOutDabanFirstAreaLabel.text = [NSString stringWithFormat:@" %0.3lfm³",[json[@"data"][@"stockCountVo"][@"areaOut"] doubleValue]];
                [SVProgressHUD dismiss];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                 [weakSelf.tableview.mj_header endRefreshing];
                [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
            }
        }else{
             [weakSelf.tableview.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        }
    }];
}

//FIXME:切换角色
- (void)switchRolesAction:(UIButton *)roleBtn{
    RSPwmsUserViewController * pwmsUserVc = [[RSPwmsUserViewController alloc]init];
    pwmsUserVc.usermodel = self.usermodel;
    [self.navigationController pushViewController:pwmsUserVc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 109;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * PERSONALEDITIONHEADER = @"PERSONALEDITIONHEADER";
    RSPersonlEditionHeaderView * personalEditionHeader = [[RSPersonlEditionHeaderView alloc]initWithReuseIdentifier:PERSONALEDITIONHEADER];
    if (section == 0) {
        personalEditionHeader.titleLabel.text = @"荒料管理";
    }else if (section == 1){
        personalEditionHeader.titleLabel.text = @"大板管理";
    }else if (section == 2){
        personalEditionHeader.titleLabel.text = @"基础数据";
    }else if (section == 3){
        personalEditionHeader.titleLabel.text = @"系统管理";
    }
    return personalEditionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *  PERSONALEDITIONCELL = @"PERSONALEDITIONCELL";
    RSPersonalEditionCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSONALEDITIONCELL];
    if (!cell) {
        cell = [[RSPersonalEditionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSONALEDITIONCELL];
    }
    cell.delegate = self;
    if (indexPath.section == 0) {
        cell.tyle = @"huangliao";
    }else if (indexPath.section == 1){
        cell.tyle = @"daban";
    }else if (indexPath.section == 2){
        cell.tyle = @"jichu";
    }else{
        cell.tyle = @"xitong";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)selectPublishCurrentImage:(UIImage *)CurrentImage{
    if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版荒料入库"]]) {
        //HLGL_HLRK荒料入库
        //HLGL_HLRK_CGRK 荒料采购入库
        //HLGL_HLRK_JGRK 荒料加工入库
        //HLGL_HLRK_PYRK荒料盘盈入库
        if (self.usermodel.pwmsUser.HLGL_HLRK == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"huangliaoruku";
            variousFunctionsVc.title = @"荒料入库";
            variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版荒料出库"]]){
        //HLGL_HLCK 荒料出库
        //HLGL_HLCK_XSCK荒料销售出库
        //HLGL_HLCK_JGCK荒料加工出库
        //HLGL_HLCK_PKCK荒料盘亏出库
        if (self.usermodel.pwmsUser.HLGL_HLCK == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"huangliaochuku";
            variousFunctionsVc.title = @"荒料出库";
             variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版库存管理"]]){
        //HLGL_KCGL 库存管理
        //HLGL_KCGL_YCCL荒料异常处理
        //HLGL_KCGL_DB荒料调拨
        if (self.usermodel.pwmsUser.HLGL_KCGL == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"kucunguanli";
            variousFunctionsVc.title = @"库存管理";
             variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
           [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版报表中心"]]){
        //HLGL_BBZX报表中心
        //HLGL_BBZX_KCYE荒料库存余额
        //HLGL_BBZX_KCLS荒料库存流水
        //HLGL_BBZX_RKMX荒料入库明细
        //HLGL_BBZX_CKMX 荒料出库明细
        if (self.usermodel.pwmsUser.HLGL_BBZX == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"baobiaozhongxin";
            variousFunctionsVc.title = @"报表中心";
             variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版大板入库"]]){
        //DBGL_DBRK大板入库
        //DBGL_DBRK_CGRK大板采购入库
        //DBGL_DBRK_JGRK大板加工入库
        //DBGL_DBRK_PYRK大板盘盈入库
        if (self.usermodel.pwmsUser.DBGL_DBRK == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"dabanruku";
            variousFunctionsVc.title = @"大板入库";
             variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版大板出库"]]){
        //DBGL大板管理
        //DBGL_DBCK大板出库
        //DBGL_DBCK_XSCK大板销售出库
        //DBGL_DBCK_JGCK大板加工出库
        //DBGL_DBCK_PKCK大板盘亏出库
        if (self.usermodel.pwmsUser.DBGL_DBCK == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"dabanchuku";
            variousFunctionsVc.title = @"大板出库";
             variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版库存管理(1)"]]){
        //DBGL_KCGL大板库存管理
        //DBGL_KCGL_YCCL大板异常处理
        //DBGL_KCGL_DB大板调拨
        if (self.usermodel.pwmsUser.DBGL_KCGL == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"kucunguanli1";
            variousFunctionsVc.title = @"库存管理";
             variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版报表中心(1)"]]){
        //DBGL_BBZX 大板报表中心
        //DBGL_BBZX_KCYE大板库存余额
        //DBGL_BBZX_KCLS大板库存流水
        //DBGL_BBZX_RKMX大板入库明细
        //DBGL_BBZX_CKMX大板出库明细
        if (self.usermodel.pwmsUser.DBGL_BBZX == 1) {
            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
            variousFunctionsVc.selectType = @"baobiaozhongxin1";
            variousFunctionsVc.title = @"报表中心";
             variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版数据字典"]]){
        RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
        variousFunctionsVc.selectType = @"shujuzidian";
         variousFunctionsVc.title = @"数据字典";
         [self.navigationController pushViewController:variousFunctionsVc animated:YES];
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版物料字典"]]){
        //JCSJ_CKGL仓库管理
        //JCSJ_WLZD物料字典
        //TYQX通用权利
        if (self.usermodel.pwmsUser.JCSJ_WLZD == 1) {
            //物料字典
            RSMaterialManagementViewController * materialManagementVc = [[RSMaterialManagementViewController alloc]init];
            materialManagementVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:materialManagementVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版用户管理"]]){
        //XTGL系统管理
        //XTGL_JSGL角色管理
        //XTGL_YHGL用户管理
        if (self.usermodel.pwmsUser.XTGL_YHGL == 1) {
            RSUserManagementViewController * variousFunctionsVc = [[RSUserManagementViewController alloc]init];
            variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版角色管理"]]){
        if (self.usermodel.pwmsUser.XTGL_JSGL == 1) {
            RSMaterialDetailsViewController * variousFunctionsVc = [[RSMaterialDetailsViewController alloc]init];
            variousFunctionsVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
        }else{
             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版码单模版"]]){
        if (self.usermodel.pwmsUser.XTGL_MBGL == 1) {
            RSTemplateViewController * templateVc = [[RSTemplateViewController alloc]init];
            templateVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:templateVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版权限管理"]]){
        RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
        variousFunctionsVc.selectType = @"quanxianguli";
        variousFunctionsVc.title = @"权限管理";
        variousFunctionsVc.usermodel = self.usermodel;
         [self.navigationController pushViewController:variousFunctionsVc animated:YES];
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版仓库管理"]]){
        //JCSJ_CKGL仓库管理
        //JCSJ_WLZD物料字典
        //TYQX通用权利
        if (self.usermodel.pwmsUser.JCSJ_CKGL == 1) {
            RSWarehouseManagementViewController * warehouseManagementVc = [[RSWarehouseManagementViewController alloc]init];
            warehouseManagementVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:warehouseManagementVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"加工厂"]]){
        if (self.usermodel.pwmsUser.JCSJ_JGC == 1) {
            RSProcessingFactoryViewController * processingFactoryVc = [[RSProcessingFactoryViewController alloc]init];
            processingFactoryVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:processingFactoryVc animated:YES];
        }else{
             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
