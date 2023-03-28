//
//  RSDabanAbnormalViewController.m
//  石来石往
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanAbnormalViewController.h"
#define margin 22
#define ECA 3

#import "RSDabanAbnormalHeaderView.h"
#import "RSDabanAbnormalProductNameHeaderView.h"
#import "RSDabanAbnormalCell.h"
#import "RSDabanAbnormalProductNameCell.h"
#import "RSDabanAbnormalProductNameThirdCell.h"
#import "RSDabanAbnormalSecondCell.h"
#import "RSDabanAbnormalThirdCell.h"

//选择库存
#import "RSChoosingInventoryViewController.h"

//尺寸变更，物料名变更
#import "RSBigBoardChangeViewController.h"

//模型
#import "RSChoosingInventoryModel.h"
#import "RSChoosingSliceModel.h"


#import "RSDabanPurchaseFootView.h"

//自定义组头
#import "RSSLFractureTreatmentView.h"
#import "RSDabanPurchaseHeaderView.h"
#import "RSBillHeadModel.h"

#import "RSDabanPurchaseCell.h"
#import "RSSLDabanPurchaseThirdHeaderView.h"
#import "RSSLChangeContentViewController.h"

@interface RSDabanAbnormalViewController ()<RSChoosingInventoryViewControllerDelegate,RSSLFractureTreatmentViewDelegate>

{
    
    
    //调拨时间
    UIButton * _timeBtn;
    //调拨时间显示
    UILabel * _timeShowLabel;
    
    UIView * _navigaionView;
    //选择库存按键
    UIButton * _selectBtn;
    //保存
    UIButton * _newSaveBtn;
    //编辑，删除，确认入库view
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
    //修改保存view
    UIButton * _saveBtn;
    
    //取消入库
    UIButton * _cancelBtn;
    
    
}

@property (nonatomic,strong)RSBillHeadModel * billheadmodel;

/**组的数组*/
@property (nonatomic,strong)NSMutableArray * headerArray;

/**头部视图的数组*/
@property (nonatomic,strong)NSMutableArray * customHeaderArray;



@property (nonatomic,strong)UIButton * currentSelectBtn;

//保存选择的按键的类型
@property (nonatomic,strong)NSString * btnType;


@end

@implementation RSDabanAbnormalViewController

- (RSBillHeadModel *)billheadmodel{
    if (!_billheadmodel) {
        _billheadmodel = [[RSBillHeadModel alloc]init];
    }
    return _billheadmodel;
}

//头部视图的数组
- (NSMutableArray *)customHeaderArray{
    if (!_customHeaderArray) {
        _customHeaderArray = [NSMutableArray array];
    }
    return _customHeaderArray;
}



- (NSMutableArray *)headerArray{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

static NSString * DABANABNORMALHEADER = @"DABANABNORMALHEADER";
static NSString * DABANABNORMALPRODUCTNAMEHEADERVIEW = @"DABANABNORMALPRODUCTNAMEHEADERVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"异常处理";    
    //自定义导航栏
    [self setCustomNavigaionView];
    //头部
    [self setHeaderView];
    //底部保存按键
    [self setUIBottomView];
    //编辑和确认入库，删除
    [self seteditAndSureUI];
    //取消编辑，修改保存
    [self setUICancelEditAndAllAndSaveSetUI];
    //取消入库
    [self cancelSetUI];
    
    
    [self setCustomTableviewHeaderView];
    
  
    
    if ([self.showType isEqualToString:@"new"]) {
        //点击新建的界面
        //        _savebottomBtn.hidden = NO;
        
        self.btnType = @"edit";
        _selectBtn.hidden = NO;
        _newSaveBtn.hidden = NO;
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
        _newSaveBtn.hidden = YES;
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
        [self reloadOldSaveNewData];
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
    _navigaionView = navigaionView;

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

//返回上一个页面
- (void)backOutAction:(UIButton *)leftBtn{
    if ([self.showType isEqualToString:@"new"]) {
        
        if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
            if ( [self.btnType isEqualToString:@"edit"] && self.customHeaderArray.count > 0 ) {
                
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
        
        
    }else{
        
        if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
            
            if ( [self.btnType isEqualToString:@"edit"] && self.customHeaderArray.count > 0) {
                
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
}



- (void)setHeaderView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_navigaionView.frame), SCW, 186)];
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
   // self.tableview.tableHeaderView = headerView;
    [self.view addSubview:headerView];
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), SCW, SCH - CGRectGetMaxY(headerView.frame));
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]|| [self.currentSelectBtn.currentTitle isEqualToString:@"物料变更"]) {
         self.tableview.contentInset = UIEdgeInsetsMake(-35, 0, 50, 0);
    }else{
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    }
}

- (void)choiceChangeTimeAction:(UIButton *)timeBtn{
    NSDate * date = [self nsstringConversionNSDate:_timeShowLabel.text];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString * date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        NSMutableArray * content = [NSMutableArray array];
        if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
            for (int i = 0; i < self.customHeaderArray.count; i++) {
                NSMutableArray * array = self.customHeaderArray[i];
                for (int j = 0 ; j < array.count; j++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                    [content addObject:slstoragemanagementmodel];
                }
            }
        }else{
            for (int i = 0; i < self.headerArray.count; i++) {
                NSMutableArray * array = self.headerArray[i];
                for (int j = 0 ; j < array.count; j++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                    [content addObject:slstoragemanagementmodel];
                }
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
                if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                    [self.customHeaderArray removeAllObjects];
                    [self setCustomTableviewHeaderView];
                    [self.headerArray removeAllObjects];
                }else{
                    [self.headerArray removeAllObjects];
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

//FIXME:自定义组头
- (void)setCustomTableviewHeaderView{
    UIView * headerView = [[UIView alloc]init];
    RSSLFractureTreatmentView * slfractureTreatView1 = [[RSSLFractureTreatmentView alloc]init];
    for (int i = 0; i < self.customHeaderArray.count; i++) {
        //判断这个数组最后一位的的view
        NSMutableArray * array = self.customHeaderArray[i];
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
        RSSLFractureTreatmentView * slfractureTreatView = [[RSSLFractureTreatmentView alloc]init];
        slfractureTreatView.productNameLabel.text = slstoragemanagementmodel.mtlName;
        slfractureTreatView.productNumberLabel.text =slstoragemanagementmodel.blockNo;
        slfractureTreatView.productTurnLabel.text =[NSString stringWithFormat:@"匝号:%@",slstoragemanagementmodel.turnsNo];
        slfractureTreatView.contentArray = array;
        slfractureTreatView.delegate = self;
        [headerView addSubview:slfractureTreatView];
        if (i == 0) {
            slfractureTreatView.sd_layout
            .leftSpaceToView(headerView, 12)
            .rightSpaceToView(headerView, 12)
            .topSpaceToView(headerView, 10)
            .autoHeightRatio(0);
        }else{
            if (slstoragemanagementmodel.isbool) {
                slfractureTreatView.sd_layout
                .leftSpaceToView(headerView, 12)
                .rightSpaceToView(headerView, 12)
                .topSpaceToView(slfractureTreatView1, 10)
                .heightIs(104);
            }else{
                slfractureTreatView.sd_layout
                .leftSpaceToView(headerView, 12)
                .rightSpaceToView(headerView, 12)
                .topSpaceToView(slfractureTreatView1, 10)
                .heightIs(104 + (array.count * 118));
            }
        }
        slfractureTreatView1 = slfractureTreatView;
        if (self.customHeaderArray.count - 1 == i) {
            slfractureTreatView.chuliLabel.hidden = NO;
           [headerView setupAutoHeightWithBottomView:slfractureTreatView bottomMargin:30];
        }else{
            slfractureTreatView.chuliLabel.hidden = YES;
        }
        slfractureTreatView.layer.cornerRadius = 8;
        slfractureTreatView.downBtn.tag = i;
        slfractureTreatView.userInteractionEnabled = YES;
        slfractureTreatView.dabanContentView.tag = i;
        slfractureTreatView.productDeleteBtn.tag = i;
        if ([self.btnType isEqualToString:@"edit"]) {
            slfractureTreatView.productDeleteBtn.hidden = NO;
            for (UIView * showView in slfractureTreatView.dabanContentView.subviews) {
                for (UIButton * deleteBtn in showView.subviews) {
                    if ([deleteBtn isMemberOfClass:[UIButton class]]) {
                          deleteBtn.hidden = NO;
                    }
                }
                for (UIButton * addBtn in showView.subviews) {
                    if ([addBtn isMemberOfClass:[UIButton class]]) {
                        addBtn.hidden = NO;
                    }
                }
            }
            //slfractureTreatView.dabanContentView.addBtn.hidden = NO;
            //slfractureTreatView.dabanContentView.deleteBtn.hidden = NO;
        }else{
            slfractureTreatView.productDeleteBtn.hidden = YES;
            for (UIView * showView in slfractureTreatView.dabanContentView.subviews) {
                for (UIButton * deleteBtn in showView.subviews) {
                    if ([deleteBtn isMemberOfClass:[UIButton class]]) {
                        deleteBtn.hidden = YES;
                    }
                }
                for (UIButton * addBtn in showView.subviews) {
                    if ([addBtn isMemberOfClass:[UIButton class]]) {
                        addBtn.hidden = YES;
                    }
                }
            }
           // slfractureTreatView.dabanContentView.addBtn.hidden = YES;
           // slfractureTreatView.dabanContentView.deleteBtn.hidden = YES;
        }
        [slfractureTreatView.productDeleteBtn addTarget:self action:@selector(deleteSlfracturetreatAction:) forControlEvents:UIControlEventTouchUpInside];
        [slfractureTreatView.downBtn addTarget:self action:@selector(isOpenDabanContentAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}

//是否展开
- (void)isOpenDabanContentAction:(UIButton *)downBtn{
    NSMutableArray * array = self.customHeaderArray[downBtn.tag];
    downBtn.selected = !downBtn.selected;
    for (int i = 0 ; i < array.count; i++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
        slstoragemanagementmodel.isbool = !slstoragemanagementmodel.isbool;
    }
    [self setCustomTableviewHeaderView];
    //[self.tableview reloadData];
}

//删除匝
- (void)deleteSlfracturetreatAction:(UIButton *)productDeleteBtn{
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        NSMutableArray * array = self.customHeaderArray[productDeleteBtn.tag];
        NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = 0; i < self.headerArray.count; i++){
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                [tempArray addObject:slstoragemanagementmodel];
            }
        }
        
        
        for (int i = 0; i < tempArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = tempArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel1 = array[j];
                if (slstoragemanagementmodel.did == slstoragemanagementmodel1.did) {
                    [tempArray removeObject:slstoragemanagementmodel];
                    i -= 1;
                }
            }
        }
        [self.headerArray removeAllObjects];
        self.headerArray = [self changeArrayRule:tempArray];
        [self.customHeaderArray removeObjectAtIndex:productDeleteBtn.tag];
        [self setCustomTableviewHeaderView];
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



//断裂+1
- (void)sendSection:(NSInteger)section andIndex:(NSInteger)index{
    if ([self.btnType isEqualToString:@"edit"]) {
        NSMutableArray * array = self.customHeaderArray[section];
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[index];
        [self addHeaderArray:slstoragemanagementmodel];
    }else{
        [SVProgressHUD showInfoWithStatus:@"只允许在编辑状态"];
    }
}

//添加
- (void)addHeaderArray:(RSSLStoragemanagementModel *)slstoragemanagementmodel{
    
    NSMutableArray * tempArray = [NSMutableArray array];
    for (int i = 0; i < self.headerArray.count; i++){
        NSMutableArray * array = self.headerArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            [tempArray addObject:slstoragemanagementmodel];
        }
    }
    /**单据ID    billid    Int
     明细ID    billdtlid    Int
     库存标识    did    Int
     物料ID    mtlId    Int
     仓库ID    whsId    Int
     物料类别ID    mtltypeId    Int
     入库类型    storageType    Sting
     物料ID新    mtlInId    Int
     物料类别ID 新    mtltypeInId    Int
     库区ID    storeareaId    Int
     荒料号    blockNo    String
     匝号    turnsNo    String
     板号    slNo    String
     入库日期    receiptDate    Sting
     数量    qty    Int
     长    length    Decimal
     宽    width    Decimal
     厚    height    Decimal
     原始面积    preArea    Decimal
     扣尺面积    dedArea    Decimal
     实际面积    area    Decimal
     长  新    lengthIn    Decimal
     宽 新    widthIn    Decimal
     厚 新    heightIn    Decimal
     原始面积 新    preareaIn    Decimal
     扣尺面积 新    dedareaIn    Decimal
     实际面积 新    areaIn    Decimal
     物料名称    mtlName    String
     物料名称 新    mtlInName    String
     物料类别名称    mtltypeName    String
     物料类别名称 新    mtltypeInName    String
     库区名称    storeareaName    String
     */
    
    RSSLStoragemanagementModel * slststoragemanagementmodel1 = [[RSSLStoragemanagementModel alloc]init];
    slststoragemanagementmodel1.billid = slstoragemanagementmodel.billid;
    slststoragemanagementmodel1.billdtlid = slstoragemanagementmodel.billdtlid;
    slststoragemanagementmodel1.did = slstoragemanagementmodel.did;
    slststoragemanagementmodel1.mtlId = slstoragemanagementmodel.mtlId;
    slststoragemanagementmodel1.whsId = slstoragemanagementmodel.whsId;
    slststoragemanagementmodel1.mtltypeId = slstoragemanagementmodel.mtltypeId;
    slststoragemanagementmodel1.storageType = slstoragemanagementmodel.storageType;
    slststoragemanagementmodel1.mtlInId = slstoragemanagementmodel.mtlInId;
    slststoragemanagementmodel1.mtltypeInId = slstoragemanagementmodel.mtltypeInId;
    slststoragemanagementmodel1.storeareaId = slstoragemanagementmodel.storeareaId;
    slststoragemanagementmodel1.blockNo = slstoragemanagementmodel.blockNo;
    slststoragemanagementmodel1.turnsNo = slstoragemanagementmodel.turnsNo;
    slststoragemanagementmodel1.slNo = slstoragemanagementmodel.slNo;
    slststoragemanagementmodel1.receiptDate = slstoragemanagementmodel.receiptDate;
    slststoragemanagementmodel1.qty = slstoragemanagementmodel.qty;
    slststoragemanagementmodel1.length = slstoragemanagementmodel.length;
    slststoragemanagementmodel1.width = slstoragemanagementmodel.width;
    slststoragemanagementmodel1.height = slstoragemanagementmodel.height;
    slststoragemanagementmodel1.preArea = slstoragemanagementmodel.preArea;
    slststoragemanagementmodel1.dedArea = slstoragemanagementmodel.dedArea;
    slststoragemanagementmodel1.area = slstoragemanagementmodel.area;
    slststoragemanagementmodel1.lengthIn = slstoragemanagementmodel.lengthIn;
    slststoragemanagementmodel1.widthIn = slstoragemanagementmodel.widthIn;
    slststoragemanagementmodel1.heightIn = slstoragemanagementmodel.heightIn;
    slststoragemanagementmodel1.preAreaIn = slstoragemanagementmodel.preAreaIn;
    slststoragemanagementmodel1.dedAreaIn = slstoragemanagementmodel.dedAreaIn;
    slststoragemanagementmodel1.areaIn = slstoragemanagementmodel.areaIn;
    slststoragemanagementmodel1.mtlName = slstoragemanagementmodel.mtlName;
    slststoragemanagementmodel1.isbool = false;
    slststoragemanagementmodel1.mtlInName = slstoragemanagementmodel.mtlInName;
    slststoragemanagementmodel1.mtltypeName = slstoragemanagementmodel.mtltypeName;
    slststoragemanagementmodel1.mtltypeInName = slstoragemanagementmodel.mtltypeInName;
    slststoragemanagementmodel1.storeareaName = slstoragemanagementmodel.storeareaName;
    
    [tempArray addObject:slststoragemanagementmodel1];
    [self.headerArray removeAllObjects];
    self.headerArray = [self changeArrayRule:tempArray];
    [self.tableview reloadData];
    
}

//删除一片
- (void)deleteSection:(NSInteger)section andIndex:(NSInteger)index{
     if ([self.btnType isEqualToString:@"edit"]) {
         
         UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             NSMutableArray * array = self.customHeaderArray[section];
             RSSLStoragemanagementModel * slstoragemanagementmodel = array[index];
             //删除一片
             [self deleteHeaderArray:slstoragemanagementmodel];
             [array removeObject:slstoragemanagementmodel];
             if (array.count < 1) {
                 [self.customHeaderArray removeObjectAtIndex:section];
             }
             [self setCustomTableviewHeaderView];
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
         
         [SVProgressHUD showInfoWithStatus:@"只允许在编辑状态"];
     }
}

//删除
- (void)deleteHeaderArray:(RSSLStoragemanagementModel *)slstoragemanagementmodel{
        NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = 0; i < self.headerArray.count; i++){
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                [tempArray addObject:slstoragemanagementmodel];
            }
        }
        
        for (int i = 0 ; i < tempArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel1 = tempArray[i];
            if (slstoragemanagementmodel.did == slstoragemanagementmodel1.did) {
                [tempArray removeObjectAtIndex:i];
                i--;
            }
        }
        [self.headerArray removeAllObjects];
        self.headerArray = [self changeArrayRule:tempArray];
        [self.tableview reloadData];
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
    UIButton * newSaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newSaveBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [newSaveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [newSaveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [newSaveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    newSaveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [newSaveBtn addTarget:self action:@selector(saveDabanAbnormalAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newSaveBtn];
    _newSaveBtn = newSaveBtn;
}



//切换功能
- (void)changSelectFunction:(UIButton *)publishBtn{
    if ([self.showType isEqualToString:@"new"]) {
        if ([publishBtn.currentTitle isEqualToString:self.currentSelectBtn.currentTitle]) {
            
            
            
        }else{
            
            if (self.customHeaderArray.count > 0 || self.headerArray.count > 0) {
                
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
                    _newSaveBtn.hidden = NO;
                    _timeBtn.hidden = NO;
                    
                    
                    _editSureView.hidden = YES;
                    _deleteBtn.hidden = YES;
                    _editBtn.hidden = YES;
                    _sureBtn.hidden = YES;
                    
                    _allView.hidden = YES;
                    _cancelEditBtn.hidden = YES;
                    _saveBtn.hidden = YES;
                    _cancelBtn.hidden = YES;
                    [self.customHeaderArray removeAllObjects];
                    [self.headerArray removeAllObjects];
                    [self setCustomTableviewHeaderView];
                    [self.tableview reloadData];
                    if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]|| [self.currentSelectBtn.currentTitle isEqualToString:@"物料变更"]) {
                        self.tableview.contentInset = UIEdgeInsetsMake(-35, 0, 50, 0);
                    }else{
                        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
                    }
                    
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
                _newSaveBtn.hidden = NO;
                _timeBtn.hidden = NO;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                [self.customHeaderArray removeAllObjects];
                [self.headerArray removeAllObjects];
                [self.tableview reloadData];
                [self setCustomTableviewHeaderView];
                if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]|| [self.currentSelectBtn.currentTitle isEqualToString:@"物料变更"]) {
                    self.tableview.contentInset = UIEdgeInsetsMake(-35, 0, 50, 0);
                }else{
                    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
                }
            }
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"不允许切换"];
    }

}

//选择库存
- (void)addSelectStockAction:(UIButton *)selectBtn{
    if (self.customHeaderArray.count < 1) {
        RSChoosingInventoryViewController * choosingInvertoryVc = [[RSChoosingInventoryViewController alloc]init];
        choosingInvertoryVc.selectType = self.selectType;
        choosingInvertoryVc.currentTitle = self.selectFunctionType;
        choosingInvertoryVc.selectFunctionType = self.selectFunctionType;
        choosingInvertoryVc.usermodel = self.usermodel;
       // choosingInvertoryVc.warehousemodel = self.warehousermodel;
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
            choosingInvertoryVc.delegate = self;
            choosingInvertoryVc.dateTo = _timeShowLabel.text;
            //if ([self.btnType isEqualToString:@"edit"]) {
            if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                NSMutableArray * array = [NSMutableArray array];
                for (int i = 0; i < self.customHeaderArray.count; i++) {
                    NSMutableArray * contentArray = self.customHeaderArray[i];
                    for (int j = 0; j < contentArray.count; j++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = contentArray[j];
                        [array addObject:slstoragemanagementmodel];
                    }
                }
                choosingInvertoryVc.selectdeContentArray = array;
            }else{
                NSMutableArray * array = [NSMutableArray array];
                for (int i = 0; i < self.headerArray.count; i++) {
                    NSMutableArray * contentArray = self.headerArray[i];
                    for (int j = 0; j < contentArray.count; j++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = contentArray[j];
                        [array addObject:slstoragemanagementmodel];
                    }
                }
                choosingInvertoryVc.selectdeContentArray = array;
            }
            //}
            [self.navigationController pushViewController:choosingInvertoryVc animated:YES];
        }else{
            //不成功
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }
}

    
//代理
- (void)dabanChoosingContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{
    NSMutableArray * tempArray = [NSMutableArray array];
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        for (int i = 0; i < self.customHeaderArray.count; i++){
            NSMutableArray * array = self.customHeaderArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                slstoragemanagementmodel.mtlInId = slstoragemanagementmodel.mtlId;
                slstoragemanagementmodel.mtlInName = slstoragemanagementmodel.mtlName;
                slstoragemanagementmodel.mtltypeInId = slstoragemanagementmodel.mtltypeId;
                slstoragemanagementmodel.mtltypeInName = slstoragemanagementmodel.mtltypeName;
                slstoragemanagementmodel.lengthIn = slstoragemanagementmodel.length;
                slstoragemanagementmodel.widthIn = slstoragemanagementmodel.width;
                slstoragemanagementmodel.heightIn = slstoragemanagementmodel.height;
                slstoragemanagementmodel.preAreaIn = slstoragemanagementmodel.preArea;
                slstoragemanagementmodel.dedAreaIn = slstoragemanagementmodel.dedArea;
                slstoragemanagementmodel.areaIn = slstoragemanagementmodel.area;
                [tempArray addObject:slstoragemanagementmodel];
            }
        }
    }else{
        for (int i = 0; i < self.headerArray.count; i++){
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                slstoragemanagementmodel.mtlInId = slstoragemanagementmodel.mtlId;
                slstoragemanagementmodel.mtlInName = slstoragemanagementmodel.mtlName;
                slstoragemanagementmodel.mtltypeInId = slstoragemanagementmodel.mtltypeId;
                slstoragemanagementmodel.mtltypeInName = slstoragemanagementmodel.mtltypeName;
                slstoragemanagementmodel.lengthIn = slstoragemanagementmodel.length;
                slstoragemanagementmodel.widthIn = slstoragemanagementmodel.width;
                slstoragemanagementmodel.heightIn = slstoragemanagementmodel.height;
                slstoragemanagementmodel.preAreaIn = slstoragemanagementmodel.preArea;
                slstoragemanagementmodel.dedAreaIn = slstoragemanagementmodel.dedArea;
                slstoragemanagementmodel.areaIn = slstoragemanagementmodel.area;
                [tempArray addObject:slstoragemanagementmodel];
            }
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
        slstoragemanagementmodel.mtlInId = slstoragemanagementmodel.mtlId;
        slstoragemanagementmodel.mtlInName = slstoragemanagementmodel.mtlName;
        slstoragemanagementmodel.mtltypeInId = slstoragemanagementmodel.mtltypeId;
        slstoragemanagementmodel.mtltypeInName = slstoragemanagementmodel.mtltypeName;
        slstoragemanagementmodel.lengthIn = slstoragemanagementmodel.length;
        slstoragemanagementmodel.widthIn = slstoragemanagementmodel.width;
        slstoragemanagementmodel.heightIn = slstoragemanagementmodel.height;
        slstoragemanagementmodel.preAreaIn = slstoragemanagementmodel.preArea;
        slstoragemanagementmodel.dedAreaIn = slstoragemanagementmodel.dedArea;
        slstoragemanagementmodel.areaIn = slstoragemanagementmodel.area;
        [tempArray addObject:slstoragemanagementmodel];
    }
    NSMutableArray * changeArray = [self changeArrayRule:tempArray];
     [self.customHeaderArray removeAllObjects];
     [self.headerArray removeAllObjects];
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
         [self.customHeaderArray addObjectsFromArray:changeArray];
    }else{
         [self.headerArray addObjectsFromArray:changeArray];
    }
    [self.tableview reloadData];
    [self setCustomTableviewHeaderView];
}

//保存
- (void)saveDabanAbnormalAction:(UIButton *)saveBtn{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        // self.btnType = @"save";
        if (self.headerArray.count > 0) {
            if ([self testingDataComplete]) {
                self.btnType = @"save";
                //[self newSaveBillNewData];
                [self newSaveBillNewData];
            }else{
                [SVProgressHUD showInfoWithStatus:@"数据不完整"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"请先处理物料再保存"];
        }
    }else{
        // self.btnType = @"save";
        if (self.headerArray.count > 0) {
            if ([self testingDataComplete]) {
                self.btnType = @"save";
                //[self newSaveBillNewData];
                [self newSaveBillNewData];
            }else{
                [SVProgressHUD showInfoWithStatus:@"数据不完整"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有数据"];
        }
    }
}

//判断完整性
- (BOOL)testingDataComplete{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        for (int i = 0; i < self.customHeaderArray.count; i++) {
            NSMutableArray * array = self.customHeaderArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                if ([slstoragemanagementmodel.mtlName isEqualToString:@""] || [slstoragemanagementmodel.mtltypeName isEqualToString:@""] || [slstoragemanagementmodel.turnsNo isEqualToString:@""] || [slstoragemanagementmodel.slNo isEqualToString:@""] || [slstoragemanagementmodel.preArea doubleValue] <= 0.000  ||
                    [slstoragemanagementmodel.area doubleValue] <= 0.000 ||
                    [slstoragemanagementmodel.blockNo isEqualToString:@""] ||  [slstoragemanagementmodel.length doubleValue] <= 0.000 ||  [slstoragemanagementmodel.width doubleValue]<= 0.000 || [slstoragemanagementmodel.height doubleValue]<= 0.000 || slstoragemanagementmodel.qty < 1 ) {
                    return NO;
                }
            }
        }
        return YES;
    }else{
        for (int i = 0; i < self.headerArray.count; i++) {
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                if ([slstoragemanagementmodel.mtlInName isEqualToString:@""] || [slstoragemanagementmodel.mtltypeInName isEqualToString:@""] || [slstoragemanagementmodel.turnsNo isEqualToString:@""] || [slstoragemanagementmodel.slNo isEqualToString:@""] || [slstoragemanagementmodel.preAreaIn doubleValue] <= 0.000  ||
                    [slstoragemanagementmodel.areaIn doubleValue] <= 0.000 ||
                    [slstoragemanagementmodel.blockNo isEqualToString:@""] ||  [slstoragemanagementmodel.lengthIn doubleValue] <= 0.000 ||  [slstoragemanagementmodel.widthIn doubleValue]<= 0.000 || [slstoragemanagementmodel.heightIn doubleValue]<= 0.000 || slstoragemanagementmodel.qty < 1 ) {
                    return NO;
                }
            }
        }
        return YES;
    }
}

//删除
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

//编辑
- (void)editOutAction:(UIButton *)editBtn{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        [self setCustomTableviewHeaderView];
        self.btnType = @"edit";
        _selectBtn.hidden = NO;
        _timeBtn.hidden = NO;
        _newSaveBtn.hidden = YES;
        _editSureView.hidden = YES;
        _deleteBtn.hidden = YES;
        _editBtn.hidden = YES;
        _sureBtn.hidden = YES;
        _allView.hidden = NO;
        _cancelEditBtn.hidden = NO;
        _saveBtn.hidden = NO;
        _cancelBtn.hidden = YES;
        [self.tableview reloadData];
        [self setCustomTableviewHeaderView];
    }else{
        
        self.btnType = @"edit";
        _selectBtn.hidden = NO;
        _timeBtn.hidden = NO;
        _newSaveBtn.hidden = YES;
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
    //[self setCustomTableviewFootView];
}



//确认入库
- (void)sureOutAction:(UIButton *)sureBtn{
    self.btnType = @"save";
    [self sureStorageBillNewData];
}

//取消编辑
- (void)cancelOutAction:(UIButton *)cancelEditBtn{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        
        self.btnType = @"save";
        _selectBtn.hidden = YES;
        _newSaveBtn.hidden = YES;
        _timeBtn.hidden = YES;
        _editSureView.hidden = NO;
        _deleteBtn.hidden = NO;
        _editBtn.hidden = NO;
        _sureBtn.hidden = NO;
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _saveBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        [self reloadOldSaveNewData];
    }else{
        self.btnType = @"save";
        _selectBtn.hidden = YES;
        _newSaveBtn.hidden = YES;
        _timeBtn.hidden = YES;
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
}


//修改保存
- (void)saveOutAction:(UIButton *)saveBtn{
    
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        
        if (self.headerArray.count > 0) {
            if ([self testingDataComplete]) {
                self.btnType = @"save";
                [self modifyAndSaveOutNewData];
            }else{
                [SVProgressHUD showInfoWithStatus:@"数据不完整"];
            }
            //[self modifyAndSaveNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"请先处理物料再保存"];
        }
    }else{
        
        if (self.headerArray.count > 0) {
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
}



//取消入库
- (void)cancelTwoOutAction:(UIButton *)cancelBtn{
    self.btnType = @"save";
    [self cancelStorageBillNewData];
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








- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        return self.headerArray.count;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
         return self.headerArray.count;
    }else{
         return self.headerArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        if (self.headerArray.count > 0) {
            NSMutableArray * array = self.headerArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return array.count;
            }else{
                return 0;
            }
        }else{
            return 0;
        }
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        if (self.headerArray.count > 0) {
            NSMutableArray * array = self.headerArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return array.count;
            }else{
                return 0;
            }
        }else{
            return 0;
        }
        
    }else{
        if (self.headerArray.count > 0) {
            NSMutableArray * array = self.headerArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return array.count;
            }else{
                return 0;
            }
        }else{
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
      return 108;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        return 108;
    }else{
         if (self.headerArray.count > 0) {
             NSMutableArray * array = self.headerArray[section];
             RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
             if ([slstoragemanagementmodel.mtlName isEqualToString:slstoragemanagementmodel.mtlInName]) {
                 return 108;
             }else{
                 return 116;
             }
         }else{
             return 108;
         }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        return 118;
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
//        RSChoosingInventoryModel * choosingInventorymodel = self.headerArray[indexPath.row];
//        if (choosingInventorymodel.isBool) {
//            return 118 + ( 118 * choosingInventorymodel.selectArray.count);
//        }else{
//            return 118;
//        }
        return 118;
    }else{
//        RSChoosingInventoryModel * choosingInventorymodel = self.headerArray[indexPath.row];
//        if (choosingInventorymodel.isBool) {
//            return 118 + ( 118 * choosingInventorymodel.selectArray.count);
//        }else{
//            if ([choosingInventorymodel.originalProductName isEqualToString:choosingInventorymodel.productName]) {
//                return 118;
//            }else{
//                return 126;
//            }
//        }
        return 118;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (self.headerArray.count > 0) {
//        NSMutableArray * array = self.headerArray[section];
//        RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
//        if (slstoragemanagementmodel.isbool) {
//            NSString * ide = [NSString stringWithFormat:@"DABANOUTPURCHASEFOOTVIEW%ld",section];
//            RSDabanPurchaseFootView * dabanPurchaseFootView = [[RSDabanPurchaseFootView alloc]initWithReuseIdentifier:ide];
//            return dabanPurchaseFootView;
//        }else{
//            return nil;
//        }
//
//    }else{
//        return nil;
//    }
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"] || [self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"] || [self.currentSelectBtn.currentTitle isEqualToString:@"物料变更"]) {
        if (self.headerArray.count > 0) {
            NSMutableArray * array = self.headerArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"] || [self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]) {
                
                static NSString * SLYICSTORAGEHEADERVIEWID = @"SLYICSTORAGEHEADERVIEWID";
               
                RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:SLYICSTORAGEHEADERVIEWID];
                dabanPurchaseHeaderView.downBtn.tag = section;
                dabanPurchaseHeaderView.productEidtBtn.tag = section;
                dabanPurchaseHeaderView.productDeleteBtn.tag = section;
                if ([self.btnType isEqualToString:@"edit"]) {
                    dabanPurchaseHeaderView.productDeleteBtn.hidden = NO;
                    dabanPurchaseHeaderView.productEidtBtn.hidden = NO;
                }else{
                    dabanPurchaseHeaderView.productDeleteBtn.hidden = YES;
                    dabanPurchaseHeaderView.productEidtBtn.hidden = YES;
                }
                dabanPurchaseHeaderView.productNameLabel.text = slstoragemanagementmodel.mtlInName;
                dabanPurchaseHeaderView.productNumberLabel.text = slstoragemanagementmodel.blockNo;
                dabanPurchaseHeaderView.productTurnLabel.text = slstoragemanagementmodel.turnsNo;
                [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
                [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
                [dabanPurchaseHeaderView.productEidtBtn addTarget:self action:@selector(dabanPurchAseProductdModifyAction:) forControlEvents:UIControlEventTouchUpInside];
                //要判断是不是物料变更，物料变更的要显示一个修改的物料名称
                return dabanPurchaseHeaderView;
                
                
            }else{
                
                if ([slstoragemanagementmodel.mtlName isEqualToString:slstoragemanagementmodel.mtlInName]) {
                    static NSString * SLYICSTORAGEHEADERVIEWID = @"SLYICSTORAGEHEADERVIEWID";
                    
                    RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:SLYICSTORAGEHEADERVIEWID];
                    dabanPurchaseHeaderView.downBtn.tag = section;
                    dabanPurchaseHeaderView.productEidtBtn.tag = section;
                    dabanPurchaseHeaderView.productDeleteBtn.tag = section;
                    if ([self.btnType isEqualToString:@"edit"]) {
                        dabanPurchaseHeaderView.productDeleteBtn.hidden = NO;
                        dabanPurchaseHeaderView.productEidtBtn.hidden = NO;
                    }else{
                        dabanPurchaseHeaderView.productDeleteBtn.hidden = YES;
                        dabanPurchaseHeaderView.productEidtBtn.hidden = YES;
                    }
                    dabanPurchaseHeaderView.slstoragemanagementmodel = slstoragemanagementmodel;
                    [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
                    [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
                    [dabanPurchaseHeaderView.productEidtBtn addTarget:self action:@selector(dabanPurchAseProductdModifyAction:) forControlEvents:UIControlEventTouchUpInside];
                    //要判断是不是物料变更，物料变更的要显示一个修改的物料名称
                    return dabanPurchaseHeaderView;
                }else{
                    
                    static NSString * DABANPURCHASETHIRDHEADERCELLID = @"DABANPURCHASETHIRDHEADERCELLID";
                    RSSLDabanPurchaseThirdHeaderView * dabanPurchaseHeaderView = [[RSSLDabanPurchaseThirdHeaderView alloc]initWithReuseIdentifier:DABANPURCHASETHIRDHEADERCELLID];
                    dabanPurchaseHeaderView.downBtn.tag = section;
                    dabanPurchaseHeaderView.productEidtBtn.tag = section;
                    dabanPurchaseHeaderView.productDeleteBtn.tag = section;
                    if ([self.btnType isEqualToString:@"edit"]) {
                        dabanPurchaseHeaderView.productDeleteBtn.hidden = NO;
                        dabanPurchaseHeaderView.productEidtBtn.hidden = NO;
                    }else{
                        dabanPurchaseHeaderView.productDeleteBtn.hidden = YES;
                        dabanPurchaseHeaderView.productEidtBtn.hidden = YES;
                    }
                    if ([slstoragemanagementmodel.mtlName isEqualToString:slstoragemanagementmodel.mtlInName]) {
                        
                        dabanPurchaseHeaderView.productModiftyLabel.hidden = YES;
                        
                        dabanPurchaseHeaderView.productModiftyLabel.sd_layout
                        .topSpaceToView(dabanPurchaseHeaderView.productNameLabel, 0)
                        .heightIs(0);
                        dabanPurchaseHeaderView.productNumberLabel.sd_layout
                        .topSpaceToView(dabanPurchaseHeaderView.productModiftyLabel, 0);
                        
                    }else{
                        dabanPurchaseHeaderView.productModiftyLabel.hidden = NO;
                        dabanPurchaseHeaderView.productModiftyLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.mtlName];
                        NSUInteger length = [slstoragemanagementmodel.mtlName length];
                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:slstoragemanagementmodel.mtlName];
                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithHexColorStr:@"#D0021B"] range:NSMakeRange(0, length)];
                        [dabanPurchaseHeaderView.productModiftyLabel setAttributedText:attri];
                        
                        
                      //  dabanPurchaseHeaderView.productModiftyLabel.text = slstoragemanagementmodel.mtlInName;
//                        dabanPurchaseHeaderView.productModiftyLabel.textColor = [UIColor redColor];
                        
                        dabanPurchaseHeaderView.productModiftyLabel.sd_layout
                        .topSpaceToView(dabanPurchaseHeaderView.productNameLabel, 0)
                        .heightIs(14);
                        dabanPurchaseHeaderView.productNumberLabel.sd_layout
                        .topSpaceToView(dabanPurchaseHeaderView.productModiftyLabel,0);
                    }
                    
                    dabanPurchaseHeaderView.productNameLabel.text = slstoragemanagementmodel.mtlInName;
                    dabanPurchaseHeaderView.productNumberLabel.text = slstoragemanagementmodel.blockNo;
                    dabanPurchaseHeaderView.productTurnLabel.text = [NSString stringWithFormat:@"匝号:%@",slstoragemanagementmodel.turnsNo];
                    
                    
                    
                    
                    
                   // dabanPurchaseHeaderView.slstoragemanagementmodel = slstoragemanagementmodel;
                    [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
                    [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
                    [dabanPurchaseHeaderView.productEidtBtn addTarget:self action:@selector(dabanPurchAseProductdModifyAction:) forControlEvents:UIControlEventTouchUpInside];
                    return dabanPurchaseHeaderView;
                }
            }
        }else{
            return nil;
        }
}

//向下
- (void)showAndHideDabanPurchaseAction:(UIButton *)downBtn{
    NSMutableArray * array = self.headerArray[downBtn.tag];
    downBtn.selected = !downBtn.selected;
    for (int i = 0 ; i < array.count; i++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
        slstoragemanagementmodel.isbool = !slstoragemanagementmodel.isbool;
    }
    //NSIndexSet * set = [NSIndexSet indexSetWithIndex:downBtn.tag];
//    [self.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    [self.tableview reloadData];
}

//删除
- (void)dabanPurchAseProductdDeleteAction:(UIButton *)productDeleteBtn{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        //删除一个匝号
        
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
       
    }else{
        
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
}

//编辑
- (void)dabanPurchAseProductdModifyAction:(UIButton *)productEidtBtn{
    
    
    RSSLChangeContentViewController * bigBoardChangeVc = [[RSSLChangeContentViewController alloc]init];
    bigBoardChangeVc.selectType = self.selectType;
    bigBoardChangeVc.currentTitle = self.currentSelectBtn.currentTitle;
    bigBoardChangeVc.title = [NSString stringWithFormat:@"%@",self.selectFunctionType];
    bigBoardChangeVc.index = productEidtBtn.tag;
    bigBoardChangeVc.selectFunctionType = self.selectFunctionType;
    bigBoardChangeVc.usermodel = self.usermodel;
//    NSMutableArray * tempArray = [NSMutableArray array];
//    for (int i = 0; i < self.headerArray.count; i++){
//        NSMutableArray * array = self.headerArray[i];
//        for (int j = 0; j < array.count; j++) {
//            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
//            [tempArray addObject:slstoragemanagementmodel];
//        }
//    }
    NSMutableArray * array = self.headerArray[productEidtBtn.tag];
    NSMutableArray * tempArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        RSSLStoragemanagementModel * slstoragemanageementmodel = array[i];
        RSSLStoragemanagementModel * slstoragemanageementmodel1 = [[RSSLStoragemanagementModel alloc]init];
        slstoragemanageementmodel1.billdtlid = slstoragemanageementmodel.billdtlid;
        slstoragemanageementmodel1.billid = slstoragemanageementmodel.billid;
        slstoragemanageementmodel1.blockNo = slstoragemanageementmodel.blockNo;
        slstoragemanageementmodel1.mtlName = slstoragemanageementmodel.mtlName;
        slstoragemanageementmodel1.storeareaId = slstoragemanageementmodel.storeareaId;
        slstoragemanageementmodel1.storeareaName = slstoragemanageementmodel.storeareaName;
        slstoragemanageementmodel1.turnsNo = slstoragemanageementmodel.turnsNo;
        slstoragemanageementmodel1.slNo = slstoragemanageementmodel.slNo;
        slstoragemanageementmodel1.did = slstoragemanageementmodel.did;
        slstoragemanageementmodel1.mtltypeName = slstoragemanageementmodel.mtltypeName;
        slstoragemanageementmodel1.mtltypeId = slstoragemanageementmodel.mtltypeId;
        slstoragemanageementmodel1.mtlId = slstoragemanageementmodel.mtlId;
        
        
        slstoragemanageementmodel1.whsId = slstoragemanageementmodel.whsId;
        
        
        slstoragemanageementmodel1.qty = slstoragemanageementmodel.qty;
        slstoragemanageementmodel1.length = slstoragemanageementmodel.length;
        slstoragemanageementmodel1.width = slstoragemanageementmodel.width;
        slstoragemanageementmodel1.height = slstoragemanageementmodel.height;
        slstoragemanageementmodel1.area = slstoragemanageementmodel.area;
        slstoragemanageementmodel1.dedArea = slstoragemanageementmodel.dedArea;
        slstoragemanageementmodel1.preArea = slstoragemanageementmodel.preArea;
        slstoragemanageementmodel1.storageType = slstoragemanageementmodel.storageType;
        slstoragemanageementmodel1.receiptDate = slstoragemanageementmodel.receiptDate;
        slstoragemanageementmodel1.mtlInName =  slstoragemanageementmodel.mtlInName;
        slstoragemanageementmodel1.mtltypeInName = slstoragemanageementmodel.mtltypeInName;
        slstoragemanageementmodel1.areaIn = slstoragemanageementmodel.areaIn;
        slstoragemanageementmodel1.dedAreaIn = slstoragemanageementmodel.dedAreaIn;
        slstoragemanageementmodel1.heightIn = slstoragemanageementmodel.heightIn;
        slstoragemanageementmodel1.lengthIn = slstoragemanageementmodel.lengthIn;
        slstoragemanageementmodel1.mtlInId = slstoragemanageementmodel.mtlInId;
        slstoragemanageementmodel1.mtltypeInId = slstoragemanageementmodel.mtltypeInId;
        slstoragemanageementmodel1.preAreaIn = slstoragemanageementmodel.preAreaIn;
        slstoragemanageementmodel1.widthIn = slstoragemanageementmodel.widthIn;
        
        
        slstoragemanageementmodel1.dedLengthOne = slstoragemanageementmodel.dedLengthOne;
        slstoragemanageementmodel1.dedWidthOne = slstoragemanageementmodel.dedWidthOne;
        slstoragemanageementmodel1.dedLengthTwo = slstoragemanageementmodel.dedLengthTwo;
        slstoragemanageementmodel1.dedWidthTwo = slstoragemanageementmodel.dedWidthTwo;
        slstoragemanageementmodel1.dedLengthThree = slstoragemanageementmodel.dedLengthThree;
        slstoragemanageementmodel1.dedWidthThree = slstoragemanageementmodel.dedWidthThree;
        slstoragemanageementmodel1.dedLengthFour = slstoragemanageementmodel.dedLengthFour;
        slstoragemanageementmodel1.dedWidthFour = slstoragemanageementmodel.dedWidthFour;
        slstoragemanageementmodel1.isbool = false;
        
        [tempArray addObject:slstoragemanageementmodel1];
    }
    bigBoardChangeVc.contentArray = tempArray;
    [self.navigationController pushViewController:bigBoardChangeVc animated:YES];
    bigBoardChangeVc.newSaveData = ^(NSMutableArray * _Nonnull contentArray, NSInteger index) {
        [self.headerArray replaceObjectAtIndex:index withObject:contentArray];
        [self.tableview reloadData];
    };
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        NSString *identifier = [NSString stringWithFormat:@"DABANABNORMALPRODUCTNAMEDID%ld%ld",(long)indexPath.section,(long)indexPath.row];
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
        NSMutableArray * array = self.headerArray[indexPath.section];
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
        
        cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
        
        cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.lengthIn doubleValue]];
        
        CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.lengthIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.longDetailLabel.sd_layout
        .widthIs(size1.width);
        
        
        cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]];
        
        CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.wideDetialLabel.sd_layout
        .widthIs(size2.width);
        
        
        cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]];
        
        CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.thickDeitalLabel.sd_layout
        .widthIs(size3.width);
        
        cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]];
        CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.originalAreaDetailLabel.sd_layout
        .widthIs(size4.width);
        
        
        
        cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]];
        CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.deductionAreaDetailLabel.sd_layout
        .widthIs(size5.width);
        
        
        cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]];
        CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.actualAreaDetailLabel.sd_layout
        .widthIs(size6.width);
    
        
        
        RSWeakself
        cell.deleteAction = ^(NSIndexPath * indexPath) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableArray * array = weakSelf.headerArray[indexPath.section];
                
                [array removeObjectAtIndex:indexPath.row];
                if (array.count < 1) {
                    [weakSelf.headerArray removeObjectAtIndex:indexPath.section];
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
            [self presentViewController:alertView animated:YES completion:nil];
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
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        //这边是可以判断有没有不一样的，一样就隐藏后面的修改的值，不一样就显示出来
        
        NSString *identifier = [NSString stringWithFormat:@"DABANABNORMALSECONDID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        RSDabanAbnormalSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RSDabanAbnormalSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        
        cell.indexPath = indexPath;
        if ([self.btnType isEqualToString:@"edit"]) {
            cell.mainScrollView.userInteractionEnabled = YES;
        }else{
            cell.mainScrollView.userInteractionEnabled = NO;
        }
        
        NSMutableArray * array = self.headerArray[indexPath.section];
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
        
        cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
        
        cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.lengthIn doubleValue]];
        
        CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.lengthIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.longDetailLabel.sd_layout
        .widthIs(size1.width);
        
        
        cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]];
        
        CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.wideDetialLabel.sd_layout
        .widthIs(size2.width);
        
        
        cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]];
        
        CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.thickDeitalLabel.sd_layout
        .widthIs(size3.width);
        
        cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]];
        CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.originalAreaDetailLabel.sd_layout
        .widthIs(size4.width);
        
        
        
        cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]];
        CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.deductionAreaDetailLabel.sd_layout
        .widthIs(size5.width);
        
        
        cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]];
        CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.actualAreaDetailLabel.sd_layout
        .widthIs(size6.width);
        
        
        //
        if ([slstoragemanagementmodel.length isEqual:slstoragemanagementmodel.lengthIn]) {
            //不显示
            cell.longModifyLabel.hidden = YES;
            
            
        }else{
            //显示
            
            cell.longModifyLabel.hidden = NO;
            
            cell.longModifyLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
            
            CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:cell.longModifyLabel.font];
//            longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
//            longModifyLabel.text = @"0.1";
            cell.longModifyLabel.sd_layout
            .leftSpaceToView(cell.longDetailLabel, 0)
            .widthIs(size6.width);
            
            NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] attributes:attribtDic1];
            //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
            cell.longModifyLabel.attributedText= attribtStr1;
            
            
        }
        
        if ([slstoragemanagementmodel.width isEqual:slstoragemanagementmodel.widthIn]) {
            //不显示
            cell.wideModifyLabel.hidden = YES;
            
        }else{
            //显示
            cell.wideModifyLabel.hidden = NO;
            cell.wideModifyLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
            
            
            CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:cell.wideModifyLabel.font];
            //            longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
            //            longModifyLabel.text = @"0.1";
            cell.wideModifyLabel.sd_layout
            .leftSpaceToView(cell.wideDetialLabel, 0)
            .widthIs(size6.width);
            NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] attributes:attribtDic1];
            //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
            cell.wideModifyLabel.attributedText= attribtStr1;
        }
        
        
        if ([slstoragemanagementmodel.height isEqual:slstoragemanagementmodel.heightIn]) {
            //不显示
            cell.thickModifyLabel.hidden = YES;
            
        }else{
            //显示
            cell.thickModifyLabel.hidden = NO;
            cell.thickModifyLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
            CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.height doubleValue]] andFont:cell.thickModifyLabel.font];
            //            longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
            //            longModifyLabel.text = @"0.1";
            cell.thickModifyLabel.sd_layout
            .leftSpaceToView(cell.thickDeitalLabel, 0)
            .widthIs(size6.width);
            NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] attributes:attribtDic1];
            //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
            cell.wideModifyLabel.attributedText= attribtStr1;
        }
        
        
        if ([slstoragemanagementmodel.preArea isEqual:slstoragemanagementmodel.preAreaIn]) {
            //不显示
            cell.originalModifyLabel.hidden = YES;
        }else{
            //显示
            cell.originalModifyLabel.hidden = NO;
            cell.originalModifyLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
            
            CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:cell.thickModifyLabel.font];
            //            longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
            //            longModifyLabel.text = @"0.1";
            cell.originalModifyLabel.sd_layout
            .leftSpaceToView(cell.originalAreaDetailLabel, 0)
            .widthIs(size6.width);
            NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] attributes:attribtDic1];
            //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
            cell.originalModifyLabel.attributedText= attribtStr1;
        }
        
        
        
        if ([slstoragemanagementmodel.dedArea isEqual:slstoragemanagementmodel.dedAreaIn]) {
            //不显示
            cell.deductionModifyLabel.hidden = YES;
        }else{
            //显示
            cell.deductionModifyLabel.hidden = NO;
            cell.deductionModifyLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
            
            CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:cell.deductionModifyLabel.font];
            //            longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
            //            longModifyLabel.text = @"0.1";
            cell.deductionModifyLabel.sd_layout
            .leftSpaceToView(cell.deductionAreaDetailLabel, 0)
            .widthIs(size6.width);
            NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] attributes:attribtDic1];
            //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
            cell.deductionModifyLabel.attributedText= attribtStr1;
            
            
            
        }
        
        if ([slstoragemanagementmodel.area isEqual:slstoragemanagementmodel.areaIn]) {
            //不显示
            cell.actualModifyLabel.hidden = YES;
        }else{
            //显示
            cell.actualModifyLabel.hidden = NO;
            cell.actualModifyLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
            
            CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:cell.actualModifyLabel.font];
            //            longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
            //            longModifyLabel.text = @"0.1";
            cell.actualModifyLabel.sd_layout
            .leftSpaceToView(cell.actualAreaDetailLabel, 0)
            .widthIs(size6.width);
            NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            
            NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] attributes:attribtDic1];
            //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
            cell.actualModifyLabel.attributedText= attribtStr1;
        }
        RSWeakself
        cell.deleteAction = ^(NSIndexPath * indexPath) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableArray * array = weakSelf.headerArray[indexPath.section];
                
                [array removeObjectAtIndex:indexPath.row];
                if (array.count < 1) {
                    [weakSelf.headerArray removeObjectAtIndex:indexPath.section];
                }
                RSDabanAbnormalSecondCell * cell1 = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
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
            for (RSDabanAbnormalSecondCell * tableViewCell in weakSelf.tableview.visibleCells) {
                /// 当屏幕滑动时，关闭不是当前滑动的cell
                if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                    [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *identifier = [NSString stringWithFormat:@"DABANABNORMALPRODUCTNAMETHIRDID%ld%ld",(long)indexPath.section,(long)indexPath.row];
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
        NSMutableArray * array = self.headerArray[indexPath.section];
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
        
        cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
        
        cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.lengthIn doubleValue]];
        
        CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.lengthIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.longDetailLabel.sd_layout
        .widthIs(size1.width);
        
        
        cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]];
        
        CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.wideDetialLabel.sd_layout
        .widthIs(size2.width);
        
        
        cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]];
        
        CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.thickDeitalLabel.sd_layout
        .widthIs(size3.width);
        
        cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]];
        CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.originalAreaDetailLabel.sd_layout
        .widthIs(size4.width);
        
        
        
        cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]];
        CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.deductionAreaDetailLabel.sd_layout
        .widthIs(size5.width);
        
        
        cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]];
        CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]] andFont:[UIFont systemFontOfSize:14]];
        cell.actualAreaDetailLabel.sd_layout
        .widthIs(size6.width);
        
        
        
        RSWeakself
        cell.deleteAction = ^(NSIndexPath * indexPath) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableArray * array = weakSelf.headerArray[indexPath.section];
                
                [array removeObjectAtIndex:indexPath.row];
                if (array.count < 1) {
                    [weakSelf.headerArray removeObjectAtIndex:indexPath.section];
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
    return nil;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        for (RSDabanPurchaseCell * tableViewCell in self.tableview.visibleCells) {
            /// 当屏幕滑动时，关闭被打开的cell
            if (tableViewCell.isOpen == YES) {
                [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    }else if([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        
        for (RSDabanAbnormalSecondCell * tableViewCell in self.tableview.visibleCells) {
            /// 当屏幕滑动时，关闭被打开的cell
            if (tableViewCell.isOpen == YES) {
                [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
        
    }else{
        
        for (RSDabanPurchaseCell * tableViewCell in self.tableview.visibleCells) {
            /// 当屏幕滑动时，关闭被打开的cell
            if (tableViewCell.isOpen == YES) {
                [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
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
                
                _selectBtn.hidden = YES;
                _newSaveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _editSureView.hidden = YES;
                _deleteBtn.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                
                
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
                   [SVProgressHUD showSuccessWithStatus:@"取消入库成功"];
            }else{
                _selectBtn.hidden = YES;
                _newSaveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
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
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alertView addAction:alert];
                 if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                       
                                       alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                   }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
                
            }
        }else{
            _selectBtn.hidden = YES;
            _newSaveBtn.hidden = YES;
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
                
                _selectBtn.hidden = YES;
                _newSaveBtn.hidden = YES;
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
                
            //    [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"确认入库成功"];
            }else{
                _selectBtn.hidden = YES;
                _newSaveBtn.hidden = YES;
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
            _selectBtn.hidden = YES;
            _newSaveBtn.hidden = YES;
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
                _selectBtn.hidden = YES;
                _newSaveBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
                _newSaveBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
            _selectBtn.hidden = YES;
            _newSaveBtn.hidden = YES;
            _timeBtn.hidden = YES;
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
                if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                    [weakSelf.customHeaderArray removeAllObjects];
                    [weakSelf.headerArray removeAllObjects];
                }else{
                     [weakSelf.headerArray removeAllObjects];
                }
              /**
                 abType":"dlcl",
                 "billDate":"2019-05-10",
                 "billNo":"SL_YCCL201905100008",
                 "billType":"BILL_SL_YCCL",
                 "billid":194759,
                 "blockNos":"ATH2018102605093,",
                 "createTime":"2019-05-10 21:05:04",
                 "createUser":95,
                 "mtlNames":"意大利45度灰,",
                 "pwmsUserId":95,
                 "status":0,
                 "totalArea":1.632,
                 "totalDedArea":0.06,
                 "totalPreArea":1.692,
                 "totalQty":1,
                 "totalTurnsQty":1,
                 "updateTime":"2019-05-10 21:05:04",
                 "updateUser":95
                  */
                weakSelf.billheadmodel.abType = json[@"data"][@"billHead"][@"abType"];
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
                
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                
                
                if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
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
                        //                    slstoragemanagementmodel.isSelect = true;
                        
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        slstoragemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                        slstoragemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.areaIn = [[array objectAtIndex:i]objectForKey:@"areaIn"];
                        slstoragemanagementmodel.dedAreaIn = [[array objectAtIndex:i]objectForKey:@"dedAreaIn"];
                        slstoragemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                        slstoragemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                        slstoragemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"] integerValue];
                        slstoragemanagementmodel.preAreaIn = [[array objectAtIndex:i]objectForKey:@"preAreaIn"];
                        slstoragemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                        
                        
                        
                        slstoragemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"] integerValue];
                       
                        slstoragemanagementmodel.isbool = false;
                        [temp addObject:slstoragemanagementmodel];
                    }
                    NSMutableArray * twotemp = [NSMutableArray array];
                    NSMutableArray * twoarray = [NSMutableArray array];
                    twoarray = json[@"data"][@"billDtl2"];
                    for (int i = 0; i < twoarray.count; i++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        slstoragemanagementmodel.billdtlid = [[[twoarray objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                        slstoragemanagementmodel.billid = [[[twoarray objectAtIndex:i]objectForKey:@"billid"] integerValue];
                        slstoragemanagementmodel.blockNo = [[twoarray objectAtIndex:i]objectForKey:@"blockNo"];
                        slstoragemanagementmodel.mtlName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.storeareaId = [[[twoarray objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                        slstoragemanagementmodel.mtltypeName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        slstoragemanagementmodel.mtltypeId = [[[twoarray objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                        slstoragemanagementmodel.mtlId = [[[twoarray objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.turnsNo = [[twoarray objectAtIndex:i]objectForKey:@"turnsNo"];
                        slstoragemanagementmodel.slNo = [[twoarray objectAtIndex:i]objectForKey:@"slNo"];
                        slstoragemanagementmodel.length =  [[twoarray objectAtIndex:i]objectForKey:@"length"];
                        slstoragemanagementmodel.width = [[twoarray objectAtIndex:i]objectForKey:@"width"];
                        slstoragemanagementmodel.height = [[twoarray objectAtIndex:i]objectForKey:@"height"];
                        /**实际面积*/
                        slstoragemanagementmodel.area = [[twoarray objectAtIndex:i]objectForKey:@"area"];
                        /**扣尺面积*/
                        slstoragemanagementmodel.dedArea = [[twoarray objectAtIndex:i]objectForKey:@"dedArea"];
                        /**原始面积*/
                        slstoragemanagementmodel.preArea = [[twoarray objectAtIndex:i]objectForKey:@"preArea"];
                        slstoragemanagementmodel.did = [[[twoarray objectAtIndex:i]objectForKey:@"did"] integerValue];
                        slstoragemanagementmodel.receiptDate = [[twoarray objectAtIndex:i]objectForKey:@"receiptDate"];
                        
                        slstoragemanagementmodel.storageType = [[twoarray objectAtIndex:i]objectForKey:@"storageType"];
                        //                    slstoragemanagementmodel.isSelect = true;
                        
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        slstoragemanagementmodel.mtlInName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.mtltypeInName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        
                        
                        
                        slstoragemanagementmodel.qty = [[[twoarray objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[twoarray objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.areaIn = [[twoarray objectAtIndex:i]objectForKey:@"area"];
                        slstoragemanagementmodel.dedAreaIn = [[twoarray objectAtIndex:i]objectForKey:@"dedArea"];
                        slstoragemanagementmodel.heightIn = [[twoarray objectAtIndex:i]objectForKey:@"height"];
                        slstoragemanagementmodel.lengthIn = [[twoarray objectAtIndex:i]objectForKey:@"length"];
                        slstoragemanagementmodel.mtlInId = [[[twoarray objectAtIndex:i]objectForKey:@"mtlIn"] integerValue];
                        slstoragemanagementmodel.mtltypeInId = [[[twoarray objectAtIndex:i]objectForKey:@"mtltype"] integerValue];
                        slstoragemanagementmodel.mtlInName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.mtltypeInName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        slstoragemanagementmodel.preAreaIn = [[twoarray objectAtIndex:i]objectForKey:@"preArea"];
                        slstoragemanagementmodel.widthIn = [[twoarray objectAtIndex:i]objectForKey:@"width"];
                        slstoragemanagementmodel.isbool = false;
                        [twotemp addObject:slstoragemanagementmodel];
                    }
                    //if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                    weakSelf.customHeaderArray = [weakSelf changeArrayRule:temp];
                    [weakSelf setCustomTableviewHeaderView];
                    weakSelf.headerArray = [weakSelf changeArrayRule:twotemp];
                    //}else{
                    
                    //}
                }else{
                    
                    NSMutableArray * temp = [NSMutableArray array];
                    NSMutableArray * array = [NSMutableArray array];
                    array = json[@"data"][@"billDtl"];
                    for (int i = 0; i < array.count; i++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        slstoragemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                        slstoragemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                        slstoragemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                        slstoragemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                        
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
                        //                    slstoragemanagementmodel.isSelect = true;
                        
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        slstoragemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                          slstoragemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                        slstoragemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                         slstoragemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltype"] integerValue];
                        slstoragemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                        slstoragemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                       slstoragemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"] integerValue];
                        
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        
                        slstoragemanagementmodel.areaIn = [[array objectAtIndex:i]objectForKey:@"areaIn"];
                        slstoragemanagementmodel.dedAreaIn = [[array objectAtIndex:i]objectForKey:@"dedAreaIn"];
                        slstoragemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                        slstoragemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                        
                        slstoragemanagementmodel.preAreaIn = [[array objectAtIndex:i]objectForKey:@"preAreaIn"];
                        slstoragemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                        

//                        slstoragemanagementmodel.preAreaIn = [[array objectAtIndex:i]objectForKey:@"preAreaIn"];
//                        slstoragemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
//                        slstoragemanagementmodel.areaIn = [[array objectAtIndex:i]objectForKey:@"areaIn"];
//                        slstoragemanagementmodel.dedAreaIn = [[array objectAtIndex:i]objectForKey:@"dedAreaIn"];
//                        slstoragemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
//                        slstoragemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
//                        slstoragemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlIn"] integerValue];
                     
                        
                       // slstoragemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                        
                        slstoragemanagementmodel.isbool = false;
                        [temp addObject:slstoragemanagementmodel];
                    }
                    weakSelf.headerArray = [weakSelf changeArrayRule:temp];
                }
                [weakSelf.tableview reloadData];
            }else{
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertView addAction:alert];
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
    
    
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        
        for (int i = 0 ; i < self.customHeaderArray.count; i++) {
            NSMutableArray * array = self.customHeaderArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                newArea += [slstoragemanagementmodel.area doubleValue];
                totalNumber += slstoragemanagementmodel.qty;
                newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
            }
        }
        totalTurnsQty = self.customHeaderArray.count;
        totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
        totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
        
        
        
    }else{
        
        
        for (int i = 0 ; i < self.headerArray.count; i++) {
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                newArea += [slstoragemanagementmodel.area doubleValue];
                totalNumber += slstoragemanagementmodel.qty;
                newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
            }
        }
        totalTurnsQty = self.headerArray.count;
        totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
        totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    }
    NSString * str = [NSString string];
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        str = @"dlcl";
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"尺寸变更"]){
        str = @"ccbg";
    }else{
        str = @"wlbg";
    }
    //,@"totalQty":@(totalNumber)
    
    NSDictionary * billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"blockNos":@"",@"status":@"",@"abType":str,@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"whsId":@"",@"whsName":@""};
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    //[phoneDict setObject:self.selectShow forKey:@"billType"];
    //[phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * tempArray = [NSMutableArray array];
    NSMutableArray * twoArray = [NSMutableArray array];
    
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        
        for (int i = 0 ; i < self.customHeaderArray.count; i++) {
            NSMutableArray * array = self.customHeaderArray[i];
            for (int j = 0; j < array.count; j++) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                RSSLStoragemanagementModel * slstroagemanagementmodel = array[j];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billid] forKey:@"billid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billdtlid] forKey:@"billdtlid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.did] forKey:@"did"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlId] forKey:@"mtlId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.whsId] forKey:@"whsId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
                
                [dict setObject:slstroagemanagementmodel.storageType forKey:@"storageType"];
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlInId] forKey:@"mtlInId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
                 [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"lengthIn"];
                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"widthIn"];
                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"heightIn"];
                [dict setObject:slstroagemanagementmodel.preAreaIn forKey:@"preAreaIn"];
                 [dict setObject:slstroagemanagementmodel.dedAreaIn forKey:@"dedAreaIn"];
                 [dict setObject:slstroagemanagementmodel.areaIn forKey:@"areaIn"];
                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlInName"];
                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
                
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.storeareaId] forKey:@"storeareaId"];
                [dict setObject:slstroagemanagementmodel.blockNo forKey:@"blockNo"];
                [dict setObject:slstroagemanagementmodel.turnsNo forKey:@"turnsNo"];
                [dict setObject:slstroagemanagementmodel.slNo forKey:@"slNo"];
                [dict setObject:slstroagemanagementmodel.receiptDate forKey:@"receiptDate"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.qty] forKey:@"qty"];
                [dict setObject:slstroagemanagementmodel.length forKey:@"length"];
                [dict setObject:slstroagemanagementmodel.width forKey:@"width"];
                [dict setObject:slstroagemanagementmodel.height forKey:@"height"];
                [dict setObject:slstroagemanagementmodel.preArea forKey:@"preArea"];
                [dict setObject:slstroagemanagementmodel.dedArea forKey:@"dedArea"];
                [dict setObject:slstroagemanagementmodel.area forKey:@"area"];
                [dict setObject:slstroagemanagementmodel.mtlName forKey:@"mtlName"];
                [dict setObject:slstroagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
                [tempArray addObject:dict];
                
            }
        }
    }else{
        
        for (int i = 0 ; i < self.headerArray.count; i++) {
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                RSSLStoragemanagementModel * slstroagemanagementmodel = array[j];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billid] forKey:@"billid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billdtlid] forKey:@"billdtlid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.did] forKey:@"did"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlId] forKey:@"mtlId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.whsId] forKey:@"whsId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
                
                [dict setObject:slstroagemanagementmodel.storageType forKey:@"storageType"];
            
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlInId] forKey:@"mtlInId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
                [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"lengthIn"];
                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"widthIn"];
                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"heightIn"];
                [dict setObject:slstroagemanagementmodel.preAreaIn forKey:@"preAreaIn"];
                [dict setObject:slstroagemanagementmodel.dedAreaIn forKey:@"dedAreaIn"];
                [dict setObject:slstroagemanagementmodel.areaIn forKey:@"areaIn"];
                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlInName"];
                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
                
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.storeareaId] forKey:@"storeareaId"];
                [dict setObject:slstroagemanagementmodel.blockNo forKey:@"blockNo"];
                [dict setObject:slstroagemanagementmodel.turnsNo forKey:@"turnsNo"];
                [dict setObject:slstroagemanagementmodel.slNo forKey:@"slNo"];
                [dict setObject:slstroagemanagementmodel.receiptDate forKey:@"receiptDate"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.qty] forKey:@"qty"];
                [dict setObject:slstroagemanagementmodel.length forKey:@"length"];
                [dict setObject:slstroagemanagementmodel.width forKey:@"width"];
                [dict setObject:slstroagemanagementmodel.height forKey:@"height"];
                [dict setObject:slstroagemanagementmodel.preArea forKey:@"preArea"];
                [dict setObject:slstroagemanagementmodel.dedArea forKey:@"dedArea"];
                [dict setObject:slstroagemanagementmodel.area forKey:@"area"];
                [dict setObject:slstroagemanagementmodel.mtlName forKey:@"mtlName"];
                [dict setObject:slstroagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
                
                 [tempArray addObject:dict];
            }
        }
    }
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        for (int i = 0 ; i < self.headerArray.count; i++) {
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                RSSLStoragemanagementModel * slstroagemanagementmodel = array[j];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billid] forKey:@"billid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billdtlid] forKey:@"billdtlid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.did] forKey:@"did"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlId] forKey:@"mtlId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.whsId] forKey:@"whsId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
                
                [dict setObject:slstroagemanagementmodel.storageType forKey:@"storageType"];
                
                
                
                
//                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlInId] forKey:@"mtlInId"];
//                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
//                [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"lengthIn"];
//                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"widthIn"];
//                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"heightIn"];
//                [dict setObject:slstroagemanagementmodel.preareaIn forKey:@"preareaIn"];
//                [dict setObject:slstroagemanagementmodel.dedareaIn forKey:@"dedareaIn"];
//                [dict setObject:slstroagemanagementmodel.areaIn forKey:@"areaIn"];
//                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlInName"];
//                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
//
                
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.storeareaId] forKey:@"storeareaId"];
                [dict setObject:slstroagemanagementmodel.blockNo forKey:@"blockNo"];
                [dict setObject:slstroagemanagementmodel.turnsNo forKey:@"turnsNo"];
                [dict setObject:slstroagemanagementmodel.slNo forKey:@"slNo"];
                [dict setObject:slstroagemanagementmodel.receiptDate forKey:@"receiptDate"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.qty] forKey:@"qty"];
                
                //用新值
                [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"length"];
                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"width"];
                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"height"];
                [dict setObject:slstroagemanagementmodel.preAreaIn forKey:@"preArea"];
                [dict setObject:slstroagemanagementmodel.dedAreaIn forKey:@"dedArea"];
                [dict setObject:slstroagemanagementmodel.areaIn forKey:@"area"];
                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlName"];
                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeName"];
                [twoArray addObject:dict];
            }
        }
    }
    [phoneDict setObject:tempArray forKey:@"billDtl"];
    [phoneDict setObject:twoArray forKey:@"billDtl2"];
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
                if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                    [weakSelf.customHeaderArray removeAllObjects];
                    [weakSelf.headerArray removeAllObjects];
                }else{
                    [weakSelf.headerArray removeAllObjects];
                }
                
                _selectBtn.hidden = YES;
                _newSaveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                
                weakSelf.billheadmodel.abType = json[@"data"][@"billHead"][@"abType"];
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
                
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
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
                        //                    slstoragemanagementmodel.isSelect = true;
                        slstoragemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                        slstoragemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.areaIn = [[array objectAtIndex:i]objectForKey:@"areaIn"];
                        slstoragemanagementmodel.dedAreaIn = [[array objectAtIndex:i]objectForKey:@"dedAreaIn"];
                        slstoragemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                        slstoragemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                        slstoragemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"] integerValue];
                        slstoragemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"] integerValue];
                        slstoragemanagementmodel.preAreaIn = [[array objectAtIndex:i]objectForKey:@"preAreaIn"];
                        slstoragemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                        slstoragemanagementmodel.isbool = false;
                        [temp addObject:slstoragemanagementmodel];
                    }
                    NSMutableArray * twotemp = [NSMutableArray array];
                    NSMutableArray * twoarray = [NSMutableArray array];
                    twoarray = json[@"data"][@"billDtl2"];
                    for (int i = 0; i < twoarray.count; i++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        slstoragemanagementmodel.billdtlid = [[[twoarray objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                        slstoragemanagementmodel.billid = [[[twoarray objectAtIndex:i]objectForKey:@"billid"] integerValue];
                        slstoragemanagementmodel.blockNo = [[twoarray objectAtIndex:i]objectForKey:@"blockNo"];
                        slstoragemanagementmodel.mtlName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.storeareaId = [[[twoarray objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                        slstoragemanagementmodel.mtltypeName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        slstoragemanagementmodel.mtltypeId = [[[twoarray objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                        slstoragemanagementmodel.mtlId = [[[twoarray objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.turnsNo = [[twoarray objectAtIndex:i]objectForKey:@"turnsNo"];
                        slstoragemanagementmodel.slNo = [[twoarray objectAtIndex:i]objectForKey:@"slNo"];
                        slstoragemanagementmodel.length =  [[twoarray objectAtIndex:i]objectForKey:@"length"];
                        slstoragemanagementmodel.width = [[twoarray objectAtIndex:i]objectForKey:@"width"];
                        slstoragemanagementmodel.height = [[twoarray objectAtIndex:i]objectForKey:@"height"];
                        /**实际面积*/
                        slstoragemanagementmodel.area = [[twoarray objectAtIndex:i]objectForKey:@"area"];
                        /**扣尺面积*/
                        slstoragemanagementmodel.dedArea = [[twoarray objectAtIndex:i]objectForKey:@"dedArea"];
                        /**原始面积*/
                        slstoragemanagementmodel.preArea = [[twoarray objectAtIndex:i]objectForKey:@"preArea"];
                        slstoragemanagementmodel.did = [[[twoarray objectAtIndex:i]objectForKey:@"did"] integerValue];
                        slstoragemanagementmodel.receiptDate = [[twoarray objectAtIndex:i]objectForKey:@"receiptDate"];
                        
                        slstoragemanagementmodel.storageType = [[twoarray objectAtIndex:i]objectForKey:@"storageType"];
                        //                    slstoragemanagementmodel.isSelect = true;
                        slstoragemanagementmodel.mtlInName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.mtltypeInName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        slstoragemanagementmodel.qty = [[[twoarray objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[twoarray objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.areaIn = [[twoarray objectAtIndex:i]objectForKey:@"area"];
                        slstoragemanagementmodel.dedAreaIn = [[twoarray objectAtIndex:i]objectForKey:@"dedArea"];
                        slstoragemanagementmodel.heightIn = [[twoarray objectAtIndex:i]objectForKey:@"height"];
                        slstoragemanagementmodel.lengthIn = [[twoarray objectAtIndex:i]objectForKey:@"length"];
                        slstoragemanagementmodel.mtlInId = [[[twoarray objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.mtltypeInId = [[[twoarray objectAtIndex:i]objectForKey:@"mtltype"] integerValue];
                        slstoragemanagementmodel.mtlInName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.mtltypeInName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        slstoragemanagementmodel.preAreaIn = [[twoarray objectAtIndex:i]objectForKey:@"preArea"];
                        slstoragemanagementmodel.widthIn = [[twoarray objectAtIndex:i]objectForKey:@"width"];
                        slstoragemanagementmodel.isbool = false;
                        [twotemp addObject:slstoragemanagementmodel];
                    }
                    //if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                        weakSelf.customHeaderArray = [weakSelf changeArrayRule:temp];
                        [weakSelf setCustomTableviewHeaderView];
                        weakSelf.headerArray = [weakSelf changeArrayRule:twotemp];
                    //}else{
                    
                    //}
                }else{
                    
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
                        //                    slstoragemanagementmodel.isSelect = true;
                        
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        slstoragemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                        slstoragemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                        
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.areaIn = [[array objectAtIndex:i]objectForKey:@"areaIn"];
                        slstoragemanagementmodel.dedAreaIn = [[array objectAtIndex:i]objectForKey:@"dedAreaIn"];
                        slstoragemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                        slstoragemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                        slstoragemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"] integerValue];
                        slstoragemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"] integerValue];
                        slstoragemanagementmodel.preAreaIn = [[array objectAtIndex:i]objectForKey:@"preAreaIn"];
                        slstoragemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                        slstoragemanagementmodel.isbool = false;
                        [temp addObject:slstoragemanagementmodel];
                    }
                    weakSelf.headerArray = [weakSelf changeArrayRule:temp];
                }
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];
            }else{
                
                _selectBtn.hidden = NO;
                _newSaveBtn.hidden = NO;
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
            _selectBtn.hidden = NO;
            _newSaveBtn.hidden = NO;
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
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        
        for (int i = 0 ; i < self.customHeaderArray.count; i++) {
            NSMutableArray * array = self.customHeaderArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                newArea += [slstoragemanagementmodel.area doubleValue];
                totalNumber += slstoragemanagementmodel.qty;
                newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
            }
        }
        totalTurnsQty = self.customHeaderArray.count;
        totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
        totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
        
    }else{
        for (int i = 0 ; i < self.headerArray.count; i++) {
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                newArea += [slstoragemanagementmodel.area doubleValue];
                totalNumber += slstoragemanagementmodel.qty;
                newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
            }
        }
        totalTurnsQty = self.headerArray.count;
        totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
        totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    }
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    
    NSDictionary * billHeadDict = [NSDictionary dictionary];
    billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"whsName":self.billheadmodel.whsName};
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * tempArray = [NSMutableArray array];
     NSMutableArray * twoArray = [NSMutableArray array];
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        
        for (int i = 0 ; i < self.customHeaderArray.count; i++) {
            NSMutableArray * array = self.customHeaderArray[i];
            for (int j = 0; j < array.count; j++) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                RSSLStoragemanagementModel * slstroagemanagementmodel = array[j];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billid] forKey:@"billid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billdtlid] forKey:@"billdtlid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.did] forKey:@"did"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlId] forKey:@"mtlId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.whsId] forKey:@"whsId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
                
                [dict setObject:slstroagemanagementmodel.storageType forKey:@"storageType"];
                
                
                
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlInId] forKey:@"mtlInId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
                [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"lengthIn"];
                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"widthIn"];
                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"heightIn"];
                [dict setObject:slstroagemanagementmodel.preAreaIn forKey:@"preAreaIn"];
                [dict setObject:slstroagemanagementmodel.dedAreaIn forKey:@"dedAreaIn"];
                [dict setObject:slstroagemanagementmodel.areaIn forKey:@"areaIn"];
                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlInName"];
                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
                
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.storeareaId] forKey:@"storeareaId"];
                [dict setObject:slstroagemanagementmodel.blockNo forKey:@"blockNo"];
                [dict setObject:slstroagemanagementmodel.turnsNo forKey:@"turnsNo"];
                [dict setObject:slstroagemanagementmodel.slNo forKey:@"slNo"];
                [dict setObject:slstroagemanagementmodel.receiptDate forKey:@"receiptDate"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.qty] forKey:@"qty"];
                [dict setObject:slstroagemanagementmodel.length forKey:@"length"];
                [dict setObject:slstroagemanagementmodel.width forKey:@"width"];
                [dict setObject:slstroagemanagementmodel.height forKey:@"height"];
                [dict setObject:slstroagemanagementmodel.preArea forKey:@"preArea"];
                [dict setObject:slstroagemanagementmodel.dedArea forKey:@"dedArea"];
                [dict setObject:slstroagemanagementmodel.area forKey:@"area"];
                [dict setObject:slstroagemanagementmodel.mtlName forKey:@"mtlName"];
                [dict setObject:slstroagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
                [tempArray addObject:dict];
                
            }
        }
    }else{
        
        for (int i = 0 ; i < self.headerArray.count; i++) {
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                RSSLStoragemanagementModel * slstroagemanagementmodel = array[j];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billid] forKey:@"billid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billdtlid] forKey:@"billdtlid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.did] forKey:@"did"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlId] forKey:@"mtlId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.whsId] forKey:@"whsId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
                
                [dict setObject:slstroagemanagementmodel.storageType forKey:@"storageType"];
                
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlInId] forKey:@"mtlInId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
                
                [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"lengthIn"];
                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"widthIn"];
                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"heightIn"];
                [dict setObject:slstroagemanagementmodel.preAreaIn forKey:@"preAreaIn"];
                [dict setObject:slstroagemanagementmodel.dedAreaIn forKey:@"dedAreaIn"];
                [dict setObject:slstroagemanagementmodel.areaIn forKey:@"areaIn"];
                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlInName"];
                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
                
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.storeareaId] forKey:@"storeareaId"];
                [dict setObject:slstroagemanagementmodel.blockNo forKey:@"blockNo"];
                [dict setObject:slstroagemanagementmodel.turnsNo forKey:@"turnsNo"];
                [dict setObject:slstroagemanagementmodel.slNo forKey:@"slNo"];
                [dict setObject:slstroagemanagementmodel.receiptDate forKey:@"receiptDate"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.qty] forKey:@"qty"];
                [dict setObject:slstroagemanagementmodel.length forKey:@"length"];
                [dict setObject:slstroagemanagementmodel.width forKey:@"width"];
                [dict setObject:slstroagemanagementmodel.height forKey:@"height"];
                [dict setObject:slstroagemanagementmodel.preArea forKey:@"preArea"];
                [dict setObject:slstroagemanagementmodel.dedArea forKey:@"dedArea"];
                [dict setObject:slstroagemanagementmodel.area forKey:@"area"];
                [dict setObject:slstroagemanagementmodel.mtlName forKey:@"mtlName"];
                [dict setObject:slstroagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
                
                [tempArray addObject:dict];
            }
        }
    }
    
    
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
        /**
         单据ID    billid    Int    关联表头
         明细ID    billdtlid    Int
         库存标识    did    Int    和复制的明细1的DID相同
         物料ID    mtlId    Int
         仓库ID    whsId    Int
         物料类别ID    mtltypeId    Int
         入库类型    storageType    Sting    见  入库类型枚举类
         库区ID    storeareaId    Int     -1
         荒料号    blockNo    String
         匝号    turnsNo    String
         板号    slNo    String
         入库日期    receiptDate    Sting    yyyy-MM-dd
         数量    qty    Int    默认1
         长    length    Decimal    1 位
         宽    width    Decimal    1 位
         厚    height    Decimal    2 位
         原始面积    preArea    Decimal    3位
         扣尺面积    dedArea    Decimal    3位
         实际面积    area    Decimal    3位
         库区名称    storeareaName    String
         物料类别名称    mtltypeName    String
         物料名称    mtlName    String
         */
        for (int i = 0 ; i < self.headerArray.count; i++) {
            NSMutableArray * array = self.headerArray[i];
            for (int j = 0; j < array.count; j++) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                RSSLStoragemanagementModel * slstroagemanagementmodel = array[j];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billid] forKey:@"billid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.billdtlid] forKey:@"billdtlid"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.did] forKey:@"did"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlId] forKey:@"mtlId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.whsId] forKey:@"whsId"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
                
                [dict setObject:slstroagemanagementmodel.storageType forKey:@"storageType"];
                
                
                
                
                //                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtlInId] forKey:@"mtlInId"];
                //                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.mtltypeInId] forKey:@"mtltypeInId"];
                //                [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"lengthIn"];
                //                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"widthIn"];
                //                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"heightIn"];
                //                [dict setObject:slstroagemanagementmodel.preareaIn forKey:@"preareaIn"];
                //                [dict setObject:slstroagemanagementmodel.dedareaIn forKey:@"dedareaIn"];
                //                [dict setObject:slstroagemanagementmodel.areaIn forKey:@"areaIn"];
                //                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlInName"];
                //                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeInName"];
                //
                
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.storeareaId] forKey:@"storeareaId"];
                [dict setObject:slstroagemanagementmodel.blockNo forKey:@"blockNo"];
                [dict setObject:slstroagemanagementmodel.turnsNo forKey:@"turnsNo"];
                [dict setObject:slstroagemanagementmodel.slNo forKey:@"slNo"];
                [dict setObject:slstroagemanagementmodel.receiptDate forKey:@"receiptDate"];
                [dict setObject:[NSNumber numberWithInteger:slstroagemanagementmodel.qty] forKey:@"qty"];
                [dict setObject:slstroagemanagementmodel.lengthIn forKey:@"length"];
                [dict setObject:slstroagemanagementmodel.widthIn forKey:@"width"];
                [dict setObject:slstroagemanagementmodel.heightIn forKey:@"height"];
                [dict setObject:slstroagemanagementmodel.preAreaIn forKey:@"preArea"];
                [dict setObject:slstroagemanagementmodel.dedAreaIn forKey:@"dedArea"];
                [dict setObject:slstroagemanagementmodel.areaIn forKey:@"area"];
                [dict setObject:slstroagemanagementmodel.mtlInName forKey:@"mtlName"];
                [dict setObject:slstroagemanagementmodel.mtltypeInName forKey:@"mtltypeName"];
                
                [twoArray addObject:dict];
            }
        }
    }
    [phoneDict setObject:tempArray forKey:@"billDtl"];
    [phoneDict setObject:twoArray forKey:@"billDtl2"];
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
                if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                    [weakSelf.customHeaderArray removeAllObjects];
                    [weakSelf.headerArray removeAllObjects];
                }else{
                    [weakSelf.headerArray removeAllObjects];
                }
                
                weakSelf.billheadmodel.abType = json[@"data"][@"billHead"][@"abType"];
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
                
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                
                if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
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
                        //                    slstoragemanagementmodel.isSelect = true;
                        
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        
                        slstoragemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                        slstoragemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                        
                        
                        
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.areaIn = [[array objectAtIndex:i]objectForKey:@"areaIn"];
                        slstoragemanagementmodel.dedAreaIn = [[array objectAtIndex:i]objectForKey:@"dedAreaIn"];
                        slstoragemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                        slstoragemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                        slstoragemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"] integerValue];
                        slstoragemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"] integerValue];
                        slstoragemanagementmodel.preAreaIn = [[array objectAtIndex:i]objectForKey:@"preAreaIn"];
                        slstoragemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                        slstoragemanagementmodel.isbool = false;
                        [temp addObject:slstoragemanagementmodel];
                    }
                    NSMutableArray * twotemp = [NSMutableArray array];
                    NSMutableArray * twoarray = [NSMutableArray array];
                    twoarray = json[@"data"][@"billDtl2"];
                    for (int i = 0; i < twoarray.count; i++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        slstoragemanagementmodel.billdtlid = [[[twoarray objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                        slstoragemanagementmodel.billid = [[[twoarray objectAtIndex:i]objectForKey:@"billid"] integerValue];
                        slstoragemanagementmodel.blockNo = [[twoarray objectAtIndex:i]objectForKey:@"blockNo"];
                        slstoragemanagementmodel.mtlName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.storeareaId = [[[twoarray objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                        slstoragemanagementmodel.mtltypeName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        slstoragemanagementmodel.mtltypeId = [[[twoarray objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                        slstoragemanagementmodel.mtlId = [[[twoarray objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.turnsNo = [[twoarray objectAtIndex:i]objectForKey:@"turnsNo"];
                        slstoragemanagementmodel.slNo = [[twoarray objectAtIndex:i]objectForKey:@"slNo"];
                        slstoragemanagementmodel.length =  [[twoarray objectAtIndex:i]objectForKey:@"length"];
                        slstoragemanagementmodel.width = [[twoarray objectAtIndex:i]objectForKey:@"width"];
                        slstoragemanagementmodel.height = [[twoarray objectAtIndex:i]objectForKey:@"height"];
                        /**实际面积*/
                        slstoragemanagementmodel.area = [[twoarray objectAtIndex:i]objectForKey:@"area"];
                        /**扣尺面积*/
                        slstoragemanagementmodel.dedArea = [[twoarray objectAtIndex:i]objectForKey:@"dedArea"];
                        /**原始面积*/
                        slstoragemanagementmodel.preArea = [[twoarray objectAtIndex:i]objectForKey:@"preArea"];
                        slstoragemanagementmodel.did = [[[twoarray objectAtIndex:i]objectForKey:@"did"] integerValue];
                        slstoragemanagementmodel.receiptDate = [[twoarray objectAtIndex:i]objectForKey:@"receiptDate"];
                        
                        slstoragemanagementmodel.storageType = [[twoarray objectAtIndex:i]objectForKey:@"storageType"];
                        //                    slstoragemanagementmodel.isSelect = true;
                        
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        
                        slstoragemanagementmodel.mtlInName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.mtltypeInName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        
                        
                        slstoragemanagementmodel.qty = [[[twoarray objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[twoarray objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.areaIn = [[twoarray objectAtIndex:i]objectForKey:@"area"];
                        slstoragemanagementmodel.dedAreaIn = [[twoarray objectAtIndex:i]objectForKey:@"dedArea"];
                        slstoragemanagementmodel.heightIn = [[twoarray objectAtIndex:i]objectForKey:@"height"];
                        slstoragemanagementmodel.lengthIn = [[twoarray objectAtIndex:i]objectForKey:@"length"];
                        slstoragemanagementmodel.mtlInId = [[[twoarray objectAtIndex:i]objectForKey:@"mtlIn"] integerValue];
                        slstoragemanagementmodel.mtltypeInId = [[[twoarray objectAtIndex:i]objectForKey:@"mtltype"] integerValue];
                        slstoragemanagementmodel.mtlInName = [[twoarray objectAtIndex:i]objectForKey:@"mtlName"];
                        slstoragemanagementmodel.mtltypeInName = [[twoarray objectAtIndex:i]objectForKey:@"mtltypeName"];
                        slstoragemanagementmodel.preAreaIn = [[twoarray objectAtIndex:i]objectForKey:@"preArea"];
                        slstoragemanagementmodel.widthIn = [[twoarray objectAtIndex:i]objectForKey:@"width"];
                        slstoragemanagementmodel.isbool = false;
                        [twotemp addObject:slstoragemanagementmodel];
                    }
                    //if ([weakSelf.currentSelectBtn.currentTitle isEqualToString:@"断裂处理"]) {
                    weakSelf.customHeaderArray = [weakSelf changeArrayRule:temp];
                    [weakSelf setCustomTableviewHeaderView];
                    weakSelf.headerArray = [weakSelf changeArrayRule:twotemp];
                    //}else{
                    
                    //}
                    
                }else{
                    
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
                        //                    slstoragemanagementmodel.isSelect = true;
                        
                        //没有的值
                        //slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                        
                        
                        slstoragemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                        slstoragemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeInName"];
                        
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                        slstoragemanagementmodel.areaIn = [[array objectAtIndex:i]objectForKey:@"areaIn"];
                        slstoragemanagementmodel.dedAreaIn = [[array objectAtIndex:i]objectForKey:@"dedAreaIn"];
                        slstoragemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                        slstoragemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                        slstoragemanagementmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"] integerValue];
                        slstoragemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeInId"] integerValue];
                        slstoragemanagementmodel.preAreaIn = [[array objectAtIndex:i]objectForKey:@"preAreaIn"];
                        slstoragemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                        slstoragemanagementmodel.isbool = false;
                        [temp addObject:slstoragemanagementmodel];
                    }
                    weakSelf.headerArray = [weakSelf changeArrayRule:temp];
                }
                [weakSelf.tableview reloadData];
                _selectBtn.hidden = YES;
                _newSaveBtn.hidden = YES;
                _timeBtn.hidden = YES;
                _editSureView.hidden = NO;
                _deleteBtn.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
               
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.tableview reloadData];
            }else{

                _selectBtn.hidden = NO;
                _newSaveBtn.hidden = NO;
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

            _selectBtn.hidden = NO;
            _newSaveBtn.hidden = NO;
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



@end
