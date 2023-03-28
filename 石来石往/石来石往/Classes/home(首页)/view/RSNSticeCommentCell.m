//
//  RSNSticeCommentCell.m
//  石来石往
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNSticeCommentCell.h"

@interface RSNSticeCommentCell()

{
    UIImageView * _nsticeCommentImage;
    UILabel * _nsticeCommentTitle;
    
    
    UILabel * _nsticeCommentLabel;
    
    UILabel * _nsticeCommentTime;
    
}


@end



@implementation RSNSticeCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //评论的界面的view
        UIView * nsticeCommentView = [[UIView alloc]init];
        nsticeCommentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:nsticeCommentView];
        
        
        
        //评论界面的图片
        UIImageView * nsticeCommentImage = [[UIImageView alloc]init];
        [nsticeCommentView addSubview:nsticeCommentImage];
        nsticeCommentImage.contentMode = UIViewContentModeScaleAspectFill;
        nsticeCommentImage.clipsToBounds = YES;
        _nsticeCommentImage = nsticeCommentImage;
        
        //评论界面的标题
        UILabel * nsticeCommentTitle = [[UILabel alloc]init];
       // nsticeCommentTitle.text = @"海西石材交易中心 给你评论了";
        nsticeCommentTitle.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nsticeCommentTitle.font = [UIFont systemFontOfSize:16];
        nsticeCommentTitle.textAlignment = NSTextAlignmentLeft;
        [nsticeCommentView addSubview:nsticeCommentTitle];
        _nsticeCommentTitle = nsticeCommentTitle;
        
        //评论界面的评论的内容
        UILabel * nsticeCommentLabel = [[UILabel alloc]init];
        nsticeCommentLabel.textAlignment = NSTextAlignmentLeft;
        nsticeCommentLabel.font = [UIFont systemFontOfSize:14];
        nsticeCommentLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        
       // nsticeCommentLabel.text = @"你家的石材很漂亮,找个机会到你那看看，到时候满意会马上买的找个机会到你那看看，到时候满意会马上买的";
        nsticeCommentLabel.numberOfLines = 2;
        [nsticeCommentView addSubview:nsticeCommentLabel];
        _nsticeCommentLabel = nsticeCommentLabel;
        
        
        
        UIView * timeView = [[UIView alloc]init];
        timeView.backgroundColor = [UIColor clearColor];
        [nsticeCommentView addSubview:timeView];
        
        
        //评论的界面的评论的推送的时间
        UILabel * nsticeCommentTime = [[UILabel alloc]init];
       // nsticeCommentTime.text = @"1天前";
        nsticeCommentTime.textAlignment = NSTextAlignmentLeft;
        nsticeCommentTime.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        nsticeCommentTime.font = [UIFont systemFontOfSize:13];
        [timeView addSubview:nsticeCommentTime];
        _nsticeCommentTime = nsticeCommentTime;
        
        //评论的界面时间view里面有一个分隔线
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
        [timeView addSubview:midView];
        
        
        
        //评论界面时间view的回复按键
        UIButton * nsticeCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nsticeCommentBtn setTitle:@"回复" forState:UIControlStateNormal];
        nsticeCommentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [nsticeCommentBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        nsticeCommentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [timeView addSubview:nsticeCommentBtn];
        _nsticeCommentBtn = nsticeCommentBtn;
        
        
        
        
        nsticeCommentView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12.5)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
        nsticeCommentImage.sd_layout
        .leftSpaceToView(nsticeCommentView, 21.5)
        .topSpaceToView(nsticeCommentView, 25)
        .bottomSpaceToView(nsticeCommentView, 25)
        .widthIs(70);
        
        
        nsticeCommentTitle.sd_layout
        .leftSpaceToView(nsticeCommentImage, 14)
        .rightSpaceToView(nsticeCommentView, 12)
        .topEqualToView(nsticeCommentImage)
        .heightIs(15.5);
        
        
        nsticeCommentLabel.sd_layout
        .leftEqualToView(nsticeCommentTitle)
        .rightEqualToView(nsticeCommentTitle)
        .topSpaceToView(nsticeCommentTitle, 8.5)
        .heightIs(29);
        
        
        
        timeView.sd_layout
        
        .topSpaceToView(nsticeCommentLabel, 15.5)
        .leftEqualToView(nsticeCommentLabel)
        .rightSpaceToView(nsticeCommentView, 12)
        .bottomSpaceToView(nsticeCommentView, 13.5);
        //.widthIs(10);
        
        
        nsticeCommentTime.sd_layout
        .leftSpaceToView(timeView, 0)
        .topSpaceToView(timeView, 0)
        .bottomSpaceToView(timeView, 0)
        .widthIs(140);
        
        
        midView.sd_layout
        .leftSpaceToView(nsticeCommentTime, 10)
        .topSpaceToView(timeView, 0)
        .bottomSpaceToView(timeView, 0)
        .widthIs(1);
        
        nsticeCommentBtn.sd_layout
        .leftSpaceToView(midView, 10)
        .rightSpaceToView(timeView, 0)
        .topSpaceToView(timeView, 0)
        .bottomSpaceToView(timeView, 0);
        
    }
    return self;
}



- (void)setMessagemodel:(RSMessageModel *)messagemodel{
    _messagemodel = messagemodel;
    
    _nsticeCommentTitle.text = [NSString stringWithFormat:@"%@ 给您评论了",_messagemodel.operationName];
    _nsticeCommentTime.text = [NSString stringWithFormat:@"%@",_messagemodel.createTime];
     _nsticeCommentLabel.text = [NSString stringWithFormat:@"%@",_messagemodel.messageContent];
    if ([_messagemodel.messageContent isEqualToString:@"该评论已删除"]) {
        _nsticeCommentLabel.font = [UIFont systemFontOfSize:18];
        _nsticeCommentLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
    }else{
        _nsticeCommentLabel.font = [UIFont systemFontOfSize:16];
        // _nsticeCommentLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
    }
    
   
    [_nsticeCommentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",messagemodel.imgUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
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
