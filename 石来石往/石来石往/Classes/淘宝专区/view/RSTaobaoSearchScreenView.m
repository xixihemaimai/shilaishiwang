//
//  RSTaobaoSearchScreenView.m
//  石来石往
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoSearchScreenView.h"
#import "YBScreenCell.h"
#import "RSScreenheaderView.h"


#import "JXPopoverView.h"

#import "RSHuangSecondCell.h"
#import "RSHuangReusableView.h"

@interface RSTaobaoSearchScreenView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
  
    NSMutableArray * arrays;
    
    //荒料
    /**用来保存按键是大于还是小于还是等于*/
    NSString * _btnStr1;
    NSString * _btnStr2;
    NSString *_btnStr3;
    NSString * _btnStr4;
    
    
    /**中间值，用来保存四个textfiled的值*/
    NSString * _tempStr1;
    NSString * _tempStr2;
    NSString * _tempStr3;
    NSString * _tempStr4;
    
    
   

    
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

@implementation RSTaobaoSearchScreenView

static NSString * headerLeftID = @"headerLeftID";
static NSString * collectionview = @"collectionview";
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //这边添加我需要的界面出来
        arrays = [NSMutableArray arrayWithArray:@[@[@"不过滤",@"大于",@"等于",@"小于"],]];
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
        _btnStr1 = @"0";
        _btnStr2 = @"0";
        _btnStr3 = @"0";
        _btnStr4 = @"0";
        
        _tempStr1 = @"0";
        _tempStr2 = @"0";
        _tempStr3 = @"0";
        _tempStr4 = @"0";
        
        _dabanbtnStr1 = @"0";
        _dabanbtnStr2 = @"0";
        _dabanbtnStr3 = @"0";
        _dabanbtnStr4 = @"0";
        
        _dabantempStr1 = @"0";
        _dabantempStr2 = @"0";
        _dabantempStr3 = @"0";
        _dabantempStr4 = @"0";
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
    [cell.textfield addTarget:self action:@selector(inputTextfield:) forControlEvents:UIControlEventEditingChanged];
    cell.textfield.tag = 1000 + indexPath.row;
    cell.choiceBtn.tag = 1000 + indexPath.row;
    cell.choiceBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    [cell.choiceBtn setTitle:@"不过滤" forState:UIControlStateNormal];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"长";
        cell.textLabel.text = @"cm";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"cm";
        cell.titleLabel.text = @"宽";
    }else if (indexPath.row == 2){
        cell.titleLabel.text = @"高";
        cell.textLabel.text = @"cm";
    }else{
        if ([self.searchType isEqualToString:@"huangliao"]) {
            cell.titleLabel.text = @"体积";
            cell.textLabel.text = @"m³";
        }else{
            cell.titleLabel.text = @"面积";
            cell.textLabel.text = @"㎡";
        }
    }
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

#pragma mark -- 筛选显示的结果
- (void)shangShowView:(UIButton *)btn{
    if ([self.searchType isEqualToString:@"huangliao"]) {
        
        if ([_tempStr1 isEqualToString:@""]) {
            _tempStr1 = @"0";
        }
        if ([_tempStr2 isEqualToString:@""]) {
            _tempStr2 = @"0";
        }
        if ([_tempStr3 isEqualToString:@""]) {
            _tempStr3 = @"0";
        }
        if ([_tempStr4 isEqualToString:@""]) {
            _tempStr4 = @"0";
        }
        if ([self.delegate respondsToSelector:@selector(screeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate screeningConditionStr1:_tempStr1 andStr2:_tempStr2 andStr3:_tempStr3 andStr4:_tempStr4 andBtn1:_btnStr1 andBtn2:_btnStr2 andBtn3:_btnStr3 andBtnStr4:_btnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }else{
        if ([_tempStr1 isEqualToString:@""]) {
            _dabantempStr1 = @"0";
        }
        if ([_tempStr2 isEqualToString:@""]) {
            _dabantempStr2 = @"0";
        }
        if ([_tempStr3 isEqualToString:@""]) {
            _dabantempStr3 = @"0";
        }
        if ([_tempStr4 isEqualToString:@""]) {
            _dabantempStr4 = @"0";
        }
        if ([self.delegate respondsToSelector:@selector(dabanscreeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate dabanscreeningConditionStr1:_dabantempStr1 andStr2:_dabantempStr2 andStr3:_dabantempStr3 andStr4:_dabantempStr4 andBtn1:_dabanbtnStr1 andBtn2:_dabanbtnStr2 andBtn3:_dabanbtnStr3 andBtnStr4:_dabanbtnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }
    [self endEditing:YES];
}


#pragma mark -- 重置
- (void)resetData:(UIButton *)btn{
    [self cellsForUICollectionView:_collectionview];
    [self endEditing:YES];
}

- (void)cellsForUICollectionView:(UICollectionView *)collectionview{
    NSInteger sections = collectionview.numberOfSections;
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [collectionview numberOfItemsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            RSHuangSecondCell * cell = (RSHuangSecondCell *)[collectionview cellForItemAtIndexPath:indexPath];
            cell.textfield.text = @"";
            [cell.choiceBtn setTitle:@"不过滤" forState:UIControlStateNormal];
        }
    }
    if ([self.searchType isEqualToString:@"huangliao"]) {
        _btnStr1 = @"0";
        _btnStr2 = @"0";
        _btnStr3 = @"0";
        _btnStr4 = @"0";
        _tempStr1 = @"0";
        _tempStr2 = @"0";
        _tempStr3 = @"0";
        _tempStr4 = @"0";
        if ([self.delegate respondsToSelector:@selector(screeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate screeningConditionStr1:_tempStr1 andStr2:_tempStr2 andStr3:_tempStr3 andStr4:_tempStr4 andBtn1:_btnStr1 andBtn2:_btnStr2 andBtn3:_btnStr3 andBtnStr4:_btnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }else{
        
        _dabanbtnStr1 = @"0";
        _dabanbtnStr2 = @"0";
        _dabanbtnStr3 = @"0";
        _dabanbtnStr4 = @"0";
        
        _dabantempStr1 = @"0";
        _dabantempStr2 = @"0";
        _dabantempStr3 = @"0";
        _dabantempStr4 = @"0";
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
            [self.cell.choiceBtn setTitle:@"不过滤" forState:UIControlStateNormal];
        }
    }
    if ([self.searchType isEqualToString:@"huangliao"]) {
        _btnStr1 = @"0";
        _btnStr2 = @"0";
        _btnStr3 = @"0";
        _btnStr4 = @"0";
        _tempStr1 = @"0";
        _tempStr2 = @"0";
        _tempStr3 = @"0";
        _tempStr4 = @"0";
        if ([self.delegate respondsToSelector:@selector(screeningConditionStr1:andStr2:andStr3:andStr4:andBtn1:andBtn2:andBtn3:andBtnStr4:andYBScreenCell:andSearchType:)]) {
            [self.delegate screeningConditionStr1:_tempStr1 andStr2:_tempStr2 andStr3:_tempStr3 andStr4:_tempStr4 andBtn1:_btnStr1 andBtn2:_btnStr2 andBtn3:_btnStr3 andBtnStr4:_btnStr4 andYBScreenCell:self.cell andSearchType:self.searchType];
        }
    }
}


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
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _btnStr1 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _btnStr1 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _btnStr1 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _btnStr1 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }else if (btn.tag == 1001){
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _btnStr2 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _btnStr2 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _btnStr2 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _btnStr2 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }else if (btn.tag == 1002){
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _btnStr3 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _btnStr3 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _btnStr3 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _btnStr3 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }else{
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _btnStr4 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _btnStr4 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _btnStr4 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _btnStr4 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }
    }else{
        if (btn.tag == 1000) {
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _dabanbtnStr1 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _dabanbtnStr1 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _dabanbtnStr1 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _dabanbtnStr1 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }else if (btn.tag == 1001){
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _dabanbtnStr2 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _dabanbtnStr2 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _dabanbtnStr2 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _dabanbtnStr2 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }else if (btn.tag == 1002){
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _dabanbtnStr3 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _dabanbtnStr3 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _dabanbtnStr3 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _dabanbtnStr3 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }else{
            JXPopoverView *popoverView = [JXPopoverView popoverView];
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:@"不过滤" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"不过滤" forState:UIControlStateNormal];
                _dabanbtnStr4 = @"0";
            }];
            
            JXPopoverAction *action2 = [JXPopoverAction actionWithTitle:@"大于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"大于" forState:UIControlStateNormal];
                _dabanbtnStr4 = @"1";
            }];
            JXPopoverAction *action3 = [JXPopoverAction actionWithTitle:@"等于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"等于" forState:UIControlStateNormal];
                _dabanbtnStr4 = @"2";
            }];
            JXPopoverAction *action4 = [JXPopoverAction actionWithTitle:@"小于" handler:^(JXPopoverAction *action) {
                [btn setTitle:@"小于" forState:UIControlStateNormal];
                _dabanbtnStr4 = @"3";
            }];
            [popoverView showToView:btn withActions:@[action1,action2,action3,action4]];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
