//
//  RSMessageSecondCenterCell.m
//  石来石往
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMessageSecondCenterCell.h"


@interface RSMessageSecondCenterCell()

{
    
    UIImageView * _myImage;
    
    
    UILabel * _myLabel;
    
    
    
    UILabel * _timeLabel;
    
    
    UIButton * _myBtn;
}


@end


@implementation RSMessageSecondCenterCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        UIView * myView = [[UIView alloc]init];
        myView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:myView];
        
        
        
        UIImageView * myImage = [[UIImageView alloc]init];
        [myView addSubview:myImage];
        _myImage = myImage;
        myImage.contentMode = UIViewContentModeScaleAspectFill;
        myImage.clipsToBounds = YES;
        
        UILabel * myLabel = [[UILabel alloc]init];
        // myLabel.text = @"海西石材交易中心 给你点赞了";
        myLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        _myLabel = myLabel;
        myLabel.font = [UIFont systemFontOfSize:16];
        myLabel.textAlignment = NSTextAlignmentLeft;
        [myView addSubview:myLabel];
        
        
        
        UIView * timeView = [[UIView alloc]init];
        timeView.backgroundColor = [UIColor clearColor];
        [myView addSubview:timeView];
        
        
        UILabel * timeLabel = [[UILabel alloc]init];
        // timeLabel.text = @"1天前";
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:13];
        [timeView addSubview:timeLabel];
        
        _timeLabel = timeLabel;
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
        [timeView addSubview:midView];
        
        
        
        UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       // [myBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [myBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        myBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        myBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [timeView addSubview:myBtn];
        _myBtn = myBtn;
        
        myView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0);
        
        
        myImage.sd_layout
        .leftSpaceToView(myView, 21.5)
        .topSpaceToView(myView, 20.5)
        .bottomSpaceToView(myView, 19)
        .widthIs(60);
        
        
        myLabel.sd_layout
        .leftSpaceToView(myImage, 15.5)
        .topEqualToView(myImage)
        .rightSpaceToView(myView, 12)
        .heightIs(15.5);
        
        
        timeView.sd_layout
        .leftSpaceToView(myImage, 10)
        .bottomEqualToView(myImage)
        .rightSpaceToView(myView, 12)
        .heightIs(20);
        
        
        
        timeLabel.sd_layout
        .leftSpaceToView(timeView, 0)
        .topSpaceToView(timeView, 0)
        .bottomSpaceToView(timeView, 0)
        .widthIs(150);
        
        
        midView.sd_layout
        .leftSpaceToView(timeLabel, 10)
        .topSpaceToView(timeView, 0)
        .bottomSpaceToView(timeView, 0)
        .widthIs(1);
        
        
        myBtn.sd_layout
        .leftSpaceToView(midView, 0)
        .topSpaceToView(timeView, 0)
        .bottomSpaceToView(timeView, 0)
        .rightSpaceToView(timeView, 0);
        
        
        
        
    }
    return self;
}



- (void)setMessagecentermodel:(RSMessageCenterModel *)messagecentermodel{
    _messagecentermodel = messagecentermodel;
    [_myImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",messagecentermodel.imgUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
    
    _myLabel.text = [NSString stringWithFormat:@"%@ %@",messagecentermodel.userName,messagecentermodel.messageContent];
    
//    if ([messagecentermodel.messageContent isEqualToString:@"评论已删除"]) {
//        _myLabel.font = [UIFont systemFontOfSize:18];
//    }else{
//        _myLabel.font = [UIFont systemFontOfSize:16];
//    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",messagecentermodel.createTime];
    NSString * str = nil;
    if ([messagecentermodel.messageType isEqualToString:@"attention"]) {
        str = @"@您了";
    }else if ([messagecentermodel.messageType isEqualToString:@"like"]){
        str = @"点赞了";
    }else if ([messagecentermodel.messageType isEqualToString:@"reply"]){
        str = @"评论您了";
    }else{
        str = @"有系统消息";
    }
    [_myBtn setTitle:str forState:UIControlStateNormal];
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
