//
//  RSAuditStatusCustomTableViewCell.m
//  石来石往
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAuditStatusCustomTableViewCell.h"

@implementation RSAuditStatusCustomTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        //上半部分view
        UIView * upView = [[UIView alloc]init];
        upView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self.contentView addSubview:upView];
        
        _upView = upView;
        
        //中间的按键
        UIButton * centerBtn = [[UIButton alloc]init];
        centerBtn.enabled = NO;
        [centerBtn setTitle:@"提" forState:UIControlStateNormal];
        [centerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#cfcfcf"]];
        [self.contentView addSubview:centerBtn];
        _centerBtn = centerBtn;
        
        
        //下半部分view
        UIView * lowView = [[UIView alloc]init];
        lowView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self.contentView addSubview:lowView];
        
        _lowView = lowView;
    //右边
        UIView *rightView = [[UIView alloc]init];
        rightView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:rightView];
        
        
        //标题
        UILabel * titleLabel = [[UILabel alloc]init];
     //   titleLabel.text = @"提出出库申请";
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        [rightView addSubview:titleLabel];
        _titleLabel = titleLabel;
        //联系人
        UILabel * contactLabel = [[UILabel alloc]init];
        contactLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        contactLabel.textAlignment = NSTextAlignmentLeft;
        contactLabel.font = [UIFont systemFontOfSize:15];
      //  contactLabel.text = @"联系人:卢要神13950800123";
        [rightView addSubview:contactLabel];
        _contactLabel = contactLabel;
        
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
       // timeLabel.text = @"2018-06-25 10:52";
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [rightView addSubview:timeLabel];
        _timeLabel = timeLabel;
        //做底线横线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
        [rightView addSubview:bottomview];
        
        
        
        
       upView.sd_layout
        .leftSpaceToView(self.contentView, 45)
        .topSpaceToView(self.contentView, 0)
        .widthIs(2)
        .heightIs((90/2) - 20);
        
        
        
        lowView.sd_layout
        .leftSpaceToView(self.contentView, 45)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(2)
        .heightIs((90/2) - 20);
        
        
        centerBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 25)
        .topSpaceToView(upView, 0)
        .bottomSpaceToView(lowView, 0)
        .widthIs(40);
        
        centerBtn.layer.cornerRadius = centerBtn.yj_width * 0.5;
        centerBtn.layer.masksToBounds = YES;
        
        
        
        rightView.sd_layout
        .leftSpaceToView(centerBtn, 20)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        titleLabel.sd_layout
        .leftSpaceToView(rightView, 12)
        .rightSpaceToView(rightView, 0)
        .topSpaceToView(rightView, 10)
        .heightIs(20);
        
        contactLabel.sd_layout
        .leftEqualToView(titleLabel)
        .rightEqualToView(titleLabel)
        .topSpaceToView(titleLabel, 10)
        .heightIs(20);
        
        
        
        timeLabel.sd_layout
        .leftEqualToView(contactLabel)
        .rightEqualToView(contactLabel)
        .topSpaceToView(contactLabel, 10)
        .heightIs(20);
        
        
        bottomview.sd_layout
        .leftSpaceToView(rightView, 0)
        .rightSpaceToView(rightView, 0)
        .bottomSpaceToView(rightView, 0)
        .heightIs(1);
        
        
    }
    return self;
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
