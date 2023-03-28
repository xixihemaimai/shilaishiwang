//
//  RSSLOutStorageViewController.m
//  石来石往
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLOutStorageViewController.h"
//提示
#import "RSSaveAlertView.h"
//合计按键
#import "RSRightPitureButton.h"
//cell
#import "RSDabanPurchaseCell.h"
//模型
#import "RSSLStoragemanagementModel.h"
//仓库
#import "RSWarehouseManagementViewController.h"
//选择库存
#import "RSChoosingInventoryViewController.h"
//组头
#import "RSDabanPurchaseHeaderView.h"
//组尾
#import "RSDabanPurchaseFootView.h"
//加工厂
#import "RSProcessingFactoryViewController.h"

@interface RSSLOutStorageViewController ()<RSChoosingInventoryViewControllerDelegate,UITextViewDelegate>

{
    
    
    
    //入库时间
    UIButton * _timeBtn;
    //入库时间显示
    UILabel * _timeShowLabel;
    
    UIView * _factoryView;
    
    UILabel * _factoryLabel;
    
    UIButton * _factoryBtn;
    //仓库
    UILabel * _warehouseDetailLabel;
    //添加仓库按键
    UIButton * _addBtn;
    //选择库存按键
    UIButton * _scanBtn;
    //合计按键
    RSRightPitureButton * _rightPictureBtn;
    //新建保存
    UIButton * _savebottomBtn;
    //编辑和确认入库，删除view
    UIView * _editSureView;
    //删除
    UIButton * _deleteBtn;
    //编辑
    UIButton * _editBtn;
    //确认入库
    UIButton * _sureBtn;
    
    //取消编辑，修改保存view
    UIView * _allView;
    //取消编辑
    UIButton * _cancelEditBtn;
    //修改保存
    UIButton * _saveBtn;
    //取消入库
    UIButton * _cancelBtn;
    
    
    //备注
    UITextView * _remarksTextField;
    
    UILabel * _remarksLabel;
    UIView * _topView;
    UIView * _thirdView;
    UIView * _secondView;
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

@implementation RSSLOutStorageViewController

- (RSSaveAlertView *)saveAlertView{
    if (!_saveAlertView) {
    _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 168, SCW,168)];   
    }
    return _saveAlertView;
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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

static NSString * SLOUTSTORAGEHEADERVIEWID = @"SLOUTSTORAGEHEADERVIEWID";
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加自定义导航栏
    [self setCustomNavigaionView];
    //添加头部视图
    [self setDifferentUI];
    //添加尾部视图
    [self setTotalUI];
    [self setUIBottomView];
    [self seteditAndSureUI];
    [self setUICancelEditAndAllAndSaveSetUI];
    [self cancelSetUI];
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    
    if ([self.showType isEqualToString:@"new"]) {
        
        self.btnType = @"edit";
        _addBtn.hidden = NO;
        _scanBtn.hidden = NO;
        //点击新建的界面
        _savebottomBtn.hidden = NO;
        _remarksTextField.userInteractionEnabled = YES;
        _editSureView.hidden = YES;
        _editBtn.hidden = YES;
        _sureBtn.hidden = YES;
        _deleteBtn.hidden = YES;
        
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = YES;
        
        _cancelBtn.hidden = YES;
        
        
        _timeBtn.hidden = NO;
        _timeShowLabel.text = [self showCurrentTime];
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
        
        _addBtn.hidden = YES;
        _scanBtn.hidden = YES;
        _remarksTextField.userInteractionEnabled = NO;
        _savebottomBtn.hidden = YES;
        
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = YES;
       
        if (self.personalFunctionmodel.status == 0) {
            
            _editSureView.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _deleteBtn.hidden = NO;
            
            _cancelBtn.hidden = YES;
           
            
        }else{
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _deleteBtn.hidden = YES;
            
            _cancelBtn.hidden = NO;
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

- (void)setDifferentUI{
    //添加tableview头部视图
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
    remarksTextField.textAlignment = NSTextAlignmentLeft;
    remarksTextField.font = [UIFont systemFontOfSize:15];
    remarksTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    remarksTextField.delegate = self;
    remarksTextField.text = @"";
    remarksTextField.returnKeyType = UIReturnKeyDone;
    [thirdView addSubview:remarksTextField];
    _remarksTextField = remarksTextField;
   // [remarksTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
 
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    _addBtn = addBtn;
    
    
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
    [scanBtn setTitle:@"选择库存" forState:UIControlStateNormal];
    [scanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [scanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:scanBtn];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
    _scanBtn = scanBtn;
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        _factoryView.hidden = NO;
        fristView.frame = CGRectMake(0, CGRectGetMaxY(factoryView.frame) + 9, SCW, 50);
        //secondView.frame = CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 50);
        
    }else{
        _factoryView.hidden = YES;
        fristView.frame = CGRectMake(0, CGRectGetMaxY(timeView.frame) + 9, SCW, 50);
        thirdView.frame = CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 50);
        secondView.frame = CGRectMake(0, CGRectGetMaxY(thirdView.frame) + 9, SCW, 50);
    }
    
    [topView setupAutoHeightWithBottomView:secondView bottomMargin:10];
    [topView layoutIfNeeded];
    self.tableview.tableHeaderView = topView;
    
    
    
}



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


//改变时间
- (void)choiceChangeTimeAction:(UIButton *)timeBtn{
    NSDate * date = [self nsstringConversionNSDate:_timeShowLabel.text];
    //date    __NSTaggedDate *    2019-06-19 16:00:00 UTC 1
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString * date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        NSMutableArray * content = [NSMutableArray array];
        for (int i = 0; i < self.dataArray.count; i++) {
            NSMutableArray * array = self.dataArray[i];
            for (int j = 0 ; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                [content addObject:slstoragemanagementmodel];
            }
        }
        if ([self TimeWithArrayCompare:date1 andArray:content]) {
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
            
            
            
//            [JHSysAlertUtil presentAlertViewWithTitle:@"确定是否修改时间选择" message:@"该操作会清空所有选择的库存，是否确定?" cancelTitle:@"确定" defaultTitle:@"取消" distinct:YES cancel:^{
//
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
            RSSLStoragemanagementModel * slstoragemanagementmodel = dataArray[i];
            NSString * receiptDate = (NSString *)slstoragemanagementmodel.receiptDate;
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



- (void)setTotalUI{
    RSRightPitureButton * rightPictureBtn = [RSRightPitureButton buttonWithType:UIButtonTypeCustom];
    rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [rightPictureBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    [rightPictureBtn setTitle:@"合计" forState:UIControlStateNormal];
    [rightPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    [rightPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    rightPictureBtn.layer.shadowOffset =  CGSizeMake(1, 1);
    rightPictureBtn.layer.shadowOpacity = 0.8;
    rightPictureBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
    rightPictureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightPictureBtn addTarget:self action:@selector(openAndCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightPictureBtn];
    _rightPictureBtn = rightPictureBtn;
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
    _savebottomBtn = savebottomBtn;
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 108;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSMutableArray * array = self.dataArray[section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    if (slstoragemanagementmodel.isbool) {
        return 10;
    }else{
        return 0.001;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   // RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
    NSMutableArray * array = self.dataArray[section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    if (slstoragemanagementmodel.isbool) {
        NSString * ide = [NSString stringWithFormat:@"DABANOUTPURCHASEFOOTVIEW%ld",section];
        RSDabanPurchaseFootView * dabanPurchaseFootView = [[RSDabanPurchaseFootView alloc]initWithReuseIdentifier:ide];
        return dabanPurchaseFootView;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    NSMutableArray * array = self.dataArray[section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    
    RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:SLOUTSTORAGEHEADERVIEWID];
    dabanPurchaseHeaderView.downBtn.tag = section;
    dabanPurchaseHeaderView.productEidtBtn.hidden = YES;
    dabanPurchaseHeaderView.productDeleteBtn.tag = section;
    if ([self.btnType isEqualToString:@"edit"]) {
        dabanPurchaseHeaderView.productDeleteBtn.hidden = NO;
    }else{
        dabanPurchaseHeaderView.productDeleteBtn.hidden = YES;
    }
    dabanPurchaseHeaderView.slstoragemanagementmodel = slstoragemanagementmodel;
    [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    return dabanPurchaseHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
    NSMutableArray * array = self.dataArray[section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    if (slstoragemanagementmodel.isbool) {
        return array.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"DABANPURCHASECELLOUTID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    RSDabanPurchaseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RSDabanPurchaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.indexPath = indexPath;
    if ([self.btnType isEqualToString:@"edit"]) {
        cell.mainScrollView.userInteractionEnabled = YES;
    }else{
        cell.mainScrollView.userInteractionEnabled = NO;
    }
    NSMutableArray * array = self.dataArray[indexPath.section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
    
    cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
    
    cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
    
    CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.longDetailLabel.sd_layout
    .widthIs(size1.width);
    
    
    cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
    
    CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.wideDetialLabel.sd_layout
    .widthIs(size2.width);
    
    
    cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
    
    CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.thickDeitalLabel.sd_layout
    .widthIs(size3.width);
    
    cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
    CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.originalAreaDetailLabel.sd_layout
    .widthIs(size4.width);
    
    
    
    cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
    CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.deductionAreaDetailLabel.sd_layout
    .widthIs(size5.width);
    
    
    cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
    CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.actualAreaDetailLabel.sd_layout
    .widthIs(size6.width);
    
   
    
    RSWeakself
    cell.deleteAction = ^(NSIndexPath * indexPath) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray * array = weakSelf.dataArray[indexPath.section];
            
            [array removeObjectAtIndex:indexPath.row];
            if (array.count < 1) {
                [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
            }
            RSDabanPurchaseCell * cell1 = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
            [cell1.mainScrollView setContentOffset:CGPointMake(0, 0)];
            [weakSelf.tableview reloadData];
        }];
        [alertView addAction:alert];
        UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert1];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [weakSelf presentViewController:alertView animated:YES completion:nil];
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
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (RSDabanPurchaseCell * tableViewCell in self.tableview.visibleCells) {
        /// 当屏幕滑动时，关闭被打开的cell
        if (tableViewCell.isOpen == YES) {
            [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}


- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
}


//返回上一个页面
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

//添加仓库
- (void)addWarehouseAction:(UIButton *)addBtn{
    [self.saveAlertView closeView];
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

//选择库存
- (void)scanPurchaseAction:(UIButton *)scanBtn{
    [self.saveAlertView closeView];
    
    
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        
        if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"] && ![_factoryLabel.text isEqualToString:@"请选择加工厂"]) {
            //荒料入库
            if (self.dataArray.count < 1) {
                RSChoosingInventoryViewController * choosingInvertoryVc = [[RSChoosingInventoryViewController alloc]init];
                choosingInvertoryVc.selectType = self.selectType;
                choosingInvertoryVc.currentTitle = self.selectFunctionType;
                choosingInvertoryVc.selectFunctionType = self.selectFunctionType;
                choosingInvertoryVc.usermodel = self.usermodel;
                choosingInvertoryVc.warehousemodel = self.warehousermodel;
                choosingInvertoryVc.delegate = self;
                choosingInvertoryVc.dateTo = _timeShowLabel.text;
                [self.navigationController pushViewController:choosingInvertoryVc animated:YES];
            }else{
                if ([self testingDataComplete]) {
                    
                    RSChoosingInventoryViewController * choosingInvertoryVc = [[RSChoosingInventoryViewController alloc]init];
                    choosingInvertoryVc.selectType = self.selectType;
                    choosingInvertoryVc.currentTitle = self.selectFunctionType;
                    choosingInvertoryVc.selectFunctionType = self.selectFunctionType;
                    choosingInvertoryVc.usermodel = self.usermodel;
                    choosingInvertoryVc.warehousemodel = self.warehousermodel;
                    choosingInvertoryVc.delegate = self;
                    choosingInvertoryVc.dateTo = _timeShowLabel.text;
                    if ([self.btnType isEqualToString:@"edit"]) {
                        NSMutableArray * array = [NSMutableArray array];
                        for (int i = 0; i < self.dataArray.count; i++) {
                            NSMutableArray * contentArray = self.dataArray[i];
                            for (int j = 0; j < contentArray.count; j++) {
                                RSSLStoragemanagementModel * slstoragemanagementmodel = contentArray[j];
                                [array addObject:slstoragemanagementmodel];
                            }
                        }
                        choosingInvertoryVc.selectdeContentArray = array;
                    }
                    [self.navigationController pushViewController:choosingInvertoryVc animated:YES];
                }else{
                    //不成功
                    [SVProgressHUD showInfoWithStatus:@"数据不完整"];
                }
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"请先选择仓库"];
        }
        
    }else{
        if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"]) {
            //荒料入库
            if (self.dataArray.count < 1) {
                RSChoosingInventoryViewController * choosingInvertoryVc = [[RSChoosingInventoryViewController alloc]init];
                choosingInvertoryVc.selectType = self.selectType;
                choosingInvertoryVc.currentTitle = self.selectFunctionType;
                choosingInvertoryVc.selectFunctionType = self.selectFunctionType;
                choosingInvertoryVc.usermodel = self.usermodel;
                choosingInvertoryVc.warehousemodel = self.warehousermodel;
                choosingInvertoryVc.delegate = self;
                choosingInvertoryVc.dateTo = _timeShowLabel.text;
                [self.navigationController pushViewController:choosingInvertoryVc animated:YES];
            }else{
                if ([self testingDataComplete]) {
                    
                    RSChoosingInventoryViewController * choosingInvertoryVc = [[RSChoosingInventoryViewController alloc]init];
                    choosingInvertoryVc.selectType = self.selectType;
                    choosingInvertoryVc.currentTitle = self.selectFunctionType;
                    choosingInvertoryVc.selectFunctionType = self.selectFunctionType;
                    choosingInvertoryVc.usermodel = self.usermodel;
                    choosingInvertoryVc.warehousemodel = self.warehousermodel;
                    choosingInvertoryVc.delegate = self;
                    choosingInvertoryVc.dateTo = _timeShowLabel.text;
                    if ([self.btnType isEqualToString:@"edit"]) {
                        NSMutableArray * array = [NSMutableArray array];
                        for (int i = 0; i < self.dataArray.count; i++) {
                            NSMutableArray * contentArray = self.dataArray[i];
                            for (int j = 0; j < contentArray.count; j++) {
                                RSSLStoragemanagementModel * slstoragemanagementmodel = contentArray[j];
                                [array addObject:slstoragemanagementmodel];
                            }
                        }
                        choosingInvertoryVc.selectdeContentArray = array;
                    }
                    [self.navigationController pushViewController:choosingInvertoryVc animated:YES];
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
//代理
- (void)dabanChoosingContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{
    NSMutableArray * tempArray = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++){
        NSMutableArray * array = self.dataArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            [tempArray addObject:slstoragemanagementmodel];
        }
    }
    for (int i = 0; i < tempArray.count; i++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = tempArray[i];
        for (int j = 0; j < cancelArray.count; j++) {
            NSInteger did = [cancelArray[j] integerValue];
            if (slstoragemanagementmodel.did == did) {
                [cancelArray removeObject:@(did)];
                [tempArray removeObject:slstoragemanagementmodel];
                i -= 1;
            }
        }
    }
    
    NSMutableArray * array = [NSMutableArray array];
    //找到arr1中有,arr2中没有的数据
    [selectArray enumerateObjectsUsingBlock:^(RSSLStoragemanagementModel * slstoragemanagementmodel, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL isHave = NO;
            [tempArray enumerateObjectsUsingBlock:^(RSSLStoragemanagementModel * slstoragemanagementmodel1, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([@(slstoragemanagementmodel.did) isEqual:@(slstoragemanagementmodel1.did)]) {
                    isHave = YES;
                    *stop = YES;
                }
            }];
            if (!isHave) {
                [array addObject:slstoragemanagementmodel];
            }
    }];
    //NSMutableArray * changeArray = [self changeArrayRule:array];
    for (int i = 0; i < array.count; i++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
        [tempArray addObject:slstoragemanagementmodel];
    }
    NSMutableArray * changeArray = [self changeArrayRule:tempArray];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:changeArray];
    [self.tableview reloadData];
}




//新建保存
- (void)saveBottomAction:(UIButton *)savebottomBtn{
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

//编辑
- (void)editOutAction:(UIButton *)editBtn{
    self.btnType = @"edit";
    _addBtn.hidden = NO;
    _scanBtn.hidden = NO;
    _timeBtn.hidden = NO;
    _remarksTextField.userInteractionEnabled = YES;
    _savebottomBtn.hidden = YES;
    
    _editSureView.hidden = YES;
    _deleteBtn.hidden = YES;
    _editBtn.hidden = YES;
    _sureBtn.hidden = YES;
    
    _allView.hidden = NO;
    _cancelEditBtn.hidden = NO;
    _saveBtn.hidden = NO;
    _cancelBtn.hidden = YES;
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        
        _factoryBtn.hidden = NO;
        _factoryView.hidden = NO;
        
    }else{
        
        _factoryBtn.hidden = YES;
        _factoryView.hidden = YES;
    }
    [self.tableview reloadData];
    
}

//确认入库
- (void)sureOutAction:(UIButton *)sureBtn{
   self.btnType = @"save";
   [self sureStorageBillNewData];
}

//取消编辑
- (void)cancelOutAction:(UIButton *)cancelEditBtn{
    self.btnType = @"save";
    
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
    _savebottomBtn.hidden = YES;
   
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

//修改保存
- (void)saveOutAction:(UIButton *)saveBtn{
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

//取消入库
- (void)cancelTwoOutAction:(UIButton *)cancelBtn{
    self.btnType = @"save";
   [self cancelStorageBillNewData];
}




//展开和关闭
- (void)showAndHideDabanPurchaseAction:(UIButton *)downBtn{
    NSMutableArray * array = self.dataArray[downBtn.tag];
    downBtn.selected = !downBtn.selected;
    for (int i = 0 ; i < array.count; i++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
        slstoragemanagementmodel.isbool = !slstoragemanagementmodel.isbool;
    }
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:downBtn.tag];
    [self.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}

//大板入库头部删除的方法
- (void)dabanPurchAseProductdDeleteAction:(UIButton *)productDeleteBtn{
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

- (void)openAndCloseAction:(UIButton *)rightPictureBtn{
    rightPictureBtn.selected = !rightPictureBtn.selected;
    if (rightPictureBtn.selected) {
        self.saveAlertView.selectFunctionType = self.selectFunctionType;
        self.saveAlertView.selectType = self.selectType;
        
        NSInteger totalNumber = 0;
        NSInteger totalTurnsQty = 0;
       // NSDecimalNumber * totalArea;
       // NSDecimalNumber * totalPreArea;
       // NSDecimalNumber * totalDedArea;
        double newPreArea = 0.0;
        double newArea = 0.0;
        double newDedArea = 0.0;
        for (int i = 0 ; i < self.dataArray.count; i++) {
            NSMutableArray * array = self.dataArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                newArea += [slstoragemanagementmodel.area doubleValue];
                totalNumber += slstoragemanagementmodel.qty;
                newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
            }
        }
        totalTurnsQty = self.dataArray.count;
        //总匝数
        self.saveAlertView.totalNumber = [NSString stringWithFormat:@"%ld",(long)totalNumber];
        self.saveAlertView.totalWeight = [NSString stringWithFormat:@"%ld",(long)totalTurnsQty];
        
        self.saveAlertView.totalPreArea = [self number:newPreArea preciseDecimal:3];
        //[NSString stringWithFormat:@"%@",totalPreArea];
        
        self.saveAlertView.totalDedArea = [self number:newDedArea preciseDecimal:3];
        //[NSString stringWithFormat:@"%@",totalDedArea];
        
        self.saveAlertView.totalArea = [self number:newArea preciseDecimal:3];
        //[NSString stringWithFormat:@"%@",totalArea];
        

        rightPictureBtn.frame = CGRectMake(0, SCH - 86 - 168, SCW, 36);
        [self.saveAlertView showView];
    }else{
        rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
        [self.saveAlertView closeView];
    }
}


- (NSString *)number:(double)x preciseDecimal:(NSUInteger)p {
    //    四舍五入
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:p raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:x];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    //    生成需要精确的小数点格式，
    //    比如精确到小数点第3位，格式为“0.000”；精确到小数点第4位，格式为“0.0000”；
    //    也就是说精确到第几位，小数点后面就有几个“0”
    NSMutableString *formatterString = [NSMutableString stringWithString:@"0."];
    for (NSInteger i = 0; i < p; ++i) {
        [formatterString appendString:@"0"];
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //    设置生成好的格式，
    [formatter setPositiveFormat:formatterString];
    //    然后把这个number 对象格式化成我们需要的格式，
    //    最后以string 类型返回结果。
    return [formatter stringFromNumber:roundedOunces];
}





- (NSMutableArray *)changeArrayRule:(NSArray *)contentarray{
    NSMutableArray *dateMutablearray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
    for (int i = 0; i < array.count; i ++) {
        //NSString *string = array[i];
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:slstoragemanagementmodel];
        for (int j = i+1;j < array.count; j ++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel1 = array[j];
            if([slstoragemanagementmodel1.mtlName isEqualToString:slstoragemanagementmodel.mtlName] && [slstoragemanagementmodel1.turnsNo isEqualToString:slstoragemanagementmodel.turnsNo] && [slstoragemanagementmodel1.blockNo isEqualToString:slstoragemanagementmodel.blockNo]){
                [tempArray addObject:slstoragemanagementmodel1];
                [array removeObjectAtIndex:j];
                j = j - 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    return dateMutablearray;
}





//判断完整性
- (BOOL)testingDataComplete{
    //荒料里面需要原始 平方数/立方数dedVaqty没有匝号和板号，原始 平方数/立方数也不需要 preVaqty,大板有匝号和板号原始 平方数/立方数需要 preVaqty但是不要// 原始 平方数/立方数dedVaqty
    //NSMutableArray * array = self.dataArray[section];
    // RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    // || [slstoragemanagementmodel.dedArea doubleValue] <= 0.000
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableArray * array = self.dataArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            if ([slstoragemanagementmodel.mtlName isEqualToString:@""] || [slstoragemanagementmodel.mtltypeName isEqualToString:@""] || [slstoragemanagementmodel.turnsNo isEqualToString:@""] || [slstoragemanagementmodel.slNo isEqualToString:@""] || [slstoragemanagementmodel.preArea doubleValue] <= 0.000||
                [slstoragemanagementmodel.area doubleValue] <= 0.000 ||
                [slstoragemanagementmodel.blockNo isEqualToString:@""] ||  [slstoragemanagementmodel.length doubleValue] <= 0.000 ||  [slstoragemanagementmodel.width doubleValue]<= 0.000 || [slstoragemanagementmodel.height doubleValue]<= 0.000 || slstoragemanagementmodel.qty < 1 ) {
                return NO;
            }
        }
    }
    return YES;
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
                
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
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
           //     [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"取消出库成功"];
            }else{
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
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
           [SVProgressHUD showErrorWithStatus:@"获取失败"];
            
        }
    }];
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
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
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
                
              //  [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"确认出库成功"];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _remarksTextField.userInteractionEnabled = NO;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
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
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            _savebottomBtn.hidden = YES;
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
    //http://192.168.1.139:8099/slsw/pwms/loadBill.do URL_LOADBILL_IOS
    //NSString * str = @"http://192.168.1.139:8099/slsw/pwms/loadBill.do";
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LOADBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
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
//                weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                //新增的4个值
                weakSelf.billheadmodel.totalTurnsQty = [json[@"data"][@"billHead"][@"totalTurnsQty"] integerValue];
                weakSelf.billheadmodel.totalDedArea = json[@"data"][@"billHead"][@"totalDedArea"];
                weakSelf.billheadmodel.totalArea = json[@"data"][@"billHead"][@"totalArea"];
                weakSelf.billheadmodel.totalPreArea = json[@"data"][@"billHead"][@"totalPreArea"];
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _remarksTextField.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"notes"]];
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                
                
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
                NSMutableArray * temp = [NSMutableArray array];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                    slstoragemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    slstoragemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    slstoragemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstoragemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstoragemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    slstoragemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    slstoragemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    slstoragemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    slstoragemanagementmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slstoragemanagementmodel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    slstoragemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    slstoragemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slstoragemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    /**实际面积*/
                    slstoragemanagementmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    /**扣尺面积*/
                    slstoragemanagementmodel.dedArea = [[array objectAtIndex:i]objectForKey:@"dedArea"];
                    /**原始面积*/
                    slstoragemanagementmodel.preArea = [[array objectAtIndex:i]objectForKey:@"preArea"];
                    /**扣尺长1*/
                    slstoragemanagementmodel.dedLengthOne = [[array objectAtIndex:i]objectForKey:@"dedLengthOne"];
                    /**扣尺宽1*/
                    slstoragemanagementmodel.dedWidthOne = [[array objectAtIndex:i]objectForKey:@"dedWidthOne"];
                    
                    /**扣尺长2*/
                    slstoragemanagementmodel.dedLengthTwo = [[array objectAtIndex:i]objectForKey:@"dedLengthTwo"];
                    /**扣尺宽2*/
                    slstoragemanagementmodel.dedWidthTwo = [[array objectAtIndex:i]objectForKey:@"dedWidthTwo"];
                    
                    /**扣尺长3*/
                    slstoragemanagementmodel.dedLengthThree = [[array objectAtIndex:i]objectForKey:@"dedLengthThree"];
                    /**扣尺宽3*/
                    slstoragemanagementmodel.dedWidthThree = [[array objectAtIndex:i]objectForKey:@"dedWidthThree"];
                    
                    /**扣尺长4*/
                    slstoragemanagementmodel.dedLengthFour = [[array objectAtIndex:i]objectForKey:@"dedLengthFour"];
                    /**扣尺宽4*/
                    slstoragemanagementmodel.dedWidthFour = [[array objectAtIndex:i]objectForKey:@"dedWidthFour"];
                    
                    
                    slstoragemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    slstoragemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    
                     slstoragemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
//                    slstoragemanagementmodel.isSelect = true;
                    
                    //没有的值
                    slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                      slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    
                   
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dataArray = [weakSelf changeArrayRule:temp];
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
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}



- (void)newSaveBillNewData{
    NSInteger totalNumber = 0;
    NSInteger totalTurnsQty = 0;
    NSDecimalNumber * totalArea;
    NSDecimalNumber * totalPreArea;
    NSDecimalNumber * totalDedArea;
    double newPreArea = 0.0;
    double newArea = 0.0;
    double newDedArea = 0.0;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        NSMutableArray * array = self.dataArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            newPreArea += [slstoragemanagementmodel.preArea doubleValue];
            newArea += [slstoragemanagementmodel.area doubleValue];
            totalNumber += slstoragemanagementmodel.qty;
            newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
        }
    }
    totalTurnsQty = self.dataArray.count;
    totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
    totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
    totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    //,@"blockNos":@"",@"storageType":@""
    NSDictionary * billHeadDict = [NSDictionary dictionary];
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"bLockNos":@"",@"status":@"",@"whsId":@(self.warehousermodel.WareHouseID),@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"whsName":self.warehousermodel.name,@"factoryId":@(self.billheadmodel.factoryId),@"factoryName":self.billheadmodel.factoryName,@"notes":_remarksTextField.text};
       
        
    }else{
        billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"bLockNos":@"",@"status":@"",@"whsId":@(self.warehousermodel.WareHouseID),@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"whsName":self.warehousermodel.name,@"notes":_remarksTextField.text};
    }
    
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableArray * tempArray = self.dataArray[i];
        for (int j = 0; j < tempArray.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = tempArray[j];
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setObject:@"" forKey:@"billid"];
            [dict setObject:@"" forKey:@"billdtlid"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.did] forKey:@"did"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtlId] forKey:@"mtlId"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
            [dict setObject:slstoragemanagementmodel.storageType forKey:@"storageType"];
            
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.storeareaId] forKey:@"storeareaId"];
            [dict setObject:slstoragemanagementmodel.blockNo forKey:@"blockNo"];
            [dict setObject:slstoragemanagementmodel.turnsNo forKey:@"turnsNo"];
            [dict setObject:slstoragemanagementmodel.slNo forKey:@"slNo"];
            
            [dict setObject:slstoragemanagementmodel.receiptDate forKey:@"receiptDate"];
            
            [dict setObject:[NSNumber numberWithDouble:slstoragemanagementmodel.qty] forKey:@"qty"];
            [dict setObject:slstoragemanagementmodel.length forKey:@"length"];
            [dict setObject:slstoragemanagementmodel.width forKey:@"width"];
            [dict setObject:slstoragemanagementmodel.height forKey:@"height"];
            [dict setObject:slstoragemanagementmodel.preArea forKey:@"preArea"];
            [dict setObject:slstoragemanagementmodel.dedArea forKey:@"dedArea"];
            [dict setObject:slstoragemanagementmodel.area forKey:@"area"];
            
            [dict setObject:slstoragemanagementmodel.mtltypeName forKey:@"mtltypeName"];
            
            [dict setObject:slstoragemanagementmodel.mtlName forKey:@"mtlName"];
            
            [dict setObject:slstoragemanagementmodel.storeareaName forKey:@"storeareaName"];
            
            [dict setObject:slstoragemanagementmodel.dedLengthOne forKey:@"dedLengthOne"];
            [dict setObject:slstoragemanagementmodel.dedWidthOne forKey:@"dedWidthOne"];
            [dict setObject:slstoragemanagementmodel.dedLengthTwo forKey:@"dedLengthTwo"];
            [dict setObject:slstoragemanagementmodel.dedWidthTwo forKey:@"dedWidthTwo"];
            [dict setObject:slstoragemanagementmodel.dedLengthThree forKey:@"dedLengthThree"];
            [dict setObject:slstoragemanagementmodel.dedWidthThree forKey:@"dedWidthThree"];
            [dict setObject:slstoragemanagementmodel.dedLengthFour forKey:@"dedLengthFour"];
            [dict setObject:slstoragemanagementmodel.dedWidthFour forKey:@"dedWidthFour"];
            //[dict setObject:slstoragemanagementmodel.weight forKey:@"weight"];
            [array addObject:dict];
        }
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
                //                weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                //新增的4个值
                weakSelf.billheadmodel.totalTurnsQty = [json[@"data"][@"billHead"][@"totalTurnsQty"] integerValue];
                weakSelf.billheadmodel.totalDedArea = json[@"data"][@"billHead"][@"totalDedArea"];
                weakSelf.billheadmodel.totalArea = json[@"data"][@"billHead"][@"totalArea"];
                weakSelf.billheadmodel.totalPreArea = json[@"data"][@"billHead"][@"totalPreArea"];
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                 _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                 _remarksTextField.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"notes"]];
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _remarksTextField.userInteractionEnabled = NO;
                
                
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
 
                _editSureView.hidden = NO;
                
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
        
                NSMutableArray * temp = [NSMutableArray array];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                    slstoragemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    slstoragemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    slstoragemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstoragemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstoragemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    slstoragemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    slstoragemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    slstoragemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    slstoragemanagementmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slstoragemanagementmodel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    slstoragemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    slstoragemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slstoragemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    /**实际面积*/
                    slstoragemanagementmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    /**扣尺面积*/
                    slstoragemanagementmodel.dedArea = [[array objectAtIndex:i]objectForKey:@"dedArea"];
                    /**原始面积*/
                    slstoragemanagementmodel.preArea = [[array objectAtIndex:i]objectForKey:@"preArea"];
                    /**扣尺长1*/
                    slstoragemanagementmodel.dedLengthOne = [[array objectAtIndex:i]objectForKey:@"dedLengthOne"];
                    /**扣尺宽1*/
                    slstoragemanagementmodel.dedWidthOne = [[array objectAtIndex:i]objectForKey:@"dedWidthOne"];
                    
                    /**扣尺长2*/
                    slstoragemanagementmodel.dedLengthTwo = [[array objectAtIndex:i]objectForKey:@"dedLengthTwo"];
                    /**扣尺宽2*/
                    slstoragemanagementmodel.dedWidthTwo = [[array objectAtIndex:i]objectForKey:@"dedWidthTwo"];
                    
                    /**扣尺长3*/
                    slstoragemanagementmodel.dedLengthThree = [[array objectAtIndex:i]objectForKey:@"dedLengthThree"];
                    /**扣尺宽3*/
                    slstoragemanagementmodel.dedWidthThree = [[array objectAtIndex:i]objectForKey:@"dedWidthThree"];
                    
                    /**扣尺长4*/
                    slstoragemanagementmodel.dedLengthFour = [[array objectAtIndex:i]objectForKey:@"dedLengthFour"];
                    /**扣尺宽4*/
                    slstoragemanagementmodel.dedWidthFour = [[array objectAtIndex:i]objectForKey:@"dedWidthFour"];
                    
                    
                    slstoragemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    slstoragemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    slstoragemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    
                    
                    //没有的值
                    slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
//                    slstoragemanagementmodel.isSelect = true;
                    
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dataArray = [weakSelf changeArrayRule:temp];
                
                
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



//修改保存网路请求
- (void)modifyAndSaveOutNewData{
    
    NSInteger totalNumber = 0;
    NSInteger totalTurnsQty = 0;
    NSDecimalNumber * totalArea;
    NSDecimalNumber * totalPreArea;
    NSDecimalNumber * totalDedArea;
    double newPreArea = 0.0;
    double newArea = 0.0;
    double newDedArea = 0.0;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        NSMutableArray * array = self.dataArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            newPreArea += [slstoragemanagementmodel.preArea doubleValue];
            newArea += [slstoragemanagementmodel.area doubleValue];
            totalNumber += slstoragemanagementmodel.qty;
            newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
        }
    }
    totalTurnsQty = self.dataArray.count;
    totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
    totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
    totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];

    NSDictionary * billHeadDict = [NSDictionary dictionary];
    
    if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
        billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"whsName":self.billheadmodel.whsName,@"factoryId":@(self.billheadmodel.factoryId),@"factoryName":self.billheadmodel.factoryName,@"notes":_remarksTextField.text};
    }else{
         billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"whsName":self.billheadmodel.whsName,@"notes":_remarksTextField.text};
    }
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableArray * tempArray = self.dataArray[i];
        for (int j = 0; j < tempArray.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = tempArray[j];
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.billid] forKey:@"billid"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.billdtlid] forKey:@"billdtlid"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.did] forKey:@"did"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtlId] forKey:@"mtlId"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
            [dict setObject:slstoragemanagementmodel.storageType forKey:@"storageType"];
            
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.storeareaId] forKey:@"storeareaId"];
            [dict setObject:slstoragemanagementmodel.blockNo forKey:@"blockNo"];
            [dict setObject:slstoragemanagementmodel.turnsNo forKey:@"turnsNo"];
            [dict setObject:slstoragemanagementmodel.slNo forKey:@"slNo"];
            
            [dict setObject:slstoragemanagementmodel.receiptDate forKey:@"receiptDate"];
            
            [dict setObject:[NSNumber numberWithDouble:slstoragemanagementmodel.qty] forKey:@"qty"];
            [dict setObject:slstoragemanagementmodel.length forKey:@"length"];
            [dict setObject:slstoragemanagementmodel.width forKey:@"width"];
            [dict setObject:slstoragemanagementmodel.height forKey:@"height"];
            [dict setObject:slstoragemanagementmodel.preArea forKey:@"preArea"];
            [dict setObject:slstoragemanagementmodel.dedArea forKey:@"dedArea"];
            [dict setObject:slstoragemanagementmodel.area forKey:@"area"];
            
            [dict setObject:slstoragemanagementmodel.mtltypeName forKey:@"mtltypeName"];
            
            [dict setObject:slstoragemanagementmodel.mtlName forKey:@"mtlName"];
            
            [dict setObject:slstoragemanagementmodel.storeareaName forKey:@"storeareaName"];
            
            [dict setObject:slstoragemanagementmodel.dedLengthOne forKey:@"dedLengthOne"];
            [dict setObject:slstoragemanagementmodel.dedWidthOne forKey:@"dedWidthOne"];
            [dict setObject:slstoragemanagementmodel.dedLengthTwo forKey:@"dedLengthTwo"];
            [dict setObject:slstoragemanagementmodel.dedWidthTwo forKey:@"dedWidthTwo"];
            [dict setObject:slstoragemanagementmodel.dedLengthThree forKey:@"dedLengthThree"];
            [dict setObject:slstoragemanagementmodel.dedWidthThree forKey:@"dedWidthThree"];
            [dict setObject:slstoragemanagementmodel.dedLengthFour forKey:@"dedLengthFour"];
            [dict setObject:slstoragemanagementmodel.dedWidthFour forKey:@"dedWidthFour"];
            //[dict setObject:slstoragemanagementmodel.weight forKey:@"weight"];
            [array addObject:dict];
        }
    }
    [phoneDict setObject:array forKey:@"billDtl"];
    NSMutableArray * twoarray = [NSMutableArray array];
    [phoneDict setObject:twoarray forKey:@"billDtl2"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    //URL_UPDATEBILL_IOS
    
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
                //                weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                //新增的4个值
                weakSelf.billheadmodel.totalTurnsQty = [json[@"data"][@"billHead"][@"totalTurnsQty"] integerValue];
                weakSelf.billheadmodel.totalDedArea = json[@"data"][@"billHead"][@"totalDedArea"];
                weakSelf.billheadmodel.totalArea = json[@"data"][@"billHead"][@"totalArea"];
                weakSelf.billheadmodel.totalPreArea = json[@"data"][@"billHead"][@"totalPreArea"];
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                 _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                 _remarksTextField.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"notes"]];
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _remarksTextField.userInteractionEnabled = NO;
                _timeBtn.hidden = YES;
                
                
                
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
                
                
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                NSMutableArray * temp = [NSMutableArray array];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                    slstoragemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    slstoragemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    slstoragemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstoragemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstoragemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    slstoragemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    slstoragemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    slstoragemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    slstoragemanagementmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slstoragemanagementmodel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    slstoragemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    slstoragemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slstoragemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    /**实际面积*/
                    slstoragemanagementmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    /**扣尺面积*/
                    slstoragemanagementmodel.dedArea = [[array objectAtIndex:i]objectForKey:@"dedArea"];
                    /**原始面积*/
                    slstoragemanagementmodel.preArea = [[array objectAtIndex:i]objectForKey:@"preArea"];
                    /**扣尺长1*/
                    slstoragemanagementmodel.dedLengthOne = [[array objectAtIndex:i]objectForKey:@"dedLengthOne"];
                    /**扣尺宽1*/
                    slstoragemanagementmodel.dedWidthOne = [[array objectAtIndex:i]objectForKey:@"dedWidthOne"];
                    
                    /**扣尺长2*/
                    slstoragemanagementmodel.dedLengthTwo = [[array objectAtIndex:i]objectForKey:@"dedLengthTwo"];
                    /**扣尺宽2*/
                    slstoragemanagementmodel.dedWidthTwo = [[array objectAtIndex:i]objectForKey:@"dedWidthTwo"];
                    
                    /**扣尺长3*/
                    slstoragemanagementmodel.dedLengthThree = [[array objectAtIndex:i]objectForKey:@"dedLengthThree"];
                    /**扣尺宽3*/
                    slstoragemanagementmodel.dedWidthThree = [[array objectAtIndex:i]objectForKey:@"dedWidthThree"];
                    
                    /**扣尺长4*/
                    slstoragemanagementmodel.dedLengthFour = [[array objectAtIndex:i]objectForKey:@"dedLengthFour"];
                    /**扣尺宽4*/
                    slstoragemanagementmodel.dedWidthFour = [[array objectAtIndex:i]objectForKey:@"dedWidthFour"];

                    slstoragemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    slstoragemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    slstoragemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    //没有的值
                    slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
//                    slstoragemanagementmodel.isSelect = true;
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dataArray = [weakSelf changeArrayRule:temp];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = NO;
                _scanBtn.hidden = NO;
                 _remarksTextField.userInteractionEnabled = YES;
                _timeBtn.hidden = NO;
                if ([self.selectFunctionType isEqualToString:@"加工出库"]) {
                    
                    _factoryBtn.hidden = NO;
                    _factoryView.hidden = NO;
                    
                }else{
                    
                    _factoryBtn.hidden = YES;
                    _factoryView.hidden = YES;
                }
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                
                _allView.hidden = NO;
                _cancelEditBtn.hidden = NO;
                _saveBtn.hidden = NO;
                
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
    NSLog(@"已经修改");
    //自适应文本高度
//    CGSize constraint = CGSizeMake(SCW - CGRectGetMaxX(_remarksLabel.frame) - 17, CGFLOAT_MAX);
//    CGRect size = [textView.text boundingRectWithSize:constraint
//                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}
//                                              context:nil];
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
