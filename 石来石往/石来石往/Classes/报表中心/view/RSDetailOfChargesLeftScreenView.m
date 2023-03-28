//
//  RSDetailOfChargesLeftScreenView.m
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDetailOfChargesLeftScreenView.h"
#import "RSShaiXuanFristCell.h"
#import "RSShaiXuanSecondCell.h"
#import "JJOptionView.h"

@interface RSDetailOfChargesLeftScreenView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    //起始时间
    UIButton * _fristBtn;
    //截止时间
    UIButton * _secondBtn;
    
//    //起始日期
//    NSString * _datefrom;
//    //截止日期
//    NSString * _Dateto;
    //物料名称
    UITextField * _productNamefield;
    //荒料号
    UITextField * _blockNofield;
    //仓库
    UITextField * _warehousefield;
    //库区
    UITextField * _reservoirfield;
    //储位名称
    UITextField * _storagefield;
    //匝号
    UITextField * _turnfield;
    
    //长
    JJOptionView * _longTypeView;
    UITextField * _longTextfield;
    
    //宽
    JJOptionView * _withTypeView;
    UITextField * _withTextfield;
}

@end

@implementation RSDetailOfChargesLeftScreenView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        _tableview = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        _tableview.estimatedRowHeight = 0;
//        _tableview.estimatedSectionFooterHeight = 0;
//        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
//        _tableview.contentSize = CGSizeMake(0, SCH);
        [self addSubview:_tableview];
        [IQKeyboardManager sharedManager].enable = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setUI];
        });
    }
    return self;
}


- (void)setUI{
    
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 17)];
    label.text = @"筛选";
    label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    
    UILabel * bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 10, self.bounds.size.width, 1)];
    bottomlabel.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
    [view addSubview:bottomlabel];
    
    
    UILabel * outLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(bottomlabel.frame) + 28, self.bounds.size.width - 32, 20)];
    outLabel.text = @"出库日期:";
    outLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    outLabel.font = [UIFont systemFontOfSize:14];
    outLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:outLabel];
    
    
    UIButton * fristBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fristBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [fristBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#E1E1E1"]];
    fristBtn.layer.cornerRadius = 3;
    fristBtn.frame = CGRectMake(14, CGRectGetMaxY(outLabel.frame) + 7, 107, 40);
    [fristBtn setTitle:@"2018/11/11" forState:UIControlStateNormal];
    fristBtn.layer.masksToBounds = YES;
    [view addSubview:fristBtn];
     _fristBtn = fristBtn;
    
    UIView * midView =[[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333"];
    midView.frame = CGRectMake(CGRectGetMaxX(fristBtn.frame) + 9, CGRectGetMaxY(outLabel.frame) + 7 + (fristBtn.frame.size.height / 2 - 0.75), 10, 1.5);
    [view addSubview:midView];
    
    UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#E1E1E1"]];
    secondBtn.layer.cornerRadius = 3;
    secondBtn.frame = CGRectMake(CGRectGetMaxX(midView.frame) + 10, CGRectGetMaxY(outLabel.frame) + 7, 107, 40);
    [secondBtn setTitle:@"2018/11/11" forState:UIControlStateNormal];
    secondBtn.layer.masksToBounds = YES;
    [view addSubview:secondBtn];
    _secondBtn = secondBtn;
    
    UILabel * productNameLabel = [[UILabel alloc]init];
    productNameLabel.text = @"物料名称:";
    productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productNameLabel.font = [UIFont systemFontOfSize:14];
    productNameLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:productNameLabel];
    
    
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
        //没有时间
        outLabel.hidden = YES;
        _fristBtn.hidden = YES;
        _secondBtn.hidden = YES;
        midView.hidden = YES;
        
        productNameLabel.frame = CGRectMake(16, CGRectGetMaxY(bottomlabel.frame) + 28, self.bounds.size.width - 32, 20);
        
        if ([self.searchType isEqualToString:@"大板库存"]) {
            //有匝号
            
            
            
        }else{
            //没有匝号
        }
    }else if ([self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"] || [self.searchType isEqualToString:@"荒料出库明细"]){
        _fristBtn.hidden = NO;
        _secondBtn.hidden = NO;
        midView.hidden = NO;
        outLabel.hidden = NO;
        productNameLabel.frame = CGRectMake(16, CGRectGetMaxY(fristBtn.frame) + 8, self.bounds.size.width - 32, 20);
        if ([self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] ) {
            //有匝号
        }else{
            //没有匝号
        }
    }else{
        //只有时间
        outLabel.hidden = NO;
        _fristBtn.hidden = NO;
        _secondBtn.hidden = NO;
        midView.hidden = NO;
    }
    

    UITextField * productNamefield = [[UITextField alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(productNameLabel.frame) + 7, self.bounds.size.width - 32, 40)];
    productNamefield.placeholder = @"请输入物料名称";
    productNamefield.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
    productNamefield.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    productNamefield.layer.borderWidth = 1;
    productNamefield.layer.cornerRadius = 3;
    productNamefield.layer.masksToBounds = YES;
    [view addSubview:productNamefield];
    productNamefield.delegate = self;
   // [productNamefield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    
    productNamefield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    productNamefield.leftViewMode = UITextFieldViewModeAlways;
    _productNamefield = productNamefield;
    
    
    UILabel * blockNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(productNamefield.frame) + 8, self.bounds.size.width - 32, 20)];
    blockNoLabel.text = @"荒料号:";
    blockNoLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    blockNoLabel.font = [UIFont systemFontOfSize:14];
    blockNoLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:blockNoLabel];
    
    
    UITextField * blockNofield = [[UITextField alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(blockNoLabel.frame) + 7, self.bounds.size.width - 32, 40)];
    blockNofield.placeholder = @"请输入荒料号";
    blockNofield.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
    blockNofield.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    blockNofield.layer.borderWidth = 1;
    blockNofield.layer.cornerRadius = 3;
    blockNofield.layer.masksToBounds = YES;
    [view addSubview:blockNofield];
    blockNofield.delegate = self;
   // [blockNofield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    _blockNofield = blockNofield;
    
    blockNofield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    blockNofield.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    UILabel * warehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(blockNofield.frame) + 8, self.bounds.size.width - 32, 20)];
    warehouseLabel.text = @"仓库:";
    warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    warehouseLabel.font = [UIFont systemFontOfSize:14];
    warehouseLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:warehouseLabel];
    
    
    UITextField * warehousefield = [[UITextField alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(warehouseLabel.frame) + 7, self.bounds.size.width - 32, 40)];
    warehousefield.placeholder = @"请输入仓库";
    warehousefield.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
    warehousefield.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    warehousefield.layer.borderWidth = 1;
    warehousefield.layer.cornerRadius = 3;
    warehousefield.layer.masksToBounds = YES;
    [view addSubview:warehousefield];
    warehousefield.delegate = self;
  //  [warehousefield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    _warehousefield = warehousefield;
    
    warehousefield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    warehousefield.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    UILabel * reservoirLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(warehousefield.frame) + 8, self.bounds.size.width - 32, 20)];
    reservoirLabel.text = @"库区:";
    reservoirLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    reservoirLabel.font = [UIFont systemFontOfSize:14];
    reservoirLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:reservoirLabel];
    
    
    UITextField * reservoirfield = [[UITextField alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(reservoirLabel.frame) + 7, self.bounds.size.width - 32, 40)];
    reservoirfield.placeholder = @"请输入库区";
    reservoirfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
    reservoirfield.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    reservoirfield.layer.borderWidth = 1;
    reservoirfield.layer.cornerRadius = 3;
    reservoirfield.layer.masksToBounds = YES;
    [view addSubview:reservoirfield];
    _reservoirfield = reservoirfield;
    reservoirfield.delegate = self;
  //  [reservoirfield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    
    
    reservoirfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    reservoirfield.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    UILabel * storageLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(reservoirfield.frame) + 8, self.bounds.size.width - 32, 20)];
    storageLabel.text = @"储位:";
    storageLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    storageLabel.font = [UIFont systemFontOfSize:14];
    storageLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:storageLabel];
    
    
    UITextField * storagefield = [[UITextField alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(storageLabel.frame) + 7, self.bounds.size.width - 32, 40)];
    storagefield.placeholder = @"请输入储位";
    storagefield.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
    storagefield.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    storagefield.layer.borderWidth = 1;
    storagefield.layer.cornerRadius = 3;
    storagefield.layer.masksToBounds = YES;
    [view addSubview:storagefield];
    storagefield.delegate = self;
  //  [storagefield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    _storagefield = storagefield;
    
    storagefield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    storagefield.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    
    
    UILabel * turnLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(storagefield.frame) + 8, self.bounds.size.width - 32, 20)];
    turnLabel.text = @"匝号:";
    turnLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    turnLabel.font = [UIFont systemFontOfSize:14];
    turnLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:turnLabel];
    
    
    UITextField * turnfield = [[UITextField alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(turnLabel.frame) + 7, self.bounds.size.width - 32, 40)];
    turnfield.placeholder = @"请输入匝号";
    turnfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
    turnfield.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    turnfield.layer.borderWidth = 1;
    turnfield.layer.cornerRadius = 3;
    turnfield.layer.masksToBounds = YES;
    [view addSubview:turnfield];
    _turnfield = turnfield;
    turnfield.delegate = self;
  //  [turnfield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    
    
    turnfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    turnfield.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    //长
    UILabel * longLabel = [[UILabel alloc]init];
    
    longLabel.text = @"长";
    longLabel.textAlignment = NSTextAlignmentLeft;
    longLabel.font = [UIFont systemFontOfSize:16];
    longLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [view addSubview:longLabel];
    
    
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
        if ([self.searchType isEqualToString:@"大板库存"]) {
            //有匝号
            turnLabel.hidden = NO;
            turnfield.hidden = NO;
            
            longLabel.frame = CGRectMake(16, CGRectGetMaxY(turnfield.frame) + 8, self.bounds.size.width - 32, 20);
            
            
            
        }else{
            //没有匝号
            
            turnLabel.hidden = YES;
            turnfield.hidden = YES;
            
            longLabel.frame = CGRectMake(16, CGRectGetMaxY(storagefield.frame) + 8, self.bounds.size.width - 32, 20);
            
        }
    }else if ([self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"] || [self.searchType isEqualToString:@"荒料出库明细"]){
        if ([self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] ) {
            //有匝号
            
            turnLabel.hidden = NO;
            turnfield.hidden = NO;
            
            longLabel.frame = CGRectMake(16, CGRectGetMaxY(turnfield.frame) + 8, self.bounds.size.width - 32, 20);
            
        }else{
            //没有匝号
            turnLabel.hidden = YES;
            turnfield.hidden = YES;
            longLabel.frame = CGRectMake(16, CGRectGetMaxY(storagefield.frame) + 8, self.bounds.size.width - 32, 20);
            
        }
    }
    
    
    
    
    
    
    
    
  
    JJOptionView * longTypeView = [[JJOptionView alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(longLabel.frame) + 8, 112, 40)];
    longTypeView.titleLabel.font = [UIFont systemFontOfSize:13];
    longTypeView.dataSource = @[@"大于",@"等于",@"小于"];
    longTypeView.selectType = @"ruku";
    longTypeView.title = @"请选择类型";
    longTypeView.layer.cornerRadius = 17;
    longTypeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    longTypeView.layer.masksToBounds = YES;
    [view addSubview:longTypeView];
    _longTypeView = longTypeView;
    
    longTypeView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
        
    };
    
    UIView * longView = [[UIView alloc]init];
    longView.frame = CGRectMake(CGRectGetMaxX(longTypeView.frame) + 10, CGRectGetMaxY(longLabel.frame) + 8, 112, 40);
    longView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    [view addSubview:longView];
    longView.layer.cornerRadius = 17;
    
    
    UITextField * longTextfield = [[UITextField alloc]init];
    longTextfield.frame = CGRectMake(0, 0, 80, 40);
    longTextfield.backgroundColor = [UIColor clearColor];
    [longView addSubview:longTextfield];
    
    longTextfield.delegate = self;
    longTextfield.returnKeyType = UIReturnKeyDone;
    _longTextfield = longTextfield;
   // [longTextfield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel * longcmLabel = [[UILabel alloc]init];
    longcmLabel.text = @"mm";
    longcmLabel.frame = CGRectMake(CGRectGetMaxX(longTextfield.frame), 0, 32, 40);
    longcmLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    longcmLabel.font = [UIFont systemFontOfSize:13];
    longcmLabel.textAlignment = NSTextAlignmentLeft;
    [longView addSubview:longcmLabel];
    
    //宽
    UILabel * withLabel = [[UILabel alloc]init];
    withLabel.text = @"宽";
    withLabel.textAlignment = NSTextAlignmentLeft;
    withLabel.font = [UIFont systemFontOfSize:16];
    withLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [view addSubview:withLabel];
    withLabel.frame = CGRectMake(16, CGRectGetMaxY(longTypeView.frame) + 8, self.bounds.size.width - 32, 20);
    
    JJOptionView * withTypeView = [[JJOptionView alloc]initWithFrame:CGRectMake(14, CGRectGetMaxY(withLabel.frame) + 8, 112, 40)];
    withTypeView.titleLabel.font = [UIFont systemFontOfSize:13];
    withTypeView.title = @"请选择类型";
    withTypeView.dataSource = @[@"大于",@"等于",@"小于"];
    withTypeView.selectType = @"ruku";
    withTypeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    withTypeView.layer.cornerRadius = 17;
    withTypeView.layer.masksToBounds = YES;
    [view addSubview:withTypeView];
    _withTypeView = withTypeView;
    
    withTypeView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
        
    };
    
    
    
    UIView * withView = [[UIView alloc]init];
    withView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    [view addSubview:withView];
    withView.frame = CGRectMake(CGRectGetMaxX(withTypeView.frame) + 7, CGRectGetMaxY(withLabel.frame) + 8, 112, 40);
    withView.layer.cornerRadius = 17;
    
    
    UITextField * withTextfield = [[UITextField alloc]init];
    withTextfield.backgroundColor = [UIColor clearColor];
    withTextfield.frame = CGRectMake(0, 0, 80, 40);
    [withView addSubview:withTextfield];
    withTextfield.returnKeyType = UIReturnKeyDone;
    withTextfield.delegate = self;
    _withTextfield = withTextfield;
    
    //[withTextfield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel * withcmLabel = [[UILabel alloc]init];
    withcmLabel.text = @"mm";
    withcmLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    withcmLabel.font = [UIFont systemFontOfSize:13];
    withcmLabel.textAlignment = NSTextAlignmentLeft;
    [withView addSubview:withcmLabel];
    withcmLabel.frame = CGRectMake(CGRectGetMaxX(withTextfield.frame), 0, 32, 40);
    
    
  
    
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor whiteColor];
    bottomview.frame = CGRectMake(0, CGRectGetMaxY(withTypeView.frame) + 10, self.bounds.size.width, 83);
    [view addSubview:bottomview];
    
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
//        if ([self.searchType isEqualToString:@"大板库存"]) {
//            //有匝号
//            turnLabel.hidden = NO;
//            turnfield.hidden = NO;
//
//
//        }else{
//            //没有匝号
//
//            turnLabel.hidden = YES;
//            turnfield.hidden = YES;
//            bottomview.frame = CGRectMake(0, CGRectGetMaxY(withTypeView.frame) + 10, self.bounds.size.width, 83);
//
//
//        }
    }else if ([self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"] || [self.searchType isEqualToString:@"荒料出库明细"]){
//        if ([self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] ) {
//            //有匝号
//
//            turnLabel.hidden = NO;
//            turnfield.hidden = NO;
//            bottomview.frame = CGRectMake(0, CGRectGetMaxY(withTypeView.frame) + 10, self.bounds.size.width, 83);
//
//
//        }else{
//            //没有匝号
//            turnLabel.hidden = YES;
//            turnfield.hidden = YES;
//            bottomview.frame = CGRectMake(0, CGRectGetMaxY(withTypeView.frame) + 10, self.bounds.size.width, 83);
//
//        }
    }else{
        //只有时间
        
        productNameLabel.hidden = YES;
        productNamefield.hidden = YES;
        blockNoLabel.hidden = YES;
        blockNofield.hidden = YES;
        warehouseLabel.hidden = YES;
        warehousefield.hidden = YES;
        reservoirLabel.hidden = YES;
        reservoirfield.hidden = YES;
        storageLabel.hidden = YES;
        storagefield.hidden = YES;
        turnLabel.hidden = YES;
        turnfield.hidden = YES;
        
        longView.hidden = YES;
        longTypeView.hidden = YES;
        longTextfield.hidden = YES;
        longcmLabel.hidden = YES;
        
        
        withView.hidden = YES;
        withLabel.hidden = YES;
        withTypeView.hidden = YES;
        withTextfield.hidden = YES;
        
        bottomview.frame = CGRectMake(0, CGRectGetMaxY(fristBtn.frame) + 10, self.bounds.size.width, 83);
    }
 
    UIButton * resetBtn = [[UIButton alloc]init];
    [resetBtn setBackgroundColor:[UIColor redColor]];
    resetBtn.layer.cornerRadius = 17;
    resetBtn.layer.masksToBounds = YES;
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetBtn addTarget:self action:@selector(DetailOfChargesReData:) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:resetBtn];
    
    UIButton * shangBtn = [[UIButton alloc]init];
    [shangBtn setTitle:@"确定" forState:UIControlStateNormal];
    [shangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shangBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [bottomview addSubview:shangBtn];
    shangBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    shangBtn.layer.cornerRadius = 17;
    shangBtn.layer.masksToBounds = YES;
    
    [shangBtn addTarget:self action:@selector(DetailOfChargesDetermine:) forControlEvents:UIControlEventTouchUpInside];
    //重置
    resetBtn.frame  =  CGRectMake(37, 49, 90, 34);
    shangBtn.frame =  CGRectMake(CGRectGetMaxX(resetBtn.frame) + 19, 49,90, 34);

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
    [adcomps setYear:-1];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
        //_datefrom = currentDateString;
        [fristBtn setTitle:[NSString stringWithFormat:@"%@",currentDateString] forState:UIControlStateNormal];
    }else{
       // _datefrom = beforDate;
        [fristBtn setTitle:[NSString stringWithFormat:@"%@",beforDate] forState:UIControlStateNormal];
    }
//   _Dateto = currentDateString;
    

    [secondBtn setTitle:[NSString stringWithFormat:@"%@",currentDateString] forState:UIControlStateNormal];
    [fristBtn addTarget:self action:@selector(fristSelectTime:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn addTarget:self action:@selector(secondSelectTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [view setupAutoHeightWithBottomView:bottomview bottomMargin:10];
    [view layoutIfNeeded];
    self.tableview.tableHeaderView = view;
}



#pragma mark -- 重置
- (void)DetailOfChargesReData:(UIButton *)resetBtn{
    
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
    
    [adcomps setYear:-1];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
        //_datefrom = currentDateString;
        [_fristBtn setTitle:currentDateString forState:UIControlStateNormal];
    }else{
        
         [_fristBtn setTitle:beforDate forState:UIControlStateNormal];
    }
    //_Dateto = currentDateString;
     [_secondBtn setTitle:currentDateString forState:UIControlStateNormal];
//   // if ([self.searchType isEqualToString:@"大板入库明细"] || [self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"] || [self.searchType isEqualToString:@"荒料出库明细"]) {
//        NSInteger sections = self.tableview.numberOfSections;
//        for (int section = 0; section < sections; section++) {
//            if (section == 0) {
//                NSInteger rows =  [self.tableview numberOfRowsInSection:section];
//                for (int row = 0; row < rows; row++) {
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
//                    RSShaiXuanFristCell * cell  = [self.tableview cellForRowAtIndexPath:indexPath];
//                    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
//                         [cell.fristBtn setTitle:[NSString stringWithFormat:@"%@",currentDateString] forState:UIControlStateNormal];
//                    }else{
//                         [cell.fristBtn setTitle:[NSString stringWithFormat:@"%@",beforDate] forState:UIControlStateNormal];
//                    }
//                    [cell.secondBtn setTitle:[NSString stringWithFormat:@"%@",currentDateString] forState:UIControlStateNormal];
//                }
//            }
//        }
    //}
    
  
    
    
    _productNamefield.text = @"";
    _blockNofield.text = @"";
    _warehousefield.text = @"";
    _storagefield.text = @"";
    _reservoirfield.text = @"";
    _turnfield.text = @"";
    _withTextfield.text = @"";
    _longTextfield.text = @"";
    _longTypeView.title = @"请选择类型";
    _withTypeView.title = @"请选择类型";
    
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]||[self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"] || [self.searchType isEqualToString:@"荒料出库明细"]) {
     
        if ([self.delegate respondsToSelector:@selector(selectorDatefrom:andDateto:andMtlname:andBlockno:andWhsName:andStoreareaName:andLocationName:andTurnsno:andLength:andLengthType:andWidth:andWidthType:)]){
            
            [self.delegate selectorDatefrom:_fristBtn.currentTitle andDateto:_secondBtn.currentTitle andMtlname:_productNamefield.text andBlockno:_blockNofield.text andWhsName:_warehousefield.text andStoreareaName:_reservoirfield.text andLocationName:_storagefield.text andTurnsno:_turnfield.text andLength:_longTextfield.text andLengthType:_longTypeView.title andWidth:_withTextfield.text andWidthType:_withTypeView.title];
            
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(selectorDatefrom:andDateto:)]) {
            [self.delegate selectorDatefrom:_fristBtn.currentTitle andDateto:_secondBtn.currentTitle];
        }
    }
}

#pragma mark -- 确定
- (void)DetailOfChargesDetermine:(UIButton *)shangBtn{
    if ([_fristBtn.currentTitle isEqualToString:@""]) {
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
        
        [adcomps setYear:-1];
        
        [adcomps setMonth:0];
        
        [adcomps setDay:0];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
        NSString *beforDate = [dateFormatter stringFromDate:newdate];
        if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
            //_datefrom = currentDateString;
             [_fristBtn setTitle:currentDateString forState:UIControlStateNormal];
        }else{
             [_fristBtn setTitle:beforDate forState:UIControlStateNormal];
        }
        
        
    }
    if ([_secondBtn.currentTitle isEqualToString:@""]) {
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
        //_Dateto = currentDateString;
        [_secondBtn setTitle:currentDateString forState:UIControlStateNormal];
    }
    
    if ([_productNamefield.text isEqualToString:@""]) {
        _productNamefield.text = @"";
       
    }
    if ([_blockNofield.text isEqualToString:@""]) {
        
        _blockNofield.text = @"";
    }
    if ([_warehousefield.text isEqualToString:@""]) {
        _warehousefield.text = @"";
    }
    if ([_storagefield.text isEqualToString:@""]) {
        _storagefield.text = @"";
    }
    if ([_reservoirfield.text isEqualToString:@""]) {
        _reservoirfield.text = @"";
    }
    
    if ([_turnfield.text isEqualToString:@""]) {
        _turnfield.text = @"";
    }
    
    
    if ([_longTextfield.text isEqualToString:@""]) {
        _longTextfield.text = @"";
    }
    
    if ([_withTextfield.text isEqualToString:@""]) {
        _withTextfield.text = @"";
    }
    
    
    
    
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]||[self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"] || [self.searchType isEqualToString:@"荒料出库明细"]) {
        
        if ([self.delegate respondsToSelector:@selector(selectorDatefrom:andDateto:andMtlname:andBlockno:andWhsName:andStoreareaName:andLocationName:andTurnsno:andLength:andLengthType:andWidth:andWidthType:)]){
            
            [self.delegate selectorDatefrom:_fristBtn.currentTitle andDateto:_secondBtn.currentTitle andMtlname:_productNamefield.text andBlockno:_blockNofield.text andWhsName:_warehousefield.text andStoreareaName:_reservoirfield.text andLocationName:_storagefield.text andTurnsno:_turnfield.text andLength:_longTextfield.text andLengthType:_longTypeView.title andWidth:_withTextfield.text andWidthType:_withTypeView.title];
            
            
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(selectorDatefrom:andDateto:)]) {
            [self.delegate selectorDatefrom:_fristBtn.currentTitle andDateto:_secondBtn.currentTitle];
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]||[self.searchType isEqualToString:@"大板入库明细"]||[self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"] || [self.searchType isEqualToString:@"荒料出库明细"]) {
//        return 2;
//    }else{
//        return 1;
//    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
//    if ([self.searchType isEqualToString:@"荒料库存"] || [self.searchType isEqualToString:@"大板库存"]) {
//        if (section == 0) {
//            return 0;
//        }else{
//            if ([self.searchType isEqualToString:@"大板库存"]) {
//                return 6;
//            }else{
//                return 5;
//            }
//
//        }
//    }else if([self.searchType isEqualToString:@"大板入库明细"] || [self.searchType isEqualToString:@"大板出库明细"] || [self.searchType isEqualToString:@"荒料出库明细"] || [self.searchType isEqualToString:@"荒料入库明细"]){
//        if (section == 0) {
//            return 1;
//        }else{
//            if ([self.searchType isEqualToString:@"大板入库明细"] || [self.searchType isEqualToString:@"大板出库明细"]) {
//                return 6;
//            }else{
//                return 5;
//            }
//        }
//    }else{
//        return 1;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        static NSString * RIGHTID = @"rightid";
        RSShaiXuanFristCell * cell = [tableView dequeueReusableCellWithIdentifier:RIGHTID];
        
        if (!cell) {
            
            cell = [[RSShaiXuanFristCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RIGHTID];
            
        }
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
        [adcomps setYear:-1];
        [adcomps setMonth:0];
        [adcomps setDay:0];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
        NSString *beforDate = [dateFormatter stringFromDate:newdate];
        [cell.fristBtn setTitle:[NSString stringWithFormat:@"%@",beforDate] forState:UIControlStateNormal];
        [cell.secondBtn setTitle:[NSString stringWithFormat:@"%@",currentDateString] forState:UIControlStateNormal];
        [cell.fristBtn addTarget:self action:@selector(fristSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondBtn addTarget:self action:@selector(secondSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * SECONDRIGHTID = @"secondrightid";
        RSShaiXuanSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:SECONDRIGHTID];
        if (!cell) {
            cell = [[RSShaiXuanSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SECONDRIGHTID];
        }
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"物料名称 :";
            cell.namefield.placeholder = @"请输入物料名称";
        }else if (indexPath.row == 1){
            
            cell.nameLabel.text = @"荒料号 :";
            cell.namefield.placeholder = @"请输入荒料号";
        }else if (indexPath.row == 2){
            cell.nameLabel.text = @"仓库 :";
            cell.namefield.placeholder = @"请输入仓库";
            
        }else if (indexPath.row == 3){
            
            cell.nameLabel.text = @"库区 :";
            cell.namefield.placeholder = @"请输入库区";
        }else if (indexPath.row == 4){
            
            cell.nameLabel.text = @"储位 :";
            cell.namefield.placeholder = @"请输入储位";
            
        }else if (indexPath.row == 5){
            
            cell.nameLabel.text = @"匝号 :";
            cell.namefield.placeholder = @"请输入匝号";
            
        }
        
       cell.namefield.delegate = self;
       cell.namefield.tag = 1000000+indexPath.row;
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
     //  [cell.namefield addTarget:self action:@selector(inputCellContent:) forControlEvents:UIControlEventEditingChanged];
        
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0 ) {
//        return ((SCH/568) * 70);
//    }else{
//        return ((SCH/568) * 60);
//    }
    return 0;
}



#pragma mark --  选择第一个时间
- (void)fristSelectTime:(UIButton *)fristBtn{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
  //  NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:-1];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    //NSString *beforDate = [dateFormatter stringFromDate:newdate];
    if ([self.searchType isEqualToString:@"大板库存"] || [self.searchType isEqualToString:@"荒料库存"]) {
        WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:currentDate CompleteBlock:^(NSDate *selectDate) {
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            [fristBtn setTitle:date forState:UIControlStateNormal];
            //起始日期
            //_datefrom
           // _datefrom = date;
        }];
        [datepicker show];
        
        
    }else{
        
        
        WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:newdate CompleteBlock:^(NSDate *selectDate) {
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            [fristBtn setTitle:date forState:UIControlStateNormal];
            //起始日期
            //_datefrom
           // _datefrom = date;
        }];
        [datepicker show];
    }

}

#pragma mark -- 选择第二个时间
- (void)secondSelectTime:(UIButton *)secondBtn{
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:[NSDate date]   CompleteBlock:^(NSDate *selectDate) {
        //截止日期
        //_Dateto
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [secondBtn setTitle:date forState:UIControlStateNormal];
        //_Dateto = date;
    }];
    [datepicker show];
}







-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *tem = [[textField.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if ([tem length] > 0) {
        if (textField == _productNamefield) {
            //物料名称
            //_mtlname
            _productNamefield.text = tem;
            
        }else if (textField == _blockNofield){
            //荒料号
            //_blockno
            _blockNofield.text = tem;
        }else if (textField == _warehousefield){
            //仓库
            //_whsName
            _warehousefield.text = tem;
        }else if (textField == _storagefield){
            //库区
            //_storeareaName
            _storagefield.text = tem;
            
        }else if (textField == _reservoirfield){
            //储位名称
            //_locationName
            _reservoirfield.text = tem;
        }else if (textField == _longTextfield){
            
            _longTextfield.text = tem;
            
        }else if (textField == _withTextfield){
            
            _withTextfield.text = tem;
            
        }else{
            _turnfield.text = tem;
        }
    }else{
        if (textField == _productNamefield) {
            if (textField.text.length < 1) {
                _productNamefield.text =@"";
            }
        }else if (textField == _blockNofield){
            //荒料号
            //_blockno
            if (textField.text.length < 1) {
                _blockNofield.text = @"";
            }
        }else if (textField == _warehousefield){
            //仓库
            if (textField.text.length < 1) {
                _warehousefield.text = @"";
            }
        }else if (textField == _storagefield){
            //库区
            if (textField.text.length < 1) {
                _storagefield.text = @"";
            }
        }else if (textField == _reservoirfield){
            //储位名称
            if (textField.text.length < 1) {
                _reservoirfield.text = @"";
            }
        }else if (textField == _longTextfield){
            if (textField.text.length < 1) {
                _longTextfield.text = @"";
            }
        }else if (textField == _withTextfield){
            if (textField.text.length < 1) {
                _withTextfield.text = @"";
            }
        }else{
            if (textField.text.length < 1) {
                _turnfield.text = @"";
            }
        }
    }
}








-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if (textField == _longTextfield || textField == _withTextfield) {
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single == '.') {
                    if(!isHaveDian)
                    {
                        isHaveDian = YES;
                        return YES;
                        
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 0) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else{
        return YES;
    }
}





@end
