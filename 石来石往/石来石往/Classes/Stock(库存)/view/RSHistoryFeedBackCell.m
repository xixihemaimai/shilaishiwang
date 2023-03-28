//
//  RSHistoryFeedBackCell.m
//  石来石往
//
//  Created by mac on 2022/9/14.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSHistoryFeedBackCell.h"

@interface RSHistoryFeedBackCell()

@property (nonatomic,strong)UILabel * timeLabel;

@property (nonatomic,strong)UIImageView * statusImage;

@property (nonatomic,strong)UIImageView * rightImage;

@property (nonatomic,strong)UILabel * showLabel;


@end


@implementation RSHistoryFeedBackCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBFBFB"];
        
        UIView * newContentView = [[UIView alloc]init];
        newContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:newContentView];
        
        
        newContentView.sd_layout.leftSpaceToView(self.contentView, 16).rightSpaceToView(self.contentView, 16).topSpaceToView(self.contentView, 12).bottomSpaceToView(self.contentView, 0);
        
        newContentView.layer.cornerRadius = 4;
        newContentView.layer.masksToBounds = true;
        
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"2022.09.22 19:00:00";
        _timeLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _timeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [newContentView addSubview:_timeLabel];
        
        _timeLabel.sd_layout.leftSpaceToView(newContentView, 11.5).topSpaceToView(newContentView, 12).heightIs(22).widthIs(180);
        
        
        _statusImage = [[UIImageView alloc]init];
        _statusImage.image = [UIImage imageNamed:@"处理中"];
        [newContentView addSubview:_statusImage];
        _statusImage.sd_layout.leftSpaceToView(_timeLabel, 6).centerYEqualToView(_timeLabel).widthIs(45).heightIs(22);
        
        
        
        _rightImage = [[UIImageView alloc]init];
        _rightImage.image = [UIImage imageNamed:@"chevron-right"];
        [newContentView addSubview:_rightImage];
        _rightImage.sd_layout.rightSpaceToView(newContentView, 9).topSpaceToView(newContentView, 18).widthIs(20).heightEqualToWidth();
        
        _showLabel = [[UILabel alloc]init];
        _showLabel.numberOfLines = 2;
        _showLabel.textAlignment = NSTextAlignmentLeft;
        _showLabel.text = @"我是反馈详情我是反馈详情我是反馈详情我是反馈详情我是反馈详情我是反馈详情";
        _showLabel.font = [UIFont systemFontOfSize:14];
        _showLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [newContentView addSubview:_showLabel];
        
        
        _showLabel.sd_layout.leftSpaceToView(newContentView, 11.5).topSpaceToView(_timeLabel, 8).rightSpaceToView(newContentView, 11.5).bottomSpaceToView(newContentView, 10.5);
        
        
    }
    return self;
}

- (void)setHistoryFeedBackListModel:(RSHistoryFeedBackListModel *)historyFeedBackListModel{
    _historyFeedBackListModel = historyFeedBackListModel;
    
    
    _showLabel.text = _historyFeedBackListModel.content;
    
    if (_historyFeedBackListModel.status == 0){
        
        _statusImage.image = [UIImage imageNamed:@"处理中"];
        _statusImage.sd_layout.leftSpaceToView(_timeLabel, 6).centerYEqualToView(_timeLabel).widthIs(45).heightIs(22);
    }else{
        
        _statusImage.image = [UIImage imageNamed:@"完成"];
        _statusImage.sd_layout.leftSpaceToView(_timeLabel, 6).centerYEqualToView(_timeLabel).widthIs(30).heightIs(22);
    }
    
    
//    _historyFeedBackListModel.updateTime
    _timeLabel.text = [self timeWithYearMonthDayCountDown:_historyFeedBackListModel.createTime];
    
}



- (NSString *)timeWithYearMonthDayCountDown:(NSString*)timestamp
{// 时间戳转日期// 传入的时间戳timeStr如果是精确到毫秒的记得要/1000
    NSTimeInterval timeInterval=[timestamp doubleValue]/1000;
    NSDate*detailDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter*dateFormatter= [[NSDateFormatter alloc]init];
    // 实例化一个NSDateFormatter对象，设定时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString*dateStr=[dateFormatter stringFromDate:detailDate];
    return dateStr;
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
