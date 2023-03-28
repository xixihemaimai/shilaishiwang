//
//  RSBigBoardChangeViewController.m
//  石来石往
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSBigBoardChangeViewController.h"
#import "RSAlterationCell.h"
#import "RSRSBigBoardChangeCell.h"
//大板选择物料
#import "RSMaterialManagementViewController.h"

@interface RSBigBoardChangeViewController ()<UITextFieldDelegate>

{
    UITextField * _firstField;
    
    UITextField * _secondField;
    
    UITextField * _thirdField;
    
    UITextField * _fourField;
    
    UIButton * _saveBtn;
}
@property (nonatomic,strong)NSString * btnType;

@property (nonatomic,strong)RSMaterialModel * materialModel;

@end

@implementation RSBigBoardChangeViewController
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
//            if (self.newSaveData) {
//                self.newSaveData(self.contentArray, self.index);
               [self.navigationController popViewControllerAnimated:YES];
//            }
            
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
    _firstField.text = slstoragemanagementmodel.mtlName;
    _secondField.text = slstoragemanagementmodel.mtltypeName;
    _thirdField.text = slstoragemanagementmodel.blockNo;
    _fourField.text = slstoragemanagementmodel.turnsNo;
}



- (void)setBottomUI{
//    if ([self.currentTitle isEqualToString:@"尺寸变更"] || [self.currentTitle isEqualToString:@"物料变更"] || [self.currentTitle isEqualToString:@"断裂处理"]) {
//        for (int i = 0; i < 2; i++) {
//            UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
//            saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//            if (i == 0) {
//                [saveBtn setTitle:@"恢复" forState:UIControlStateNormal];
//                [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
//                saveBtn.frame = CGRectMake(0, SCH - 50, SCW/2, 50);
//                [saveBtn addTarget:self action:@selector(restoreTheOriginalValueSaveAction:) forControlEvents:UIControlEventTouchUpInside];
//            }else{
//                [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//                [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
//                saveBtn.frame = CGRectMake(SCW/2, SCH - 50, SCW/2, 50);
//                [saveBtn addTarget:self action:@selector(ModificationOfPrincipleValueSaveAction:) forControlEvents:UIControlEventTouchUpInside];
//            }
//            [self.view addSubview:saveBtn];
//            [saveBtn bringSubviewToFront:self.view];
//        }
//    }else{
        UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
        saveBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
        [saveBtn addTarget:self action:@selector(screenSaveAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveBtn];
        [saveBtn bringSubviewToFront:self.view];
    _saveBtn = saveBtn;
//    }
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



//异常处理中的按键恢复的功能
//- (void)restoreTheOriginalValueSaveAction:(UIButton *)saveBtn{
//
//      //尺寸变更可以改变第二组的值，物料变更只能改物料名称，断裂处理都可以改变
//
//    //这边都是第一组的
//    for (int i = 0; i < self.bigBoardSecondArray.count; i++) {
//        //RSAlterationCell
//        RSAlterationCell * cell = (RSAlterationCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if (i == 0) {
//            cell.alterationDetailLabel.text = self.choosingInventorymodel.originalProductName;
//        }else if (i == 1){
//            cell.alterationDetailLabel.text = self.choosingInventorymodel.originalProductType;
//
//        }else if (i == 2){
//              cell.alterationDetailLabel.text = self.choosingInventorymodel.originalProductNumber;
//
//        }else{
//            cell.alterationDetailLabel.text = self.choosingInventorymodel.originalTurnNumber;
//        }
//    }
//
//    for (int i = 0; i < self.choosingInventorymodel.selectArray.count; i++) {
//        RSChoosingSliceModel * choosingSlicemodel = self.choosingInventorymodel.selectArray[i];
//        RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
//        /**
//         cell.longDetailLabel.tag = indexPath.row;
//         cell.wideDetialLabel.tag = indexPath.row;
//         cell.thickDeitalLabel.tag = indexPath.row;
//         cell.originalAreaDetailLabel.tag = indexPath.row;
//         cell.deductionAreaDetailLabel.tag = indexPath.row;
//         cell.actualAreaDetailLabel.tag = indexPath.row;
//         */
//        cell.longDetailLabel.text = choosingSlicemodel.originalLenth;
//        cell.wideDetialLabel.text = choosingSlicemodel.originalWide;
//        //厚
//        cell.thickDeitalLabel.text = choosingSlicemodel.originalHeight;
//        cell.originalAreaDetailLabel.text = choosingSlicemodel.originalArea;
//        cell.deductionAreaDetailLabel.text = choosingSlicemodel.originalDeductionArea;
//        cell.actualAreaDetailLabel.text = choosingSlicemodel.originalActualArea;
//    }
//
//
//
//    if (self.recoveryData) {
//        self.recoveryData(self.index, self.choosingInventorymodel, self.currentTitle);
//    }
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}

//异常处理中的按键保存的功能
//- (void)ModificationOfPrincipleValueSaveAction:(UIButton *)saveBtn{
//    //这边都是第一组的
//    for (int i = 0; i < self.bigBoardSecondArray.count; i++) {
//        //RSAlterationCell
//        RSAlterationCell * cell = (RSAlterationCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if (i == 0) {
//            self.choosingInventorymodel.productName  = cell.alterationDetailLabel.text;
//        }else if (i == 1){
//            self.choosingInventorymodel.productType  = cell.alterationDetailLabel.text;
//        }else if (i == 2){
//            self.choosingInventorymodel.productNumber =  cell.alterationDetailLabel.text;
//        }else{
//            self.choosingInventorymodel.turnNumber = cell.alterationDetailLabel.text;
//        }
//    }
//
//    for (int i = 0; i < self.choosingInventorymodel.selectArray.count; i++) {
//        RSChoosingSliceModel * choosingSlicemodel = self.choosingInventorymodel.selectArray[i];
//        RSRSBigBoardChangeCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
//       choosingSlicemodel.lenth = cell.longDetailLabel.text;
//       choosingSlicemodel.wide = cell.wideDetialLabel.text;
//        //厚
//       choosingSlicemodel.height = cell.thickDeitalLabel.text;
//       choosingSlicemodel.area = cell.originalAreaDetailLabel.text;
//       choosingSlicemodel.deductionArea =  cell.deductionAreaDetailLabel.text;
//       choosingSlicemodel.actualArea = cell.actualAreaDetailLabel.text;
//    }
//
//    if (self.saveData) {
//        self.saveData(self.index, self.choosingInventorymodel, self.currentTitle);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}








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
//    if (indexPath.section == 0) {
//        static NSString * BIGBOARDCHANGECELLID = @"BIGBOARDCHANGECELLID";
//        RSAlterationCell * cell = [tableView dequeueReusableCellWithIdentifier:BIGBOARDCHANGECELLID];
//        if (!cell ) {
//            cell = [[RSAlterationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BIGBOARDCHANGECELLID];
//        }
//        cell.alterationLabel.text = self.bigBoardSecondArray[indexPath.row];
//        cell.alterationDetailLabel.delegate = self;
//        if (indexPath.row == 0) {
//           // cell.alterationDetailLabel.text = self.choosingInventorymodel.productName;
//        }else if (indexPath.row == 1){
//           //  cell.alterationDetailLabel.text = self.choosingInventorymodel.productType;
//        }else if (indexPath.row == 2){
//          //   cell.alterationDetailLabel.text = self.choosingInventorymodel.productNumber;
//        }else{
//           //  cell.alterationDetailLabel.text = self.choosingInventorymodel.turnNumber;
//        }
//        cell.alterationDetailLabel.tag = indexPath.row;
//
////        if ([self.currentTitle isEqualToString:@"尺寸变更"]) {
////             cell.alterationDetailLabel.enabled = NO;
////            cell.alterationBtn.hidden = YES;
////            cell.alterationLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
////            cell.alterationDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
////        }else if([self.currentTitle isEqualToString:@"物料变更"]){
////             cell.alterationDetailLabel.enabled = NO;
////            if (indexPath.row == 0) {
////                cell.alterationBtn.hidden = NO;
////                [cell.alterationBtn addTarget:self action:@selector(alterationSelectBigBoardAction:) forControlEvents:UIControlEventTouchUpInside];
////                cell.alterationLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
////                cell.alterationDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
////            }else{
////                cell.alterationLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
////                cell.alterationDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
////                cell.alterationBtn.hidden = YES;
////            }
////        }else{
//
//            if (indexPath.row == 0) {
//                cell.alterationDetailLabel.enabled = NO;
//                cell.alterationBtn.hidden = NO;
//                [cell.alterationBtn addTarget:self action:@selector(alterationSelectBigBoardAction:) forControlEvents:UIControlEventTouchUpInside];
//                cell.alterationLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//                cell.alterationDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//
//               // [cell.alterationDetailLabel addTarget:self action:@selector(alterationDetailSelectAction:) forControlEvents:UIControlEventEditingDidEnd];
//
//
//            }else{
//                cell.alterationDetailLabel.enabled = YES;
//               // cell.alterationLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//                cell.alterationDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//                cell.alterationBtn.hidden = YES;
//            }
////        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }else{
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
    if ([slstoragemanagementmodel.length doubleValue] <= 0.0 ) {
        cell.longDetailLabel.textColor = [UIColor redColor];
    }else{
        cell.longDetailLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    cell.longDetailLabel.tag = indexPath.row;

    cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
    
    
    cell.longDetailLabel.delegate = self;
    
    
    
    if ([slstoragemanagementmodel.width doubleValue] <= 0.0) {
        
        cell.wideDetialLabel.textColor = [UIColor redColor];
    
    }else{
        
        cell.wideDetialLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    
    
    
    cell.wideDetialLabel.tag = indexPath.row;
    cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
        cell.wideDetialLabel.delegate = self;
    
    
    if ([slstoragemanagementmodel.height doubleValue] <= 0.0) {
        cell.thickDeitalLabel.textColor = [UIColor redColor];
        
    }else{
        
        cell.thickDeitalLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    
        cell.thickDeitalLabel.tag = indexPath.row;
    cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
    
        cell.thickDeitalLabel.delegate = self;
    
    
    if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000) {
       
          cell.originalAreaDetailLabel.textColor = [UIColor redColor];
        
    }else{
        
        cell.originalAreaDetailLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    
        cell.originalAreaDetailLabel.tag = indexPath.row;
      cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
    
        cell.originalAreaDetailLabel.delegate = self;
    
    
//    if ([slstoragemanagementmodel.dedArea doubleValue] <= 0.000) {
//
//        cell.deductionAreaDetailLabel.layer.borderColor = [UIColor redColor].CGColor;
//    }else{
//
//        cell.deductionAreaDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
//    }
    
    
        cell.deductionAreaDetailLabel.tag = indexPath.row;
    cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
    
        cell.deductionAreaDetailLabel.delegate = self;
    
    
    if ([slstoragemanagementmodel.area doubleValue] <= 0.000) {
        //cell.actualAreaDetailLabel.layer.borderColor = [UIColor redColor].CGColor;
        cell.actualAreaDetailLabel.textColor = [UIColor redColor];
    }else{
        cell.actualAreaDetailLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
    }
    
    cell.actualAreaDetailLabel.tag = indexPath.row;
    
    cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
    
    cell.actualAreaDetailLabel.delegate = self;
       // cell.filmNumberLabel.text = [NSString stringWithFormat:@"片号 %ld",indexPath.row + 1];
//        if ([self.currentTitle isEqualToString:@"尺寸变更"]) {
//            cell.longDetailLabel.sd_layout.widthIs(85);
//            cell.longDetailLabel.layer.borderWidth = 1;
//            cell.wideDetialLabel.sd_layout.widthIs(85);
//             cell.wideDetialLabel.layer.borderWidth = 1;
//            cell.thickDeitalLabel.sd_layout.widthIs(85);
//             cell.thickDeitalLabel.layer.borderWidth = 1;
//            cell.originalAreaDetailLabel.sd_layout.widthIs(85);
//             cell.originalAreaDetailLabel.layer.borderWidth = 1;
//            cell.deductionAreaDetailLabel.sd_layout.widthIs(85);
//             cell.deductionAreaDetailLabel.layer.borderWidth = 1;
//            cell.actualAreaDetailLabel.sd_layout.widthIs(85);
//             cell.actualAreaDetailLabel.layer.borderWidth = 1;
        
               //[cell.longDetailLabel addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingDidEnd];
               //[cell.wideDetialLabel addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingDidEnd];
               //[cell.thickDeitalLabel addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingDidEnd];
               //[cell.originalAreaDetailLabel addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingDidEnd];
               //[cell.deductionAreaDetailLabel addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingDidEnd];
               //[cell.actualAreaDetailLabel addTarget:self action:@selector(bigBoardChangeTextfieldContent:) forControlEvents:UIControlEventEditingDidEnd];
            
            
//        }else if([self.currentTitle isEqualToString:@"物料变更"]){
//            cell.longDetailLabel.borderStyle = UITextBorderStyleNone;
//            cell.longDetailLabel.layer.borderWidth = 0;
//            cell.longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//            cell.wideDetialLabel.borderStyle = UITextBorderStyleNone;
//             cell.wideDetialLabel.layer.borderWidth = 0;
//            cell.wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//            cell.thickDeitalLabel.borderStyle = UITextBorderStyleNone;
//             cell.thickDeitalLabel.layer.borderWidth = 0;
//            cell.thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//            cell.originalAreaDetailLabel.borderStyle = UITextBorderStyleNone;
//             cell.originalAreaDetailLabel.layer.borderWidth = 0;
//            cell.originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//            cell.deductionAreaDetailLabel.borderStyle = UITextBorderStyleNone;
//             cell.deductionAreaDetailLabel.layer.borderWidth = 0;
//            cell.deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//            cell.actualAreaDetailLabel.borderStyle = UITextBorderStyleNone;
//             cell.actualAreaDetailLabel.layer.borderWidth = 0;
//            cell.actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        }else{
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
            
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
//    }
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
                slstoragemanagementmodel.length = [NSDecimalNumber decimalNumberWithString:@"0.0"];
            }else{
                slstoragemanagementmodel.length = [NSDecimalNumber decimalNumberWithString:cell.longDetailLabel.text];
            }
            if ([cell.longDetailLabel.text length] > 0 && [cell.wideDetialLabel.text length] > 0) {
                //技算原始面积
                cell.originalAreaDetailLabel.text = [self calculateByMultiplying:cell.longDetailLabel.text secondNumber:cell.wideDetialLabel.text];
                slstoragemanagementmodel.preArea =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
            }
            
            if ([cell.originalAreaDetailLabel.text length] > 0 && [cell.deductionAreaDetailLabel.text length] > 0) {
                cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:cell.originalAreaDetailLabel.text secondNumber:cell.deductionAreaDetailLabel.text];
                slstoragemanagementmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
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
                slstoragemanagementmodel.width =[NSDecimalNumber decimalNumberWithString:@"0.0"];
            }else{
                slstoragemanagementmodel.width =[NSDecimalNumber decimalNumberWithString:cell.wideDetialLabel.text];
            }
            if ([cell.longDetailLabel.text length] > 0 && [cell.wideDetialLabel.text length] > 0) {
                //技算原始面积
                cell.originalAreaDetailLabel.text = [self calculateByMultiplying:cell.longDetailLabel.text secondNumber:cell.wideDetialLabel.text];
                slstoragemanagementmodel.preArea =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
            }
            
            
            if ([cell.originalAreaDetailLabel.text length] > 0 && [cell.deductionAreaDetailLabel.text length] > 0) {
                cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:cell.originalAreaDetailLabel.text secondNumber:cell.deductionAreaDetailLabel.text];
                slstoragemanagementmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
    
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
                slstoragemanagementmodel.height =[NSDecimalNumber decimalNumberWithString:@"0.000"];
            }else{
                slstoragemanagementmodel.height =[NSDecimalNumber decimalNumberWithString:cell.thickDeitalLabel.text];
            }
        }else if (cell.originalAreaDetailLabel == textField){
            self.btnType = @"change";
            cell.originalAreaDetailLabel.text = temp;
            slstoragemanagementmodel.preArea =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
            if (cell.originalAreaDetailLabel.text == NULL || [cell.originalAreaDetailLabel.text isEqualToString:@""]) {
                slstoragemanagementmodel.preArea =[NSDecimalNumber decimalNumberWithString:@"0.000"];
            }else{
                slstoragemanagementmodel.preArea =[NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
            }
            if ([cell.originalAreaDetailLabel.text length] > 0 && [cell.deductionAreaDetailLabel.text length] > 0) {
                cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:cell.originalAreaDetailLabel.text secondNumber:cell.deductionAreaDetailLabel.text];
                slstoragemanagementmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
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
                slstoragemanagementmodel.dedArea =[NSDecimalNumber decimalNumberWithString:@"0.000"];
            }else{
                slstoragemanagementmodel.dedArea =[NSDecimalNumber decimalNumberWithString:cell.deductionAreaDetailLabel.text];
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
                slstoragemanagementmodel.area =[NSDecimalNumber decimalNumberWithString:@"0.000"];
            }else{
                slstoragemanagementmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
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
                        if (range.location - ran.location <= 2) {
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
            
            unichar single = [string characterAtIndex:0];
            if ((single >= '0' && single <= '9') || single == '.') {
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
                        if (range.location - ran.location <= 3) {
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
            
            unichar single = [string characterAtIndex:0];
            if ((single >= '0' && single <= '9') || single == '.') {
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
                        if (range.location - ran.location <= 1) {
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
            _saveBtn.frame = CGRectMake(0, SCH - offset - 50, SCW, 50);
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
        _saveBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    }];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    self.tableview.contentSize = CGSizeMake(0, 190 + self.contentArray.count * 128);
//}


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
            if (![slstoragemanagementmodel.slNo isEqualToString:@""] && ![slstoragemanagementmodel.slNo isEqualToString:@"板号"] && [slstoragemanagementmodel.length doubleValue] > 0 && [slstoragemanagementmodel.width doubleValue] > 0 && [slstoragemanagementmodel.height doubleValue] > 0 && [slstoragemanagementmodel.preArea doubleValue] > 0 && [slstoragemanagementmodel.dedArea doubleValue] >= 0.000 && [slstoragemanagementmodel.area doubleValue] > 0) {
                self.btnType = @"new";
                if (self.materialModel.name != nil) {
                    slstoragemanagementmodel.mtlName = _firstField.text;
                    slstoragemanagementmodel.mtltypeName = _secondField.text;
                    slstoragemanagementmodel.mtlId = self.materialModel.MAterialID;
                    slstoragemanagementmodel.mtltypeId = self.materialModel.typeId;
                }
                slstoragemanagementmodel.blockNo = _thirdField.text;
                slstoragemanagementmodel.turnsNo = _fourField.text;
//                slstoragemanagementmodel.slNo = cell.filmNumberTextfield.text;
//                slstoragemanagementmodel.length = [NSDecimalNumber decimalNumberWithString:cell.longDetailLabel.text];
//                slstoragemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:cell.wideDetialLabel.text];
//                slstoragemanagementmodel.height = [NSDecimalNumber decimalNumberWithString:cell.thickDeitalLabel.text];
//                slstoragemanagementmodel.preArea = [NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
                
                if ([slstoragemanagementmodel.dedArea doubleValue] <= 0.000) {
                    cell.deductionAreaDetailLabel.text = @"0.000";
                    slstoragemanagementmodel.dedArea = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                }
                else{
                    slstoragemanagementmodel.dedArea = slstoragemanagementmodel.dedArea;
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
                if ([slstoragemanagementmodel.length doubleValue] <= 0.0 ) {
                    cell.longDetailLabel.text = @"0.0";
                    slstoragemanagementmodel.length = [NSDecimalNumber decimalNumberWithString:@"0.0"];
                }else{
                    cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
                }
                if ([slstoragemanagementmodel.width doubleValue] <= 0.0) {
                    cell.wideDetialLabel.text = @"0.0";
                    slstoragemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:@"0.0"];
                }else{
                    cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
                }
                if ([slstoragemanagementmodel.height doubleValue] <= 0.00 ) {
                    cell.thickDeitalLabel.text = @"0.00";
                    slstoragemanagementmodel.height = [NSDecimalNumber decimalNumberWithString:@"0.00"];
                }else{
                    cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
                }
                if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000 ) {
                    cell.originalAreaDetailLabel.text = @"0.000";
                    slstoragemanagementmodel.preArea = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                }else{
                    cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
                }
                if ([slstoragemanagementmodel.dedArea doubleValue] <= 0.000) {
                    cell.deductionAreaDetailLabel.text = @"0.000";
                    slstoragemanagementmodel.dedArea = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                }else{
                    cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
                }
                if ([slstoragemanagementmodel.area doubleValue] <= 0.000 ) {
                    cell.actualAreaDetailLabel.text = @"0.000";
                    slstoragemanagementmodel.area = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                }else{
                    cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
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
