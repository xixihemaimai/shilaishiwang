//
//  RSFeedbackViewController.m
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSFeedbackViewController.h"
#import "RSFeedBackCell.h"

#import "RSAboutWeViewController.h"
#import "RSQuestionFeedBackViewController.h"
#import <SDImageCache.h>


#import "RSAboutWeDetailViewController.h"
#import "RSAccountAndSafeViewController.h"
///<,UITableViewDataSource>
@interface RSFeedbackViewController ()

//@property (nonatomic,strong)UITableView * tableview;

@end

@implementation RSFeedbackViewController


//
//- (UITableView *)tableview{
//    if (!_tableview) {
//
//
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    }
//    return _tableview;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.title = @"服务";
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [self isAddjust];
    [self.view addSubview:self.tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * RSFEEDBACKCELL = @"RSFeedBackCell";
    RSFeedBackCell * cell = [tableView dequeueReusableCellWithIdentifier:RSFEEDBACKCELL];
    if (!cell) {
        cell = [[RSFeedBackCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSFEEDBACKCELL];
    }
    if (indexPath.row == 0){
        cell.image.image = [UIImage imageNamed:@"账号与安全"];
        cell.feedStyleLabel.text = @"账号与安全";
        cell.feedPhoneLabel.text = @"";
    }else if (indexPath.row == 1) {
        cell.image.image = [UIImage imageNamed:@"意见反馈"];
        cell.feedStyleLabel.text = @"意见反馈";
        cell.feedPhoneLabel.text = @"";
    }else if (indexPath.row == 2){
        cell.image.image = [UIImage imageNamed:@"关于我们"];
        cell.feedStyleLabel.text = @"关于我们";
        cell.feedPhoneLabel.text = @"";
    }else if(indexPath.row == 3) {
        cell.image.image = [UIImage imageNamed:@"联系客服"];
        cell.feedStyleLabel.text = @"联系客服";
        cell.feedPhoneLabel.text = @"400-0046056";
    }else{
        cell.image.image = [UIImage imageNamed:@"清除缓存"];
        cell.feedStyleLabel.text = @"清除缓存";
        //获取缓存图片的大小(字节)
//        NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
//        float MBCache = bytesCache/1000/1000;
//        cell.feedPhoneLabel.text = [NSString stringWithFormat:@"%0.2lfM",MBCache];
//        cell.feedPhoneLabel.hidden = YES;
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0){
        RSAccountAndSafeViewController * accountAndSafeVc = [[RSAccountAndSafeViewController alloc]init];
        accountAndSafeVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:accountAndSafeVc animated:true];
    }else if (indexPath.row == 1) {
        //意见反馈的地方
        RSQuestionFeedBackViewController * questionFeedBackVc = [[RSQuestionFeedBackViewController alloc]init];
         questionFeedBackVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:questionFeedBackVc animated:YES];
    }else if (indexPath.row == 2){
        //这边是关于我们的界面
        RSAboutWeDetailViewController * aboutWeVc = [[RSAboutWeDetailViewController alloc]init];
        aboutWeVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutWeVc animated:YES];
    }else if(indexPath.row == 3){
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://400-0046056"];
        NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
        if (compare == NSOrderedDescending || compare == NSOrderedSame) {
            /// 大于等于10.0系统使用此openURL方法
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
                
                [JHSysAlertUtil presentAlertViewWithTitle:@"清理完毕" message:nil confirmTitle:@"确定" handler:^{
                    
                }];
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清理完毕" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                }];
//                [alert addAction:actionConfirm];
//                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                    alert.modalPresentationStyle = UIModalPresentationFullScreen;
//                }
//                [self presentViewController:alert animated:YES completion:nil];
            }];
        });
    }
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return false;
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
