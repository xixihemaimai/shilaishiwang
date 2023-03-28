//
//  RSPersonalBaseViewController.m
//  石来石往
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"

@interface RSPersonalBaseViewController ()

@end

@implementation RSPersonalBaseViewController

//- (UITableView *)tableview{
//    if (!_tableview) {
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navHeight + navY, SCW, SCH - (navHeight + navY)) style:UITableViewStyleGrouped];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.estimatedRowHeight = 0;
//        _tableview.estimatedSectionFooterHeight = 0;
//        _tableview.estimatedSectionHeaderHeight = 0;
//        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
//        _tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return _tableview;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isAddjust];
    [self.view addSubview:self.tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PERSONALBASECELL = @"PERSONALBASECELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSONALBASECELL];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSONALBASECELL];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


- (NSString *)time_dateToString:(NSDate *)date{
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    //    [dateFormat setDateStyle:NSDateFormatterFullStyle];
    //    [dateFormat setTimeStyle:NSDateFormatterNoStyle];
    NSString * string = [dateFormat stringFromDate:date];
    return string;
}



- (NSString *)showCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}



-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

@end
