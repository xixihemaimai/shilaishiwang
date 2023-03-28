//
//  RSServiceCentreVViewController.m
//  石来石往
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 mac. All rights reserved.







#import "RSServiceCentreVViewController.h"
#import "RSServiceCell.h"

#import "RSServiceEvaluationViewController.h"
#import "RSServiceMarketViewController.h"


#import "RSServiceLibraryViewController.h"


#import "RSServiceMyServiceController.h"


#import "WWDViewController.h"


@interface RSServiceCentreVViewController ()
{
    
    NSArray * serviceImageArray;
    NSArray * serviceTitleArray;
    NSArray * serviceIntroductTitleArray;
}



@end

@implementation RSServiceCentreVViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F1EFF2"];
    
    self.title = @"服务中心";
    [self isAddjust];
    [self.view addSubview:self.tableview];
    
    serviceTitleArray = @[@"出库服务",@"市场服务",@"我的服务"];
    serviceImageArray = @[@"出库服务",@"市场服务",@"我的服务"];
    serviceIntroductTitleArray = @[@"荒料，大板出库业务",@"维修服务及其他服务",@"已发起的服务"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * SERVICECENTREID = @"servicecetreid";
    RSServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICECENTREID];
    if (!cell) {
        cell = [[RSServiceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICECENTREID];
        
    }
    cell.serviceImageview.image = [UIImage imageNamed:serviceImageArray[indexPath.row]];
    cell.serviceImageview.contentMode = UIViewContentModeScaleAspectFill;
    cell.serviceImageview.clipsToBounds = YES;
    cell.serviceLabel.text = serviceTitleArray[indexPath.row];
    cell.serviceLabelIntroduct.text = serviceIntroductTitleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //出库服务
        RSServiceLibraryViewController * serviceLibraryVc = [[RSServiceLibraryViewController
                                                              alloc]init];
        serviceLibraryVc.usermodel = self.usermodel;
        [self.navigationController pushViewController:serviceLibraryVc animated:YES];
        
    }else if (indexPath.row == 1){
        
        //市场服务
        RSServiceMarketViewController * serviceMarketVc = [[RSServiceMarketViewController alloc]init];
        serviceMarketVc.usermodel = self.usermodel;
        
        [self.navigationController pushViewController:serviceMarketVc animated:YES];
        
    }else{
        
        //已发出的服务
        RSServiceMyServiceController * myServiceVc = [[RSServiceMyServiceController alloc]init];
        myServiceVc.usermodel = self.usermodel;
        [self.navigationController pushViewController:myServiceVc animated:YES];
    }
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
