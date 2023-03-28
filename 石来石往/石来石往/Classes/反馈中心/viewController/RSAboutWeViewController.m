//
//  RSAboutWeViewController.m
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAboutWeViewController.h"
#import "RSAboutWeCell.h"

#import "RSAboutWeDetailViewController.h"


@interface RSAboutWeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView * tableview;

@end

@implementation RSAboutWeViewController

- (UITableView *)tableview{
    if (!_tableview) {
        
        
        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableview;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * RSABOUTWECELL = @"RSABOUTWECELL";
    RSAboutWeCell * cell = [tableView dequeueReusableCellWithIdentifier:RSABOUTWECELL];
    if (!cell) {
        cell = [[RSAboutWeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSABOUTWECELL];
    }
    if (indexPath.row == 0) {
        cell.aboutWeLabel.text = @"当前版本";
        cell.bangLabel.text = @"1.3.6";
    }else{
        
        cell.aboutWeLabel.text = @"石来石往介绍";
        cell.bangLabel.text = @"";
    }
  
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RSAboutWeDetailViewController * aboutWeDetailVc = [[RSAboutWeDetailViewController alloc]init];
     aboutWeDetailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutWeDetailVc animated:YES];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.title = @"关于我们";
    
    [self.view addSubview:self.tableview];
    
    
    
    
    
    //这边设置一个表视图
    UIView * headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 250)];
    headerview.backgroundColor = [UIColor whiteColor];
    UIImageView * productImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 50, 200/2 - 50, 100, 100)];
    productImage.contentMode = UIViewContentModeScaleAspectFill;
    productImage.image = [UIImage imageNamed:@"logo"];
    [headerview addSubview:productImage];
    
    
    
    
    //文字图片
    UIImageView * titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 90, CGRectGetMaxY(productImage.frame) + 30, 180, 60)];
      titleImage.contentMode = UIViewContentModeScaleAspectFill;
    titleImage.image = [UIImage imageNamed:@"石来石往"];
    [headerview addSubview:titleImage];
    self.tableview.tableHeaderView = headerview;
    
    
    
    
    
    
    
    
    
    
    

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
