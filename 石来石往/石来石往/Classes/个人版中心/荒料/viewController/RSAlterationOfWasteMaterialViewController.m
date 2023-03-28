//
//  RSAlterationOfWasteMaterialViewController.m
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSAlterationOfWasteMaterialViewController.h"
#import "RSAlterationCell.h"
#import "RSMaterialModel.h"
//物料管理
#import "RSMaterialManagementViewController.h"
@interface RSAlterationOfWasteMaterialViewController ()<UITextFieldDelegate>
{
    UIButton * _recoveryBtn;
    UIButton * _saveBtn;
    UITextField * _firstTextfield;
    
    UITextField * _secondTextfield;
    
    UITextField * _thirdTextfield ;
    UITextField * _fourTextfield;
    
    UITextField * _fiveTextfield;
    UITextField * _sixTextfield ;
    UITextField * _sevenTextfield;
    UITextField * _eightTextfield;
}
@property (nonatomic,strong)NSString * btnType;


@property (nonatomic,strong)RSMaterialModel * materialModel;
@end

@implementation RSAlterationOfWasteMaterialViewController

- (RSMaterialModel *)materialModel{
    if (!_materialModel) {
        _materialModel = [[RSMaterialModel alloc]init];
    }
    return _materialModel;
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
    contentTitleLabel.text = self.currentTitle;
    contentTitleLabel.font = [UIFont systemFontOfSize:17];
    contentTitleLabel.textColor = [UIColor blackColor];
    contentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navigaionView addSubview:contentTitleLabel];
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, H - 1, SCW, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [navigaionView addSubview:bottomview];
    
}



//返回
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

- (void)viewDidLoad {
    [super viewDidLoad];

    //荒料异常处理
    //尺寸变更详情,物料变更详情
    //self.title = self.currentTitle;
    self.btnType = @"new";
    [self setCustomNavigaionView];

    [self setUIBottomView];
}



- (void)setUIBottomView{
    
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(0, Y, SCW, 45)];
    
    
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#F3F3F3"];
    
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 45)];
    firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:firstView];
    
    UILabel * firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    firstLabel.text = @"物料名称";
    firstLabel.font = [UIFont systemFontOfSize:15];
    firstLabel.textAlignment = NSTextAlignmentLeft;
    //firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [firstView addSubview:firstLabel];
    
    UITextField * firstTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstLabel.frame) + 23, 0, firstView.yj_width/2, 45)];
    _firstTextfield = firstTextfield;
    firstTextfield.placeholder = @"请你选择物料名称";
    firstTextfield.enabled = NO;
    firstTextfield.delegate = self;
    firstTextfield.font = [UIFont systemFontOfSize:15];
  //  firstTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    firstTextfield.textAlignment = NSTextAlignmentLeft;
    firstTextfield.returnKeyType = UIReturnKeyDone;
   // _firstTextfield.text = self.storagemanagementmodel.mtlName;
    [firstView addSubview:firstTextfield];
    
    firstTextfield.keyboardType = UIKeyboardTypeDefault;
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(firstView.yj_width - 40, firstView.yj_height/2 - 14, 28, 28);
    [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    [firstView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(jumpMateriaManagermentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, firstView.yj_height - 1, SCW, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [firstView addSubview:bottomview];
    
    
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstView.frame), SCW, 45)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:secondView];
    
    UILabel * secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    secondLabel.text = @"物料类型";
    secondLabel.font = [UIFont systemFontOfSize:15];
    secondLabel.textAlignment = NSTextAlignmentLeft;
    //secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [secondView addSubview:secondLabel];
    
    UITextField * secondTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(secondLabel.frame) + 23, 0, secondView.yj_width - CGRectGetMaxX(secondLabel.frame) + 23 - 12, 45)];
    //secondTextfield.placeholder = @"请你选择物料名称";
    secondTextfield.font = [UIFont systemFontOfSize:15];
   // secondTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    secondTextfield.textAlignment = NSTextAlignmentLeft;
    secondTextfield.delegate = self;
    secondTextfield.returnKeyType = UIReturnKeyDone;
    [secondView addSubview:secondTextfield];
  //  _secondTextfield.text = self.storagemanagementmodel.mtltypeName;
    _secondTextfield = secondTextfield;
    _secondTextfield.enabled = NO;
    secondTextfield.keyboardType = UIKeyboardTypeDefault;
    UIView * secondbottomview = [[UIView alloc]initWithFrame:CGRectMake(0, firstView.yj_height - 1, SCW, 1)];
    secondbottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [secondView addSubview:secondbottomview];
    
    
    
    
    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame), SCW, 45)];
    thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:thirdView];
    
    UILabel * thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    thirdLabel.text = @"荒料号";
    thirdLabel.font = [UIFont systemFontOfSize:15];
    thirdLabel.textAlignment = NSTextAlignmentLeft;
   // thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [thirdView addSubview:thirdLabel];
    
    UITextField * thirdTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(thirdLabel.frame) + 23, 0, thirdView.yj_width - CGRectGetMaxX(thirdLabel.frame) + 23 - 12, 45)];
    //thirdTextfield.placeholder = @"请你选择物料名称";
    thirdTextfield.font = [UIFont systemFontOfSize:15];
  //  thirdTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    thirdTextfield.textAlignment = NSTextAlignmentLeft;
    [thirdView addSubview:thirdTextfield];
    
    _thirdTextfield = thirdTextfield;
   // _thirdTextfield.text = self.storagemanagementmodel.blockNo;
    thirdTextfield.keyboardType = UIKeyboardTypeDefault;
    thirdTextfield.returnKeyType = UIReturnKeyDone;
    thirdTextfield.delegate = self;
    UIView * thirdbottomview = [[UIView alloc]initWithFrame:CGRectMake(0, thirdView.yj_height - 1, SCW, 1)];
    thirdbottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [thirdView addSubview:thirdbottomview];

    
    UIView * fourView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(thirdView.frame), SCW, 45)];
    fourView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:fourView];
    
    UILabel * fourLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    fourLabel.text = @"长(cm)";
    fourLabel.font = [UIFont systemFontOfSize:15];
    fourLabel.textAlignment = NSTextAlignmentLeft;
 //   fourLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [fourView addSubview:fourLabel];
    
    UITextField * fourTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fourLabel.frame) + 23, 0, fourView.yj_width - CGRectGetMaxX(fourLabel.frame) + 23 - 12, 45)];
    //fourTextfield.placeholder = @"请你选择物料名称";
    fourTextfield.font = [UIFont systemFontOfSize:15];
 //   fourTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    fourTextfield.textAlignment = NSTextAlignmentLeft;
    [fourView addSubview:fourTextfield];
    _fourTextfield = fourTextfield;
    fourTextfield.keyboardType = UIKeyboardTypeDefault;
    fourTextfield.returnKeyType = UIReturnKeyDone;
   // _fourTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.length];
    
    fourTextfield.delegate = self;
    UIView * fourbottomview = [[UIView alloc]initWithFrame:CGRectMake(0, fourView.yj_height - 1, SCW, 1)];
    fourbottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [fourView addSubview:fourbottomview];
    
    
    
    UIView * fiveView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fourView.frame), SCW, 45)];
    fiveView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:fiveView];
    
    UILabel *fiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    fiveLabel.text = @"宽(cm)";
    fiveLabel.font = [UIFont systemFontOfSize:15];
    fiveLabel.textAlignment = NSTextAlignmentLeft;
  //  fiveLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [fiveView addSubview:fiveLabel];
    
    UITextField * fiveTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fiveLabel.frame) + 23, 0, fiveView.yj_width - CGRectGetMaxX(fiveLabel.frame) + 23 - 12, 45)];
    // fiveTextfield.placeholder = @"请你选择物料名称";
    fiveTextfield.font = [UIFont systemFontOfSize:15];
  //  fiveTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    fiveTextfield.textAlignment = NSTextAlignmentLeft;
    [fiveView addSubview:fiveTextfield];
      fiveTextfield.keyboardType = UIKeyboardTypeDefault;
  //  _fiveTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.width];
    fiveTextfield.returnKeyType = UIReturnKeyDone;
    _fiveTextfield = fiveTextfield;
    fiveTextfield.delegate = self;
  
    
    UIView * fivebottomview = [[UIView alloc]initWithFrame:CGRectMake(0, fiveView.yj_height - 1, SCW, 1)];
    fivebottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [fiveView addSubview:fivebottomview];
    
    
    UIView * sixView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fiveView.frame), SCW, 45)];
    sixView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:sixView];
    
    UILabel *sixLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    sixLabel.text = @"高(cm)";
    sixLabel.font = [UIFont systemFontOfSize:15];
    sixLabel.textAlignment = NSTextAlignmentLeft;
   // sixLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [sixView addSubview:sixLabel];
  //  _sixTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.height];
    
    UITextField * sixTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sixLabel.frame) + 23, 0, sixView.yj_width - CGRectGetMaxX(sixLabel.frame) + 23 - 12, 45)];
    //sixTextfield.placeholder = @"请你选择物料名称";
    sixTextfield.font = [UIFont systemFontOfSize:15];
   // sixTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    sixTextfield.textAlignment = NSTextAlignmentLeft;
    [sixView addSubview:sixTextfield];
    sixTextfield.keyboardType = UIKeyboardTypeDefault;
    _sixTextfield = sixTextfield;
    sixTextfield.delegate = self;
    UIView * sixbottomview = [[UIView alloc]initWithFrame:CGRectMake(0, sixView.yj_height - 1, SCW, 1)];
    sixbottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [sixView addSubview:sixbottomview];
    sixTextfield.returnKeyType = UIReturnKeyDone;
    
    
    UIView * sevenView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sixView.frame), SCW, 45)];
    sevenView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:sevenView];
    
    UILabel *sevenLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    sevenLabel.text = @"重量(吨)";
    sevenLabel.font = [UIFont systemFontOfSize:15];
    sevenLabel.textAlignment = NSTextAlignmentLeft;
 //   sevenLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [sevenView addSubview:sevenLabel];
    
    UITextField * sevenTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sevenLabel.frame) + 23, 0, sevenView.yj_width - CGRectGetMaxX(sevenLabel.frame) + 23 - 12, 45)];
    //sevenTextfield.placeholder = @"请你选择物料名称";
    sevenTextfield.font = [UIFont systemFontOfSize:15];
 //   sevenTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    sevenTextfield.textAlignment = NSTextAlignmentLeft;
    [sevenView addSubview:sevenTextfield];
   // _sevenTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.weight];
    _sevenTextfield = sevenTextfield;
    sevenTextfield.keyboardType = UIKeyboardTypeDefault;
    sevenTextfield.delegate = self;
    UIView * sevenbottomview = [[UIView alloc]initWithFrame:CGRectMake(0, sevenView.yj_height - 1, SCW, 1)];
    sevenbottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [sevenView addSubview:sevenbottomview];
    sevenTextfield.returnKeyType = UIReturnKeyDone;
    
    UIView * eightView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sevenView.frame), SCW, 45)];
    eightView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:eightView];
    
    UILabel *eightLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 45)];
    eightLabel.text = @"体积(m³)";
    eightLabel.font = [UIFont systemFontOfSize:15];
    eightLabel.textAlignment = NSTextAlignmentLeft;
 //   eightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [eightView addSubview:eightLabel];
    
    UITextField * eightTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(eightLabel.frame) + 23, 0, eightView.yj_width - CGRectGetMaxX(eightLabel.frame) + 23 - 12, 45)];
    //eightTextfield.placeholder = @"请你选择物料名称";
    eightTextfield.font = [UIFont systemFontOfSize:15];
 //   eightTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    eightTextfield.textAlignment = NSTextAlignmentLeft;
    [eightView addSubview:eightTextfield];
    _eightTextfield = eightTextfield;
   // _eightTextfield.text =[NSString stringWithFormat:@"%@",self.storagemanagementmodel.volume];
    //    _eightTextfield.enabled = NO;
    eightTextfield.keyboardType = UIKeyboardTypeDefault;
    eightTextfield.delegate = self;
    UIView * eightbottomview = [[UIView alloc]initWithFrame:CGRectMake(0, eightView.yj_height - 1, SCW, 1)];
    eightbottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [eightView addSubview:eightbottomview];
    eightTextfield.returnKeyType = UIReturnKeyDone;
    
    [headerView setupAutoHeightWithBottomView:eightView bottomMargin:10];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
   
    
    UIButton * recoveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recoveryBtn.frame = CGRectMake(0, SCH - 50, SCW/2, 50);
    [recoveryBtn setTitle:@"恢复" forState:UIControlStateNormal];
    [recoveryBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
    [recoveryBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    recoveryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [recoveryBtn addTarget:self action:@selector(recoveryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recoveryBtn];
    
    
    
    
    _recoveryBtn = recoveryBtn;
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(CGRectGetMaxX(recoveryBtn.frame), SCH - 50, SCW/2, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn addTarget:self action:@selector(saveAddingBlockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
   
    
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    
    
    
    
    
    _saveBtn = saveBtn;
    if ([self.currentTitle isEqualToString:@"断裂处理"]) {
        _firstTextfield.enabled = NO;
        _secondTextfield.enabled = NO;
        _thirdTextfield.enabled = YES;
        _fourTextfield.enabled = YES;
        _fiveTextfield.enabled = YES;
        _sixTextfield.enabled = YES;
        _sevenTextfield.enabled = YES;
        _eightTextfield.enabled = YES;
         addBtn.hidden = YES;
        firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        firstTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
         secondTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        thirdTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
         fourLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        fourTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        fiveLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        _fiveTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
         sixLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        sixTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
         sevenLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        sevenTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        eightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        eightTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        
    }else if ([self.currentTitle isEqualToString:@"尺寸变更"]){
        
        
        _firstTextfield.enabled = NO;
        _secondTextfield.enabled = NO;
        _thirdTextfield.enabled = NO;
        _fourTextfield.enabled = YES;
        _fiveTextfield.enabled = YES;
        _sixTextfield.enabled = YES;
        _sevenTextfield.enabled = YES;
        _eightTextfield.enabled = NO;
        addBtn.hidden = YES;
        
        firstLabel.textColor =  [UIColor colorWithHexColorStr:@"#666666"];
        firstTextfield.textColor =  [UIColor colorWithHexColorStr:@"#666666"];
        secondLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        secondTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        thirdLabel.textColor =  [UIColor colorWithHexColorStr:@"#666666"];
        thirdTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        fourLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        fourTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        fiveLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        _fiveTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        sixLabel.textColor =[UIColor colorWithHexColorStr:@"#333333"];
        sixTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        sevenLabel.textColor =[UIColor colorWithHexColorStr:@"#333333"];
        sevenTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        eightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        eightTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        
    }else{
        
        _firstTextfield.enabled = NO;
        _secondTextfield.enabled = NO;
        _thirdTextfield.enabled = NO;
        _fourTextfield.enabled = NO;
        _fiveTextfield.enabled = NO;
        _sixTextfield.enabled = NO;
        _sevenTextfield.enabled = NO;
        _eightTextfield.enabled = NO;
        addBtn.hidden = NO;
        
        firstLabel.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
        firstTextfield.textColor =  [UIColor colorWithHexColorStr:@"#333333"];
        secondLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        secondTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        thirdLabel.textColor =  [UIColor colorWithHexColorStr:@"#666666"];
        thirdTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        fourLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        fourTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        fiveLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        _fiveTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        
        sixLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        sixTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        sevenLabel.textColor =[UIColor colorWithHexColorStr:@"#666666"];
        sevenTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        eightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        eightTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];   
    }
    
    _firstTextfield.text = self.storagemanagementmodel.mtlInName;
    _secondTextfield.text = self.storagemanagementmodel.mtltypeInName;
    _thirdTextfield.text = self.storagemanagementmodel.blockNo;
    
    _fourTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.lengthIn];
    _fiveTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.widthIn];
    _sixTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.heightIn];
    _sevenTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.weightIn];
    _eightTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.volumeIn];
}





- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _fourTextfield) {
        if ([_fourTextfield.text isEqualToString:@"0.0"]) {
            _fourTextfield.text = @"";
        }
    }else if (textField == _fiveTextfield){
        if ([_fiveTextfield.text isEqualToString:@"0.0"]) {
            _fiveTextfield.text = @"";
        }
    }else if (textField == _sixTextfield){
        if ([_sixTextfield.text isEqualToString:@"0.00"]) {
            _sixTextfield.text = @"";
        }
    }else if (textField == _sevenTextfield){
        if ([_sevenTextfield.text isEqualToString:@"0.000"]) {
            _sevenTextfield.text = @"";
        }
    }else if (textField == _eightTextfield){
        if ([_eightTextfield.text isEqualToString:@"0.000"]) {
            _eightTextfield.text = @"";
        }
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if (textField == _sixTextfield) {
        
        
        //    限制只能输入数字
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
                           // NSLog(@"最多两位小数");
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
    }else if (textField == _sevenTextfield || textField == _eightTextfield){
        
        
        //    限制只能输入数字
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
//
//        return YES;
    }else if(_fourTextfield == textField || _fiveTextfield == textField){
        
        
        
        //    限制只能输入数字
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
    }else{
        return YES;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if (textField == _secondTextfield) {
         self.btnType = @"change";
        _secondTextfield.text = temp;
        //self.storagemanagementmodel.mtltypeInName = temp;
    }else if (textField == _thirdTextfield){
         self.btnType = @"change";
       // self.storagemanagementmodel.blockNo = temp;
        _thirdTextfield.text = temp;
    }else if (textField == _fourTextfield){
         self.btnType = @"change";
        _fourTextfield.text = temp;
       // self.storagemanagementmodel.lengthIn = [NSDecimalNumber decimalNumberWithString:temp];
        if ([_fourTextfield.text length] > 0 && [_fiveTextfield.text length] > 0 && [_sixTextfield.text length]>0) {
            _eightTextfield.text = [self calculateByMultiplying:_fourTextfield.text secondNumber:_fiveTextfield.text thirdNumber:_sixTextfield.text];
          // self.storagemanagementmodel.vaqty = [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];
          // self.storagemanagementmodel.volumeIn = [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];
        }
    }else if (textField == _fiveTextfield){
         self.btnType = @"change";
        _fiveTextfield.text = temp;
        //self.storagemanagementmodel.widthIn = [NSDecimalNumber decimalNumberWithString:temp];
        if ([_fourTextfield.text length] > 0 && [_fiveTextfield.text length] > 0 && [_sixTextfield.text length]>0) {
            _eightTextfield.text = [self calculateByMultiplying:_fourTextfield.text secondNumber:_fiveTextfield.text thirdNumber:_sixTextfield.text];
           // self.storagemanagementmodel.vaqty =   [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];
           // self.storagemanagementmodel.volumeIn =   [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];
        }
    }else if (textField == _sixTextfield){
         self.btnType = @"change";
         _sixTextfield.text = temp;
        //self.storagemanagementmodel.heightIn = [NSDecimalNumber decimalNumberWithString:temp];
        if ([_fourTextfield.text length] > 0 && [_fiveTextfield.text length] > 0 && [_sixTextfield.text length]>0) {
   
            _eightTextfield.text = [self calculateByMultiplying:_fourTextfield.text secondNumber:_fiveTextfield.text thirdNumber:_sixTextfield.text];
         //   self.storagemanagementmodel.vaqty =   [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];
          //  self.storagemanagementmodel.volumeIn = [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];
        }
    }else if (textField == _sevenTextfield){
         self.btnType = @"change";
        _sevenTextfield.text = temp;
       // self.storagemanagementmodel.weightIn =  [NSDecimalNumber decimalNumberWithString:temp];
    }
}

-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2 thirdNumber:(NSString *)number3
{
    
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    NSDecimalNumber *num3 = [NSDecimalNumber decimalNumberWithString:number3];
    NSDecimalNumber * newNum = [multiplyingNum decimalNumberByMultiplyingBy:num3];
    NSDecimalNumber *num4 = [NSDecimalNumber decimalNumberWithString:@"1000000"];
    //NSDecimalNumber * dividingNum = [newNum decimalNumberByDividingBy:num4];
    NSDecimalNumber * dividingNum =[newNum decimalNumberByDividingBy:num4 withBehavior:Handler];
    return [dividingNum stringValue];
}



//FIXME:恢复
- (void)recoveryAction:(UIButton *)recoveryBtn{
    
    [_firstTextfield resignFirstResponder];
    [_secondTextfield resignFirstResponder];
    [_thirdTextfield resignFirstResponder];
    [_fourTextfield resignFirstResponder];
    [_fiveTextfield resignFirstResponder];
    [_sixTextfield resignFirstResponder];
    [_sevenTextfield resignFirstResponder];
    [_eightTextfield resignFirstResponder];
    
    self.btnType = @"new";
    
    _firstTextfield.text = self.storagemanagementmodel.mtlInName;
    
    _secondTextfield.text = self.storagemanagementmodel.mtltypeInName;
    
    _thirdTextfield.text = self.storagemanagementmodel.blockInNo;
    
    _fourTextfield.text = [NSString stringWithFormat:@"%@",self.storagemanagementmodel.lengthIn];
    
    _fiveTextfield.text =  [NSString stringWithFormat:@"%@",self.storagemanagementmodel.widthIn];
    
    _sixTextfield.text =  [NSString stringWithFormat:@"%@",self.storagemanagementmodel.heightIn];
    
    _sevenTextfield.text =  [NSString stringWithFormat:@"%@",self.storagemanagementmodel.weightIn];
    
    _eightTextfield.text =  [NSString stringWithFormat:@"%@",self.storagemanagementmodel.volumeIn];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLNULL = @"CELLNULL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLNULL];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLNULL];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//FIXME:保存
- (void)saveAddingBlockAction:(UIButton *)saveBtn{
    [_firstTextfield resignFirstResponder];
    [_secondTextfield resignFirstResponder];
    [_thirdTextfield resignFirstResponder];
    [_fourTextfield resignFirstResponder];
    [_fiveTextfield resignFirstResponder];
    [_sixTextfield resignFirstResponder];
    [_sevenTextfield resignFirstResponder];
    [_eightTextfield resignFirstResponder];
    //&& [_sevenTextfield.text length] > 0
    if ([_fiveTextfield.text length] > 0 && [_secondTextfield.text length] > 0 && [_thirdTextfield.text length] > 0 && [_fourTextfield.text length] > 0 && [_fiveTextfield.text length] > 0 && [_sixTextfield.text length] > 0  && [_eightTextfield.text length] > 0) {
        
        if ([self.currentTitle isEqualToString:@"断裂处理"]) {
            if (self.materialModel.name != nil) {
                self.storagemanagementmodel.mtlInId = self.materialModel.MAterialID;
                self.storagemanagementmodel.mtltypeInId = self.materialModel.typeId;
                self.storagemanagementmodel.mtltypeInName = self.materialModel.type;
                self.storagemanagementmodel.mtlInName = self.materialModel.name;
            }
        }else if ([self.currentTitle isEqualToString:@"尺寸变更"]){
            
            
        }else if ([self.currentTitle isEqualToString:@"物料变更"]){
            if (self.materialModel.name != nil) {
                self.storagemanagementmodel.mtlInId = self.materialModel.MAterialID;
                self.storagemanagementmodel.mtltypeInId = self.materialModel.typeId;
                self.storagemanagementmodel.mtltypeInName = self.materialModel.type;
                self.storagemanagementmodel.mtlInName = self.materialModel.name;
            }
        }
//        _eightTextfield.text = [self calculateByMultiplying:_fourTextfield.text secondNumber:_fiveTextfield.text thirdNumber:_sixTextfield.text];
        
//        if ([_sevenTextfield.text isEqualToString:@""]) {
//            _sevenTextfield.text = @"0";
//        }
        self.storagemanagementmodel.mtlName = self.storagemanagementmodel.mtlName;
        self.storagemanagementmodel.mtltypeName = self.storagemanagementmodel.mtltypeName;
        self.storagemanagementmodel.blockInNo = _thirdTextfield.text;
        self.storagemanagementmodel.lengthIn = [NSDecimalNumber decimalNumberWithString:_fourTextfield.text];
      
        self.storagemanagementmodel.widthIn = [NSDecimalNumber decimalNumberWithString:_fiveTextfield.text];
        self.storagemanagementmodel.heightIn =[NSDecimalNumber decimalNumberWithString:_sixTextfield.text];

       // self.storagemanagementmodel.weightIn =  [NSDecimalNumber decimalNumberWithString:_sevenTextfield.text];
        if ([_sevenTextfield.text isEqualToString:@""]) {
            _sevenTextfield.text = @"0.000";
            self.storagemanagementmodel.weight =  [NSDecimalNumber decimalNumberWithString:_sevenTextfield.text];
        }else{
            self.storagemanagementmodel.weight =  [NSDecimalNumber decimalNumberWithString:_sevenTextfield.text];
        }
        
        
        self.storagemanagementmodel.vaqty =   [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];
        self.storagemanagementmodel.volumeIn =  [NSDecimalNumber decimalNumberWithString:_eightTextfield.text];

        self.storagemanagementmodel.qty = 1;
        self.storagemanagementmodel.storeareaName = self.storagemanagementmodel.storeareaName;
        if ([self.delegate respondsToSelector:@selector(passValueIndexpath:andRSStoragemanagementModel:andCurrentTitle:)]) {
            self.btnType = @"new";
            [self.delegate passValueIndexpath:self.index andRSStoragemanagementModel:self.storagemanagementmodel andCurrentTitle:self.currentTitle];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"填写的数据不完整"];
    }
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}



//跳转到物料管理界面
- (void)jumpMateriaManagermentAction:(UIButton *)addBtn{
    RSMaterialManagementViewController * maeriamanagementVc = [[RSMaterialManagementViewController alloc]init];
    maeriamanagementVc.usermodel = self.usermodel;
    maeriamanagementVc.selectType = self.selectType;
    maeriamanagementVc.selectFunctionType = self.selectFunctionType;
    maeriamanagementVc.equallyStr = _firstTextfield.text;
    [self.navigationController pushViewController:maeriamanagementVc animated:YES];
    maeriamanagementVc.selectIndexPathMatermodel = ^(RSMaterialModel * _Nonnull materialmodel) {
        self.btnType = @"change";
        _firstTextfield.text = materialmodel.name;
        //self.storagemanagementmodel.materialId = materialmodel.MAterialID;
        //self.storagemanagementmodel.mtlId = materialmodel.MAterialID;
        //self.storagemanagementmodel.mtlName = materialmodel.name;
        //self.storagemanagementmodel.name = materialmodel.name;
        //self.storagemanagementmodel.mtltypeId = materialmodel.typeId;
        //self.storagemanagementmodel.mtltypeName = materialmodel.type;
        _firstTextfield.text = materialmodel.name;
        self.materialModel = materialmodel;
        _secondTextfield.text = materialmodel.type;
    };
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



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
