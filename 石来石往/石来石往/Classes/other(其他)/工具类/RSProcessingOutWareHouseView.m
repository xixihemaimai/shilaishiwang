//
//  RSProcessingOutWareHouseView.m
//  石来石往
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSProcessingOutWareHouseView.h"
#import "JJOptionView.h"
#import "RSPublishingProjectCaseFirstButton.h"

@interface RSProcessingOutWareHouseView()<UITextViewDelegate,TZImagePickerControllerDelegate>
{
    UITextView * _processTextView;
    
    UIButton * _choiceTimeBtn;
    
    JJOptionView * _completeView;
    
    
    UITextView * _nameTextView;
    UITextView * _priceView;
    UITextView * _numberView;
    UITextView * _moneyView;
    
    
    UITextView * _titleView;
    RSPublishingProjectCaseFirstButton * _selectImageBtn;
    
    //删除图片
    UIButton * _deleteBtn;
    
}




@property(nonatomic,strong)UIView *bgView;
@end


@implementation RSProcessingOutWareHouseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorFromHexString:@"#ffffff"];
        // [self createView];
        
        [IQKeyboardManager sharedManager].enable = NO;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
    }
    return self;
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
            if ([self.addType isEqualToString:@"添加进度"]){
                self.frame = CGRectMake(33, 387 - offset, SCW - 66 , 387);
            }else if([self.addType isEqualToString:@"添加费用"]){
                self.frame = CGRectMake(33,  428 - offset - 160, SCW - 66, 428);
            }else if([self.addType isEqualToString:@"添加照片"]){
                self.frame = CGRectMake(33, 374 - offset, SCW - 66, 374);
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
        if ([self.addType isEqualToString:@"添加进度"]) {
            self.frame = CGRectMake(33, (SCH/2) - 192.5, SCW - 66 , 387);
        }else if([self.addType isEqualToString:@"添加费用"]){
            self.frame = CGRectMake(33,  (SCH/2) - 214, SCW - 66, 428);
        }else if([self.addType isEqualToString:@"添加照片"]){
            self.frame = CGRectMake(33, (SCH/2) - 187, SCW - 66, 374);
        }
    }];
}


- (void)creatUI{
    if ([self.addType isEqualToString:@"添加进度"]) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"添加进度";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //进度
        UILabel * processLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 19, self.bounds.size.width, 23)];
        processLabel.textAlignment = NSTextAlignmentLeft;
        processLabel.text = @"进度";
        processLabel.font = [UIFont systemFontOfSize:16];
        processLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        processLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:processLabel];
        
        //输入进度的内容
        UITextView * processTextView = [[UITextView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(processLabel.frame) + 5, self.bounds.size.width - (39 * 2), 68)];
        processTextView.backgroundColor = [UIColor colorFromHexString:@"#F7F7F7"];
        processTextView.layer.cornerRadius = 3;
        processTextView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        processTextView.layer.masksToBounds = YES;
        processTextView.font = [UIFont systemFontOfSize:16];
        processTextView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        //processTextView.zw_placeHolder = @"请输入荒料号";
        processTextView.delegate =self;
        //processTextView.lineBreakMode = UILineBreakModeWordWrap;
        //processTextView.numberOfLines = 0;
        processTextView.returnKeyType = UIReturnKeySend;
        [self addSubview:processTextView];
        _processTextView = processTextView;
        //时间
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(processTextView.frame) + 10, self.bounds.size.width - (39 * 2), 23)];
        timeLabel.text = @"时间";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        
        UIButton * choiceTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [choiceTimeBtn setTitle:[self showCurrentTime] forState:UIControlStateNormal];
        [choiceTimeBtn setBackgroundColor:[UIColor colorFromHexString:@"#F7F7F7"]];
        [choiceTimeBtn setTitleColor:[UIColor colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        choiceTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        choiceTimeBtn.frame = CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, self.bounds.size.width - (39 * 2), 34);
        choiceTimeBtn.layer.cornerRadius = 17;
        [choiceTimeBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:choiceTimeBtn];
        _choiceTimeBtn = choiceTimeBtn;
        
        //是否加工全部完成
        UILabel * endLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(choiceTimeBtn.frame) + 10, self.bounds.size.width - (39 * 2), 23)];
        endLabel.text = @"是否加工全部完成";
        endLabel.font = [UIFont systemFontOfSize:16];
        endLabel.textAlignment = NSTextAlignmentLeft;
        endLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        endLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:endLabel];
        
        //选择器
        JJOptionView * completeView = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(endLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        completeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        completeView.layer.cornerRadius = 17;
        completeView.layer.masksToBounds = YES;
        
        //completeView.title = @"是否加工完成";
        completeView.title = @"否";
        
        completeView.selectType = @"warehouse";
        completeView.dataSource = @[@"是",@"否"];
        //RSWeakself
        completeView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
            
            
        };
        [self addSubview:completeView];
        _completeView = completeView;

        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(completeView.frame) + 20, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 47);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"删除" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 5, 1, 30)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        if ([self.statusType isEqualToString:@"1"]) {
            //新建
            
            
            
            
            
        }else{
            //修改或者删除
            _processTextView.text = self.firstprocessmodel.processName;
            NSString * str = [NSString string];
            str = [self.firstprocessmodel.processTime substringToIndex:10];
            [_choiceTimeBtn setTitle:str forState:UIControlStateNormal];
            if (self.firstprocessmodel.processStatus == 1) {
                _completeView.title = @"否";
            }else{
                _completeView.title = @"是";
            }
        }
    }else if([self.addType isEqualToString:@"添加费用"]){
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"加工费用";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //费用名称
        UILabel * processLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 19, self.bounds.size.width, 23)];
        processLabel.textAlignment = NSTextAlignmentLeft;
        processLabel.text = @"费用名称";
        processLabel.font = [UIFont systemFontOfSize:16];
        processLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        processLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:processLabel];
        
        //费用名称输入
        UITextView * nameTextView = [[UITextView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(processLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        nameTextView.backgroundColor = [UIColor colorFromHexString:@"#F7F7F7"];
        nameTextView.layer.cornerRadius = 17;
        nameTextView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        nameTextView.layer.masksToBounds = YES;
        nameTextView.font = [UIFont systemFontOfSize:16];
        nameTextView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        //processTextView.zw_placeHolder = @"请输入荒料号";
        nameTextView.delegate =self;
        //processTextView.lineBreakMode = UILineBreakModeWordWrap;
        //processTextView.numberOfLines = 0;
        nameTextView.returnKeyType = UIReturnKeySend;
        [self addSubview:nameTextView];
        _nameTextView = nameTextView;
        
        //单价
        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(nameTextView.frame) + 5, self.bounds.size.width - 78, 23)];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.text = @"单价";
        priceLabel.font = [UIFont systemFontOfSize:16];
        priceLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        priceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:priceLabel];
        
        //单价输入值
        UITextView * priceView = [[UITextView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(priceLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        priceView.backgroundColor = [UIColor colorFromHexString:@"#F7F7F7"];
        priceView.layer.cornerRadius = 17;
        priceView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        priceView.layer.masksToBounds = YES;
        priceView.font = [UIFont systemFontOfSize:16];
        priceView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        //processTextView.zw_placeHolder = @"请输入荒料号";
        priceView.delegate =self;
        //processTextView.lineBreakMode = UILineBreakModeWordWrap;
        //processTextView.numberOfLines = 0;
        priceView.returnKeyType = UIReturnKeySend;
        [self addSubview:priceView];
        _priceView = priceView;
        
        //数量
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(priceView.frame) + 5, self.bounds.size.width - 78, 23)];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.text = @"数量";
        numberLabel.font = [UIFont systemFontOfSize:16];
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numberLabel];
        
        //数量输入值
        UITextView * numberView = [[UITextView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(numberLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        numberView.backgroundColor = [UIColor colorFromHexString:@"#F7F7F7"];
        numberView.layer.cornerRadius = 17;
        numberView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        numberView.layer.masksToBounds = YES;
        numberView.font = [UIFont systemFontOfSize:16];
        numberView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        //processTextView.zw_placeHolder = @"请输入荒料号";
        numberView.delegate =self;
        numberView.returnKeyType = UIReturnKeySend;
        [self addSubview:numberView];
        _numberView = numberView;
        
        //金额
        UILabel * moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(numberView.frame) + 5, self.bounds.size.width - 78, 23)];
        moneyLabel.textAlignment = NSTextAlignmentLeft;
        moneyLabel.text = @"金额";
        moneyLabel.font = [UIFont systemFontOfSize:16];
        moneyLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        moneyLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:moneyLabel];
        
        //单价输入值
        UITextView * moneyView = [[UITextView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(moneyLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        moneyView.backgroundColor = [UIColor colorFromHexString:@"#F7F7F7"];
        moneyView.layer.cornerRadius = 17;
        moneyView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        moneyView.layer.masksToBounds = YES;
        moneyView.font = [UIFont systemFontOfSize:16];
        moneyView.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
        //processTextView.zw_placeHolder = @"请输入荒料号";
        moneyView.delegate =self;
        //processTextView.lineBreakMode = UILineBreakModeWordWrap;
        //processTextView.numberOfLines = 0;
        moneyView.returnKeyType = UIReturnKeySend;
        [self addSubview:moneyView];
        _moneyView = moneyView;
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyView.frame) + 30, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 49);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"删除" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 5, 1, 30)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 49);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
        
        
        if ([self.statusType isEqualToString:@"2"]) {
            _nameTextView.text = self.secondProcessmodel.name;
            _priceView.text = [NSString stringWithFormat:@"%@",self.secondProcessmodel.price];
            _numberView.text = [NSString stringWithFormat:@"%@",self.secondProcessmodel.amount];
            _moneyView.text = [NSString stringWithFormat:@"%@",self.secondProcessmodel.money];
        }

    }else if([self.addType isEqualToString:@"添加照片"]){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"添加照片";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //标题
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 19, self.bounds.size.width, 23)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"标题";
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        UITextView * titleView = [[UITextView alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(titleLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        titleView.backgroundColor = [UIColor colorFromHexString:@"#F7F7F7"];
        titleView.layer.cornerRadius = 17;
        titleView.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        titleView.layer.masksToBounds = YES;
        titleView.font = [UIFont systemFontOfSize:15];
        //processTextView.zw_placeHolder = @"请输入荒料号";
        titleView.delegate =self;
        //processTextView.lineBreakMode = UILineBreakModeWordWrap;
        //processTextView.numberOfLines = 0;
        titleView.returnKeyType = UIReturnKeySend;
        [self addSubview:titleView];
        _titleView = titleView;
        
        RSPublishingProjectCaseFirstButton * selectImageBtn = [[RSPublishingProjectCaseFirstButton alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(titleView.frame) + 19, self.bounds.size.width - 78, 135)];
        [selectImageBtn setImage:[UIImage imageNamed:@"添加个人版"] forState:UIControlStateNormal];
        [selectImageBtn setTitle:@"添加照片" forState:UIControlStateNormal];
        [selectImageBtn addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
        [selectImageBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [selectImageBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [self addSubview:selectImageBtn];
        _selectImageBtn = selectImageBtn;
        
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.bounds = CGRectMake(0, 0, selectImageBtn.yj_width, selectImageBtn.yj_height);//虚线框的大小
        borderLayer.position = CGPointMake(CGRectGetMidX(selectImageBtn.bounds),CGRectGetMidY(selectImageBtn.bounds));//虚线框锚点
        borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;//矩形路径
        borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];//虚线宽度
        //虚线边框
        borderLayer.lineDashPattern = @[@5, @5];
        //实线边框
        //    borderLayer.lineDashPattern = nil;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = [UIColor colorWithHexColorStr:@"#D8D8D8"].CGColor;
        [selectImageBtn.layer addSublayer:borderLayer];
        
        
        
        
        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"现货删除"] forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(self.bounds.size.width - 60, CGRectGetMaxY(titleView.frame) , 40, 40);
        [deleteBtn addTarget:self action:@selector(deleteCurrentImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        
        
        
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(selectImageBtn.frame) + 22, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:view];
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 49);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"删除" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 13, 1, 30)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 49);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
        
        
        
        if ([self.statusType isEqualToString:@"2"]) {
          
            
            _titleView.text = [NSString stringWithFormat:@"%@",self.thirdProcessmodel.name];
            
            
            NSString * urlstr = [URL_HEADER_TEXT_IOS substringToIndex:[URL_HEADER_TEXT_IOS length] - 1];
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlstr,self.thirdProcessmodel.filePath]]];
            UIImage * image = [UIImage imageWithData:data];
            [_selectImageBtn setImage:image forState:UIControlStateNormal];
            
            
            _deleteBtn.hidden = NO;
            
            _selectImageBtn.imageView.sd_layout
            .widthIs(_selectImageBtn.yj_width)
            .heightIs(_selectImageBtn.yj_height)
            .topSpaceToView(_selectImageBtn, 0)
            .rightSpaceToView(_selectImageBtn, 0);
            
            [_selectImageBtn setTitle:@"" forState:UIControlStateNormal];
            
            
            
            
            
        }else{
  
            
            
            
            _deleteBtn.hidden = YES;
            [selectImageBtn setImage:[UIImage imageNamed:@"添加个人版"] forState:UIControlStateNormal];
            [selectImageBtn setTitle:@"添加照片" forState:UIControlStateNormal];
        }
    }
}



//删除图片
- (void)deleteCurrentImageAction:(UIButton *)deleteBtn{
    
    [_selectImageBtn setImage:[UIImage imageNamed:@"添加个人版"] forState:UIControlStateNormal];
    [_selectImageBtn setTitle:@"添加照片" forState:UIControlStateNormal];
    deleteBtn.hidden = YES;
    
    _selectImageBtn.imageView.sd_layout
    .widthIs(23)
    .heightIs(23)
    .leftSpaceToView(_selectImageBtn, _selectImageBtn.yj_width/2 - 11.5)
    .rightSpaceToView(_selectImageBtn, _selectImageBtn.yj_width/2 - 11.5)
    .topSpaceToView(_selectImageBtn, 20);
    
    
    
}



- (void)choiceTimeAction:(UIButton *)choiceTimeBtn{
    NSDate * date = [self nsstringConversionNSDate:choiceTimeBtn.currentTitle];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [choiceTimeBtn setTitle:date forState:UIControlStateNormal];
    }];
    //    datepicker.minLimitDate = [self maxtimeString:firstTimeBtn.currentTitle];
    //    datepicker.maxLimitDate = [NSDate date];
    [datepicker show];
}

- (void)addPictureAction:(UIButton *)selectImageBtn{
    
    
    if (![selectImageBtn.currentImage isEqual:[UIImage imageNamed:@"添加个人版"]]) {
 
      
        
        NSMutableArray * array = [NSMutableArray array];
        [array addObject:_selectImageBtn.currentImage];
        [HUPhotoBrowser showFromImageView:_selectImageBtn withImages:array atIndex:0];
        
        
    }else{
        RSWeakself
        TZImagePickerController * tzimagepicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        tzimagepicker.allowPickingVideo = NO;
        tzimagepicker.allowTakePicture = YES;
        [tzimagepicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                           {
                               for (int i=0; i<photos.count; i++)
                               {
                                   UIImage * tempImg = photos[i];
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       
                                       [_selectImageBtn setImage:tempImg forState:UIControlStateNormal];
                                       [_selectImageBtn setTitle:@"" forState:UIControlStateNormal];
                                       weakSelf.bgView.hidden = NO;
                                       weakSelf.hidden = NO;
                                       _deleteBtn.hidden = NO;
                                       
                                       _selectImageBtn.imageView.sd_layout
                                       .widthIs(_selectImageBtn.yj_width)
                                       .heightIs(_selectImageBtn.yj_height)
                                       .topSpaceToView(_selectImageBtn, 0)
                                       .rightSpaceToView(_selectImageBtn, 0);
                                   });
                               }
                           });
        }];
        self.bgView.hidden = YES;
        self.hidden = YES;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                   
                   tzimagepicker.modalPresentationStyle = UIModalPresentationFullScreen;
               }
        [_VC presentViewController:tzimagepicker animated:YES completion:nil];
       
    }
}


- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    self.bgView.hidden = NO;
    self.hidden = NO;
}


- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}



- (void)resetAction:(UIButton *)oneBtn{
    //时间
    if ([self.addType isEqualToString:@"添加进度"]) {
        [_choiceTimeBtn setTitle:[self showCurrentTime] forState:UIControlStateNormal];
        _processTextView.text = @"";
        _completeView.title = @"否";
    }else if([self.addType isEqualToString:@"添加费用"]){
        _nameTextView.text = @"";
        _priceView.text = @"";
        _numberView.text = @"";
        _moneyView.text = @"";
    }else if([self.addType isEqualToString:@"添加照片"]){
        
        
    }
}

//这边是相册用到的
- (void)deleteAction:(UIButton *)deleteBtn{
    if ([self.addType isEqualToString:@"添加进度"]) {
        if ([self.statusType isEqualToString:@"1"]) {
            //新建
            [_choiceTimeBtn setTitle:[self showCurrentTime] forState:UIControlStateNormal];
            _processTextView.text = @"";
            _completeView.title = @"否";
            [self closeView];
        }else{
            //删除
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:@"process" forKey:@"type"];
            [phoneDict setObject:[NSNumber numberWithInteger:self.firstprocessmodel.processId] forKey:@"id"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
             RSWeakself
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_DELETEPROCESSDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL isresult = [json[@"success"]boolValue];
                    if (isresult) {
                        if (weakSelf.processReload) {
                            weakSelf.processReload(true);
                        }
                        [weakSelf closeView];
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"删除失败"];
                    }
                }else{
                    [SVProgressHUD showInfoWithStatus:@"删除失败"];
                }
            }];
        }
    }else if([self.addType isEqualToString:@"添加费用"]){
         if ([self.statusType isEqualToString:@"1"]) {
             //新建
             _nameTextView.text = @"";
             _priceView.text = @"";
             _numberView.text = @"";
             _moneyView.text = @"";
             [self closeView];
         }else{
             //删除
             NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
             NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
             NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
             [phoneDict setObject:@"processFee" forKey:@"type"];
             [phoneDict setObject:[NSNumber numberWithInteger:self.secondProcessmodel.processId] forKey:@"id"];
             NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
             NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
             NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
              RSWeakself
             XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
             [network getDataWithUrlString:URL_DELETEPROCESSDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                 if (success) {
                     BOOL isresult = [json[@"success"]boolValue];
                     if (isresult) {
                         if (weakSelf.processReload) {
                             weakSelf.processReload(true);
                         }
                         [weakSelf closeView];
                     }else{
                         [SVProgressHUD showInfoWithStatus:@"删除失败"];
                     }
                 }else{
                     [SVProgressHUD showInfoWithStatus:@"删除失败"];
                 }
             }];
         }
    }else if([self.addType isEqualToString:@"添加照片"]){
        if ([self.statusType isEqualToString:@"1"]) {
            
            
            
            _deleteBtn.hidden = YES;
            //新建
            [_selectImageBtn setImage:[UIImage imageNamed:@"添加个人版"] forState:UIControlStateNormal];
            [_selectImageBtn setTitle:@"添加照片" forState:UIControlStateNormal];
            [self closeView];
            
            
            
        }else{
            
            //删除
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:@"processPic" forKey:@"type"];
            [phoneDict setObject:[NSNumber numberWithInteger:self.thirdProcessmodel.processId] forKey:@"id"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
             RSWeakself
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_DELETEPROCESSDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL isresult = [json[@"success"]boolValue];
                    if (isresult) {
                        
                        
                        _deleteBtn.hidden = YES;
                        if (weakSelf.processReload) {
                            weakSelf.processReload(true);
                        }
                        [weakSelf closeView];
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"删除失败"];
                    }
                }else{
                    [SVProgressHUD showInfoWithStatus:@"删除失败"];
                }
            }];
        }
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    if ([self.addType isEqualToString:@"添加费用"]) {
       // 单价    price    Decimal    两位精度
       // 数量    amount   Decimal    三位精度
       // 金额    money    Decimal    两位精度
        if (_priceView == textView || _moneyView == textView) {
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
            }
        }else if(_numberView == textView){
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
                            if (range.location - ran.location <= 3) {
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
            }
        }else{
            if ([text isEqualToString:@"\n"]) {
                [textView resignFirstResponder];
                return NO;
            }
            return YES;
        }
    }else{
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    NSString * temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([self.addType isEqualToString:@"添加费用"]) {
        if (_priceView == textView) {
            _priceView.text = temp;
            if ([_priceView.text length] > 0 && [_numberView.text length] > 0 ) {
                _moneyView.text = [self calculateByMultiplying:_priceView.text secondNumber:_numberView.text];
            }
        }else if (_numberView == textView){
             _numberView.text = temp;
            if ([_priceView.text length] > 0 && [_numberView.text length] > 0 ) {
                _moneyView.text = [self calculateByMultiplying:_priceView.text secondNumber:_numberView.text];
            }
        }
    }
}




-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2
{
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber * multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2 withBehavior:Handler];
    return [multiplyingNum stringValue];
}





- (void)sendSalertAction:(UIButton *)sureBtn{
    if ([self.addType isEqualToString:@"添加进度"]) {
        if ([_processTextView.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"进度描述错误"];
            return;
        }

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:@"process" forKey:@"type"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            NSString * str = [NSString string];
            if ([self.statusType isEqualToString:@"2"]) {
             //修改
            [dict setObject:[NSNumber numberWithInteger:self.firstprocessmodel.processId] forKey:@"id"];
                str = URL_UPDATEPROCESSDETAIL_IOS;
            }else{
                str = URL_ADDPROCESSDETAIL_IOS;
            }
        
            [dict setObject:_processTextView.text forKey:@"processName"];
            [dict setObject:_choiceTimeBtn.currentTitle forKey:@"processTime"];
            [dict setObject:[NSNumber numberWithInteger:self.billdtlid] forKey:@"billdtlid"];
            NSInteger status = 1;
            if ([_completeView.title isEqualToString:@"否"]) {
                status = 1;
            }else{
                status = 10;
            }
            [dict setObject:[NSNumber numberWithInteger:status] forKey:@"processStatus"];
            [phoneDict setObject:dict forKey:@"processDetail"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
             RSWeakself
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:str withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL isresult = [json[@"success"]boolValue];
                    if (isresult) {
                        if (weakSelf.processReload) {
                            weakSelf.processReload(true);
                        }
                        [weakSelf closeView];
                    }else{
                        if ([self.statusType isEqualToString:@"2"]) {
                            [SVProgressHUD showInfoWithStatus:@"修改失败"];
                        }else{
                            [SVProgressHUD showInfoWithStatus:@"添加失败"];
                        }
                    }
                }else{
                    if ([self.statusType isEqualToString:@"2"]) {
                        [SVProgressHUD showInfoWithStatus:@"修改失败"];
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"添加失败"];
                    }
                }
            }];
    }else if([self.addType isEqualToString:@"添加费用"]){
        
        //判断条件
        if ([_nameTextView.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"费用名称错误"];
            return;
        }else if ([_priceView.text isEqualToString:@""]){
             [SVProgressHUD showInfoWithStatus:@"单价错误"];
            return;
        }else if ([_numberView.text isEqualToString:@""]){
             [SVProgressHUD showInfoWithStatus:@"数量错误"];
            return;
        }else if ([_moneyView.text isEqualToString:@""]){
             [SVProgressHUD showInfoWithStatus:@"金额错误"];
            return;
        }
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:@"processFee" forKey:@"type"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSString * str = [NSString string];
        if ([self.statusType isEqualToString:@"2"]) {
            //修改
            [dict setObject:[NSNumber numberWithInteger:self.secondProcessmodel.processId] forKey:@"id"];
            str = URL_UPDATEPROCESSDETAIL_IOS;
        }else{
            str = URL_ADDPROCESSDETAIL_IOS;
        }
        [dict setObject:_nameTextView.text forKey:@"name"];
        [dict setObject:_priceView.text forKey:@"price"];
        [dict setObject:_numberView.text forKey:@"amount"];
        [dict setObject:_moneyView.text forKey:@"money"];
        [dict setObject:[NSNumber numberWithInteger:self.billdtlid] forKey:@"billdtlid"];
        [phoneDict setObject:dict forKey:@"processDetail"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:str withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    if (weakSelf.processReload) {
                        weakSelf.processReload(true);
                    }
                    [weakSelf closeView];
                }else{
                    if ([self.statusType isEqualToString:@"2"]) {
                        [SVProgressHUD showInfoWithStatus:@"修改失败"];
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"添加失败"];
                    }
                }
            }else{
                if ([self.statusType isEqualToString:@"2"]) {
                    [SVProgressHUD showInfoWithStatus:@"修改失败"];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"添加失败"];
                }
            }
        }];
    }else if ([self.addType isEqualToString:@"添加照片"]){
        //添加图片
        if ([_titleView.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"标题错误"];
            return;
        }
        if ([_selectImageBtn.currentImage isEqual:[UIImage imageNamed:@"添加个人版"]]) {
            [SVProgressHUD showInfoWithStatus:@"未选择图片"];
            return;
        }
        [self closeView];
           /**
             //URL_ADDPROCESSDETAIL_IOS
             "Data= {  type:'processFee',processDetail:{ billdtlid:284981, name :'包胶费用'}}
             */
        
        [SVProgressHUD showWithStatus:@"正在上传中....."];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
        
        [dict setObject:@"processPic" forKey:@"type"];
        [modeldict setObject:[NSNumber numberWithInteger:self.billdtlid] forKey:@"billdtlid"];
        [modeldict setObject:_titleView.text forKey:@"name"];
        NSString * str = [NSString string];
        if ([self.statusType isEqualToString:@"2"]) {
            //修改
            [modeldict setObject:[NSNumber numberWithInteger:self.thirdProcessmodel.processId] forKey:@"id"];
            str = URL_UPDATEPROCESSDETAIL_IOS;
        }else{
            str = URL_ADDPROCESSDETAIL_IOS;
        }
        [dict setObject:modeldict forKey:@"processDetail"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //POST参数
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
        NSArray *avatarArray = [NSArray arrayWithObject:_selectImageBtn.currentImage];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSData *imageData;
        for (UIImage *avatar in avatarArray)
        {
            imageData = UIImageJPEGRepresentation(avatar, 1);
            [dataArray addObject:imageData];
        }
        RSWeakself
        XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
        [netWork getImageDataWithUrlString:str withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    [SVProgressHUD dismiss];
                        if (weakSelf.processReload) {
                            weakSelf.processReload(true);
                        }
                        [weakSelf closeView];
                    }else{
                        if ([self.statusType isEqualToString:@"2"]) {
                            [SVProgressHUD showInfoWithStatus:@"修改失败"];
                        }else{
                            [SVProgressHUD showInfoWithStatus:@"添加失败"];
                        }
                    }
//                }else{
//                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"msg"]]];
//                }
            }
            else{
                if ([self.statusType isEqualToString:@"2"]) {
                    [SVProgressHUD showInfoWithStatus:@"修改失败"];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"添加失败"];
                }
            }
        }];
    }
}

- (NSString *)showCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
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
    
    [self creatUI];
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
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
//    [self.bgView removeFromSuperview];
//    self.bgView = nil;
//    [self removeFromSuperview];
    [self closeView];
}


- (void)cancelAction:(UIButton *)cancelBtn{
    
    [self closeView];
}

- (void)closeView
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
     _deleteBtn.hidden = YES;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [IQKeyboardManager sharedManager].enable = YES;
    [self removeFromSuperview];
}

@end
