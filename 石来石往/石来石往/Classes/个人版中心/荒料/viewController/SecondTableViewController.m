//
//  SecondTableViewController.m
//  TableViewFloat
//
//  Created by 李雪阳 on 2018/8/28.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "SecondTableViewController.h"
#import "SecondCell.h"

#import "FirstHeaderView.h"
#import "FristFootView.h"
#import "RSProcessingOutWareHouseView.h"

#import "RSSecondProcessModel.h"

@interface SecondTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)RSProcessingOutWareHouseView * processingOutWareHouse;

@property(nonatomic ,strong)UITableView * myTableView;

@property (nonatomic,strong)NSMutableArray * processArray;

@property (nonatomic,assign)CGFloat totalMoney;

@end

@implementation SecondTableViewController

- (NSMutableArray *)processArray{
    if (!_processArray) {
        _processArray = [NSMutableArray array];
    }
    return _processArray;
}

- (RSProcessingOutWareHouseView *)processingOutWareHouse{
    if (!_processingOutWareHouse) {
        self.processingOutWareHouse = [[RSProcessingOutWareHouseView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 214, SCW - 66 , 428)];
        self.processingOutWareHouse.backgroundColor = [UIColor whiteColor];
        
        self.processingOutWareHouse.layer.cornerRadius = 15;
    }
    return _processingOutWareHouse;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        
        Y = 88;
    }else{
        Y = 64;
    }
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCW,self.view.frame.size.height - Y - 44)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self reloadProcessNewData];
}

- (void)reloadProcessNewData{
    self.totalMoney = 0.0;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.billdtlid] forKey:@"billdtlid"];
    [phoneDict setObject:[NSNumber numberWithBool:false] forKey:@"processList"];
    [phoneDict setObject:[NSNumber numberWithBool:true] forKey:@"processFeeList"];
    [phoneDict setObject:[NSNumber numberWithBool:false] forKey:@"processPicList"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROCESSDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            weakSelf.totalMoney = 0.0;
            if (isresult) {
                [weakSelf.processArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"processFeeList"];
                for (int i = 0; i < array.count; i++) {
                    RSSecondProcessModel * secondProcessmodel = [[RSSecondProcessModel alloc]init];
                    secondProcessmodel.amount = [[array objectAtIndex:i]objectForKey:@"amount"];
                    secondProcessmodel.money = [[array objectAtIndex:i]objectForKey:@"money"];
                    secondProcessmodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
                    secondProcessmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                     secondProcessmodel.createUser = [[array objectAtIndex:i]objectForKey:@"createUser"];
                     secondProcessmodel.name = [[array objectAtIndex:i]objectForKey:@"name"];
                    secondProcessmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    secondProcessmodel.processId = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
                    weakSelf.totalMoney += [secondProcessmodel.money floatValue];
                    [weakSelf.processArray addObject:secondProcessmodel];
                }
                [weakSelf.myTableView reloadData];
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取失败"];
                [weakSelf.myTableView reloadData];
            }
        }else{
             [SVProgressHUD showInfoWithStatus:@"获取失败"];
            [weakSelf.myTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 47;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * FIRSTHEADERVIEWCELLID = @"FIRSTHEADERVIEWCELLID";
    FirstHeaderView * firstHeaderView = [[FirstHeaderView alloc]initWithReuseIdentifier:FIRSTHEADERVIEWCELLID];
    return firstHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString * FIRSTFOOTVIEWCELLID = @"FIRSTFOOTVIEWCELLID";
    FristFootView * firstFootView = [[FristFootView alloc]initWithReuseIdentifier:FIRSTFOOTVIEWCELLID];
    firstFootView.userInteractionEnabled = YES;
    firstFootView.totalLabel.text = [NSString stringWithFormat:@"合计:%0.3lf",self.totalMoney];
    if (self.usermodel.pwmsUser.HLGL_BBZX_JGGDCK == 1 && self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1) {
        firstFootView.addMoneyBtn.hidden = NO;
    }else if(self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1 ){
        firstFootView.addMoneyBtn.hidden = NO;
    }else{
        firstFootView.addMoneyBtn.hidden = YES;
    }
    [firstFootView.addMoneyBtn addTarget:self action:@selector(addMoneyAction:) forControlEvents:UIControlEventTouchUpInside];
    return firstFootView;
}

- (void)addMoneyAction:(UIButton *)addMoneyBtn{
    self.processingOutWareHouse.addType = @"添加费用";
    self.processingOutWareHouse.billdtlid = self.billdtlid;
    self.processingOutWareHouse.statusType = @"1";
    [self.processingOutWareHouse showView];
    RSWeakself
    self.processingOutWareHouse.processReload = ^(BOOL isreload) {
        if (isreload) {
            [weakSelf reloadProcessNewData];
        }
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.processArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"money"];
    if (cell==nil) {
        cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"money"];
    }
    //cell.textLabel.text = @"2";
    //cell.contentView.backgroundColor = [UIColor orangeColor];
    cell.secondProcessmodel = self.processArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSSecondProcessModel * secondProcessmodel = self.processArray[indexPath.row];
    NSInteger first = [self needLinesWithWidth:123 andText:secondProcessmodel.name];
    NSString * firstStr = [NSString stringWithFormat:@"%@元",secondProcessmodel.price];
    NSInteger second = [self needLinesWithWidth:31 andText:firstStr];
    NSInteger third = [self needLinesWithWidth:40 andText:[NSString stringWithFormat:@"%@",secondProcessmodel.amount]];
    NSString * fourStr = [NSString stringWithFormat:@"%@元",secondProcessmodel.money];
    NSInteger four = [self needLinesWithWidth:60 andText:fourStr];
    NSArray * array = @[@(first),@(second),@(third),@(four)];
    NSInteger max = [[array valueForKeyPath:@"@max.floatValue"] integerValue];
    return max * 37;
}

- (NSInteger)needLinesWithWidth:(CGFloat)width andText:(NSString *)textStr{
    //创建一个labe
    UILabel * label = [[UILabel alloc]init];
    //font和当前label保持一致
    label.font = [UIFont systemFontOfSize:15];
    NSString * text = textStr;
    NSInteger sum = 0; //总行数受换行符影响，所以这里计算总行数，需要用换行符分隔这段文字，然后计算每段文字的行数，相加即是总行数。
    NSArray * splitText = [text componentsSeparatedByString:@"\n"];
    for (NSString * sText in splitText) {
        label.text = sText;
        //获取这段文字一行需要的size
        CGSize textSize = [label systemLayoutSizeFittingSize:CGSizeZero];
        //size.width/所需要的width 向上取整就是这段文字占的行数
        NSInteger lines = ceilf(textSize.width/width);
        //当是0的时候，说明这是换行，需要按一行算。
        lines = lines == 0?1:lines;
        sum += lines;
    }
    return sum;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.usermodel.pwmsUser.HLGL_BBZX_JGGDCK == 1 && self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1) {
        self.processingOutWareHouse.addType = @"添加费用";
        //修改或者删除
        RSSecondProcessModel * secondProcessmodel = self.processArray[indexPath.row];
        self.processingOutWareHouse.secondProcessmodel = secondProcessmodel;
        self.processingOutWareHouse.statusType = @"2";
        self.processingOutWareHouse.billdtlid = secondProcessmodel.billdtlid;
        [self.processingOutWareHouse showView];
        RSWeakself
        self.processingOutWareHouse.processReload = ^(BOOL isreload) {
            if (isreload) {
                [weakSelf reloadProcessNewData];
            }
        };
    }else if(self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1 ){
        self.processingOutWareHouse.addType = @"添加费用";
        //修改或者删除
        RSSecondProcessModel * secondProcessmodel = self.processArray[indexPath.row];
        self.processingOutWareHouse.secondProcessmodel = secondProcessmodel;
        self.processingOutWareHouse.statusType = @"2";
        self.processingOutWareHouse.billdtlid = secondProcessmodel.billdtlid;
        [self.processingOutWareHouse showView];
        RSWeakself
        self.processingOutWareHouse.processReload = ^(BOOL isreload) {
            if (isreload) {
                [weakSelf reloadProcessNewData];
            }
        };
    }else{
         //[SVProgressHUD showInfoWithStatus:@"你没有这个权限"];
    }
}

@end
