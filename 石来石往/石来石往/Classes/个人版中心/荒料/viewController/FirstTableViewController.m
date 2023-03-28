//
//  FirstTableViewController.m
//  TableViewFloat
//
//  Created by 李雪阳 on 2018/8/28.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "FirstTableViewController.h"
#import "FirstCell.h"

#import "RSProcessingOutWareHouseView.h"

#import "RSFirstProcessModel.h"

@interface FirstTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)RSProcessingOutWareHouseView * processingOutWareHouse;

@property(nonatomic ,strong)UITableView * myTableView;

@property (nonatomic,strong)NSMutableArray * processArray;

@end

@implementation FirstTableViewController

- (RSProcessingOutWareHouseView *)processingOutWareHouse{
    if (!_processingOutWareHouse) {
        self.processingOutWareHouse = [[RSProcessingOutWareHouseView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 192.5, SCW - 66 , 387)];
        self.processingOutWareHouse.backgroundColor = [UIColor whiteColor];
//        self.processingOutWareHouse.delegate = self;
        self.processingOutWareHouse.layer.cornerRadius = 15;
    }
    return _processingOutWareHouse;
}
- (NSMutableArray *)processArray{
    if (!_processArray) {
        _processArray = [NSMutableArray array];
    }
    return _processArray;
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
    [self setFirstCustomHeaderView];
    
    [self reloadProcessNewData];
}


- (void)reloadProcessNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.billdtlid] forKey:@"billdtlid"];
    [phoneDict setObject:[NSNumber numberWithBool:true] forKey:@"processList"];
    [phoneDict setObject:[NSNumber numberWithBool:false] forKey:@"processFeeList"];
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
            if (isresult) {
                [weakSelf.processArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"processList"];
                //weakSelf.processArray = [RSFirstProcessModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"processList"]];
                for (int i = 0; i < array.count; i++) {
                    RSFirstProcessModel * firstprocessmodel = [[RSFirstProcessModel alloc]init];
                    firstprocessmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"] integerValue];
                    
                     firstprocessmodel.processId = [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
                    
                     firstprocessmodel.processStatus = [[[array objectAtIndex:i]objectForKey:@"processStatus"] integerValue];
                    firstprocessmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                    firstprocessmodel.processName = [[array objectAtIndex:i]objectForKey:@"processName"];
                    firstprocessmodel.createUser = [[array objectAtIndex:i]objectForKey:@"createUser"];
                    firstprocessmodel.processTime = [[array objectAtIndex:i]objectForKey:@"processTime"];
                    
                    [weakSelf.processArray addObject:firstprocessmodel];
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






- (void)setFirstCustomHeaderView{
    UIView * headerView = [[UIView alloc]init];
    //WithFrame:CGRectMake(0, 0, SCW , 77)
   
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加进度" forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(12, 10, [UIScreen mainScreen].bounds.size.width  - 24, 37);
    [addBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn setBackgroundColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0]];
    [headerView addSubview:addBtn];
    addBtn.layer.cornerRadius = 3;
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0].CGColor;
    [addBtn addTarget:self action:@selector(addProcessIngOutWareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * foramtLabel = [[UILabel alloc]init];
    if (self.usermodel.pwmsUser.HLGL_BBZX_JGGDCK == 1 && self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1) {
        headerView.frame = CGRectMake(0, 0, SCW, 77);
        addBtn.hidden = NO;
        
        foramtLabel.frame = CGRectMake(12, CGRectGetMaxY(addBtn.frame), SCW - 24, 37);
    }else if(self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1 ){
        headerView.frame = CGRectMake(0, 0, SCW, 77);
          addBtn.hidden = NO;
        foramtLabel.frame = CGRectMake(12, CGRectGetMaxY(addBtn.frame), SCW - 24, 37);
    }else{
        headerView.frame = CGRectMake(0, 0, SCW, 37);
          addBtn.hidden = YES;
        foramtLabel.frame = CGRectMake(0, 0, SCW - 24, 37);
    }
    //foramtLabel.text = @"加工厂:某某一号加工厂";
    foramtLabel.text = [NSString stringWithFormat:@"加工厂:%@",self.machiningoutmodel.factoryName];
    foramtLabel.textAlignment = NSTextAlignmentCenter;
    foramtLabel.font = [UIFont systemFontOfSize:12];
    foramtLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    [headerView addSubview:foramtLabel];
    self.myTableView.tableHeaderView = headerView;
}


- (void)addProcessIngOutWareAction:(UIButton *)addBtn{
    self.processingOutWareHouse.addType = @"添加进度";
    self.processingOutWareHouse.billdtlid = self.billdtlid;
    self.processingOutWareHouse.statusType = @"1";
    [self.processingOutWareHouse showView];
    RSWeakself
    self.processingOutWareHouse.processReload = ^(BOOL isreload) {
        if (isreload) {
            [weakSelf reloadProcessNewData];
            if (weakSelf.firstReload) {
                
                weakSelf.firstReload();
            }
        }
    };
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.processArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rank"];
    if (cell==nil) {
        cell = [[FirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rank"];
    }
    //cell.textLabel.text = @"1";
    //cell.contentView.backgroundColor = [UIColor greenColor];
    cell.firstprocessmodel = self.processArray[indexPath.row];
    if (indexPath.row == self.processArray.count - 1) {
        cell.creatCurrentBtn.hidden = NO;
    }else{
        cell.creatCurrentBtn.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.usermodel.pwmsUser.HLGL_BBZX_JGGDCK == 1 && self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1) {
        self.processingOutWareHouse.addType = @"添加进度";
        //修改或者删除
        RSFirstProcessModel * firstprocessmodel = self.processArray[indexPath.row];
        self.processingOutWareHouse.firstprocessmodel = firstprocessmodel;
        self.processingOutWareHouse.statusType = @"2";
        self.processingOutWareHouse.billdtlid = firstprocessmodel.billdtlid;
        [self.processingOutWareHouse showView];
        RSWeakself
        self.processingOutWareHouse.processReload = ^(BOOL isreload) {
            if (isreload) {
                [weakSelf reloadProcessNewData];
                if (weakSelf.firstReload) {
                    weakSelf.firstReload();
                }
            }
        };
    }else if(self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1 ){
        self.processingOutWareHouse.addType = @"添加进度";
        //修改或者删除
        RSFirstProcessModel * firstprocessmodel = self.processArray[indexPath.row];
        self.processingOutWareHouse.firstprocessmodel = firstprocessmodel;
        self.processingOutWareHouse.statusType = @"2";
        self.processingOutWareHouse.billdtlid = firstprocessmodel.billdtlid;
        [self.processingOutWareHouse showView];
        RSWeakself
        self.processingOutWareHouse.processReload = ^(BOOL isreload) {
            if (isreload) {
                [weakSelf reloadProcessNewData];
                if (weakSelf.firstReload) {
                    weakSelf.firstReload();
                }
            }
        };
    }else{
        //[SVProgressHUD showInfoWithStatus:@"你没有这个权限"];
    }
}

@end
