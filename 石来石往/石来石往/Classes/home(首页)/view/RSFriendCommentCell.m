//
//  RSFriendCommentCell.m
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFriendCommentCell.h"

@interface RSFriendCommentCell()

/**评论的tableview*/
@property (nonatomic,strong)UITableView * commentTableview;

@end

@implementation RSFriendCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * topview = [[UIView alloc]init];
        topview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        [self.contentView addSubview:topview];
        
        
        
        
        //图片
        UIImageView * icomImage = [[UIImageView alloc]init];
        _icomImage = icomImage;
        [self.contentView addSubview:icomImage];
        
        
        
        UIImageView * touImage = [[UIImageView alloc]init];
        // touImage.image = [UIImage imageNamed:@"货主头像框"];
        [self.contentView addSubview:touImage];
        _touImage = touImage;
        
        
        //货主的名字
        UILabel * hznameLabel = [[UILabel alloc]init];
        _hznameLabel = hznameLabel;
        hznameLabel.textColor = [UIColor blackColor];
        hznameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:hznameLabel];
        
        
        
        //评论
        UILabel * commentLabel = [[UILabel alloc]init];
        _commentLabel = commentLabel;
        commentLabel.numberOfLines = 0;
        commentLabel.textColor = [UIColor blackColor];
        commentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:commentLabel];
        
        
        //时间
        UILabel * dateLabel = [[UILabel alloc]init];
        _dateLabel = dateLabel;
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:dateLabel];
        
        
        
        topview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
        icomImage.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightIs(40);
        
        
        touImage.sd_layout
        .leftSpaceToView(icomImage, 10)
        .topEqualToView(icomImage)
        .widthIs(20)
        .heightIs(20);
        
        hznameLabel.sd_layout
        .leftSpaceToView(touImage,10)
        .rightSpaceToView(self.contentView,12)
        .topEqualToView(touImage)
        .heightIs(20);
        
        dateLabel.sd_layout
        .leftEqualToView(touImage)
        .rightEqualToView(hznameLabel)
        .topSpaceToView(touImage, 5)
        .heightIs(20);
        
        commentLabel.sd_layout
        .leftEqualToView(dateLabel)
        .rightEqualToView(dateLabel)
        .topSpaceToView(dateLabel, 5)
        .heightIs(20);
        
        
       
        
    }
    return self;
    
    
}





- (void)setFriendDetailmodel:(RSFriendDetailModel *)friendDetailmodel{
    _friendDetailmodel = friendDetailmodel;
    if ([_friendDetailmodel.userType isEqualToString:@"hxhz"]) {
        _touImage.image = [UIImage imageNamed:@"vip"];
        _touImage.sd_layout
        .widthIs(20);
    }else{
        _touImage.image = [UIImage imageNamed:@""];
        _touImage.sd_layout
        .widthIs(0);
    }
    [_icomImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",friendDetailmodel.HZLogo]] placeholderImage:[UIImage imageNamed:@"头像"]];
    _commentLabel.text = [NSString stringWithFormat:@"%@",friendDetailmodel.comment];
    _commentLabel.sd_layout
    .autoHeightRatio(0);
    _dateLabel.text = [NSString stringWithFormat:@"%@",friendDetailmodel.timedate];
    _hznameLabel.text = [NSString stringWithFormat:@"%@",friendDetailmodel.commentName];
    _dateLabel.textColor = [UIColor colorWithHexColorStr:@"#7683a4"];
    [self setupAutoHeightWithBottomView:_commentLabel bottomMargin:5];

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
