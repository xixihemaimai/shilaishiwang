//
//  RSVerifyViewController.m
//  石来石往
//
//  Created by mac on 17/6/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSVerifyViewController.h"

#import "RSShipmentModel.h"
@interface RSVerifyViewController ()

@end

@implementation RSVerifyViewController

//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}


- (YJTopicType)type
{
    // 返回审核中数据
    return YJTopicTypeverify;
}
-(RSUserModel *)usermodel{
    return _usermodel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
//    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.rowHeight = 50;
//    
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableview];
   
}


//- (void)getNetWorkData{
//    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    
//    [dict setObject:self.erpCode forKey:@"ERPCODE"];
//    
//    
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode]};
//    
//    
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_OUTSTORE_HISTORY withParameters:parameters withBlock:^(id json, BOOL success) {
//        
//        if (success) {
//            
//            
//            
//            BOOL Result = [json[@"Result"] boolValue];
//            
//            if (Result) {

//                
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"Data"];
//                
//                //NSInteger status = [json[@"outstoreStatus"] integerValue];
//                for (int i = 0; i < array.count; i++) {
//                    
//                    RSShipmentModel * shipModel = [[RSShipmentModel alloc]init];
//                    shipModel.outstoreStatus = [[[array objectAtIndex:i] objectForKey:@"outstoreStatus"] integerValue];
//                    shipModel.outstoreDate = [[array objectAtIndex:i]objectForKey:@"outstoreDate"];
//                    shipModel.outstoreId = [[array objectAtIndex:i]objectForKey:@"outstoreId"];
//                    shipModel.outstoreUrl = [[array objectAtIndex:i]objectForKey:@"outstoreUrl"];
//                    
//                    
//                    
//                    if (shipModel.outstoreStatus == 1) {
//                        [self.dataArray addObject:shipModel];
//                    }
//                }
//            }
//            [self.tableview reloadData];
//        }
//        
//    }];
//    
//    
//    
//    
//    
//}
//
//
//
//
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * shippingID = @"shippingcell";
//    RSShippingCell * cell = [tableView dequeueReusableCellWithIdentifier:shippingID];
//    if (!cell) {
//        cell = [[RSShippingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:shippingID];
//        
//        
//        
//        //        cell.detailLibraryLabel.text = @"LTG820170412301107";
//        //        cell.detailDateLabel.text = @"2017-04-12 20:11:07";
//        //        cell.detailStatusLabel.text = @"处理中";
//        //        cell.detailStatusLabel.textColor = [UIColor greenColor];
//        cell.detailStatusLabel.text = @"审核中";
//        cell.detailStatusLabel.textColor = [UIColor orangeColor];
//        
//    }
//    cell.shipModel = self.dataArray[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    
//    
//    return cell;
//}



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
