//
//  RSTaoBaoSLDetailView.m
//  石来石往
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoSLDetailView.h"
#import "RSTaoBaoSLProdectCell.h"


@interface RSTaoBaoSLDetailView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)UIView * menview;

@end


@implementation RSTaoBaoSLDetailView
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
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCH, SCW, 249) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        
        [self setCustomHeaderView];
    });
    
}


- (void)setCustomHeaderView{
    
    
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#7F7F7F" alpha:0.5];
    
    
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 52)];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:contentView];
    
    CGRect rect6 = CGRectMake(0, 0, SCW, 52);
    CGRect oldRect2 = rect6;
    oldRect2.size.width = SCW;
    UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect2 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.path = maskPath2.CGPath;
    maskLayer2.frame = oldRect2;
    contentView.layer.mask = maskLayer2;
    
    RSTaobaoStoneDtlModel * taobaoStoneDtlmodel = self.contactsArray[0];
    
    //荒料号
    UILabel * blockNoLabel = [[UILabel alloc]init];
    blockNoLabel.text =[NSString stringWithFormat:@"%@",taobaoStoneDtlmodel.blockNo];
    blockNoLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    blockNoLabel.textAlignment = NSTextAlignmentLeft;
    blockNoLabel.font = [UIFont systemFontOfSize:15];
    blockNoLabel.frame = CGRectMake(20, 10, SCW - 50, 21);
    [contentView addSubview:blockNoLabel];
    
    
    
    
    //匝号
    UILabel * turnLabel = [[UILabel alloc]init];
    //turnLabel.text = @"5匝";
    
    turnLabel.text = [NSString stringWithFormat:@"%ld匝",self.contactsArray.count];
    
    turnLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    turnLabel.textAlignment = NSTextAlignmentLeft;
    turnLabel.font = [UIFont systemFontOfSize:15];
    turnLabel.frame = CGRectMake(20, CGRectGetMaxY(blockNoLabel.frame), SCW - 50, 21);
    [contentView addSubview:turnLabel];
    
    
    //取消按键
    //删除-(3)
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(SCW - 30, 12, 16, 16);
    [contentView addSubview:cancelBtn];
    
    [headerView setupAutoHeightWithBottomView:contentView bottomMargin:0];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.contactsArray.count == 1) {
        return 1;
    }else if (self.contactsArray.count == 2){
        return 2;
    }else if (self.contactsArray.count >= 3){
        return self.contactsArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString * CONTACTSACTIONSECONDCELLID = @"CONTACTSACTIONSECONDCELLID";
   RSTaoBaoSLProdectCell * cell = [tableView dequeueReusableCellWithIdentifier:CONTACTSACTIONSECONDCELLID];
   if (!cell) {
      cell = [[RSTaoBaoSLProdectCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CONTACTSACTIONSECONDCELLID];
    }
    RSTaobaoStoneDtlModel * taobaoStoneDtlmodel = self.contactsArray[indexPath.row];
   cell.taobaoStoneDtlmodel = taobaoStoneDtlmodel;
    
    
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
        if (self.contactsArray.count < 1) {
            self.tableview.frame = CGRectMake(0, SCH - 200, SCW, 200);
        }else if (self.contactsArray.count == 1){
            self.tableview.frame = CGRectMake(0, SCH - 200, SCW, 200);
        }else if (self.contactsArray.count == 2){
            self.tableview.frame = CGRectMake(0, SCH - 300, SCW, 300);
        }else{
            self.tableview.frame = CGRectMake(0, SCH - 408, SCW, 408);
        }
    }];
    
}

/**隐藏*/
- (void)hide{
    if ([self.delegate respondsToSelector:@selector(hideCurrentShowView:)]) {
        [self.delegate hideCurrentShowView:self];
    }
    [self.menview removeFromSuperview];
    [UIView animateWithDuration:0.2 animations:^{
        self.tableview.frame = CGRectMake(0, SCH, SCW, 249);
        [self.tableview removeFromSuperview];
    }];
}


@end
