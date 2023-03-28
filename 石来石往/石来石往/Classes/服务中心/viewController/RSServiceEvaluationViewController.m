//
//  RSServiceEvaluationViewController.m
//  石来石往
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceEvaluationViewController.h"

#import "RSPublishButton.h"
#define margin 18
#define ECA 4
#define STARECA 1

#import "RSEvaluate.h"

#import "XHStarRateView.h"


//多个服务人员的界面
#import "RSEvaluationServiceStarView.h"

@interface RSServiceEvaluationViewController ()<UITextViewDelegate>
{
    
    
    UIView *  _starView;
    
    /**评论内容的首先显示的东西*/
    UILabel * _commentLabel;
    
    /**用来保存评论的内容*/
    NSString * _tempStr;
    
    UITextView * _commentTextview;
    
    
}

//@property (nonatomic,strong)UITableView * tableview;

/**
*按钮选中中间值
*/
@property(nonatomic,strong)UIButton * selectedBtn;



/**用来存储选择多个服务人员星级评价的数组*/
@property (nonatomic,strong)NSMutableArray * starArray;


/**用来存储多个服务人员的数组*/
@property (nonatomic,strong)NSMutableArray * serviceArray;


/**这边是记录选择表情的*/
@property (nonatomic,assign)NSInteger smileTeger;


/**提交*/
@property (nonatomic,strong)UIButton * submitBtn;



@end

@implementation RSServiceEvaluationViewController



- (NSMutableArray *)starArray{
    
    if (_starArray == nil) {
        _starArray = [NSMutableArray array];
    }
    
    return _starArray;
}

- (NSMutableArray *)serviceArray{
    if (_serviceArray == nil) {
        _serviceArray = [NSMutableArray array];
    }
    return _serviceArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    self.title = @"评价";
    _smileTeger = 0;
    
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }

    [self isAddjust];
    [self.view addSubview:self.tableview];

    [self loadServicePepoleNetWorkDataType];
    
   
}


- (void)setUICustomEvaluationHeaderview{
    
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, navY + navHeight, 0);
//    [self.view addSubview:self.tableview];
    
    UIView * headview = [[UIView alloc]init];
    headview.backgroundColor = [UIColor whiteColor];
    
    
    //表情
    UIView * smileView = [[UIView alloc]init];
    smileView.backgroundColor = [UIColor whiteColor];
    [headview addSubview:smileView];
    
    
    //表情上面部分
    UIView * topSmileView = [[UIView alloc]init];
    topSmileView.backgroundColor = [UIColor clearColor];
    [smileView addSubview:topSmileView];
    
    //添加了俩行提示语句
    UILabel * topSmileLabel = [[UILabel alloc]init];
    topSmileLabel.text = @"服务已完成";
    topSmileLabel.textAlignment = NSTextAlignmentCenter;
    topSmileLabel.font = [UIFont systemFontOfSize:24];
    topSmileLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [topSmileView addSubview:topSmileLabel];
    
    
    UILabel * topSmileIntroductLabel = [[UILabel alloc]init];
    topSmileIntroductLabel.text = @"您的评价对我们的服务人员至关重要,";
    topSmileIntroductLabel.textAlignment = NSTextAlignmentCenter;
    topSmileIntroductLabel.font = [UIFont systemFontOfSize:18];
    topSmileIntroductLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [topSmileView addSubview:topSmileIntroductLabel];
    
    
    
    UILabel * topSmileTwoIntroductLabel = [[UILabel alloc]init];
    topSmileTwoIntroductLabel.text = @"请谨慎评价";
    topSmileTwoIntroductLabel.textAlignment = NSTextAlignmentCenter;
    topSmileTwoIntroductLabel.font = [UIFont systemFontOfSize:18];
    topSmileTwoIntroductLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [topSmileView addSubview:topSmileTwoIntroductLabel];
    
    
    
    
    UIView * topSmileBottomView = [[UIView alloc]init];
    topSmileBottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [topSmileView addSubview:topSmileBottomView];
    
    //表情下面部分
    UIView * bottomSmileView = [[UIView alloc]init];
    bottomSmileView.backgroundColor = [UIColor whiteColor];
    [smileView addSubview:bottomSmileView];
    
    
    //表情下面要选择的界面
    UIView * bottomChoiceSmileView = [[UIView alloc]init];
    bottomChoiceSmileView.backgroundColor = [UIColor clearColor];
    [bottomSmileView addSubview:bottomChoiceSmileView];
    
    
    NSArray * imageArray = @[@"差1",@"一般1",@"很不错1",@"非常满意1"];
    NSArray * highImageArray = @[@"差",@"一般",@"很不错",@"非常满意"];
    NSArray * titleArray = @[@"差",@"一般",@"很不错",@"很满意"];
    CGFloat btnW = ((SCW - (40)) - (ECA + 1)*margin)/ECA;
    //CGFloat btnW = 56;
    CGFloat btnH = Height_Real(80);
    
//    if (iPhone6){
//        btnH = autoSizeScale6Y * 80;
//    }else if (iPhone6p){
//        btnH = autoSizeScale6px * 80;
//    }else{
//        btnH = autoSizeScalexY * 80;
//    }
    
    for (int i = 0 ; i < imageArray.count; i++) {
        RSEvaluate * evaluateBtn = [[RSEvaluate alloc]init];
        //NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        evaluateBtn.tag = 100000 + i;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        //CGFloat btnY =  row * (margin + btnH) + margin;
        evaluateBtn.frame = CGRectMake(btnX, 15, btnW, btnH);
        [evaluateBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [evaluateBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [evaluateBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [evaluateBtn setImage:[UIImage imageNamed:highImageArray[i]] forState:UIControlStateSelected];
        [bottomChoiceSmileView addSubview:evaluateBtn];
        [evaluateBtn addTarget:self action:@selector(evaluateStyle:) forControlEvents:UIControlEventTouchUpInside];
    }
    //评星的总界--- 要是有多个服务人员的评价
    UIView * starView = [[UIView alloc]init];
    starView.backgroundColor = [UIColor colorWithHexColorStr:@"#F3F3F3"];
    [headview addSubview:starView];
    _starView = starView;
    
    
    CGFloat StarViewH = 140;
    RSWeakself;
    RSEvaluationServiceStarView * evaluationServiceStarview;
    for (int i = 0; i < self.serviceArray.count; i++) {
        
        NSInteger row = i / STARECA;
        
        CGFloat starViewY = row * (margin + StarViewH) + margin;
        
        evaluationServiceStarview = [[RSEvaluationServiceStarView alloc]init];
        
        
         RSServicePepleModel * servicePeplemdodel = self.serviceArray[i];
        
        evaluationServiceStarview.starRateView3.tag = [servicePeplemdodel.serviceUserId integerValue];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:servicePeplemdodel.img]];
        
        evaluationServiceStarview.servicePeopleImageview.image = [UIImage imageWithData:data];
        evaluationServiceStarview.servicePeopleImageview.contentMode = UIViewContentModeScaleAspectFill;
        evaluationServiceStarview.servicePeopleImageview.clipsToBounds = YES;
        evaluationServiceStarview.servicePeopleLabel.text = [NSString stringWithFormat:@"%@",servicePeplemdodel.userName];
        CGFloat starScore = 0.0;
        //NSInteger index = 100000000+i;
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        //[dict setValue:[NSString stringWithFormat:@"%ld",index] forKey:@"starRateView3.tag"];
        [dict setObject:[NSString stringWithFormat:@"%@",servicePeplemdodel.serviceUserId] forKey:@"serviceUserId"];
        [dict setValue:[NSString stringWithFormat:@"%lf",starScore] forKey:@"starLevel"];
        [weakSelf.starArray addObject:dict];
        evaluationServiceStarview.starRateView3.userInteractionEnabled = NO;
        
        //方法1
        XHStarRateView * starRateView3 = evaluationServiceStarview.starRateView3;
        //方法2
        //NSInteger index = evaluationServiceStarview.starRateView3.tag;
        evaluationServiceStarview.starRateView3.complete = ^(CGFloat currentScore) {
            CGFloat starScore = currentScore;
            //这边要添加的到数组中，需要判断条件
            for (int j = 0; j < weakSelf.starArray.count; j++) {
                NSMutableDictionary * dict = weakSelf.starArray[j];
                NSInteger starTag = [[dict objectForKey:@"serviceUserId"] integerValue];
                if (starTag == starRateView3.tag) {
                    [dict setValue:[NSString stringWithFormat:@"%ld",(long)starTag] forKey:@"serviceUserId"];
                    [dict setValue:[NSString stringWithFormat:@"%lf",starScore] forKey:@"starLevel"];
                    [weakSelf.starArray replaceObjectAtIndex:j withObject:dict];
                    break;
                }
            }
            for (int j = 0; j<weakSelf.starArray.count; j++) {
                NSMutableDictionary * dict = weakSelf.starArray[j];
                //这边是判断提交按键能不能点击
                CGFloat starScoreNumber = [[dict objectForKey:@"starLevel"] integerValue];
                if (starScoreNumber == 0) {
                    _submitBtn.enabled = NO;
                    [_submitBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D1D1D1"]];
                    break;
                }else{
                    if (_smileTeger != 0) {
                        _submitBtn.enabled = YES;
                        [_submitBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
                        
                    }else{
                        _submitBtn.enabled = NO;
                        [_submitBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D1D1D1"]];
                        break;
                    }
                }
            }
        };
        evaluationServiceStarview.frame = CGRectMake(0, starViewY, SCW, StarViewH);
        evaluationServiceStarview.backgroundColor = [UIColor yellowColor];
        [starView addSubview:evaluationServiceStarview];
    }
    
    UITextView * commentTextview = [[UITextView alloc]init];
    commentTextview.delegate = self;
    commentTextview.backgroundColor = [UIColor whiteColor];
    commentTextview.layer.borderWidth = 1;
    commentTextview.layer.borderColor = [UIColor colorWithHexColorStr:@"#f0f0f0"].CGColor;
    commentTextview.layer.cornerRadius = 4;
    commentTextview.layer.masksToBounds = YES;
    [headview addSubview:commentTextview];
    _commentTextview = commentTextview;
    UILabel * commentLabel = [[UILabel alloc] init];
    commentLabel.text = @"请输入评论内容";
    commentLabel.textColor = [UIColor colorWithWhite:0.4 alpha:0.6];
    commentLabel.font = [UIFont systemFontOfSize:12.0];
    commentLabel.enabled = NO; // lable必须设置为不可用
    commentLabel.backgroundColor = [UIColor clearColor];
    [commentTextview addSubview:commentLabel];
    _commentLabel = commentLabel;
    
    smileView.sd_layout
    .leftSpaceToView(headview, 0)
    .topSpaceToView(headview, 0)
    .rightSpaceToView(headview, 0)
    .heightIs(216);
    
    
    topSmileView.sd_layout
    .leftSpaceToView(smileView, 0)
    .topSpaceToView(smileView, 0)
    .rightSpaceToView(smileView, 0)
    .heightIs(115);
    
    topSmileLabel.sd_layout
    .leftSpaceToView(topSmileView, 15)
    .rightSpaceToView(topSmileView, 15)
    .topSpaceToView(topSmileView, 20)
    .heightIs(24);
    
    
    topSmileIntroductLabel.sd_layout
    .leftSpaceToView(topSmileView, 15)
    .rightSpaceToView(topSmileView, 15)
    .topSpaceToView(topSmileLabel, 15)
    .heightIs(15);
    
    
    topSmileTwoIntroductLabel.sd_layout
    .leftEqualToView(topSmileIntroductLabel)
    .rightEqualToView(topSmileIntroductLabel)
    .topSpaceToView(topSmileIntroductLabel, 5)
    .heightIs(15);
    
    
    
    topSmileBottomView.sd_layout
    .leftSpaceToView(topSmileView, 25)
    .rightSpaceToView(topSmileView, 25)
    .bottomSpaceToView(topSmileView, 0)
    .heightIs(1);
    
    
    
    
    bottomSmileView.sd_layout
    .leftSpaceToView(smileView, 0)
    .rightSpaceToView(smileView, 0)
    .topSpaceToView(topSmileView, 0)
    .bottomSpaceToView(smileView, 0);
    
    
    bottomChoiceSmileView.sd_layout
    .leftSpaceToView(bottomSmileView, 20)
    .topSpaceToView(bottomSmileView, 0)
    .bottomSpaceToView(bottomSmileView, 0)
    .rightSpaceToView(bottomSmileView, 20);
    
    
    starView.sd_layout
    .leftSpaceToView(headview, 0)
    .rightSpaceToView(headview, 0)
    .topSpaceToView(smileView, 8)
    .autoHeightRatio(0);
    
    
    
    commentTextview.sd_layout
    .topSpaceToView(starView, 10)
    .leftSpaceToView(headview, 12)
    .rightSpaceToView(headview, 12)
    .heightIs(140);
    
    commentLabel.sd_layout
    .leftSpaceToView(commentTextview, 4)
    .rightSpaceToView(commentTextview, 12)
    .topSpaceToView(commentTextview, 5)
    .heightIs(15);
    
    
    //提交
    UIButton * submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    //[submitBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [submitBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D1D1D1"]];
    submitBtn.enabled = NO;
    submitBtn.layer.cornerRadius = 11;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    submitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:submitBtn];
    _submitBtn = submitBtn;
    submitBtn.sd_layout
    .leftSpaceToView(headview, 24)
    .rightSpaceToView(headview, 24)
    .topSpaceToView(commentTextview, 26)
    .heightIs(45);
    [starView setupAutoHeightWithBottomView:evaluationServiceStarview bottomMargin:0];
    [headview setupAutoHeightWithBottomView:submitBtn bottomMargin:19];
    [headview layoutSubviews];
    self.tableview.tableHeaderView = headview;
}


- (void)loadServicePepoleNetWorkDataType{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:@"1" forKey:@"search"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SERVICESEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf.serviceArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int i = 0; i < array.count; i++) {
                    RSServicePepleModel * servicePeplemdodel = [[RSServicePepleModel alloc]init];
                    servicePeplemdodel.img = [[array objectAtIndex:i]objectForKey:@"img"];
                    servicePeplemdodel.phone = [[array objectAtIndex:i]objectForKey:@"phone"];
                    servicePeplemdodel.userName = [[array objectAtIndex:i]objectForKey:@"userName"];
                    servicePeplemdodel.serviceUserId = [[array objectAtIndex:i]objectForKey:@"serviceUserId"];
                    [weakSelf.serviceArray addObject:servicePeplemdodel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setUICustomEvaluationHeaderview];
                    [weakSelf.tableview reloadData];
                });
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取服务器失败"];
        }
    }];
}

- (void)evaluateStyle:(RSEvaluate *)evaluateBtn{
    if(evaluateBtn != self.selectedBtn){
        self.selectedBtn.selected = NO ;
        evaluateBtn.selected = YES ;
        self.selectedBtn = evaluateBtn;
        switch (evaluateBtn.tag) {
            case 100000:
                _smileTeger = 1;
                break;
            case 100001:
                _smileTeger = 2;
                break;
            case 100002:
                _smileTeger = 3;
                break;
            case 100003:
                _smileTeger = 4;
                break;
        }
        for (RSEvaluationServiceStarView * evaluationServiceStarview in _starView.subviews) {
            evaluationServiceStarview.starRateView3.userInteractionEnabled = YES;
        }
    } else {
        self.selectedBtn.selected  =  YES ;
    }
}



- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    
    NSRange range = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 500)
    {
        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            //在这里做你响应return键的代码
            [textView resignFirstResponder];
            return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        }
        return  YES;
    } else {
        return NO;
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([temp length] < 1) {
            _commentLabel.text = @"请输入评论内容";
          //  temp = [self delSpaceAndNewline:temp];
            
        }else{
            _commentLabel.text = @"";
            //_tempStr = @"";
        }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 0;
} 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ESERVICEMARKETID = @"ESERVICEMARKETID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ESERVICEMARKETID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ESERVICEMARKETID];
    }
    return cell;
}


//FIXME:提交
- (void)submitAction:(UIButton *)btn{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    [dict setObject:_commentTextview.text forKey:@"serviceComment"];
    [dict setObject:[NSString stringWithFormat:@"%ld",_smileTeger] forKey:@"serviceEvalLevel"];
    [dict setObject:self.starArray forKey:@"serviceUserEvalList"];
    [dict setObject:self.usermodel.userName forKey:@"userName"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_STARSERVICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                if (weakSelf.completesubmit) {
                    weakSelf.completesubmit();
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"提交失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"提交失败"];
        }
    }];
}


- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
