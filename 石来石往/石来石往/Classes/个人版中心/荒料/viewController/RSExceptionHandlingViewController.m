//
//  RSExceptionHandlingViewController.m
//  石来石往
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSExceptionHandlingViewController.h"
#define margin 22
#define ECA 3
#import "RSExceptionHandlingHeaderView.h"
#import "RSExceptionHandlingProductNameHeaderView.h"
#import "RSExceptionHandlingDataHeaderView.h"

#import "RSExceptionHanlingCell.h"
#import "RSExceptionHandlingSecondDetailCell.h"
#import "RSExceptionHanlingSecondCell.h"
#import "RSExceptionHandlingThirdCell.h"

//选择库存
#import "RSSelectiveInventoryViewController.h"
//尺寸变更
#import "RSAlterationOfWasteMaterialViewController.h"
//模型
#import "RSBillHeadModel.h"
//模型
#import "RSSelectiveInventoryModel.h"
//模型
#import "RSStoragemanagementModel.h"
//组尾的视图
#import "RSExceptionFootView.h"

@interface RSExceptionHandlingViewController ()<RSSelectiveInventoryViewControllerDelegate,RSAlterationOfWasteMaterialViewControllerDelegate>
{
 
    
    //调拨时间
    UIButton * _timeBtn;
    //调拨时间显示
    UILabel * _timeShowLabel;
    /**选择物料*/
    UIButton * _selectBtn;
    /**保存*/
    UIButton * _newBtn;
    /**编辑，确认入库 删除*/
    UIView * _editSureView;
    /**删除*/
    UIButton * _deleteBtn;
    /**编辑*/
    UIButton * _editBtn;
    /**确认入库*/
    UIButton * _sureBtn;
    /**取消编辑 保存*/
    UIView * _allView;
    /**取消编辑*/
    UIButton * _cancelEditBtn;
    /**修改保存*/
    UIButton * _saveBtn;
    /**取消入库*/
    UIButton * _cancelBtn;

}

@property (nonatomic,strong)RSBillHeadModel * billheadmodel;


/**组的数组*/
@property (nonatomic,strong)NSMutableArray * headerArray;

//处理加1的数组
@property (nonatomic,strong)NSMutableArray * abnormalArray;


@property (nonatomic,strong)UIButton * currentSelectBtn;

//保存选择的按键的类型
@property (nonatomic,strong)NSString * btnType;

@end

@implementation RSExceptionHandlingViewController

- (RSBillHeadModel *)billheadmodel{
    if (!_billheadmodel) {
        _billheadmodel = [[RSBillHeadModel alloc]init];
    }
    return _billheadmodel;
}




- (NSMutableArray *)headerArray{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}


- (NSMutableArray *)abnormalArray{
    if (!_abnormalArray) {
        _abnormalArray = [NSMutableArray array];
    }
    return _abnormalArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

static NSString * EXCEPTIONHEADERVIEW = @"EXCEPTIONHEADERVIEW";
static NSString * EXCEPTIONHANDLINGPRODUCTNAMEHEADERVIEW = @"EXCEPTIONHANDLINGPRODUCTNAMEHEADERVIEW";
static NSString * EXCEPTIONHANDLINGDATAHEADERVIEW = @"EXCEPTIONHANDLINGDATAHEADERVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    //self.title = @"异常处理";
    
    //[self.view addSubview:self.tableview];
    
    [self setCustomNavigaionView];
    
    
    [self setHeaderView];
    
    [self setUIBottomView];
    
    [self seteditAndSureUI];
    
    [self setUICancelEditAndAllAndSaveSetUI];
    
    [self cancelSetUI];
    
    
    [self setCustomTableviewFootView];
    
    if ([self.showType isEqualToString:@"new"]) {
        //点击新建的界面
//        _savebottomBtn.hidden = NO;
        
        self.btnType = @"edit";
        _selectBtn.hidden = NO;
        _newBtn.hidden = NO;
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        _editSureView.hidden = YES;
        _editBtn.hidden = YES;
        _sureBtn.hidden = YES;
        _deleteBtn.hidden = YES;
        
        
        _timeBtn.hidden = NO;
        _timeShowLabel.text = [self showCurrentTime];
        
        
    }else{
        self.btnType = @"save";
        _selectBtn.hidden = YES;
         _newBtn.hidden = YES;
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = NO;
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
        [self blockExceptionreloadNewData];
    }
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


- (void)backOutAction:(UIButton *)leftBtn{
    if ([self.showType isEqualToString:@"new"]) {
        if ([self.btnType isEqualToString:@"edit"] && self.headerArray.count > 0) {
            
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
        if ( [self.btnType isEqualToString:@"edit"] && self.headerArray.count > 0) {
            
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




- (void)setHeaderView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 186)];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#F3F3F3"];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 68)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:topView];
    
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCW - 24, 68)];
    contentView.backgroundColor = [UIColor clearColor];
    [topView addSubview:contentView];
    
    CGFloat btnW = (contentView.bounds.size.width - (ECA + 1)*margin)/ECA;
    CGFloat btnH = 32;
    for (int i = 0 ; i < 3; i++) {
        UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        publishBtn.tag = 10000 + i;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        CGFloat btnY =  row * (margin + btnH) + margin;
        publishBtn.layer.cornerRadius = 9;
        publishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        if (i == 0) {
            
            [publishBtn setTitle:@"断裂处理" forState:UIControlStateNormal];
           
            [ publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [ publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            [ publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#E8EAEF"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
            
            
        }else if (i == 1){
            [publishBtn setTitle:@"尺寸变更" forState:UIControlStateNormal];
            [ publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [ publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            [ publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#E8EAEF"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
            

        }else{
            [publishBtn setTitle:@"物料变更" forState:UIControlStateNormal];
            [ publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [ publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            [ publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#E8EAEF"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
            
        }
        
        
        
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [contentView addSubview:publishBtn];
        [publishBtn addTarget:self action:@selector(changSelectFunction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.showType isEqualToString:@"new"]) {
            if (i == 0) {
                publishBtn.selected = YES;
                self.currentSelectBtn = publishBtn;
                [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
                [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                [publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#A3B9FE"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
            }
            
        }else{
            
            if ([self.personalFunctionmodel.abType isEqualToString:@"dlcl"]) {
                if (i == 0) {
                    publishBtn.selected = YES;
                    self.currentSelectBtn = publishBtn;
                    [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
                    [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                    [publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#A3B9FE"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
                }
            }else if ([self.personalFunctionmodel.abType isEqualToString:@"ccbg"]){
                if (i == 1) {
                    publishBtn.selected = YES;
                    self.currentSelectBtn = publishBtn;
                    [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
                    [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                    [publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#A3B9FE"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
                }
            }else{
                if (i == 2) {
                    publishBtn.selected = YES;
                    self.currentSelectBtn = publishBtn;
                    [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
                    [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                    [publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#A3B9FE"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
                }
            }
        }
    }
    
    
    
    //时间
    UIView * timeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 10, SCW, 50)];
    timeView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:timeView];
    
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
    
    
    
    
    UIView * informationView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(timeView.frame) + 10, SCW, 48)];
    informationView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:informationView];
    
    UILabel * informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 14, 62, 21)];
    informationLabel.text = @"物料信息";
    informationLabel.textAlignment = NSTextAlignmentLeft;
    informationLabel.font = [UIFont systemFontOfSize:15];
    informationLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [informationView addSubview:informationLabel];
    
    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(SCW - 12 - 85, 10, 85, 28);
    [selectBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [selectBtn setTitle:@"选择库存" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [informationView addSubview:selectBtn];
    selectBtn.layer.cornerRadius = 14;
    _selectBtn = selectBtn;
    [selectBtn addTarget:self action:@selector(addSelectStockAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tableview.tableHeaderView = headerView;
}




- (void)choiceChangeTimeAction:(UIButton *)timeBtn{
    NSDate * date = [self nsstringConversionNSDate:_timeShowLabel.text];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString * date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        if ([self TimeWithArrayCompare:date1 andArray:self.headerArray]) {
            //结束时间
            _timeShowLabel.text = date1;
        }else{
            
            
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"确定是否修改时间选择" message:@"该操作会清空所有选择的库存，是否确定?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert];
            
            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 //这边要做的是对数组进行删除
                                [self.headerArray removeAllObjects];
                                if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                                    [self.abnormalArray removeAllObjects];
                                    [self setCustomTableviewFootView];
                                }
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
//                [self.headerArray removeAllObjects];
//                if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
//                    [self.abnormalArray removeAllObjects];
//                    [self setCustomTableviewFootView];
//                }
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
    [sureBtn setTitle:@"确认入库" forState:UIControlStateNormal];
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
    [cancelBtn setTitle:@"取消入库" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [cancelBtn addTarget:self action:@selector(cancelTwoOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    cancelBtn.hidden = YES;
}



- (void)setUIBottomView{
    UIButton * newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [newBtn setTitle:@"保存" forState:UIControlStateNormal];
    [newBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [newBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    newBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [newBtn addTarget:self action:@selector(saveExceptionHandlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newBtn];
    _newBtn = newBtn;
}




//FIXME:新保存
- (void)saveExceptionHandlAction:(UIButton *)newBtn{
   // self.btnType = @"save";
    if (self.headerArray.count > 0) {
        if ([self testingDataComplete]) {
            self.btnType = @"save";
            //[self newSaveBillNewData];
            [self blockExceptionSaveNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"没有数据"];
    }
}


//FIXME:取消入库
- (void)cancelTwoOutAction:(UIButton *)cancelBtn{
    self.btnType = @"save";
    [self blockExceptionCancelNewDataNewData];
}

//FIXME:修改保存
- (void)saveOutAction:(UIButton *)saveBtn{
//     self.btnType = @"save";
    if (self.headerArray.count > 0) {
        if ([self testingDataComplete]) {
            self.btnType = @"save";
            [self blockExceptionmodifyAndSaveNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
        //[self modifyAndSaveNewData];
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}

//FIXME:取消编辑
- (void)cancelOutAction:(UIButton *)cancelEditBtn{
     self.btnType = @"save";
    _selectBtn.hidden = YES;
    _newBtn.hidden = YES;
    _timeBtn.hidden = YES;
    _editSureView.hidden = NO;
    _deleteBtn.hidden = NO;
    _editBtn.hidden = NO;
    _sureBtn.hidden = NO;
    _allView.hidden = YES;
    _cancelEditBtn.hidden = YES;
    _saveBtn.hidden = YES;
    _cancelBtn.hidden = YES;
    [self blockExceptionreloadNewData];
}


//FIXME:确定入库
- (void)sureOutAction:(UIButton *)sureBtn{
    self.btnType = @"save";
    [self blockExceptionSureNewData];
}


//FIXME:编辑
- (void)editOutAction:(UIButton *)editBtn{
    self.btnType = @"edit";
    _selectBtn.hidden = NO;
    _timeBtn.hidden = NO;
    _newBtn.hidden = YES;
    _editSureView.hidden = YES;
    _deleteBtn.hidden = YES;
    _editBtn.hidden = YES;
    _sureBtn.hidden = YES;
    _allView.hidden = NO;
    _cancelEditBtn.hidden = NO;
    _saveBtn.hidden = NO;
    _cancelBtn.hidden = YES;
    [self.tableview reloadData];
    
    [self setCustomTableviewFootView];
    
}


//FIXME:删除
- (void)deleteOutAction:(UIButton *)deleteBtn{
//    self.btnType = @"save";
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.btnType = @"save";
        [self blockExceptionDeleteNewData];
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


//FIXME:新保存
- (void)blockExceptionSaveNewData{
    NSInteger totalNumber = 0;
    NSDecimalNumber * totalVolume;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.headerArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.headerArray[i];
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
    NSString * str = [NSString string];
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        str = @"dlcl";
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        str = @"ccbg";
    }else{
        str = @"wlbg";
    }
    //,@"totalQty":@(totalNumber)
    
    NSDictionary * billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"blockNos":@"",@"status":@"",@"abType":str ,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber)};
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
   
    for (int i = 0; i < self.headerArray.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        RSStoragemanagementModel * storagemanagementmodel = self.headerArray[i];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
        [dict setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
         [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.whsId] forKey:@"whsId"];
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
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlInId] forKey:@"mtlInId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
        [dict setObject:storagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
        [dict setObject:storagemanagementmodel.mtlInName forKey:@"mtlInName"];
        
        [dict setObject:storagemanagementmodel.lengthIn forKey:@"lengthIn"];
        [dict setObject:storagemanagementmodel.widthIn forKey:@"widthIn"];
        [dict setObject:storagemanagementmodel.heightIn forKey:@"heightIn"];
        [dict setObject:storagemanagementmodel.volumeIn forKey:@"volumeIn"];
        [dict setObject:storagemanagementmodel.weightIn forKey:@"weightIn"];
//        }
         [array addObject:dict];
    }
    NSMutableArray * twoarray = [NSMutableArray array];
      for (int j = 0 ; j < self.abnormalArray.count ; j++) {
          NSMutableDictionary * dict1 = [NSMutableDictionary dictionary];
          RSStoragemanagementModel * storagemanagementmodel = self.abnormalArray[j];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
          [dict1 setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlInId] forKey:@"mtlId"];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.whsId] forKey:@"whsId"];
          [dict1 setObject:storagemanagementmodel.mtlInName forKey:@"mtlName"];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeInId] forKey:@"mtltypeId"];
          [dict1 setObject:storagemanagementmodel.mtltypeInName forKey:@"mtltypeName"];
    
          [dict1 setObject:storagemanagementmodel.storageType forKey:@"storageType"];
          [dict1 setObject:@"" forKey:@"storeareaName"];
          [dict1 setObject:storagemanagementmodel.blockInNo forKey:@"blockNo"];
          [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.qty] forKey:@"qty"];
          [dict1 setObject:storagemanagementmodel.lengthIn forKey:@"length"];
          [dict1 setObject:storagemanagementmodel.widthIn forKey:@"width"];
          [dict1 setObject:storagemanagementmodel.heightIn forKey:@"height"];
          [dict1 setObject:storagemanagementmodel.volumeIn forKey:@"volume"];
          [dict1 setObject:storagemanagementmodel.weightIn forKey:@"weight"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
//      [dict1 setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.whsId] forKey:@"whsId"];
//      [dict1 setObject:storagemanagementmodel.mtlName forKey:@"mtlName"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
//      [dict1 setObject:storagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
//      [dict1 setObject:storagemanagementmodel.storageType forKey:@"storageType"];
//      [dict1 setObject:@"" forKey:@"storeareaName"];
//      [dict1 setObject:storagemanagementmodel.blockNo forKey:@"blockNo"];
//      [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.qty] forKey:@"qty"];
//      [dict1 setObject:storagemanagementmodel.length forKey:@"length"];
//      [dict1 setObject:storagemanagementmodel.width forKey:@"width"];
//      [dict1 setObject:storagemanagementmodel.height forKey:@"height"];
//      [dict1 setObject:storagemanagementmodel.volume forKey:@"volume"];
//      [dict1 setObject:storagemanagementmodel.weight forKey:@"weight"];
      [twoarray addObject:dict1];
    }
    [phoneDict setObject:array forKey:@"billDtl"];
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
                [weakSelf.headerArray removeAllObjects];
                [weakSelf.abnormalArray removeAllObjects];
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.abType = json[@"data"][@"billHead"][@"abType"];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
                
                //weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                //weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                //weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _newBtn.hidden = YES;
                _saveBtn.hidden = YES;
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
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                    storagemanagementmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    storagemanagementmodel.weightIn = [[array objectAtIndex:i]objectForKey:@"weightIn"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.volumeIn = [[array objectAtIndex:i]objectForKey:@"volumeIn"];
                    
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"]integerValue];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                    
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"]integerValue];
                    
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                    storagemanagementmodel.blockInNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    
                    
                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                      storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                     storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"] integerValue];
                     storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                     storagemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    [weakSelf.headerArray addObject:storagemanagementmodel];
                }
                
                NSMutableArray * array2 = [NSMutableArray array];
                array2 = json[@"data"][@"billDtl2"];
                for (int j = 0; j < array2.count; j++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billid = [[[array2 objectAtIndex:j]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.billdtlid = [[[array2 objectAtIndex:j]objectForKey:@"billdtlid"] integerValue];
                    storagemanagementmodel.blockNo = [[array2 objectAtIndex:j]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array2 objectAtIndex:j]objectForKey:@"did"] integerValue];
                    storagemanagementmodel.height = [[array2 objectAtIndex:j]objectForKey:@"height"];
                    storagemanagementmodel.heightIn = [[array2 objectAtIndex:j]objectForKey:@"height"];
                    storagemanagementmodel.length = [[array2 objectAtIndex:j]objectForKey:@"length"];
                    storagemanagementmodel.lengthIn = [[array2 objectAtIndex:j]objectForKey:@"length"];
                    storagemanagementmodel.weight = [[array2 objectAtIndex:j]objectForKey:@"weight"];
                    storagemanagementmodel.weightIn = [[array2 objectAtIndex:j]objectForKey:@"weight"];
                    storagemanagementmodel.width = [[array2 objectAtIndex:j]objectForKey:@"width"];
                    storagemanagementmodel.widthIn = [[array2 objectAtIndex:j]objectForKey:@"width"];
                    storagemanagementmodel.volume = [[array2 objectAtIndex:j]objectForKey:@"volume"];
                    storagemanagementmodel.volumeIn = [[array2 objectAtIndex:j]objectForKey:@"volume"];
                    storagemanagementmodel.mtlId = [[[array2 objectAtIndex:j]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlInId = [[[array2 objectAtIndex:j]objectForKey:@"mtlInId"]integerValue];
                    storagemanagementmodel.mtlName = [[array2 objectAtIndex:j]objectForKey:@"mtlName"];
                     storagemanagementmodel.mtlInName = [[array2 objectAtIndex:j]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeId = [[[array2 objectAtIndex:j]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeInId = [[[array2 objectAtIndex:j]objectForKey:@"mtltypeInId"]integerValue];
                    storagemanagementmodel.mtltypeName = [[array2 objectAtIndex:j]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeInName = [[array2 objectAtIndex:j]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.blockInNo = [[array2 objectAtIndex:j]objectForKey:@"blockNo"];
                    storagemanagementmodel.qty = [[[array2 objectAtIndex:j]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.receiptDate = [[array2 objectAtIndex:j]objectForKey:@"receiptDate"];
                    storagemanagementmodel.storageType = [[array2 objectAtIndex:j]objectForKey:@"storageType"];
                    storagemanagementmodel.storeareaId = [[[array2 objectAtIndex:j]objectForKey:@"storeareaId"] integerValue];
                    storagemanagementmodel.storeareaName = [[array2 objectAtIndex:j]objectForKey:@"storeareaName"];
                    storagemanagementmodel.whsId = [[[array2 objectAtIndex:j]objectForKey:@"whsId"] integerValue];
                    [weakSelf.abnormalArray addObject:storagemanagementmodel];
                }
                if (self.reload) {
                    self.reload(true);
                }
                [weakSelf.tableview reloadData];
                [weakSelf setCustomTableviewFootView];
            }else{
                _selectBtn.hidden = NO;
                _timeBtn.hidden = NO;
                _newBtn.hidden = NO;
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
            _selectBtn.hidden = NO;
            _timeBtn.hidden = NO;
            _newBtn.hidden = NO;
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


//FIXME:加载网络的请求
- (void)blockExceptionreloadNewData{
    
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
                [weakSelf.headerArray removeAllObjects];
                [weakSelf.abnormalArray removeAllObjects];
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.abType = json[@"data"][@"billHead"][@"abType"];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
                
                //weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                    storagemanagementmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    storagemanagementmodel.weightIn = [[array objectAtIndex:i]objectForKey:@"weightIn"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.volumeIn = [[array objectAtIndex:i]objectForKey:@"volumeIn"];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"]integerValue];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                     storagemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"]integerValue];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                    storagemanagementmodel.blockInNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"] integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    [weakSelf.headerArray addObject:storagemanagementmodel];
                }
                
                NSMutableArray * array2 = [NSMutableArray array];
                array2 = json[@"data"][@"billDtl2"];
                for (int j = 0; j < array2.count; j++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billid = [[[array2 objectAtIndex:j]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.billdtlid = [[[array2 objectAtIndex:j]objectForKey:@"billdtlid"] integerValue];
                    storagemanagementmodel.blockNo = [[array2 objectAtIndex:j]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array2 objectAtIndex:j]objectForKey:@"did"] integerValue];
                    storagemanagementmodel.height = [[array2 objectAtIndex:j]objectForKey:@"height"];
                    storagemanagementmodel.heightIn = [[array2 objectAtIndex:j]objectForKey:@"height"];
                    storagemanagementmodel.length = [[array2 objectAtIndex:j]objectForKey:@"length"];
                    storagemanagementmodel.lengthIn = [[array2 objectAtIndex:j]objectForKey:@"length"];
                    storagemanagementmodel.weight = [[array2 objectAtIndex:j]objectForKey:@"weight"];
                    storagemanagementmodel.weightIn = [[array2 objectAtIndex:j]objectForKey:@"weight"];
                    storagemanagementmodel.width = [[array2 objectAtIndex:j]objectForKey:@"width"];
                    storagemanagementmodel.widthIn = [[array2 objectAtIndex:j]objectForKey:@"width"];
                    storagemanagementmodel.volume = [[array2 objectAtIndex:j]objectForKey:@"volume"];
                    storagemanagementmodel.volumeIn = [[array2 objectAtIndex:j]objectForKey:@"volume"];
                    storagemanagementmodel.mtlId = [[[array2 objectAtIndex:j]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlInId = [[[array2 objectAtIndex:j]objectForKey:@"mtlInId"]integerValue];
                    
                    storagemanagementmodel.mtlName = [[array2 objectAtIndex:j]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlInName = [[array2 objectAtIndex:j]objectForKey:@"mtlName"];
                    
                    storagemanagementmodel.mtltypeId = [[[array2 objectAtIndex:j]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeInId = [[[array2 objectAtIndex:j]objectForKey:@"mtltypeInId"]integerValue];
                    
                    storagemanagementmodel.mtltypeName = [[array2 objectAtIndex:j]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeInName = [[array2 objectAtIndex:j]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.blockInNo = [[array2 objectAtIndex:j]objectForKey:@"blockNo"];
      
                    storagemanagementmodel.qty = [[[array2 objectAtIndex:j]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.receiptDate = [[array2 objectAtIndex:j]objectForKey:@"receiptDate"];
                    storagemanagementmodel.storageType = [[array2 objectAtIndex:j]objectForKey:@"storageType"];
                    storagemanagementmodel.storeareaId = [[[array2 objectAtIndex:j]objectForKey:@"storeareaId"] integerValue];
                    storagemanagementmodel.storeareaName = [[array2 objectAtIndex:j]objectForKey:@"storeareaName"];
                    storagemanagementmodel.whsId = [[[array2 objectAtIndex:j]objectForKey:@"whsId"] integerValue];
                    [weakSelf.abnormalArray addObject:storagemanagementmodel];
                }
                [weakSelf setCustomTableviewFootView];
                [weakSelf.tableview reloadData];
            }else{
//                _selectBtn.hidden = YES;
//                _newBtn.hidden = YES;
//                _editSureView.hidden = YES;
//                _deleteBtn.hidden = NO;
//                _editBtn.hidden = NO;
//                _sureBtn.hidden = NO;
//                _allView.hidden = YES;
//                _cancelEditBtn.hidden = YES;
//                _saveBtn.hidden = YES;
//                _cancelBtn.hidden = YES;
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
//            _selectBtn.hidden = YES;
//            _newBtn.hidden = YES;
//            _editSureView.hidden = YES;
//            _deleteBtn.hidden = NO;
//            _editBtn.hidden = NO;
//            _sureBtn.hidden = NO;
//            _allView.hidden = YES;
//            _cancelEditBtn.hidden = YES;
//            _saveBtn.hidden = YES;
//            _cancelBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}





//FIXME:删除网络请求
- (void)blockExceptionDeleteNewData{
    
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
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _newBtn.hidden = YES;
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
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _newBtn.hidden = YES;
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
            _selectBtn.hidden = YES;
            _timeBtn.hidden = YES;
             _newBtn.hidden = YES;
            _editSureView.hidden = YES;
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


//FIXME:确认入库网络请求
- (void)blockExceptionSureNewData{
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
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _newBtn.hidden = YES;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = NO;
                [weakSelf.tableview reloadData];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"确认入库成功"];
               // [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _newBtn.hidden = YES;
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
            _selectBtn.hidden = YES;
            _timeBtn.hidden = YES;
             _newBtn.hidden = YES;
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




//FIXME:取消入库网络请求
- (void)blockExceptionCancelNewDataNewData{
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
                
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _newBtn.hidden = YES;
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                
                [weakSelf.tableview reloadData];
                
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
               // [weakSelf.navigationController popViewControllerAnimated:YES];
                   [SVProgressHUD showSuccessWithStatus:@"取消入库成功"];
            }else{
                 _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                 _newBtn.hidden = YES;
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
            _selectBtn.hidden = YES;
            _timeBtn.hidden = YES;
             _newBtn.hidden = YES;
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

//FIXME:修改保存网络请求
//修改保存网路请求
- (void)blockExceptionmodifyAndSaveNewData{

    NSInteger totalNumber = 0;
    NSDecimalNumber * totalVolume;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.headerArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.headerArray[i];
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
    
    NSDictionary * billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"abType":self.billheadmodel.abType ,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber)};
    
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.headerArray.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        RSStoragemanagementModel * storagemanagementmodel = self.headerArray[i];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
        [dict setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
       
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.whsId] forKey:@"whsId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
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
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlInId] forKey:@"mtlInId"];
        [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
        [dict setObject:storagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
        [dict setObject:storagemanagementmodel.mtlInName forKey:@"mtlInName"];
        [dict setObject:storagemanagementmodel.lengthIn forKey:@"lengthIn"];
        [dict setObject:storagemanagementmodel.widthIn forKey:@"widthIn"];
        [dict setObject:storagemanagementmodel.heightIn forKey:@"heightIn"];
        [dict setObject:storagemanagementmodel.volumeIn forKey:@"volumeIn"];
        [dict setObject:storagemanagementmodel.weightIn forKey:@"weightIn"];
        
        [array addObject:dict];
    }
    NSMutableArray * twoarray = [NSMutableArray array];
    for (int j = 0 ; j < self.abnormalArray.count ; j++) {
        NSMutableDictionary * dict1 = [NSMutableDictionary dictionary];
        RSStoragemanagementModel * storagemanagementmodel = self.abnormalArray[j];
        
        /**
         单据ID    billid    Int    关联表头
         明细ID    billdtlid    Int
         库存标识    did    Int    和复制的明细1的DID相同
         入库日期    receiptDate    Sting    yyyy-MM-dd
         物料ID    mtlId    Int
         仓库ID    whsId    Int
         库区ID    storeareaId    Int     -1
         物料名称    mtlName    String
         物料类别ID    mtltypeId    Int
         物料类别名称    mtltypeName    String
         入库类型    storageType    Sting    见  入库类型枚举类
         库区名称    storeareaName    String
         荒料编号    blockNo    String
         数量    qty    Int    默认1
         长    length    Decimal    1 位
         宽    width    Decimal    1 位
         厚    height    Decimal    2 位
         立方数    volume    Decimal    3位
         吨数    weight    Decimal    3位
         */
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.did] forKey:@"did"];
        [dict1 setObject:[NSString stringWithFormat:@"%@",storagemanagementmodel.receiptDate] forKey:@"receiptDate"];
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlInId] forKey:@"mtlId"];
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.whsId] forKey:@"whsId"];
        [dict1 setObject:storagemanagementmodel.mtlInName forKey:@"mtlName"];
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeInId] forKey:@"mtltypeId"];
        [dict1 setObject:storagemanagementmodel.mtltypeInName forKey:@"mtltypeName"];
        [dict1 setObject:storagemanagementmodel.storageType forKey:@"storageType"];
        [dict1 setObject:@"" forKey:@"storeareaName"];
        [dict1 setObject:storagemanagementmodel.blockNo forKey:@"blockNo"];
        [dict1 setObject:[NSNumber numberWithInteger:storagemanagementmodel.qty] forKey:@"qty"];
        [dict1 setObject:storagemanagementmodel.lengthIn forKey:@"length"];
        [dict1 setObject:storagemanagementmodel.widthIn forKey:@"width"];
        [dict1 setObject:storagemanagementmodel.heightIn forKey:@"height"];
        [dict1 setObject:storagemanagementmodel.volumeIn forKey:@"volume"];
        [dict1 setObject:storagemanagementmodel.weightIn forKey:@"weight"];
        [twoarray addObject:dict1];
    }
    [phoneDict setObject:array forKey:@"billDtl"];
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
                [weakSelf.headerArray removeAllObjects];
                [weakSelf.abnormalArray removeAllObjects];
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.abType = json[@"data"][@"billHead"][@"abType"];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
                //weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _newBtn.hidden = YES;
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
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                    storagemanagementmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    storagemanagementmodel.weightIn = [[array objectAtIndex:i]objectForKey:@"weightIn"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.volumeIn = [[array objectAtIndex:i]objectForKey:@"volumeIn"];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"]integerValue];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                     storagemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"]integerValue];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                   storagemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                    storagemanagementmodel.blockInNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"] integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    [weakSelf.headerArray addObject:storagemanagementmodel];
                }
                NSMutableArray * array2 = [NSMutableArray array];
                array2 = json[@"data"][@"billDtl2"];
                for (int j = 0; j < array2.count; j++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billid = [[[array2 objectAtIndex:j]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.billdtlid = [[[array2 objectAtIndex:j]objectForKey:@"billdtlid"] integerValue];
                    storagemanagementmodel.blockNo = [[array2 objectAtIndex:j]objectForKey:@"blockNo"];
                    storagemanagementmodel.did = [[[array2 objectAtIndex:j]objectForKey:@"did"] integerValue];
                    storagemanagementmodel.height = [[array2 objectAtIndex:j]objectForKey:@"height"];
                    storagemanagementmodel.heightIn = [[array2 objectAtIndex:j]objectForKey:@"height"];
                    storagemanagementmodel.length = [[array2 objectAtIndex:j]objectForKey:@"length"];
                    storagemanagementmodel.lengthIn = [[array2 objectAtIndex:j]objectForKey:@"length"];
                    storagemanagementmodel.weight = [[array2 objectAtIndex:j]objectForKey:@"weight"];
                    storagemanagementmodel.weightIn = [[array2 objectAtIndex:j]objectForKey:@"weight"];
                    storagemanagementmodel.width = [[array2 objectAtIndex:j]objectForKey:@"width"];
                    storagemanagementmodel.widthIn = [[array2 objectAtIndex:j]objectForKey:@"width"];
                    storagemanagementmodel.volume = [[array2 objectAtIndex:j]objectForKey:@"volume"];
                    storagemanagementmodel.volumeIn = [[array2 objectAtIndex:j]objectForKey:@"volume"];
                    storagemanagementmodel.mtlId = [[[array2 objectAtIndex:j]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlInId = [[[array2 objectAtIndex:j]objectForKey:@"mtlInId"]integerValue];
                    storagemanagementmodel.mtlName = [[array2 objectAtIndex:j]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlInName = [[array2 objectAtIndex:j]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeId = [[[array2 objectAtIndex:j]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeInId = [[[array2 objectAtIndex:j]objectForKey:@"mtltypeInId"]integerValue];
                    storagemanagementmodel.mtltypeName = [[array2 objectAtIndex:j]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeInName = [[array2 objectAtIndex:j]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.blockInNo = [[array2 objectAtIndex:j]objectForKey:@"blockNo"];
                    storagemanagementmodel.qty = [[[array2 objectAtIndex:j]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.receiptDate = [[array2 objectAtIndex:j]objectForKey:@"receiptDate"];
                    storagemanagementmodel.storageType = [[array2 objectAtIndex:j]objectForKey:@"storageType"];
                    storagemanagementmodel.storeareaId = [[[array2 objectAtIndex:j]objectForKey:@"storeareaId"] integerValue];
                    storagemanagementmodel.storeareaName = [[array2 objectAtIndex:j]objectForKey:@"storeareaName"];
                    storagemanagementmodel.whsId = [[[array2 objectAtIndex:j]objectForKey:@"whsId"] integerValue];
                    [weakSelf.abnormalArray addObject:storagemanagementmodel];
                }
                if (self.reload) {
                    self.reload(true);
                }
                [weakSelf setCustomTableviewFootView];
                [weakSelf.tableview reloadData];
            }else{
                _selectBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _newBtn.hidden = YES;
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
            _selectBtn.hidden = YES;
            _timeBtn.hidden = YES;
            _newBtn.hidden = YES;
            _saveBtn.hidden = YES;
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

//荒料异常处理，断裂+1的数组 -- 编辑
- (void)exceptionFootViewEidtAcion:(UIButton *)productEidtBtn{
    RSStoragemanagementModel * storagemanagementmodel = self.abnormalArray[productEidtBtn.tag - 100000];
    //这边是编辑的代码 -- 要跳到另一个界面
    RSAlterationOfWasteMaterialViewController * alterationOfWasteVc = [[RSAlterationOfWasteMaterialViewController alloc]init];
    alterationOfWasteVc.storagemanagementmodel = storagemanagementmodel;
    alterationOfWasteVc.currentTitle = self.currentSelectBtn.currentTitle;
    alterationOfWasteVc.usermodel = self.usermodel;
    alterationOfWasteVc.index = productEidtBtn.tag - 100000;
    alterationOfWasteVc.delegate = self;
    alterationOfWasteVc.selectType = self.selectType;
    alterationOfWasteVc.selectFunctionType = self.selectFunctionType;
    [self.navigationController pushViewController:alterationOfWasteVc animated:YES];
}


//切换功能
- (void)changSelectFunction:(UIButton *)publishBtn{
    if ([self.showType isEqualToString:@"new"]) {
        if ([publishBtn.currentTitle isEqualToString:self.currentSelectBtn.currentTitle]) {
            
            
            
        }else{
            
            if (self.headerArray.count > 0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换功能会清除当前数据" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if ([publishBtn.currentTitle isEqualToString:@"断裂处理"] || [publishBtn.currentTitle isEqualToString:@"尺寸变更"] || [publishBtn.currentTitle isEqualToString:@"物料变更"]) {
                        [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
                        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                        [publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#A3B9FE"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
                    }
                    
                    if (!publishBtn.isSelected) {
                        
                        self.currentSelectBtn.selected = !self.currentSelectBtn.selected;
                        publishBtn.selected = !publishBtn.selected;
                        [ self.currentSelectBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
                        [ self.currentSelectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
                        [ self.currentSelectBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#E8EAEF"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
                        self.currentSelectBtn = publishBtn;
                    }
                    
                    _selectBtn.hidden = NO;
                    _timeBtn.hidden = NO;
                    _newBtn.hidden = NO;
                    _editSureView.hidden = YES;
                    _deleteBtn.hidden = YES;
                    _editBtn.hidden = YES;
                    _sureBtn.hidden = YES;
                    _allView.hidden = YES;
                    _cancelEditBtn.hidden = YES;
                    _saveBtn.hidden = YES;
                    _cancelBtn.hidden = YES;
                    [self.headerArray removeAllObjects];
                    [self.abnormalArray removeAllObjects];
                    [self.tableview reloadData];
                    [self setCustomTableviewFootView];
                    
                }];
                [alert addAction:actionConfirm];
                UIAlertAction * cancelaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancelaction];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alert.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alert animated:YES completion:nil];
                
            }else{
                [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
                [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                [publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#A3B9FE"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
                
                
                if (!publishBtn.isSelected) {
                    self.currentSelectBtn.selected = !self.currentSelectBtn.selected;
                    publishBtn.selected = !publishBtn.selected;
                    [ self.currentSelectBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
                    [ self.currentSelectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
                    [ self.currentSelectBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#E8EAEF"] shadowOpacity:1.0 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:1];
                    self.currentSelectBtn = publishBtn;
                }
                _selectBtn.hidden = NO;
                _timeBtn.hidden = NO;
                _newBtn.hidden = NO;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                [self.headerArray removeAllObjects];
                [self.abnormalArray removeAllObjects];
                [self.tableview reloadData];
                [self setCustomTableviewFootView];
            }
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"不允许切换"];
    }
}



//判断完整性
- (BOOL)testingDataComplete{
    //荒料里面需要原始 平方数/立方数dedVaqty没有匝号和板号，原始 平方数/立方数也不需要 preVaqty,大板有匝号和板号原始 平方数/立方数需要 preVaqty但是不要// 原始 平方数/立方数dedVaqty
    
    //|| [storagemanagementmodel.weight doubleValue] <= 0.000;
    for (int i = 0; i < self.headerArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.headerArray[i];
        if ([storagemanagementmodel.mtlName isEqualToString:@""] || [storagemanagementmodel.mtltypeName isEqualToString:@""] || [storagemanagementmodel.blockNo isEqualToString:@""] || [storagemanagementmodel.length doubleValue] <= 0.000 ||  [storagemanagementmodel.width doubleValue]<= 0.000 || [storagemanagementmodel.height doubleValue]<= 0.000 || storagemanagementmodel.qty < 1  || [storagemanagementmodel.volume doubleValue]<= 0.000 || [storagemanagementmodel.mtlInName isEqualToString:@""] || [storagemanagementmodel.mtltypeInName isEqualToString:@""] || [storagemanagementmodel.blockInNo isEqualToString:@""] || [storagemanagementmodel.lengthIn doubleValue] <= 0.000 ||  [storagemanagementmodel.widthIn doubleValue]<= 0.000 || [storagemanagementmodel.heightIn doubleValue]<= 0.000 || [storagemanagementmodel.volumeIn doubleValue]<= 0.000) {
            return NO;
        }
    }
    return YES;
}




//- (void)selectContentArray:(NSMutableArray *)selectArray{
//    if (self.headerArray.count < 1) {
//        [self.headerArray addObjectsFromArray:selectArray];
//    }else{
//
//    }
//    [self.tableview reloadData];
//}



- (void)selectContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{
    if (self.headerArray.count < 1) {
         [self.headerArray addObjectsFromArray:selectArray];
    }else{
        //这边要判断下
        [self.headerArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RSStoragemanagementModel * storagemanagementmodel = obj;
            [cancelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSInteger did = [obj integerValue];
                if ([@(storagemanagementmodel.did) isEqual:@(did)]) {
                    [self.headerArray removeObjectAtIndex:idx];
                }
            }];
        }];
        
        NSMutableArray * array = [NSMutableArray array];
        //找到arr1中有,arr2中没有的数据
        [selectArray enumerateObjectsUsingBlock:^(RSStoragemanagementModel * storagemanagementmodel, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isHave = NO;
            [self.headerArray enumerateObjectsUsingBlock:^(RSStoragemanagementModel * storagemanagementmodel1, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([@(storagemanagementmodel.did) isEqual:@(storagemanagementmodel1.did)]) {
                    isHave = YES;
                    *stop = YES;
                }
            }];
            if (!isHave) {
                [array addObject:storagemanagementmodel];
            }
        }];
        [self.headerArray addObjectsFromArray:array];
    }
    [self.tableview reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        return 1;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        return 230;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
     RSStoragemanagementModel * storagemanagementmodel = self.headerArray[indexPath.row];
     if ([storagemanagementmodel.length isEqual:storagemanagementmodel.lengthIn] && [storagemanagementmodel.width isEqual:storagemanagementmodel.widthIn] && [storagemanagementmodel.height isEqual:storagemanagementmodel.heightIn] && [storagemanagementmodel.volume isEqual:storagemanagementmodel.volumeIn] && [storagemanagementmodel.weight isEqual:storagemanagementmodel.weight]){
            return 209;
        }else{
            return 217;
        }
    }else{
        RSStoragemanagementModel * storagemanagementmodel = self.headerArray[indexPath.row];
        if ([storagemanagementmodel.mtlName isEqualToString:storagemanagementmodel.mtlInName]) {
             return 209;
        }else{
             return 220;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        return 0;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
       return 0;
    }else{
        return 0;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
       return nil;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        return nil;
    }else{
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        return self.headerArray.count;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        return self.headerArray.count;
    }else{
        return self.headerArray.count;
    }
}


//选择库存
- (void)addSelectStockAction:(UIButton *)selectBtn{
    if (self.headerArray.count < 1) {
        RSSelectiveInventoryViewController * selectiveInventoryVc = [[RSSelectiveInventoryViewController alloc]init];
        selectiveInventoryVc.selectType = self.selectType;
        selectiveInventoryVc.selectFunctionType = self.selectFunctionType;
        selectiveInventoryVc.currentTitle = self.currentSelectBtn.currentTitle;
        selectiveInventoryVc.usermodel = self.usermodel;
        selectiveInventoryVc.delegate = self;
        selectiveInventoryVc.dateTo = _timeShowLabel.text;
        [self.navigationController pushViewController:selectiveInventoryVc animated:YES];
    }else{
        if ([self testingDataComplete]) {
            RSSelectiveInventoryViewController * selectiveInvenroryVc = [[RSSelectiveInventoryViewController alloc]init];
            selectiveInvenroryVc.selectType = self.selectType;
            selectiveInvenroryVc.delegate = self;
            selectiveInvenroryVc.dateTo = _timeShowLabel.text;
            selectiveInvenroryVc.selectFunctionType = self.selectFunctionType;
            if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
               // selectiveInvenroryVc.selectionArray = self.headerArray;
                NSMutableArray * array = [NSMutableArray array];
                for (int i = 0; i < self.self.headerArray.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = self.self.headerArray[i];
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
}

//FIXME:断裂+1的删除方法
- (void)productDeleteInventoryAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RSStoragemanagementModel * storagemanagementmodel = self.headerArray[productDeleteBtn.tag];
        [self.headerArray removeObjectAtIndex:productDeleteBtn.tag];
        for (int i = 0; i < self.abnormalArray.count; i++) {
            RSStoragemanagementModel * storagemanagementmodel1 = self.abnormalArray[i];
            if (storagemanagementmodel.did == storagemanagementmodel1.did) {
                [self.abnormalArray removeObjectAtIndex:i];
                i--;
            }
        }
        [self setCustomTableviewFootView];
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

//FIXME:断裂+1添加的方法
- (void)handAction:(UIButton *)handBtn{
    RSStoragemanagementModel * storagemanagementmodel = self.headerArray[handBtn.tag];
    RSStoragemanagementModel * storagemanagementmodel1 = [[RSStoragemanagementModel alloc]init];
    storagemanagementmodel1.billid = storagemanagementmodel.billid;
    storagemanagementmodel1.billdtlid = 0;
    storagemanagementmodel1.blockNo  = storagemanagementmodel.blockNo ;
    storagemanagementmodel1.did = storagemanagementmodel.did;
    storagemanagementmodel1.height = storagemanagementmodel.height;
    storagemanagementmodel1.heightIn = storagemanagementmodel.heightIn;
    storagemanagementmodel1.length  = storagemanagementmodel.length;
    storagemanagementmodel1.lengthIn = storagemanagementmodel.lengthIn;
    storagemanagementmodel1.weight = storagemanagementmodel.weight;
    storagemanagementmodel1.weightIn = storagemanagementmodel.weightIn;
    storagemanagementmodel1.width = storagemanagementmodel.width;
    storagemanagementmodel1.widthIn = storagemanagementmodel.widthIn;
    storagemanagementmodel1.volume = storagemanagementmodel.volume;
    storagemanagementmodel1.volumeIn = storagemanagementmodel.volumeIn;
    storagemanagementmodel1.mtlId = storagemanagementmodel.mtlId;
    storagemanagementmodel1.mtlInId = storagemanagementmodel.mtlInId;
    storagemanagementmodel1.mtlName = storagemanagementmodel.mtlName;
    storagemanagementmodel1.mtlInName = storagemanagementmodel.mtlInName;
    storagemanagementmodel1.mtltypeId = storagemanagementmodel.mtltypeId;
    storagemanagementmodel1.mtltypeInId = storagemanagementmodel.mtltypeInId;
    storagemanagementmodel1.mtltypeName = storagemanagementmodel.mtltypeName;
    storagemanagementmodel1.mtltypeInName = storagemanagementmodel.mtltypeInName;
    storagemanagementmodel1.blockInNo = storagemanagementmodel.blockInNo;
    storagemanagementmodel1.qty = storagemanagementmodel.qty;
    storagemanagementmodel1.receiptDate = storagemanagementmodel.receiptDate;
    storagemanagementmodel1.storageType = storagemanagementmodel.storageType;
    storagemanagementmodel1.storeareaId = storagemanagementmodel.storeareaId;
    storagemanagementmodel1.storeareaName = storagemanagementmodel.storeareaName;
    storagemanagementmodel1.whsId  = storagemanagementmodel.whsId ;
    [self.abnormalArray addObject:storagemanagementmodel1];
    [self.abnormalArray sortUsingComparator:^NSComparisonResult( RSStoragemanagementModel * storagemanagementmodel, RSStoragemanagementModel * storagemanagementmodel1) {
        return [@(storagemanagementmodel.did) compare:@(storagemanagementmodel1.did)];
    }];
    [self setCustomTableviewFootView];
}

//荒料异常处理，断裂+1的数组 -- 删除
- (void)exceptionFootViewDeleteAcion:(UIButton *)productDeleteBtn{
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.abnormalArray removeObjectAtIndex:productDeleteBtn.tag - 100000];
        //这边要不要删除选中的模型
        [self setCustomTableviewFootView];
        
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




- (void)passValueIndexpath:(NSInteger)index andRSStoragemanagementModel:(RSStoragemanagementModel *)storagemanagementmodel andCurrentTitle:(NSString *)currentTitle{
    if ([currentTitle isEqualToString:@"断裂处理"]) {
        [self.abnormalArray replaceObjectAtIndex:index withObject:storagemanagementmodel];
        [self.tableview reloadData];
        [self setCustomTableviewFootView];
    }else if ([currentTitle isEqualToString:@"尺寸变更"]){
        //这边要判断是什么不一样
        [self.headerArray replaceObjectAtIndex:index withObject:storagemanagementmodel];
        [self.tableview reloadData];
    }else{
        //这边要判断物料名称不一样
        [self.headerArray replaceObjectAtIndex:index withObject:storagemanagementmodel];
        [self.tableview reloadData];
    }
}

- (void)setCustomTableviewFootView{
    UIView * footView = [[UIView alloc]init];
    CGFloat H = 194;
    CGFloat W = SCW;
    for (int i = 0 ; i < self.abnormalArray.count; i++) {
        RSExceptionFootView * exceptionfootview = [[RSExceptionFootView alloc]init];
        exceptionfootview.frame = CGRectMake(0, i * H, W, H);
        exceptionfootview.storagemanagementmodel = self.abnormalArray[i];
        
        [footView addSubview:exceptionfootview];
        if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
            exceptionfootview.productDeleteBtn.hidden = NO;
            exceptionfootview.productEidtBtn.hidden = NO;
        }else{
            exceptionfootview.productEidtBtn.hidden = YES;
            exceptionfootview.productDeleteBtn.hidden = YES;
        }
        exceptionfootview.productEidtBtn.tag = i + 100000;
        exceptionfootview.productDeleteBtn.tag = i + 100000;
        [exceptionfootview.productEidtBtn addTarget:self action:@selector(exceptionFootViewEidtAcion:) forControlEvents:UIControlEventTouchUpInside];
        [exceptionfootview.productDeleteBtn addTarget:self action:@selector(exceptionFootViewDeleteAcion:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    //[footView setupAutoHeightWithBottomView:exceptionfootview bottomMargin:0];
    footView.sd_layout
    .heightIs(self.abnormalArray.count * 194);
    [footView layoutIfNeeded];
    self.tableview.tableFooterView = footView;
}




//FIXME:尺寸变更的方法 物料变更的界面 -- 删除（没有变化）
- (void)productDeleteAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.headerArray removeObjectAtIndex:productDeleteBtn.tag];
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

//FIXME:尺寸变更，物料变更-- 编辑（没有变化）
- (void)productEidtAction:(UIButton *)productEditBtn{
    //编辑
    RSStoragemanagementModel * storagemanagementmodel = self.headerArray[productEditBtn.tag];
    RSAlterationOfWasteMaterialViewController * alterationOfWasteVc = [[RSAlterationOfWasteMaterialViewController alloc]init];
    alterationOfWasteVc.storagemanagementmodel = storagemanagementmodel;
    alterationOfWasteVc.currentTitle = self.currentSelectBtn.currentTitle;
    alterationOfWasteVc.usermodel = self.usermodel;
    alterationOfWasteVc.index = productEditBtn.tag;
    alterationOfWasteVc.delegate = self;
    alterationOfWasteVc.selectType = self.selectType;
    alterationOfWasteVc.selectFunctionType = self.selectFunctionType;
    [self.navigationController pushViewController:alterationOfWasteVc animated:YES];
}

//FIXME:尺寸变化 -- 删除(变化后的)
- (void)productDeleteChangeAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.headerArray removeObjectAtIndex:productDeleteBtn.tag];
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

//FIXME:尺寸变化 -- 编辑(变化)
- (void)productEidtChangeAction:(UIButton *)productEidtBtn{
    RSStoragemanagementModel * storagemanagementmodel = self.headerArray[productEidtBtn.tag];
    RSAlterationOfWasteMaterialViewController * alterationOfWasteVc = [[RSAlterationOfWasteMaterialViewController alloc]init];
    alterationOfWasteVc.storagemanagementmodel = storagemanagementmodel;
    alterationOfWasteVc.currentTitle = self.currentSelectBtn.currentTitle;
    alterationOfWasteVc.usermodel = self.usermodel;
    alterationOfWasteVc.index = productEidtBtn.tag;
    alterationOfWasteVc.delegate = self;
    alterationOfWasteVc.selectType = self.selectType;
    alterationOfWasteVc.selectFunctionType = self.selectFunctionType;
    [self.navigationController pushViewController:alterationOfWasteVc animated:YES];
}

//FIXME:物料变更的--删除（变化）
- (void)productDeleteNoChangeAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self.headerArray removeObjectAtIndex:productDeleteBtn.tag];
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

//FIXME:物料变更 -- 编辑（变化）
- (void)productEditNoChangeAction:(UIButton *)productEditBtn{
    RSStoragemanagementModel * storagemanagementmodel = self.headerArray[productEditBtn.tag];
    RSAlterationOfWasteMaterialViewController * alterationOfWasteVc = [[RSAlterationOfWasteMaterialViewController alloc]init];
    alterationOfWasteVc.storagemanagementmodel = storagemanagementmodel;
    alterationOfWasteVc.currentTitle = self.currentSelectBtn.currentTitle;
    alterationOfWasteVc.usermodel = self.usermodel;
    alterationOfWasteVc.index = productEditBtn.tag;
    alterationOfWasteVc.delegate = self;
    alterationOfWasteVc.selectType = self.selectType;
    alterationOfWasteVc.selectFunctionType = self.selectFunctionType;
    [self.navigationController pushViewController:alterationOfWasteVc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        static NSString * EXCEPTIONHANDLINGID = @"EXCEPTIONHANDLINGID";
       RSExceptionHanlingCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGID];
       if (!cell) {
          cell = [[RSExceptionHanlingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGID];
        }
        cell.storagemanagementmodel = self.headerArray[indexPath.row];
        cell.tag = indexPath.section;
        if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
            cell.productDeleteBtn.hidden = NO;
            cell.handBtn.hidden = NO;
        }else{
            cell.handBtn.hidden = YES;
            cell.productDeleteBtn.hidden = YES;
        }
        if (indexPath.row == self.headerArray.count - 1) {
            cell.handleLabel.hidden = NO;
        }else{
            cell.handleLabel.hidden = YES;
        }
        cell.productDeleteBtn.tag = indexPath.row;
        cell.handBtn.tag = indexPath.row;
        [cell.handBtn addTarget:self action:@selector(handAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.productDeleteBtn addTarget:self action:@selector(productDeleteInventoryAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        
      RSStoragemanagementModel * storagemanagementmodel = self.headerArray[indexPath.row];
      if ([storagemanagementmodel.length isEqual:storagemanagementmodel.lengthIn] && [storagemanagementmodel.width isEqual:storagemanagementmodel.widthIn] && [storagemanagementmodel.height isEqual:storagemanagementmodel.heightIn] && [storagemanagementmodel.volume isEqual:storagemanagementmodel.volumeIn] && [storagemanagementmodel.weight isEqual:storagemanagementmodel.weight]) {    
        static NSString * EXCEPTIONHANDLINGSECONDID = @"EXCEPTIONHANDLINGSECONDID";
        RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGSECONDID];
        if (!cell) {
            cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGSECONDID];
        }
           cell.storagemaanagementmodel = self.headerArray[indexPath.row];
          
          if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
              cell.productDeleteBtn.hidden = NO;
              cell.productEidtBtn.hidden = NO;
          }else{
              cell.productDeleteBtn.hidden = YES;
              cell.productEidtBtn.hidden = YES;
          }
           cell.productDeleteBtn.tag = indexPath.row;
           cell.productEidtBtn.tag = indexPath.row;
           [cell.productDeleteBtn addTarget:self action:@selector(productDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
           [cell.productEidtBtn addTarget:self action:@selector(productEidtAction:) forControlEvents:UIControlEventTouchUpInside];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          return cell;
          
          
        }else{
            
            static NSString * EXCEPTIONHANDLINGSECONDDETIALID = @"EXCEPTIONHANDLINGSECONDDETIALID";
            RSExceptionHanlingSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGSECONDDETIALID];
            if (!cell) {
                cell = [[RSExceptionHanlingSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGSECONDDETIALID];
            }
            cell.productEidtBtn.tag = indexPath.row;
            cell.productDeleteBtn.tag = indexPath.row;
            
            if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
                cell.productDeleteBtn.hidden = NO;
                cell.productEidtBtn.hidden = NO;
            }else{
                
                cell.productDeleteBtn.hidden = YES;
                cell.productEidtBtn.hidden = YES;
            }
            cell.storagemanagementmodel = self.headerArray[indexPath.row];
            [cell.productEidtBtn addTarget:self action:@selector(productEidtChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productDeleteBtn addTarget:self action:@selector(productDeleteChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
         RSStoragemanagementModel * storagemanagementmodel = self.headerArray[indexPath.row];
        if ([storagemanagementmodel.mtlName isEqualToString:storagemanagementmodel.mtlInName]) {
            
            static NSString * EXCEPTIONHANDLINGDDDID = @"EXCEPTIONHANDLINGDDDID";
            RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGDDDID];
            if (!cell) {
                cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGDDDID];
            }
            cell.storagemaanagementmodel = self.headerArray[indexPath.row];
            if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
                cell.productDeleteBtn.hidden = NO;
                cell.productEidtBtn.hidden = NO;
            }else{
                cell.productDeleteBtn.hidden = YES;
                cell.productEidtBtn.hidden = YES;
            }
            cell.storagemaanagementmodel = self.headerArray[indexPath.row];
            cell.productEidtBtn.tag = indexPath.row;
            cell.productDeleteBtn.tag = indexPath.row;
            [cell.productEidtBtn addTarget:self action:@selector(productEidtAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productDeleteBtn addTarget:self action:@selector(productDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            static NSString * EXCEPTIONHANDLINGTHIRDID = @"EXCEPTIONHANDLINGTHIRDID";
            RSExceptionHandlingThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:EXCEPTIONHANDLINGTHIRDID];
            if (!cell) {
                cell = [[RSExceptionHandlingThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:EXCEPTIONHANDLINGTHIRDID];
            }
            
            if ([self.btnType isEqualToString:@"new"] || [self.btnType isEqualToString:@"edit"]) {
                cell.productDeleteBtn.hidden = NO;
                cell.productEidtBtn.hidden = NO;
            }else{
                cell.productDeleteBtn.hidden = YES;
                cell.productEidtBtn.hidden = YES;
            }
            cell.storagemanagementmodel = self.headerArray[indexPath.row];
            cell.productEidtBtn.tag = indexPath.row;
            cell.productDeleteBtn.tag = indexPath.row;
            [cell.productEidtBtn addTarget:self action:@selector(productEditNoChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productDeleteBtn addTarget:self action:@selector(productDeleteNoChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}







@end
