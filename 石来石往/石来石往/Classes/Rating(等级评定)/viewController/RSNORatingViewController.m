//
//  RSNORatingViewController.m
//  石来石往
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNORatingViewController.h"
#import "RSRatingCell.h"


//模型
#import "RSRatingModel.h"
@interface RSNORatingViewController ()<UITableViewDelegate,UITableViewDataSource>


//获取服务器返回来的数据
@property (nonatomic,strong)NSMutableArray * stoneLevelArray;

@property (nonatomic,assign)BOOL isLevel;


@property (nonatomic,strong)UITableView *tableview;

//选中A的
@property (nonatomic,assign)BOOL levelA;
//选中B的
@property (nonatomic,assign)BOOL levelB;
//选中C的
@property (nonatomic,assign)BOOL levelC;

/**选择A为1 B为2 C为3*/
@property (nonatomic,assign)NSInteger choiceBtnPosition;





@end

@implementation RSNORatingViewController

- (NSMutableArray *)stoneLevelArray{
    if (_stoneLevelArray == nil) {
        _stoneLevelArray = [NSMutableArray array];
    }
    return _stoneLevelArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    //URL_GET_STONE_LEVEL_DATA 获取石材数据
    
    [self addCustomTableview];
   
    _levelA = false;
    _levelB = false;
    _levelC = false;
    
    if ([self.searchTextfield.text isEqualToString:@""]) {
//        [self getStoneInformationMessage];
    }else{
//        [self getStoneSearchNoNullString];
    }

    
    
}



//- (void)getStoneSearchNoNullString{
//    self.isLevel = false;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithBool:self.isLevel] forKey:@"ISGRADE"];
//    [dict setObject:self.choiceStyle forKey:@"BLORSL"];
//    [dict setObject:self.searchTextfield.text forKey:@"searchtxt"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_GET_STONE_LEVEL_DATA withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                //NSMutableArray * array = nil;
//                [weakSelf.stoneLevelArray removeAllObjects];
//               // array = json[@"Data"];
//
//                weakSelf.stoneLevelArray = [RSRatingModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//
//
////                for (int i = 0; i < array.count; i++) {
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
////                    [weakSelf.stoneLevelArray addObject:ratingModel];
//                    [weakSelf.tableview reloadData];
////                }
//            }
//        }
//    }];
//
//
//
//
//
//
//}



//- (void)getStoneInformationMessage{
//    self.isLevel = false;
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
//            BOOL Result = [json[@"Result"] boolValue];
//            
//            if (Result) {
////                NSMutableArray * array = nil;
////                array = json[@"Data"];
//                //移除数组中所有的对象
//                [weakSelf.stoneLevelArray removeAllObjects];
//                
//                
//                weakSelf.stoneLevelArray = [RSRatingModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//                
////                for (int i = 0; i < array.count; i++) {
////                    RSRatingModel * ratingModel = [[RSRatingModel alloc]init];
////                    ratingModel.ratingID = [[array objectAtIndex:i]objectForKey:@"id"];
////                    ratingModel.stoneId = [[array objectAtIndex:i]objectForKey:@"stoneId"];
////                    ratingModel.stoneLevel = [[[array objectAtIndex:i]objectForKey:@"stoneLevel"] integerValue];
////
////
////                    ratingModel.stoneMessage = [[array objectAtIndex:i]objectForKey:@"stoneMessage"];
////                    ratingModel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
////                    ratingModel.stoneType = [[array objectAtIndex:i]objectForKey:@"stoneType"];
////                    ratingModel.stoneVolume = [[array objectAtIndex:i]objectForKey:@"stoneVolume"];
////                    ratingModel.stoneWeight = [[array objectAtIndex:i]objectForKey:@"stoneWeight"];
////
////                    ratingModel.stoneblno = [[array objectAtIndex:i]objectForKey:@"stoneblno"];
////                    ratingModel.stoneturnsno = [[array objectAtIndex:i]objectForKey:@"stoneturnsno"];
////                    [weakSelf.stoneLevelArray addObject:ratingModel];
//                    [weakSelf.tableview reloadData];
////                }
//            }else{
//                
//            }
//        }
//    }];
//}

static NSString *ratingCellID = @"ratingcell";
- (void)addCustomTableview{
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stoneLevelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSRatingCell *cell = [tableView dequeueReusableCellWithIdentifier:ratingCellID];
    if (!cell) {
        cell = [[RSRatingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ratingCellID];
        cell.backgroundColor = [UIColor colorWithHexColorStr:@"#f1eff2"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RSRatingModel *ratingModel = self.stoneLevelArray[indexPath.row];
    cell.ratingModel = ratingModel;
    

    
    cell.aBtn.tag = indexPath.row;
    cell.bBtn.tag = indexPath.row;
    cell.cBtn.tag = indexPath.row;
    [cell.aBtn addTarget:self action:@selector(selete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.bBtn addTarget:self action:@selector(selete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cBtn addTarget:self action:@selector(selete:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if (ratingModel.status == 0) {
        cell.aBtn.selected = NO;
        [cell.aBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [cell.aBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        
        cell.bBtn.selected = NO;
        [cell.bBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        [cell.bBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        
        cell.cBtn.selected = NO;
        [cell.cBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        [cell.cBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        
    }else{
        if (_levelA == true) {
            cell.aBtn.selected = YES;
            [cell.aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [cell.aBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
        }else{
            cell.aBtn.selected = NO;
            [cell.aBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
            [cell.aBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        }
        
        
        if (_levelB == true) {
            cell.bBtn.selected = YES;
            [cell.bBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
            [cell.bBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }else{
            cell.bBtn.selected = NO;
            [cell.bBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
            [cell.bBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        }
        
        
        if (_levelC == true) {
            cell.cBtn.selected = YES;
            [cell.cBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
            [cell.cBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }else{
            cell.cBtn.selected = NO;
            [cell.cBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
            [cell.cBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        }
    }

    
        
    
    return cell;
}


- (void)selete:(UIButton *)btn{
    
    RSRatingModel * rating = self.stoneLevelArray[btn.tag];
    rating.status = 1;
    
    [self.stoneLevelArray replaceObjectAtIndex:btn.tag withObject:rating];
    
        if ([btn.currentTitle isEqualToString:@"A"]) {
            _levelA = true;
            _levelB = false;
            _levelC = false;
            self.choiceBtnPosition = 1;
//            [self evaluateTheStoneLevel:btn andChoiceBtnPosition:self.choiceBtnPosition];
            
            
        }else if ([btn.currentTitle isEqualToString:@"B"]){
            _levelA = false;
            _levelB = true;
            _levelC = false;
            self.choiceBtnPosition = 2;
//            [self evaluateTheStoneLevel:btn andChoiceBtnPosition:self.choiceBtnPosition];
            
            
        }else if([btn.currentTitle isEqualToString:@"C"]){
            _levelA = false;
            _levelB = false;
            _levelC = true;
            self.choiceBtnPosition = 3;
            
//            [self evaluateTheStoneLevel:btn andChoiceBtnPosition:self.choiceBtnPosition];
        }
  
    
   //URL_SET_STONE_LEVEL给石材进行评定
            //这边要做区分
    

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
//        [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationTop];
//    });
    
    [self.tableview reloadData];
   
}


//- (void)evaluateTheStoneLevel:(UIButton *)btn andChoiceBtnPosition:(NSInteger)choiceBtnPosition{
//    //URL_SET_STONE_LEVEL
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    RSRatingModel * ratingModel = self.stoneLevelArray[btn.tag];
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
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//
//                    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
//                    [weakSelf.stoneLevelArray removeObjectAtIndex:indexpath.row];
//                    //[self.tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationRight];
//                    [weakSelf.tableview reloadData];
//                });
//            }else{
//
//            }
//        }
//
//    }];
//
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
