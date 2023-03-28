//
//  CustomMyPickerView.m
//  pickerText
//
//  Created by ios3 on 16/7/8.
//  Copyright © 2016年 ios3. All rights reserved.
//

#import "CustomMyPickerView.h"
#import "ViewController.h"
#import "DatePickerView.h"
#define BG_COLOR_RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//#define SCREEN_WIGHT  [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CustomMyPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource,DatePickerViewDelegate>
{
    //显示年，月，日
    DatePickerView * _datePickerView;
}


// pickerview  创建
@property (nonatomic ,strong)UIView *toolsView;


//@property (nonatomic ,strong)NSArray *componentArray;
@property (nonatomic ,strong)NSArray *titleArray;

//用来存年，月，日
@property (nonatomic,strong)NSString * tempStr;

// selectedRow = 0
//选中的时候变颜色
@property (nonatomic,assign)NSInteger selectedRow;

@end

@implementation CustomMyPickerView

/*!
 *  初始化选择器
 *
 *  @param ComponentDataArray 第一区 显示的数据
 *  @param titleDataArray     第二区 显示的数据
 *
 *  @return 返回自己
 */
- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray titleDataArray:(NSArray *)titleDataArray
{
    self = [super init];
    if (self)
    {
        self.componentArray = ComponentDataArray;
        self.titleArray = titleDataArray;
        self.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar);
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//        }];
        _tempStr = [self getCurrentTime];
        DatePickerView *datePickerView = [[DatePickerView alloc]initWithFrame:CGRectMake(SCW/2 - 135, 100, 270, 250) withTimeShowMode:ShowTimeAfterToday withIsShowTodayDate:YES];
        _datePickerView = datePickerView;
        datePickerView.backgroundColor = [UIColor whiteColor];
        datePickerView.delegate = self;
        [self addSubview:datePickerView];
        _datePickerView.hidden = YES;
        
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, SCH - 244 - Height_NavBar, SCW, 44)];
        _toolsView.backgroundColor = BG_COLOR_RGB(248, 248, 248);
        [self addSubview:_toolsView];

        // 右边确定按钮
        UIButton *rightSureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        rightSureBtn.frame = CGRectMake(SCW - 54, 0, 44, 44);
        [rightSureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightSureBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:rightSureBtn];
        
        // 中间显示  label
        UIButton * timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(54, 0 , SCW - 2 * 54, 44)];
//        timeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //titleLabel.text = @"选择类型";
        [timeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [timeBtn setTitle:[NSString stringWithFormat:@"%@",_tempStr] forState:UIControlStateNormal];
        [timeBtn addTarget:self action:@selector(choiceYearAndMonthAndDay:) forControlEvents:UIControlEventTouchUpInside];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_toolsView addSubview:timeBtn];
        _timeBtn = timeBtn;
        
        // 左边取消按钮
        UIButton *leftCancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftCancleButton.frame = CGRectMake(10, 0, 44, 44);
        [leftCancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftCancleButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:leftCancleButton];
        
        
        _picerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCH - 200 - Height_NavBar, SCW, 200)];
        _picerView.dataSource = self;
        _picerView.delegate = self;
        [_picerView selectRow:0 inComponent:0 animated:YES];
        _picerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_picerView];
    }
    return self;
}
#pragma mark -- 选择年，月，日
- (void)choiceYearAndMonthAndDay:(UIButton *)btn{
    _datePickerView.hidden = NO;
}
#pragma mark -- 获取当前时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
#pragma mark -  左边按钮 方法  取消
- (void)leftButtonClick:(UIButton *)button
{
    [self thisWayIsDissmisssSelf];
}
#pragma mark -  右边按钮  方法
- (void)rightButtonClick:(UIButton *)button
{
    [self setDataValue];
    if (self.getPickerValue)
    {
        self.titleString = _tempStr;
        self.getPickerValue(self.componentString,self.titleString);
    }
    [self thisWayIsDissmisssSelf];
}
#pragma mark - 赋值
- (void)setDataValue
{
    if ([self.componentString isEqualToString:@""] || self.componentString == NULL)
    {
        self.componentString = self.componentArray[0];
    }
    if ([self.titleString isEqualToString:@""]||self.titleString == NULL)
    {
        self.titleString = self.titleArray[0];
    }
}
#pragma mark -  数据源方法
//FIXME:设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.componentArray.count == 0 || self.titleArray.count == 0)
    {
        return 1;
    }
    else if (self.componentArray.count == 0 && self.titleArray.count == 0)
    {
        return 0;
    }
    else
    {
        return 2;
    }
}
//FIXME:设置指定列包含的项数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.componentArray.count;
    }
    else
    {
        return self.titleArray.count;
    }
}
//FIXME:设置每个选项显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if (component == 0)
    {
        return self.componentArray[row];
    }
    else
    {
        return self.titleArray[row];
    }
}

#pragma mark - DatePickerViewDelegate
- (void)DatePickerView:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day withDate:(NSString *)date withTag:(NSInteger)tag{
    _datePickerView.hidden = YES;
    
    //[self thisWayIsDissmisssSelf];
    
    if (![date isEqualToString:@"取消"]) {
        [_timeBtn setTitle:[NSString stringWithFormat:@"%@",date] forState:UIControlStateNormal];
        _tempStr = date;
        if ([self.delegate respondsToSelector:@selector(compareTime:)]) {
            [self.delegate compareTime:date];
        }
    }else{
       // NSLog(@"取消");
    }
}



#pragma mark -  代理方法
//FIXME:获取用户当前选中的选项
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedRow = row;
    if (component == 0)
    {
        self.componentString = self.componentArray[row];
        self.valueString = self.componentArray[row];
    }
    else
    {
        self.titleString = self.titleArray[row];
    }
    //刷新所有的组
    [self.picerView reloadAllComponents];
}

//FIXME:返回的是一个UIView对象，所以可选就很多了，比如实现“国旗”选择器，放国家的图片、或者字体的颜色等需要重新定义的可以用UILable 等等
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    if (row == _selectedRow)
    {
        pickerLabel.textColor = [UIColor blueColor];
    }
    else
    {
        pickerLabel.textColor = [UIColor blackColor];
    }
    return pickerLabel;
}

#pragma mark - 
#pragma mark - 屏幕点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self thisWayIsDissmisssSelf];
}


#pragma mark -
#pragma mark - 消失的方法
- (void)thisWayIsDissmisssSelf
{
    __weak typeof (self)weakSelf = self;
    __weak typeof(UIView *)blockView = _toolsView;
    __weak typeof(UIPickerView *)blockPickerViwe = _picerView;
    [UIView animateWithDuration:0.3 animations:^{
        blockView.frame = CGRectMake(0, SCH, SCW, 44);
        blockPickerViwe.frame = CGRectMake(0, SCH, SCW, 200);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
