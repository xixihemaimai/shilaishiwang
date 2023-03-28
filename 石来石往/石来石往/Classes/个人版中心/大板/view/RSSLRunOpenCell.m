//
//  RSSLRunOpenCell.m
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLRunOpenCell.h"


@interface RSSLRunOpenCell()

@property (nonatomic,strong)UIView * accountView;

@property (nonatomic,strong) UILabel * accountProductNameLabel;

@property (nonatomic,strong)UILabel * accountMaterielLabel;

@property (nonatomic,strong)UILabel * accountNumberLabel;

@property (nonatomic,strong) UIImageView * yellewView;


@property (nonatomic,strong)UIView * contAccountView;

@end


@implementation RSSLRunOpenCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        [self setUI];
    }
    return self;
}



- (void)setUI{
    
    UIView * accountView = [[UIView alloc]init];
    accountView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.contentView addSubview:accountView];
    _accountView = accountView;
    
    UIImageView * yellewView = [[UIImageView alloc]init];
    //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
    yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
    yellewView.contentMode = UIViewContentModeScaleAspectFill;
    yellewView.clipsToBounds = YES;
    [accountView addSubview:yellewView];
    
    _yellewView = yellewView;
    
    
    
    
    UIImageView * blueView = [[UIImageView alloc]init];
    blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
    blueView.contentMode = UIViewContentModeScaleAspectFill;
    blueView.clipsToBounds = YES;
    [accountView addSubview:blueView];
    
    
    
    UILabel * accountProductNameLabel = [[UILabel alloc]init];
    accountProductNameLabel.text = @"白玉兰";
    accountProductNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    accountProductNameLabel.font = [UIFont systemFontOfSize:16];
    accountProductNameLabel.textAlignment = NSTextAlignmentLeft;
    [accountView addSubview:accountProductNameLabel];
    _accountProductNameLabel = accountProductNameLabel;
    
    //物料号
    UILabel * accountMaterielLabel = [[UILabel alloc]init];
    accountMaterielLabel.text = @"ESB00295/DH-539";
    accountMaterielLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    accountMaterielLabel.font = [UIFont systemFontOfSize:15];
    accountMaterielLabel.textAlignment = NSTextAlignmentRight;
    [accountView addSubview:accountMaterielLabel];
    _accountMaterielLabel = accountMaterielLabel;
    
    //移动位
    //    UILabel * accountMoveLabel = [[UILabel alloc]init];
    //    accountMoveLabel.text = @"移动位";
    //    accountMoveLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    //    accountMoveLabel.font = [UIFont systemFontOfSize:12];
    //    accountMoveLabel.textAlignment = NSTextAlignmentRight;
    //    [accountView addSubview:accountMoveLabel];
    
    //时间
    //    UILabel * accountTimeLabel = [[UILabel alloc]init];
    //    accountTimeLabel.text = @"2019-01-12";
    //    accountTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    //    accountTimeLabel.font = [UIFont systemFontOfSize:12];
    //    accountTimeLabel.textAlignment = NSTextAlignmentRight;
    //    [accountView addSubview:accountTimeLabel];
    
    //分隔线
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [accountView addSubview:midView];
    
    
    
    UIButton * bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    //[bottomBtn addTarget:self action:@selector(openMemberView:) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:bottomBtn];
    _bottomBtn = bottomBtn;
    
    
    
    UILabel * accountNumberLabel = [[UILabel alloc]init];
    // accountNumberLabel.text = @"匝号：5-5 片号1";
    accountNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    accountNumberLabel.font = [UIFont systemFontOfSize:14];
    accountNumberLabel.textAlignment = NSTextAlignmentLeft;
    [bottomBtn addSubview:accountNumberLabel];
    _accountNumberLabel = accountNumberLabel;
    
    //方向
    UIImageView * accountOpenImageView = [[UIImageView alloc]init];
    accountOpenImageView.image = [UIImage imageNamed:@"system-pull-down"];
    accountOpenImageView.clipsToBounds = YES;
    accountOpenImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  [accountOpenBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    // [accountOpenBtn addTarget:self action:@selector(openMemberView:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn addSubview:accountOpenImageView];
    _accountOpenImageView = accountOpenImageView;
    
    UIView * contAccountView = [[UIView alloc]init];
    contAccountView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [accountView addSubview:contAccountView];
    _contAccountView = contAccountView;
    _contAccountView.hidden = YES;
    
    accountView.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .rightSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 15)
    .bottomSpaceToView(self.contentView, 0);
    
    accountView.layer.cornerRadius = 8;
    
    yellewView.sd_layout
    .leftSpaceToView(accountView, 0)
    .topSpaceToView(accountView, 18)
    .heightIs(17)
    .widthIs(4);
    
    
    blueView.sd_layout
    .rightSpaceToView(accountView, 0)
    .topSpaceToView(accountView, 18)
    .heightIs(17)
    .widthIs(4);
    
    //    accountMoveLabel.sd_layout
    //    .rightSpaceToView(blueView, 10)
    //    .topSpaceToView(accountView, 16)
    //    .heightIs(17)
    //    .widthIs(37);
    
    accountProductNameLabel.sd_layout
    .leftSpaceToView(accountView, 13)
    .topSpaceToView(accountView, 14)
    .heightIs(23)
    .rightSpaceToView(accountView, 15);
    
    
    //    accountTimeLabel.sd_layout
    //    .rightEqualToView(accountMoveLabel)
    //    .topSpaceToView(accountMoveLabel, 0)
    //    .heightIs(17)
    //    .widthIs(68);
    
    accountMaterielLabel.sd_layout
    .widthRatioToView(accountView, 0.6)
    .rightSpaceToView(blueView, 19)
    .topSpaceToView(accountView, 14)
    .heightIs(21);
    
    
    midView.sd_layout
    .leftSpaceToView(accountView, 0)
    .rightSpaceToView(accountView, 0)
    .heightIs(1)
    .topSpaceToView(accountView, 54);
    
    
    bottomBtn.sd_layout
    .topSpaceToView(midView, 0)
    .leftSpaceToView(accountView, 10)
    .rightSpaceToView(accountView, 10)
    .heightIs(39);
    
    
    
    accountNumberLabel.sd_layout
    .leftSpaceToView(bottomBtn, 3)
    .topSpaceToView(bottomBtn, 10)
    .heightIs(20)
    .widthRatioToView(bottomBtn, 0.5);
    
    accountOpenImageView.sd_layout
    .rightSpaceToView(bottomBtn, 11)
    .topSpaceToView(bottomBtn, 16)
    .widthIs(16)
    .heightIs(9);
    
    contAccountView.sd_layout
    .leftSpaceToView(accountView,0)
    .rightSpaceToView(accountView, 0)
    .topSpaceToView(bottomBtn, 0)
    .bottomSpaceToView(accountView, 10);
    
    
    
}


- (void)setBalancemodel:(RSSLRunningDetialModel *)balancemodel{
    //_balancemodel = balancemodel;
    _balancemodel = balancemodel;
    _accountProductNameLabel.text = [NSString stringWithFormat:@"匝号:%@",balancemodel.turnsNo];
    _accountMaterielLabel.text =[NSString stringWithFormat:@"板号:%@", balancemodel.slNo];
    _accountNumberLabel.text = [NSString stringWithFormat:@"流转单据 %ld单",balancemodel.billCount];
    for (UIView *view in _contAccountView.subviews) {
        [view removeFromSuperview];
    }
    if (balancemodel.contentArr.count > 0) {
        _contAccountView.hidden = NO;
        _contAccountView.userInteractionEnabled = YES;
        
        for (int i = 0; i < balancemodel.contentArr.count; i++) {
            RSAccountDetailModel * accountdetialmodel = balancemodel.contentArr[i];
            UIButton * detailContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            detailContentBtn.frame = CGRectMake(0, i * 44, SCW - 24, 44);
            [detailContentBtn setBackgroundColor:[UIColor clearColor]];
            [detailContentBtn addTarget:self action:@selector(clickCurrentAction:) forControlEvents:UIControlEventTouchUpInside];
            detailContentBtn.tag = i;
            
            UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 1, 19.5)];
            firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
            [detailContentBtn addSubview:firstView];
            if (i == 0) {
                firstView.hidden = YES;
            }else{
                firstView.hidden = NO;
            }
            
            UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(13, 19.5, 5, 5)];
            midView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
            [detailContentBtn addSubview:midView];
            midView.layer.cornerRadius = midView.yj_width * 0.5;
            midView.layer.masksToBounds = YES;
            
            UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(15, 24.5, 1, 19.5)];
            secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
            [detailContentBtn addSubview:secondView];
            
            //类型
            UILabel * typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(27, 10, detailContentBtn.yj_width * 0.3, 20)];
            typeLabel.text = accountdetialmodel.billName;
            typeLabel.font = [UIFont systemFontOfSize:14];
            typeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
            typeLabel.textAlignment = NSTextAlignmentLeft;
            [detailContentBtn addSubview:typeLabel];
            
            
            
            //时间
            UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(27, CGRectGetMaxY(typeLabel.frame), 60, 13)];
            timeLabel.text = accountdetialmodel.billDate;
            timeLabel.font = [UIFont systemFontOfSize:10];
            timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
            timeLabel.textAlignment = NSTextAlignmentLeft;
            [detailContentBtn addSubview:timeLabel];
            
            
            //单号
            UILabel *  billNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeLabel.frame), 10,detailContentBtn.yj_width - 36 - CGRectGetMaxX(typeLabel.frame), 20)];
            billNoLabel.text = accountdetialmodel.billNo;
            billNoLabel.font = [UIFont systemFontOfSize:14];
            billNoLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
            billNoLabel.textAlignment = NSTextAlignmentRight;
            [detailContentBtn addSubview:billNoLabel];
            
            //图片
            UIImageView * typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(billNoLabel.frame) + 12, 18.5, 7, 13)];
            typeImageView.image = [UIImage imageNamed:@"system-pull-down copy 2-1"];
            typeImageView.contentMode = UIViewContentModeScaleAspectFill;
            typeImageView.clipsToBounds = YES;
            [detailContentBtn addSubview:typeImageView];
            [_contAccountView addSubview:detailContentBtn];
        }
    }else{
        _contAccountView.hidden = YES;
    }
    
}


- (void)clickCurrentAction:(UIButton *)detailContentBtn{
    if ([self.delegate respondsToSelector:@selector(clickOpenDetialContentCurrentCellIndex:andContentArrIndex:)]) {
        [self.delegate clickOpenDetialContentCurrentCellIndex:self.tag andContentArrIndex:detailContentBtn.tag];
    }
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
