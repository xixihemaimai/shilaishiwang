//
//  RSServiceChoiceRightView.m
//  石来石往
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceChoiceRightView.h"

#import "RSShaiXuanFristCell.h"
#import "RSShaiXuanSecondCell.h"
#import "RSServiceChoiceRightSecondCell.h"
#import "RSServiceChoiceCustomButton.h"
#import "JXPopoverView.h"

@interface RSServiceChoiceRightView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>




@end

@implementation RSServiceChoiceRightView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        _tableview = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableview];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 75)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, self.bounds.size.width, 17)];
        label.text = @"筛选";
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        
        UILabel * bottomlabel = [[UILabel alloc]init];
        bottomlabel.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
        [view addSubview:bottomlabel];
        
        bottomlabel.sd_layout
        .leftSpaceToView(view, 0)
        .rightSpaceToView(view, 0)
        .bottomSpaceToView(view, 0)
        .heightIs(1);
        
        _tableview.tableHeaderView = view;
        
        
        
        UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 83)];
        bottomview.backgroundColor = [UIColor whiteColor];
        
        
        
        
        //重置
        UIButton * resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(37, 49, 90, 34)];
        [resetBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D6D6D6"]];
        resetBtn.layer.cornerRadius = 17;
        resetBtn.layer.masksToBounds = YES;
        [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
       [resetBtn addTarget:self action:@selector(serviceChoiceDetailOfChargesReData:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [bottomview addSubview:resetBtn];
        
        
        
        
        UIButton * shangBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(resetBtn.frame) + 19, 49,90, 34)];
        
        [shangBtn setTitle:@"确定" forState:UIControlStateNormal];
        [shangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shangBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        [bottomview addSubview:shangBtn];
        shangBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        shangBtn.layer.cornerRadius = 17;
        shangBtn.layer.masksToBounds = YES;
        [shangBtn addTarget:self action:@selector(serviceChoiceDetailOfChargesDetermine:) forControlEvents:UIControlEventTouchUpInside];
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
        NSDate *monthagoData = [self getPriousorLaterDateFromDate:currentDate withMonth:-1];
        NSString *beforeString = [dateFormatter stringFromDate:monthagoData];
        _starTime = beforeString;
        _endTime = currentDateString;
        _people = @"";
        _statusStr = @"0";
        _serviceType = @"";
        
        _tableview.tableFooterView = bottomview;
    }
    return self;
}


//FIXME:重置
- (void)serviceChoiceDetailOfChargesReData:(UIButton *)btn{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    NSInteger sections = self.tableview.numberOfSections;
    for (int section = 0; section < sections; section++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        if (indexPath.section == 0) {
            RSShaiXuanFristCell * cell  = [self.tableview cellForRowAtIndexPath:indexPath];
            NSDate *monthagoData = [self getPriousorLaterDateFromDate:currentDate withMonth:-1];
            NSString *beforeString = [dateFormatter stringFromDate:monthagoData];
            [cell.fristBtn setTitle:[NSString stringWithFormat:@"%@",beforeString] forState:UIControlStateNormal];
            [cell.secondBtn setTitle:[NSString stringWithFormat:@"%@",currentDateString] forState:UIControlStateNormal];
            _starTime = beforeString;
            _endTime = currentDateString;
        }else if (indexPath.section == 1){
            RSShaiXuanSecondCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
            cell.namefield.text = @"";
            cell.namefield.placeholder = @"";
            _people = @"";
        }else if(indexPath.section == 2){
            RSServiceChoiceRightSecondCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
            [cell.statusBtn setTitle:[NSString stringWithFormat:@"未受理"] forState:UIControlStateNormal];
            _statusStr = @"0";
        }else{
            RSServiceChoiceRightSecondCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
            [cell.statusBtn setTitle:[NSString stringWithFormat:@"全部"] forState:UIControlStateNormal];
            _serviceType = @"";
        }
    }
    //这边要做一个代理的方式
    if ([self.delegate respondsToSelector:@selector(showChoiceMyServiceStyleStarTime:andEndTime:andApplicant:andStatus: andServiceType:)]) {
        [self.delegate showChoiceMyServiceStyleStarTime:_starTime andEndTime:_endTime andApplicant:_people andStatus:_statusStr andServiceType:_serviceType];
    }
    
    
}
//FIXME:确定
- (void)serviceChoiceDetailOfChargesDetermine:(UIButton *)btn{
    
    if ([_starTime isEqualToString:@""]) {
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //NSDate转NSString
        NSDate *monthagoData = [self getPriousorLaterDateFromDate:currentDate withMonth:-1];
        NSString *beforeString = [dateFormatter stringFromDate:monthagoData];
        _starTime = beforeString;
    }
    if ([_endTime isEqualToString:@""]) {
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
        _endTime = currentDateString;
    }
    if ([_people isEqualToString:@""]) {
        
        _people = @"";
        
    }
    
    if ([_statusStr isEqualToString:@"0"]) {
        _statusStr = @"0";
    }
    
    if ([_serviceType isEqualToString:@""]) {
        _serviceType = @"";
    }
    //这边要做一个代理的方式
    if ([self.delegate respondsToSelector:@selector(showChoiceMyServiceStyleStarTime:andEndTime:andApplicant:andStatus: andServiceType:)]) {
        [self.delegate showChoiceMyServiceStyleStarTime:_starTime andEndTime:_endTime andApplicant:_people andStatus:_statusStr andServiceType:_serviceType];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if(section == 2){
        return 1;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * SERVICERIGHTID = @"SERVICERIGHTID";
        RSShaiXuanFristCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICERIGHTID];
        if (!cell) {
            cell = [[RSShaiXuanFristCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICERIGHTID];
        }
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
        
        NSDate *monthagoData = [self getPriousorLaterDateFromDate:currentDate withMonth:-1];
        NSString *beforeString = [dateFormatter stringFromDate:monthagoData];
        
        [cell.fristBtn setTitle:[NSString stringWithFormat:@"%@",beforeString] forState:UIControlStateNormal];
        [cell.secondBtn setTitle:[NSString stringWithFormat:@"%@",currentDateString] forState:UIControlStateNormal];
       [cell.fristBtn addTarget:self action:@selector(serviceChoicefristSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondBtn addTarget:self action:@selector(serviceChoicesecondSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 1){
        static NSString * SERVICESECONDRIGHTID = @"SERVICESECONDRIGHTID";
        RSShaiXuanSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICESECONDRIGHTID];
        if (!cell) {
            cell = [[RSShaiXuanSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICESECONDRIGHTID];
        }
        cell.nameLabel.text = @"申请人:";
        cell.namefield.placeholder = @"";
        _people = @"";
        cell.namefield.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.namefield addTarget:self action:@selector(serviceApplicant:) forControlEvents:UIControlEventEditingChanged];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        //这边是选择状态
        
        
        static NSString * SERVICESCHOICESERONDECONDRIGHTID = @"SERVICESCHOICESERONDECONDRIGHTID";
        RSServiceChoiceRightSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICESCHOICESERONDECONDRIGHTID];
        if (!cell) {
            cell = [[RSServiceChoiceRightSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICESCHOICESERONDECONDRIGHTID];
        }
        cell.nameLabel.text = @"目前状态:";
        [cell.statusBtn addTarget:self action:@selector(serviceTypestatusChoice:) forControlEvents:UIControlEventTouchUpInside];
        [cell.statusBtn setTitle:@"未受理" forState:UIControlStateNormal];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        
        static NSString * SERVICETYPECHOICERIGHTSECONDID = @"SERVICETYPECHOICERIGHTSECONDID";
        RSServiceChoiceRightSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICETYPECHOICERIGHTSECONDID];
        if (!cell) {
            cell = [[RSServiceChoiceRightSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICETYPECHOICERIGHTSECONDID];
        }
        cell.nameLabel.text = @"服务类型:";
        [cell.statusBtn addTarget:self action:@selector(statusChoice:) forControlEvents:UIControlEventTouchUpInside];
        [cell.statusBtn setTitle:@"全部" forState:UIControlStateNormal];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}





- (void)serviceApplicant:(UITextField *)namefiled{
    NSString *tem = [[namefiled.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if ([tem length]!= 0) {
        
        _people = tem;

    }else{
        
        _people = @"";
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return ((SCH/568) * 70);
    }else{
        return ((SCH/568) * 60);
    }
    
}

#pragma mark -- 开始时间
- (void)serviceChoicefristSelectTime:(UIButton *)btn{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [btn setTitle:date forState:UIControlStateNormal];
        //起始日期
        _starTime = btn.currentTitle;
    }];
    [datepicker show];
}



//选择状态
- (void)serviceTypestatusChoice:(RSServiceChoiceCustomButton *)btn{
    //serviceStatus    Int    服务状态 0->未受理， 1->已受理 ，2->派遣中， 3->进行中,4->取消服务，5->已完成，全部就传：-1
    JXPopoverView *popoverView = [JXPopoverView popoverView];
    JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"未受理" handler:^(JXPopoverAction *action) {
        [btn setTitle:@"未受理" forState:UIControlStateNormal];
        _statusStr = @"0";
    }];
    JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"已受理" handler:^(JXPopoverAction *action) {
        [btn setTitle:@"已受理" forState:UIControlStateNormal];
          _statusStr = @"1";
    }];
    JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"派遣中" handler:^(JXPopoverAction *action) {
        
        [btn setTitle:@"派遣中" forState:UIControlStateNormal];
          _statusStr = @"2";
    }];
    JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"进行中" handler:^(JXPopoverAction *action) {
        
        [btn setTitle:@"进行中" forState:UIControlStateNormal];
          _statusStr = @"3";
    }];
    JXPopoverAction *action5 = [JXPopoverAction actionWithTitle:@"取消服务" handler:^(JXPopoverAction *action) {
        
        [btn setTitle:@"取消服务" forState:UIControlStateNormal];
        _statusStr = @"4";
    }];
    JXPopoverAction *action6 = [JXPopoverAction actionWithTitle:@"已完成" handler:^(JXPopoverAction *action) {
        [btn setTitle:@"已完成" forState:UIControlStateNormal];
          _statusStr = @"5";
    }];
    
    JXPopoverAction *action7 = [JXPopoverAction actionWithTitle:@"全部" handler:^(JXPopoverAction *action) {
        [btn setTitle:@"全部" forState:UIControlStateNormal];
        _statusStr = @"-1";
    }];
    
    [popoverView showToView:btn withActions:@[action1,action2,action3,action4,action5,action6,action7]];
}


//服务类型
- (void)statusChoice:(UIButton *)serviceTypeBtn{
    
    JXPopoverView *popoverView = [JXPopoverView popoverView];
    JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"全部" handler:^(JXPopoverAction *action) {
        [serviceTypeBtn setTitle:@"全部" forState:UIControlStateNormal];
        _serviceType = @"";
    }];
    JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"出库服务" handler:^(JXPopoverAction *action) {
        [serviceTypeBtn setTitle:@"出库服务" forState:UIControlStateNormal];
        _serviceType = @"ckfw";
    }];
    JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"市场服务" handler:^(JXPopoverAction *action) {
        
        [serviceTypeBtn setTitle:@"市场服务" forState:UIControlStateNormal];
        _serviceType = @"scfw";
    }];
    [popoverView showToView:serviceTypeBtn withActions:@[action1,action2,action3]];
    
    
}

//获取前一个月
-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}


#pragma mark -- 停止时间
- (void)serviceChoicesecondSelectTime:(UIButton *)btn{
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        
        [btn setTitle:date forState:UIControlStateNormal];
        //停止时间        
        _endTime = btn.currentTitle;
    }];
    [datepicker show];
}



@end
