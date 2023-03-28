//
//  RSFactoryFromMenuView.m
//  石来石往
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSFactoryFromMenuView.h"
#import "MenuItemView.h"


@interface RSFactoryFromMenuView()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    //开始时间
    UIButton * _beginTime;
    //结束时间
    UIButton * _endTime;
    //物料号
    UITextView * _wuliaotextView;
    //荒料号
    UITextView * _blockTextView;
    //仓库
    MenuItemView * _warehouseView;
    //加工厂
    MenuItemView * _factoryView;
}

@property (nonatomic,strong)UITableView * tableview;

@end


@implementation RSFactoryFromMenuView

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW - 91, SCH) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        
    }
    return _tableview;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.tableview];
        [IQKeyboardManager sharedManager].enable = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setUI];
        });
    }
    return self;
}


- (void)setUI{
    UIView * headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UILabel * luLabel = [[UILabel alloc]init];
    luLabel.text = @"加工时间";
    luLabel.textAlignment = NSTextAlignmentLeft;
    luLabel.font = [UIFont systemFontOfSize:16];
    luLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:luLabel];
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        luLabel.frame = CGRectMake(24, 10, 66, 23);
    }else{
        
        luLabel.frame = CGRectMake(24, 10, 66, 23);
    }
    //开始时间
    UIButton * beginTime = [UIButton buttonWithType:UIButtonTypeCustom];
    beginTime.frame = CGRectMake(24, CGRectGetMaxY(luLabel.frame) + 5, 101, 30);
    [beginTime setTitle:@"2019-01-03" forState:UIControlStateNormal];
    [beginTime setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
    beginTime.layer.cornerRadius = 17;
    [beginTime setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    beginTime.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerview addSubview:beginTime];
    [beginTime addTarget:self action:@selector(firstChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    _beginTime = beginTime;
    
    //中间的横线
    UIView * hengView = [[UIView alloc]init];
    hengView.frame = CGRectMake(CGRectGetMaxX(beginTime.frame) + 8, 50, 14, 2);
    hengView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
    [headerview addSubview:hengView];
    
    
    //结束时间
    UIButton * endTime = [UIButton buttonWithType:UIButtonTypeCustom];
    endTime.frame = CGRectMake(CGRectGetMaxX(hengView.frame) + 8,  CGRectGetMaxY(luLabel.frame) + 5, 101, 30);
    [endTime setTitle:@"2019-01-03" forState:UIControlStateNormal];
    [endTime setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
    endTime.layer.cornerRadius = 17;
    [endTime setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    endTime.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerview addSubview:endTime];
    [endTime addTarget:self action:@selector(secondChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    _endTime = endTime;
    [self showDisplayTheTimeToSelectTime:beginTime andSecondTime:endTime];
    
    
    
    
    
    //物料名称
    UILabel * wuliaoLabel = [[UILabel alloc]init];
    
    if ([self.menuType isEqualToString:@"2"]) {
        luLabel.hidden = YES;
        beginTime.hidden = YES;
        hengView.hidden = YES;
        endTime.hidden = YES;
        
        
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            
            wuliaoLabel.frame = CGRectMake(24, 10, 66, 23);
            
        }else{
            
            wuliaoLabel.frame = CGRectMake(24, 10, 66, 23);
        }
        
    }else{
        
        
        luLabel.hidden = NO;
        beginTime.hidden = NO;
        hengView.hidden = NO;
        endTime.hidden = NO;
         wuliaoLabel.frame = CGRectMake(24, CGRectGetMaxY(beginTime.frame) + 10, 66, 23);
    }
    
    
    
    wuliaoLabel.text = @"物料名称";
   
    wuliaoLabel.textAlignment = NSTextAlignmentLeft;
    wuliaoLabel.font = [UIFont systemFontOfSize:16];
    wuliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:wuliaoLabel];
    
    //内容
    UITextView * wuliaotextView = [[UITextView alloc]init];
    wuliaotextView.frame = CGRectMake(24, CGRectGetMaxY(wuliaoLabel.frame) + 5,SCW - 91 - 48, 30);
    //wuliaoTextfield.placeholder = @"请输入物料名称";
    wuliaotextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    wuliaotextView.layer.cornerRadius = 17;
    [headerview addSubview:wuliaotextView];
    wuliaotextView.returnKeyType = UIReturnKeyDone;
    wuliaotextView.delegate = self;
    _wuliaotextView = wuliaotextView;
    
    //荒料号
    UILabel * blockLabel = [[UILabel alloc]init];
    blockLabel.text = @"荒料号";
    blockLabel.frame = CGRectMake(24, CGRectGetMaxY(wuliaotextView.frame) + 10, 66, 23);
    blockLabel.textAlignment = NSTextAlignmentLeft;
    blockLabel.font = [UIFont systemFontOfSize:16];
    blockLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:blockLabel];
    
    //荒料号内容
    UITextView * blockTextView = [[UITextView alloc]init];
    // blockTextfield.placeholder = @"请输入荒料名";
    blockTextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    blockTextView.layer.cornerRadius = 17;
    blockTextView.returnKeyType = UIReturnKeyDone;
    blockTextView.frame = CGRectMake(24, CGRectGetMaxY(blockLabel.frame) + 5, SCW - 91 - 48, 30);
    [headerview addSubview:blockTextView];
    blockTextView.delegate = self;
    _blockTextView = blockTextView;
    
   
    _wuliaotextView.text = @"";
    //所在仓库
//    UILabel * warehousebel = [[UILabel alloc]init];
//    warehousebel.text = @"所在仓库";
//    warehousebel.frame = CGRectMake(24,CGRectGetMaxY(blockTextView.frame) + 10, 66, 23);
//    warehousebel.textAlignment = NSTextAlignmentLeft;
//    warehousebel.font = [UIFont systemFontOfSize:16];
//    warehousebel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//    [headerview addSubview:warehousebel];
//
//    MenuItemView *warehouseView = [[MenuItemView alloc] initWithFrame:CGRectMake(24,CGRectGetMaxY(warehousebel.frame) + 5,  SCW - 91 - 48, 30)];
//    warehouseView.itemText = @"请选出所在仓库";
//    warehouseView.title.text = @"请选出所在仓库";
//    warehouseView.whsId = 0;
//    RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
//    NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
//
//    RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
//    warehousemodel.code = @"";
//    warehousemodel.createTime = @"";
//    warehousemodel.name = @"请选出所在仓库";
//    warehousemodel.updateTime = @"";
//    warehousemodel.whstype = @"";
//    warehousemodel.createUser = 0;
//    warehousemodel.pwmsUserId = 0;
//    warehousemodel.status = 0;
//    warehousemodel.updateUser = 0;
//    warehousemodel.WareHouseID = 0;
//    [warehouseArray insertObject:warehousemodel atIndex:0];
//
//    warehouseView.items = warehouseArray;
//    warehouseView.layer.cornerRadius = 17;
//    warehouseView.layer.masksToBounds = YES;
//    warehouseView.selectType = @"newWareHouse";
//    warehouseView.layer.borderWidth = 1.;
//    warehouseView.layer.borderColor = [UIColor whiteColor].CGColor;
//    warehouseView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
//    [warehouseView setSelectedItemWarehouseBlock:^(NSInteger index, NSString *itemName) {
//        self.wareHouseIndex = index;
//
//    }];
//    _warehouseView = warehouseView;
//    [headerview addSubview:warehouseView];
    
    //所在仓库
    UILabel * factorylabel = [[UILabel alloc]init];
    factorylabel.text = @"加工厂";
    factorylabel.frame = CGRectMake(24,CGRectGetMaxY(blockTextView.frame) + 10, 66, 23);
    factorylabel.textAlignment = NSTextAlignmentLeft;
    factorylabel.font = [UIFont systemFontOfSize:16];
    factorylabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:factorylabel];
    
    
    MenuItemView * factoryView = [[MenuItemView alloc] initWithFrame:CGRectMake(24,CGRectGetMaxY(factorylabel.frame) + 5,  SCW - 91 - 48, 30)];
    factoryView.itemText = @"请选出所在加工厂";
    factoryView.title.text = @"请选出所在加工厂";
    factoryView.whsId = 0;
    RSPersonlPublishDB * db1 = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Factory.sqlite"];
    NSMutableArray * factoryArray = [db1 getAllContent];
    
    RSWarehouseModel * warehousemodel1 = [[RSWarehouseModel alloc]init];
    warehousemodel1.code = @"";
    warehousemodel1.createTime = @"";
    warehousemodel1.name = @"请选出所在加工厂";
    warehousemodel1.updateTime = @"";
    warehousemodel1.whstype = @"";
    warehousemodel1.createUser = 0;
    warehousemodel1.pwmsUserId = 0;
    warehousemodel1.status = 0;
    warehousemodel1.updateUser = 0;
    warehousemodel1.WareHouseID = 0;
    [factoryArray insertObject:warehousemodel1 atIndex:0];
    
    factoryView.items = factoryArray;
    factoryView.layer.cornerRadius = 17;
    factoryView.layer.masksToBounds = YES;
    factoryView.selectType = @"newWareHouse";
    factoryView.layer.borderWidth = 1.;
    factoryView.layer.borderColor = [UIColor whiteColor].CGColor;
    factoryView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    [factoryView setSelectedItemWarehouseBlock:^(NSInteger index, NSString *itemName) {
        self.factoryIndex = index;
    }];
    _factoryView = factoryView;
    [headerview addSubview:factoryView];
    
    
    
    UIView * functionview = [[UIView alloc]init];
    functionview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerview addSubview:functionview];
    
    functionview.frame = CGRectMake((SCW - 91)/2 - 90,CGRectGetMaxY(factoryView.frame) + 35, 180, 36);
    
    if ([self.menuType isEqualToString:@"2"]) {
//        warehousebel.hidden = YES;
//        warehouseView.hidden = YES;
        factorylabel.hidden = YES;
        factoryView.hidden = YES;
    }else{
//        warehousebel.hidden = NO;
//        warehouseView.hidden = NO;
        factorylabel.hidden = NO;
        factoryView.hidden = NO;
    }
    
    

    
    UIButton * reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
    [reloadBtn setTitle:@"重置" forState:UIControlStateNormal];
    [reloadBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [functionview addSubview:reloadBtn];
    [reloadBtn addTarget:self action:@selector(reloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    reloadBtn.frame = CGRectMake(0,0, 90, 36);
    //_reloadBtn = reloadBtn;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:reloadBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(17, 17)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = reloadBtn.bounds;
    reloadBtn.layer.mask = maskLayer;
    
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [functionview addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(reloadBtn.frame),0, 90, 36);
    //_sureBtn = sureBtn;
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:sureBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(17, 17)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.path = maskPath2.CGPath;
    maskLayer1.frame = sureBtn.bounds;
    sureBtn.layer.mask = maskLayer1;
    
    
    functionview.layer.cornerRadius = 17;
    [headerview setupAutoHeightWithBottomView:functionview bottomMargin:30];
    [headerview layoutIfNeeded];
    self.tableview.tableHeaderView = headerview;
}


- (void)showDisplayTheTimeToSelectTime:(UIButton *)firstTimeBtn andSecondTime:(UIButton *)secondTimeBtn{
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    NSString * newBefordate = [beforDate substringToIndex:8];
    newBefordate = [NSString stringWithFormat:@"%@01",newBefordate];
    
    [firstTimeBtn setTitle:newBefordate forState:UIControlStateNormal];
    [secondTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * SELFCELL = @"SELFCELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SELFCELL];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SELFCELL
                ];
    }
    return cell;
}


//开始时间
- (void)firstChangeTimeAction:(UIButton *)beginTime{
    NSDate * date = [self nsstringConversionNSDate:beginTime.currentTitle];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [beginTime setTitle:date forState:UIControlStateNormal];
    }];
    // datepicker.minLimitDate = [self maxtimeString:firstTimeBtn.currentTitle];
    // datepicker.maxLimitDate = [NSDate date];
    [datepicker show];
}


//结束时间
- (void)secondChangeTimeAction:(UIButton *)endTime{
    NSDate * date = [self nsstringConversionNSDate:endTime.currentTitle];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        //结束时间
        [endTime setTitle:date forState:UIControlStateNormal];
        
    }];
    // datepicker.maxLimitDate = [NSDate date];
    // datepicker.minLimitDate = [self currentMinTime];
    [datepicker show];
}


//重置
- (void)reloadBtnAction:(UIButton *)reloadBtn{
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    NSString * newBefordate = [beforDate substringToIndex:8];
    newBefordate = [NSString stringWithFormat:@"%@01",newBefordate];
    [_beginTime setTitle:newBefordate forState:UIControlStateNormal];
    [_endTime setTitle:currentDateString forState:UIControlStateNormal];
    
    _wuliaotextView.text = @"";
    _blockTextView.text = @"";
    
    _warehouseView.itemText = @"";
    _warehouseView.title.text = @"";
    _warehouseView.whsId = 0;
    self.wareHouseIndex = 0;
    
    _factoryView.itemText = @"请选出所在加工厂";
    _factoryView.title.text = @"请选出所在加工厂";
    _factoryView.whsId = 0;
    self.factoryIndex = 0;
    
    [_wuliaotextView resignFirstResponder];
    [_blockTextView resignFirstResponder];
}


//确认
- (void)sureBtnAction:(UIButton *)sureBtn{
    [_wuliaotextView resignFirstResponder];
    [_blockTextView resignFirstResponder];
    
    if (self.showSelectMenu) {
        self.showSelectMenu(self.selectyType, _beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _warehouseView.itemText, self.wareHouseIndex, _factoryView.itemText, self.factoryIndex);
    }
}


-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [_wuliaotextView resignFirstResponder];
        [_blockTextView resignFirstResponder];
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView == _wuliaotextView) {
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
        if ([temp length] < 1){
            _wuliaotextView.text = @"";
            [_wuliaotextView resignFirstResponder];
        }else{
            _wuliaotextView.text = temp;
            [_wuliaotextView resignFirstResponder];
        }
    }else if (textView == _blockTextView){
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
        if ([temp length] < 1){
            _blockTextView.text = @"";
            [_blockTextView resignFirstResponder];
        }else{
            _blockTextView.text = temp;
            [_blockTextView resignFirstResponder];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
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
