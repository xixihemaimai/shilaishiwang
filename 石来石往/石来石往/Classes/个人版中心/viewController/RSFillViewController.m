//
//  RSFillViewController.m
//  石来石往
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//
#import "RSFillViewController.h"
#import "RSWarehouseManagementViewController.h"
#import "RSSaveAlertView.h"
//大板采购入库组头
#import "RSDabanPurchaseHeaderView.h"
//大板采购入库组尾
#import "RSDabanPurchaseFootView.h"
//大板采购入库的Cell
#import "RSDabanPurchaseCell.h"
//荒料入库的cell
#import "RSExceptionHandlingSecondDetailCell.h"
//选择荒料库存
#import "RSSelectiveInventoryViewController.h"
//选择大板库存
#import "RSChoosingInventoryViewController.h"
//进入荒料入库的编辑页面
//#import "RSAlterationOfWasteMaterialViewController.h"
//荒料入库添加荒料
#import "RSAddingBlocksViewController.h"
#import "RSExceptionHanlingSecondCell.h"
#import "RSExceptionHandlingThirdCell.h"
//编辑大板信息
#import "RSBigBoardChangeViewController.h"
//荒料入库扫描返回的模型
#import "RSOcrBlockJsonModel.h"
#import "RSOcrBlockDetailModel.h"
//模型
#import "RSSelectiveInventoryModel.h"
//扫描的界面
#import "MADCameraCaptureController.h"
//大板入库模型
#import "RSChoosingInventoryModel.h"
#import "RSChoosingSliceModel.h"
#import "RSRightPitureButton.h"

@interface RSFillViewController ()
//荒料入库扫描的返回的模型
@property (nonatomic,strong)RSOcrBlockJsonModel * ocrBlockJsonModel;
@property (nonatomic,strong)RSSaveAlertView * saveAlertView;
@property (nonatomic,strong)NSMutableArray * dataArray;
/**仓库数据库的数组*/
@property (nonatomic,strong)NSMutableArray * warehouseArray;
/**物料名称数据库的数组*/
@property (nonatomic,strong)NSMutableArray * materiallArray;
@end

@implementation RSFillViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)warehouseArray{
    if (!_warehouseArray) {
        RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:WAREHOUSERSQL];
        _warehouseArray = [personlPublishDB getAllContent];
        if (_warehouseArray == nil) {
            _warehouseArray = [NSMutableArray array];
        }
    }
    return _warehouseArray;
}

- (NSMutableArray *)materiallArray{
    if (!_materiallArray) {
        RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
       // personlPublishDB.creatList = @"Materiallist.sqlite";
        _materiallArray = [personlPublishDB getAllContent];
        if (_materiallArray == nil) {
            _materiallArray = [NSMutableArray array];
        }
    }
    return _materiallArray;
}

- (RSSaveAlertView *)saveAlertView{
    if (!_saveAlertView) {
        if ([self.selectType isEqualToString:@"dabanchuku"]) {
             _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 168, SCW,168)];
        }else{
            _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 112, SCW, 112)];
        }
    }
    return _saveAlertView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //self.tabBarController.tabBar.hidden = YES;
    
}


static NSString * DABANPURCHASEHEADERVIEW = @"DABANPURCHASEHEADERVIEW";
static NSString * DABANPURCHASEFOOTVIEW = @"DABANPURCHASEFOOTVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    //这个界面可以为（荒料入库）填写入库单，（荒料出库）填写出库单，（大板入库）大板填写入库单，（大板出库）大板填写出库单，(调拨)调拨详情，
//    [self.view addSubview:self.tableview];
    //荒料和大板不同
    if ([self.selectType isEqualToString:@"huangliaoruku"]) {
        [self setUI];
    }else if ([self.selectType isEqualToString:@"huangliaochuku"] || [self.selectType isEqualToString:@"dabanchuku"]){
        [self setDifferentUI];
    }else if ([self.selectType isEqualToString:@"dabanruku"]){
        [self setDabanUI];
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        if ([self.selectFunctionType isEqualToString:@"调拨"]) {
             [self setDiaoBoUI];
        }
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        if ([self.selectFunctionType isEqualToString:@"调拨"]) {
            [self setDiaoBoUI];
        }
    }
    //底部视图
    [self setUIBottomView];
}


//荒料填写入库单和荒料填写入库单 copy2
- (void)setUI{
    //添加tableview头部视图
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 106)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.tableHeaderView = topView;
    //选择仓库
    UIView * fristView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 49)];
    fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:fristView];
    
    UILabel * warehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 31, 21)];
    warehouseLabel.text = @"仓库";
    warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    warehouseLabel.font = [UIFont systemFontOfSize:15];
    warehouseLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseLabel];
    
    
    UILabel * warehouseDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(warehouseLabel.frame) + 17, 13, SCW/2, 21)];
    warehouseDetailLabel.text = @"请选择仓库";
    warehouseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    warehouseDetailLabel.font = [UIFont systemFontOfSize:15];
    warehouseDetailLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseDetailLabel];
    
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
     [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
   // [addBtn setTitle:@"+" forState:UIControlStateNormal];
   // [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 49)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:secondView];
    
    
    UILabel * materialLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    materialLabel.text = @"物料信息";
    materialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    materialLabel.font = [UIFont systemFontOfSize:15];
    materialLabel.textAlignment = NSTextAlignmentLeft;
    [secondView addSubview:materialLabel];
    
    UIButton * scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(SCW - 50 - 62, 13, 62, 28);
    // scanLabel.text = @"扫描";
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    //scanLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    [scanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [scanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    //scanLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    //scanLabel.font = [UIFont systemFontOfSize:14];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:scanBtn];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
    
    UIButton * addSecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addSecondBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
     [addSecondBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
   // [addSecondBtn setTitle:@"+" forState:UIControlStateNormal];
   // [addSecondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [secondView addSubview:addSecondBtn];
    addSecondBtn.layer.cornerRadius = addSecondBtn.yj_width * 0.5;
    [addSecondBtn addTarget:self action:@selector(addScanContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


//大板填写入库单
- (void)setDabanUI{
    //添加tableview头部视图
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 106)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.tableHeaderView = topView;
    //选择仓库
    UIView * fristView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 49)];
    fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:fristView];
    
    UILabel * warehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 31, 21)];
    warehouseLabel.text = @"仓库";
    warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    warehouseLabel.font = [UIFont systemFontOfSize:15];
    warehouseLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseLabel];
    
    
    UILabel * warehouseDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(warehouseLabel.frame) + 17, 13, SCW/2, 21)];
    warehouseDetailLabel.text = @"请选择仓库";
    warehouseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    warehouseDetailLabel.font = [UIFont systemFontOfSize:15];
    warehouseDetailLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseDetailLabel];
    
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
     [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    //[addBtn setTitle:@"+" forState:UIControlStateNormal];
    //[addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 49)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:secondView];
    
    
    UILabel * materialLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    materialLabel.text = @"物料信息";
    materialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    materialLabel.font = [UIFont systemFontOfSize:15];
    materialLabel.textAlignment = NSTextAlignmentLeft;
    [secondView addSubview:materialLabel];
    
    UIButton * scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(SCW - 12 - 62, 13, 62, 28);
    // scanLabel.text = @"扫描";
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    //scanLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    [scanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [scanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    //scanLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    //scanLabel.font = [UIFont systemFontOfSize:14];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:scanBtn];
    //采购入库的方法
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
}


//荒料入库-采购入库
- (void)addScanContentAction:(UIButton *)addSecondBtn{
    if ([self.selectType isEqualToString:@"huangliaoruku"]){
        
        
        RSAddingBlocksViewController * addingBlocksVc = [[RSAddingBlocksViewController alloc]init];
        [self.navigationController pushViewController:addingBlocksVc animated:YES];
        
        
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
//            [self.dataArray insertObject:@(1) atIndex:0];
           // [self.tableview reloadData];
//        }else{
        
            
//        }
        
    }
}


- (void)scanPurchaseAction:(UIButton *)scanBtn{
    
    if ([self.selectType isEqualToString:@"dabanruku"]) {
        
        //大板入库
        RSChoosingInventoryModel * choosingInventorymodel = [[RSChoosingInventoryModel alloc]init];
        choosingInventorymodel.isBool = false;
        choosingInventorymodel.productName = @"白玉兰";
        choosingInventorymodel.originalProductName = @"白玉兰";
        choosingInventorymodel.productNumber = [NSString stringWithFormat:@"ESB00295/DH-511"];
        choosingInventorymodel.originalProductNumber = [NSString stringWithFormat:@"ESB00295/DH-511"];
        choosingInventorymodel.productType = @"大理石";
        choosingInventorymodel.originalProductType = @"大理石";
        choosingInventorymodel.turnNumber = @"5-5";
        choosingInventorymodel.originalTurnNumber = @"5-5";
        choosingInventorymodel.newIsBool = false;
        for (int j = 0; j < 3; j++) {
            RSChoosingSliceModel * choosingSlicemodel = [[RSChoosingSliceModel alloc]init];
            choosingSlicemodel.lenth = @"0.1";
            choosingSlicemodel.originalLenth = @"0.1";
            choosingSlicemodel.wide = @"3.3";
            choosingSlicemodel.originalWide = @"3.3";
            choosingSlicemodel.height = @"10.1";
            choosingSlicemodel.originalHeight = @"10.1";
            choosingSlicemodel.area = @"3.111";
            choosingSlicemodel.originalArea = @"3.111";
            choosingSlicemodel.deductionArea = @"1.000";
            choosingSlicemodel.originalDeductionArea = @"1.000";
            choosingSlicemodel.actualArea = @"2.111";
            choosingSlicemodel.originalActualArea = @"2.111";
            [choosingInventorymodel.sliceArray addObject:choosingSlicemodel];
        }
        [self.dataArray addObject:choosingInventorymodel];
        [self.tableview reloadData];

    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
        
        MADCameraCaptureController *vc = [[MADCameraCaptureController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        vc.scanSuccess = ^(RSOcrBlockJsonModel *ocrblockjsonmodel) {
            [SVProgressHUD dismiss];
            self.ocrBlockJsonModel = ocrblockjsonmodel;
            [self.tableview reloadData];
        };

    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
        
            RSSelectiveInventoryViewController * selectiveInventoryVc = [[RSSelectiveInventoryViewController alloc]init];
            selectiveInventoryVc.selectType = self.selectType;
            selectiveInventoryVc.selectFunctionType = self.selectFunctionType;
            
            [self.navigationController pushViewController:selectiveInventoryVc animated:YES];
//           selectiveInventoryVc.selectTwo = ^(NSString * _Nonnull selectType, NSString * _Nonnull selectFunctionType, NSMutableArray * _Nonnull selectArray) {
//            if ([selectType isEqualToString:@"huangliaochuku"]) {
//                
//                self.dataArray = selectArray;
//                [self.tableview reloadData];
//                
//            }
//        };

    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
        RSChoosingInventoryViewController * choosingInventoryVc = [[RSChoosingInventoryViewController alloc]init];
        choosingInventoryVc.selectFunctionType = self.selectFunctionType;
        choosingInventoryVc.title = self.selectFunctionType;
        choosingInventoryVc.title = self.selectFunctionType;
        [self.navigationController pushViewController:choosingInventoryVc animated:YES];
//        choosingInventoryVc.selectTwo = ^(NSString * _Nonnull selectType, NSString * _Nonnull selectFunctionType, NSMutableArray * _Nonnull selectArray) {
//            self.dataArray = selectArray;
//            [self.tableview reloadData];
//        };
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        if ([self.selectFunctionType isEqualToString:@"调拨"]) {
            
            RSSelectiveInventoryViewController * selectiveInventoryVc = [[RSSelectiveInventoryViewController alloc]init];
            selectiveInventoryVc.selectType = self.selectType;
            selectiveInventoryVc.selectFunctionType = self.selectFunctionType;
            [self.navigationController pushViewController:selectiveInventoryVc animated:YES];
            
            
            
//            selectiveInventoryVc.selectTwo = ^(NSString * _Nonnull selectType, NSString * _Nonnull selectFunctionType, NSMutableArray * _Nonnull selectArray) {
//                if ([selectType isEqualToString:@"kucunguanli"]) {
//
//                    self.dataArray = selectArray;
//                    [self.tableview reloadData];
//
//                }
//            };
            
            
        }
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板
        if ([self.selectFunctionType isEqualToString:@"调拨"]) {
            RSChoosingInventoryViewController * choosingInventoryVc = [[RSChoosingInventoryViewController alloc]init];
            choosingInventoryVc.selectType = self.selectType;
            choosingInventoryVc.selectFunctionType = self.selectFunctionType;
            choosingInventoryVc.title = self.selectFunctionType;
            [self.navigationController pushViewController:choosingInventoryVc animated:YES];
            
            
//            choosingInventoryVc.selectTwo = ^(NSString * _Nonnull selectType, NSString * _Nonnull selectFunctionType, NSMutableArray * _Nonnull selectArray) {
//
//
//                self.dataArray = selectArray;
//                [self.tableview reloadData];
//
//
//            };
        }
    }
}


//荒料填写出库单和大板填写出库单
- (void)setDifferentUI{
    //添加tableview头部视图
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 106)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.tableHeaderView = topView;
    //选择仓库
    UIView * fristView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 49)];
    fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:fristView];
    
    UILabel * warehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 31, 21)];
    warehouseLabel.text = @"仓库";
    warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    warehouseLabel.font = [UIFont systemFontOfSize:15];
    warehouseLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseLabel];
    
    
    UILabel * warehouseDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(warehouseLabel.frame) + 17, 13, SCW/2, 21)];
    warehouseDetailLabel.text = @"请选择仓库";
    warehouseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    warehouseDetailLabel.font = [UIFont systemFontOfSize:15];
    warehouseDetailLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseDetailLabel];
    
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
     [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
   // [addBtn setTitle:@"+" forState:UIControlStateNormal];
   // [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 49)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:secondView];
    
    
    UILabel * materialLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    materialLabel.text = @"物料信息";
    materialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    materialLabel.font = [UIFont systemFontOfSize:15];
    materialLabel.textAlignment = NSTextAlignmentLeft;
    [secondView addSubview:materialLabel];
    
    UIButton * scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(SCW - 12 - 85, 13, 85, 28);
    // scanLabel.text = @"扫描";
    [scanBtn setTitle:@"选择库存" forState:UIControlStateNormal];
    //scanLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    [scanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [scanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    //scanLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    //scanLabel.font = [UIFont systemFontOfSize:14];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:scanBtn];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
    
}



//调拨详情
- (void)setDiaoBoUI{
    //添加tableview头部视图
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 161)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.tableHeaderView = topView;
    //选择仓库
    UIView * fristView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 46)];
    fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:fristView];
    
    UILabel * warehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    warehouseLabel.text = @"调出仓库";
    warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    warehouseLabel.font = [UIFont systemFontOfSize:15];
    warehouseLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseLabel];
    
    
    UILabel * warehouseDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(warehouseLabel.frame) + 17, 13, SCW/2, 21)];
    warehouseDetailLabel.text = @"请选择仓库";
    warehouseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    warehouseDetailLabel.font = [UIFont systemFontOfSize:15];
    warehouseDetailLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseDetailLabel];
    
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    //[addBtn setTitle:@"+" forState:UIControlStateNormal];
    //[addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fristView.frame), SCW, 1)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [topView addSubview:midView];
    
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(midView.frame), SCW, 44)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:secondView];
    
    
    
    UILabel * warehouseSecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    warehouseSecondLabel.text = @"调入仓库";
    warehouseSecondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    warehouseSecondLabel.font = [UIFont systemFontOfSize:15];
    warehouseSecondLabel.textAlignment = NSTextAlignmentLeft;
    [secondView addSubview:warehouseSecondLabel];
    
    
    UILabel * warehouseSecondDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(warehouseLabel.frame) + 17, 13, SCW/2, 21)];
    warehouseSecondDetailLabel.text = @"请选择仓库";
    warehouseSecondDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    warehouseSecondDetailLabel.font = [UIFont systemFontOfSize:15];
    warehouseSecondDetailLabel.textAlignment = NSTextAlignmentLeft;
    [secondView addSubview:warehouseSecondDetailLabel];
    
    
    UIButton * addSecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addSecondBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
     [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    //[addSecondBtn setTitle:@"+" forState:UIControlStateNormal];
    //[addSecondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [secondView addSubview:addSecondBtn];
   // [addSecondBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addSecondBtn.layer.cornerRadius = addBtn.yj_width * 0.5;

    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 10, SCW, 48)];
    thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:thirdView];
    
    UILabel * materialLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    materialLabel.text = @"物料信息";
    materialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    materialLabel.font = [UIFont systemFontOfSize:15];
    materialLabel.textAlignment = NSTextAlignmentLeft;
    [thirdView addSubview:materialLabel];
    
    UIButton * scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(SCW - 12 - 85, 13, 85, 28);
    // scanLabel.text = @"扫描";
    [scanBtn setTitle:@"选择库存" forState:UIControlStateNormal];
    //scanLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    [scanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [scanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    //scanLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    //scanLabel.font = [UIFont systemFontOfSize:14];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [thirdView addSubview:scanBtn];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
}



- (void)setUIBottomView{
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn addTarget:self action:@selector(saveCurrentDataAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    
    RSRightPitureButton * rightPictureBtn = [RSRightPitureButton buttonWithType:UIButtonTypeCustom];
    rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [rightPictureBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    [rightPictureBtn setTitle:@"合计" forState:UIControlStateNormal];
    [rightPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    [rightPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    rightPictureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightPictureBtn addTarget:self action:@selector(openAndCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightPictureBtn];
    
}


- (void)openAndCloseAction:(UIButton *)rightPictureBtn{
    rightPictureBtn.selected = !rightPictureBtn.selected;
    if (rightPictureBtn.selected) {
        self.saveAlertView.selectFunctionType = self.selectFunctionType;
        self.saveAlertView.selectType = self.selectType;
        [self.saveAlertView showView];
        if ([self.selectType isEqualToString:@"dabanchuku"]) {
            rightPictureBtn.frame = CGRectMake(0, SCH - 86 - 168, SCW, 36);
        }else{
            rightPictureBtn.frame = CGRectMake(0, SCH - 86 - 112, SCW, 36);
        }
    }else{
        rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
        [self.saveAlertView closeView];
    }
}


//保存
- (void)saveCurrentDataAction:(UIButton *)saveBtn{
//    saveBtn.selected = !saveBtn.selected;
//    if (saveBtn.selected) {
//        self.saveAlertView.selectFunctionType = self.selectFunctionType;
//        self.saveAlertView.selectType = self.selectType;
//        [self.saveAlertView showView];
//    }else{
//       [self.saveAlertView closeView];
//    }
}



//仓库
- (void)addWarehouseAction:(UIButton *)addBtn{
    RSWarehouseManagementViewController * warehouseManagementVc = [[RSWarehouseManagementViewController alloc]init];
    [self.navigationController pushViewController:warehouseManagementVc animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return self.dataArray.count;
//        }else{
//            return 1;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return 1;
            
//        }else{
//            return 1;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
       // if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            return 1;
        //}else{
          //  return 1;
        //}
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
        //if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            return self.dataArray.count;
       // }else{
         //   return 1;
        //}
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        //调拨
        return 1;
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板t调拨
        return self.dataArray.count;
    }
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return 118;
//        }else{
//            return 0;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return 217;

//        }else{
//            return 0;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
//        if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
        RSSelectiveInventoryModel * selectiveInventorymodel = self.dataArray[indexPath.row];
//        if ([selectiveInventorymodel.originalProudcutName isEqualToString:selectiveInventorymodel.productName]){
//            //相同的物料名称的地方
//            if ([selectiveInventorymodel.lenth isEqualToString:selectiveInventorymodel.originalLenth] && [selectiveInventorymodel.wide isEqualToString:selectiveInventorymodel.originalWide] && [selectiveInventorymodel.height isEqualToString:selectiveInventorymodel.originalHeight]&&[selectiveInventorymodel.wight isEqualToString:selectiveInventorymodel.originalWight] && [selectiveInventorymodel.area isEqualToString:selectiveInventorymodel.originalArea]) {
//                return 197;
//            }else{
                return 217;
//            }
//        }else{
//            //不同物料名称的地方
//            return 209;
//        }
//        }else{
//            return 0;
//        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
       // if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            return 118;
       // }else{
         //   return 0;
        //}
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        //调拨
        return 217;
        
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板t调拨
        return 118;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return 108;
//        }else{
//            return 0.001;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return 0.001;
//        }else{
//            return 0.001;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
        if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            return 0.001;
        }else{
            return 0.001;
        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
      //  if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            return 108;
       // }else{
         //   return 0.001;
        //}
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        //调拨
        return 0.001;
        
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板t调拨
        return 108;
    }
    return 0.001;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
        
         RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        if (choosingInventorymodel.isBool) {
            return 10;
        }else{
             return 0.001;
        }
        
        
        
//        }else{
//              return 0.001;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return 0.001;
//        }else{
//            return 0.001;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
        if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
           return 0.001;
        }else{
            return 0.001;
        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
      //  if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
        
          RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        
        if (choosingInventorymodel.isBool) {
            return 10;
        }else{
            return 0.001;
        }
       // }else{
         //   return 0.001;
        //}
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        //调拨
        return 0.001;
        
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板t调拨
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        if (choosingInventorymodel.isBool) {
            return 10;
        }else{
            return 0.001;
        }
        
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
        
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        
           // NSMutableDictionary * dict = self.dataArray[section];
            RSDabanPurchaseFootView * dabanPurchaseFootView = [[RSDabanPurchaseFootView alloc]initWithReuseIdentifier:DABANPURCHASEFOOTVIEW];
            //dabanPurchaseFootView.choosingInventorymodel = choosingInventorymodel;
            return dabanPurchaseFootView;
//        }else{
//            return nil;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return nil;
//        }else{
//            return nil;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
        if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            return nil;
        }else{
            return nil;
        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
       // if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
           // NSMutableDictionary * dict = self.dataArray[section];
        
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        
        
            RSDabanPurchaseFootView * dabanPurchaseFootView = [[RSDabanPurchaseFootView alloc]initWithReuseIdentifier:DABANPURCHASEFOOTVIEW];
       // dabanPurchaseFootView.choosingInventorymodel = choosingInventorymodel;
//            dabanPurchaseFootView.dict = dict;
        
            return dabanPurchaseFootView;
        //}else{
          //  return nil;
        //}
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        //调拨
        return nil;
        
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板t调拨
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        
        // NSMutableDictionary * dict = self.dataArray[section];
        RSDabanPurchaseFootView * dabanPurchaseFootView = [[RSDabanPurchaseFootView alloc]initWithReuseIdentifier:DABANPURCHASEFOOTVIEW];
       // dabanPurchaseFootView.choosingInventorymodel = choosingInventorymodel;
        return dabanPurchaseFootView;
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ///RSDabanPurchaseHeaderView.h
    
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            //NSMutableDictionary * dict = self.dataArray[section];
        
            RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        
            RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:DABANPURCHASEHEADERVIEW];
            dabanPurchaseHeaderView.downBtn.tag = section;
            dabanPurchaseHeaderView.productDeleteBtn.tag = section;
          //  dabanPurchaseHeaderView.choosingInventorymodel = choosingInventorymodel;
            [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        dabanPurchaseHeaderView.productEidtBtn.tag = section;
        [dabanPurchaseHeaderView.productEidtBtn addTarget:self action:@selector(dabanPurchAseProductEidtAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
            return dabanPurchaseHeaderView;
//
//        }else{
//            return nil;
//
//        }
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            return nil;
//        }else{
//            return nil;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
        if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
             return nil;
        }else{
             return nil;
        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
       // if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            //NSMutableDictionary * dict = self.dataArray[section];
        
         RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
            RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:DABANPURCHASEHEADERVIEW];
            dabanPurchaseHeaderView.downBtn.tag = section;
           // dabanPurchaseHeaderView.dict = dict;
       // dabanPurchaseHeaderView.choosingInventorymodel = choosingInventorymodel;
            dabanPurchaseHeaderView.productEidtBtn.hidden = YES;
        dabanPurchaseHeaderView.productDeleteBtn.tag = section;
            [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
        [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
            return dabanPurchaseHeaderView;
     //   }else{
       //     return nil;
       // }
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        //调拨
        return nil;
        
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板调拨
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:DABANPURCHASEHEADERVIEW];
        dabanPurchaseHeaderView.downBtn.tag = section;
        // dabanPurchaseHeaderView.dict = dict;
       // dabanPurchaseHeaderView.choosingInventorymodel = choosingInventorymodel;
        dabanPurchaseHeaderView.productEidtBtn.hidden = YES;
        dabanPurchaseHeaderView.productDeleteBtn.tag = section;
        [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
        [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        return dabanPurchaseHeaderView;
    }
    return nil;
    
}


- (void)showAndHideDabanPurchaseAction:(UIButton *)downBtn{
    if ([self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"kucunguanli1"] || [self.selectType isEqualToString:@"dabanchuku"]) {
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[downBtn.tag];
        //BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
        downBtn.selected = !downBtn.selected;
        choosingInventorymodel.isBool = !choosingInventorymodel.isBool;
        //  [dict setObject:[NSNumber numberWithBool:isbool] forKey:@"isbool"];
        //    if (downBtn.selected) {
        //        isbool = true;
        //        [dict setObject:[NSNumber numberWithBool:isbool] forKey:@"isbool"];
        //    }else{
        //        isbool = false;
        //        [dict setObject:[NSNumber numberWithBool:isbool] forKey:@"isbool"];
        //    }
        NSIndexSet * set = [NSIndexSet indexSetWithIndex:downBtn.tag];
        [self.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }else{
        NSMutableDictionary * dict = self.dataArray[downBtn.tag];
        BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
        downBtn.selected = !downBtn.selected;
        isbool = !isbool;
        [dict setObject:[NSNumber numberWithBool:isbool] forKey:@"isbool"];
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:downBtn.tag];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


//大板入库头部编辑的方式
- (void)dabanPurchAseProductEidtAction:(UIButton *)productEidtBtn{
    RSBigBoardChangeViewController * bigBoardChangeVc = [[RSBigBoardChangeViewController alloc]init];
    bigBoardChangeVc.selectType = self.selectType;
    bigBoardChangeVc.currentTitle = self.selectFunctionType;
    bigBoardChangeVc.title = [NSString stringWithFormat:@"%@",self.selectFunctionType];
    
    if ([self.selectType isEqualToString:@"dabanruku"]) {
       RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[productEidtBtn.tag];
      // bigBoardChangeVc.choosingInventorymodel = choosingInventorymodel;
       bigBoardChangeVc.index = productEidtBtn.tag;
        bigBoardChangeVc.recoveryData = ^(NSInteger index, RSChoosingInventoryModel * _Nonnull choosingInventorymodel, NSString * _Nonnull currentTitle) {
            
        };
        
        bigBoardChangeVc.saveData = ^(NSInteger index, RSChoosingInventoryModel * _Nonnull choosingInventorymodel, NSString * _Nonnull currentTitle) {
            choosingInventorymodel = choosingInventorymodel;
            [self.tableview reloadData];
        };
    }else{
        
        
    
    }
    [self.navigationController pushViewController:bigBoardChangeVc animated:YES];
}

//大板入库头部删除的方法
- (void)dabanPurchAseProductdDeleteAction:(UIButton *)productDeleteBtn{
    if ([self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"dabanchuku"] || [self.selectType isEqualToString:@"kucunguanli1"]) {
        [self.dataArray removeObjectAtIndex:productDeleteBtn.tag];
        [self.tableview reloadData];
    }
}

//荒料入库的编辑按钮
- (void)exceptionHandlingProductEidtAction:(UIButton *)productEidtBtn{
//    RSSelectiveInventoryModel * selectiveInventorymodel = self.dataArray[productEidtBtn.tag];
//    RSAlterationOfWasteMaterialViewController * alterationOfWasteVc = [[RSAlterationOfWasteMaterialViewController alloc]init];
//    alterationOfWasteVc.currentTitle = self.selectFunctionType;
//    alterationOfWasteVc.selectType = self.selectType;
//    alterationOfWasteVc.selectiveInventorymodel = selectiveInventorymodel;
//    alterationOfWasteVc.title = [NSString stringWithFormat:@"%@",self.selectFunctionType];
//    [self.navigationController pushViewController:alterationOfWasteVc animated:YES];
//
//    alterationOfWasteVc.saveData = ^(NSInteger index, RSSelectiveInventoryModel * _Nonnull selectiveInvetorymodel, NSString * _Nonnull currentTitle) {
//        [self.dataArray replaceObjectAtIndex:index withObject:selectiveInventorymodel];
//        //NSIndexPath * indexpath = [NSIndexPath indexPathForRow:index inSection:0];
//       // [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableview reloadData];
//    };
}


- (void)exceptionHandlingProductDeleteAction:(UIButton *)productDeleteBtn{
    [self.ocrBlockJsonModel.noteDtl removeObjectAtIndex:productDeleteBtn.tag];
    [self.tableview reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            /**
             [dict setObject:[NSNumber numberWithBool:isbool] forKey:@"isbool"];
             [dict setObject:cellArray forKey:@"cellArray"];
             */
            RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
            //NSMutableArray * array = [dict objectForKey:@"cellArray"];
            //BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
            if (choosingInventorymodel.isBool) {
                return choosingInventorymodel.sliceArray.count;
            }else{
                return 0;
            }
//        }else{
//            return 1;
//        }
//        return 1;
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            //return self.dataArray.count;
        
        return self.ocrBlockJsonModel.noteDtl.count;
        
//        }else{
//            return 0;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
//        if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            return self.dataArray.count;
//        }else{
//            return 0;
//        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
       // if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            //NSMutableDictionary * dict = self.dataArray[section];
        
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
            //NSMutableArray * array = [dict objectForKey:@"selectArray"];
            //BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
            if (choosingInventorymodel.isBool) {
                return choosingInventorymodel.selectArray.count;
            }else{
                return 0;
            }
       // }else{
         //   return 0;
       // }
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        //荒料
        //调拨
         return self.dataArray.count;
        
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板调拨
        RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
        //NSMutableArray * array = [dict objectForKey:@"cellArray"];
        //BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
        if (choosingInventorymodel.isBool) {
            return choosingInventorymodel.sliceArray.count;
        }else{
            return 0;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.selectType isEqualToString:@"dabanruku"]) {
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
            static NSString * DABANPURCHASECELLID = @"DABANPURCHASECELLID";
            RSDabanPurchaseCell * cell = [tableView dequeueReusableCellWithIdentifier:DABANPURCHASECELLID];
            if (!cell) {
                cell = [[RSDabanPurchaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DABANPURCHASECELLID];
            }
            
            cell.indexPath = indexPath;
        
             RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[indexPath.section];
            //cell.name = @"11212";
            //typeof(self) __weak weakSelf = self;
            RSWeakself
            cell.deleteAction = ^(NSIndexPath *indexPath) {
                [choosingInventorymodel.sliceArray removeObjectAtIndex:indexPath.row];
                [weakSelf.tableview reloadData];
                /// 删除逻辑
               // [weakSelf.dataList removeObjectAtIndex:indexPath.row];
               // [weakSelf reloadData];
            };
            cell.scrollAction = ^{
                for (RSDabanPurchaseCell * tableViewCell in weakSelf.tableview.visibleCells) {
                    /// 当屏幕滑动时，关闭不是当前滑动的cell
                    if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                        [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                    }
                }
            };
            
            
            return cell;
//        }else{
//            return nil;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaoruku"]){
        //荒料入库
//        if ([self.selectFunctionType isEqualToString:@"采购入库"]) {
        //self.ocrBlockJsonModel.noteDtl.count
        
        RSOcrBlockDetailModel * ocrblockdetialmodel = self.ocrBlockJsonModel.noteDtl[indexPath.row];
//        RSSelectiveInventoryModel * selectiveInventorymodel = self.dataArray[indexPath.row];
        if ([ocrblockdetialmodel.originalStoneName isEqualToString:ocrblockdetialmodel.stoneName]){
            //相同的物料名称的地方
            if (ocrblockdetialmodel.length == ocrblockdetialmodel.originalLength &&
                ocrblockdetialmodel.width == ocrblockdetialmodel.originalWidth
                &&
                ocrblockdetialmodel.height == ocrblockdetialmodel.originalHeight
                &&
                ocrblockdetialmodel.weight == ocrblockdetialmodel.originalWeight
                &&
                ocrblockdetialmodel.preVaqty == ocrblockdetialmodel.originalPreVaqty
                ) {
                
                static NSString * EXCEPTIONHANDLINGFILLID = @"EXCEPTIONHANDLINGFILLID";
                RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGFILLID];
                if (!cell) {
                    cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGFILLID];
                }
                //cell.ocrblockdetailmodel = ocrblockdetialmodel;
                cell.productEidtBtn.tag = indexPath.row;
                cell.productDeleteBtn.tag = indexPath.row;
                [cell.productEidtBtn addTarget:self action:@selector(exceptionHandlingProductEidtAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.productDeleteBtn addTarget:self action:@selector(exceptionHandlingProductDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                static NSString * EXCEPTIONHANDLINGSECONDDETIALID = @"EXCEPTIONHANDLINGSECONDDETIALID";
                RSExceptionHanlingSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGSECONDDETIALID];
                if (!cell) {
                    cell = [[RSExceptionHanlingSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGSECONDDETIALID];
                }
                cell.productDeleteBtn.tag = indexPath.row;
                cell.productEidtBtn.tag = indexPath.row;
                
                [cell.productEidtBtn addTarget:self action:@selector(exceptionHandlingProductEidtAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.productDeleteBtn addTarget:self action:@selector(exceptionHandlingProductDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }else{
            //不同物料名称的地方
            static NSString * EXCEPTIONHANDLINGTHIRDDETAILID = @"EXCEPTIONHANDLINGTHIRDDETAILID";
            RSExceptionHandlingThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGTHIRDDETAILID];
            if (!cell) {
                cell = [[RSExceptionHandlingThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGTHIRDDETAILID];
            }
            
            cell.productDeleteBtn.tag = indexPath.row;
            cell.productEidtBtn.tag = indexPath.row;
            [cell.productEidtBtn addTarget:self action:@selector(exceptionHandlingProductEidtAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productDeleteBtn addTarget:self action:@selector(exceptionHandlingProductDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
//        }else{
//            return nil;
//        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
//        if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            static NSString * EXCEPTIONHANDLINGOUTID = @"EXCEPTIONHANDLINGOUTID";
            RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGOUTID];
            if (!cell) {
                cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGOUTID];
            }
            cell.productEidtBtn.hidden = YES;
        
        
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
//        }else{
//            return nil;
        
            
//        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
      //  if ([self.selectFunctionType isEqualToString:@"销售出库"]) {
            static NSString * DABANPURCHASECELLOUTID = @"DABANPURCHASECELLOUTID";
            RSDabanPurchaseCell * cell = [tableView dequeueReusableCellWithIdentifier:DABANPURCHASECELLOUTID];
            if (!cell) {
                cell = [[RSDabanPurchaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DABANPURCHASECELLOUTID];
            }
        cell.mainScrollView.userInteractionEnabled = NO;
//            cell.indexPath = indexPath;
//
//            //typeof(self) __weak weakSelf = self;
//            RSWeakself
//            cell.deleteAction = ^(NSIndexPath *indexPath) {
//                /// 删除逻辑
//                // [weakSelf.dataList removeObjectAtIndex:indexPath.row];
//
//                // [weakSelf reloadData];
//            };
//
//            cell.scrollAction = ^{
//                for (RSDabanPurchaseCell * tableViewCell in weakSelf.tableview.visibleCells) {
//                    /// 当屏幕滑动时，关闭不是当前滑动的cell
//                    if (tableViewCell.isOpen == YES && tableViewCell != cell) {
//                        [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//                    }
//                }
//            };
            return cell;
//        }else{
//            return nil;
//        }
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        
        //调拨
        
        static NSString * EXCEPTIONHANDLINGDIAOID = @"EXCEPTIONHANDLINGDIAOID";
        RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGDIAOID];
        if (!cell) {
            cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGDIAOID];
        }
        cell.productEidtBtn.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        //大板调拨
        static NSString * DABANPURCHASECELLOUTDIAOID = @"DABANPURCHASECELLOUTDIAOID";
        RSDabanPurchaseCell * cell = [tableView dequeueReusableCellWithIdentifier:DABANPURCHASECELLOUTDIAOID];
        if (!cell) {
            cell = [[RSDabanPurchaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DABANPURCHASECELLOUTDIAOID];
        }
        cell.mainScrollView.userInteractionEnabled = NO;
        //            cell.indexPath = indexPath;
        //
        //            //typeof(self) __weak weakSelf = self;
        //            RSWeakself
        //            cell.deleteAction = ^(NSIndexPath *indexPath) {
        //                /// 删除逻辑
        //                // [weakSelf.dataList removeObjectAtIndex:indexPath.row];
        //
        //                // [weakSelf reloadData];
        //            };
        //
        //            cell.scrollAction = ^{
        //                for (RSDabanPurchaseCell * tableViewCell in weakSelf.tableview.visibleCells) {
        //                    /// 当屏幕滑动时，关闭不是当前滑动的cell
        //                    if (tableViewCell.isOpen == YES && tableViewCell != cell) {
        //                        [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        //                    }
        //                }
        //            };
        return cell;
    }
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.selectType isEqualToString:@"dabanruku"]) {
        for (RSDabanPurchaseCell * tableViewCell in self.tableview.visibleCells) {
            /// 当屏幕滑动时，关闭被打开的cell
            if (tableViewCell.isOpen == YES) {
                [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    }
   
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.saveAlertView closeView];
}

@end
