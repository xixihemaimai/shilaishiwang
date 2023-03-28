//
//  RSTaobaoSCShopCell.m
//  石来石往
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoSCShopCell.h"

@interface RSTaobaoSCShopCell()<UIScrollViewDelegate>


@property (nonatomic, strong)UIImageView * logoImageview;

@property (nonatomic, strong)UILabel * nameDetailLabel;

@property (nonatomic, strong)UILabel * addressLabel;

@property (nonatomic, strong)UILabel * blocKLabel;

@property (nonatomic, strong)UILabel * slocKLabel;

@property (nonatomic,strong)UILabel * weightLabel;



/// 标题的背景
@property (nonatomic, strong) UIView *backView;
/// 标题
//@property (nonatomic, strong) UILabel *titleLabel;
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation RSTaobaoSCShopCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        [self setupCell];
        
        
    }
    return self;
}

-(void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /// 在cell上先添加滑动视图
    [self.contentView addSubview:self.mainScrollView];
    
    /// 再在滑动视图上添加背景视图（就是cell主要显示的内容）
    [self.mainScrollView addSubview:self.backView];
    [self.mainScrollView addSubview:self.deleteButton];
    //[self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.joinBtn];
    //[self.backView addSubview:self.titleLabel];
    

   
    
    self.mainScrollView.frame = CGRectMake(0, 12, SCW, 80);
    self.backView.frame = CGRectMake(0, 0, SCW, 80);
     self.joinBtn.frame = CGRectMake(0, 0, SCW, 96);
    
    //self.titleLabel.frame = CGRectMake(10, 0, 200, 40);
    self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith], 80);
    
    
    
    UIImageView * logoImageview = [[UIImageView alloc]init];
    [logoImageview setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000"]];
    //nameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
    [self.backView addSubview:logoImageview];
    _logoImageview = logoImageview;
    
    
    
    UILabel * nameDetailLabel = [[UILabel alloc]init];
    // [nameDetailLabel setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000"]];
    nameDetailLabel.text = @"大唐石业";
    nameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameDetailLabel.textAlignment = NSTextAlignmentLeft;
    nameDetailLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [self.backView addSubview:nameDetailLabel];
    _nameDetailLabel = nameDetailLabel;
    
    //地址
    UILabel * addressLabel = [[UILabel alloc]init];
    addressLabel.text = @"南安市水头";
    addressLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.font = [UIFont systemFontOfSize:12];
    [self.backView addSubview:addressLabel];
    _addressLabel = addressLabel;
    
    //荒料
    UILabel * blocKLabel = [[UILabel alloc]init];
    blocKLabel.text = @"荒料：234m³";
    blocKLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
    blocKLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    blocKLabel.textAlignment = NSTextAlignmentCenter;
    blocKLabel.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:blocKLabel];
    CGRect rect = [blocKLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    
    _blocKLabel = blocKLabel;
    
    //大板
    UILabel * slocKLabel = [[UILabel alloc]init];
    slocKLabel.text = @"大板：234m²";
    slocKLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
    slocKLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    slocKLabel.textAlignment = NSTextAlignmentCenter;
    slocKLabel.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:slocKLabel];
    
    CGRect rect1 = [slocKLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    _slocKLabel = slocKLabel;
    
    
    
    
    UILabel * weightLabel = [[UILabel alloc]init];
    weightLabel.text = @"234m²";
    weightLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
    weightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    weightLabel.textAlignment = NSTextAlignmentCenter;
    weightLabel.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:weightLabel];
    
    CGRect rect2 = [weightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    
    _weightLabel = weightLabel;
    
    
    
    
    
    
    
    
    UIButton * joinShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [joinShopBtn setTitle:@"进店" forState:UIControlStateNormal];
    [joinShopBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    joinShopBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.backView addSubview:joinShopBtn];
    _joinShopBtn = joinShopBtn;
    
    
    _logoImageview.sd_layout
    .leftSpaceToView(self.backView, 24)
    .topSpaceToView(self.backView, 15)
    .widthIs(50)
    .heightEqualToWidth();
    
    _logoImageview.layer.cornerRadius = 4;
    _logoImageview.layer.masksToBounds = YES;
    
    
    nameDetailLabel.sd_layout
    .leftSpaceToView(_logoImageview, 9)
    .topSpaceToView(self.backView, 11)
    .widthRatioToView(self.backView, 0.5)
    .heightIs(20);
    
    addressLabel.sd_layout
    .leftEqualToView(nameDetailLabel)
    .rightEqualToView(nameDetailLabel)
    .topSpaceToView(nameDetailLabel, 0)
    .heightIs(17);
    
    blocKLabel.sd_layout
    .leftEqualToView(addressLabel)
    .topSpaceToView(addressLabel, 3)
    .heightIs(16)
    .widthIs(rect.size.width + 5);
    blocKLabel.layer.cornerRadius = 8;
    blocKLabel.layer.masksToBounds = YES;
    
    weightLabel.sd_layout
    .leftSpaceToView(blocKLabel, 9)
    .topEqualToView(blocKLabel)
    .bottomEqualToView(blocKLabel)
    .widthIs(rect2.size.width + 5);
    weightLabel.layer.cornerRadius = 8;
    weightLabel.layer.masksToBounds = YES;
    
    
    slocKLabel.sd_layout
    .leftSpaceToView(weightLabel, 9)
    .topEqualToView(weightLabel)
    .bottomEqualToView(weightLabel)
    .widthIs(rect1.size.width + 5);
    slocKLabel.layer.cornerRadius = 8;
    slocKLabel.layer.masksToBounds = YES;
    
    
    
    
    
    joinShopBtn.sd_layout
    .centerYEqualToView(self.backView)
    .rightSpaceToView(self.backView, 12)
    .heightIs(20)
    .widthIs(40);
    
    
}


- (void)setTaobaoShopInformationmodel:(RSTaoBaoShopInformationModel *)taobaoShopInformationmodel{
    _taobaoShopInformationmodel = taobaoShopInformationmodel;
    
    
    //_nameLabel.text = [NSString stringWithFormat:@"%@",[_taobaoShopInformationmodel.shopName substringToIndex:1]];
    
    [_logoImageview sd_setImageWithURL:[NSURL URLWithString:_taobaoShopInformationmodel.shopLogo] placeholderImage:[UIImage imageNamed:@"512"]];
    
    
    
    _nameDetailLabel.text = [NSString stringWithFormat:@"%@",_taobaoShopInformationmodel.shopName];
    
    
    _addressLabel.text = [NSString stringWithFormat:@"%@",_taobaoShopInformationmodel.address];
    
    
    
    _blocKLabel.text = [NSString stringWithFormat:@"荒料：%0.3lfm³",[_taobaoShopInformationmodel.volume floatValue]];
    
    
    CGRect rect = [_blocKLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    _blocKLabel.sd_layout
    .leftEqualToView(_addressLabel)
    .topSpaceToView(_addressLabel, 3)
    .heightIs(16)
    .widthIs(rect.size.width + 5);
    
    
    
    
    _weightLabel.text =  [NSString stringWithFormat:@"%0.3lf吨",[_taobaoShopInformationmodel.weight floatValue]];
          
          
       CGRect rect2 = [_weightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];

          
          
          
          
          
          _weightLabel.sd_layout
          .leftSpaceToView(_blocKLabel, 9)
          .topEqualToView(_blocKLabel)
          .bottomEqualToView(_blocKLabel)
          .widthIs(rect2.size.width + 5);
    
    
    
    
    _slocKLabel.text =  [NSString stringWithFormat:@"大板：%0.3lfm²",[_taobaoShopInformationmodel.area floatValue]];
    
    
    CGRect rect1 = [_slocKLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];

    
    
    
    
    
    _slocKLabel.sd_layout
    .leftSpaceToView(_weightLabel, 9)
    .topEqualToView(_weightLabel)
    .bottomEqualToView(_weightLabel)
    .widthIs(rect1.size.width + 5);
    
    
   
    
    
    
    
    
}







#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint movePoint = self.mainScrollView.contentOffset;
    if (movePoint.x < 0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    if (movePoint.x > [self deleteButtonWdith]) {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, movePoint.x, 80);
    } else {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith],80);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint endPoint = self.mainScrollView.contentOffset;
    if (endPoint.x < self.deleteButtonWdith) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (self.scrollAction) {
        self.scrollAction();
    }
}

#pragma mark - 点击事件
-(void)deleteAction:(UIButton *)button {
    if (self.deleteAction) {
        self.deleteAction(self.indexPath);
    }
}

#pragma mark - Get方法
-(CGFloat)deleteButtonWdith {
    return 60.0 * (SCW / 375.0);
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    }
    return _backView;
}

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        /// 设置滑动视图的偏移量是：屏幕宽+删除按钮宽
        //_mainScrollView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        _mainScrollView.contentSize = CGSizeMake(self.deleteButtonWdith + SCW, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.bounces = NO;
        _mainScrollView.userInteractionEnabled = YES;
    }
    
    return _mainScrollView;
}

-(UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteButton.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteButton;
}

/// 判断是否被打开了
-(BOOL)isOpen {
    return self.mainScrollView.contentOffset.x >= self.deleteButtonWdith;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
