//
//  RSTaoBaoSCContentCell.m
//  石来石往
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoSCContentCell.h"

@interface RSTaoBaoSCContentCell()<UIScrollViewDelegate>




@property (nonatomic, strong) UIImageView * newimageView;

@property (nonatomic, strong) UIImageView * typeImageView;

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILabel * surplusLabel;

@property (nonatomic, strong) UILabel * symbolLabel;

@property (nonatomic, strong) UILabel * currentPriceLabel;

@property (nonatomic, strong) UILabel * discountPriceLabel;

@property (nonatomic, strong) UILabel * shopLabel;



/// 标题
//@property (nonatomic, strong) UILabel *titleLabel;
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;





@end


@implementation RSTaoBaoSCContentCell

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
    [self.backView addSubview:self.joinBtn];
    //[self.backView addSubview:self.titleLabel];
    
    
    self.mainScrollView.frame = CGRectMake(0, 12, SCW, 96);
    self.backView.frame = CGRectMake(0, 0, SCW, 96);
    self.joinBtn.frame = CGRectMake(0, 0, SCW, 96);
    
    //self.titleLabel.frame = CGRectMake(10, 0, 200, 40);
    self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith], 96);
    
    
    //图片
    UIImageView * newimageView = [[UIImageView alloc]init];
    newimageView.image = [UIImage imageNamed:@"01"];
    newimageView.contentMode = UIViewContentModeScaleAspectFill;
    newimageView.clipsToBounds = YES;
    [self.backView addSubview:newimageView];
    _newimageView = newimageView;
    
    //类型
    UIImageView * typeImageView = [[UIImageView alloc]init];
    typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
    typeImageView.contentMode = UIViewContentModeScaleAspectFill;
    typeImageView.clipsToBounds = YES;
    [self.backView addSubview:typeImageView];
    _typeImageView = typeImageView;
    
    //名字
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"波斯海浪灰";
    //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [self.backView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    //剩余
    UILabel * surplusLabel = [[UILabel alloc]init];
    surplusLabel.text = @"剩余234m³";
    
    CGRect rect1 = [surplusLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    surplusLabel.textAlignment = NSTextAlignmentLeft;
    surplusLabel.font = [UIFont systemFontOfSize:12];
    surplusLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    [self.backView addSubview:surplusLabel];
    _surplusLabel = surplusLabel;
    
    //符号
    UILabel * symbolLabel = [[UILabel alloc]init];
    symbolLabel.text = @"¥";
    //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    symbolLabel.textAlignment = NSTextAlignmentCenter;
    symbolLabel.font = [UIFont systemFontOfSize:10];
    symbolLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    [self.backView addSubview:symbolLabel];
    _symbolLabel = symbolLabel;
    
    
    //当前价格
    UILabel * currentPriceLabel = [[UILabel alloc]init];
    currentPriceLabel.text = @"9.9";
    
    CGRect rect = [currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25)options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    currentPriceLabel.textAlignment = NSTextAlignmentLeft;
    currentPriceLabel.font = [UIFont systemFontOfSize:18];
    currentPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    [self.backView addSubview:currentPriceLabel];
    _currentPriceLabel = currentPriceLabel;
    
    //打折价钱
    UILabel * discountPriceLabel = [[UILabel alloc]init];
    discountPriceLabel.textAlignment = NSTextAlignmentLeft;
    discountPriceLabel.font = [UIFont systemFontOfSize:10];
    discountPriceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥248" attributes:attribtDic];
    discountPriceLabel.attributedText = attribtStr;
    [self.backView addSubview:discountPriceLabel];
    _discountPriceLabel = discountPriceLabel;
    
    
    
    
    //商店
    UILabel * shopLabel = [[UILabel alloc]init];
    shopLabel.text = @"大唐石业";
    //nameLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    shopLabel.textAlignment = NSTextAlignmentLeft;
    shopLabel.font = [UIFont systemFontOfSize:11];
    shopLabel.textColor = [UIColor colorWithHexColorStr:@"#9D9D9D"];
    [self.backView addSubview:shopLabel];
    
    CGRect rect2 = [shopLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    _shopLabel = shopLabel;
    
    //进店按键
    RSTaobaoSCButton * taoBaoSCBtn = [[RSTaobaoSCButton alloc]init];
    [taoBaoSCBtn setTitle:@"进店" forState:UIControlStateNormal];
    [taoBaoSCBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    taoBaoSCBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [taoBaoSCBtn setImage:[UIImage imageNamed:@"icon_chose_arrow_nor"] forState:UIControlStateNormal];
    [self.backView addSubview:taoBaoSCBtn];
    _taoBaoSCBtn = taoBaoSCBtn;
    
    
    //马上抢
    UIButton * rowNowRobBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rowNowRobBtn setTitle:@"马上抢" forState:UIControlStateNormal];
    [rowNowRobBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    rowNowRobBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rowNowRobBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
    [self.backView addSubview:rowNowRobBtn];
    _rowNowRobBtn = rowNowRobBtn;
    
    
    
    newimageView.sd_layout
    .leftSpaceToView(self.backView, 12)
    .topSpaceToView(self.backView, 0)
    .widthIs(96)
    .heightEqualToWidth();
    newimageView.layer.cornerRadius = 5;
   
    
    typeImageView.sd_layout
    .leftSpaceToView(newimageView, 10)
    .topSpaceToView(self.backView, 7)
    .widthIs(22)
    .heightIs(12);
    
    nameLabel.sd_layout
    .leftSpaceToView(typeImageView, 3)
    .topSpaceToView(self.backView, 3)
    .rightSpaceToView(self.backView, 12)
    .heightIs(20);
    
    surplusLabel.sd_layout
    .leftEqualToView(typeImageView)
    .topSpaceToView(nameLabel, 4)
    .heightIs(17)
    .widthIs(rect1.size.width);
    
    symbolLabel.sd_layout
    .leftEqualToView(surplusLabel)
    .topSpaceToView(surplusLabel, 13)
    .heightIs(14)
    .widthIs(6);
    
    
    currentPriceLabel.sd_layout
    .leftSpaceToView(symbolLabel, 2)
    .topSpaceToView(surplusLabel, 5)
    .heightIs(25)
    .widthIs(rect.size.width);
    
    
    discountPriceLabel.sd_layout
    .leftSpaceToView(currentPriceLabel, 4)
    .topSpaceToView(surplusLabel, 13)
    .rightSpaceToView(self.backView, 12)
    .heightIs(14);
    
    
    shopLabel.sd_layout
    .leftEqualToView(symbolLabel)
    .topSpaceToView(symbolLabel, 11)
    .heightIs(15)
    .widthIs(rect2.size.width);
    
    taoBaoSCBtn.sd_layout
    .leftSpaceToView(shopLabel, 4)
    .topEqualToView(shopLabel)
    .bottomEqualToView(shopLabel)
    .widthIs(80);
    
    rowNowRobBtn.sd_layout
    .rightSpaceToView(self.backView, 12)
    .topSpaceToView(self.backView, 72)
    .widthIs(65)
    .heightIs(24);
    
    rowNowRobBtn.layer.cornerRadius = 12;
}


- (void)showBigPictureAction:(UITapGestureRecognizer *)tap{
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:self.taobaoUserlikemodel.imageUrl];
    [HUPhotoBrowser showFromImageView:_newimageView withURLStrings:array atIndex:0];
}


- (void)setTaobaoUserlikemodel:(RSTaoBaoUserLikeModel *)taobaoUserlikemodel{
    _taobaoUserlikemodel = taobaoUserlikemodel;
    
    
    [_newimageView sd_setImageWithURL:[NSURL URLWithString:_taobaoUserlikemodel.imageUrl] placeholderImage:[UIImage imageNamed:@"512"]];
    
    _newimageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPictureAction:)];
    [_newimageView addGestureRecognizer:tap];
    
    
    if ([_taobaoUserlikemodel.stockType isEqualToString:@"daban"]) {
        _typeImageView.image = [UIImage imageNamed:@"淘宝大板"];
    }else{
        _typeImageView.image = [UIImage imageNamed:@"淘宝荒料"];
    }
    
    _nameLabel.text = _taobaoUserlikemodel.stoneName;
    
    if ([_taobaoUserlikemodel.stockType isEqualToString:@"daban"]) {
        _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm²",[_taobaoUserlikemodel.inventory floatValue]];
    }else{
        
        //_surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm³",[_taobaoUserlikemodel.inventory floatValue]];
        if ([_taobaoUserlikemodel.unit isEqualToString:@"立方米"]) {
            _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lfm³",[_taobaoUserlikemodel.inventory floatValue]];
        }else{
            _surplusLabel.text = [NSString stringWithFormat:@"余%0.3lf吨",[_taobaoUserlikemodel.weight floatValue]];
        }
    }
    CGRect rect1 = [_surplusLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17)options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    _surplusLabel.sd_layout
    .leftEqualToView(_typeImageView)
    .topSpaceToView(_nameLabel, 4)
    .heightIs(17)
    .widthIs(rect1.size.width);
    
    
    
    
           _currentPriceLabel.text = [NSString stringWithFormat:@"%@",_taobaoUserlikemodel.price];
           CGRect rect = [_currentPriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25)options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
           
           _currentPriceLabel.sd_layout
           .leftSpaceToView(_symbolLabel, 2)
           .topSpaceToView(_surplusLabel, 5)
           .heightIs(25)
           .widthIs(rect.size.width);
       
    
    
   
    
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_taobaoUserlikemodel.originalPrice] attributes:attribtDic];
    _discountPriceLabel.attributedText = attribtStr;
    
    
    
    
    
    
    _shopLabel.text = _taobaoUserlikemodel.shopName;
    CGRect rect2 = [_shopLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15)options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    
    _shopLabel.sd_layout
    .leftEqualToView(_symbolLabel)
    .bottomEqualToView(_newimageView)
    .heightIs(15)
    .widthIs(rect2.size.width);
    
    
}




#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint movePoint = self.mainScrollView.contentOffset;
    if (movePoint.x < 0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    if (movePoint.x > [self deleteButtonWdith]) {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, movePoint.x, 96);
    } else {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith],96);
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


- (UIButton *)joinBtn{
    if (!_joinBtn) {
        _joinBtn = [[UIButton alloc] init];
        _joinBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    }
    return _joinBtn;
    
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
