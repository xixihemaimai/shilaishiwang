//
//  RSHSCell.m
//  石来石往
//
//  Created by mac on 17/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHSCell.h"

@interface RSHSCell ()

{

    /**公司名称*/
    UILabel *_ownerLabel;
    /**体积*/
    UILabel *_volumeLabel;
}

@end

@implementation RSHSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UIView * firstView = [[UIView alloc]init];
        firstView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:firstView];
        
        
        firstView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,1)
        .widthIs(SCW/3);
        
        
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.backgroundColor = [UIColor whiteColor];
        [firstView addSubview:imageview];
        _imageview = imageview;
        
        imageview.sd_layout
        .centerXEqualToView(firstView)
        .topSpaceToView(firstView,8)
        .bottomSpaceToView(firstView,8)
        .widthIs(20);
        
        
        
        UILabel * rankLabel = [[UILabel alloc]init];
        rankLabel.text = @"1";
        rankLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        rankLabel.font = [UIFont systemFontOfSize:12];
        rankLabel.textAlignment = NSTextAlignmentCenter;
        _rankLabel = rankLabel;
        [firstView addSubview:rankLabel];
        
        
        rankLabel.sd_layout
        .centerYEqualToView(firstView)
        .leftSpaceToView(firstView,0)
        .topSpaceToView(firstView,0)
        .bottomSpaceToView(firstView,0)
        .widthIs(SCW/3);
        
        
        UILabel *ownerLabel = [[UILabel alloc]init];
        ownerLabel.text = @"石材石往";
        ownerLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        ownerLabel.textAlignment = NSTextAlignmentCenter;
        ownerLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:ownerLabel];
        _ownerLabel = ownerLabel;
        
        
        UILabel *volumeLabel = [[UILabel alloc]init];
        volumeLabel.text = @"225m3";
        volumeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        volumeLabel.font = [UIFont systemFontOfSize:12];
          volumeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:volumeLabel];
        _volumeLabel = volumeLabel;
        
        
        UIView * bottomview = [[UIView alloc]init];
       // bottomLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        //bottomLabel.numberOfLines = 1;
       // bottomLabel.text = @"-----------------------------------------------------------------------------------------------------------";
       // bottomLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:bottomview];
        
        
        volumeLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(ownerLabel,0)
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,1)
        .rightSpaceToView(self.contentView,0)
        .widthIs(SCW/3);
        
        
        ownerLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .centerXEqualToView(self.contentView)
        .leftSpaceToView(rankLabel,0)
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,1)
        .rightSpaceToView(volumeLabel,0)
        .widthIs(SCW/3);
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(SCW)
        .heightIs(1);
        
        [self drawDashLine:bottomview lineLength:2 lineSpacing:1 lineColor:[UIColor colorWithHexColorStr:@"#999999"]];
        
    }
    return self;
}

- (void)setRankModel:(RSRankModel *)rankModel{
    _rankModel = rankModel;
    
    
    if (_rankModel.monthRank == 1) {
        
        _imageview.image = [UIImage imageNamed:@"奖牌_03"];
        _rankLabel.text = [NSString stringWithFormat:@""];
    }else if (_rankModel.monthRank == 2){
        _imageview.image = [UIImage imageNamed:@"奖牌_05"];
        _rankLabel.text = [NSString stringWithFormat:@""];
    }else if (_rankModel.monthRank == 3){
        _imageview.image = [UIImage imageNamed:@"奖牌_07"];
        //_rankLabel.hidden = YES;
        _rankLabel.text = [NSString stringWithFormat:@""];
    }else{
        _imageview.image = [UIImage imageNamed:@""];
        _rankLabel.text = [NSString stringWithFormat:@"%ld",(long)_rankModel.monthRank];

    }
    
    
    
    _ownerLabel.text = [NSString stringWithFormat:@"%@",_rankModel.mtlName];
    
    if (_rankModel.mtlType == 1) {
        _volumeLabel.text = [NSString stringWithFormat:@"%.3fm³",_rankModel.VAQty];
    }else{
        _volumeLabel.text = [NSString stringWithFormat:@"%.3fm²",_rankModel.VAQty];
    }
    
    
    
}

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
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
