//
//  RSReportFormController.m
//  石来石往
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSReportFormController.h"

#import "RSReportCell.h"


#import "RSReportDetailViewController.h"

#import "RSDetailsOfChargesViewController.h"


@interface RSReportFormController ()

{
    NSArray * titleArray;
    NSArray * imageArray;
    
    
}



@end

@implementation RSReportFormController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"报表中心";
    
    titleArray = @[@"大板库存码单",@"荒料库存码单",@"大板入库明细",@"大板出库明细",@"荒料入库明细",@"荒料出库明细",@"费用明细"];
    imageArray = @[@"大板库存2",@"荒料库存2",@"大板入库明细",@"大板出库明细",@"荒料入库明细",@"荒料出库明细",@"费用明细"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * REPORTFORMID = @"repoftformid";
    RSReportCell *cell = [tableView dequeueReusableCellWithIdentifier:REPORTFORMID];
    
    if (!cell) {
        cell = [[RSReportCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:REPORTFORMID];
    }
    
    cell.imageStyle.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.labelStyle.text = [NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //(SCH/568) *
    return 45;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * str = [NSString string];
    
    
    switch (indexPath.row) {
        case 0:
            
        {
              str = @"大板库存";
            RSReportDetailViewController * reportDetailVc = [[RSReportDetailViewController alloc]init];
//            reportDetailVc.usermodel = self.usermodel;
            reportDetailVc.title = str;
            [self.navigationController pushViewController:reportDetailVc animated:YES];
            
        }
            
            break;
            
        case 1:
            
        {
            
            str = @"荒料库存";
            
            RSReportDetailViewController * reportDetailVc = [[RSReportDetailViewController alloc]init];
             reportDetailVc.title = str;
//            reportDetailVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:reportDetailVc animated:YES];
            
            
            
        }
            
            
            break;
            
        case 2:
        {
            str = @"大板入库明细";
            RSReportDetailViewController * reportDetailVc = [[RSReportDetailViewController alloc]init];
             reportDetailVc.title = str;
//            reportDetailVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:reportDetailVc animated:YES];
        }
            
            
            break;
            
            
        case 3:
        {
            str = @"大板出库明细";
            
            RSReportDetailViewController * reportDetailVc = [[RSReportDetailViewController alloc]init];
             reportDetailVc.title = str;
//            reportDetailVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:reportDetailVc animated:YES];
        }
            
            
            break;
            
        case 4:
        {
         str = @"荒料入库明细";
            RSReportDetailViewController * reportDetailVc = [[RSReportDetailViewController alloc]init];
             reportDetailVc.title = str;
//            reportDetailVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:reportDetailVc animated:YES];
        }
            
            
            break;
            
        case 5:
        {
             str = @"荒料出库明细";
            RSReportDetailViewController * reportDetailVc = [[RSReportDetailViewController alloc]init];
             reportDetailVc.title = str;
//            reportDetailVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:reportDetailVc animated:YES];
        }
           
            break;
            
        case 6:
        {
            str = @"费用明细";
            RSDetailsOfChargesViewController * detailsOfChargesVc = [[RSDetailsOfChargesViewController alloc]init];
            [self.navigationController pushViewController:detailsOfChargesVc animated:YES];
            
            
        }
        break;
    }
}



@end
