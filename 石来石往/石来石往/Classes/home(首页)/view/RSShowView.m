//
//  RSShowView.m
//  StoneOnlineApp
//
//  Created by 曾旭升 on 16/3/8.
//  Copyright © 2016年 RuishiInfo. All rights reserved.
//

#import "RSShowView.h"
#import "CompanyTableViewCell.h"
@implementation RSShowView
-(id)init{
    if (self =[super init]) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RSShowView" owner:nil                                                               options:nil];
        
        self= nib[0];
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        _tableview.delegate =self;
        _tableview.dataSource =self;
        _mArrSelect = [NSMutableArray array];
    }
    return self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _arrCount.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"CompanyTableViewCell";
    CompanyTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CompanyTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.lbltittle.text =_arrCompanyName[indexPath.row];
    if ([_mArrSelect containsObject:intChangString(indexPath.row)]) {
        [cell.btnSelect setImage:[UIImage imageNamed:@"list_btn_radio_check_on.png"] forState:UIControlStateNormal];
    }else {
        [cell.btnSelect setImage:[UIImage imageNamed:@"list_btn_radio_check_off.png"] forState:UIControlStateNormal];
    }
    [cell.btnSelect addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)initData:(NSArray *)arr{
    _arrData =arr;
    _arrCount =[arr[2] componentsSeparatedByString:@";"];
    _arrCompanyName =[arr[3] componentsSeparatedByString:@";"];
    if (![arr[4]  isEqual:@"-1"]) {
        _mArrSelect = [[arr[4] componentsSeparatedByString:@";"]mutableCopy];
    }
    _lblTitle.text =arr[1];
    
    [self.tableview reloadData];
}

-(void)btnSelect:(UIButton *)sender{
    UITableViewCell *clickCell=(UITableViewCell*)[[sender superview] superview];
    NSIndexPath * path = [self.tableview indexPathForCell:clickCell];
    if (_type ==kShowDataTypeOne) {
        [_mArrSelect removeAllObjects];
    }
    if ([_mArrSelect containsObject:intChangString(path.row)]) {
        [_mArrSelect removeObject:intChangString(path.row)];
    }else {
         [_mArrSelect addObject:intChangString(path.row)];
    }
    [_tableview reloadData];
}

- (IBAction)btnSure:(UIButton *)sender {
    if (_mArrSelect.count==0) {
        return;
    }
    NSMutableArray * _mArrSelectCount = [NSMutableArray array];
    NSMutableArray * _mArrSelectCompany = [NSMutableArray array];
    for (NSString *string in _mArrSelect) {
        [_mArrSelectCount addObject:_arrCount[[string intValue]]];
        [_mArrSelectCompany addObject:_arrCompanyName[[string intValue]]];
    }
     [self.detelage selectCodes:[_mArrSelectCount componentsJoinedByString:@";"] andNames:[_mArrSelectCompany componentsJoinedByString:@";"]];
    self.hidden =YES;
}

- (IBAction)hidden:(UITapGestureRecognizer *)sender {
    
    self.hidden =YES;
}
@end
