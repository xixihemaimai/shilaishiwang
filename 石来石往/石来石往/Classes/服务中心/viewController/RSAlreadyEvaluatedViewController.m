//
//  RSAlreadyEvaluatedViewController.m
//  石来石往
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAlreadyEvaluatedViewController.h"
//#import "RSPublishButton.h"
#define margin 18
#define ECA 4
#define STARECA 1
#import "RSEvaluate.h"

#import "XHStarRateView.h"

#import "RSServiceEvalModel.h"
#import "RSServiceSecondEvalModel.h"




//多个服务人员的界面
#import "RSAlreadEvaluationServiceStarView.h"

@interface RSAlreadyEvaluatedViewController ()


//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)NSMutableArray * alreadyArray;


@end

@implementation RSAlreadyEvaluatedViewController

- (NSMutableArray *)alreadyArray{
    if (_alreadyArray == nil) {
        _alreadyArray = [NSMutableArray array];
    }
    return _alreadyArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.title = @"评价";
    
    
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    [self isAddjust];
    [self.view addSubview:self.tableview];
    
    //[self setUIAlreadyEvaluated];
    
    
    [self alreadRoalEvaluatedNetworkData];
}

- (void)alreadRoalEvaluatedNetworkData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SHOWSERVICEEVAL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int i = 0; i < array.count; i++) {
                    RSServiceEvalModel * serviceEvalmodel = [[RSServiceEvalModel alloc]init];
                    serviceEvalmodel.serviceId = [[array objectAtIndex:i]objectForKey:@"serviceId"];
                    serviceEvalmodel.userId = [[array objectAtIndex:i]objectForKey:@"userId"];
                    serviceEvalmodel.userName = [[array objectAtIndex:i]objectForKey:@"userName"];
                    serviceEvalmodel.serviceComment = [[array objectAtIndex:i]objectForKey:@"serviceComment"];
                    serviceEvalmodel.serviceEvalLevel = [[array objectAtIndex:i]objectForKey:@"serviceEvalLevel"];
                    NSMutableArray * tempArray = [NSMutableArray array];
                    tempArray = [[array objectAtIndex:i]objectForKey:@"serviceUserEvalList"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSServiceSecondEvalModel * serviceSecondEvalmodel = [[RSServiceSecondEvalModel alloc]init];
                        serviceSecondEvalmodel.name = [[tempArray objectAtIndex:j]objectForKey:@"name"];
                        serviceSecondEvalmodel.serviceUserId = [[tempArray objectAtIndex:j]objectForKey:@"serviceUserId"];
                        serviceSecondEvalmodel.starLevel = [[tempArray objectAtIndex:j]objectForKey:@"starLevel"];
                        serviceSecondEvalmodel.userHead = [[tempArray objectAtIndex:j]objectForKey:@"userHead"];
                        [serviceEvalmodel.serviceUserEvalList addObject:serviceSecondEvalmodel];
                    }
                    [weakSelf.alreadyArray addObject:serviceEvalmodel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setUIAlreadyEvaluated];
                    [weakSelf.tableview reloadData];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


- (void)setUIAlreadyEvaluated{
    RSServiceEvalModel * serviceEvalmodel = self.alreadyArray[0];
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, navY + navHeight, 0);
//    [self.view addSubview:self.tableview];

    
    UIView * headview = [[UIView alloc]init];
    headview.backgroundColor = [UIColor colorWithHexColorStr:@"#F3F3F3"];
    
    
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
    topSmileIntroductLabel.text = @"总体评价";
    topSmileIntroductLabel.textAlignment = NSTextAlignmentCenter;
    topSmileIntroductLabel.font = [UIFont systemFontOfSize:18];
    topSmileIntroductLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [topSmileView addSubview:topSmileIntroductLabel];
    
    
    
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
//    if (iPhone4) {
//        btnH = autoSizeScale4Y * 80;
//    }else if (iPhone5){
//        btnH = autoSizeScale5Y * 80;
//    }else if (iPhone6){
//        btnH = autoSizeScale6Y * 80;
//    }else if (iPhone6p){
//        btnH = autoSizeScale6px * 80;
//    }else{
//        btnH = autoSizeScalexY * 80;
//    }
    for (int i = 0 ; i < imageArray.count; i++) {
        RSEvaluate * evaluateBtn = [[RSEvaluate alloc]init];
        NSInteger colom = i % ECA;
        evaluateBtn.tag = 100000 + i;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        evaluateBtn.frame = CGRectMake(btnX, 15, btnW, btnH);
        [evaluateBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [evaluateBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [bottomChoiceSmileView addSubview:evaluateBtn];
        //这边有点问题
        
        //[serviceEvalmodel.serviceEvalLevel integerValue] == 4
        if (i == [serviceEvalmodel.serviceEvalLevel integerValue] - 1) {
            evaluateBtn.highlighted = YES;
            
            [evaluateBtn setImage:[UIImage imageNamed:highImageArray[i]] forState:UIControlStateHighlighted];
        }else{
            [evaluateBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        }
        evaluateBtn.enabled = NO;
    }
    
    //下面评论的内容
    UIView * commentView = [[UIView alloc]init];
    commentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F3F3F3"];
    [headview addSubview:commentView];
    CGFloat StarViewH = 140;
    //RSWeakself;
    RSAlreadEvaluationServiceStarView * evaluationServiceStarview;
    for (int i = 0; i <serviceEvalmodel.serviceUserEvalList.count; i++) {
       RSServiceSecondEvalModel * serviceSecondEvalmodel = serviceEvalmodel.serviceUserEvalList[i];
        NSInteger row = i / STARECA;
        CGFloat starViewY = row * (margin + StarViewH) + margin;
        evaluationServiceStarview = [[RSAlreadEvaluationServiceStarView alloc]init];
        evaluationServiceStarview.starRateView3.userInteractionEnabled = NO;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:serviceSecondEvalmodel.userHead]];
        evaluationServiceStarview.servicePeopleImageview.image = [UIImage imageWithData:data];
        evaluationServiceStarview.servicePeopleImageview.contentMode =  UIViewContentModeScaleAspectFill;
        evaluationServiceStarview.servicePeopleImageview.clipsToBounds = YES;
        evaluationServiceStarview.servicePeopleLabel.text = [NSString stringWithFormat:@"%@",serviceSecondEvalmodel.name];
        evaluationServiceStarview.starRateView3.currentScore = [serviceSecondEvalmodel.starLevel integerValue];
        evaluationServiceStarview.frame = CGRectMake(0, starViewY, SCW, StarViewH);
        evaluationServiceStarview.backgroundColor = [UIColor whiteColor];
        [commentView addSubview:evaluationServiceStarview];
    }
    
    
    
    //评论的内容
    UITextView * evaluatTextView = [[UITextView alloc]init];
    evaluatTextView.backgroundColor = [UIColor whiteColor];
    evaluatTextView.editable = NO;
    evaluatTextView.text = [NSString stringWithFormat:@"%@",serviceEvalmodel.serviceComment];
    evaluatTextView.font = [UIFont systemFontOfSize:15];
    evaluatTextView.layer.borderWidth = 1;
    evaluatTextView.layer.borderColor = [UIColor colorWithHexColorStr:@"#f0f0f0"].CGColor;
    evaluatTextView.layer.cornerRadius = 4;
    evaluatTextView.layer.masksToBounds = YES;
    evaluatTextView.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    evaluatTextView.textAlignment = NSTextAlignmentCenter;
    [headview addSubview:evaluatTextView];
    

    smileView.sd_layout
    .leftSpaceToView(headview, 0)
    .topSpaceToView(headview, 0)
    .rightSpaceToView(headview, 0)
    .heightIs(216);
    
    
    topSmileView.sd_layout
    .leftSpaceToView(smileView, 0)
    .topSpaceToView(smileView, 0)
    .rightSpaceToView(smileView, 0)
    .heightIs(104);
    
    topSmileLabel.sd_layout
    .leftSpaceToView(topSmileView, 15)
    .rightSpaceToView(topSmileView, 15)
    .topSpaceToView(topSmileView, 30)
    .heightIs(24);
    
    
    topSmileIntroductLabel.sd_layout
    .leftSpaceToView(topSmileView, 15)
    .rightSpaceToView(topSmileView, 15)
    .topSpaceToView(topSmileLabel, 14)
    .bottomSpaceToView(topSmileView, 19);
    
    
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
    

    commentView.sd_layout
    .leftSpaceToView(headview, 0)
    .rightSpaceToView(headview, 0)
    .topSpaceToView(smileView, 10)
    .autoHeightRatio(0);

    
    evaluatTextView.sd_layout
    .topSpaceToView(commentView, 10)
    .leftSpaceToView(headview, 12)
    .rightSpaceToView(headview, 12)
    .heightIs(140);
    
    [commentView setupAutoHeightWithBottomView:evaluationServiceStarview bottomMargin:0];
    [headview setupAutoHeightWithBottomView:evaluatTextView bottomMargin:10];
    [headview layoutSubviews];
    self.tableview.tableHeaderView = headview;

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
