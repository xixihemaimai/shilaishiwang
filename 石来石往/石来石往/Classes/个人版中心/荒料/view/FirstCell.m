//
//  FirstCell.m
//  TableViewFloat
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 singularity. All rights reserved.
//

#import "FirstCell.h"

@interface FirstCell()

@property (nonatomic,strong)UILabel * creatTimeLabel;

@property (nonatomic,strong)UILabel * creatEventLabel;



@end


@implementation FirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //创建外部表格
        UIView * creatView = [[UIView alloc]init];
        creatView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:creatView];
        
        
        //图片
        UIImageView * creatImageView = [[UIImageView alloc]init];
        creatImageView.image = [UIImage imageNamed:@"等待1"];
        creatImageView.contentMode = UIViewContentModeScaleAspectFill;
        creatImageView.clipsToBounds = YES;
        [creatView addSubview:creatImageView];
        
        //时间
        UILabel * creatTimeLabel = [[UILabel alloc]init];
        creatTimeLabel.text = @"2019/1/1";
        creatTimeLabel.font = [UIFont systemFontOfSize:14];
        creatTimeLabel.textAlignment = NSTextAlignmentLeft;
        creatTimeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        [creatView addSubview:creatTimeLabel];
        _creatTimeLabel = creatTimeLabel;
        //事件
        UILabel * creatEventLabel = [[UILabel alloc]init];
        creatEventLabel.text = @"待磨1号机";
        creatEventLabel.font = [UIFont systemFontOfSize:15];
        creatEventLabel.textAlignment = NSTextAlignmentLeft;
        creatEventLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        [creatView addSubview:creatEventLabel];
        _creatEventLabel = creatEventLabel;
        
        UIButton * creatCurrentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [creatCurrentBtn setBackgroundColor:[UIColor colorFromHexString:@"#FDAD32"]];
        [creatCurrentBtn setTitle:@"当前工序" forState:UIControlStateNormal];
        [creatCurrentBtn setTitleColor:[UIColor colorFromHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        creatCurrentBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [creatView addSubview:creatCurrentBtn];
        _creatCurrentBtn = creatCurrentBtn;
        
        creatView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 6)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 1);
        
        
        creatView.layer.borderColor = [UIColor colorFromHexString:@"#E8E8E8"].CGColor;
        creatView.layer.cornerRadius = 3;
        creatView.layer.borderWidth = 1;
        
        
        creatImageView.sd_layout
        .leftSpaceToView(creatView, 20)
        .topSpaceToView(creatView, 9)
        .widthIs(16)
        .heightEqualToWidth();
        
        creatTimeLabel.sd_layout
        .leftSpaceToView(creatImageView, 6)
        .topEqualToView(creatImageView)
        .bottomEqualToView(creatImageView)
        .widthRatioToView(creatView, 0.5);
        
        
        creatEventLabel.sd_layout
        .leftSpaceToView(creatView, 20)
        .rightEqualToView(creatTimeLabel)
        .topSpaceToView(creatTimeLabel, 0)
        .bottomEqualToView(creatView);
        
        
        creatCurrentBtn.sd_layout
        .topSpaceToView(creatView, 7)
        .rightSpaceToView(creatView, 0)
        .widthIs(49)
        .heightIs(18);
        
        CGRect rect = CGRectMake(0, 0, 49, 18);
        CGRect oldRect = rect;
        oldRect.size.width = 49;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(50, 50)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = oldRect;
        creatCurrentBtn.layer.mask = maskLayer;
        
        
        
        
    }
    return self;
}


- (void)setFirstprocessmodel:(RSFirstProcessModel *)firstprocessmodel{
    _firstprocessmodel = firstprocessmodel;
    
    _creatTimeLabel.text = [NSString stringWithFormat:@"%@",_firstprocessmodel.processTime];
    
    _creatEventLabel.text = [NSString stringWithFormat:@"%@",_firstprocessmodel.processName];
    
    
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
