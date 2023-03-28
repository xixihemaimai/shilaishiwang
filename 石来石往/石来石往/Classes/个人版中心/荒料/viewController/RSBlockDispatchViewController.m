//
//  RSBlockDispatchViewController.m
//  石来石往
//
//  Created by mac on 2019/4/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBlockDispatchViewController.h"
#import "RSSaveAlertView.h"
#import "RSRightPitureButton.h"

//cell
#import "RSExceptionHandlingSecondDetailCell.h"
//选择库存
#import "RSSelectiveInventoryViewController.h"

#import "RSBillHeadModel.h"

#import "RSWarehouseManagementViewController.h"

@interface RSBlockDispatchViewController ()<RSSelectiveInventoryViewControllerDelegate>
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

@implementation RSBlockDispatchViewController

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
        _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 112, SCW, 112)];
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
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    //自定义导航栏
    [self setCustomDispathNavigaionView];
    //头部
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
        
        _timeShowLabel.text = [self showCurrentTime];
        _timeBtn.hidden = NO;
        
        self.btnType = @"edit";
        
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
    addSecondBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
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
    _scanBtn = scanBtn;
    
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [thirdView addSubview:scanBtn];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
}


- (void)choiceChangeTimeAction:(UIButton *)timeBtn{
    NSDate * date = [self nsstringConversionNSDate:_timeShowLabel.text];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString * date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        if ([self TimeWithArrayCompare:date1 andArray:self.dispathArray]) {
            //结束时间
            _timeShowLabel.text = date1;
        }else{
            
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"确定是否修改时间选择" message:@"该操作会清空所有选择的库存，是否确定?" preferredStyle:UIAlertControllerStyleAlert];
                      UIAlertAction * alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      }];
                      [alertView addAction:alert];
                      
                      UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
//                //这边要做的是对数组进行删除
//                [self.dispathArray removeAllObjects];
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




- (void)setUIBottomView{
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


//FIXME:合计
- (void)openAndCloseAction:(UIButton *)rightPictureBtn{
    rightPictureBtn.selected = !rightPictureBtn.selected;
    if (rightPictureBtn.selected) {
        NSInteger totalNumber = 0;
        NSDecimalNumber * totalWeight;
        NSDecimalNumber * totalVolume;
        
        totalNumber =self.dispathArray.count;
        double newWeight =0.0;
        double newVolume = 0.0;
        for (int i = 0 ; i < self.dispathArray.count; i++) {
            RSStoragemanagementModel * storagemanagementmodel = self.dispathArray[i];
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
    _savebottomBtn.hidden = YES;
    _addBtn.hidden = NO;
    _timeBtn.hidden = NO;
    _addSecondBtn.hidden = NO;
    _scanBtn.hidden = NO;
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


//FIXME:选择库存
- (void)scanPurchaseAction:(UIButton *)selectBtn{
    if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"] && ![_warehouseSecondDetailLabel.text isEqualToString:@"请选择仓库"]) {
        //荒料入库
        if (self.dispathArray.count < 1) {
            
            RSSelectiveInventoryViewController * selectiveInvenroryVc = [[RSSelectiveInventoryViewController alloc]init];
            selectiveInvenroryVc.delegate = self;
          //  selectiveInvenroryVc.warehousemodel =self.warehousermodel;
            selectiveInvenroryVc.whsIn = self.billheadmodel.whsId;
            selectiveInvenroryVc.whsName = self.billheadmodel.whsName;
            selectiveInvenroryVc.whstype = self.billheadmodel.whstype;
            selectiveInvenroryVc.selectType = self.selectType;
            selectiveInvenroryVc.dateTo = _timeShowLabel.text;
            selectiveInvenroryVc.selectFunctionType = self.selectFunctionType;
            selectiveInvenroryVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:selectiveInvenroryVc animated:YES];
            
        }else{
            if ([self testingDataComplete]) {
                RSSelectiveInventoryViewController * selectiveInvenroryVc = [[RSSelectiveInventoryViewController alloc]init];
               // selectiveInvenroryVc.warehousemodel = self.warehousermodel;
                selectiveInvenroryVc.selectType = self.selectType;
                selectiveInvenroryVc.delegate = self;
                selectiveInvenroryVc.dateTo = _timeShowLabel.text;
                selectiveInvenroryVc.whsIn = self.billheadmodel.whsId;
                selectiveInvenroryVc.whsName = self.billheadmodel.whsName;
                selectiveInvenroryVc.whstype = self.billheadmodel.whstype;
                selectiveInvenroryVc.selectFunctionType = self.selectFunctionType;
                if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
                    //selectiveInvenroryVc.selectionArray = self.dispathArray;
                    NSMutableArray * array = [NSMutableArray array];
                    for (int i = 0; i < self.dispathArray.count; i++) {
                        RSStoragemanagementModel * storagemanagementmodel = self.dispathArray[i];
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

- (void)selectContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{
     if (self.dispathArray.count < 1) {
        [self.dispathArray addObjectsFromArray:selectArray];
      }else{
          //这边要判断下
          [self.dispathArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              RSStoragemanagementModel * storagemanagementmodel = obj;
              [cancelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                  NSInteger did = [obj integerValue];
                  if ([@(storagemanagementmodel.did) isEqual:@(did)]) {
                      [self.dispathArray removeObjectAtIndex:idx];
                  }
              }];
          }];
          
          NSMutableArray * array = [NSMutableArray array];
          //找到arr1中有,arr2中没有的数据
          [selectArray enumerateObjectsUsingBlock:^(RSStoragemanagementModel * storagemanagementmodel, NSUInteger idx, BOOL * _Nonnull stop) {
              __block BOOL isHave = NO;
              [self.dispathArray enumerateObjectsUsingBlock:^(RSStoragemanagementModel * storagemanagementmodel1, NSUInteger idx, BOOL * _Nonnull stop) {
                  if ([@(storagemanagementmodel.did) isEqual:@(storagemanagementmodel1.did)]) {
                      isHave = YES;
                      *stop = YES;
                  }
              }];
              if (!isHave) {
                  [array addObject:storagemanagementmodel];
              }
          }];
          [self.dispathArray addObjectsFromArray:array];
      }
     [self.tableview reloadData];
}



//- (void)selectContentArray:(NSMutableArray *)selectArray{
//    if (self.dispathArray.count < 1) {
//        [self.dispathArray addObjectsFromArray:selectArray];
//    }else{
//
//    }
//    [self.tableview reloadData];
//}



//判断完整性
- (BOOL)testingDataComplete{
    //荒料里面需要原始 平方数/立方数dedVaqty没有匝号和板号，原始 平方数/立方数也不需要 preVaqty,大板有匝号和板号原始 平方数/立方数需要 preVaqty但是不要// 原始 平方数/立方数dedVaqty
    for (int i = 0; i < self.dispathArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.dispathArray[i];
        if ([storagemanagementmodel.mtlName isEqualToString:@""] || [storagemanagementmodel.mtltypeName isEqualToString:@""] || [storagemanagementmodel.blockNo isEqualToString:@""] || [storagemanagementmodel.length doubleValue] <= 0.000 ||  [storagemanagementmodel.width doubleValue]<= 0.000 || [storagemanagementmodel.height doubleValue]<= 0.000 || storagemanagementmodel.qty < 1  || [storagemanagementmodel.volume doubleValue]<= 0.000) {
            return NO;
        }
    }
    return YES;
}


//FIXME:保存
- (void)newSaveBillNewData{
    NSInteger totalNumber = 0;
    NSDecimalNumber * totalVolume;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.dispathArray.count; i++) {
        
        RSStoragemanagementModel * storagemanagementmodel = self.dispathArray[i];
        newWeight += [storagemanagementmodel.weight doubleValue];
        newVolume += [storagemanagementmodel.volume doubleValue];
        totalNumber += storagemanagementmodel.qty;
    }
    totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
    totalVolume = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
    
    //billHead
    /**
     单据ID    billid    Int    单据唯一标识
     单据类别    billType    Sting    对应列表详见 单据类型.xlsx
     所属个人版用户ID    pwmsUserId    Int
     单据编号    billNo    Sting
     单据日期    billDate    Sting    yyyy-MM-dd
     本单石种名称汇总    mtlNames    Sting
     本单荒料编号汇总    blockNos    Sting
     单据状态    status    Int    见 状态类型枚举
     调出仓库ID    whsId    Int
     调出仓库名称    whsName    Sting
     调入仓库ID    whsInId    Int
     调入仓库名称    whsInName    Sting
     总体积    totalVolume    Decimal    3位
     总重量    totalWeight    Decimal    3位
     创建人    createUser    Int
     创建时间    createTime    String    yyyy-MM-dd HH:mm:ss
     修改人    updateUser    Int
     修改时间    updateTime    String    yyyy-MM-dd HH:mm:ss
     确认人    checkUser    Int
     确认时间    checkTime    String    yyyy-MM-dd HH:mm:ss
     */
    NSDictionary * billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"blockNos":@"",@"status":@"",@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"whsInId":@(self.billheadmodel.whsInId),@"whsInName":self.billheadmodel.whsInName,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber)};
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    //billDtl
    /**
     单据ID    billid    Int    关联表头
     明细ID    billdtlid    Int    唯一标识
     库存标识    did    Int
     入库日期    receiptDate    Sting    yyyy-MM-dd
     物料ID    mtlId    Int
     库区ID    storeareaId    Int     -1
     调入库区ID    storeareaInId    Int     -1
     物料名称    mtlName    String
     物料类别ID    mtltypeId    Int
     物料类别名称    mtltypeName    String
     入库类型    storageType    Sting    见  入库类型枚举类
     库区名称    storeareaName    String
     调入库区名称    storeareaName    String
     荒料编号    blockNo    String
     数量    qty    Int    默认1
     长    length    Decimal    1 位
     宽    width    Decimal    1 位
     厚    height    Decimal    2 位
     立方数    volume    Decimal    3位
     吨数    weight    Decimal    3位
     */

    for (int i = 0; i < self.dispathArray.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        RSStoragemanagementModel * storagemanagementmodel = self.dispathArray[i];
        [dict setObject:[NSNumber numberWithInteger:0] forKey:@"billid"];
        [dict setObject:[NSNumber numberWithInteger:0] forKey:@"billdtlid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
        [dict setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
        
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaInId] forKey:@"storeareaInId"];
        
        [dict setObject:storagemanagementmodel.mtlName forKey:@"mtlName"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
        [dict setObject:storagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
        [dict setObject:storagemanagementmodel.storageType forKey:@"storageType"];
        
        
        [dict setObject:@"" forKey:@"storeareaName"];
        [dict setObject:@"" forKey:@"storeareaInName"];
        
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
                
                //weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                weakSelf.billheadmodel.whsInId = [json[@"data"][@"billHead"][@"whsInId"] integerValue];
                weakSelf.billheadmodel.whsInName = json[@"data"][@"billHead"][@"whsInName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _warehouseSecondDetailLabel.text = weakSelf.billheadmodel.whsInName;
                
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
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
                     storagemanagementmodel.storeareaInId = [[[array objectAtIndex:i]objectForKey:@"storeareaInId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.storeareaInName =  [[array objectAtIndex:i]objectForKey:@"storeareaInName"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dispathArray addObject:storagemanagementmodel];
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
                [weakSelf.dispathArray removeAllObjects];
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
                
                weakSelf.billheadmodel.whsInId = [json[@"data"][@"billHead"][@"whsInId"] integerValue];
                weakSelf.billheadmodel.whsInName = json[@"data"][@"billHead"][@"whsInName"];
                
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _warehouseSecondDetailLabel.text = weakSelf.billheadmodel.whsInName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                //这边要添加仓库的东西
                //RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:WAREHOUSERSQL];
                
                //NSMutableArray * warehousearray = [personlPublishDB getWarehouseID:weakSelf.billheadmodel.whsId];
                //self.warehousermodel = warehousearray[0];
                
                
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
                    storagemanagementmodel.storeareaInId = [[[array objectAtIndex:i]objectForKey:@"storeareaInId"]integerValue];
                    
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.storeareaInName =  [[array objectAtIndex:i]objectForKey:@"storeareaInName"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dispathArray addObject:storagemanagementmodel];
                }
                [weakSelf.tableview reloadData];
                _addBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
                 _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
            }
        }else{
            _addBtn.hidden = YES;
             _addSecondBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
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
                _addSecondBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _editSureView.hidden = NO;
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
                _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
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
                   [SVProgressHUD showSuccessWithStatus:@"确认调拨成功"];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
             _addSecondBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
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
                
                
                [weakSelf.tableview reloadData];
               // [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                  [SVProgressHUD showSuccessWithStatus:@"取消调拨成功"];
            }else{
                
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = NO;
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
            _addSecondBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
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

//修改保存网路请求
- (void)modifyAndSaveOutNewData{
    NSInteger totalNumber = 0;
    NSDecimalNumber * totalVolume;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.dispathArray.count; i++) {
        
        RSStoragemanagementModel * storagemanagementmodel = self.dispathArray[i];
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
    NSDictionary * billHeadDict = [NSDictionary dictionary];
    billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"whsInId":@(self.billheadmodel.whsInId),@"whsInName":self.billheadmodel.whsInName,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber)};
    
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.dispathArray.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        RSStoragemanagementModel * storagemanagementmodel = self.dispathArray[i];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
        [dict setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
         [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaInId] forKey:@"storeareaInId"];
        
        [dict setObject:storagemanagementmodel.mtlName forKey:@"mtlName"];
        [dict setObject:storagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
        if (storagemanagementmodel.storageType == NULL) {
            [dict setObject:@"" forKey:@"storageType"];
        }else{
            [dict setObject:storagemanagementmodel.storageType forKey:@"storageType"];
        }
        
        if (storagemanagementmodel.storeareaName == NULL) {
            [dict setObject:@"" forKey:@"storeareaName"];
             [dict setObject:@"" forKey:@"storeareaName"];
        }else{
            [dict setObject:storagemanagementmodel.storeareaName forKey:@"storeareaName"];
             [dict setObject:storagemanagementmodel.storeareaInName forKey:@"storeareaInName"];
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
                //  weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                weakSelf.billheadmodel.whsInId = [json[@"data"][@"billHead"][@"whsInId"] integerValue];
                weakSelf.billheadmodel.whsInName = json[@"data"][@"billHead"][@"whsInName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _warehouseSecondDetailLabel.text = weakSelf.billheadmodel.whsInName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                
                
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
                    storagemanagementmodel.storeareaInId = [[[array objectAtIndex:i]objectForKey:@"storeareaInId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.storeareaInName =  [[array objectAtIndex:i]objectForKey:@"storeareaInName"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dispathArray addObject:storagemanagementmodel];
                }
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];
            }else{
                _savebottomBtn.hidden = YES;
                _addBtn.hidden = NO;
                _timeBtn.hidden = NO;
                _addSecondBtn.hidden = NO;
                _scanBtn.hidden = NO;
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
    return self.dispathArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * EXCEPTIONHANDLINGDIAOID = @"EXCEPTIONHANDLINGDIAOID";
    RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGDIAOID];
    if (!cell) {
        cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGDIAOID];
    }
    cell.storagemaanagementmodel = self.dispathArray[indexPath.row];
    cell.productEidtBtn.hidden = YES;
    if ([self.btnType isEqualToString:@"edit"]) {
        cell.productDeleteBtn.hidden = NO;
    }else{
        cell.productDeleteBtn.hidden = YES;
    }
    cell.productDeleteBtn.tag = indexPath.row;
    [cell.productDeleteBtn addTarget:self action:@selector(blockDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)blockDeleteAction:(UIButton *)deleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dispathArray removeObjectAtIndex:deleteBtn.tag];
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


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [self.saveAlertView closeView];
}



@end
