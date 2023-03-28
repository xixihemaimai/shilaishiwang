//
//  RSContactsActionView.m
//  石来石往
//
//  Created by mac on 2019/1/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSContactsActionView.h"
#import "RSContactsActionHeaderFootView.h"
#import "RSContactsActionFootView.h"
#import "RSContactsAcionCell.h"
#import "RSContactsActionSecondCell.h"
#import "RSOwerLinkManModel.h"
#import "RSSCCompanyHeaderContactModel.h"
#import "RSSCCompanyHeaderStoreModel.h"

@interface RSContactsActionView()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)UIView * menview;

@end

@implementation RSContactsActionView


- (UIView *)menview{
    if (!_menview) {
        _menview = [[UIView alloc]initWithFrame:self.bounds];
        _menview.backgroundColor = [UIColor colorWithHexColorStr:@"#7F7F7F" alpha:0.5];
        _menview.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCurrentView:)];
        [_menview addGestureRecognizer:tap];
    }
    return _menview;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCH, SCW, Height_Real(400)) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, Height_Real(100), 0);
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
    }
    return _tableview;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}



- (void)setUI{
    [self addSubview:self.menview];
    [self addSubview:self.tableview];
    [self.tableview bringSubviewToFront:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self show];
    });
    if ([self.selectype isEqualToString:@"1"] || [self.selectype isEqualToString:@"4"]) {
        [self.tableview setupEmptyDataText:@"去添加联系人" tapBlock:^{
        }];
    }else if([self.selectype isEqualToString:@"2"]){
        [self.tableview setupEmptyDataText:@"去添加地址" tapBlock:^{
        }];
    }else{
        [self.tableview setupEmptyDataText:@"去后台添加门店地址" tapBlock:^{
        }];
    }
    [self setCustomTableviewFootView];
}

- (void)setCustomTableviewFootView{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, Height_Real(30))];
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    footView.userInteractionEnabled = YES;
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, 0, SCW, Height_Real(30));
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(15)];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:cancelBtn];
    self.tableview.tableFooterView = footView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.contactsArray.count == 1) {
//        return 1;
//    }else if (self.contactsArray.count == 2){
//        return 2;
//    }else if (self.contactsArray.count >= 3){
       return self.contactsArray.count;
//    }
//    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Height_Real(51);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Height_Real(49);
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 45;
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * CONTACTSACTIONHEADERID = @"CONTACTSACTIONHEADERID";
    RSContactsActionHeaderFootView * contactsActionHeaderView = [[RSContactsActionHeaderFootView alloc]initWithReuseIdentifier:CONTACTSACTIONHEADERID];
    if ([self.selectype isEqualToString:@"1"] ||[self.selectype isEqualToString:@"4"]) {
        contactsActionHeaderView.nameLabel.text = @"联系人";
    }else if([self.selectype isEqualToString:@"2"]){
        contactsActionHeaderView.nameLabel.text = @"联系地址";
    }else if ([self.selectype isEqualToString:@"3"]){
        contactsActionHeaderView.nameLabel.text = @"门店";
    }
    if (self.isCurrent) {
        contactsActionHeaderView.editBtn.hidden = NO;
    }else{
        contactsActionHeaderView.editBtn.hidden = YES;
    }
    
    [contactsActionHeaderView.editBtn addTarget:self action:@selector(editContactsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return contactsActionHeaderView;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    RSContactsActionFootView * contactsActionFootView = [[RSContactsActionFootView alloc]init];
//    [contactsActionFootView.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
//    return contactsActionFootView;
//}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectype isEqualToString:@"1"] || [self.selectype isEqualToString:@"4"]) {
        static NSString * CONTACTSACTIONCELLID = @"CONTACTSACTIONCELLID";
        RSContactsAcionCell * cell = [tableView dequeueReusableCellWithIdentifier:CONTACTSACTIONCELLID];
        if (!cell) {
            cell = [[RSContactsAcionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CONTACTSACTIONCELLID];
        }
        if ([self.selectype isEqualToString:@"4"]) {
            RSSCCompanyHeaderContactModel * contactModel  = self.contactsArray[indexPath.row];
             cell.nameLabel.text = [NSString stringWithFormat:@"%@",contactModel.contactManName];
             cell.phoneLabel.text = [NSString stringWithFormat:@"%@",contactModel.contactNumber];
        }else{
            RSOwerLinkManModel * owerLinkManmodel  = self.contactsArray[indexPath.row];
             cell.nameLabel.text = [NSString stringWithFormat:@"%@",owerLinkManmodel.ownerLinkMan];
             cell.phoneLabel.text = [NSString stringWithFormat:@"%@",owerLinkManmodel.ownerPhone];
        }
        return cell;
    }else if([self.selectype isEqualToString:@"2"]){
         static NSString * CONTACTSACTIONSECONDCELLID = @"CONTACTSACTIONSECONDCELLID";
        RSContactsActionSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:CONTACTSACTIONSECONDCELLID];
        if (!cell) {
            cell = [[RSContactsActionSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CONTACTSACTIONSECONDCELLID];
        }
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",self.contactsArray[indexPath.row]];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"123"];
        }
        RSSCCompanyHeaderStoreModel * storeModel = self.contactsArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",storeModel.storeName,storeModel.storeAddress];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.selectype isEqualToString:@"1"] || [self.selectype isEqualToString:@"4"]) {
        NSString * phoneNum = @"";
        if ([self.selectype isEqualToString:@"1"]) {
            RSOwerLinkManModel * owerLinkManmodel = self.contactsArray[indexPath.row];
            phoneNum = owerLinkManmodel.ownerPhone;
        }else{
            RSSCCompanyHeaderContactModel * contactModel  = self.contactsArray[indexPath.row];
            phoneNum = contactModel.contactNumber;
        }
        //这边是打电话
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",phoneNum];
        if ([UIDevice currentDevice].systemVersion.floatValue > 10.0) {
                /// 大于等于10.0系统使用此openURL方法
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }else if ([self.selectype isEqualToString:@"3"]){
        if ([self.delegate respondsToSelector:@selector(selectChangeContactsFuntionIndex:andContactsArrayStr:andRSContactsActionView:)]) {
            RSSCCompanyHeaderStoreModel * storeModel = self.contactsArray[indexPath.row];
            [self.delegate selectChangeContactsFuntionIndex:indexPath.row andContactsArrayStr:[NSString stringWithFormat:@"%@ %@",storeModel.storeName,storeModel.storeAddress] andRSContactsActionView:self];
        }
    }
    [self hide];
}


//编辑
- (void)editContactsAction:(UIButton *)editBtn{
    //selectChangeContactsFuntionSelectype
    if ([self.delegate respondsToSelector:@selector(selectChangeContactsFuntionSelectype:andRSContactsActionView:)]) {
        [self.delegate selectChangeContactsFuntionSelectype:self.selectype andRSContactsActionView:self];
    }
    [self hide];
}


//取消
- (void)cancelAction:(UIButton *)cancelBtn{
    [self hide];
}


- (void)hideCurrentView:(UITapGestureRecognizer *)tap{
    [self hide];
}

/**显示*/
- (void)show{
    [UIView animateWithDuration:0.2 animations:^{
        self.tableview.frame = CGRectMake(0, SCH - Height_Real(400),SCW,Height_Real(400));
//        if (self.contactsArray.count < 1) {
//            self.tableview.frame = CGRectMake(0, SCH - Height_Real(147), SCW, Height_Real(147));
//        }else if (self.contactsArray.count == 1){
//            self.tableview.frame = CGRectMake(0, SCH - Height_Real(147), SCW, Height_Real(147));
//        }else if (self.contactsArray.count == 2){
//            self.tableview.frame = CGRectMake(0, SCH - Height_Real(198), SCW, Height_Real(198));
//        }else{
//            self.tableview.frame = CGRectMake(0, SCH - Height_Real(249), SCW, Height_Real(249));
//        }
    }];
    
}

/**隐藏*/
- (void)hide{
    if ([self.delegate respondsToSelector:@selector(hideCurrentShowView:)]) {
        [self.delegate hideCurrentShowView:self];
    }
    [self.menview removeFromSuperview];
    [UIView animateWithDuration:0.2 animations:^{
        self.tableview.frame = CGRectMake(0, SCH, SCW, Height_Real(400));
        [self.tableview removeFromSuperview];
    }];
}

@end
