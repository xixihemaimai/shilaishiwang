//
//  RSLeftScreenView.m
//  石来石往
//
//  Created by mac on 2017/7/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSLeftScreenView.h"

#import "YBScreenCell.h"
#import "RSScreenheaderView.h"


#import "JXPopoverView.h"

#import "RSHuangSecondCell.h"
#import "RSHuangReusableView.h"


@interface RSLeftScreenView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

{
    
    
    
    
     NSMutableArray * arrays;
    
    
   
    
    
    /**中间值，用来保存四个textfiled的值*/
    NSString * _tempStr1;
    NSString * _tempStr2;
    NSString * _tempStr3;
    NSString * _tempStr4;
    
    
    /**用来保存按键是大于还是小于还是等于*/
    NSString * _btnStr1;
    NSString * _btnStr2;
    NSString *_btnStr3;
    NSString * _btnStr4;
    
    
    
    
    
    
    //大板
    /**中间值，用来保存四个textfiled的值*/
    NSString * _dabantempStr1;
    NSString * _dabantempStr2;
    NSString * _dabantempStr3;
    NSString * _dabantempStr4;
    
    
    /**用来保存按键是大于还是小于还是等于*/
    NSString * _dabanbtnStr1;
    NSString * _dabanbtnStr2;
    NSString * _dabanbtnStr3;
    NSString * _dabanbtnStr4;
    
    
    
}
/**保存数据有多少组模型在这个数组里面*/
@property (nonatomic,strong)NSMutableArray * dataArray;





@end

@implementation RSLeftScreenView


static NSString * headerLeftID = @"headerLeftID";
static NSString * collectionview = @"collectionview";
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //这边添加我需要的界面出来
        arrays = [NSMutableArray arrayWithArray:@[@[@"大于",@"等于",@"小于"],]];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCW/2 - 5,40);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCW, 164) collectionViewLayout:layout];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionview];
        [_collectionview registerClass:[RSHuangSecondCell class] forCellWithReuseIdentifier:collectionview];
        //注册尾部视图
        [_collectionview registerClass:[RSHuangReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
//        _tableview = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.rowHeight = 58;
//        _tableview.scrollEnabled = NO;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self addSubview:_tableview];
//
//        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
//        view.backgroundColor = [UIColor whiteColor];
//
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, self.bounds.size.width, 20)];
//        label.text = @"筛选";
//        label.font = [UIFont systemFontOfSize:18];
//        label.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:label];
//
//
//        UILabel * bottomlabel = [[UILabel alloc]init];
//        bottomlabel.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
//        [view addSubview:bottomlabel];
//
//        bottomlabel.sd_layout
//        .leftSpaceToView(view, 0)
//        .rightSpaceToView(view, 0)
//        .bottomSpaceToView(view, 0)
//        .heightIs(1);
//        _tableview.tableHeaderView = view;
//        UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 35)];
//        bottomview.backgroundColor = [UIColor whiteColor];
//
//        //重置
//        UIButton * resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, (self.bounds.size.width/2) - 10, 30)];
//        [resetBtn setBackgroundColor:[UIColor redColor]];
//        resetBtn.layer.cornerRadius = 10;
//        resetBtn.layer.masksToBounds = YES;
//        [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
//        [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//
//        [resetBtn addTarget:self action:@selector(resetData:) forControlEvents:UIControlEventTouchUpInside];
//        [bottomview addSubview:resetBtn];
//
//
//
//
//        UIButton * shangBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(resetBtn.frame) + 5, 5,(self.bounds.size.width/2) - 10, 30)];
//
//        [shangBtn setTitle:@"确定" forState:UIControlStateNormal];
//        [shangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [shangBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
//        [bottomview addSubview:shangBtn];
//        shangBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        shangBtn.layer.cornerRadius = 10;
//        shangBtn.layer.masksToBounds = YES;
//
//        [shangBtn addTarget:self action:@selector(shangShowView:) forControlEvents:UIControlEventTouchUpInside];
//
//
//
//
//
//
//        _tableview.tableFooterView = bottomview;
        
        
       
        _btnStr1 = @"2";
        _btnStr2 = @"2";
        _btnStr3 = @"2";
        _btnStr4 = @"2";
        
        
        _tempStr1 = @"-1";
        _tempStr2 = @"-1";
        _tempStr3 = @"-1";
        _tempStr4 = @"-1";
        
        
        
        
        
        _dabanbtnStr1 = @"2";
        _dabanbtnStr2 = @"2";
        _dabanbtnStr3 = @"2";
        _dabanbtnStr4 = @"2";
        
        
        _dabantempStr1 = @"-1";
        _dabantempStr2 = @"-1";
        _dabantempStr3 = @"-1";
        _dabantempStr4 = @"-1";
        

        
        
 
    }
    return self;
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RSHuangSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionview forIndexPath:indexPath];
    
    
    [cell.choiceBtn addTarget:self action:@selector(changeStyleRule:) forControlEvents:UIControlEventTouchUpInside];
    //textfield
    //titleLabel
    
    
    [cell.textfield addTarget:self action:@selector(inputTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.textfield.tag = 1000 + indexPath.row;
    cell.choiceBtn.tag = 1000 + indexPath.row;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"长";
        cell.textLabel.text = @"mm";
    }else if (indexPath.row == 1){
         cell.textLabel.text = @"mm";
        cell.titleLabel.text = @"宽";
    }else if (indexPath.row == 2){
        cell.titleLabel.text = @"高";
         cell.textLabel.text = @"mm";
    }else{
        
        if ([self.searchType isEqualToString:@"huangliao"]) {
            
            cell.titleLabel.text = @"体积";
            
            cell.textLabel.text = @"m³";
            
            
        }else{
        
         cell.titleLabel.text = @"面积";
        
        cell.textLabel.text = @"㎡";
        
        
         }
        
       
    }
    
    
    
      //cell.backgroundColor = [UIColor redColor];
    return cell;
}

//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 0 ,5, 0);//分别为上、左、下、右
}





//设置尾部视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCW, 40);
}




//添加尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RSHuangReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [footerView.resetBtn addTarget:self action:@selector(resetData:) forControlEvents:UIControlEventTouchUpInside];
    [footerView.sureBtn addTarget:self action:@selector(shangShowView:) forControlEvents:UIControlEventTouchUpInside];
    return footerView;
}




//#pragma mark -- 点击取消显示该界面
//- (void)cancelShow:(UIButton *)btn{
//    
//    //关闭筛选的界面
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"closeShowView" object:nil];
//    
//    
//}


#pragma mark -- 筛选显示的结果
- (void)shangShowView:(UIButton *)btn{
    if ([self.searchType isEqualToString:@"huangliao"]) {
        
        if ([_tempStr1 isEqualToString:@""]) {
            _tempStr1 = @"-1";
        }
        if ([_tempStr2 isEqualToString:@""]) {
            _tempStr2 = @"-1";
        }
        if ([_tempStr3 isEqualToString:@""]) {
            _tempStr3 = @"-1";
        }
        if ([_tempStr4 isEqualToString:@""]) {
            _tempStr4 = @"-1";
        }
        if ([self.delegate respondsToSelector:@selector(screeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate screeningConditionStr1:_tempStr1 andStr2:_tempStr2 andStr3:_tempStr3 andStr4:_tempStr4 andBtn1:_btnStr1 andBtn2:_btnStr2 andBtn3:_btnStr3 andBtnStr4:_btnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }else{
        if ([_tempStr1 isEqualToString:@""]) {
            _dabantempStr1 = @"-1";
        }
        if ([_tempStr2 isEqualToString:@""]) {
            _dabantempStr2 = @"-1";
        }
        if ([_tempStr3 isEqualToString:@""]) {
            _dabantempStr3 = @"-1";
        }
        if ([_tempStr4 isEqualToString:@""]) {
            _dabantempStr4 = @"-1";
        }
        if ([self.delegate respondsToSelector:@selector(dabanscreeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate dabanscreeningConditionStr1:_dabantempStr1 andStr2:_dabantempStr2 andStr3:_dabantempStr3 andStr4:_dabantempStr4 andBtn1:_dabanbtnStr1 andBtn2:_dabanbtnStr2 andBtn3:_dabanbtnStr3 andBtnStr4:_dabanbtnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }
}


#pragma mark -- 重置
- (void)resetData:(UIButton *)btn{
    
    
   // if ([self.searchType isEqualToString:@"huangliao"]) {
        
        //NSInteger sections = _collectionview.numberOfSections;
        
    
        
        
        
        [self cellsForUICollectionView:_collectionview];
        
        
        
   // }else{
        
        
    // [self cellsForUICollectionView:_collectionview];
        
    //}
    
    
   // [self cellsForTableView:_tableview];
    
    
    
}


- (void)cellsForUICollectionView:(UICollectionView *)collectionview{
    
    NSInteger sections = collectionview.numberOfSections;
    
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [collectionview numberOfItemsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            RSHuangSecondCell * cell = (RSHuangSecondCell *)[collectionview cellForItemAtIndexPath:indexPath];
            cell.textfield.text = @"";
            [cell.choiceBtn setTitle:@"大于" forState:UIControlStateNormal];
        }
    }
    
    
    if ([self.searchType isEqualToString:@"huangliao"]) {
        
        
        
        _btnStr1 = @"2";
        _btnStr2 = @"2";
        _btnStr3 = @"2";
        _btnStr4 = @"2";
        
        
        _tempStr1 = @"-1";
        _tempStr2 = @"-1";
        _tempStr3 = @"-1";
        _tempStr4 = @"-1";
        
        
        if ([self.delegate respondsToSelector:@selector(screeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate screeningConditionStr1:_tempStr1 andStr2:_tempStr2 andStr3:_tempStr3 andStr4:_tempStr4 andBtn1:_btnStr1 andBtn2:_btnStr2 andBtn3:_btnStr3 andBtnStr4:_btnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }else{
        
        
        _dabanbtnStr1 = @"2";
        _dabanbtnStr2 = @"2";
        _dabanbtnStr3 = @"2";
        _dabanbtnStr4 = @"2";
        
        
        _dabantempStr1 = @"-1";
        _dabantempStr2 = @"-1";
        _dabantempStr3 = @"-1";
        _dabantempStr4 = @"-1";
        
        
        if ([self.delegate respondsToSelector:@selector(dabanscreeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate dabanscreeningConditionStr1:_dabantempStr1 andStr2:_dabantempStr2 andStr3:_dabantempStr3 andStr4:_dabantempStr4 andBtn1:_dabantempStr1 andBtn2:_dabantempStr2 andBtn3:_dabantempStr3 andBtnStr4:_dabantempStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }

    }
}




-(void)cellsForTableView:(UITableView *)uitableview
{
    NSInteger sections = uitableview.numberOfSections;
    
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [uitableview numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
           self.cell = [uitableview cellForRowAtIndexPath:indexPath];
            
            self.cell.textfield.text = @"";
            [self.cell.choiceBtn setTitle:@"大于" forState:UIControlStateNormal];
        }
    }
    
    
    if ([self.searchType isEqualToString:@"huangliao"]) {
        
        
        
        _btnStr1 = @"2";
        _btnStr2 = @"2";
        _btnStr3 = @"2";
        _btnStr4 = @"2";
        
        
        _tempStr1 = @"-1";
        _tempStr2 = @"-1";
        _tempStr3 = @"-1";
        _tempStr4 = @"-1";
        
        
        if ([self.delegate respondsToSelector:@selector(screeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate screeningConditionStr1:_tempStr1 andStr2:_tempStr2 andStr3:_tempStr3 andStr4:_tempStr4 andBtn1:_btnStr1 andBtn2:_btnStr2 andBtn3:_btnStr3 andBtnStr4:_btnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }
}





//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return 2;
//
//}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    if (section == 0) {
//        return 3;
//    }else{
////        if ([self.searchType isEqualToString:@"huangliao"]) {
////            return 1;
////        }
//
//        return 1;
//    }
//
//}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    static NSString * IDD = @"idd";
//    self.cell = [tableView dequeueReusableCellWithIdentifier:IDD];
//
//    if (!_cell) {
//        _cell = [[YBScreenCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDD];
//    }
//
//    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//
//
//    //    cell.detailTextLabel.text = @"1";
//
//  //  [cell.choiceBtn setTitle:@"大于" forState:UIControlStateNormal];
//    [_cell.choiceBtn addTarget:self action:@selector(changeStyleRule:) forControlEvents:UIControlEventTouchUpInside];
//    [_cell.textfield addTarget:self action:@selector(inputTextfield:) forControlEvents:UIControlEventEditingChanged];
//    _cell.textfield.delegate = self;
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            _cell.nameLabel.text = @"长";
//           _cell.choiceBtn.tag = 1000;
//            _cell.textfield.tag = 1000;
//
//
//
//        }else if (indexPath.row == 1){
//            _cell.nameLabel.text = @"宽";
//            _cell.choiceBtn.tag = 1001;
//            _cell.textfield.tag = 1001;
//
//
//
//        }else{
//
//
//            if ([self.searchType isEqualToString:@"huangliao"]) {
//                _cell.nameLabel.text = @"高";
//            }else{
//                _cell.nameLabel.text = @"厚";
//            }
//
//
//           _cell.choiceBtn.tag = 1002;
//            _cell.textfield.tag = 1002;
//
//        }
//    }else{
//        _cell.choiceBtn.tag = 1003;
//
//        _cell.textfield.tag = 1003;
//
//    }
//
//    return _cell;
//}






- (void)inputTextfield:(UITextField *)textfield{
    if ([self.searchType isEqualToString:@"huangliao"]) {
        if (textfield.tag == 1000) {
            _tempStr1 = textfield.text;
        }else if (textfield.tag == 1001){
            _tempStr2 = textfield.text;
        }else if (textfield.tag == 1002){
            _tempStr3 = textfield.text;
        }else{
            _tempStr4 = textfield.text;
        }
        
    }else{
        if (textfield.tag == 1000) {
            _dabantempStr1 = textfield.text;
        }else if (textfield.tag == 1001){
            _dabantempStr2 = textfield.text;
        }else if (textfield.tag == 1002){
            _dabantempStr3 = textfield.text;
        }else{
            _dabantempStr4 = textfield.text;
        }
    }
}



- (void)changeStyleRule:(UIButton *)btn{
    
    
    if ([self.searchType isEqualToString:@"huangliao"]) {
        
        switch (btn.tag) {
            case 1000:
                [self action:btn];
                break;
            case 1001:
                [self action:btn];
                break;
            case  1002:
                [self action:btn];
                break;
            case  1003:
                [self action:btn];
                break;
        }
        
    }else{
        
        switch (btn.tag) {
            case 1000:
                [self action:btn];
                break;
            case 1001:
                [self action:btn];
                break;
            case  1002:
                [self action:btn];
                break;
            case  1003:
                [self action:btn];
                break;
        }
        
    }
    
    
    
}





- (void)action:(UIButton *)btn{
    
  
    if ([self.searchType isEqualToString:@"huangliao"]) {
        
        if (btn.tag == 1000) {
            
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _btnStr1 = @"2";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _btnStr1 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _btnStr1 = @"0";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
            
            
            
        }else if (btn.tag == 1001){
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _btnStr2 = @"2";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                
                _btnStr2 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                
                _btnStr2 = @"0";
                
            }];
            
            
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
            
            
            
        }else if (btn.tag == 1002){
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _btnStr3 = @"2";
                
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _btnStr3 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _btnStr3 = @"0";
            }];
            
            
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
        }else{
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                
                _btnStr4 = @"2";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _btnStr4 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _btnStr4 = @"0";
                
            }];
            
            
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
        }
        
    }else{
        if (btn.tag == 1000) {
            
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _dabanbtnStr1 = @"2";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _dabanbtnStr1 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _dabanbtnStr1 = @"0";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
            
            
            
        }else if (btn.tag == 1001){
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _dabanbtnStr2 = @"2";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                
                _dabanbtnStr2 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                
                _dabanbtnStr2 = @"0";
                
            }];
            
            
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
            
            
            
        }else if (btn.tag == 1002){
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _dabanbtnStr3 = @"2";
                
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _dabanbtnStr3 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _dabanbtnStr3 = @"0";
            }];
            
            
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
        }else{
            
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                
                
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                
                _dabanbtnStr4 = @"2";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _dabanbtnStr4 = @"1";
            }];
            
            
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _dabanbtnStr4 = @"0";
                
            }];
            
            
            [popoverView showToView:btn withActions:@[action1,action2,action3]];
            
            
            
        }
        
        
        
    }
    
    
}



/*

#pragma mark -- sim的代理的方法
-(void)actionCancle{
    [sheet dismiss:self];
}

-(void)actionDone:(UIButton *)btn{
    [sheet dismiss:self];
    
    NSUInteger index = [sheet selectedRowInComponent:0];
    NSString * str = [arrays objectAtIndex:index];
 
    
    [btn setTitle:str forState:UIControlStateNormal];
    [self saveBtnTitle:btn];
    
    
}



#pragma mark -- 用来保存选择什么样子的规格
- (void)saveBtnTitle:(UIButton *)btn{
    
    if (btn.tag == 1000) {
        _btnStr1 = btn.currentTitle;
        
    }else if (btn.tag == 1001){
        _btnStr2 = btn.currentTitle;
        
    }else if (btn.tag == 1002){
        _btnStr3 = btn.currentTitle;
    }else{
        _btnStr4 = btn.currentTitle;
        
    }
    
    
}

*/

/*

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrays.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arrays objectAtIndex:row];
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}








//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    RSScreenheaderView * screenheaderview = [[RSScreenheaderView alloc]initWithReuseIdentifier:headerLeftID];
//
//    if (section == 0) {
//        screenheaderview.label.text = @"规格(mm)";
//
//
//    }else{
//
//
//        if ([self.searchType isEqualToString:@"huangliao"]) {
//            screenheaderview.label.text = @"体积(m³)";
//        }else{
//            screenheaderview.label.text = @"面积(m²)";
//        }
//
//
//    }
//    return screenheaderview;
//
//}
//
//
//
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}


@end
