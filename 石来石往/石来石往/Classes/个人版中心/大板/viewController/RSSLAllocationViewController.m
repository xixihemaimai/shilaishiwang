//
//  RSSLAllocationViewController.m
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLAllocationViewController.h"
#import "RSSaveAlertView.h"
#import "RSRightPitureButton.h"
//cell
#import "RSDabanPurchaseCell.h"
//组头
#import "RSDabanPurchaseHeaderView.h"
//选择库存
#import "RSChoosingInventoryViewController.h"

#import "RSBillHeadModel.h"
#import "RSSLStoragemanagementModel.h"
#import "RSWarehouseManagementViewController.h"


@interface RSSLAllocationViewController ()<RSChoosingInventoryViewControllerDelegate>
{
    
    
    //调拨时间
    UIButton * _timeBtn;
    //调拨时间显示
    UILabel * _timeShowLabel;
    
    
    
    //调出仓库
    UILabel * _warehouseDetailLabel;
    //调出仓库的按键
    UIButton * _addBtn;
    //调入仓库
    UILabel * _warehouseSecondDetailLabel;
    //调入仓库的按键
    UIButton * _addSecondBtn;
    //选择库存
    UIButton * _scanBtn;
    //合计按键
    RSRightPitureButton * _rightPictureBtn;
    
    //新建保存
    UIButton * _savebottomBtn;
    //编辑和确认入库
    UIView * _editSureView;
    //删除
    UIButton * _deleteBtn;
    //编辑
    UIButton * _editBtn;
    //确认入库
    UIButton * _sureBtn;
    
    
    //取消编辑和保存
    UIView * _allView;
    
    //取消编辑
    UIButton * _cancelEditBtn;
    //保存
    UIButton * _saveBtn;
    
    //取消入库
    UIButton * _cancelBtn;
    
}

@property (nonatomic,strong)NSMutableArray * dispathArray;

@property (nonatomic,strong)RSSaveAlertView * saveAlertView;
//保存选择的按键的类型
@property (nonatomic,strong)NSString * btnType;

@property (nonatomic,strong)RSBillHeadModel * billheadmodel;






@end

@implementation RSSLAllocationViewController
- (RSBillHeadModel *)billheadmodel{
    if (!_billheadmodel) {
        _billheadmodel = [[RSBillHeadModel alloc]init];
    }
    return _billheadmodel;
}

- (NSMutableArray *)dispathArray{
    if (!_dispathArray) {
        _dispathArray = [NSMutableArray array];
    }
    return _dispathArray;
}

- (RSSaveAlertView *)saveAlertView{
    if (!_saveAlertView) {
        _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 168, SCW,168)];
    }
    return _saveAlertView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //自定义导航栏
    [self setCustomDispathNavigaionView];
    
    [self setDiaoBoUI];
    //合计
    [self setUIBottomView];
    
    //保存
    [self setUISaveBottomView];
    
    //编辑和确认入库
    [self setDispatheditAndSureUI];
    
    //取消和保存
    [self setUIDispathCancelEditAndSaveSetUI];
    
    //取消入库
    [self cancelDispathSetUI];
    
    
    if ([self.showType isEqualToString:@"new"]) {
        
        //点击新建的界面
        _addBtn.hidden = NO;
        _addSecondBtn.hidden = NO;
        _scanBtn.hidden = NO;
        _savebottomBtn.hidden = NO;
        
        
        _editSureView.hidden = YES;
        _editBtn.hidden = YES;
        _sureBtn.hidden = YES;
        _deleteBtn.hidden = YES;
        
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        self.btnType = @"edit";
        
        _timeShowLabel.text = [self showCurrentTime];
        _timeBtn.hidden = NO;
        
    }else{
        self.btnType = @"save";
        //点击cell跳转过来的值，要去加载数据
        _addBtn.hidden = YES;
        _addSecondBtn.hidden = YES;
        _scanBtn.hidden = YES;
        _savebottomBtn.hidden = YES;
        
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = NO;
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
        [self reloadOldSaveNewData];
    }
}


//调拨详情
- (void)setDiaoBoUI{
    //添加tableview头部视图
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 211)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.tableHeaderView = topView;
    
    
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
    
    
    //选择仓库
    UIView * fristView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(timeView.frame) + 9, SCW, 46)];
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
    _warehouseDetailLabel = warehouseDetailLabel;
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    //[addBtn setTitle:@"+" forState:UIControlStateNormal];
    //[addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    _addBtn = addBtn;
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
    _warehouseSecondDetailLabel = warehouseSecondDetailLabel;
    
    
    UIButton * addSecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addSecondBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [addSecondBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    //[addSecondBtn setTitle:@"+" forState:UIControlStateNormal];
    //[addSecondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [secondView addSubview:addSecondBtn];
    [addSecondBtn addTarget:self action:@selector(addSecondWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addSecondBtn.layer.cornerRadius = addSecondBtn.yj_width * 0.5;
    _addSecondBtn = addSecondBtn;
    
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
    _scanBtn = scanBtn;
}

- (void)choiceChangeTimeAction:(UIButton *)timeBtn{
    NSDate * date = [self nsstringConversionNSDate:_timeShowLabel.text];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString * date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        NSMutableArray * content = [NSMutableArray array];
        for (int i = 0; i < self.dispathArray.count; i++) {
            NSMutableArray * array = self.dispathArray[i];
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
                           //这边要做的是对数组进行删除
                                          [self.dispathArray removeAllObjects];
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




- (void)setUIBottomView{
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
- (void)setUISaveBottomView{
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
- (void)setDispatheditAndSureUI{
    
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
    [sureBtn setTitle:@"确认调拨" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sureOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [editSureView addSubview:sureBtn];
    _sureBtn = sureBtn;
    sureBtn.hidden = YES;
}



//取消编辑  保存
- (void)setUIDispathCancelEditAndSaveSetUI{
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
- (void)cancelDispathSetUI{
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitle:@"取消调拨" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [cancelBtn addTarget:self action:@selector(cancelTwoOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    cancelBtn.hidden = YES;
}


- (void)setCustomDispathNavigaionView{
    
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


//FIXME:调出仓库
- (void)addWarehouseAction:(UIButton *)addBtn{
    [self.saveAlertView closeView];
    RSWarehouseManagementViewController * warehouseVc = [[RSWarehouseManagementViewController alloc]init];
    warehouseVc.usermodel = self.usermodel;
    warehouseVc.selectType = self.selectType;
    warehouseVc.selectFunctionType = self.selectFunctionType;
    warehouseVc.inputAndOutStr = @"out";
    warehouseVc.whsName = self.billheadmodel.whsName;
    warehouseVc.whsInName = self.billheadmodel.whsInName;
    [self.navigationController pushViewController:warehouseVc animated:YES];
    warehouseVc.inputAndOutselect = ^(NSString * _Nonnull inputAndOutStr, RSWarehouseModel * _Nonnull warehousemodel) {
        if ([inputAndOutStr isEqualToString:@"out"]) {
            self.billheadmodel.whsId = warehousemodel.WareHouseID;
            self.billheadmodel.whsName = warehousemodel.name;
            self.billheadmodel.whstype = warehousemodel.whstype;
            _warehouseDetailLabel.text = warehousemodel.name;
            [self.dispathArray removeAllObjects];
        }
    };
}

//FIXME:调入仓库
- (void)addSecondWarehouseAction:(UIButton *)addSecondBtn{
    [self.saveAlertView closeView];
    RSWarehouseManagementViewController * warehouseVc = [[RSWarehouseManagementViewController alloc]init];
    warehouseVc.usermodel = self.usermodel;
    warehouseVc.selectType = self.selectType;
    warehouseVc.selectFunctionType = self.selectFunctionType;
    warehouseVc.inputAndOutStr = @"input";
    warehouseVc.whsName = self.billheadmodel.whsName;
    warehouseVc.whsInName = self.billheadmodel.whsInName;
    [self.navigationController pushViewController:warehouseVc animated:YES];
    warehouseVc.inputAndOutselect = ^(NSString * _Nonnull inputAndOutStr, RSWarehouseModel * _Nonnull warehousemodel) {
        if ([inputAndOutStr isEqualToString:@"input"]) {
            self.billheadmodel.whsInId = warehousemodel.WareHouseID;
            self.billheadmodel.whsInName = warehousemodel.name;
            self.billheadmodel.whsIntype = warehousemodel.whstype;
            _warehouseSecondDetailLabel.text = warehousemodel.name;
            [self.dispathArray removeAllObjects];
        }
    };
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dispathArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 108;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSMutableArray * array = self.dispathArray[section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    if (slstoragemanagementmodel.isbool) {
        return 10;
    }else{
        return 0.001;
    }
}


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    // RSChoosingInventoryModel * choosingInventorymodel = self.dataArray[section];
//    NSMutableArray * array = self.dispathArray[section];
//    RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
//    if (slstoragemanagementmodel.isbool) {
//        NSString * ide = [NSString stringWithFormat:@"DABANOUTPURCHASEFOOTVIEW%ld",section];
//        RSDabanPurchaseFootView * dabanPurchaseFootView = [[RSDabanPurchaseFootView alloc]initWithReuseIdentifier:ide];
//        return dabanPurchaseFootView;
//    }else{
//        return nil;
//    }
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSMutableArray * array = self.dispathArray[section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    static NSString * SLALLOCATIONCELLID = @"SLALLOCATIONCELLID";
    RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:SLALLOCATIONCELLID];
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
    NSMutableArray * array = self.dispathArray[section];
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
    NSMutableArray * array = self.dispathArray[indexPath.section];
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
            NSMutableArray * array = weakSelf.dispathArray[indexPath.section];
            
            [array removeObjectAtIndex:indexPath.row];
            if (array.count < 1) {
                [weakSelf.dispathArray removeObjectAtIndex:indexPath.section];
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




//选择库存
- (void)scanPurchaseAction:(UIButton *)scanBtn{
    [self.saveAlertView closeView];
    if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"] && ![_warehouseSecondDetailLabel.text isEqualToString:@"请选择仓库"])  {
        //荒料入库
        if (self.dispathArray.count < 1) {
            RSChoosingInventoryViewController * choosingInvertoryVc = [[RSChoosingInventoryViewController alloc]init];
            choosingInvertoryVc.selectType = self.selectType;
            choosingInvertoryVc.currentTitle = self.selectFunctionType;
            choosingInvertoryVc.selectFunctionType = self.selectFunctionType;
            choosingInvertoryVc.usermodel = self.usermodel;
           // choosingInvertoryVc.warehousemodel = self.warehousermodel;
            choosingInvertoryVc.whsIn = self.billheadmodel.whsId;
            choosingInvertoryVc.whsName = self.billheadmodel.whsName;
            choosingInvertoryVc.whstype = self.billheadmodel.whstype;
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
               // choosingInvertoryVc.warehousemodel = self.warehousermodel;
                choosingInvertoryVc.whsIn = self.billheadmodel.whsId;
                choosingInvertoryVc.whsName = self.billheadmodel.whsName;
                choosingInvertoryVc.whstype = self.billheadmodel.whstype;
                choosingInvertoryVc.delegate = self;
                choosingInvertoryVc.dateTo = _timeShowLabel.text;
                if ([self.btnType isEqualToString:@"edit"]) {
                    NSMutableArray * array = [NSMutableArray array];
                    for (int i = 0; i < self.dispathArray.count; i++) {
                        NSMutableArray * contentArray = self.dispathArray[i];
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




//代理
- (void)dabanChoosingContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{
    NSMutableArray * tempArray = [NSMutableArray array];
    for (int i = 0; i < self.dispathArray.count; i++){
        NSMutableArray * array = self.dispathArray[i];
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
    [self.dispathArray removeAllObjects];
    [self.dispathArray addObjectsFromArray:changeArray];
    [self.tableview reloadData];
}



//FIXME:新建保存
- (void)saveBottomAction:(UIButton *)savebottomBtn{
    if (self.dispathArray.count > 0) {
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

//FIXME:删除
- (void)deleteOutAction:(UIButton *)deleteBtn{
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

//FIXME:编辑
- (void)editOutAction:(UIButton *)editBtn{
    self.btnType = @"edit";
    _addBtn.hidden = NO;
    _addSecondBtn.hidden = NO;
    _scanBtn.hidden = NO;
     _timeBtn.hidden = NO;
    _savebottomBtn.hidden = YES;
   
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

//FIXME:确定入库
- (void)sureOutAction:(UIButton *)sureBtn{
    self.btnType = @"save";
    [self sureStorageBillNewData];
}

//FIXME:取消编辑
- (void)cancelOutAction:(UIButton *)cancelEditBtn{
    self.btnType = @"save";
    _addBtn.hidden = YES;
    _addSecondBtn.hidden = YES;
    _scanBtn.hidden = YES;
     _timeBtn.hidden = YES;
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

//FIXME:修改保存
- (void)saveOutAction:(UIButton *)saveBtn{
    if (self.dispathArray.count > 0) {
        if ([self testingDataComplete]) {
            self.btnType = @"save";
            [self modifyAndSaveOutNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}

//FIXME:取消入库
- (void)cancelTwoOutAction:(UIButton *)cancelBtn{
    self.btnType = @"save";
    [self cancelStorageBillNewData];
}

//FIXME:返回
- (void)backOutAction:(UIButton *)leftBtn{
    if ([self.showType isEqualToString:@"new"]) {
        if ( [self.btnType isEqualToString:@"edit"] && self.dispathArray.count > 0) {
            
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
        if ( [self.btnType isEqualToString:@"edit"] && self.dispathArray.count > 0) {
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



//展开和关闭
- (void)showAndHideDabanPurchaseAction:(UIButton *)downBtn{
    NSMutableArray * array = self.dispathArray[downBtn.tag];
    downBtn.selected = !downBtn.selected;
    for (int i = 0 ; i < array.count; i++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
        slstoragemanagementmodel.isbool = !slstoragemanagementmodel.isbool;
    }
    [self.tableview reloadData];
}

//大板入库头部删除的方法
- (void)dabanPurchAseProductdDeleteAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dispathArray removeObjectAtIndex:productDeleteBtn.tag];
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
        for (int i = 0 ; i < self.dispathArray.count; i++) {
            NSMutableArray * array = self.dispathArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                newArea += [slstoragemanagementmodel.area doubleValue];
                totalNumber += slstoragemanagementmodel.qty;
                newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
            }
        }
        totalTurnsQty = self.dispathArray.count;
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
    for (int i = 0; i < self.dispathArray.count; i++) {
        NSMutableArray * array = self.dispathArray[i];
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
                _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                 _timeBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                
                [weakSelf.tableview reloadData];
               // [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"取消调拨成功"];
            }else{
                _addBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                 _timeBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                
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
             _timeBtn.hidden = YES;
            _addSecondBtn.hidden = YES;
            _scanBtn.hidden = YES;
            
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
                _addSecondBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = NO;
                [weakSelf.tableview reloadData];
                
             //   [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"确认调拨成功"];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                 _timeBtn.hidden = YES;
                  _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                
                _editSureView.hidden = YES;
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
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            _savebottomBtn.hidden = YES;
            _addBtn.hidden = YES;
             _timeBtn.hidden = YES;
              _addSecondBtn.hidden = YES;
            _scanBtn.hidden = YES;
            
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
                 _timeBtn.hidden = YES;
                  _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                
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
                 _timeBtn.hidden = YES;
                  _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                
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
             _timeBtn.hidden = YES;
              _addSecondBtn.hidden = YES;
            _scanBtn.hidden = YES;
            
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
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LOADBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.dispathArray removeAllObjects];
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
                weakSelf.billheadmodel.whsInName =  json[@"data"][@"billHead"][@"whsInName"];
                weakSelf.billheadmodel.whsInId = [json[@"data"][@"billHead"][@"whsInId"]integerValue];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _warehouseSecondDetailLabel.text = weakSelf.billheadmodel.whsInName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                
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
                    
                    
                    slstoragemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    slstoragemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    slstoragemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    
                    slstoragemanagementmodel.storeareaInId = [[[array objectAtIndex:i]objectForKey:@"storeareaInId"]integerValue];
                    //没有的值
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    //                    slstoragemanagementmodel.isSelect = true;
                    
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dispathArray = [weakSelf changeArrayRule:temp];
                [weakSelf.tableview reloadData];
                
            }else{
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
    for (int i = 0 ; i < self.dispathArray.count; i++) {
        NSMutableArray * array = self.dispathArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            newPreArea += [slstoragemanagementmodel.preArea doubleValue];
            newArea += [slstoragemanagementmodel.area doubleValue];
            totalNumber += slstoragemanagementmodel.qty;
            newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
        }
    }
    totalTurnsQty = self.dispathArray.count;
    totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
    totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
    totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    //,@"blockNos":@"",@"storageType":@""
    NSDictionary * billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"SLockNos":@"",@"status":@"",@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"whsInId":@(self.billheadmodel.whsInId),@"whsInName":self.billheadmodel.whsInName,@"totalVolume":@"",@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@""};
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.dispathArray.count; i++) {
        NSMutableArray * tempArray = self.dispathArray[i];
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
            [dict setObject:[NSNumber numberWithInteger:-1] forKey:@"storeareaInId"];
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
                [weakSelf.dispathArray removeAllObjects];
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
                weakSelf.billheadmodel.whsInName =  json[@"data"][@"billHead"][@"whsInName"];
                weakSelf.billheadmodel.whsInId = [json[@"data"][@"billHead"][@"whsInId"]integerValue];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _warehouseSecondDetailLabel.text = weakSelf.billheadmodel.whsInName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                 _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
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
                   
                    
                    slstoragemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    slstoragemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    slstoragemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    
                    slstoragemanagementmodel.storeareaInId = [[[array objectAtIndex:i]objectForKey:@"storeareaInId"]integerValue];
                    //没有的值
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    //                    slstoragemanagementmodel.isSelect = true;
                    
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dispathArray = [weakSelf changeArrayRule:temp];
                
                
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];
                
            }else{
                _savebottomBtn.hidden = NO;
                _addBtn.hidden = NO;
                _addSecondBtn.hidden = NO;
                _scanBtn.hidden = NO;
                _timeBtn.hidden = NO;
                
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
             _addSecondBtn.hidden = NO;
            _scanBtn.hidden = NO;
            _timeBtn.hidden = NO;
            
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
    for (int i = 0 ; i < self.dispathArray.count; i++) {
        NSMutableArray * array = self.dispathArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            newPreArea += [slstoragemanagementmodel.preArea doubleValue];
            newArea += [slstoragemanagementmodel.area doubleValue];
            totalNumber += slstoragemanagementmodel.qty;
            newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
        }
    }
    totalTurnsQty = self.dispathArray.count;
    totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
    totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
    totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    
    NSDictionary * billHeadDict = [NSDictionary dictionary];
    /*
    NSDictionary * billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":@"",@"mtlNames":@"",@"SLockNos":@"",@"status":@"",@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"whsInId":@(self.billheadmodel.whsInId),@"whsInName":self.billheadmodel.whsInName,@"totalVolume":@"",@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@""};
    */
    
    
    billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"SLockNos":@"",@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"whsInId":@(self.billheadmodel.whsInId),@"whsInName":self.billheadmodel.whsInName,@"totalVolume":@"",@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@""};
    
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.dispathArray.count; i++) {
        NSMutableArray * tempArray = self.dispathArray[i];
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
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.storeareaInId] forKey:@"storeareaInId"];
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
    [network getDataWithUrlString:URL_UPDATEBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.dispathArray removeAllObjects];
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
                weakSelf.billheadmodel.whsInName =  json[@"data"][@"billHead"][@"whsInName"];
                weakSelf.billheadmodel.whsInId = [json[@"data"][@"billHead"][@"whsInId"]integerValue];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _warehouseSecondDetailLabel.text = weakSelf.billheadmodel.whsInName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
                    
                    
                    slstoragemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    slstoragemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    slstoragemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    
                    slstoragemanagementmodel.storeareaInId = [[[array objectAtIndex:i]objectForKey:@"storeareaInId"]integerValue];
                    //没有的值
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    //                    slstoragemanagementmodel.isSelect = true;
                    
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dispathArray = [weakSelf changeArrayRule:temp];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = NO;
                _addSecondBtn.hidden = NO;
                _scanBtn.hidden = NO;
                _timeBtn.hidden = NO;
                
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
            _addSecondBtn.hidden = NO;
            _scanBtn.hidden = NO;
            _timeBtn.hidden = NO;
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




@end
