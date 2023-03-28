//
//  RSShopCircleCell.m
//  石来石往
//
//  Created by mac on 2021/11/1.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSShopCircleCell.h"
#import "UILabel+Category.h"
// 最大高度限制
CGFloat maxLinkLabelHeight = 0;
#define margin 0

@interface RSShopCircleCell()<MMImageListViewDelegate>

//分享
@property (nonatomic,strong)UUButton * shareBtn;

//评论
@property (nonatomic,strong)UUButton * commentBtn;

//底部横线
@property (nonatomic,strong)UIView * bottomview;

//时间
@property (nonatomic,strong)UILabel * timeLabel;

@end


@implementation RSShopCircleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 头像视图
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:_headImageView];
        _headImageView.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(self.contentView, Height_Real(10)).widthIs(Width_Real(44)).heightEqualToWidth();
        _headImageView.layer.cornerRadius = _headImageView.yj_width * 0.5;
        _headImageView.layer.masksToBounds = YES;
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHead:)];
        [_headImageView addGestureRecognizer:tapGesture];
        
        
        //会员
        _memberImageView = [[UIImageView alloc]init];
        _memberImageView.image = [UIImage imageNamed:@"会员"];
        [_headImageView addSubview:_memberImageView];
        
        _memberImageView.sd_layout.centerXEqualToView(_headImageView).bottomSpaceToView(_headImageView, 0).widthIs(Width_Real(12)).heightEqualToWidth();
        
        
        // 名字视图
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"水头某有限公司";
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightRegular];
        _nameLab.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        _nameLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLab];
                
        _nameLab.sd_layout.leftSpaceToView(_headImageView, Width_Real(12)).topEqualToView(_headImageView).rightSpaceToView(self.contentView, Width_Real(68)).heightIs(Height_Real(23));
        
        
        _nameLab.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickName:)];
        [_nameLab addGestureRecognizer:tapName];
        
        
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"21分钟前";
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightRegular];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:timeLabel];
        
        timeLabel.sd_layout.leftEqualToView(_nameLab).rightEqualToView(_nameLab).topSpaceToView(_nameLab, 0).heightIs(Height_Real(17));
        _timeLabel = timeLabel;
        
        //关注
        _attentionBtn = [[UUButton alloc]init];
        [_attentionBtn setTitle:@"+关注 " forState:UIControlStateNormal];
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightRegular];
        [_attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        [_attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_attentionBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        [self.contentView addSubview:_attentionBtn];
        
        _attentionBtn.sd_layout.rightSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(self.contentView, Height_Real(12)).widthIs(52).heightIs(24);
        
        _attentionBtn.layer.borderWidth = 1;
        _attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#3385FF"].CGColor;
        _attentionBtn.layer.cornerRadius = 11.5;
        
        _attentionBtn.clipsToBounds = YES;
//        _attentionBtn.spacing = Width_Real(3);
        
        // 正文视图
        _shopLinkLabel = kMLLinkLabel();
//        _shopLinkLabel.text = @"当你看完海西市场鳞次栉比、琳琅满目的满仓大板后，漫步在海西大道上，伴随着一曲高山流水的洋洋盈耳，跟着走进海西智慧石代馆，你会发现这里别有一番天地！";
//        _shopLinkLabel.numberOfLines = 0;
        _shopLinkLabel.font =  [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
        _shopLinkLabel.delegate = self;
        _shopLinkLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        _shopLinkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kLinkTextColor};
        _shopLinkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#333333"],NSBackgroundColorAttributeName:kHLBgColor};
        [self.contentView addSubview:_shopLinkLabel];
        
//        _shopLinkLabel.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).rightSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(_headImageView, Height_Real(8)).autoHeightRatio(0);
//
        
        // 查看'全文'按钮
        _showAllBtn = [[UIButton alloc]init];
        _showAllBtn.titleLabel.font = kTextFont;
        _showAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        _showAllBtn.backgroundColor = [UIColor clearColor];
        [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
        [_showAllBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
        [_showAllBtn addTarget:self action:@selector(fullTextClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_showAllBtn];
        
//        _showAllBtn.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(_shopLinkLabel, 0).heightIs(Height_Real(20)).widthIs(Width_Real(60));
        
        // 图片区
        _imageListView = [[MMImageListView alloc] initWithFrame:CGRectZero];
        _imageListView.delegate = self;
        [self.contentView addSubview:_imageListView];
        
//        _imageListView.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).rightSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(_shopLinkLabel, Height_Real(25)).autoHeightRatio(0);
//
        
        _commentView = [[UIView alloc]init];
        _commentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_commentView];
        
//        _commentView.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).rightSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(_imageListView, Height_Real(8)).autoHeightRatio(0);
//
        
        //分享
        UUButton * shareBtn = [[UUButton alloc]init];
        [shareBtn setImage:[UIImage imageNamed:@"新分享"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:shareBtn];
        _shareBtn = shareBtn;
//        shareBtn.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(_commentView, Height_Real(8)).widthIs(Width_Real(30)).heightEqualToWidth();
        
        //评论
        UUButton * commentBtn =[[UUButton alloc]init];
        [commentBtn setTitle:@"20" forState:UIControlStateNormal];
        [commentBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        commentBtn.spacing = Width_Real(5);
        commentBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
        [commentBtn setImage:[UIImage imageNamed:@"新评论"] forState:UIControlStateNormal];
        [commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:commentBtn];
        _commentBtn = commentBtn;
        
        //点赞
        UUButton * goodBtn = [[UUButton alloc]init];
        [goodBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FD9338"] forState:UIControlStateSelected];
        [goodBtn setTitle:@"2010" forState:UIControlStateNormal];
        [goodBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        goodBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
        [goodBtn setImage:[UIImage imageNamed:@"新未点赞"] forState:UIControlStateNormal];
        [goodBtn setImage:[UIImage imageNamed:@"新点赞"] forState:UIControlStateSelected];
        [goodBtn addTarget:self action:@selector(goodAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:goodBtn];
        goodBtn.spacing = Width_Real(2);
        _goodBtn = goodBtn;
        
        
        
        _bottomview = [[UIView alloc]init];
        _bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.6];
        [self.contentView addSubview:_bottomview];
        
//        goodBtn.sd_layout.rightSpaceToView(self.contentView, Width_Real(16)).topEqualToView(shareBtn).widthIs(Width_Real(70)).heightIs(Height_Real(30));
//
//        commentBtn.sd_layout.rightSpaceToView(goodBtn,0).topEqualToView(goodBtn).widthIs(Width_Real(70)).heightIs(Height_Real(30));
//
        maxLinkLabelHeight = _shopLinkLabel.font.lineHeight * 4;
        
    }
    return self;
}



- (void)setMoment:(Moment *)moment{
    _moment = moment;
    
    _nameLab.text = _moment.HZName;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:moment.HZLogo] placeholderImage:[UIImage imageNamed:@"图片加载中"]];
    if ([_moment.userType isEqualToString:@"hxhz"]) {
       _memberImageView.hidden = NO;
    }else{
       _memberImageView.hidden = YES;
    }
    // 正文
    _showAllBtn.hidden = YES;
    _shopLinkLabel.hidden = YES;
    if ([[NSString stringWithFormat:@"%@",moment.attstatus] isEqualToString:@"0"]) {
        [_attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        _attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#3385FF"].CGColor;
//        [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_attentionBtn setTitle:@"+关注 " forState:UIControlStateNormal];
    }else{
        [_attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#B2B2B2"] forState:UIControlStateNormal];
        [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        _attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
    }
    
    CGFloat bottom = _headImageView.bottom + kPaddingValue;
    
    NSString *string = moment.create_time;
    NSRange range = [string rangeOfString:@"."];
    string =[string substringToIndex:range.location];
    _timeLabel.text = [NSString stringWithFormat:@"%@",[Utility compareCurrentTime:string]];
    
    
    CGFloat rowHeight = 0;
    
    
    if ([moment.content length]) {
        _shopLinkLabel.hidden = NO;
//        _shopLinkLabel.text = moment.content;
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 0;
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:moment.content];
        [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,[moment.content length])];
        _shopLinkLabel.attributedText = attributedText;
        // 判断显示'全文'/'收起'
        CGSize attrStrSize = [_shopLinkLabel preferredSizeWithMaxWidth:SCW - Width_Real(32)];
        CGFloat labH = attrStrSize.height;
        if (labH > maxLinkLabelHeight) {
            if (!_moment.isFullText) {
                labH = maxLinkLabelHeight;
                [self.showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
            } else {
                [self.showAllBtn setTitle:@"收起" forState:UIControlStateNormal];
            }
            _showAllBtn.hidden = NO;
        }
        _shopLinkLabel.frame = CGRectMake(Width_Real(16), bottom + kPaddingValue, attrStrSize.width, labH);
        _showAllBtn.frame = CGRectMake(Width_Real(16), _shopLinkLabel.bottom + kArrowHeight, kMoreLabWidth, kMoreLabHeight);
        if (_showAllBtn.hidden) {
            bottom = _shopLinkLabel.bottom + kPaddingValue;
        } else {
            bottom = _showAllBtn.bottom + kPaddingValue;
        }
    }
    // 图片
    
    for (UIView * view in _imageListView.subviews) {
        [view removeFromSuperview];
    }
    
    _imageListView.moment = moment;
    if ([moment.viewType isEqualToString:@"picture"]) {
        if (moment.photos.count > 0) {
            _imageListView.origin = CGPointMake(Width_Real(16), bottom);
//            CLog(@"============================%lf-----------------%lf",_imageListView.height,_imageListView.bottom);
//            _imageListView.frame = CGRectMake(_nameLab.left, bottom, SCW - Width_Real(32), _imageListView.height);
            bottom = _imageListView.bottom;
        }
    }else if([moment.viewType isEqualToString:@"video"]) {
        _imageListView.origin = CGPointMake(Width_Real(16), bottom);
        bottom = _imageListView.bottom;
    }

    // 操作视图
    // 处理评论/赞
    _commentView.frame = CGRectZero;
    [_commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 处理赞
    CGFloat width = SCW - Width_Real(32);
    // 处理评论
    CGFloat top = 0;
    NSInteger count = [moment.commentList count];
    [_commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CommentShopLabel * shopLabel = [[CommentShopLabel alloc] initWithFrame:CGRectMake(0, top, width, 0)];
            Comment * commen = [moment.commentList objectAtIndex:i];
            shopLabel.comment = commen;
            [shopLabel setDidClickText:^(Comment *comment) {
                if ([self.delegate respondsToSelector:@selector(didShopCircleSelectComment:andMomentCell:)]) {
                    [self.delegate didShopCircleSelectComment:comment andMomentCell:self];
                }
            }];
            [shopLabel setDidClickLinkText:^(MLLink *link, NSString *linkText, Comment *comment) {
                if ([self.delegate respondsToSelector:@selector(didShopCircleClickLink:linkText:andComment:andCell:)]) {
                    [self.delegate didShopCircleClickLink:link linkText:linkText andComment:comment andCell:self];
                }
            }];
            [_commentView addSubview:shopLabel];
            // 更新
            top += shopLabel.height;
        }
    }
    _commentView.frame = CGRectMake(Width_Real(16), bottom + kArrowHeight, width, top);
//     更新UI
//    if (top > 0) {
//        rowHeight = _commentView.bottom + kBlank;
//    } else {
     rowHeight = _commentView.bottom + kBlank;
//    }

    _shareBtn.frame = CGRectMake(Width_Real(16), rowHeight, Width_Real(30), Width_Real(30));
    

    if ([moment.likestatus isEqualToString:@"0"]) {
        _goodBtn.selected = false;
    }else{
        _goodBtn.selected = true;
    }
    [_goodBtn setTitle:[NSString stringWithFormat:@"%@",moment.likenum] forState:UIControlStateNormal];
    
    _goodBtn.frame = CGRectMake(SCW - Width_Real(86), rowHeight, Width_Real(70), Height_Real(30));
    
    _commentBtn.frame = CGRectMake(SCW - Width_Real(156), rowHeight, Width_Real(79), Height_Real(30));
    
    rowHeight = _shareBtn.bottom + kBlank;
    
    _bottomview.frame = CGRectMake(Width_Real(16),rowHeight , SCW - Width_Real(32), Height_Real(0.5));
    
    rowHeight = _bottomview.bottom;
    // 这样做就是起到缓存行高的作用，省去重复计算!!!
    _moment.rowHeight = rowHeight;
    
    
//    CLog(@"======================================%lf",rowHeight);
    
}


#pragma mark - 点击事件
// 查看全文/收起
- (void)fullTextClicked:(UIButton *)sender{
    _showAllBtn.titleLabel.backgroundColor = kHLBgColor;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _showAllBtn.titleLabel.backgroundColor = [UIColor clearColor];
        _moment.isFullText = !_moment.isFullText;
        if ([self.delegate respondsToSelector:@selector(didShopCircleSelectFullText:)]) {
            [self.delegate didShopCircleSelectFullText:self];
        }
    });
}




//点击介绍
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel{
    if ([self.delegate respondsToSelector:@selector(didShopCircleClickLink:linkText:andCell:)]) {
        [self.delegate didShopCircleClickLink:link linkText:linkText andCell:self];
    }
}


//分享
- (void)shareAction:(UIButton *)shareBtn{
    if ([self.delegate respondsToSelector:@selector(didShopCircleShareMoment:)]) {
        [self.delegate didShopCircleShareMoment:self];
    }
}

//评论
- (void)commentAction:(UIButton *)commentBtn{
    //didShopCircleAddComment
    if ([self.delegate respondsToSelector:@selector(didShopCircleAddComment:)]) {
        [self.delegate didShopCircleAddComment:self];
    }
}

//点赞
- (void)goodAction:(UIButton *)goodBtn{
//    didShopCircleLikeMoment
    if ([self.delegate respondsToSelector:@selector(didShopCircleLikeMoment:)]) {
        [self.delegate didShopCircleLikeMoment:self];
    }
}

//关注
- (void)attentionAction:(UIButton *)attentionBtn{
    if ([self.delegate respondsToSelector:@selector(didShopCircleAttentionMoment:)]) {
        [self.delegate didShopCircleAttentionMoment:self];
    }
}


//点击视频播放的时候
- (void)tapCurrentImageView:(Moment *)moment{
    if ([self.delegate respondsToSelector:@selector(didCurrentCellVideoUrl:)]) {
        [self.delegate didCurrentCellVideoUrl:moment];
    }
}

//点击图片
- (void)tapCurrentShowImageView{
    if ([self.delegate respondsToSelector:@selector(didCurrentShowImageView)]) {
        [self.delegate didCurrentShowImageView];
    }
}

// 点击头像
- (void)clickHead:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(didClickProfile:)]) {
        [self.delegate didClickProfile:self];
    }
}

//点击名称
- (void)clickName:(UITapGestureRecognizer *)tapName{
    if ([self.delegate respondsToSelector:@selector(didClickName:)]) {
        [self.delegate didClickName:self];
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end


#pragma mark - ------------------ 评论 ------------------
@implementation CommentShopLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _commentLinkLabel = kMLLinkLabel();
        _commentLinkLabel.delegate = self;
        [self addSubview:_commentLinkLabel];
    }
    return self;
}

#pragma mark - Setter
- (void)setComment:(Comment *)comment
{
    _comment = comment;
    _commentLinkLabel.attributedText = kMLLinkLabelAttributedText(comment);
    CGSize attrStrSize = [_commentLinkLabel preferredSizeWithMaxWidth:SCW - Width_Real(32)];
    _commentLinkLabel.frame = CGRectMake(0, Height_Real(3),attrStrSize.width, attrStrSize.height);
    self.height = attrStrSize.height + 10;
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    if (self.didClickLinkText) {
        //self.didClickLinkText(link,linkText);
        self.didClickLinkText(link, linkText, self.comment);
    }
}

#pragma mark - 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = kHLBgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor clearColor];
        if (self.didClickText) {
            self.didClickText(_comment);
        }
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor clearColor];
}


@end
