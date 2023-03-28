//
//  RSDetailOsakaViewController.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDetailOsakaViewController.h"
//出货的界面的每组的组头视图
#import "RSProductHeaderSectionView.h"
#import "RSDetailChoiceCell.h"

#import "RSTurnsCountModel.h"

#import "RSFilmView.h"
//,UIGestureRecognizerDelegate
@interface RSDetailOsakaViewController ()<UITableViewDelegate,UITableViewDataSource,RSFilmViewDelegate,RSDetailChoiceCellDelegate>
{
    UIView *_navigationview;
    
    
    
    
}


@property (nonatomic,strong)UITableView *tableview;



@end

@implementation RSDetailOsakaViewController


static NSString * detailHeaderID = @"detailHeaderID";
- (void)viewDidLoad {
    [super viewDidLoad];
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    
   // pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController.navigationItem setHidesBackButton:YES];
    
    if (self.styleModel == 2) {
        self.title = @"按片出库";
    }else{
        self.title = @"按匝出库";
    }
    
    
    
    //进行初始化
    _btnStatueArr = [NSMutableArray array];
    _turnsStatueArr = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tmpArray = [NSMutableArray array];
    //按片
    if (self.styleModel == 2) {
        self.osakaModel.styleModel = self.styleModel;
        for (int i = 0; i < self.osakaModel.turns.count; i++) {
            RSTurnsCountModel * turnsModel = self.osakaModel.turns[i];
            
            for (int j = 0; j < turnsModel.pieces.count;j++) {
                RSPiecesModel *piecesModel = turnsModel.pieces[j];
                if (piecesModel.status) {
                    [self.tmpArray addObject:piecesModel.pieceID];
                }
            }
        }
    }else{
        //按匝
        self.osakaModel.styleModel = self.styleModel;
        for (int i = 0; i < self.osakaModel.turns.count; i++) {
            RSTurnsCountModel * turnsModel = self.osakaModel.turns[i];
            if (turnsModel.turnsStatus) {
                [self.tmpArray addObject:turnsModel.turnsID];
                self.tmpZhaPianCount += turnsModel.pieces.count;
            }
        }
    }
    //自定义导航栏
    [self addCustomNavigationBarView];
    //自定义内容视图
    [self addContentview];
    //自定义底部视图
    [self addCustomBottomview];
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//
//
//    return YES;
//}

// 返回yes表示支持多个手势
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

- (void)addCustomNavigationBarView{
    UIButton  * backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [backItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backItem.frame = CGRectMake(0, 0, 35, 35);
    [backItem addTarget:self action:@selector(backOsakaViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)addCustomBottomview{
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - Height_NavBar - Height_bottomSafeArea - 45, SCW, 45)];
    bottomview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomview];
    bottomview.hidden = NO;
    [bottomview bringSubviewToFront:self.view];
    
//    bottomview.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .bottomSpaceToView(self.view,0)
//    .heightIs(50);
    
    //提交按键
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.frame = CGRectMake(12, 10, SCW - 20, 35);
    [submitBtn setTintColor:[UIColor whiteColor]];
    [submitBtn setBackgroundColor:[UIColor orangeColor]];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomview addSubview:submitBtn];
    
//    submitBtn.sd_layout
////    .leftSpaceToView(bottomview,12)
////    .rightSpaceToView(bottomview,12)
////    .centerYEqualToView(bottomview)
////    .centerXEqualToView(bottomview)
////    .topSpaceToView(bottomview,10)
////    .bottomSpaceToView(bottomview,10);
}

- (void)addContentview{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar - Height_bottomSafeArea - 45) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    self.tableview = tableview;
    [self.view addSubview:tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.osakaModel.turns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这边要利用styleModel的值来进行对选择的方式进行选择
    RSDetailChoiceCell *cell = [[RSDetailChoiceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (self.osakaModel.styleModel == 2) {
        cell.filmview.tempselectCount = self.osakaModel.count;
    }else{
        cell.tempTurnsCount = self.osakaModel.count;
//        CLog(@"-----------------------------------------%ld",cell.tempTurnsCount);
//        CLog(@"-----------------------------------------%ld",self.osakaModel.count);
    }
    RSTurnsCountModel *turnsModel = self.osakaModel.turns[indexPath.row];
    cell.turnsModel  = turnsModel;
    
    //按片
    if (_btnStatueArr.count) {
        for (int i=0; i<turnsModel.pieces.count; i++) {
            for (int j=0; j<_btnStatueArr.count; j++) {
                RSPiecesModel *selModel = _btnStatueArr[j];
                RSPiecesModel *allModel = turnsModel.pieces[i];
                if (selModel == allModel) {
                    allModel = selModel;
                }
            }
        }
    }
    
    //按匝
    if (_turnsStatueArr.count) {
        for (int i=0; i<self.osakaModel.turns.count; i++) {
            for (int j=0; j<_turnsStatueArr.count; j++) {
                RSTurnsCountModel *selModel = _turnsStatueArr[j];
                RSTurnsCountModel *allModel = self.osakaModel.turns[i];
                if (selModel == allModel) {
                    allModel = selModel;
                }
            }
        }
    }
    cell.deleagete = self;
    cell.filmview.dataAry=turnsModel.pieces;
    cell.filmview.delegate = self;
    //利用这个来进行对按片还是按匝的选择，所要购买的片数
    if (self.osakaModel.styleModel == 2) {
        cell.turnsBtn.enabled = NO;
        [cell.turnsBtn setBackgroundColor:[UIColor whiteColor]];
    }else{
        cell.filmview.userInteractionEnabled = NO;
//        for (UIButton * btn  in cell.filmview.dataAry) {
//            btn.backgroundColor = [UIColor whiteColor];
//        }
        for (UIView * view in cell.filmview.subviews) {
            view.backgroundColor = [UIColor whiteColor];
        }
    }
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSProductHeaderSectionView * productHeaderview = [[RSProductHeaderSectionView alloc]initWithReuseIdentifier:detailHeaderID];
    //productHeaderview.turnsModel = self.turnsModel;
    productHeaderview.osakaModel = self.osakaModel;
    return productHeaderview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSTurnsCountModel *turnsModel = self.osakaModel.turns[indexPath.row];
    if (turnsModel.pieces.count > 0) {
        /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
        return [tableView cellHeightForIndexPath:indexPath model:turnsModel keyPath:@"turnsModel" cellClass:[RSDetailChoiceCell class] contentViewWidth:self.view.frame.size.width];
    }
    return 0;
}

#pragma mark -- 提交
- (void)submitAction:(UIButton *)btn{
    if (self.osakaModel.count > 0) {
        if ([self.delegate respondsToSelector:@selector(choiceDataWithSendOsakaModel:)]) {
            [self.delegate choiceDataWithSendOsakaModel:self.osakaModel];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        if (self.leixi == topicOsaka) {
                [SVProgressHUD showErrorWithStatus:@"你还没有选择"];
        } else {
            if ([self.delegate respondsToSelector:@selector(removeDataWithSendOsakaModel:)]) {
                [self.delegate removeDataWithSendOsakaModel:self.osakaModel];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }        
    }
}

#pragma mark-- 是RSFilmView的代理方法这边是按片的选择
- (void)choiceSliceCount:(NSInteger)count andPSPiecesModel:(RSPiecesModel *)piecesModel andBtn:(UIButton *)btn{
    //这边获取的是选中的中片里面BTN的状态，也是对这个对象里面的status的设定
    [_btnStatueArr addObject:piecesModel];
    if (_btnStatueArr.count) {
        for (int i=0; i<_btnStatueArr.count; i++) {
            RSPiecesModel *model = _btnStatueArr[i];
            if (piecesModel == model) {
                 if (piecesModel.status == 0) {
                    //用来保存你取消之后的model数据
                    [_btnStatueArr removeObject:model];
                }
            }
        }
    }
    //对获取多少次的值，进行设置。
    self.osakaModel.count = count;
}

- (void)backOsakaViewController{
    //利用这个来进行对按片还是按匝的选择，所要购买的片数
    if (self.osakaModel.styleModel == 2) {
        for (int i = 0; i < self.osakaModel.turns.count; i++) {
            RSTurnsCountModel * turnsModel = self.osakaModel.turns[i];
            for (int j = 0; j < turnsModel.pieces.count;j++) {
                RSPiecesModel *piecesModel = turnsModel.pieces[j];
                    piecesModel.status = 0;
            }
        }
        for (int k=0; k<self.tmpArray.count; k++) {
            for (int i = 0; i < self.osakaModel.turns.count; i++) {
                RSTurnsCountModel * turnsModel = self.osakaModel.turns[i];
                for (int j = 0; j < turnsModel.pieces.count;j++) {
                    RSPiecesModel *piecesModel = turnsModel.pieces[j];
                    if (piecesModel.pieceID == self.tmpArray[k]) {
                        piecesModel.status = 1;
                        continue;
                    }
                }
            }
        }
        self.osakaModel.count = self.tmpArray.count;
        [self.delegate choiceDataWithSendOsakaModel:self.osakaModel];
    }else{
        //这边是按匝的情况
        for (int i = 0; i < self.osakaModel.turns.count; i++) {
            RSTurnsCountModel * turnsModel = self.osakaModel.turns[i];
            turnsModel.turnsStatus = 0;
        }
        for (int k=0; k<self.tmpArray.count; k++) {
            for (int i = 0; i < self.osakaModel.turns.count; i++) {
                RSTurnsCountModel * turnsModel = self.osakaModel.turns[i];
                if (turnsModel.turnsID == self.tmpArray[k]) {
                    turnsModel.turnsStatus = 1;
                    continue;
                }
            }
        }
        self.osakaModel.count = self.tmpZhaPianCount;
        [self.delegate choiceDataWithSendOsakaModel:self.osakaModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 是RSDetailChoiceCell的代理，就是选择匝数
- (void)selectTurnsNumberCount:(NSInteger)count andTurnsCountModel:(RSTurnsCountModel *)turnsCountModel andBtn:(UIButton *)btn{
    [_turnsStatueArr addObject:turnsCountModel];
//    CLog(@"--------------------------------------------%ld",turnsCountModel.turnsStatus);
//    CLog(@"=======================================%@",_turnsStatueArr);
    if (_turnsStatueArr.count) {
        for (int i=0; i<_turnsStatueArr.count; i++) {
            RSTurnsCountModel * model = _turnsStatueArr[i];
            if (turnsCountModel == model) {
                 if (turnsCountModel.turnsStatus == 0) {
//                     self.tmpZhaPianCount -= turnsCountModel.pieces.count;
                    [_turnsStatueArr removeObject:model];
                }
            }else{
                if (model.turnsStatus == 0) {
//                    self.tmpZhaPianCount -= turnsCountModel.pieces.count;
                    [_turnsStatueArr removeObject:model];
                }
            }
        }
    }
//    CLog(@"=======================================%ld",count);
    self.osakaModel.count = count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
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
