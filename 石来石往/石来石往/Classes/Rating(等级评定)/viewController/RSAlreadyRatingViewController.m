//
//  RSAlreadyRatingViewController.m
//  石来石往
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAlreadyRatingViewController.h"
#import "RSRatingModel.h"
#import "RSRatingCell.h"



@interface RSAlreadyRatingViewController ()<UITableViewDelegate,UITableViewDataSource>



/**已经评论过的模型数组*/
@property (nonatomic,strong)NSMutableArray * HasBeenStoneArray;
/**接口需要的参数*/
@property (nonatomic,assign)BOOL isLevel;


@property (nonatomic,strong)UITableView * tableview;

/**A按键*/
@property (nonatomic,assign)BOOL isLevelA;
/**B按键*/
@property (nonatomic,assign)BOOL isLevelB;
/**C按键*/
@property (nonatomic,assign)BOOL isLevelC;



@end

@implementation RSAlreadyRatingViewController
- (NSMutableArray *)HasBeenStoneArray{
    if (_HasBeenStoneArray == nil) {
        _HasBeenStoneArray = [NSMutableArray array];
    }
    return _HasBeenStoneArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self addCustomTableview];
    
    if ([self.searchTextfield.text isEqualToString:@""]) {
        /**获取网络数据*/
//        [self getStoneHasBeenRated];
    }else{
//        [self getStoneHasBeenRatedSearchNoNullString];
    }
    
    
}

//- (void)getStoneHasBeenRatedSearchNoNullString{
//
//    self.isLevel = true;
//
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    [dict setObject:[NSNumber numberWithBool:self.isLevel] forKey:@"ISGRADE"];
//    [dict setObject:self.choiceStyle forKey:@"BLORSL"];
//    [dict setObject:self.searchTextfield.text forKey:@"searchtxt"];
//
//
//
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    __weak typeof(self) weakSelf = self;
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_GET_STONE_LEVEL_DATA withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//
//
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//               // NSMutableArray *array = nil;
//
//                [weakSelf.HasBeenStoneArray removeAllObjects];
//               // array = json[@"Data"];
//
//                weakSelf.HasBeenStoneArray = [RSRatingModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//
////                for (int i = 0; i < array.count; i++) {
////
////                    RSRatingModel * ratingModel = [[RSRatingModel alloc]init];
////                    ratingModel.ratingID = [[array objectAtIndex:i]objectForKey:@"id"];
////                    ratingModel.stoneId = [[array objectAtIndex:i]objectForKey:@"stoneId"];
////                    ratingModel.stoneLevel = [[[array objectAtIndex:i]objectForKey:@"stoneLevel"] integerValue];
////                    ratingModel.stoneMessage = [[array objectAtIndex:i]objectForKey:@"stoneMessage"];
////                    ratingModel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
////                    ratingModel.stoneType = [[array objectAtIndex:i]objectForKey:@"stoneType"];
////                    ratingModel.stoneVolume = [[array objectAtIndex:i]objectForKey:@"stoneVolume"];
////                    ratingModel.stoneWeight = [[array objectAtIndex:i]objectForKey:@"stoneWeight"];
////                    ratingModel.stoneblno = [[array objectAtIndex:i]objectForKey:@"stoneblno"];
////                    ratingModel.stoneturnsno = [[array objectAtIndex:i]objectForKey:@"stoneturnsno"];
////
////                    [weakSelf.HasBeenStoneArray addObject:ratingModel];
//                    [weakSelf.tableview reloadData];
//                    [SVProgressHUD showSuccessWithStatus:@"获取数据成功"];
////                }
//            }else{
//
//            }
//        }
//    }];
//}


- (void)addCustomTableview{
    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    
    
}




-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.HasBeenStoneArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * alreadID = @"alreadcell";
    RSRatingCell * cell = [tableView dequeueReusableCellWithIdentifier:alreadID];
    if (!cell) {
        cell = [[RSRatingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alreadID];
        cell.backgroundColor = [UIColor colorWithHexColorStr:@"#f1eff2"];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RSRatingModel * ratingModel = self.HasBeenStoneArray[indexPath.row];
    
    
    
    cell.ratingModel  = ratingModel;
    
  
    
    
    cell.aBtn.tag = indexPath.row;
    cell.bBtn.tag = indexPath.row;
    cell.cBtn.tag = indexPath.row;
    
    [cell.aBtn addTarget:self action:@selector(changSelectState:) forControlEvents:UIControlEventTouchUpInside];
    [cell.bBtn addTarget:self action:@selector(changSelectState:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cBtn addTarget:self action:@selector(changSelectState:) forControlEvents:UIControlEventTouchUpInside];
    
    
        if (ratingModel.stoneLevel == 1) {
            _isLevelA = true;
            _isLevelB = false;
            _isLevelC = false;
        }else if (ratingModel.stoneLevel == 2){
            _isLevelA = false;
            _isLevelB = true;
            _isLevelC = false;
        }else{
            _isLevelA = false;
            _isLevelB = false;
            _isLevelC = true;
        }
    
    
        if (_isLevelA == true) {
            cell.aBtn.selected = YES;
            [cell.aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [cell.aBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
        }else{
            cell.aBtn.selected = NO;
            [cell.aBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
            [cell.aBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        }
        
        
        if (_isLevelB == true) {
            cell.bBtn.selected = YES;
            [cell.bBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
            [cell.bBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }else{
            cell.bBtn.selected = NO;
            [cell.bBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
            [cell.bBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        }
        
        
        if (_isLevelC == true) {
            cell.cBtn.selected = YES;
            [cell.cBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
            [cell.cBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }else{
            cell.cBtn.selected = NO;
            [cell.cBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
            [cell.cBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        }
    return cell;
}



- (void)changSelectState:(UIButton *)btn{
    RSRatingModel * rating = self.HasBeenStoneArray[btn.tag];
    //rating.status = 1;
    if ([btn.currentTitle isEqualToString:@"A"]) {
        if (rating.stoneLevel != 1) {
            rating.stoneLevel = 1;
            self.isLevelA = true;
            self.isLevelB = false;
            self.isLevelC = false;
            
            [self.HasBeenStoneArray replaceObjectAtIndex:btn.tag withObject:rating];
            
//            [self evaluateTheStoneLevel:btn andChoiceBtnPosition:rating.stoneLevel];
            
           // [self.tableview reloadData];
        }
    }else if ([btn.currentTitle isEqualToString:@"B"]){
        
        rating.stoneLevel = 2;
        self.isLevelA = false;
        self.isLevelB = true;
        self.isLevelC = false;
        [self.HasBeenStoneArray replaceObjectAtIndex:btn.tag withObject:rating];
//        [self evaluateTheStoneLevel:btn andChoiceBtnPosition:rating.stoneLevel];
        
        //[self.tableview reloadData];
    }else if ([btn.currentTitle isEqualToString:@"C"]){
        
        
        rating.stoneLevel = 3;
        self.isLevelA = false;
        self.isLevelB = false;
        self.isLevelC = true;
        [self.HasBeenStoneArray replaceObjectAtIndex:btn.tag withObject:rating];
        
//        [self evaluateTheStoneLevel:btn andChoiceBtnPosition:rating.stoneLevel];
        
        //[self.tableview reloadData];
    }
}

//- (void)evaluateTheStoneLevel:(UIButton *)btn andChoiceBtnPosition:(NSInteger)choiceBtnPosition{
//    //URL_SET_STONE_LEVEL
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    RSRatingModel * ratingModel = self.HasBeenStoneArray[btn.tag];
//    [dict setObject:ratingModel.ratingID forKey:@"STONEID"];
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)choiceBtnPosition] forKey:@"stoneLvl"];
//
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    __weak typeof(self) weakSelf = self;
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_SET_STONE_LEVEL withParameters:parameters withBlock:^(id json, BOOL success) {
//
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//
//
//                [SVProgressHUD showSuccessWithStatus:@"评级成功"];
//
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//
////                    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
////                    [self.HasBeenStoneArray removeObjectAtIndex:indexpath.row];
//                    //[self.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationRight];
//                    [weakSelf.tableview reloadData];
//                });
//            }
//        }
//
//    }];
//
//}


#pragma mark -- 获取已经评过的石材数据
//- (void)getStoneHasBeenRated{
//    self.isLevel = true;
//
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    [dict setObject:[NSNumber numberWithBool:self.isLevel] forKey:@"ISGRADE"];
//    [dict setObject:self.choiceStyle forKey:@"BLORSL"];
//    [dict setObject:self.searchTextfield.text forKey:@"searchtxt"];
//
//
//
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    __weak typeof(self) weakSelf = self;
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_GET_STONE_LEVEL_DATA withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//
//
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                //NSMutableArray *array = nil;
//
//                [weakSelf.HasBeenStoneArray removeAllObjects];
//                //array = json[@"Data"];
//
//                weakSelf.HasBeenStoneArray = [RSRatingModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
////
////                for (int i = 0; i < array.count; i++) {
////
////                    RSRatingModel * ratingModel = [[RSRatingModel alloc]init];
////                    ratingModel.ratingID = [[array objectAtIndex:i]objectForKey:@"id"];
////                    ratingModel.stoneId = [[array objectAtIndex:i]objectForKey:@"stoneId"];
////                    ratingModel.stoneLevel = [[[array objectAtIndex:i]objectForKey:@"stoneLevel"] integerValue];
////                    ratingModel.stoneMessage = [[array objectAtIndex:i]objectForKey:@"stoneMessage"];
////                    ratingModel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
////                    ratingModel.stoneType = [[array objectAtIndex:i]objectForKey:@"stoneType"];
////                    ratingModel.stoneVolume = [[array objectAtIndex:i]objectForKey:@"stoneVolume"];
////                    ratingModel.stoneWeight = [[array objectAtIndex:i]objectForKey:@"stoneWeight"];
////                    ratingModel.stoneblno = [[array objectAtIndex:i]objectForKey:@"stoneblno"];
////                    ratingModel.stoneturnsno = [[array objectAtIndex:i]objectForKey:@"stoneturnsno"];
////
////                    [weakSelf.HasBeenStoneArray addObject:ratingModel];
//                    [weakSelf.tableview reloadData];
//                    [SVProgressHUD showSuccessWithStatus:@"获取数据成功"];
////                }
//            }else{
//
//            }
//        }
//    }];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 136;
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
