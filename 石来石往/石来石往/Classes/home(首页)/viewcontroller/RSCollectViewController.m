//
//  RSCollectViewController.m
//  石来石往
//
//  Created by mac on 17/5/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSCollectViewController.h"
#import "RSCollectCell.h"
#import "RSCollectionModel.h"

#import "RSSpotSearchView.h"
#import "RSCLSelectionCenterView.h"


@interface RSCollectViewController ()<UIScrollViewDelegate>
{
//    UIView * _navigationview;
//
//
//    UIButton * _editSelectBtn;
//
//    UIButton * _allSelectBtn;
//    //删除
//    UIButton * _delectBtn;
}

//@property (nonatomic,strong)NSMutableArray *dataArray;
/**要删除的数据*/
//@property (nonatomic, strong)NSMutableArray *deleteArray;



@property (nonatomic,strong)UIButton * stopSearchBtn;

@property (nonatomic,strong)UIView * stopSearchBottomView;

@property (nonatomic,strong)UIButton * selectCenterBtn;

@property (nonatomic,strong)UIView * selectCenterBottomView;

@property (nonatomic,strong)UIScrollView * contentScrollView;



@end
@implementation RSCollectViewController

- (UIButton *)stopSearchBtn{
    if (!_stopSearchBtn){
        _stopSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stopSearchBtn setTitle:@"现货搜索" forState:UIControlStateNormal];
        [_stopSearchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateSelected];
        [_stopSearchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        _stopSearchBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(15)];
        _stopSearchBtn.tag = 1;
        [_stopSearchBtn addTarget:self action:@selector(choiceCollectionActionType:) forControlEvents:UIControlEventTouchUpInside];
        _stopSearchBtn.selected = true;
    }
    return _stopSearchBtn;
}

- (UIView *)stopSearchBottomView{
    if (!_stopSearchBottomView){
        _stopSearchBottomView = [[UIView alloc]init];
        _stopSearchBottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    }
    return _stopSearchBottomView;
}

- (UIButton *)selectCenterBtn{
    if (!_selectCenterBtn){
        _selectCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectCenterBtn setTitle:@"选材中心" forState:UIControlStateNormal];
        [_selectCenterBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateSelected];
        [_selectCenterBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        _selectCenterBtn.tag = 2;
        [_selectCenterBtn addTarget:self action:@selector(choiceCollectionActionType:) forControlEvents:UIControlEventTouchUpInside];
        _selectCenterBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(15)];
        _selectCenterBtn.selected = false;
    }
    return _selectCenterBtn;
}

- (UIView *)selectCenterBottomView{
    if (!_selectCenterBottomView){
        _selectCenterBottomView = [[UIView alloc]init];
        _selectCenterBottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        _selectCenterBottomView.hidden = true;
    }
    return _selectCenterBottomView;
}


- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]init];
        _contentScrollView.contentSize = CGSizeMake(SCW * 2, 0);
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}



//-(NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
//
//- (NSMutableArray *)deleteArray{
//    if (!_deleteArray) {
//        _deleteArray = [NSMutableArray array];
//    }
//    return _deleteArray;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.hidesBottomBarWhenPushed = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

static NSString *collectID = @"collect";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    
    
    
//    [self isAddjust];
//    [self.view addSubview:self.tableview];
    self.title = @"收藏";
//    [self addCustomNavigationBar];
//    [self initDataArray];
//    [self addBottomCustionView];
//    [self.tableview registerClass:[RSCollectCell class] forCellReuseIdentifier:collectID];
    
    
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    topView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).heightIs(Width_Real(39.5));
    
    
    [topView addSubview:self.stopSearchBtn];
    [topView addSubview:self.stopSearchBottomView];
    [topView addSubview:self.selectCenterBtn];
    [topView addSubview:self.selectCenterBottomView];
    
    
    self.stopSearchBtn.sd_layout.leftEqualToView(topView).topSpaceToView(topView, 0).bottomSpaceToView(topView, 0).widthIs(SCW/2);
    
    self.stopSearchBottomView.sd_layout.bottomSpaceToView(topView, 0).heightIs(Width_Real(1.5)).widthIs(Width_Real(62)).leftSpaceToView(topView, SCW/4 - Width_Real(62)/2);
    
    self.selectCenterBtn.sd_layout.leftSpaceToView(self.stopSearchBtn, 0).topSpaceToView(topView, 0).bottomSpaceToView(topView, 0).widthIs(SCW/2);
    
    self.selectCenterBottomView.sd_layout.bottomSpaceToView(topView, 0).heightIs(Width_Real(1.5)).widthIs(Width_Real(62)).leftSpaceToView(self.stopSearchBtn, SCW/4 - Width_Real(62)/2);
    
    self.stopSearchBottomView.layer.cornerRadius = Width_Real(5);
    self.selectCenterBottomView.layer.cornerRadius = Width_Real(5);
    
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(topView, Width_Real(12)).bottomSpaceToView(self.view, 0);
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    
    
    
    RSSpotSearchView * stopSearchView = [[RSSpotSearchView alloc]init];
    [self.contentScrollView addSubview:stopSearchView];
    stopSearchView.sd_layout.leftSpaceToView(self.contentScrollView, 0).topSpaceToView(self.contentScrollView, 0).bottomSpaceToView(self.contentScrollView, 0).rightSpaceToView(self.contentScrollView, 0);
    
    
    RSCLSelectionCenterView * clSelectCenterView = [[RSCLSelectionCenterView alloc]init];
    [self.contentScrollView addSubview:clSelectCenterView];
    clSelectCenterView.sd_layout.leftSpaceToView(stopSearchView, 0).topSpaceToView(self.contentScrollView, 0).bottomSpaceToView(self.contentScrollView, 0).widthIs(SCW);
}


- (void)choiceCollectionActionType:(UIButton *)sender{
    if (sender.tag == 1){
        [self refreshCategory:0];
    }else if (sender.tag == 2){
        [self refreshCategory:1];
    }
}



- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self refreshCategory:scrollView.contentOffset.x / scrollView.width];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self refreshCategory:scrollView.contentOffset.x / scrollView.width];
}


- (void)refreshCategory:(int)index{
    [self.contentScrollView setContentOffset:CGPointMake(SCW * index, 0) animated:true];
    if (index == 0){
        self.stopSearchBtn.selected = true;
        self.stopSearchBottomView.hidden = false;
        self.selectCenterBtn.selected = false;
        self.selectCenterBottomView.hidden = true;
    }else{
        self.stopSearchBtn.selected = false;
        self.stopSearchBottomView.hidden = true;
        self.selectCenterBtn.selected = true;
        self.selectCenterBottomView.hidden = false;
    }
}






//- (void)initDataArray{
//    [SVProgressHUD showWithStatus:@"正在加载数据....."];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:self.userModel.userID forKey:@"userId"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_HEADER_TEXT_COLLECTION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                _dataArray = [RSCollectionModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
////                _label.hidden = YES;
//                [weakSelf.tableview reloadData];
//                [SVProgressHUD dismiss];
//            }else{
////                _label.hidden = NO;
//                [SVProgressHUD dismiss];
//            }
//        }else{
////            _label.hidden = NO;
//            [SVProgressHUD dismiss];
//        }
//    }];
//}




//TODO:在底下添加删除界面
//- (void)addBottomCustionView{
//    UIButton * delectBtn = [[UIButton alloc]init];
//    [delectBtn setTitle:@"删除" forState:UIControlStateNormal];
//    [delectBtn setBackgroundColor:[UIColor redColor]];
//    delectBtn.hidden = YES;
//    [self.view addSubview:delectBtn];
//    _delectBtn = delectBtn;
//    delectBtn.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).heightIs(45);
//    [delectBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:delectBtn];
//}
//
////将选中的cell加入删除的数据数组中
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView.editing) {
//        [self.deleteArray addObject:_dataArray[indexPath.row]];
//    }else{
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
//}
//
////从要删除的数组中移除未选中的cell
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.deleteArray removeObject:_dataArray[indexPath.row]];
//}
//
//#pragma mark -- 删除
//- (void)deleteBtnClick:(UIButton *)btn{
//    if (self.deleteArray.count > 0) {
//        NSString * erpid = [[NSString alloc]init];
//        NSMutableArray * array = [NSMutableArray array];
//        if (self.tableview.editing) {
//            for (RSCollectionModel * collectionModel in self.deleteArray) {
//                [array addObject:collectionModel.collectionID];
//                erpid = [array componentsJoinedByString:@","];
//            }
//            [self deletaAllData:erpid] ;
//        }
//    }else{
//        [SVProgressHUD showInfoWithStatus:@"请先选择自己需要删除的内容"];
//    }
//}
//
//#pragma mark -- 批量删除
//- (void)deletaAllData:(NSString *)erpid{
//    //对改行进行删除
//    NSString * str = @"HxStock";
//    // NSIndexPath *indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:str forKey:@"collType"];
//    [dict setObject:erpid forKey:@"collectionID"];
//    [dict setObject:[NSString stringWithFormat:@"del"] forKey:@"operationType"];
//    [dict setObject:self.userModel.userID forKey:@"userId"];
//    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"erpId"];
//    [dict setObject:[NSString stringWithFormat:@""] forKey:@"stoneblno"];
//    [dict setObject:[NSString stringWithFormat:@""] forKey:@"stoneturnsno"];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_HEADER_TEXT_STONECO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                [weakSelf.dataArray removeObjectsInArray:weakSelf.deleteArray];
//                [weakSelf.tableview reloadData];
//                [SVProgressHUD showSuccessWithStatus:@"成功删除"];
//            }else{
//            }
//        }
//    }];
//}
//
//#pragma mark -- 界面导航栏
//- (void)addCustomNavigationBar{
//    UIButton * allSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
//    _allSelectBtn = allSelectBtn;
//    [allSelectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    [allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
//    _allSelectBtn.hidden = YES;
//    [allSelectBtn addTarget:self action:@selector(allSelcectDelect:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightallSelectitem = [[UIBarButtonItem alloc]initWithCustomView:allSelectBtn];
//    UIButton * editSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
//    _editSelectBtn = editSelectBtn;
//    [editSelectBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    [editSelectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    [editSelectBtn addTarget:self action:@selector(editSelectDelect:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * righteditSelectitem = [[UIBarButtonItem alloc]initWithCustomView:editSelectBtn];
//    self.navigationItem.rightBarButtonItems = @[righteditSelectitem,rightallSelectitem];
//}
//
//#pragma mark -- 全选删除
//- (void)allSelcectDelect:(UIButton *)btn{
//    for (int i=0; i<_dataArray.count; i++) {
//        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
//        [self.tableview selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionBottom];
//        [self.deleteArray addObject:self.dataArray[index.row]];
//    }
//}
//
//
//#pragma mark -- 编辑按键
//- (void)editSelectDelect:(UIButton *)btn{
//    self.tableview.allowsMultipleSelectionDuringEditing = YES;
//    self.tableview.editing = !self.tableview.editing;
//    if (self.tableview.editing) {
//        _allSelectBtn.hidden  = NO;
//        [_editSelectBtn setTitle:@"完成" forState:UIControlStateNormal];
//        [_deleteArray removeAllObjects];
//        _delectBtn.hidden = NO;
//    }else{
//        _allSelectBtn.hidden  = YES;
//        [_editSelectBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        _delectBtn.hidden = YES;
//    }
//}
//
//
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    RSCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:collectID];
//    RSCollectionModel * collectionModel = self.dataArray[indexPath.row];
//    cell.collectionModel = collectionModel;
//    cell.removeBtn.tag = indexPath.row;
//    cell.playPhoneBtn.tag = indexPath.row;
//    [cell.removeBtn addTarget:self action:@selector(removeCollectProduct:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.playPhoneBtn addTarget:self action:@selector(playPhoneToCustomerService:) forControlEvents:UIControlEventTouchUpInside];
//    cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
//    UIView *backGroundView = [[UIView alloc]init];
//    backGroundView.backgroundColor = [UIColor clearColor];
//    cell.selectedBackgroundView = backGroundView;
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 200;
//}
//
//#pragma mark -- 移除该列
//- (void)removeCollectProduct:(UIButton *)btn{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你确定需要对改行进行删除吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        RSCollectionModel * collectionModel = self.dataArray[btn.tag];
//        //对改行进行删除
//         NSString * str = @"HxStock";
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        [dict setObject:str forKey:@"collType"];
//        [dict setObject:collectionModel.collectionID forKey:@"collectionID"];
//        [dict setObject:[NSString stringWithFormat:@"del"] forKey:@"operationType"];
//        [dict setObject:self.userModel.userID forKey:@"userId"];
//        [dict setObject:collectionModel.stoneblno forKey:@"stoneblno"];
//        [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"erpId"];
//        if (collectionModel.stoneType == 1) {
//            collectionModel.stoneturnsno  = @"";
//            [dict setObject:collectionModel.stoneturnsno forKey:@"stoneturnsno"];
//        }else{
//            [dict setObject:collectionModel.stoneturnsno forKey:@"stoneturnsno"];
//        }
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//        RSWeakself
//        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//        [network getDataWithUrlString:URL_HEADER_TEXT_STONECO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//            if (success) {
//                BOOL Result = [json[@"Result"] boolValue];
//                if (Result) {
//                    [weakSelf.dataArray removeObjectAtIndex:btn.tag];
//                    [weakSelf.tableview reloadData];
//                    [SVProgressHUD showSuccessWithStatus:@"你成功删除该行"];
//                }else{
//                }
//            }
//        }];
//    }];
//    [alert addAction:alert1];
//    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alert addAction:alert2];
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                           alert.modalPresentationStyle = UIModalPresentationFullScreen;
//                       }
//    [self presentViewController:alert animated:YES completion:nil];
//}
//
//#pragma mark -- 打电话给客服
//- (void)playPhoneToCustomerService:(UIButton *)btn{
//    [JHSysAlertUtil presentAlertViewWithTitle:@"你确定要打电话给客服吗？" message:nil cancelTitle:@"确定" defaultTitle:@"取消" distinct: YES cancel:^{
//        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
//        RSCollectCell *cell = [self.tableview cellForRowAtIndexPath:indexpath];
//        //改行的电话号码
//        //这边是为了调用系统的打电话功能
//        UIWebView *webview = [[UIWebView alloc]init];
//        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",cell.phoneLabel.text]]]];
//        [self.view addSubview:webview];
//    } confirm:^{
//    }];
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
