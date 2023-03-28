//
//  RSSalertView.m
//  石来石往
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSSalertView.h"
#import "JJOptionView.h"
#import "RSWarehouseModel.h"
@interface RSSalertView()<UITextViewDelegate>
{
    UIButton * _firstTimeBtn;
    
    UIButton * _secondTimeBtn;
    
    UITextView * _firstview;
    
    UITextView * _secondView;
    
    
    JJOptionView * _fristView;
    
    JJOptionView * _secondview;
    
    UILabel * _wareHouseLabel;
    
}
@property(nonatomic,strong)UIView *bgView;


@end


@implementation RSSalertView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
       // [self createView];
        
        [IQKeyboardManager sharedManager].enable = NO;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
        
    }
    return self;
}



-(void)createView
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.clipsToBounds = YES;
    
    if ([self.selectFunctionType isEqualToString:@"采购入库"] || [self.selectFunctionType isEqualToString:@"加工入库"] || [self.selectFunctionType isEqualToString:@"盘盈入库"] || [self.selectFunctionType isEqualToString:@"销售出库"] ||
        [self.selectFunctionType isEqualToString:@"加工出库"] || [self.selectFunctionType isEqualToString:@"盘亏出库"]  ||
        [self.selectFunctionType isEqualToString:@"大板库存余额表"] ||[self.selectFunctionType isEqualToString:@"大板库存流水账"]||[self.selectFunctionType isEqualToString:@"大板入库明细表"]||[self.selectFunctionType isEqualToString:@"大板出库明细表"]||[self.selectFunctionType isEqualToString:@"异常处理"] || [self.selectFunctionType isEqualToString:@"调拨"] ) {
        //这边是荒料入库
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"筛选条件";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        
        if ([self.selectFunctionType isEqualToString:@"销售出库"] ||
            [self.selectFunctionType isEqualToString:@"加工出库"] || [self.selectFunctionType isEqualToString:@"盘亏出库"]  ) {
            timeLabel.text = @"出库时间";
        }else{
            timeLabel.text = @"入库时间";
        }
       
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
//        //获取系统当前时间
//        NSDate *currentDate = [NSDate date];
//        //用于格式化NSDate对象
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        //设置格式：zzz表示时区
//        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//        //NSDate转NSString
//        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];

//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//
//        NSDateComponents *comps = nil;
//
//        comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
//
//        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
//
//        [adcomps setYear:0];
//
//        [adcomps setMonth:-1];
//
//        [adcomps setDay:0];
//        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
//        NSString *beforDate = [dateFormatter stringFromDate:newdate];
//
        
        
        UIButton * firstTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, 101, 34)];
        firstTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [firstTimeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
       // [firstTimeBtn setTitle:beforDate forState:UIControlStateNormal];
        [firstTimeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
        firstTimeBtn.layer.cornerRadius = 17;
        [self addSubview:firstTimeBtn];
        [firstTimeBtn addTarget:self action:@selector(firstChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        _firstTimeBtn = firstTimeBtn;
        
        
        UILabel * hengLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstTimeBtn.frame) + 8, CGRectGetMaxY(timeLabel.frame) + 22, 16, 2)];
        hengLabel.text = @"一";
        hengLabel.textAlignment = NSTextAlignmentCenter;
        hengLabel.font = [UIFont systemFontOfSize:16];
        hengLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        hengLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:hengLabel];
        
        UIButton * secondTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstTimeBtn.frame) + 28, CGRectGetMaxY(timeLabel.frame) + 5, 101, 34)];
        [secondTimeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
//        [secondTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
        [secondTimeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
        secondTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        secondTimeBtn.layer.cornerRadius = 17;
        [self addSubview:secondTimeBtn];
         [secondTimeBtn addTarget:self action:@selector(secondChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        _secondTimeBtn = secondTimeBtn;
        
        
        [self showDisplayTheTimeToSelectTime:firstTimeBtn andSecondTime:secondTimeBtn];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstTimeBtn.frame) + 10, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"物料名称";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //self.firstField.borderStyle = UITextBorderStyleLine;
        firstview.placeholder = @"请输入物料名称";
        if ([self.selectFunctionType isEqualToString:@"采购入库"] || [self.selectFunctionType isEqualToString:@"加工入库"] || [self.selectFunctionType isEqualToString:@"盘盈入库"] || [self.selectFunctionType isEqualToString:@"销售出库"] ||
            [self.selectFunctionType isEqualToString:@"加工出库"] || [self.selectFunctionType isEqualToString:@"盘亏出库"] || [self.selectFunctionType isEqualToString:@"异常处理"] || [self.selectFunctionType isEqualToString:@"调拨"] ) {
            firstview.text = self.wareHouseTypeName;
        }
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstview.zw_placeHolder = @"请输入物料名称";
        firstview.layer.masksToBounds = YES;
        // firstview.delegate =self;
        firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        //self.firstField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"荒料号";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        secondView.zw_placeHolder = @"请输入荒料号";
        // secondView.delegate =self;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        _secondView = secondView;
        _secondView.delegate = self;
        //self.secondField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 47);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"重置" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 13, 1, 23)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
        
    }else if([self.selectFunctionType isEqualToString:@"库存筛选"]){
        //仓库
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"筛选条件";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"仓库";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        
        UILabel * wareHouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(39,CGRectGetMaxY(timeLabel.frame) + 5,  self.bounds.size.width - 78, 34)];
        wareHouseLabel.text = self.wareHouseTypeName;
        wareHouseLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        wareHouseLabel.textAlignment = NSTextAlignmentLeft;
        wareHouseLabel.font = [UIFont systemFontOfSize:15];
        wareHouseLabel.layer.cornerRadius = 17;
        wareHouseLabel.layer.masksToBounds = YES;
        [self addSubview:wareHouseLabel];
        _wareHouseLabel = wareHouseLabel;
//        JJOptionView * fristView = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, self.bounds.size.width - 78, 34)];
//        fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
//        fristView.layer.cornerRadius = 17;
//        fristView.layer.masksToBounds = YES;
//        fristView.title = @"请选择仓库";
//        fristView.selectType = @"newWareHouse";
//        fristView.dataSource = self.typeArray;
//        RSWeakself
//        fristView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
//            weakSelf.index = selectedIndex;
//        };
//        [self addSubview:fristView];
//         _fristView = fristView;
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(wareHouseLabel.frame) + 10, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"物料名称";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //self.firstField.borderStyle = UITextBorderStyleLine;
        
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstview.zw_placeHolder = @"请输入物料名称";
        // firstview.delegate =self;
        firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        //self.firstField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"荒料号";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //secondView.placeholder = @"请输入荒料号";
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        secondView.zw_placeHolder = @"请输入荒料号";
        // secondView.delegate =self;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        //self.secondField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        _secondView = secondView;
        _secondView.delegate = self;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 47);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"重置" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 5, 1, 47)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
    }else if ([self.selectFunctionType isEqualToString:@"添加物料"]){
 
        //添加物料
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"添加物料";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        
        UILabel * nameProductLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 10, self.bounds.size.width, 23)];
        nameProductLabel.textAlignment = NSTextAlignmentLeft;
        nameProductLabel.text = @"物料名称";
        nameProductLabel.font = [UIFont systemFontOfSize:16];
        nameProductLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameProductLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameProductLabel];
        
        UITextView * firstProductview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameProductLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstProductview.placeholder = @"请输入物料名称";
        firstProductview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstProductview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstProductview.layer.cornerRadius = 17;
        firstProductview.layer.masksToBounds = YES;
        // firstview.delegate =self;
        firstProductview.font = [UIFont systemFontOfSize:16];
        firstProductview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstProductview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstProductview];
        _firstview = firstProductview;
        _firstview.delegate = self;
  
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstProductview.frame) + 10, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"物料类型";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        JJOptionView * firstview = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //firstview.titleLabel.text = @"大理石";
        firstview.title = self.materialTypeName;
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入物料名称";
        //firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        //firstview.dataSource = @[@"111",@"222",@"333",@"444",@"555"];
        firstview.selectType = @"type";
        _fristView = firstview;
        firstview.dataSource = self.typeArray;
        RSWeakself
        firstview.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
            weakSelf.index = selectedIndex;
        };
        [self addSubview:firstview];
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"石种颜色";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        JJOptionView * secondview = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        secondview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondview.title = self.materialColorName;
        secondview.layer.cornerRadius = 17;
        secondview.titleLabel.text = @"红色";
        secondview.selectType = @"color";
        secondview.layer.masksToBounds = YES;
        secondview.dataSource = self.colorArray;
        _secondview = secondview;

        secondview.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
            weakSelf.secondIndex = selectedIndex;
        };
        [self addSubview:secondview];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondview.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(0, CGRectGetMaxY(view.frame),  self.bounds.size.width, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(addMaterialAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
        if ([self.selectType isEqualToString:@"new"]) {
             firstProductview.placeholder = self.materialProductName;
        }else{
             firstProductview.text = self.materialProductName;
        }
        
    }else if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]){

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"筛选条件";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"入库时间";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        
        UIButton * firstTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, 101, 34)];
        firstTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [firstTimeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        // [firstTimeBtn setTitle:beforDate forState:UIControlStateNormal];
        [firstTimeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
        firstTimeBtn.layer.cornerRadius = 17;
        [self addSubview:firstTimeBtn];
        [firstTimeBtn addTarget:self action:@selector(firstChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        _firstTimeBtn = firstTimeBtn;
        
        
        UILabel * hengLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstTimeBtn.frame) + 8, CGRectGetMaxY(timeLabel.frame) + 22, 16, 2)];
        hengLabel.text = @"一";
        hengLabel.textAlignment = NSTextAlignmentCenter;
        hengLabel.font = [UIFont systemFontOfSize:16];
        hengLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        hengLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:hengLabel];
        
        UIButton * secondTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstTimeBtn.frame) + 28, CGRectGetMaxY(timeLabel.frame) + 5, 101, 34)];
        [secondTimeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        //        [secondTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
        [secondTimeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
        secondTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        secondTimeBtn.layer.cornerRadius = 17;
        [self addSubview:secondTimeBtn];
        [secondTimeBtn addTarget:self action:@selector(secondChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        _secondTimeBtn = secondTimeBtn;
        [self showDisplayTheTimeToSelectTime:firstTimeBtn andSecondTime:secondTimeBtn];
        

        UILabel * styleLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(secondTimeBtn.frame) + 11, SCW - 78, 23)];
        styleLabel.text = @"入库类型";
        styleLabel.textAlignment = NSTextAlignmentLeft;
        styleLabel.font = [UIFont systemFontOfSize:16];
        styleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        styleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:styleLabel];
        
        
        JJOptionView * fristView = [[JJOptionView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(styleLabel.frame) + 11, self.bounds.size.width - 78, 34)];
        fristView.title = @"采购入库";
        _fristView = fristView;
        
        
        //firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        fristView.layer.cornerRadius = 17;
        fristView.layer.masksToBounds = YES;
        [self addSubview:fristView];
        fristView.dataSource = self.typeArray;
        fristView.selectType = @"ruku";
        RSWeakself
        fristView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
            weakSelf.index = selectedIndex;
        };
        
        UILabel * currentWareHouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(fristView.frame) + 11, SCW - 78 , 23)];
        currentWareHouseLabel.text = @"所在仓库";
        currentWareHouseLabel.textAlignment = NSTextAlignmentLeft;
        currentWareHouseLabel.font = [UIFont systemFontOfSize:16];
        currentWareHouseLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        currentWareHouseLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:currentWareHouseLabel];
        
        JJOptionView * secondview = [[JJOptionView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(currentWareHouseLabel.frame) + 11, self.bounds.size.width - 78, 34)];
        _secondview = secondview;
        secondview.dataSource = self.colorArray;
        //secondview.title = @"请选择仓库";
        //RSWarehouseModel * warehousemodel = self.colorArray[0];
        secondview.title = @"请选择仓库";
        secondview.selectType = @"newWareHouse";
        secondview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondview.layer.cornerRadius = 17;
        secondview.layer.masksToBounds = YES;
        [self addSubview:secondview];
        secondview.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
            weakSelf.secondIndex = selectedIndex;
        };
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(secondview.frame) + 10, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"物料名称";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //self.firstField.borderStyle = UITextBorderStyleLine;
      
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstview.zw_placeHolder = @"请输入物料名称";
        // firstview.delegate =self;
        firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        //self.firstField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"荒料号";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //secondView.placeholder = @"请输入荒料号";
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        secondView.zw_placeHolder = @"请输入荒料号";
        // secondView.delegate =self;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        _secondView = secondView;
        _secondView.delegate = self;
        //self.secondField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 47);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"重置" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 13, 1, 23)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
    
    }else if ([self.selectFunctionType isEqualToString:@"荒料库存筛选"]){
        
        
        //仓库
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"筛选条件";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"仓库";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        
//        UILabel * wareHouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(39,CGRectGetMaxY(timeLabel.frame) + 5,  self.bounds.size.width - 78, 34)];
//        wareHouseLabel.text = self.wareHouseTypeName;
//        wareHouseLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
//        wareHouseLabel.textAlignment = NSTextAlignmentLeft;
//        wareHouseLabel.font = [UIFont systemFontOfSize:15];
//        wareHouseLabel.layer.cornerRadius = 17;
//        wareHouseLabel.layer.masksToBounds = YES;
//        [self addSubview:wareHouseLabel];
//        _wareHouseLabel = wareHouseLabel;
          JJOptionView * fristView = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, self.bounds.size.width - 78, 34)];
          fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
          fristView.layer.cornerRadius = 17;
          fristView.layer.masksToBounds = YES;
          fristView.title = @"请选择仓库";
          fristView.selectType = @"newWareHouse";
          fristView.dataSource = self.typeArray;
          RSWeakself
          fristView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
              
                weakSelf.index = selectedIndex;
          };
          [self addSubview:fristView];
          _fristView = fristView;
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(fristView.frame) + 10, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"物料名称";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入物料名称";
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstview.zw_placeHolder = @"请输入物料名称";
        // firstview.delegate =self;
        firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        //self.firstField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"荒料号";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //secondView.placeholder = @"请输入荒料号";
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        secondView.zw_placeHolder = @"请输入荒料号";
        // secondView.delegate =self;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        //self.secondField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        _secondView = secondView;
        _secondView.delegate = self;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 47);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"重置" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 5, 1, 47)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
    }else if ([self.selectFunctionType isEqualToString:@"添加公司"]){
     
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"添加账号";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"添加申请电话";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 40)];
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入电话";
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0);
        firstview.zw_placeHolder = @"请输入电话";
        // firstview.delegate =self;
        firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"添加申请公司名称";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 40)];
      //  secondView.placeholder = @"请输入公司名称";
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0);
        secondView.zw_placeHolder = @"请输入公司名称";
        // secondView.delegate =self;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        _secondView = secondView;
        _secondView.delegate = self;
        
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(12, CGRectGetMaxY(secondView.frame) + 10, self.bounds.size.width - 24 , 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
  
        
    }else if([self.selectFunctionType isEqualToString:@"修改账号"]){
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"修改账号";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"修改申请电话";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 40)];
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入电话";
        firstview.text = self.materialProductName;
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0);
        firstview.zw_placeHolder = @"请输入电话";
        // firstview.delegate =self;
        firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"修改申请公司名称";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 40)];
       // secondView.placeholder = @"请输入公司名称";
        secondView.text = self.materialTypeName;
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0);
        secondView.zw_placeHolder = @"请输入公司名称";
        // secondView.delegate =self;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        _secondView = secondView;
        _secondView.delegate = self;
        
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(12, CGRectGetMaxY(secondView.frame) + 10, self.bounds.size.width - 24 , 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
        
        
        
        
    }else if ([self.selectFunctionType isEqualToString:@"用户编辑"]){
        
     
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"用户编辑";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"用户账号";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        firstview.editable = NO;
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入物料名称";
        firstview.text = self.materialProductName;
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstview.zw_placeHolder = @"请输入物料名称";
        // firstview.delegate =self;
        firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;

        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"用户角色";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        
        JJOptionView * fristView = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        fristView.layer.cornerRadius = 17;
        fristView.layer.masksToBounds = YES;
        fristView.selectType = @"user";
       // RSRoleModel * rolemodel = self.typeArray[0];
        fristView.title = self.materialColorName;
        fristView.dataSource = self.typeArray;
        RSWeakself
        fristView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
            
            weakSelf.index = selectedIndex;
        };
        [self addSubview:fristView];
        _fristView = fristView;
        
//
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(fristView.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"用户名称";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //secondView.placeholder = @"请输入荒料号";
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.text = self.materialTypeName;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        //firstview.zw_placeHolder = @"请输入物料名称";
        // secondView.delegate =self;
        secondView.editable = NO;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        //self.secondField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        _secondView = secondView;
        _secondView.delegate = self;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
    
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
    }else if ([self.selectFunctionType isEqualToString:@"修改厚度"]){
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"修改厚度";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"修改厚度";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //firstview.editable = NO;
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入物料名称";
        //firstview.text = self.materialProductName;
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstview.zw_placeHolder = @"请填写厚度的值";
        firstview.keyboardType = UIKeyboardTypeDefault;
        firstview.returnKeyType = UIReturnKeyDone;
        // firstview.delegate =self;
        //firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(12, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width - 24 , 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        

    }else if ([self.selectFunctionType isEqualToString:@"加工厂"]){
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"加工厂";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"加工厂名称";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        UITextView * firstview = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //firstview.editable = NO;
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入物料名称";
        //firstview.text = self.materialProductName;
        firstview.text = self.wareHouseTypeName;
        firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.font = [UIFont systemFontOfSize:16];
        firstview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        firstview.zw_placeHolder = @"请填写加工厂名称";
        firstview.keyboardType = UIKeyboardTypeDefault;
        firstview.returnKeyType = UIReturnKeyDone;
        // firstview.delegate =self;
        //firstview.returnKeyType = UIReturnKeySend;
        [self addSubview:firstview];
        _firstview = firstview;
        _firstview.delegate = self;
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(12, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width - 24 , 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];

    }else{
        //添加仓库
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"添加仓库";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"仓库类型";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        JJOptionView * firstview = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        _fristView = firstview;
        _fristView.title = self.wareHouseTypeName;
        //self.firstField.borderStyle = UITextBorderStyleLine;
        //firstview.placeholder = @"请输入物料名称";
        //firstview.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        firstview.layer.cornerRadius = 17;
        firstview.layer.masksToBounds = YES;
        firstview.selectType = @"warehouse";
        firstview.dataSource =self.typeArray;
        RSWeakself
        firstview.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
            weakSelf.index = selectedIndex;
        };
        [self addSubview:firstview];
        
        //self.firstField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(firstview.frame) + 10, self.bounds.size.width, 16)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"仓库名称";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        
        UITextView * secondView = [[UITextView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        //secondView.placeholder = @"请输入仓库名称";
        
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        secondView.layer.masksToBounds = YES;
        secondView.font = [UIFont systemFontOfSize:16];
        secondView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        // secondView.delegate =self;
        secondView.returnKeyType = UIReturnKeySend;
        [self addSubview:secondView];
        _secondView = secondView;
        _secondView.delegate = self;
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(0, CGRectGetMaxY(view.frame),  self.bounds.size.width, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(warehouseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
        if ([self.selectType isEqualToString:@"edit"]) {
            secondView.text = self.wareHouseProductName;
        }else{
            secondView.placeholder = self.wareHouseProductName;
        }
        
    }
}


//修改开始时间
- (void)firstChangeTimeAction:(UIButton *)firstTimeBtn{
    
    NSDate * date = [self nsstringConversionNSDate:firstTimeBtn.currentTitle];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy/MM/dd"];
        [firstTimeBtn setTitle:date forState:UIControlStateNormal];
    }];
//    datepicker.minLimitDate = [self maxtimeString:firstTimeBtn.currentTitle];
//    datepicker.maxLimitDate = [NSDate date];
    [datepicker show];
}

-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

- (NSDate *)maxtimeString:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate * birthdayDate = [dateFormatter dateFromString:string];
    return birthdayDate;
}


//修改结束时间
- (void)secondChangeTimeAction:(UIButton *)secondTimeBtn{
     NSDate * date = [self nsstringConversionNSDate:secondTimeBtn.currentTitle];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy/MM/dd"];
         //结束时间
        [secondTimeBtn setTitle:date forState:UIControlStateNormal];
       
    }];
//    datepicker.maxLimitDate = [NSDate date];
   // datepicker.minLimitDate = [self currentMinTime];
    [datepicker show];
}

#pragma mark -- 显示键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            //self.textfield.frame  = CGRectMake(0,SCH - offset - 130, SCW, 50);
            //self.cmtView.frame = CGRectMake(0, SCH - offset - 130, SCW, 50);
            if ([self.selectFunctionType isEqualToString:@"库存筛选"] || [self.selectFunctionType isEqualToString:@"采购入库"] || [self.selectFunctionType isEqualToString:@"加工入库"] || [self.selectFunctionType isEqualToString:@"盘盈入库"] || [self.selectFunctionType isEqualToString:@"销售出库"] ||
                [self.selectFunctionType isEqualToString:@"加工出库"] || [self.selectFunctionType isEqualToString:@"盘亏出库"]  || [self.selectFunctionType isEqualToString:@"异常处理"] || [self.selectFunctionType isEqualToString:@"调拨"]) {
                  self.frame = CGRectMake(33, 351 - offset, SCW - 66 , 351);
                
            }else if([self.selectFunctionType isEqualToString:@"添加物料"]){
                
                self.frame = CGRectMake(33,  345 - offset, SCW - 66, 348);
                
            }else if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]){
                
                self.frame = CGRectMake(33, 80, SCW - 66, SCH - 160);
            }else if ([self.selectFunctionType isEqualToString:@"荒料库存筛选"]){
                
                
                 self.frame = CGRectMake(33, 351 - offset, SCW - 66 , 351);
            }else if ([self.selectFunctionType isEqualToString:@"用户编辑"]){
                 self.frame = CGRectMake(33, 351 - offset, SCW - 66 , 351);
                
            }else if ([self.selectFunctionType isEqualToString:@"修改厚度"] || [self.selectFunctionType isEqualToString:@"加工厂"]){
                self.frame = CGRectMake(33, 200 - 50, SCW - 66, 200);
            }else{
                
                self.frame = CGRectMake(33, 279 - offset, SCW - 66 , 279);
            }
        }];
    }
}

#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        if ([self.selectFunctionType isEqualToString:@"库存筛选"] || [self.selectFunctionType isEqualToString:@"采购入库"] || [self.selectFunctionType isEqualToString:@"加工入库"] || [self.selectFunctionType isEqualToString:@"盘盈入库"] || [self.selectFunctionType isEqualToString:@"销售出库"] ||
            [self.selectFunctionType isEqualToString:@"加工出库"] || [self.selectFunctionType isEqualToString:@"盘亏出库"] || [self.selectFunctionType isEqualToString:@"异常处理"] || [self.selectFunctionType isEqualToString:@"调拨"]) {
            
             self.frame = CGRectMake(33, (SCH/2) - 175.5, SCW - 66 , 351);
            
        }else if([self.selectFunctionType isEqualToString:@"添加物料"]){
            
             self.frame = CGRectMake(33,  (SCH/2) - 174, SCW - 66, 348);
           
        }else if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]){
            self.frame = CGRectMake(33,  80, SCW - 66 , SCH - 160);
        }else if ([self.selectFunctionType isEqualToString:@"荒料库存筛选"]){
            self.frame = CGRectMake(33, (SCH/2) - 175.5, SCW - 66 , 351);
        }else if ([self.selectFunctionType isEqualToString:@"用户编辑"]){
            self.frame = CGRectMake(33,  (SCH/2) - 175.5, SCW - 66 , 351);
        }else if ([self.selectFunctionType isEqualToString:@"修改厚度"]|| [self.selectFunctionType isEqualToString:@"加工厂"]){
            self.frame = CGRectMake(33, (SCH/2) - 100, SCW - 66, 200);
        }
        else{
             self.frame = CGRectMake(33,  (SCH/2) - 139.5, SCW - 66 , 279);
        }
    }];
}




- (void)showView
{
    
//    if ([self.selectType isEqualToString:@"edit"]) {
//        //编辑
//
//
//    }else{
//        //新建
//        self.index = 0;
//        self.secondIndex = 0;
//    }
   
    if (self.bgView) {
        return;
    }
    
    [self createView];
    
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
    
}

-(void)tap:(UIGestureRecognizer *)tap
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}


- (void)cancelAction:(UIButton *)cancelBtn{
    [self closeView];
}

- (void)closeView
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [IQKeyboardManager sharedManager].enable = YES;
    [self removeFromSuperview];
}



//确定
- (void)sendSalertAction:(UIButton *)buttonTwo{ 
    if ([self.selectFunctionType isEqualToString:@"采购入库"] || [self.selectFunctionType isEqualToString:@"加工入库"] || [self.selectFunctionType isEqualToString:@"盘盈入库"] || [self.selectFunctionType isEqualToString:@"销售出库"] ||
        [self.selectFunctionType isEqualToString:@"加工出库"] || [self.selectFunctionType isEqualToString:@"盘亏出库"] || [self.selectFunctionType isEqualToString:@"异常处理"] || [self.selectFunctionType isEqualToString:@"调拨"]) {
        if (![_firstTimeBtn.currentTitle isEqualToString:@""] && ![_secondTimeBtn.currentTitle isEqualToString:@""]) {
            if ([self.delegate respondsToSelector:@selector(screenFunctionWithWarehousingTime:andDeadline:andMaterialName:andBlockNumber:)]) {
                [self.delegate screenFunctionWithWarehousingTime:_firstTimeBtn.currentTitle andDeadline:_secondTimeBtn.currentTitle andMaterialName:_firstview.text andBlockNumber:_secondView.text];
            }
            [_firstview resignFirstResponder];
            [_secondView resignFirstResponder];
            [self closeView];
        }
    }else if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]){
        if ([self.delegate respondsToSelector:@selector(balanceFunctionWithBeginTime:andEndTime:andType:andWareHouseName:andWarehouseIndex:andName:andBlockNo:)]) {
            [self.delegate balanceFunctionWithBeginTime:_firstTimeBtn.currentTitle andEndTime:_secondTimeBtn.currentTitle andType:self.index andWareHouseName:_secondview.title andWarehouseIndex:self.secondIndex andName:_firstview.text andBlockNo:_secondView.text];
        }
        
    }else if ([self.selectFunctionType isEqualToString:@"库存筛选"]){
        if ([self.delegate respondsToSelector:@selector(blockFunctionWithWareHouseName:andName:andBlockNo:)]) {
            [self.delegate blockFunctionWithWareHouseName:_wareHouseLabel.text andName:_firstview.text andBlockNo:_secondView.text];
        }
    }else if ([self.selectFunctionType isEqualToString:@"荒料库存筛选"]){
        if ([self.delegate respondsToSelector:@selector(abnormalFunctionWithWarehouseName:andIndex:andName:andBlockNo:)]) {
            [self.delegate abnormalFunctionWithWarehouseName:_fristView.title andIndex:self.index andName:_firstview.text andBlockNo:_secondView.text];
        }
    }else if ([self.selectFunctionType isEqualToString:@"添加公司"]){
        
        if (![self isTrueMobile:_firstview.text]) {
            [SVProgressHUD showErrorWithStatus:@"手机号错误"];
            return;
        }
        
        if ([_secondView.text length] < 1){
            [SVProgressHUD showErrorWithStatus:@"公司没有输入"];
            return;
        }
        
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        //NSString * user_code = [user objectForKey:@"USER_CODE"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:_firstview.text forKey:@"contactPhone"];
        [phoneDict setObject:_secondView.text forKey:@"companyName"];
        [phoneDict setObject:@"year" forKey:@"signingMode"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        //RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_APPLYPERSONAL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isreust = [json[@"success"]boolValue];
                if (isreust) {
                    [SVProgressHUD showSuccessWithStatus:@"申请成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"申请失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"申请失败"];
            }
        }];
    }else if([self.selectFunctionType isEqualToString:@"修改账号"]){
        
        if (![self isTrueMobile:_firstview.text]) {
            [SVProgressHUD showErrorWithStatus:@"手机号错误"];
            return;
        }
        
        if ([_secondView.text length] < 1){
            [SVProgressHUD showErrorWithStatus:@"公司没有输入"];
            return;
        }
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        //NSString * user_code = [user objectForKey:@"USER_CODE"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:_firstview.text forKey:@"contactPhone"];
        [phoneDict setObject:_secondView.text forKey:@"companyName"];
        [phoneDict setObject:@"year" forKey:@"signingMode"];
        [phoneDict setObject:[NSNumber numberWithInteger:self.applyID] forKey:@"pwmsUserId"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_UPDATEAPPLYA_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isreust = [json[@"success"]boolValue];
                if (isreust) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    if (weakSelf.reload) {
                        weakSelf.reload(true);
                    }
                    if (weakSelf.modilfy) {
                        weakSelf.modilfy(_firstview.text, _secondView.text);
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }];
    }else if ([self.selectFunctionType isEqualToString:@"用户编辑"]){
        
        
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        //用户id    userId    Int
        //角色id    roleId    Int
        RSRoleModel * rolemodel = self.typeArray[self.index];
        [phoneDict setObject:[NSNumber numberWithInteger:rolemodel.roleID] forKey:@"roleId"];
        [phoneDict setObject:[NSNumber numberWithInteger:self.userManagementID] forKey:@"userId"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_UPDATEUSER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isreust = [json[@"success"]boolValue];
                if (isreust) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    if (weakSelf.reload) {
                        weakSelf.reload(true);
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }];
    }else if ([self.selectFunctionType isEqualToString:@"修改厚度"] ){
        
        if ([_firstview.text isEqualToString:@""]){
            [SVProgressHUD showInfoWithStatus:@"没有数值"];
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(changHeightNumber:)]) {
            [self.delegate changHeightNumber:_firstview.text];
        }
    }else if ([self.selectFunctionType isEqualToString:@"加工厂"]){
        
        if ([_firstview.text isEqualToString:@""]){
            [SVProgressHUD showInfoWithStatus:@"没有加工厂名称 "];
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(reloadFactoryName:andType:andTag:)]) {
            [self.delegate reloadFactoryName:_firstview.text andType:self.selectType andTag:self.indextag];
        }
        
        
    }
    [_firstview resignFirstResponder];
    [_secondView resignFirstResponder];
    [self closeView];
}

//添加物料的确定
- (void)addMaterialAction:(UIButton *)buttonTwo{
    if ([_firstview.text length] > 0) {
        if ([self.selectType isEqualToString:@"edit"]) {
            //编辑
            
            if ([self.delegate respondsToSelector:@selector(materialWithContent:FristName:andSecondName:andColorId:andTypeID:andSelectType:andTag:)]) {
                RSTypeModel * typemodel = _fristView.dataSource[self.index];
                RSColorModel * colormodel = _secondview.dataSource[self.secondIndex];
                
                [self.delegate materialWithContent:_firstview.text FristName:_fristView.title andSecondName:_secondview.title andColorId:colormodel.ColorID andTypeID:typemodel.TypeID andSelectType:self.selectType andTag:self.indextag];
            }
        }else{
            
            //新建
            if ([self.delegate respondsToSelector:@selector(materialWithContent:FristName:andSecondName:andColorId:andTypeID:andSelectType:andTag:)]) {
                RSTypeModel * typemodel = _fristView.dataSource[self.index];
                RSColorModel * colormodel = _secondview.dataSource[self.secondIndex];
                [self.delegate materialWithContent:_firstview.text FristName:_fristView.title andSecondName:_secondview.title andColorId:colormodel.ColorID andTypeID:typemodel.TypeID andSelectType:self.selectType andTag:self.indextag];
            }
        }
        [_firstview resignFirstResponder];
        [_secondView resignFirstResponder];
        
        [self closeView];
    }else{
        
        [SVProgressHUD showInfoWithStatus:@"请输入名称和选择类型,颜色"];
    }
    
}

- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    
    // NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
    
}


//添加仓库
- (void)warehouseAction:(UIButton *)buttonTwo{
    if ([_secondView.text length] > 0) {
        if ([self.selectType isEqualToString:@"edit"]) {
            //编辑
            if ([self.delegate respondsToSelector:@selector(warehouseSelectName:andWarehouseName:andSelectType:andTag:)]) {
                [self.delegate warehouseSelectName:_fristView.title andWarehouseName:_secondView.text andSelectType:self.selectType andTag:self.indextag];
            }
        }else{
            //新建
            if ([self.delegate respondsToSelector:@selector(warehouseSelectName:andWarehouseName:andSelectType:andTag:)]) {
                [self.delegate warehouseSelectName:_fristView.title andWarehouseName:_secondView.text andSelectType:self.selectType andTag:self.indextag];
            }
        }
        [_firstview resignFirstResponder];
        [_secondView resignFirstResponder];
        [self closeView];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请输入仓库名称和选择仓库类型"];
    }
}

//重置
-(void)resetAction:(UIButton *)sender
{
    if ([self.selectFunctionType isEqualToString:@"库存筛选"]) {
        
        
        _firstview.text = @"";
        _secondView.text = @"";
        //self.index = 0;
        //self.secondIndex = 0;
        [_firstview resignFirstResponder];
        [_secondView resignFirstResponder];

    }else if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]){
    
        _firstview.text = @"";
        _secondView.text = @"";
        self.index = 0;
        self.secondIndex = 0;
        
        _fristView.title = @"采购入库";
        
        _secondview.title = @"请选择仓库";
        
        [_firstview resignFirstResponder];
        [_secondView resignFirstResponder];
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
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
        [_firstTimeBtn setTitle:newBefordate forState:UIControlStateNormal];
        [_secondTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
        
        
    
    }else if ([self.selectFunctionType isEqualToString:@"荒料库存筛选"]){
        
         _fristView.title = @"请选择仓库";
        _firstview.text = @"";
        _secondView.text = @"";
        self.index = 0;
        [_firstview resignFirstResponder];
        [_secondView resignFirstResponder];
        
        
        
    
        
    }else{
        _firstview.text = @"";
        _secondView.text = @"";
        [_firstview resignFirstResponder];
        [_secondView resignFirstResponder];
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
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
        [_firstTimeBtn setTitle:newBefordate forState:UIControlStateNormal];
        [_secondTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
    }
    //[self closeView];
}



- (NSDate *)currentMinTime{
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    //NSDate转NSString
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
    return [self maxtimeString:newBefordate];
}


- (void)showDisplayTheTimeToSelectTime:(UIButton *)firstTimeBtn andSecondTime:(UIButton *)secondTimeBtn{
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
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




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self.selectFunctionType isEqualToString:@"修改厚度"]) {
        BOOL isHaveDian = YES;
        if ([text isEqualToString:@" "]) {
            return NO;
        }
        if ([textView.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([text length] > 0) {
            unichar single = [text characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                if([textView.text length] == 0){
                    if(single == '.') {
                       // NSLog(@"数据格式有误");
                        [textView.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian = YES;
                        return YES;
                        
                    }else{
                       // NSLog(@"数据格式有误");
                        [textView.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        
                        //判断小数点的位数
                        NSRange ran = [textView.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                           // NSLog(@"最多两位小数");
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
               // NSLog(@"数据格式有误");
                [textView.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }else
        {
            return YES;
        }
        
        
    }else{
        
        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            if (textView == _firstview) {
                NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                temp = [self delSpaceAndNewline:temp];
                if ([temp length] < 1){
                    _firstview.text = @"";
                    [_firstview resignFirstResponder];
                }else{
                    _firstview.text = temp;
                    [_firstview resignFirstResponder];
                }
            }else{
                NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                temp = [self delSpaceAndNewline:temp];
                if ([temp length] < 1){
                    _secondView.text = @"";
                    [_secondView resignFirstResponder];
                }else{
                    _secondView.text = temp;
                    [_secondView resignFirstResponder];
                }
            }
            return NO;
        }
        return YES;
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
