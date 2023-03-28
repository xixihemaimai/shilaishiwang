//
//  RSSLChangeContentViewController.m
//  石来石往
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLChangeContentViewController.h"
#import "RSAlterationCell.h"
#import "RSRSBigBoardChangeCell.h"
//大板选择物料
#import "RSMaterialManagementViewController.h"


@interface RSSLChangeContentViewController ()<UITextFieldDelegate>


{
    
    UIButton * _recoveryBtn;
    
    UITextField * _firstField;
    
    UITextField * _secondField;
    
    UITextField * _thirdField;
    
    UITextField * _fourField;
    
    UIButton * _saveBtn;
}
@property (nonatomic,strong)NSString * btnType;

@property (nonatomic,strong)RSMaterialModel * materialModel;



@end

@implementation RSSLChangeContentViewController
- (RSMaterialModel *)materialModel{
    if (!_materialModel) {
        _materialModel = [[RSMaterialModel alloc]init];
    }
    return _materialModel;
}
- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [IQKeyboardManager sharedManager].enable = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnType = @"new";
    
    //self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 256, 0);
    
    
    
    [self setCustomNavigaionView];
    [self setCustomTableviewHeaderView];
    [self setBottomUI];
    
    
    
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
    contentTitleLabel.text = @"编辑大板";
    contentTitleLabel.font = [UIFont systemFontOfSize:17];
    contentTitleLabel.textColor = [UIColor blackColor];
    contentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navigaionView addSubview:contentTitleLabel];
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, H - 1, SCW, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [navigaionView addSubview:bottomview];
    
    
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(navigaionView.frame), SCW , 190 + self.contentArray.count * 128);
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, self.contentArray.count * 128, 0);
}



- (void)backOutAction:(UIButton *)leftBtn{
    if ([self.btnType isEqualToString:@"change"]) {
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





- (void)setCustomTableviewHeaderView{
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#F3F3F3"];
    
    //第一个
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 43)];
    firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:firstView];
    
    UILabel * firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    firstLabel.text = @"物料名称";
    firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:firstLabel];
    
    UITextField * firstField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstLabel.frame) + 21, 13, SCW * 0.6, 21)];
    firstField.enabled = NO;
    firstField.textAlignment = NSTextAlignmentLeft;
    firstField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    firstField.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:firstField];
    _firstField = firstField;
    
    
    
    UIButton * choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    choiceBtn.frame = CGRectMake(SCW - 12 - 28, 9, 28, 28);
    [choiceBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    [firstView addSubview:choiceBtn];
    [choiceBtn addTarget:self action:@selector(alterationSelectBigBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView * firstBottomview = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCW, 1)];
    firstBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [firstView addSubview:firstBottomview];
    
    //第二个
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstView.frame), SCW, 43)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:secondView];
    
    UILabel * secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    secondLabel.text = @"物料类型";
    secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    secondLabel.textAlignment = NSTextAlignmentLeft;
    secondLabel.font = [UIFont systemFontOfSize:15];
    [secondView addSubview:secondLabel];
    
    UITextField * secondField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(secondLabel.frame) + 21, 13, SCW * 0.6, 21)];
    secondField.enabled = NO;
    secondField.textAlignment = NSTextAlignmentLeft;
    secondField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    secondField.font = [UIFont systemFontOfSize:15];
    [secondView addSubview:secondField];
    _secondField = secondField;
    UIView * secondBottomview = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCW, 1)];
    secondBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [secondView addSubview:secondBottomview];
    
    
    
    //第三个
    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame), SCW, 43)];
    thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:thirdView];
    UILabel * thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    thirdLabel.text = @"荒料号";
    thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    thirdLabel.textAlignment = NSTextAlignmentLeft;
    thirdLabel.font = [UIFont systemFontOfSize:15];
    [thirdView addSubview:thirdLabel];
    
    UITextField * thirdField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(thirdLabel.frame) + 21, 13, SCW * 0.6, 21)];
    thirdField.textAlignment = NSTextAlignmentLeft;
    thirdField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    thirdField.font = [UIFont systemFontOfSize:15];
    [thirdView addSubview:thirdField];
    _thirdField = thirdField;
    [_thirdField addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingChanged];
    UIView * thirdBottomview = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCW, 1)];
    thirdBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [thirdView addSubview:thirdBottomview];
    
    
    //第四个
    UIView * fourView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(thirdView.frame), SCW, 43)];
    fourView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:fourView];
    
    UILabel * fourLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    fourLabel.text = @"匝号";
    fourLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    fourLabel.textAlignment = NSTextAlignmentLeft;
    fourLabel.font = [UIFont systemFontOfSize:15];
    [fourView addSubview:fourLabel];
    
    UITextField * fourField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fourLabel.frame) + 21, 13, SCW * 0.6, 21)];
    
    fourField.textAlignment = NSTextAlignmentLeft;
    fourField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    fourField.font = [UIFont systemFontOfSize:15];
    [fourView addSubview:fourField];
    _fourField = fourField;
    [_fourField addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingChanged];
    UIView * fourBottomview = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCW, 1)];
    fourBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [fourView addSubview:fourBottomview];
    [headerView setupAutoHeightWithBottomView:fourView bottomMargin:10];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
    
    RSSLStoragemanagementModel  * slstoragemanagementmodel = self.contentArray[0];
    _firstField.text = slstoragemanagementmodel.mtlInName;
    _secondField.text = slstoragemanagementmodel.mtltypeInName;
    _thirdField.text = slstoragemanagementmodel.blockNo;
    _fourField.text = slstoragemanagementmodel.turnsNo;
    
    if ([self.currentTitle isEqualToString:@"断裂处理"]) {
        
        _firstField.enabled = NO;
        _secondField.enabled = NO;
        _thirdField.enabled = NO;
        _fourField.enabled = YES;
        choiceBtn.enabled = NO;
        choiceBtn.hidden = YES;
        
        
        
    }else if ([self.currentTitle isEqualToString:@"尺寸变更"]){
        
        _firstField.enabled = NO;
        _secondField.enabled = NO;
        _thirdField.enabled = NO;
        _fourField.enabled = NO;
        choiceBtn.enabled = NO;
        choiceBtn.hidden = YES;
        
    }else{
        _firstField.enabled = NO;
        _secondField.enabled = NO;
        _thirdField.enabled = NO;
        _fourField.enabled = NO;
        choiceBtn.enabled = YES;
        choiceBtn.hidden = NO;
    }

}



- (void)setBottomUI{
    UIButton * recoveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [recoveryBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    recoveryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [recoveryBtn setTitle:@"恢复" forState:UIControlStateNormal];
    [recoveryBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
    recoveryBtn.frame = CGRectMake(0, SCH - 50, SCW/2, 50);
    [recoveryBtn addTarget:self action:@selector(restoreTheOriginalValueSaveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recoveryBtn];
    [recoveryBtn bringSubviewToFront:self.view];
  //  _saveBtn = saveBtn;
    _recoveryBtn = recoveryBtn;
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    saveBtn.frame = CGRectMake(CGRectGetMaxX(recoveryBtn.frame), SCH - 50, SCW/2, 50);
    [saveBtn addTarget:self action:@selector(screenSaveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn bringSubviewToFront:self.view];
    _saveBtn = saveBtn;
}



//异常处理中的按键恢复的功能
- (void)restoreTheOriginalValueSaveAction:(UIButton *)recoveryBtn{
//    [self setEditing:YES];
    for (int i = 0 ;i < self.contentArray.count; i++) {
          RSSLStoragemanagementModel * slstoragemangementmodel = self.contentArray[i];
        RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
      
        //物料名称，物料ID，物料类型，物料类型ID
        slstoragemangementmodel.lengthIn = slstoragemangementmodel.length;
        slstoragemangementmodel.widthIn = slstoragemangementmodel.width;
        slstoragemangementmodel.heightIn = slstoragemangementmodel.height;
        slstoragemangementmodel.preAreaIn = slstoragemangementmodel.preArea;
        slstoragemangementmodel.dedAreaIn = slstoragemangementmodel.dedArea;
        slstoragemangementmodel.areaIn = slstoragemangementmodel.area;
        cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemangementmodel.lengthIn doubleValue]];
        cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemangementmodel.widthIn doubleValue]];
        cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemangementmodel.heightIn doubleValue]];
        cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemangementmodel.preAreaIn doubleValue]];
        cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemangementmodel.dedAreaIn doubleValue]];
        cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemangementmodel.areaIn doubleValue]];
  
        _firstField.text = slstoragemangementmodel.mtlName;
        _secondField.text = slstoragemangementmodel.mtltypeName;
        _thirdField.text = slstoragemangementmodel.blockNo;
        _fourField.text = slstoragemangementmodel.turnsNo;
        
    }
    [self.tableview reloadData];
}








- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"BIGBOARDCHANGESECONDCELLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    RSRSBigBoardChangeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell ) {
        cell = [[RSRSBigBoardChangeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.filmNumberTextfield.tag = indexPath.row;
    RSSLStoragemanagementModel * slstoragemanagementmodel = self.contentArray[indexPath.row];
    if ([slstoragemanagementmodel.slNo isEqualToString:@"板号"]|| [slstoragemanagementmodel.slNo isEqualToString:@""]) {
        //cell.filmNumberTextfield.layer.borderColor = [UIColor redColor].CGColor;
        cell.filmNumberTextfield.textColor = [UIColor redColor];
        cell.filmNumberTextfield.text = @"板号";
    }else{
        cell.filmNumberTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        cell.filmNumberTextfield.text = slstoragemanagementmodel.slNo;
    }
    cell.filmNumberTextfield.delegate = self;
    if ([slstoragemanagementmodel.lengthIn doubleValue] <= 0.0 ) {
        cell.longDetailLabel.textColor = [UIColor redColor];
    }else{
        cell.longDetailLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    cell.longDetailLabel.tag = indexPath.row;
    cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.lengthIn doubleValue]];
    cell.longDetailLabel.delegate = self;
    if ([slstoragemanagementmodel.widthIn doubleValue] <= 0.0) {
        cell.wideDetialLabel.textColor = [UIColor redColor];
    }else{
        cell.wideDetialLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    cell.wideDetialLabel.tag = indexPath.row;
    cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]];
    cell.wideDetialLabel.delegate = self;
    if ([slstoragemanagementmodel.heightIn doubleValue] <= 0.0) {
        cell.thickDeitalLabel.textColor = [UIColor redColor];
    }else{
        cell.thickDeitalLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    cell.thickDeitalLabel.tag = indexPath.row;
    cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]];
    cell.thickDeitalLabel.delegate = self;
    if ([slstoragemanagementmodel.preAreaIn doubleValue] <= 0.000) {
        cell.originalAreaDetailLabel.textColor = [UIColor redColor];
    }else{
        cell.originalAreaDetailLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    cell.originalAreaDetailLabel.tag = indexPath.row;
    cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]];
    cell.originalAreaDetailLabel.delegate = self;
    cell.deductionAreaDetailLabel.tag = indexPath.row;
    cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]];
    cell.deductionAreaDetailLabel.delegate = self;
    if ([slstoragemanagementmodel.areaIn doubleValue] <= 0.000) {
        //cell.actualAreaDetailLabel.layer.borderColor = [UIColor redColor].CGColor;
        cell.actualAreaDetailLabel.textColor = [UIColor redColor];
    }else{
        cell.actualAreaDetailLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    cell.actualAreaDetailLabel.tag = indexPath.row;
    cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]];
    cell.actualAreaDetailLabel.delegate = self;
    cell.filmNumberTextfield.layer.borderWidth = 1;
    cell.filmNumberTextfield.sd_layout.widthIs(120);
    [cell.filmNumberTextfield addTarget:self action:@selector(cellContentChangeTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.longDetailLabel.sd_layout.widthIs(85);
    cell.longDetailLabel.layer.borderWidth = 1;
    [cell.longDetailLabel addTarget:self action:@selector(cellContentChangeTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.wideDetialLabel.sd_layout.widthIs(85);
    cell.wideDetialLabel.layer.borderWidth = 1;
    [cell.wideDetialLabel addTarget:self action:@selector(cellContentChangeTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.thickDeitalLabel.sd_layout.widthIs(85);
    cell.thickDeitalLabel.layer.borderWidth = 1;
    [cell.thickDeitalLabel addTarget:self action:@selector(cellContentChangeTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.originalAreaDetailLabel.sd_layout.widthIs(85);
    cell.originalAreaDetailLabel.layer.borderWidth = 1;
    [cell.originalAreaDetailLabel addTarget:self action:@selector(cellContentChangeTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.deductionAreaDetailLabel.sd_layout.widthIs(85);
    cell.deductionAreaDetailLabel.layer.borderWidth = 1;
    [cell.deductionAreaDetailLabel addTarget:self action:@selector(cellContentChangeTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.actualAreaDetailLabel.sd_layout.widthIs(85);
    cell.actualAreaDetailLabel.layer.borderWidth = 1;
    [cell.actualAreaDetailLabel addTarget:self action:@selector(cellContentChangeTextfield:) forControlEvents:UIControlEventEditingChanged];
    
    if ([self.currentTitle isEqualToString:@"断裂处理"]) {
        cell.filmNumberTextfield.enabled = YES;
        cell.longDetailLabel.enabled = YES;
        cell.wideDetialLabel.enabled = YES;
        cell.thickDeitalLabel.enabled = YES;
        cell.originalAreaDetailLabel.enabled = NO;
        cell.deductionAreaDetailLabel.enabled = YES;
        cell.actualAreaDetailLabel.enabled = YES;
        cell.originalAreaDetailLabel.layer.borderWidth = 0;
        
     
    }else if ([self.currentTitle isEqualToString:@"尺寸变更"]){
        
         cell.filmNumberTextfield.enabled = YES;
        cell.longDetailLabel.enabled = YES;
        cell.wideDetialLabel.enabled = YES;
        cell.thickDeitalLabel.enabled = YES;
        cell.originalAreaDetailLabel.enabled = NO;
        cell.deductionAreaDetailLabel.enabled = YES;
        cell.actualAreaDetailLabel.enabled = YES;
         cell.originalAreaDetailLabel.layer.borderWidth = 0;
    }else{
        cell.filmNumberTextfield.enabled = NO;
        cell.longDetailLabel.enabled = NO;
        cell.wideDetialLabel.enabled = NO;
        cell.thickDeitalLabel.enabled = NO;
        cell.originalAreaDetailLabel.enabled = NO;
        cell.deductionAreaDetailLabel.enabled = NO;
        cell.actualAreaDetailLabel.enabled = NO;
         cell.originalAreaDetailLabel.layer.borderWidth = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)cellContentChangeTextfield:(UITextField *)textField{
    NSString * temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    RSSLStoragemanagementModel * slstoragemanagementmodel = self.contentArray[textField.tag];
    if (cell.filmNumberTextfield == textField) {
        self.btnType = @"change";
        cell.filmNumberTextfield.text = temp;
        if (cell.filmNumberTextfield.text == NULL) {
            slstoragemanagementmodel.slNo = @"板号";
        }else{
            slstoragemanagementmodel.slNo = cell.filmNumberTextfield.text;
        }
    }else if (cell.longDetailLabel == textField) {
        self.btnType = @"change";
        cell.longDetailLabel.text = temp;
        if (cell.longDetailLabel.text == NULL || [cell.longDetailLabel.text isEqualToString:@""]) {
            slstoragemanagementmodel.lengthIn =[NSDecimalNumber decimalNumberWithString:@"0.0"];
        }else{
            slstoragemanagementmodel.lengthIn =[NSDecimalNumber decimalNumberWithString:cell.longDetailLabel.text];
        }
        if ([cell.longDetailLabel.text length] > 0 && [cell.wideDetialLabel.text length] > 0) {
            //技算原始面积
            cell.originalAreaDetailLabel.text = [self calculateByMultiplying:cell.longDetailLabel.text secondNumber:cell.wideDetialLabel.text];
            slstoragemanagementmodel.preAreaIn =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
        }
        if ([cell.originalAreaDetailLabel.text length] > 0 && [cell.deductionAreaDetailLabel.text length] > 0) {
            cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:cell.originalAreaDetailLabel.text secondNumber:cell.deductionAreaDetailLabel.text];
            slstoragemanagementmodel.areaIn =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
            
            if ([cell.actualAreaDetailLabel.text containsString:@"-"]) {
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
               
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alertView animated:YES completion:nil];
              
            }
        }
    }else if (cell.wideDetialLabel == textField){
        self.btnType = @"change";
        cell.wideDetialLabel.text = temp;
        
        if (cell.wideDetialLabel.text == NULL || [cell.wideDetialLabel.text isEqualToString:@""]) {
            slstoragemanagementmodel.widthIn =[NSDecimalNumber decimalNumberWithString:@"0.0"];
        }else{
            slstoragemanagementmodel.widthIn =[NSDecimalNumber decimalNumberWithString:cell.wideDetialLabel.text];
        }
        if ([cell.longDetailLabel.text length] > 0 && [cell.wideDetialLabel.text length] > 0) {
            //技算原始面积
            cell.originalAreaDetailLabel.text = [self calculateByMultiplying:cell.longDetailLabel.text secondNumber:cell.wideDetialLabel.text];
            
            slstoragemanagementmodel.preAreaIn =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
            
        }
        if ([cell.originalAreaDetailLabel.text length] > 0 && [cell.deductionAreaDetailLabel.text length] > 0) {
            cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:cell.originalAreaDetailLabel.text secondNumber:cell.deductionAreaDetailLabel.text];
            slstoragemanagementmodel.areaIn =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
            
            if ([cell.actualAreaDetailLabel.text containsString:@"-"]) {
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alertView animated:YES completion:nil];
            }
        }
    }else if (cell.thickDeitalLabel == textField){
        self.btnType = @"change";
        cell.thickDeitalLabel.text = temp;
        if (cell.thickDeitalLabel.text == NULL || [cell.thickDeitalLabel.text isEqualToString:@""]) {
            slstoragemanagementmodel.heightIn =[NSDecimalNumber decimalNumberWithString:@"0.000"];
        }else{
            slstoragemanagementmodel.heightIn =[NSDecimalNumber decimalNumberWithString:cell.thickDeitalLabel.text];
        }
    }else if (cell.originalAreaDetailLabel == textField){
        self.btnType = @"change";
        cell.originalAreaDetailLabel.text = temp;
        slstoragemanagementmodel.preAreaIn =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
        if (cell.originalAreaDetailLabel.text == NULL || [cell.originalAreaDetailLabel.text isEqualToString:@""]) {
            slstoragemanagementmodel.preAreaIn =[NSDecimalNumber decimalNumberWithString:@"0.000"];
        }else{
            slstoragemanagementmodel.preAreaIn =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
        }
        
        
        if ([cell.originalAreaDetailLabel.text length] > 0 && [cell.deductionAreaDetailLabel.text length] > 0) {
            cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:cell.originalAreaDetailLabel.text secondNumber:cell.deductionAreaDetailLabel.text];
            
            slstoragemanagementmodel.areaIn =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
            
            if ([cell.actualAreaDetailLabel.text containsString:@"-"]) {
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alertView animated:YES completion:nil];
            }
        }
    }else if (cell.deductionAreaDetailLabel == textField){
        self.btnType = @"change";
        cell.deductionAreaDetailLabel.text = temp;
        if (cell.deductionAreaDetailLabel.text == NULL || [cell.deductionAreaDetailLabel.text isEqualToString:@""]) {
            slstoragemanagementmodel.dedAreaIn =[NSDecimalNumber decimalNumberWithString:@"0.000"];
        }else{
            slstoragemanagementmodel.dedAreaIn =[NSDecimalNumber decimalNumberWithString:cell.deductionAreaDetailLabel.text];
        }
        if ([cell.originalAreaDetailLabel.text length] > 0 && [cell.deductionAreaDetailLabel.text length] > 0) {
            cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:cell.originalAreaDetailLabel.text secondNumber:cell.deductionAreaDetailLabel.text];
            if ([cell.actualAreaDetailLabel.text containsString:@"-"]) {
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alertView animated:YES completion:nil];
            }
        }
    }else if (cell.actualAreaDetailLabel == textField){
        self.btnType = @"change";
        cell.actualAreaDetailLabel.text = temp;
        if (cell.actualAreaDetailLabel.text == NULL || [cell.actualAreaDetailLabel.text isEqualToString:@""]) {
            slstoragemanagementmodel.areaIn =[NSDecimalNumber decimalNumberWithString:@"0.000"];
        }else{
            slstoragemanagementmodel.areaIn =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
     RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    // RSSLStoragemanagementModel * slstoragemanagementmodel = self.contentArray[textField.tag];
    if (cell.longDetailLabel == textField) {
        self.btnType = @"change";
        if ([cell.longDetailLabel.text isEqualToString:@"0.0"]) {
            cell.longDetailLabel.text = @"";
        }
    }else if (cell.wideDetialLabel == textField){
        self.btnType = @"change";
        if ([cell.wideDetialLabel.text isEqualToString:@"0.0"]) {
            cell.wideDetialLabel.text = @"";
        }
    }else if (cell.thickDeitalLabel == textField){
        self.btnType = @"change";
        if ([cell.thickDeitalLabel.text isEqualToString:@"0.00"]) {
            cell.thickDeitalLabel.text = @"";
        }
    }else if (cell.originalAreaDetailLabel == textField){
        self.btnType = @"change";
        if ([cell.originalAreaDetailLabel.text isEqualToString:@"0.000"]) {
            cell.originalAreaDetailLabel.text = @"";
        }
    }else if (cell.deductionAreaDetailLabel == textField){
        self.btnType = @"change";
        if ([cell.deductionAreaDetailLabel.text isEqualToString:@"0.000"]) {
            cell.deductionAreaDetailLabel.text = @"";
        }
    }else if (cell.actualAreaDetailLabel == textField){
        self.btnType = @"change";
        if ([cell.actualAreaDetailLabel.text isEqualToString:@"0.000"]) {
            cell.actualAreaDetailLabel.text = @"";
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    for (int i = 0 ; i < self.contentArray.count; i++) {
        RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.filmNumberTextfield resignFirstResponder];
        [cell.longDetailLabel resignFirstResponder];
        [cell.wideDetialLabel resignFirstResponder];
        [cell.thickDeitalLabel resignFirstResponder];
        [cell.originalAreaDetailLabel resignFirstResponder];
        [cell.deductionAreaDetailLabel resignFirstResponder];
        [cell.actualAreaDetailLabel resignFirstResponder];
    }
}





-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    if (textField == cell.thickDeitalLabel) {
        
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
                       // NSLog(@"数据格式有误");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
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
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            //NSLog(@"最多两位小数");
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
              //  NSLog(@"数据格式有误");
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
//        //如果输入的是“.”  判断之前已经有"."或者字符串为空
//        if ([string isEqualToString:@"."] && ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""])) {
//            return NO;
//        }
//        //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
//        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
//        [str insertString:string atIndex:range.location];
//        if (str.length >= [str rangeOfString:@"."].location+4){
//            return NO;
//        }
//        return YES;
    }else if (textField == cell.originalAreaDetailLabel || textField == cell.deductionAreaDetailLabel || textField == cell.actualAreaDetailLabel){
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
                        // NSLog(@"数据格式有误");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
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
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
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
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
//        if ([string isEqualToString:@"."] && ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""])) {
//            return NO;
//        }
//        //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
//        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
//        [str insertString:string atIndex:range.location];
//        if (str.length >= [str rangeOfString:@"."].location+5){
//            return NO;
//        }
//        return YES;
    }else if (textField == cell.filmNumberTextfield){
        return YES;
    }else{
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
                        // NSLog(@"数据格式有误");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
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
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 1) {
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
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
//        if ([string isEqualToString:@"."] && ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""])) {
//            return NO;
//        }
//        //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
//        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
//        [str insertString:string atIndex:range.location];
//        if (str.length >= [str rangeOfString:@"."].location+3){
//            return NO;
//        }
//        return YES;
    }
}





//这边是监测每一个textfield的内容
- (void)bigBoardChangeTextfieldContent:(UITextField *)textfield{
    NSString * temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if (textfield == _thirdField){
        self.btnType = @"change";
        _thirdField.text = temp;
    }else if (textfield == _fourField){
        self.btnType = @"change";
        _fourField.text = temp;
    }
}


//长和宽相乘 并转化
-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2
{
    
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    // NSDecimalNumber * newNum = [multiplyingNum decimalNumberByMultiplyingBy:num3];
    NSDecimalNumber *num4 = [NSDecimalNumber decimalNumberWithString:@"10000"];
    //NSDecimalNumber * dividingNum = [newNum decimalNumberByDividingBy:num4];
    NSDecimalNumber * dividingNum =[multiplyingNum decimalNumberByDividingBy:num4 withBehavior:Handler];
    return [dividingNum stringValue];
}

//减
-(NSString *)calculateDecimalByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2{
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber * multiplyingNum = [num1 decimalNumberBySubtracting:num2 withBehavior:Handler];
    return [multiplyingNum stringValue];
}



//大板选择物料
- (void)alterationSelectBigBoardAction:(UIButton *)alterationBtn{
    RSMaterialManagementViewController * materialManagementVc = [[RSMaterialManagementViewController alloc]init];
    materialManagementVc.usermodel = self.usermodel;
    materialManagementVc.selectType = self.selectType;
    materialManagementVc.selectFunctionType = self.selectFunctionType;
    materialManagementVc.equallyStr = _firstField.text;
    [self.navigationController pushViewController:materialManagementVc animated:YES];
    materialManagementVc.selectIndexPathMatermodel = ^(RSMaterialModel * _Nonnull materialmodel) {
        self.btnType = @"change";
        _firstField.text = materialmodel.name;
        self.materialModel = materialmodel;
        _secondField.text = materialmodel.type;
    };
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
            _recoveryBtn.frame = CGRectMake(0, SCH - offset - 50, SCW/2, 50);
            _saveBtn.frame = CGRectMake(CGRectGetMaxX(_recoveryBtn.frame), SCH - offset - 50, SCW/2, 50);
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
        // self.textfield.frame = CGRectMake(0, SCH, SCW, 50);
        _recoveryBtn.frame = CGRectMake(0, SCH - 50, SCW/2, 50);
        _saveBtn.frame = CGRectMake(CGRectGetMaxX(_recoveryBtn.frame), SCH - 50, SCW/2, 50);
    }];
}


//扫描编辑页面的按键的保存
- (void)screenSaveAction:(UIButton *)saveBtn{
    
    [_firstField resignFirstResponder];
    [_secondField resignFirstResponder];
    [_thirdField resignFirstResponder];
    [_fourField resignFirstResponder];
    
    if ([_firstField.text length] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请添加物料名称"];
        return;
    }
    
    if ([_secondField.text length] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请添加物料类型"];
        return;
    }
    
    
    if ([_thirdField.text length] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请添加荒料号"];
        return;
    }
    
    if ([_fourField.text length] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请添加匝号"];
        return;
    }
    
    BOOL isFinish = false;
    for (int i = 0; i < self.contentArray.count; i++) {
        RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.filmNumberTextfield resignFirstResponder];
        [cell.longDetailLabel resignFirstResponder];
        [cell.wideDetialLabel resignFirstResponder];
        [cell.thickDeitalLabel resignFirstResponder];
        [cell.originalAreaDetailLabel resignFirstResponder];
        [cell.deductionAreaDetailLabel resignFirstResponder];
        [cell.actualAreaDetailLabel resignFirstResponder];
        RSSLStoragemanagementModel * slstoragemanagementmodel = self.contentArray[i];
        //&& [cell.deductionAreaDetailLabel.text length] > 0
        if (![slstoragemanagementmodel.slNo isEqualToString:@""] && ![slstoragemanagementmodel.slNo isEqualToString:@"板号"] && [slstoragemanagementmodel.lengthIn doubleValue] > 0 && [slstoragemanagementmodel.widthIn doubleValue] > 0 && [slstoragemanagementmodel.heightIn doubleValue] > 0 && [slstoragemanagementmodel.preAreaIn doubleValue] > 0 && [slstoragemanagementmodel.dedAreaIn doubleValue] >= 0.000 && [slstoragemanagementmodel.areaIn doubleValue] > 0) {
            self.btnType = @"new";
            if (self.materialModel.name != nil) {
                slstoragemanagementmodel.mtlInName = _firstField.text;
                slstoragemanagementmodel.mtltypeInName = _secondField.text;
                slstoragemanagementmodel.mtlInId = self.materialModel.MAterialID;
                slstoragemanagementmodel.mtltypeInId = self.materialModel.typeId;
            }
            slstoragemanagementmodel.blockNo = _thirdField.text;
            slstoragemanagementmodel.turnsNo = _fourField.text;
            //                slstoragemanagementmodel.slNo = cell.filmNumberTextfield.text;
            //                slstoragemanagementmodel.length = [NSDecimalNumber decimalNumberWithString:cell.longDetailLabel.text];
            //                slstoragemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:cell.wideDetialLabel.text];
            //                slstoragemanagementmodel.height = [NSDecimalNumber decimalNumberWithString:cell.thickDeitalLabel.text];
            //                slstoragemanagementmodel.preArea = [NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
            if ([slstoragemanagementmodel.dedAreaIn doubleValue] <= 0.000) {
                cell.deductionAreaDetailLabel.text = @"0.000";
                slstoragemanagementmodel.dedAreaIn = [NSDecimalNumber decimalNumberWithString:@"0.000"];
            }
            else{
                slstoragemanagementmodel.dedAreaIn = slstoragemanagementmodel.dedAreaIn;
            }
            //slstoragemanagementmodel.area = [NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
            isFinish = true;
        }else{
            if ([slstoragemanagementmodel.slNo isEqualToString:@""] || [slstoragemanagementmodel.slNo isEqualToString:@"板号"]) {
                cell.filmNumberTextfield.text = @"板号";
                slstoragemanagementmodel.slNo = @"板号";
            }else{
                
                cell.filmNumberTextfield.text = slstoragemanagementmodel.slNo;
            }
            if ([slstoragemanagementmodel.lengthIn doubleValue] <= 0.0 ) {
                cell.longDetailLabel.text = @"0.0";
                slstoragemanagementmodel.lengthIn = [NSDecimalNumber decimalNumberWithString:@"0.0"];
            }else{
                cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
            }
            if ([slstoragemanagementmodel.widthIn doubleValue] <= 0.0) {
                cell.wideDetialLabel.text = @"0.0";
                slstoragemanagementmodel.widthIn = [NSDecimalNumber decimalNumberWithString:@"0.0"];
                
                
            }else{
                
                cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.widthIn doubleValue]];
            }
            
            if ([slstoragemanagementmodel.heightIn doubleValue] <= 0.00 ) {
                cell.thickDeitalLabel.text = @"0.00";
                slstoragemanagementmodel.heightIn = [NSDecimalNumber decimalNumberWithString:@"0.00"];
            }else{
                cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.heightIn doubleValue]];
            }
            if ([slstoragemanagementmodel.preAreaIn doubleValue] <= 0.000 ) {
                cell.originalAreaDetailLabel.text = @"0.000";
                slstoragemanagementmodel.preAreaIn = [NSDecimalNumber decimalNumberWithString:@"0.000"];
            }else{
                cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preAreaIn doubleValue]];
            }
            
            if ([slstoragemanagementmodel.dedAreaIn doubleValue] <= 0.000) {
                cell.deductionAreaDetailLabel.text = @"0.000";
                slstoragemanagementmodel.dedAreaIn = [NSDecimalNumber decimalNumberWithString:@"0.000"];
            }else{
                cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedAreaIn doubleValue]];
            }
            if ([slstoragemanagementmodel.areaIn doubleValue] <= 0.000 ) {
                cell.actualAreaDetailLabel.text = @"0.000";
                slstoragemanagementmodel.areaIn = [NSDecimalNumber decimalNumberWithString:@"0.000"];
            }else{
                
                cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.areaIn doubleValue]];
            }
            self.btnType = @"change";
            isFinish = false;
            break;
        }
    }
    
    if (isFinish) {
        //把改的值传递回去
        if (self.newSaveData) {
            self.newSaveData(self.contentArray, self.index);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self.tableview reloadData];
        self.btnType = @"change";
        [SVProgressHUD showInfoWithStatus:@"填写的数据不完整"];
    }
    //    for (int i = 0; i < self.bigBoardSecondArray.count; i++) {
    //        //RSAlterationCell
    //        RSAlterationCell * cell = (RSAlterationCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    //        if (i == 0) {
    //           // self.choosingInventorymodel.productName  = cell.alterationDetailLabel.text;
    //        }else if (i == 1){
    //            //self.choosingInventorymodel.productType  = cell.alterationDetailLabel.text;
    //        }else if (i == 2){
    //            //self.choosingInventorymodel.productNumber =  cell.alterationDetailLabel.text;
    //        }else{
    //            //self.choosingInventorymodel.turnNumber = cell.alterationDetailLabel.text;
    //        }
    //    }
    
    //    for (int i = 0; i < self.choosingInventorymodel.selectArray.count; i++) {
    //        RSChoosingSliceModel * choosingSlicemodel = self.choosingInventorymodel.selectArray[i];
    //        RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
    //        choosingSlicemodel.lenth = cell.longDetailLabel.text;
    //        choosingSlicemodel.wide = cell.wideDetialLabel.text;
    //        //厚
    //        choosingSlicemodel.height = cell.thickDeitalLabel.text;
    //        choosingSlicemodel.area = cell.originalAreaDetailLabel.text;
    //        choosingSlicemodel.deductionArea =  cell.deductionAreaDetailLabel.text;
    //        choosingSlicemodel.actualArea = cell.actualAreaDetailLabel.text;
    //    }
    
    //    if (self.saveData) {
    //        self.saveData(self.index, self.choosingInventorymodel, self.currentTitle);
    //    }
    //    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



@end
