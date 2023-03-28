//
//  RSAllHuangAndDaViewController.m
//  石来石往
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAllHuangAndDaViewController.h"
#import "RSCompanyAndStoneModel.h"
/**组头*/
#import "RSNewSearchHeaderview.h"
/**组尾*/
#import "RSNewSearchFooterview.h"
/**每组Cell*/
#import "RSNewSearchFirstCell.h"
#import "RSNewSearchSecondCell.h"
#import "RSNewSearchThirdCell.h"
#import "RSBlocksNumberViewController.h"
#import "RSHuangDetailAndDaDetailViewController.h"
#import "RSFriendDetailController.h"
#import "RSDetailSegmentViewController.h"
#import "RSSearchHuangAndDabanViewController.h"

@interface RSAllHuangAndDaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * _label;
}
/**上拉还是下拉*/
//@property (nonatomic,assign)BOOL isrefresh;
/**页数*/
//@property (nonatomic,assign)NSInteger pageNum;
/**显示内容*/
@property (nonatomic,strong)UITableView * tableview;
/**获取荒料号数组*/
@property (nonatomic,strong)NSMutableArray * showArray;
/**获取物料名称的数组*/
@property (nonatomic,strong)NSMutableArray * wuArray;
/**获取商圈的数组*/
@property (nonatomic,strong)NSMutableArray * stoneArray;

@end

@implementation RSAllHuangAndDaViewController
- (NSMutableArray *)showArray{
    if (_showArray == nil) {
        _showArray = [NSMutableArray array];
    }
    return _showArray;
}

- (NSMutableArray *)wuArray{
    if (_wuArray == nil) {
        _wuArray = [NSMutableArray array];
    }
    return _wuArray;
}

- (NSMutableArray *)stoneArray{
    if (_stoneArray == nil) {
        _stoneArray = [NSMutableArray array];
    }
    return _stoneArray;
}

#pragma mark -- 是大板还是荒料
- (NSString *)searchStr{
    return @"";
}

#pragma mark -- 搜索的内容
- (NSString *)searchType{
    return @"";
}

- (RSUserModel *)userModel{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustonTableview];
    [self loadHuangAndDaNewData];
}

- (void)addCustonTableview{
    UITableView * tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableview = tableview;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11) {
        self.tableview.estimatedRowHeight = 0.01;
        self.tableview.estimatedSectionHeaderHeight = 0.01;
        self.tableview.estimatedSectionFooterHeight = 0.01;
    }
    // 设置tableView的内边距
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 64+50, 0);
    [self.view addSubview:self.tableview];
    UILabel * label = [[UILabel alloc]init];
    _label = label;
    label.text = @"你搜索的条件，暂时没有内容";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.hidden = YES;
    
    label.sd_layout
    .centerXEqualToView(self.tableview)
    .centerYEqualToView(self.tableview)
    .widthIs(SCW)
    .heightIs(45);
    [self.tableview addSubview:label];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHuangAndDaNewData];
    }];
}

- (void)loadHuangAndDaNewData{
    if (![self.searchStr isEqualToString:@""]) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.searchStr forKey:@"text"];
        [dict setObject:applegate.ERPID forKey:@"erpId"];
        [dict setObject:self.searchType forKey:@"type"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_HEADER_DETAILSEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result ) {
                    [weakSelf.showArray removeAllObjects];
                    [weakSelf.wuArray removeAllObjects];
                    [weakSelf.stoneArray removeAllObjects];
                    NSMutableArray * array = nil;
                    array = json[@"Data"];
                    if (array.count >= 1) {
                for (int i = 0; i < array.count; i++) {
                    //这边有三个数组进行的区分
                    if (i == 0) {
                    NSMutableArray * wuArray = [NSMutableArray array];
                    wuArray = array[i];
                        if (wuArray.count >= 1) {
                            for (int j = 0; j < wuArray.count; j++) {
                                RSCompanyAndStoneModel * companyAndStoneModel = [[RSCompanyAndStoneModel alloc]init];
                                companyAndStoneModel.blockId = [[wuArray objectAtIndex:j]objectForKey:@"blockId"];
                                companyAndStoneModel.content = [[wuArray objectAtIndex:j]objectForKey:@"content"];
                                companyAndStoneModel.createTime = [[wuArray objectAtIndex:j]objectForKey:@"createTime"];
                                companyAndStoneModel.erpCode = [[wuArray objectAtIndex:j]objectForKey:@"erpCode"];
                                companyAndStoneModel.imgUrl = [[wuArray objectAtIndex:j]objectForKey:@"imgUrl"];
                                companyAndStoneModel.friendId = [[wuArray objectAtIndex:j]objectForKey:@"friendId"];
                                companyAndStoneModel.qty = [[wuArray objectAtIndex:j]objectForKey:@"qty"];
                                companyAndStoneModel.stockType = [[wuArray objectAtIndex:j]objectForKey:@"stockType"];
                                companyAndStoneModel.stoneId = [[wuArray objectAtIndex:j]objectForKey:@"stoneId"];
                                companyAndStoneModel.turnsQty = [[wuArray objectAtIndex:j]objectForKey:@"turnsQty"];
                                companyAndStoneModel.type = [[wuArray objectAtIndex:j]objectForKey:@"type"];
                                companyAndStoneModel.vaqty = [[wuArray objectAtIndex:j]objectForKey:@"vaqty"];
                                companyAndStoneModel.companyName = [[wuArray objectAtIndex:j]objectForKey:@"companyName"];
                                companyAndStoneModel.phone = [[wuArray objectAtIndex:j]objectForKey:@"phone"];
                                companyAndStoneModel.weight = [[wuArray objectAtIndex:j]objectForKey:@"weight"];
                                [weakSelf.wuArray addObject:companyAndStoneModel];
                            }
                        }
                    }else if(i == 1){
                        NSMutableArray * huArray = [NSMutableArray array];
                        huArray = array[i];
                        if (huArray.count >= 1) {
                            for (int j = 0; j < huArray.count; j++) {
                                RSCompanyAndStoneModel * companyAndStoneModel = [[RSCompanyAndStoneModel alloc]init];
                                companyAndStoneModel.blockId = [[huArray objectAtIndex:j]objectForKey:@"blockId"];
                                companyAndStoneModel.content = [[huArray objectAtIndex:j]objectForKey:@"content"];
                                companyAndStoneModel.createTime = [[huArray objectAtIndex:j]objectForKey:@"createTime"];
                                companyAndStoneModel.erpCode = [[huArray objectAtIndex:j]objectForKey:@"erpCode"];
                                companyAndStoneModel.imgUrl = [[huArray objectAtIndex:j]objectForKey:@"imgUrl"];
                                companyAndStoneModel.friendId = [[huArray objectAtIndex:j]objectForKey:@"friendId"];
                                companyAndStoneModel.qty = [[huArray objectAtIndex:j]objectForKey:@"qty"];
                                companyAndStoneModel.stockType = [[huArray objectAtIndex:j]objectForKey:@"stockType"];
                                companyAndStoneModel.stoneId = [[huArray objectAtIndex:j]objectForKey:@"stoneId"];
                                companyAndStoneModel.turnsQty = [[huArray objectAtIndex:j]objectForKey:@"turnsQty"];
                                companyAndStoneModel.type = [[huArray objectAtIndex:j]objectForKey:@"type"];
                                companyAndStoneModel.vaqty = [[huArray objectAtIndex:j]objectForKey:@"vaqty"];
                                companyAndStoneModel.companyName = [[huArray objectAtIndex:j]objectForKey:@"companyName"];
                                companyAndStoneModel.phone = [[huArray objectAtIndex:j]objectForKey:@"phone"];
                                companyAndStoneModel.weight = [[huArray objectAtIndex:j]objectForKey:@"weight"];
                                [weakSelf.showArray addObject:companyAndStoneModel];
                            }
                        }
                    }else{
                        NSMutableArray * quanArray = [NSMutableArray array];
                        quanArray = array[i];
                        if (quanArray.count >= 1) {
                            for (int j = 0; j < quanArray.count; j++) {
                                RSCompanyAndStoneModel * companyAndStoneModel = [[RSCompanyAndStoneModel alloc]init];
                                companyAndStoneModel.blockId = [[quanArray objectAtIndex:j]objectForKey:@"blockId"];
                                companyAndStoneModel.content = [[quanArray objectAtIndex:j]objectForKey:@"content"];
                                companyAndStoneModel.createTime = [[quanArray objectAtIndex:j]objectForKey:@"createTime"];
                                companyAndStoneModel.erpCode = [[quanArray objectAtIndex:j]objectForKey:@"erpCode"];
                                companyAndStoneModel.imgUrl = [[quanArray objectAtIndex:j]objectForKey:@"imgUrl"];
                                companyAndStoneModel.friendId = [[quanArray objectAtIndex:j]objectForKey:@"friendId"];
                                companyAndStoneModel.qty = [[quanArray objectAtIndex:j]objectForKey:@"qty"];
                                companyAndStoneModel.stockType = [[quanArray objectAtIndex:j]objectForKey:@"stockType"];
                                companyAndStoneModel.stoneId = [[quanArray objectAtIndex:j]objectForKey:@"stoneId"];
                                companyAndStoneModel.turnsQty = [[quanArray objectAtIndex:j]objectForKey:@"turnsQty"];
                                companyAndStoneModel.type = [[quanArray objectAtIndex:j]objectForKey:@"type"];
                                companyAndStoneModel.companyName = [[quanArray objectAtIndex:j]objectForKey:@"companyName"];
                                companyAndStoneModel.vaqty = [[quanArray objectAtIndex:j]objectForKey:@"vaqty"];
                                companyAndStoneModel.phone = [[quanArray objectAtIndex:j]objectForKey:@"phone"];
                                companyAndStoneModel.weight = [[quanArray objectAtIndex:j]objectForKey:@"weight"];
                                [weakSelf.stoneArray addObject:companyAndStoneModel];
                            }
                        }
                    }
                }
                }
                    [weakSelf.tableview.mj_header endRefreshing];
                    [weakSelf.tableview reloadData];
            }else{
                _label.hidden = NO;
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }
    }];
   }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.wuArray.count > 3) {
            return 3;
        }else{
            return self.wuArray.count;
        }
    }else if(section == 1){
        if (self.stoneArray.count > 3) {
            return 3;
        }else{
            return self.stoneArray.count;
        }
    }else{
        if (self.showArray.count > 3) {
            return 3;
        }else{
            return self.showArray.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) {
            //第一种为名称的Cell
            static NSString * NEWSEARCHTHIRSTID = @"newsearchthirdid";
            RSNewSearchThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWSEARCHTHIRSTID];
            if (!cell) {
                cell = [[RSNewSearchThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWSEARCHTHIRSTID];
            }
             RSCompanyAndStoneModel * companyAndStonemodel = self.wuArray[indexPath.row];
            cell.companyAndStonemodel = companyAndStonemodel;
            NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.searchStr andModelStr:companyAndStonemodel.stoneId];
            cell.fristHuangliaoLabel.attributedText = attributedstring;
            return cell;
        }else if (indexPath.section == 1){
            //第二种为石圈的Cell
            static NSString * NEWSEARCHSECONDID = @"newsearchsecondid";
            RSNewSearchSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWSEARCHSECONDID];
            if (!cell) {
                cell = [[RSNewSearchSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWSEARCHSECONDID];
            }
             RSCompanyAndStoneModel * companyAndStonemodel = self.stoneArray[indexPath.row];
            cell.companyAndStonemodel = companyAndStonemodel;
            NSString * str = [self delSpaceAndNewline:companyAndStonemodel.content];
             NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.searchStr andModelStr:str];
            cell.textview.attributedText = attributedstring;
            return cell;
        }else{
            //第三种荒料号的Cell
            static NSString * NEWSEARCHFRISTID = @"newsearchfristid";
            RSNewSearchFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWSEARCHFRISTID];
            if (!cell) {
                cell =  [[RSNewSearchFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWSEARCHFRISTID];
            }
            RSCompanyAndStoneModel * companyAndStonemodel = self.showArray[indexPath.row];
            cell.companyAndStonemodel = companyAndStonemodel;
              NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.searchStr andModelStr:companyAndStonemodel.blockId];
            cell.fristHuangliaoLabel.attributedText = attributedstring;
            return cell;
        }
}


- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.wuArray.count < 1) {
            return 70;
        }else{
            return 40;
        }
    }else if (section == 1){
        if (self.stoneArray.count < 1) {
            return 70;
        }else{
            return 40;
        }
    }else{
        if (self.showArray.count < 1) {
            return 70;
        }else{
            return 40;
        }
    }
}

#pragma mark -- 组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

static NSString * newSearchFootID = @"newSearchFootid";
static NSString * newSearchHeaderID = @"newSearchHeaderid";
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
       RSNewSearchFooterview * newSearchfootview = [[RSNewSearchFooterview alloc]initWithReuseIdentifier:newSearchFootID];
    if (section == 0) {
        if (self.wuArray.count < 1) {
           newSearchfootview.alertLabel.sd_layout
            .leftSpaceToView(newSearchfootview.contentView, 0)
            .rightSpaceToView(newSearchfootview.contentView, 0)
            .topSpaceToView(newSearchfootview.contentView, 0)
            .heightIs(30);
            newSearchfootview.alertLabel.hidden = NO;
        }else{
            newSearchfootview.alertLabel.sd_layout
            .leftSpaceToView(newSearchfootview.contentView, 0)
            .rightSpaceToView(newSearchfootview.contentView, 0)
            .topSpaceToView(newSearchfootview.contentView, 0)
            .heightIs(0);
            newSearchfootview.alertLabel.hidden = YES;
        }
    }else if (section == 1){
        if (self.stoneArray.count < 1) {
          newSearchfootview.alertLabel.sd_layout
            .leftSpaceToView(newSearchfootview.contentView, 0)
            .rightSpaceToView(newSearchfootview.contentView, 0)
            .topSpaceToView(newSearchfootview.contentView, 0)
            .heightIs(30);
            newSearchfootview.alertLabel.hidden = NO;
        }else{
         newSearchfootview.alertLabel.sd_layout
            .leftSpaceToView(newSearchfootview.contentView, 0)
            .rightSpaceToView(newSearchfootview.contentView, 0)
            .topSpaceToView(newSearchfootview.contentView, 0)
            .heightIs(0);
            newSearchfootview.alertLabel.hidden = YES;
        }
    }else{
        if (self.showArray.count < 1) {
             newSearchfootview.alertLabel.hidden = NO;
         newSearchfootview.alertLabel.sd_layout
            .leftSpaceToView(newSearchfootview.contentView, 0)
            .rightSpaceToView(newSearchfootview.contentView, 0)
            .topSpaceToView(newSearchfootview.contentView, 0)
            .heightIs(30);
        }else{
         newSearchfootview.alertLabel.sd_layout
            .leftSpaceToView(newSearchfootview.contentView, 0)
            .rightSpaceToView(newSearchfootview.contentView, 0)
            .topSpaceToView(newSearchfootview.contentView, 0)
            .heightIs(0);
            newSearchfootview.alertLabel.hidden = YES;
        }
    }
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [newSearchfootview.contentView addSubview:moreBtn];
    moreBtn.sd_layout
    .leftSpaceToView(newSearchfootview.contentView, 0)
    .rightSpaceToView(newSearchfootview.contentView, 0)
    //.topSpaceToView(newSearchfootview.contentView, 0)
    .topSpaceToView(newSearchfootview.alertLabel, 0)
    .bottomSpaceToView(newSearchfootview.contentView, 10);
    [moreBtn addTarget:self action:@selector(clickMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.tag = section;
        if (section == 0) {
            [newSearchfootview.checkMoreBtn setTitle:@"查看更多相关物料" forState:UIControlStateNormal];
            [moreBtn setTitle:newSearchfootview.checkMoreBtn.titleLabel.text forState:UIControlStateNormal];
        }else if (section == 1){
            [newSearchfootview.checkMoreBtn setTitle:@"查看更多相关石圈" forState:UIControlStateNormal];
             [moreBtn setTitle:newSearchfootview.checkMoreBtn.titleLabel.text forState:UIControlStateNormal];
        }else{
            [newSearchfootview.checkMoreBtn setTitle:@"查看更多相关荒料号" forState:UIControlStateNormal];
             [moreBtn setTitle:newSearchfootview.checkMoreBtn.titleLabel.text forState:UIControlStateNormal];
        }
        return newSearchfootview;
}

- (void)clickMoreAction:(UIButton *)moreBtn{
    NSInteger type = 0;
    if (moreBtn.tag == 0) {
        type = 1;
    }else if (moreBtn.tag == 1){
        type = 3;
    }else{
        type = 2;
    }
    RSBlocksNumberViewController * blockSNumberVc = [[RSBlocksNumberViewController alloc]init];
    blockSNumberVc.searchType = type;
    blockSNumberVc.searchStr = self.searchStr;
    blockSNumberVc.classifyStr = self.searchType;
    blockSNumberVc.userModel = self.userModel;
    [self.navigationController pushViewController:blockSNumberVc animated:YES];
}

#pragma mark -- 组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        RSNewSearchHeaderview * newSearchHeaderview = [[RSNewSearchHeaderview alloc]initWithReuseIdentifier:newSearchHeaderID];
        newSearchHeaderview.contentView.backgroundColor = [UIColor whiteColor];
        if (section == 0) {
            newSearchHeaderview.headerlabel.text = @"物料名称";
        }else if (section == 1){
            newSearchHeaderview.headerlabel.text = @"石圈";
        }else{
            newSearchHeaderview.headerlabel.text = @"荒料号";
        }
        return newSearchHeaderview;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RSSearchHuangAndDabanViewController * searchHuangVc = [[RSSearchHuangAndDabanViewController alloc]init];
        [self.navigationController pushViewController:searchHuangVc animated:YES];
    }else if (indexPath.section == 1){
        //评论页面
        RSCompanyAndStoneModel * companyAndStonemodel = self.stoneArray[indexPath.row];
        RSFriendDetailController * freindDeatilVc = [[RSFriendDetailController alloc]init];
        freindDeatilVc.friendID = companyAndStonemodel.friendId;
        freindDeatilVc.titleStyle = @"";
        freindDeatilVc.selectStr = @"";
        freindDeatilVc.userModel = self.userModel;
        [self.navigationController pushViewController:freindDeatilVc animated:YES];
    }else{
        //还有问题
        //详情页面
        RSCompanyAndStoneModel * companyAndStonemodel = self.showArray[indexPath.row];
        RSDetailSegmentViewController * detailVc = [[RSDetailSegmentViewController alloc]init];
        //detailVc.companyAndStoneModel = companyAndStonemodel;
        detailVc.tempStr1 =@"-1";
        detailVc.tempStr2 = @"-1";
        detailVc.tempStr3 = @"-1";
        detailVc.tempStr4 = @"-1";
        detailVc.btnStr1 = @"-1";
        detailVc.btnStr2 = @"-1";
        detailVc.btnStr3 = @"-1";
        detailVc.btnStr4 = @"-1";
        detailVc.imageUrl = companyAndStonemodel.imgUrl;
        detailVc.shitouName = companyAndStonemodel.stoneId;
        //数量
        detailVc.keAndZaStr = companyAndStonemodel.turnsQty;
        detailVc.piAndFangStr = companyAndStonemodel.vaqty;
        
        detailVc.title = companyAndStonemodel.stoneId;
        detailVc.phone = companyAndStonemodel.phone;
        detailVc.weight = companyAndStonemodel.weight;
        detailVc.stoneName = companyAndStonemodel.stoneId;
        detailVc.companyName = companyAndStonemodel.companyName;
        detailVc.searchType = companyAndStonemodel.stockType;
        detailVc.titleStr = companyAndStonemodel.blockId;
        detailVc.userModel = self.userModel;
        detailVc.erpCode = companyAndStonemodel.erpCode;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
