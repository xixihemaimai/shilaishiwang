//
//  RSOutStockViewController.m
//  石来石往
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSOutStockViewController.h"
#import "RSExceptionHandlingSecondDetailCell.h"
//合计
#import "RSRightPitureButton.h"
#import "RSSaveAlertView.h"

//仓库管理界面
#import "RSWarehouseManagementViewController.h"

//选择
#import "RSSelectiveInventoryViewController.h"

//加工厂
#import "RSProcessingFactoryViewController.h"


//仓库模型
#import "RSWarehouseModel.h"
//荒料汇总模型
//#import "RSSelectiveInventoryModel.h"
#import "RSStoragemanagementModel.h"
//加载模型头部
#import "RSBillHeadModel.h"

@interface RSOutStockViewController ()<RSSelectiveInventoryViewControllerDelegate,UITextViewDelegate>
{
    
    //出库时间
    UIButton * _timeBtn;
    //出库时间显示
    UILabel * _timeShowLabel;
    
    
    //仓库
    UIButton * _addBtn;
    
    //选择库存
    UIButton * _scanBtn;
    RSRightPitureButton * _rightPictureBtn;
    //显示仓库
    UILabel * _warehouseDetailLabel;
    
    //保存
    UIButton * _savebottomBtn;
    UIView * _factoryView;
    
    UILabel * _factoryLabel;
    
    UIButton * _factoryBtn;
    //编辑，确认入库 删除
    UIView * _editSureView;
    
    //删除
    UIButton * _deleteBtn;
    
    //编辑
    UIButton * _editBtn;
    
    //确认入库
    UIButton * _sureBtn;
    //取消编辑 保存
    UIView * _allView;
    //取消编辑
    UIButton * _cancelEditBtn;
    //修改保存
    UIButton * _saveBtn;
    //取消入库
    UIButton * _cancelBtn;
    UIView * _secondView;
    //备注
    UITextView * _remarksTextField;
    UILabel * _remarksLabel;
    UIView * _topView;
    UIView * _thirdView;
    
    UIView * _fristView;
    
}

//本地扫描的数组
@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,strong)RSSaveAlertView * saveAlertView;

/**仓库的模型*/
@property (nonatomic,strong)RSWarehouseModel * warehousermodel;

/**仓库的选择的位置*/
@property (nonatomic,strong)RSBillHeadModel * billheadmodel;

//保存选择的按键的类型
@property (nonatomic,strong)NSString * btnType;

@end

@implementation RSOutStockViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (RSWarehouseModel *)warehousermodel{
    if (!_warehousermodel) {
        _warehousermodel = [[RSWarehouseModel alloc]init];
    }
    return _warehousermodel;
}

- (RSBillHeadModel *)billheadmodel{
    if (!_billheadmodel) {
        _billheadmodel = [[RSBillHeadModel alloc]init];
    }
    return _billheadmodel;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (RSSaveAlertView *)saveAlertView{
    if (!_saveAlertView) {
        _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 112, SCW, 112)];
    }
    return _saveAlertView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义创建导航栏
    [self setCustomNavigaionView];
    
    //创建添加tableview头部视图
    
    [self setDifferentUI];
    
    [self setTotalUI];
 
    [self setUIBottomView];
    
    [self seteditAndSureUI];
    
    [self setUICancelEditAndAllAndSaveSetUI];
    
    
    [self cancelSetUI];
    
    
    if ([self.showType isEqualToString:@"new"]) {
        //点击新建的界面
        _savebottomBtn.hidden = NO;
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        _editSureView.hidden = YES;
        _editBtn.hidden = YES;
        _sureBtn.hidden = YES;
        _deleteBtn.hidden = YES;
        _addBtn.hidden = NO;
        _remarksTextField.userInteractionEnabled = YES;
        _scanBtn.hidden = NO;
       
        _timeBtn.hidden = NO;
        _timeShowLabel.text = [self showCurrentTime];
        self.btnType = @"edit";
        
        if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
            
            _factoryBtn.hidden = NO;
            _factoryView.hidden = NO;
        }else{
            _factoryBtn.hidden = YES;
            _factoryView.hidden = YES;
        }
        
        
    }else{
         self.btnType = @"save";
        //点击cell跳转过来的值，要去加载数据
        //_savebottomBtn.hidden = YES;
        _savebottomBtn.hidden = YES;
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = YES;
        _remarksTextField.userInteractionEnabled = NO;
        _addBtn.hidden = YES;
        _scanBtn.hidden = YES;
        if (self.personalFunctionmodel.status == 0) {
            _cancelBtn.hidden = YES;
            _editSureView.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _deleteBtn.hidden = NO;
        }else{
            _cancelBtn.hidden = NO;
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _deleteBtn.hidden = YES;
        }
        
         _timeBtn.hidden = YES;
        if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
            _factoryBtn.hidden = YES;
            _factoryView.hidden = NO;
        }else{
            _factoryBtn.hidden = YES;
            _factoryView.hidden = YES;
        }
         [self reloadOldSaveNewData];
    }
}

- (void)setTotalUI{
    RSRightPitureButton * rightPictureBtn = [RSRightPitureButton buttonWithType:UIButtonTypeCustom];
    rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [rightPictureBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    rightPictureBtn.layer.shadowOffset =  CGSizeMake(1, 1);
    rightPictureBtn.layer.shadowOpacity = 0.8;
    rightPictureBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
    
    
    [rightPictureBtn setTitle:@"合计" forState:UIControlStateNormal];
    [rightPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    [rightPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    rightPictureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightPictureBtn addTarget:self action:@selector(openAndCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightPictureBtn];
    _rightPictureBtn = rightPictureBtn;
}


- (void)openAndCloseAction:(UIButton *)rightPictureBtn{
    rightPictureBtn.selected = !rightPictureBtn.selected;
    if (rightPictureBtn.selected) {
        NSInteger totalNumber = 0;
        NSDecimalNumber * totalWeight;
        NSDecimalNumber * totalVolume;
        
        totalNumber =self.dataArray.count;
        double newWeight =0.0;
        double newVolume = 0.0;
        for (int i = 0 ; i < self.dataArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
        newWeight += [storagemanagementmodel.weight doubleValue];
        newVolume += [storagemanagementmodel.volume doubleValue];
       }
            totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
            totalVolume = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
        
        self.saveAlertView.totalNumber = [NSString stringWithFormat:@"%ld",(long)totalNumber];
        self.saveAlertView.totalArea = [NSString stringWithFormat:@"%0.3lf",[totalVolume doubleValue]];
        self.saveAlertView.totalWeight = [NSString stringWithFormat:@"%0.3lf",[totalWeight doubleValue]];
        self.saveAlertView.selectFunctionType = self.selectFunctionType;
        self.saveAlertView.selectType = self.selectType;
        [self.saveAlertView showView];
        rightPictureBtn.frame = CGRectMake(0, SCH - 86 - 112, SCW, 36);
    }else{
        rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
        [self.saveAlertView closeView];
    }
}




- (void)setDifferentUI{
    
    //添加tableview头部视图
    //WithFrame:CGRectMake(0, 0, SCW, 275)
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    _topView = topView;
    //时间
    UIView * timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 50)];
    timeView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:timeView];
    
    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 31, 21)];
    timeLabel.text = @"日期";
    timeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [timeView addSubview:timeLabel];
    
    //时间label
    UILabel * timeShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame) + 17, 0, SCW - CGRectGetMaxX(timeLabel.frame) + 10, 50)];
    timeShowLabel.text = @"请选择时间";
    timeShowLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    timeShowLabel.font = [UIFont systemFontOfSize:15];
    timeShowLabel.textAlignment = NSTextAlignmentLeft;
    [timeView addSubview:timeShowLabel];
    _timeShowLabel = timeShowLabel;
    
    //时间按键
    UIButton * timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [timeBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    [timeView addSubview:timeBtn];
    [timeBtn addTarget:self action:@selector(choiceChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.layer.cornerRadius = timeBtn.yj_width * 0.5;
    _timeBtn = timeBtn;
    
    
    //这边添加加工厂
    UIView * factoryView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(timeView.frame) + 9, SCW, 50)];
    factoryView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:factoryView];
    _factoryView = factoryView;
    
    
    UILabel * factoryShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13,50, 21)];
    factoryShowLabel.text = @"加工厂";
    factoryShowLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    factoryShowLabel.font = [UIFont systemFontOfSize:15];
    factoryShowLabel.textAlignment = NSTextAlignmentLeft;
    [factoryView addSubview:factoryShowLabel];
    
    
    //选择工厂的显示
    UILabel * factoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(factoryShowLabel.frame) + 17, 0, SCW - CGRectGetMaxX(factoryShowLabel.frame) + 10, 50)];
    factoryLabel.text = @"请选择加工厂";
    factoryLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    factoryLabel.font = [UIFont systemFontOfSize:15];
    factoryLabel.textAlignment = NSTextAlignmentLeft;
    [factoryView addSubview:factoryLabel];
    _factoryLabel = factoryLabel;
    

    
    //选择加工厂的按键
    UIButton * factoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [factoryBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    factoryBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [factoryView addSubview:factoryBtn];
    [factoryBtn addTarget:self action:@selector(choiceFactoryAction:) forControlEvents:UIControlEventTouchUpInside];
    factoryBtn.layer.cornerRadius = factoryBtn.yj_width * 0.5;
    _factoryBtn = factoryBtn;
    

    
    //选择仓库
    UIView * fristView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(factoryView.frame) + 9, SCW, 50)];
    fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:fristView];
    _fristView = fristView;
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
    _warehouseDetailLabel = warehouseDetailLabel;
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    // [addBtn setTitle:@"+" forState:UIControlStateNormal];
    // [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    _addBtn = addBtn;
    
    
    
    
    
    //备注
    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW , 50)];
    thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:thirdView];
    _thirdView = thirdView;
    
    //备注
    UILabel * remarksLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 31, 21)];
    remarksLabel.text = @"备注";
    remarksLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    remarksLabel.font = [UIFont systemFontOfSize:15];
    remarksLabel.textAlignment = NSTextAlignmentLeft;
    [thirdView addSubview:remarksLabel];
    _remarksLabel = remarksLabel;
    
    
    UITextView * remarksTextField = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(remarksLabel.frame) + 17, 13, SCW - CGRectGetMaxX(remarksLabel.frame) - 17, 21)];
    //remarksTextField.placeholder = @"请填写备注信息";
    remarksTextField.text = @"";
    remarksTextField.textAlignment = NSTextAlignmentLeft;
    remarksTextField.font = [UIFont systemFontOfSize:15];
    remarksTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    remarksTextField.delegate = self;
    remarksTextField.returnKeyType = UIReturnKeyDone;
    [thirdView addSubview:remarksTextField];
    _remarksTextField = remarksTextField;
    //[remarksTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(thirdView.frame) + 9, SCW, 49)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:secondView];
    _secondView = secondView;
    
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
    _scanBtn = scanBtn;
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:scanBtn];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
    
    
    
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        
        _factoryView.hidden = NO;
        fristView.frame = CGRectMake(0, CGRectGetMaxY(factoryView.frame) + 9, SCW, 50);
        //secondView.frame = CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 50);
        //topView.frame = CGRectMake(0, 0, SCW, 275);
       
    }else{
        
        _factoryView.hidden = YES;
        fristView.frame = CGRectMake(0, CGRectGetMaxY(timeView.frame) + 9, SCW, 50);
        thirdView.frame = CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 50);
        secondView.frame = CGRectMake(0, CGRectGetMaxY(thirdView.frame) + 9, SCW, 50);
        //topView.frame = CGRectMake(0, 0, SCW, 225);
    }
    
    [topView setupAutoHeightWithBottomView:secondView bottomMargin:10];
    [topView layoutIfNeeded];
    self.tableview.tableHeaderView = topView;
}


- (void)choiceChangeTimeAction:(UIButton *)timeBtn{
    NSDate * date = [self nsstringConversionNSDate:_timeShowLabel.text];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
         NSString * date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
         if ([self TimeWithArrayCompare:date1 andArray:self.dataArray]) {
            //结束时间
            _timeShowLabel.text = date1;
         }else{
            
                       UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"确定是否修改时间选择" message:@"该操作会清空所有选择的库存，是否确定?" preferredStyle:UIAlertControllerStyleAlert];
                                  UIAlertAction * alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                  }];
                                  [alertView addAction:alert];
                                  
                                  UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                       //这边要做的是对数组进行删除
                                                     [self.dataArray removeAllObjects];
                                                     //并且刷新tableview
                                                     [self.tableview reloadData];
                                                     _timeShowLabel.text = date1;
                                  }];
                                  [alertView addAction:alert1];
                                  
                                  if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                      alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                  }
                                  [self presentViewController:alertView animated:YES completion:nil];
                                  
             
             
//             [JHSysAlertUtil presentAlertViewWithTitle:@"确定是否修改时间选择" message:@"该操作会清空所有选择的库存，是否确定?" cancelTitle:@"确定" defaultTitle:@"取消" distinct:YES cancel:^{
//                //这边要做的是对数组进行删除
//                [self.dataArray removeAllObjects];
//                //并且刷新tableview
//                [self.tableview reloadData];
//                _timeShowLabel.text = date1;
//            } confirm:^{
//            }];
         }
        
        
        
    }];
    // datepicker.maxLimitDate = [NSDate date];
    [datepicker show];
}


- (BOOL)TimeWithArrayCompare:(NSString *)timeStr andArray:(NSMutableArray *)dataArray{
    BOOL isTrue = true;
    if (dataArray.count < 0) {
        isTrue = YES;
        return isTrue;
    }else{
        for (int i = 0 ; i < dataArray.count; i++) {
          RSStoragemanagementModel * storagemaanagementmodel = dataArray[i];
            NSString * receiptDate = (NSString *)storagemaanagementmodel.receiptDate;
            int number = [self compareDate:timeStr withDate:receiptDate];
            if (number == 1) {
                isTrue = false;
                break;
            }else{
                isTrue = true;
            }
        }
        return isTrue;
    }
}
/****
 iOS比较日期大小默认会比较到秒
 ****/
-(int)compareDate:(NSString *)date01 withDate:(NSString *)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci = 1;
            break;
            //date02比date01小
        case NSOrderedDescending: ci = -1;
            break;
            //date02=date01
            //        case NSOrderedSame: ci=0; break;
        default:
            //NSLog(@"erorr dates %@, %@", dt2, dt1);
            ci = 0;
            break;
    }
    return ci;
}



//底部视图
- (void)setUIBottomView{
    UIButton * savebottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebottomBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [savebottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebottomBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [savebottomBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    savebottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [savebottomBtn addTarget:self action:@selector(saveBottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebottomBtn];
    //_savebottomBtn = savebottomBtn;
}


//FIXME:加工厂
- (void)choiceFactoryAction:(UIButton *)factoryBtn{
    RSProcessingFactoryViewController * processingFactoryVc = [[RSProcessingFactoryViewController alloc]init];
    processingFactoryVc.usermodel = self.usermodel;
    processingFactoryVc.selectType = self.selectType;
    processingFactoryVc.selectFunctionType = self.selectFunctionType;
    processingFactoryVc.selectName = self.billheadmodel.factoryName;
    processingFactoryVc.selectID = self.billheadmodel.factoryId;
    [self.navigationController pushViewController:processingFactoryVc animated:YES];
    processingFactoryVc.select = ^(BOOL isSelect, RSWarehouseModel * _Nonnull warehousemodel) {
        if (isSelect) {
            self.billheadmodel.factoryId = warehousemodel.WareHouseID;
            self.billheadmodel.factoryName = warehousemodel.name;
            _factoryLabel.text = warehousemodel.name;
        }
    };
}






//编辑和确认入库
- (void)seteditAndSureUI{
    
    UIView * editSureView = [[UIView alloc]init];
    editSureView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    editSureView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:editSureView];
    editSureView.hidden = YES;
    _editSureView = editSureView;
    //删除
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, SCW/3 -1, 50);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [editSureView addSubview:deleteBtn];
     [deleteBtn addTarget:self action:@selector(deleteOutAction:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn = deleteBtn;
    deleteBtn.hidden = YES;
    //编辑
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(CGRectGetMaxX(deleteBtn.frame) + 1, 0, SCW/3 - 1, 50);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [editBtn addTarget:self action:@selector(editOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [editSureView addSubview:editBtn];
    _editBtn = editBtn;
    editBtn.hidden = YES;
    //确认入库
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(editBtn.frame) + 1, 0, SCW/3, 50);
    [sureBtn setTitle:@"确认出库" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sureOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [editSureView addSubview:sureBtn];
    _sureBtn = sureBtn;
    sureBtn.hidden = YES;
}



//取消编辑  保存
- (void)setUICancelEditAndAllAndSaveSetUI{
    UIView * allView = [[UIView alloc]init];
    allView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    allView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:allView];
    _allView = allView;
    allView.hidden = YES;
    
    UIButton * cancelEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelEditBtn.frame = CGRectMake(0, 0, SCW/2 - 0.5, 50);
    [cancelEditBtn setTitle:@"取消编辑" forState:UIControlStateNormal];
    [cancelEditBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [cancelEditBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    cancelEditBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelEditBtn addTarget:self action:@selector(cancelOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:cancelEditBtn];
    _cancelEditBtn = cancelEditBtn;
    cancelEditBtn.hidden = YES;
    
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(SCW/2 + 0.5 , 0, SCW/2 - 0.5, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn addTarget:self action:@selector(saveOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:saveBtn];
    _saveBtn = saveBtn;
    saveBtn.hidden = YES;
}


//取消入库
- (void)cancelSetUI{
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitle:@"取消出库" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [cancelBtn addTarget:self action:@selector(cancelTwoOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    cancelBtn.hidden = YES;
}


- (void)setCustomNavigaionView{
    
    CGFloat H = 0.0;
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        H = 88;
        Y = 49;
    }else{
        H = 64;
        Y = 25;
    }
    
    UIView * navigaionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, H)];
    navigaionView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:navigaionView];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(12, Y - 5, 40, 40);
    [leftBtn addTarget:self action:@selector(backOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [navigaionView addSubview:leftBtn];
    
    
    UILabel * contentTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW/2 - 50, Y + 5, 100, 23)];
    contentTitleLabel.text = self.selectFunctionType;
    contentTitleLabel.font = [UIFont systemFontOfSize:17];
    contentTitleLabel.textColor = [UIColor blackColor];
    contentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navigaionView addSubview:contentTitleLabel];
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, H - 1, SCW, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [navigaionView addSubview:bottomview];
    
}

//保存
- (void)saveBottomAction:(UIButton *)saveBtn{
    if (self.dataArray.count > 0) {
        if ([self testingDataComplete]) {
            self.btnType = @"save";
            [self newSaveBillNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"没有数据"];
    }
}

- (void)newSaveBillNewData{
    NSInteger totalNumber = 0;
    NSDecimalNumber * totalVolume;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
        newWeight += [storagemanagementmodel.weight doubleValue];
        newVolume += [storagemanagementmodel.volume doubleValue];
        totalNumber += storagemanagementmodel.qty;
    }
    totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
    totalVolume = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
    /**
     单据ID    billid    Int    单据唯一标识
     单据类别    billType    Sting    对应列表详见 单据类型.xlsx
     所属个人版用户ID    pwmsUserId    Int
     单据编号    billNo    Sting
     单据日期    billDate    Sting    yyyy-MM-dd
     本单石种名称汇总    mtlNames    Sting
     本单荒料编号汇总    blockNos    Sting
     单据状态    status    Int    见 状态类型枚举
     仓库ID    whsId    Int
     仓库名称    whsName    Sting
     总体积    totalVolume    Decimal    3位
     总重量    totalWeight    Decimal    3位
     创建人    createUser    Int
     创建时间    createTime    String    yyyy-MM-dd HH:mm:ss
     修改人    updateUser    Int
     修改时间    updateTime    String    yyyy-MM-dd HH:mm:ss
     确认人    checkUser    Int
     确认时间    checkTime    String    yyyy-MM-dd HH:mm:ss
     */
    //@"storageType":@"",,@"totalQty":@(totalNumber)不需要
    
    
    NSDictionary * billHeadDict = [NSDictionary dictionary];
    
    //NSDictionary * billHeadDict =
    
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
       
        billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"blockNos":@"",@"status":@"",@"whsId":@(self.warehousermodel.WareHouseID),@"whsName":self.warehousermodel.name,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber),@"factoryId":@(self.billheadmodel.factoryId),@"factoryName":self.billheadmodel.factoryName,@"notes":_remarksTextField.text};
        
    }else{
        
        billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"blockNos":@"",@"status":@"",@"whsId":@(self.warehousermodel.WareHouseID),@"whsName":self.warehousermodel.name,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber),@"notes":_remarksTextField.text};
    }

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    /**
     单据ID    billid    Int    关联表头
     明细ID    billdtlid    Int    唯一标识
     物料ID    mtlId    Int
     库区ID    storeareaId    Int     -1
     物料名称    mtlName    String
     物料类别ID    mtltypeId    Int
     物料类别名称    mtltypeName    String
     库区名称    storeareaName    String
     荒料编号    blockNo    String
     数量    qty    Int    默认1
     长    length    Decimal    1 位
     宽    width    Decimal    1 位
     厚    height    Decimal    2 位
     立方数    volume    Decimal    3位
     吨数    weight    Decimal    3位
     */
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
        [dict setObject:[NSNumber numberWithInteger:0] forKey:@"billid"];
        [dict setObject:[NSNumber numberWithInteger:0] forKey:@"billdtlid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
        [dict setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
        [dict setObject:storagemanagementmodel.mtlName forKey:@"mtlName"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
        [dict setObject:storagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
        [dict setObject:storagemanagementmodel.storageType forKey:@"storageType"];
        [dict setObject:@"" forKey:@"storeareaName"];
        [dict setObject:storagemanagementmodel.blockNo forKey:@"blockNo"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.qty] forKey:@"qty"];
        [dict setObject:storagemanagementmodel.length forKey:@"length"];
        [dict setObject:storagemanagementmodel.width forKey:@"width"];
        [dict setObject:storagemanagementmodel.height forKey:@"height"];
        [dict setObject:storagemanagementmodel.volume forKey:@"volume"];
        [dict setObject:storagemanagementmodel.weight forKey:@"weight"];
        [array addObject:dict];
    }
    [phoneDict setObject:array forKey:@"billDtl"];
    NSMutableArray * twoarray = [NSMutableArray array];
    [phoneDict setObject:twoarray forKey:@"billDtl2"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SAVEBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.dataArray removeAllObjects];
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
                
                //weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];

                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];

                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = self.billheadmodel.whsName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                
               _remarksTextField.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"notes"]];
                
                
                
                CGRect rect = [weakSelf remarksContent:_remarksTextField];
                _remarksTextField.frame =  CGRectMake(CGRectGetMaxX(_remarksLabel.frame) + 17, 13, SCW - CGRectGetMaxX(_remarksLabel.frame) - 17, rect.size.height + 10);
                if (rect.size.height < 30) {
                    _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, 50);
                }else{
                    _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, _remarksTextField.yj_height + 23);
                }
                _secondView.frame = CGRectMake(0, CGRectGetMaxY(_thirdView.frame) + 9, SCW, 49);
                [_topView setupAutoHeightWithBottomView:_secondView bottomMargin:10];
                [_topView layoutIfNeeded];
                weakSelf.tableview.tableHeaderView = _topView;
                
                
                
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    weakSelf.billheadmodel.factoryId = [json[@"data"][@"billHead"][@"factoryId"]integerValue];
                    weakSelf.billheadmodel.factoryName = json[@"data"][@"billHead"][@"factoryName"];
                    
                    _factoryLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"factoryName"]];
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                
                
                _savebottomBtn.hidden = YES;
                _remarksTextField.userInteractionEnabled = NO;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _timeBtn.hidden = YES;
               // _factoryBtn.hidden = YES;
                
                
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                
                
                
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    //                    storagemanagementmodel.turnsNo = @"";
                    //                    storagemanagementmodel.slNo = @"";
                    //                    storagemanagementmodel.preVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    //                    storagemanagementmodel.dedVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    //                    storagemanagementmodel.vaqty = [[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    //   storagemanagementmodel.name = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    //  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dataArray addObject:storagemanagementmodel];
                }
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];

            }else{
                _savebottomBtn.hidden = NO;
                _addBtn.hidden = NO;
                _scanBtn.hidden = NO;
                _timeBtn.hidden = NO;
                 _remarksTextField.userInteractionEnabled = YES;
                
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                   
                    
                     _factoryBtn.hidden = NO;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                
                
               
                
                _saveBtn.hidden = YES;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
            }
        }else{
            _savebottomBtn.hidden = NO;
            _addBtn.hidden = NO;
            _scanBtn.hidden = NO;
            _timeBtn.hidden = NO;
             _remarksTextField.userInteractionEnabled = YES;
            if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                
                
                
                _factoryBtn.hidden = NO;
                _factoryView.hidden = NO;
                
            }else{
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = YES;
            }
            
            _saveBtn.hidden = YES;
            _editSureView.hidden = YES;
            _deleteBtn.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = YES;
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}



//加载数据
//URL_LOADBILL_IOS
- (void)reloadOldSaveNewData{
    // 单据类型    billType    String    操作的单据类型  对应表详细见 单据类型对应
    // 单据ID    billid    Int
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LOADBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.dataArray removeAllObjects];
                // weakSelf.dataArray = [RSPersonalFunctionModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
               // weakSelf.billheadmodel = [RSBillHeadModel mj_objectWithKeyValues:json[@"data"][@"billHead"]];
                
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
               // weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                
                
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                _remarksTextField.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"notes"]];
                
                CGRect rect = [weakSelf remarksContent:_remarksTextField];
                _remarksTextField.frame =  CGRectMake(CGRectGetMaxX(_remarksLabel.frame) + 17, 13, SCW - CGRectGetMaxX(_remarksLabel.frame) - 17, rect.size.height + 10);
                if (rect.size.height < 30) {
                    _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, 50);
                }else{
                    _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, _remarksTextField.yj_height + 23);
                }
                _secondView.frame = CGRectMake(0, CGRectGetMaxY(_thirdView.frame) + 9, SCW, 49);
                [_topView setupAutoHeightWithBottomView:_secondView bottomMargin:10];
                [_topView layoutIfNeeded];
                weakSelf.tableview.tableHeaderView = _topView;
                
                
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    weakSelf.billheadmodel.factoryId = [json[@"data"][@"billHead"][@"factoryId"]integerValue];
                    weakSelf.billheadmodel.factoryName = json[@"data"][@"billHead"][@"factoryName"];
                    
                    _factoryLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"factoryName"]];
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                
                
                
              
                
                //这边要添加仓库的东西
                RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:WAREHOUSERSQL];
                //- (NSMutableArray*)getAllContent:(NSString *)whsType
                 NSMutableArray * warehousearray = [personlPublishDB getWarehouseID:weakSelf.billheadmodel.whsId];
                if (warehousearray.count > 0) {
                    self.warehousermodel = warehousearray[0];
                }
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
//                    storagemanagementmodel.turnsNo = @"";
//                    storagemanagementmodel.slNo = @"";
//                    storagemanagementmodel.preVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
//                    storagemanagementmodel.dedVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
//                    storagemanagementmodel.vaqty = [[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                 //   storagemanagementmodel.name = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                  //  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dataArray addObject:storagemanagementmodel];
                }
                [weakSelf.tableview reloadData];
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                
            }else{
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                  
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
            }
        }else{
             _remarksTextField.userInteractionEnabled = NO;
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
            if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                
                
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = NO;
                
            }else{
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = YES;
            }
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}





//判断完整性
- (BOOL)testingDataComplete{
    //荒料里面需要原始 平方数/立方数dedVaqty没有匝号和板号，原始 平方数/立方数也不需要 preVaqty,大板有匝号和板号原始 平方数/立方数需要 preVaqty但是不要// 原始 平方数/立方数dedVaqty
    for (int i = 0; i < self.dataArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
        if ([storagemanagementmodel.mtlName isEqualToString:@""] || [storagemanagementmodel.mtltypeName isEqualToString:@""] || [storagemanagementmodel.blockNo isEqualToString:@""] || [storagemanagementmodel.length doubleValue] <= 0.000 ||  [storagemanagementmodel.width doubleValue]<= 0.000 || [storagemanagementmodel.height doubleValue]<= 0.000 || storagemanagementmodel.qty < 1  || [storagemanagementmodel.volume doubleValue]<= 0.000) {
            return NO;
        }
    }
    return YES;
}




//删除
- (void)deleteOutAction:(UIButton *)deleteBtn{
    //跳转到上一个页面
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.btnType = @"save";
        [self deleteSureStorageBillNewData];
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

- (void)deleteSureStorageBillNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DELETEBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                _editSureView.hidden = YES;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;

                [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                 [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _saveBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                _timeBtn.hidden = YES;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
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
            _savebottomBtn.hidden = YES;
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _timeBtn.hidden = YES;
             _remarksTextField.userInteractionEnabled = NO;
            if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                
                
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = NO;
                
            }else{
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = YES;
            }
            _editSureView.hidden = NO;
            _deleteBtn.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = YES;
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


//编辑
- (void)editOutAction:(UIButton *)editBtn{
     self.btnType = @"edit";
    _savebottomBtn.hidden = YES;
    _addBtn.hidden = NO;
    _scanBtn.hidden = NO;
    _timeBtn.hidden = NO;
     _remarksTextField.userInteractionEnabled = YES;
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        
        
        
        _factoryBtn.hidden = NO;
        _factoryView.hidden = NO;
        
    }else{
        
        _factoryBtn.hidden = YES;
        _factoryView.hidden = YES;
    }
    
    _saveBtn.hidden = YES;
    
    _editSureView.hidden = YES;
    _deleteBtn.hidden = YES;
    _editBtn.hidden = YES;
    _sureBtn.hidden = YES;
    _allView.hidden = NO;
    _cancelEditBtn.hidden = NO;
    _saveBtn.hidden = NO;
    _cancelBtn.hidden = YES;
    [self.tableview reloadData];
}

//确认入库
- (void)sureOutAction:(UIButton *)editBtn{
    self.btnType = @"save";
    //    _savebottomBtn.hidden = YES;
    //    _addBtn.hidden = YES;
    //    _scanBtn.hidden = YES;
    //    _saveBtn.hidden = YES;
    //    _editSureView.hidden = YES;
    //    _deleteBtn.hidden = YES;
    //    _editBtn.hidden = YES;
    //    _sureBtn.hidden = YES;
    //    _allView.hidden = YES;
    //    _cancelEditBtn.hidden = YES;
    //    _saveBtn.hidden = YES;
    //    _cancelBtn.hidden = NO;
    [self sureStorageBillNewData];
}

- (void)sureStorageBillNewData{
    // 单据类型    billType    String
    // 单据ID    billid    Int
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CONFIRMBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = NO;
                [weakSelf.tableview reloadData];
                
               // [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"确认出库成功"];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                
                _editSureView.hidden = YES;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
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
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
            _savebottomBtn.hidden = YES;
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _timeBtn.hidden = YES;
             _remarksTextField.userInteractionEnabled = NO;
            if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                
                
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = NO;
                
            }else{
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = YES;
            }
            
            _editSureView.hidden = YES;
            _deleteBtn.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = YES;
        }
    }];
}


//修改保存
- (void)saveOutAction:(UIButton *)saveBtn{
    //这边按键要调用修改单据保存接口
    if (self.dataArray.count > 0) {
        if ([self testingDataComplete]) {
            self.btnType = @"save";
            [self modifyAndSaveOutNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
        //[self modifyAndSaveNewData];
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}


//修改保存网路请求
- (void)modifyAndSaveOutNewData{
    
    NSInteger totalNumber = 0;
    NSDecimalNumber * totalVolume;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
        newWeight += [storagemanagementmodel.weight doubleValue];
        newVolume += [storagemanagementmodel.volume doubleValue];
        totalNumber += storagemanagementmodel.qty;
    }
    totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
    totalVolume = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    
    
    
    /**
     "{\"billHead\":{\"status\":0,\"totalWeight\":39,\"updateTime\":\"2019-04-20 15:26:05\",\"pwmsUserId\":98,\"mtlNames\":\"\U95ea\U7535\U7070,\",\"totalVolume\":0.006,\"checkTime\":\"\",\"whsId\":69,\"billDate\":\"2019-04-20\",\"whsName\":\"\U8352\U6599\U4e09\U5e93\",\"billType\":\"BILL_BL_CGRK\",\"createUser\":119,\"createTime\":\"2019-04-20 15:23:12\",\"checkUser\":\"\",\"blockNos\":\"rt,\",\"billNo\":\"201904200043\",\"updateUser\":119,\"billid\":83612,\"storageType\":\"CGRK\"};
     */
    NSDictionary * billHeadDict = [NSDictionary dictionary];
    
    
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber),@"factoryId":@(self.billheadmodel.factoryId),@"factoryName":self.billheadmodel.factoryName,@"notes":_remarksTextField.text};
    }else{
        billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber),@"notes":_remarksTextField.text};
    }
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
        [dict setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
        [dict setObject:storagemanagementmodel.mtlName forKey:@"mtlName"];
        [dict setObject:storagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
        if (storagemanagementmodel.storageType == NULL) {
            [dict setObject:@"" forKey:@"storageType"];
        }else{
            [dict setObject:storagemanagementmodel.storageType forKey:@"storageType"];
        }
        
        if (storagemanagementmodel.storeareaName == NULL) {
            [dict setObject:@"" forKey:@"storeareaName"];
        }else{
            [dict setObject:storagemanagementmodel.storeareaName forKey:@"storeareaName"];
        }
        
        
       
        [dict setObject:storagemanagementmodel.blockNo forKey:@"blockNo"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
        [dict setObject:[NSNumber numberWithDouble:storagemanagementmodel.qty] forKey:@"qty"];
        [dict setObject:storagemanagementmodel.length forKey:@"length"];
        [dict setObject:storagemanagementmodel.width forKey:@"width"];
        [dict setObject:storagemanagementmodel.height forKey:@"height"];
        [dict setObject:storagemanagementmodel.volume forKey:@"volume"];
        [dict setObject:storagemanagementmodel.weight forKey:@"weight"];
        [array addObject:dict];
    }
    [phoneDict setObject:array forKey:@"billDtl"];
    [phoneDict setObject:array forKey:@"billDtl"];
    NSMutableArray * twoarray = [NSMutableArray array];
    [phoneDict setObject:twoarray forKey:@"billDtl2"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_UPDATEBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.dataArray removeAllObjects];
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
              //  weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                _remarksTextField.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"notes"]];
                
                
                
                CGRect rect = [weakSelf remarksContent:_remarksTextField];
                _remarksTextField.frame =  CGRectMake(CGRectGetMaxX(_remarksLabel.frame) + 17, 13, SCW - CGRectGetMaxX(_remarksLabel.frame) - 17, rect.size.height + 10);
                if (rect.size.height < 30) {
                    _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, 50);
                }else{
                    _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, _remarksTextField.yj_height + 23);
                }
                _secondView.frame = CGRectMake(0, CGRectGetMaxY(_thirdView.frame) + 9, SCW, 49);
                [_topView setupAutoHeightWithBottomView:_secondView bottomMargin:10];
                [_topView layoutIfNeeded];
                weakSelf.tableview.tableHeaderView = _topView;
                
                
                
                
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    weakSelf.billheadmodel.factoryId = [json[@"data"][@"billHead"][@"factoryId"]integerValue];
                    weakSelf.billheadmodel.factoryName = json[@"data"][@"billHead"][@"factoryName"];
                    
                    _factoryLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"factoryName"]];
                    
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                //_saveBtn.hidden = YES;
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    //                    storagemanagementmodel.turnsNo = @"";
                    //                    storagemanagementmodel.slNo = @"";
                    //                    storagemanagementmodel.preVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    //                    storagemanagementmodel.dedVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    //                    storagemanagementmodel.vaqty = [[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    //   storagemanagementmodel.name = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    //  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dataArray addObject:storagemanagementmodel];
                }
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = NO;
                _scanBtn.hidden = NO;
                _timeBtn.hidden = NO;
                 _remarksTextField.userInteractionEnabled = YES;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                }else{
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                //_saveBtn.hidden = YES;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _allView.hidden = NO;
                _cancelEditBtn.hidden = NO;
                _saveBtn.hidden = NO;
                _cancelBtn.hidden = YES;
                
                //[SVProgressHUD showErrorWithStatus:@"获取失败"];
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
            }
        }else{
            _savebottomBtn.hidden = YES;
            _addBtn.hidden = NO;
            _scanBtn.hidden = NO;
            _timeBtn.hidden = NO;
             _remarksTextField.userInteractionEnabled = YES;
            if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = NO;
                
            }else{
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = YES;
            }
            //_saveBtn.hidden = YES;
            _editSureView.hidden = YES;
            _deleteBtn.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _allView.hidden = NO;
            _cancelEditBtn.hidden = NO;
            _saveBtn.hidden = NO;
            _cancelBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}





//取消编辑
- (void)cancelOutAction:(UIButton *)cancelBtn{
     self.btnType = @"save";
    _savebottomBtn.hidden = YES;
    _addBtn.hidden = YES;
    _scanBtn.hidden = YES;
    _saveBtn.hidden = YES;
     _remarksTextField.userInteractionEnabled = NO;
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        
        _factoryBtn.hidden = YES;
        _factoryView.hidden = NO;
        
    }else{
        
        _factoryBtn.hidden = YES;
        _factoryView.hidden = YES;
    }
    _editSureView.hidden = NO;
    _deleteBtn.hidden = NO;
    _editBtn.hidden = NO;
    _sureBtn.hidden = NO;
    _allView.hidden = YES;
    _cancelEditBtn.hidden = YES;
    _saveBtn.hidden = YES;
    _cancelBtn.hidden = YES;
    [self reloadOldSaveNewData];
}






//取消入库
- (void)cancelTwoOutAction:(UIButton *)cancelBtn{
     self.btnType = @"save";
//    _savebottomBtn.hidden = YES;
//    _addBtn.hidden = YES;
//    _scanBtn.hidden = YES;
//    _saveBtn.hidden = YES;
//    _editSureView.hidden = NO;
//    _deleteBtn.hidden = NO;
//    _editBtn.hidden = NO;
//    _sureBtn.hidden = NO;
//    _allView.hidden = YES;
//    _cancelEditBtn.hidden = YES;
//    _saveBtn.hidden = YES;
//    _cancelBtn.hidden = YES;
    [self cancelStorageBillNewData];
}



- (void)cancelStorageBillNewData{
    // 单据类型    billType    String
    // 单据ID    billid    Int
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_UNCONFIRMBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                
                
                [weakSelf.tableview reloadData];
                //[weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"取消出库成功"];
            }else{
                
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _remarksTextField.userInteractionEnabled = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = NO;
               // [SVProgressHUD showErrorWithStatus:@"取消入库失败"];
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
            }
        }else{
            _savebottomBtn.hidden = YES;
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _timeBtn.hidden = YES;
             _remarksTextField.userInteractionEnabled = NO;
            if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = NO;
                
            }else{
                
                _factoryBtn.hidden = YES;
                _factoryView.hidden = YES;
            }
            _editSureView.hidden = YES;
            _deleteBtn.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = NO;
//            [SVProgressHUD showErrorWithStatus:@"取消入库失败"];
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


//返回回去
- (void)backOutAction:(UIButton *)leftBtn{
    if ([self.showType isEqualToString:@"new"]) {
        if ( [self.btnType isEqualToString:@"edit"] && self.dataArray.count > 0) {
            
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"你的数据未保存,需要返回吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertView addAction:alert];
            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert1];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alertView animated:YES completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if ( [self.btnType isEqualToString:@"edit"] && self.dataArray.count > 0) {
            
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"你的数据未保存,需要返回吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertView addAction:alert];
            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert1];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alertView animated:YES completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//选择仓库
- (void)addWarehouseAction:(UIButton *)addBtn{
    if ([_warehouseDetailLabel.text isEqualToString:@"请选择仓库"]) {
        RSWarehouseManagementViewController * warehouseManagementVc = [[RSWarehouseManagementViewController alloc]init];
        warehouseManagementVc.usermodel = self.usermodel;
        warehouseManagementVc.selectType = self.selectType;
        warehouseManagementVc.selectFunctionType = self.selectFunctionType;
        warehouseManagementVc.selectName = _warehouseDetailLabel.text;
        [self.navigationController pushViewController:warehouseManagementVc animated:YES];
        warehouseManagementVc.select = ^(BOOL isSelect, RSWarehouseModel * _Nonnull warehousemodel) {
            if (isSelect) {
                _warehouseDetailLabel.text = warehousemodel.name;
                self.warehousermodel = warehousemodel;
                self.billheadmodel.whsName = warehousemodel.name;
                self.billheadmodel.whsId = warehousemodel.WareHouseID;
                [self.dataArray removeAllObjects];
                [self.tableview reloadData];
            }
        };
    }else{
        if (self.dataArray.count < 1) {
            RSWarehouseManagementViewController * warehouseManagementVc = [[RSWarehouseManagementViewController alloc]init];
            warehouseManagementVc.usermodel = self.usermodel;
            warehouseManagementVc.selectType = self.selectType;
            warehouseManagementVc.selectFunctionType = self.selectFunctionType;
            warehouseManagementVc.selectName = _warehouseDetailLabel.text;
            [self.navigationController pushViewController:warehouseManagementVc animated:YES];
            warehouseManagementVc.select = ^(BOOL isSelect, RSWarehouseModel * _Nonnull warehousemodel) {
                if (isSelect) {
                    _warehouseDetailLabel.text = warehousemodel.name;
                    self.warehousermodel = warehousemodel;
                    self.billheadmodel.whsName = warehousemodel.name;
                    self.billheadmodel.whsId = warehousemodel.WareHouseID;
                    [self.dataArray removeAllObjects];
                    [self.tableview reloadData];
                }
            };
        }else{
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"修改仓库会清空已选的物料信息,是否确认修改" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                RSWarehouseManagementViewController * warehouseManagementVc = [[RSWarehouseManagementViewController alloc]init];
                warehouseManagementVc.usermodel = self.usermodel;
                warehouseManagementVc.selectType = self.selectType;
                warehouseManagementVc.selectFunctionType = self.selectFunctionType;
                warehouseManagementVc.selectName = _warehouseDetailLabel.text;
                [self.navigationController pushViewController:warehouseManagementVc animated:YES];
                warehouseManagementVc.select = ^(BOOL isSelect, RSWarehouseModel * _Nonnull warehousemodel) {
                    if (isSelect) {
                        _warehouseDetailLabel.text = warehousemodel.name;
                        self.warehousermodel = warehousemodel;
                        self.billheadmodel.whsName = warehousemodel.name;
                        self.billheadmodel.whsId = warehousemodel.WareHouseID;
                        [self.dataArray removeAllObjects];
                        [self.tableview reloadData];
                    }
                };
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


- (void)scanPurchaseAction:(UIButton *)selectBtn{
     if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
         
         if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"] && ![_factoryLabel.text isEqualToString:@"请选择加工厂"]) {
             //荒料入库
             if (self.dataArray.count < 1) {
                 
                 RSSelectiveInventoryViewController * selectiveInvenroryVc = [[RSSelectiveInventoryViewController alloc]init];
                 selectiveInvenroryVc.delegate = self;
                 selectiveInvenroryVc.dateTo = _timeShowLabel.text;
                 selectiveInvenroryVc.warehousemodel =self.warehousermodel;
                 selectiveInvenroryVc.selectType = self.selectType;
                 selectiveInvenroryVc.selectFunctionType = self.selectFunctionType;
                 selectiveInvenroryVc.usermodel = self.usermodel;
                 [self.navigationController pushViewController:selectiveInvenroryVc animated:YES];
                 
             }else{
                 if ([self testingDataComplete]) {
                     RSSelectiveInventoryViewController * selectiveInvenroryVc = [[RSSelectiveInventoryViewController alloc]init];
                     selectiveInvenroryVc.warehousemodel = self.warehousermodel;
                     selectiveInvenroryVc.selectType = self.selectType;
                     selectiveInvenroryVc.delegate = self;
                     selectiveInvenroryVc.dateTo = _timeShowLabel.text;
                     selectiveInvenroryVc.selectFunctionType = self.selectFunctionType;
                     if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
                         NSMutableArray * array = [NSMutableArray array];
                         for (int i = 0; i < self.dataArray.count; i++) {
                             RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
                             [array addObject:storagemanagementmodel];
                         }
                         // selectiveInvenroryVc.selectionArray = self.dataArray;
                         selectiveInvenroryVc.selectionArray = array;
                     }
                     selectiveInvenroryVc.usermodel = self.usermodel;
                     [self.navigationController pushViewController:selectiveInvenroryVc animated:YES];
                 }else{
                     //不成功
                     [SVProgressHUD showInfoWithStatus:@"数据不完整"];
                 }
             }
         }else{
             [SVProgressHUD showInfoWithStatus:@"请先选择需要的仓库和加工厂"];
         }
         
     }else{
         if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"]) {
             //荒料入库
             if (self.dataArray.count < 1) {
                 
                 RSSelectiveInventoryViewController * selectiveInvenroryVc = [[RSSelectiveInventoryViewController alloc]init];
                 selectiveInvenroryVc.delegate = self;
                 selectiveInvenroryVc.dateTo = _timeShowLabel.text;
                 selectiveInvenroryVc.warehousemodel =self.warehousermodel;
                 selectiveInvenroryVc.selectType = self.selectType;
                 selectiveInvenroryVc.selectFunctionType = self.selectFunctionType;
                 selectiveInvenroryVc.usermodel = self.usermodel;
                 [self.navigationController pushViewController:selectiveInvenroryVc animated:YES];
                 
             }else{
                 if ([self testingDataComplete]) {
                     RSSelectiveInventoryViewController * selectiveInvenroryVc = [[RSSelectiveInventoryViewController alloc]init];
                     selectiveInvenroryVc.warehousemodel = self.warehousermodel;
                     selectiveInvenroryVc.selectType = self.selectType;
                     selectiveInvenroryVc.delegate = self;
                     selectiveInvenroryVc.dateTo = _timeShowLabel.text;
                     selectiveInvenroryVc.selectFunctionType = self.selectFunctionType;
                     if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
                         NSMutableArray * array = [NSMutableArray array];
                         for (int i = 0; i < self.dataArray.count; i++) {
                             RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
                             [array addObject:storagemanagementmodel];
                         }
                         // selectiveInvenroryVc.selectionArray = self.dataArray;
                         selectiveInvenroryVc.selectionArray = array;
                     }
                     selectiveInvenroryVc.usermodel = self.usermodel;
                     [self.navigationController pushViewController:selectiveInvenroryVc animated:YES];
                 }else{
                     //不成功
                     [SVProgressHUD showInfoWithStatus:@"数据不完整"];
                 }
             }
         }else{
             [SVProgressHUD showInfoWithStatus:@"请先选择仓库"];
         }
     }
}


- (void)selectContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{
    if (self.dataArray.count < 1) {
        [self.dataArray addObjectsFromArray:selectArray];
    }else{
        //这边要判断下
//        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            RSStoragemanagementModel * storagemanagementmodel = obj;
//            [cancelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger dx, BOOL * _Nonnull stop) {
//                NSInteger did = [obj integerValue];
//                if ([@(storagemanagementmodel.did) isEqual:@(did)]) {
//                    [self.dataArray removeObjectAtIndex:idx];
//                }
//            }];
//        }];
        
        for (int i = 0; i < self.dataArray.count; i++) {
            RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
            for (int j = 0; j < cancelArray.count; j++) {
                NSInteger did = [cancelArray[j] integerValue];
                if ([@(storagemanagementmodel.did) isEqualToNumber:@(did)]) {
                    [self.dataArray removeObjectAtIndex:i];
                    i--;
                }
            }
        }
        
    
    
        NSMutableArray * array = [NSMutableArray array];
        //找到arr1中有,arr2中没有的数据
        [selectArray enumerateObjectsUsingBlock:^(RSStoragemanagementModel * storagemanagementmodel, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isHave = NO;
            [self.dataArray enumerateObjectsUsingBlock:^(RSStoragemanagementModel * storagemanagementmodel1, NSUInteger dx, BOOL * _Nonnull stop) {
                if ([@(storagemanagementmodel.did) isEqual:@(storagemanagementmodel1.did)]) {
                    isHave = YES;
                    *stop = YES;
                }
            }];
            if (!isHave) {
                [array addObject:storagemanagementmodel];
            }
        }];
        [self.dataArray addObjectsFromArray:array];
    }
    [self.tableview reloadData];
}



- (void)exceptionHandlingProductDeleteAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.dataArray removeObjectAtIndex:productDeleteBtn.tag];
        [self.tableview reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 217;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * EXCEPTIONHANDLINGOUTID = @"EXCEPTIONHANDLINGOUTID";
    RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGOUTID];
    if (!cell) {
    cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGOUTID];
    }
    cell.productEidtBtn.hidden = YES;
    cell.productDeleteBtn.tag = indexPath.row;
    [cell.productDeleteBtn addTarget:self action:@selector(exceptionHandlingProductDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    if([self.btnType isEqualToString:@"edit"] || [self.btnType isEqualToString:@"new"]){
        cell.productDeleteBtn.hidden = NO;
    }else{
        cell.productDeleteBtn.hidden = YES;
    }
//    if ([self.dataArray[indexPath.row] isKindOfClass:[RSStoragemanagementModel class]]) {
         cell.storagemaanagementmodel = self.dataArray[indexPath.row];
//    }else{
        // cell.selectiveInventorymodel = self.dataArray[indexPath.row];
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [self.saveAlertView closeView];
}











- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString * temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        _remarksTextField.text = temp;
        
    }else{
        _remarksTextField.text = @"";
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
    CGSize constraint = CGSizeMake(SCW - CGRectGetMaxX(_remarksLabel.frame) - 17, CGFLOAT_MAX);
    CGRect size = [textView.text boundingRectWithSize:constraint
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}
                                              context:nil];
    return size;
}



- (void)textViewDidChange:(UITextView *)textView{
    //NSLog(@"已经修改");
    //自适应文本高度
//    CGSize constraint = CGSizeMake(SCW - CGRectGetMaxX(_remarksLabel.frame) - 17, CGFLOAT_MAX);
//    CGRect size = [textView.text boundingRectWithSize:constraint
//                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                         attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}
//                                            context:nil];
    
    CGRect size =  [self remarksContent:textView];
    
    //重新调整textView的高度
    _remarksTextField.frame =  CGRectMake(CGRectGetMaxX(_remarksLabel.frame) + 17, 13, SCW - CGRectGetMaxX(_remarksLabel.frame) - 17, size.size.height + 10);
    if (size.size.height < 30) {
       _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, 50);
    }else{
       _thirdView.frame = CGRectMake(0,CGRectGetMaxY(_fristView.frame) + 9,SCW, _remarksTextField.yj_height + 23);
    }
    _secondView.frame = CGRectMake(0, CGRectGetMaxY(_thirdView.frame) + 9, SCW, 49);
    [_topView setupAutoHeightWithBottomView:_secondView bottomMargin:10];
    [_topView layoutIfNeeded];
    self.tableview.tableHeaderView = _topView;
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




@end
