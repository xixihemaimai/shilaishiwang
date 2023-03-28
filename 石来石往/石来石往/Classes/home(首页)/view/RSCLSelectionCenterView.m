//
//  RSCLSelectionCenterView.m
//  石来石往
//
//  Created by mac on 2022/8/17.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSCLSelectionCenterView.h"
#import "RSCLSelectCenterCell.h"
#import "RSCLSelectionModel.h"

static NSString * ClSelectionCellId = @"ClSelectionCellId";
@interface RSCLSelectionCenterView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong)UITableView * selectionCenterTableview;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * selectArray;

@end

@implementation RSCLSelectionCenterView

- (NSMutableArray *)selectArray{
    if (!_selectArray){
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}



- (UITableView *)selectionCenterTableview{
    if (_selectionCenterTableview == nil){
        _selectionCenterTableview = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _selectionCenterTableview.delegate = self;
        _selectionCenterTableview.dataSource = self;
        _selectionCenterTableview.estimatedSectionFooterHeight = 0;
        _selectionCenterTableview.estimatedSectionHeaderHeight = 0;
        _selectionCenterTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _selectionCenterTableview.emptyDataSetSource = self;
        _selectionCenterTableview.emptyDataSetDelegate = self;
    }
    return _selectionCenterTableview;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]){
     
        
        
        self.pageNum = 1;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.selectionCenterTableview];
        self.selectionCenterTableview.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
        
        [self.selectionCenterTableview registerClass:[RSCLSelectCenterCell class] forCellReuseIdentifier:ClSelectionCellId];
        
        
        [self initDataArrayHead:true];
        
        self.selectionCenterTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self initDataArrayHead:true];
        }];
        
        
        self.selectionCenterTableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [self initDataArrayHead:false];
        }];
        
    }
    return self;
}



- (void)initDataArrayHead:(BOOL)isHead{
    if (isHead) {
       self.pageNum = 1;
    }else{
       self.pageNum++;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [dict setObject:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SC_COLLECITON_I_ALL withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            NSLog(@"==========================%@",json);
            BOOL Result = [json[@"success"] boolValue];
            if (Result) {
                if (isHead){
                    //删除数组
                    [weakSelf.selectArray removeAllObjects];
                    
                    weakSelf.selectArray = [RSCLSelectionModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    
                    [weakSelf.selectionCenterTableview.mj_header endRefreshing];
                    
                }else{
                    
                    NSMutableArray * tempArray = [NSMutableArray array];
                    
                    tempArray = [RSCLSelectionModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];

                    [weakSelf.selectArray addObjectsFromArray:tempArray];
                    
                    [weakSelf.selectionCenterTableview.mj_footer endRefreshing];
                    
                }
                [weakSelf.selectionCenterTableview reloadData];
            }
        }else{
            [weakSelf.selectionCenterTableview.mj_header endRefreshing];
            [weakSelf.selectionCenterTableview.mj_footer endRefreshing];
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSCLSelectCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:ClSelectionCellId];
    RSCLSelectionModel * model = self.selectArray[indexPath.row];
    cell.deleteBtn.tag = indexPath.row;
    
    [cell.deleteBtn addTarget:self action:@selector(deleteCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = model;
    return cell;
}


//删除
- (void)deleteCollectionAction:(UIButton *)deleteBtn{
    RSCLSelectionModel * model = self.selectArray[deleteBtn.tag];
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除该收藏" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
    } confirm:^{
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSString stringWithFormat:@"%ld",model.collectionId] forKey:@"collectionId"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary * parameters = @{@"key":[NSString get_uuid],@"Data":dataStr,@"VerifyKey":[UserManger Verifykey]  == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            RSWeakself
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_COLLECTION_CANCEL withParameters:parameters withBlock:^(id json, BOOL success) {
                if ([json[@"success"] boolValue]){
//                    [weakSelf.selectArray removeObjectAtIndex:deleteBtn.tag];
                    [weakSelf initDataArrayHead:true];
                }
            }];
   }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
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
