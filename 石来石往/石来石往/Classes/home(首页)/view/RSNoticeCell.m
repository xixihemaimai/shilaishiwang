//
//  RSNoticeCell.m
//  石来石往
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNoticeCell.h"


@interface RSNoticeCell ()
{
    
    UILabel * _noticeLabel;
    
    UILabel * _noticeContent;
    
    UILabel * _noticeTime;
    
    
}



@end

@implementation RSNoticeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        //通知的界面
        UIView * noticeView = [[UIView alloc]init];
        noticeView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:noticeView];
        
        //通知的消息
        UILabel * noticeLabel = [[UILabel alloc]init];
       // noticeLabel.text = @"紧急通知";
        noticeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        noticeLabel.font = [UIFont systemFontOfSize:16];
        noticeLabel.textAlignment = NSTextAlignmentLeft;
        [noticeView addSubview:noticeLabel];
        _noticeLabel = noticeLabel;
        
        
        //通知里面的内容
        UILabel * noticeContent = [[UILabel alloc]init];
        noticeContent.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        noticeContent.font = [UIFont systemFontOfSize:14];
        noticeContent.textAlignment = NSTextAlignmentLeft;
        noticeContent.numberOfLines = 0;
       // noticeContent.text = @"目前app已全部正常使用";
        [noticeView addSubview:noticeContent];
        _noticeContent = noticeContent;
        
        //通知里面的时间界面
        UIView * noticeTimeView = [[UIView alloc]init];
        noticeTimeView.backgroundColor = [UIColor clearColor];
        [noticeView addSubview:noticeTimeView];
        
        
        //通知时间界面的图片
        UIImageView * noticeImage = [[UIImageView alloc]init];
        noticeImage.image = [UIImage imageNamed:@"系统通知"];
        [noticeTimeView addSubview:noticeImage];
        
        //通知时间界面的通知类型
        UILabel * noticeStyle = [[UILabel alloc]init];
        noticeStyle.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        noticeStyle.font = [UIFont systemFontOfSize:13];
        noticeStyle.textAlignment = NSTextAlignmentLeft;
        //noticeStyle.text = @"系统通知";
        [noticeTimeView addSubview:noticeStyle];
        _noticeStyle = noticeStyle;
        
        //通知时间界面的时间
        UILabel * noticeTime = [[UILabel alloc]init];
       // noticeTime.text = @"2017-11-24";
        noticeTime.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        noticeTime.font = [UIFont systemFontOfSize:13];
        noticeTime.textAlignment = NSTextAlignmentRight;
        [noticeTimeView addSubview:noticeTime];
        _noticeTime = noticeTime;
        
        noticeView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        noticeLabel.sd_layout
        .leftSpaceToView(noticeView, 16)
        .topSpaceToView(noticeView, 20.5)
        .rightSpaceToView(noticeView, 16)
        .heightIs(15.5);
        
        
        
        noticeTimeView.sd_layout
        .leftSpaceToView(noticeView, 16)
        .rightSpaceToView(noticeView, 17)
        .bottomSpaceToView(noticeView, 15)
        .heightIs(24);
        
        
        
        
        
        
        noticeContent.sd_layout
        .leftEqualToView(noticeLabel)
        .rightEqualToView(noticeLabel)
        .topSpaceToView(noticeLabel, 10.5)
        .bottomSpaceToView(noticeTimeView, 10);
        
        
        
        
        
        
        
        noticeImage.sd_layout
        .leftEqualToView(noticeTimeView)
        .topEqualToView(noticeTimeView)
        .bottomEqualToView(noticeTimeView)
        .widthIs(24);

        noticeStyle.sd_layout
        .leftSpaceToView(noticeImage, 10)
        .centerYEqualToView(noticeTimeView)
        .widthIs(60)
        .heightIs(12.5);
        
        
        noticeTime.sd_layout
        .rightEqualToView(noticeTimeView)
        .centerYEqualToView(noticeTimeView)
        .leftSpaceToView(noticeStyle, 10)
        .heightIs(10.5);
    

    }
    return self;
}

- (void)setMessagemodel:(RSMessageModel *)messagemodel{
    _messagemodel = messagemodel;
    
    _noticeTime.text = [NSString stringWithFormat:@"%@",_messagemodel.createTime];
    
    _noticeLabel.text = [NSString stringWithFormat:@"%@",_messagemodel.messageTitle];
    
    _noticeContent.text = [NSString stringWithFormat:@"%@",_messagemodel.messageContent];
    
    
    
    
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
