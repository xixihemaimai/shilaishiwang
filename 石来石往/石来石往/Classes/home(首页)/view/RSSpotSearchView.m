//
//  RSSpotSearchView.m
//  石来石往
//
//  Created by mac on 2022/8/17.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSSpotSearchView.h"
#import "RSCollectCell.h"

static NSString *collectID = @"collect";
@interface RSSpotSearchView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong)UITableView * stopSearchTableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end


@implementation RSSpotSearchView


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (UITableView *)stopSearchTableView{
    if (_stopSearchTableView == nil){
        _stopSearchTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _stopSearchTableView.delegate = self;
        _stopSearchTableView.dataSource = self;
        _stopSearchTableView.estimatedSectionFooterHeight = 0;
        _stopSearchTableView.estimatedSectionHeaderHeight = 0;
        _stopSearchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _stopSearchTableView.emptyDataSetSource = self;
        _stopSearchTableView.emptyDataSetDelegate = self;
    }
    return _stopSearchTableView;
}





- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.stopSearchTableView];
        self.stopSearchTableView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);

        [self.stopSearchTableView registerClass:[RSCollectCell class] forCellReuseIdentifier:collectID];
        
        [self initDataArray];
        
    }
    return self;
}


- (void)initDataArray{
    [SVProgressHUD showWithStatus:@"正在加载数据....."];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:self.userModel.userID forKey:@"userId"];
    [dict setObject:UserManger.getUserObject.userID forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_TEXT_COLLECTION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                _dataArray = [RSCollectionModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                [weakSelf.stopSearchTableView reloadData];
                [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD dismiss];
            }
        }else{
            [SVProgressHUD dismiss];
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:collectID];
    RSCollectionModel * collectionModel = self.dataArray[indexPath.row];
    cell.collectionModel = collectionModel;
    cell.removeBtn.tag = indexPath.row;
    cell.playPhoneBtn.tag = indexPath.row;
    [cell.removeBtn addTarget:self action:@selector(removeCollectProduct:) forControlEvents:UIControlEventTouchUpInside];
    [cell.playPhoneBtn addTarget:self action:@selector(playPhoneToCustomerService:) forControlEvents:UIControlEventTouchUpInside];
    cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
    UIView *backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = backGroundView;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


//#pragma mark -- 打电话给客服
- (void)playPhoneToCustomerService:(UIButton *)btn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"你确定要打电话给客服吗？" message:nil cancelTitle:@"确定" defaultTitle:@"取消" distinct: YES cancel:^{
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
        RSCollectCell *cell = [self.stopSearchTableView cellForRowAtIndexPath:indexpath];
        //改行的电话号码
        //这边是为了调用系统的打电话功能
        UIWebView *webview = [[UIWebView alloc]init];
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",cell.phoneLabel.text]]]];
        [self addSubview:webview];
    } confirm:^{
    }];
}



#pragma mark -- 移除该列
- (void)removeCollectProduct:(UIButton *)btn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"你确定需要对改行进行删除吗？" message:nil cancelTitle:@"确定" defaultTitle:@"取消" distinct:YES cancel:^{
        RSCollectionModel * collectionModel = self.dataArray[btn.tag];
        //对改行进行删除
         NSString * str = @"HxStock";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:str forKey:@"collType"];
        [dict setObject:collectionModel.collectionID forKey:@"collectionID"];
        [dict setObject:[NSString stringWithFormat:@"del"] forKey:@"operationType"];
        [dict setObject:UserManger.getUserObject.userID forKey:@"userId"];
        [dict setObject:collectionModel.stoneblno forKey:@"stoneblno"];
        [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"erpId"];
        if (collectionModel.stoneType == 1) {
            collectionModel.stoneturnsno  = @"";
            [dict setObject:collectionModel.stoneturnsno forKey:@"stoneturnsno"];
        }else{
            [dict setObject:collectionModel.stoneturnsno forKey:@"stoneturnsno"];
        }
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_HEADER_TEXT_STONECO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    [weakSelf.dataArray removeObjectAtIndex:btn.tag];
                    [weakSelf.stopSearchTableView reloadData];
                    [SVProgressHUD showSuccessWithStatus:@"你成功删除该行"];
                }
            }
        }];
        } confirm:^{
        }];
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"暂无数据icon1123"];
}

// 返回文字的提示
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor colorWithHexColorStr:@"#AAAAAA"]
                                 };
    NSAttributedString *attributedStr = [[NSAttributedString alloc]initWithString:title attributes:attributes];
    return attributedStr;
}


// 垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -Height_Real(64);
}

//是否允许点击 (默认是 YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

//要求知道空的状态应该渲染和显示 (Default is YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}


@end
