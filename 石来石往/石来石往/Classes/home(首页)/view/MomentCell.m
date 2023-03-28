//
//  MomentCell.m
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MomentCell.h"
#import "UILabel+Category.h"
#pragma mark - ------------------ 动态 ------------------

// 最大高度限制
CGFloat maxLimitHeight = 0;
#define margin 0

@interface MomentCell()<MMImageListViewDelegate>

@property (nonatomic,strong) UIView * bottomview;


@end



@implementation MomentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    // 头像视图
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kBlank, kFaceWidth, kFaceWidth)];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.userInteractionEnabled = YES;
    _headImageView.layer.borderWidth = 0.5;
    _headImageView.layer.borderColor = [UIColor colorWithHexColorStr:@"#D8D8D8"].CGColor;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5;
     _headImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImageView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHead:)];
    [_headImageView addGestureRecognizer:tapGesture];
    
    //会员
    _memberImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxY(_headImageView.frame) - 14, 8, 16, 16)];
    _memberImageView.image = [UIImage imageNamed:@"会员"];
    _memberImageView.contentMode = UIViewContentModeScaleAspectFill;
    _memberImageView.clipsToBounds = YES;
    [self.contentView addSubview:_memberImageView];
    
    // 名字视图
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right + 10, _headImageView.top, SCW - 60 - 25 - 50, 20)];
    UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    _nameLab.font = font;
    _nameLab.textColor = [UIColor colorWithHexColorStr:@"#4C618E"];
    _nameLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_nameLab];
    _nameLab.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickName:)];
    [_nameLab addGestureRecognizer:tapName];

    //关注
    _attentionBtn = [[UUButton alloc]initWithFrame:CGRectMake(SCW - 12 - 50, _nameLab.top, 50, 20)];
    [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#4C618E"] forState:UIControlStateNormal];
    _attentionBtn.layer.borderWidth = 0.5;
    _attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#4C618E"].CGColor;
    _attentionBtn.layer.cornerRadius = 3;
    _attentionBtn.layer.masksToBounds = YES;
    _attentionBtn.spacing = 2;
    [_attentionBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
    [self.contentView addSubview:_attentionBtn];
    
    // 正文视图
    _linkLabel = kMLLinkLabel();
     UIFont * linklabelFont = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    _linkLabel.font = linklabelFont;
    _linkLabel.delegate = self;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kLinkTextColor};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#333333"],NSBackgroundColorAttributeName:kHLBgColor};
    [self.contentView addSubview:_linkLabel];
    // 查看'全文'按钮
    _showAllBtn = [[UIButton alloc]init];
    _showAllBtn.titleLabel.font = kTextFont;
    _showAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _showAllBtn.backgroundColor = [UIColor clearColor];
    [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
    [_showAllBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
    [_showAllBtn addTarget:self action:@selector(fullTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_showAllBtn];
    // 图片区
    _imageListView = [[MMImageListView alloc] initWithFrame:CGRectZero];
    _imageListView.delegate = self;
    [self.contentView addSubview:_imageListView];
    // 位置视图
  //  _locationLab = [[UILabel alloc] init];
  //  _locationLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
  //  _locationLab.font = [UIFont systemFontOfSize:13.0f];
  //  [self.contentView addSubview:_locationLab];
    // 时间视图
    _timeLab = [[UILabel alloc] init];
    _timeLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _timeLab.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_timeLab];
    // 删除视图
   // _deleteBtn = [[UIButton alloc] init];
   // _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
   // _deleteBtn.backgroundColor = [UIColor clearColor];
   // [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
   // [_deleteBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
   // [_deleteBtn addTarget:self action:@selector(deleteMoment:) forControlEvents:UIControlEventTouchUpInside];
   // [self.contentView addSubview:_deleteBtn];
    // 评论视图
    _bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgImageView];
    _commentView = [[UIView alloc] init];
    [self.contentView addSubview:_commentView];
    // 操作视图
    _menuView = [[MMOperateMenuView alloc] initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf = self;
    //点赞
    [_menuView setLikeMoment:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didLikeMoment:)]) {
            [weakSelf.delegate didLikeMoment:weakSelf];
        }
    }];
    //评论
    [_menuView setCommentMoment:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didAddComment:)]) {
            [weakSelf.delegate didAddComment:weakSelf];
        }
    }];
    //分享
    [_menuView setShareMoment:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didShareMoment:)]) {
            [weakSelf.delegate didShareMoment:weakSelf];
        }
    }];
    [self.contentView addSubview:_menuView];
    
    
    _bottomview = [[UIView alloc]init];
    _bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#E5E5E5"];
    [self.contentView addSubview:_bottomview];
    
    
    // 最大高度限制
    maxLimitHeight = _linkLabel.font.lineHeight * 6;
}


//点击视频播放的时候
- (void)tapCurrentImageView:(Moment *)moment{
    if ([self.delegate respondsToSelector:@selector(didCurrentCellVideoUrl:)]) {
        [self.delegate didCurrentCellVideoUrl:moment];
    }
}

- (void)tapCurrentShowImageView{
    if ([self.delegate respondsToSelector:@selector(didCurrentShowImageView)]) {
        [self.delegate didCurrentShowImageView];
    }
    
}




#pragma mark - setter
- (void)setMoment:(Moment *)moment
{
    _moment = moment;
    // 头像
    //_headImageView.image = [UIImage imageNamed:@"moment_head"];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:moment.HZLogo] placeholderImage:[UIImage imageNamed:@"图片加载中"]];
    // 昵称
    _nameLab.text = moment.HZName;
    if ([_moment.userType isEqualToString:@"hxhz"]) {
       _memberImageView.hidden = NO;
    }else{
       _memberImageView.hidden = YES;
    }
    // 正文
    _showAllBtn.hidden = YES;
    _linkLabel.hidden = YES;
    CGFloat bottom = _nameLab.bottom + kPaddingValue;
    CGFloat rowHeight = 0;
    if ([moment.content length]) {
        _linkLabel.hidden = NO;
        _linkLabel.text = moment.content;
        // 判断显示'全文'/'收起'
        CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
        CGFloat labH = attrStrSize.height;
        if (labH > maxLimitHeight) {
            if (!_moment.isFullText) {
                labH = maxLimitHeight;
                [self.showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
            } else {
                [self.showAllBtn setTitle:@"收起" forState:UIControlStateNormal];
            }
            _showAllBtn.hidden = NO;
        }
        _linkLabel.frame = CGRectMake(_nameLab.left, bottom, attrStrSize.width, labH);
        _showAllBtn.frame = CGRectMake(_nameLab.left, _linkLabel.bottom + kArrowHeight, kMoreLabWidth, kMoreLabHeight);
        if (_showAllBtn.hidden) {
            bottom = _linkLabel.bottom + kPaddingValue;
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
            _imageListView.origin = CGPointMake(_nameLab.left, bottom);
            bottom = _imageListView.bottom + kPaddingValue;
        }
    }else if([moment.viewType isEqualToString:@"video"]) {
        _imageListView.origin = CGPointMake(_nameLab.left, bottom);
        bottom = _imageListView.bottom + kPaddingValue;
    }
    
    
  
    // 位置
//    _locationLab.frame = CGRectMake(_nameLab.left, bottom, _nameLab.width, kTimeLabelH);
    
    NSString *string =moment.create_time;
    NSRange range = [string rangeOfString:@"."];
    string =[string substringToIndex:range.location];
      _timeLab.text = [NSString stringWithFormat:@"%@",[Utility compareCurrentTime:string]];
   // _timeLab.text = moment.create_time;
    CGFloat textW = [_timeLab.text boundingRectWithSize:CGSizeMake(200, kTimeLabelH)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_timeLab.font}
                                                context:nil].size.width;
//    if ([moment.location length]) {
//        _locationLab.hidden = NO;
//        _locationLab.text = moment.location;
//        _timeLab.frame = CGRectMake(_nameLab.left, _locationLab.bottom+kPaddingValue, textW, kTimeLabelH);
//    } else {
//        _locationLab.hidden = YES;
        _timeLab.frame = CGRectMake(_nameLab.left, bottom, textW, kTimeLabelH);
//    }
//    _deleteBtn.frame = CGRectMake(_timeLab.right + 25, _timeLab.top, 30, kTimeLabelH);
    bottom = _timeLab.bottom + kPaddingValue;
    // 操作视图
    
    _menuView.frame = CGRectMake(SCW - kOperateWidth - 10, _timeLab.top - (kOperateHeight-kTimeLabelH)/2, kOperateWidth, kOperateHeight);
    
    _menuView.show = NO;
    // 处理评论/赞
    _commentView.frame = CGRectZero;
    _bgImageView.frame = CGRectZero;
    _bgImageView.image = nil;
    [_commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 处理赞
    CGFloat top = 0;
    CGFloat width = SCW - kRightMargin - _nameLab.left;
    
    NSMutableArray * goodArray = [NSMutableArray array];
   if (moment.likeList.count > 0) {
       for (int i = 0; i < moment.likeList.count; i++) {
            RSLike * like = moment.likeList[i];
           if (i == 0) {
               [goodArray addObject:[NSString stringWithFormat:@"  %@",like.USER_NAME]];
           }else{
               [goodArray addObject:like.USER_NAME];
           }
       }
       
       NSString *goodTotalString = [goodArray componentsJoinedByString:@","];
       NSMutableAttributedString *newGoodString = [[NSMutableAttributedString alloc] initWithString:goodTotalString];
       //添加'赞'的图片
       NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
       textAttachment.image = [UIImage imageNamed:@"moment_like_hl"];
       textAttachment.bounds = CGRectMake(3, -3, textAttachment.image.size.width, textAttachment.image.size.height);
       NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:textAttachment];
       [newGoodString insertAttributedString:string atIndex:0];
       //设置行距 实际开发中间距为0太丑了，根据项目需求自己把握
       NSMutableParagraphStyle *paragraphstyle = [[NSMutableParagraphStyle alloc] init];
       paragraphstyle.lineSpacing = 3;
       [newGoodString addAttribute:NSParagraphStyleAttributeName value:paragraphstyle range:NSMakeRange(0, goodTotalString.length + string.length)];
       
       
       
       [newGoodString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, goodTotalString.length + string.length)];
       
       [newGoodString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithHexColorStr:@"#4C618E"] range:NSMakeRange(0, goodTotalString.length + string.length)];
       
       [newGoodString addAttribute:NSUnderlineStyleAttributeName
                             value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, goodTotalString.length + string.length)];
       
       UILabel * goodTextLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, kTextWidth, 21)];
       goodTextLbl.numberOfLines = 0;//设置UILable自适应
       goodTextLbl.attributedText = newGoodString;
       [_commentView addSubview:goodTextLbl];
       [goodTextLbl sizeToFit];
       
       [goodTextLbl onTapRangeActionWithString:goodArray tapClicked:^(NSString *string, NSRange range, NSInteger index) {
           RSLike * like = moment.likeList[index];
           if ([self.delegate respondsToSelector:@selector(didLikeContentTitleLike:)]) {
               [self.delegate didLikeContentTitleLike:like];
           }
       }];

       // 分割线
       UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, goodTextLbl.bottom + 7, width, 0.5)];
       line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
       [_commentView addSubview:line];
       top = goodTextLbl.height + 15;
   }else{
       top = 0;
   }
    // 处理评论
    NSInteger count = [moment.commentList count];
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CommentLabel *label = [[CommentLabel alloc] initWithFrame:CGRectMake(0, top, width, 0)];
            Comment * commen = [moment.commentList objectAtIndex:i];
            label.comment = commen;
            [label setDidClickText:^(Comment *comment) {
                if ([self.delegate respondsToSelector:@selector(didSelectComment:andMomentCell:)]) {
                    [self.delegate didSelectComment:comment andMomentCell:self];
                }
            }];
            [label setDidClickLinkText:^(MLLink *link, NSString *linkText, Comment *comment) {
            if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:andComment:andCell:)]) {
                        [self.delegate didClickLink:link linkText:linkText andComment:comment andCell:self];
                }
            }];
            [_commentView addSubview:label];
            // 更新
            top += label.height;
        }
    }
    // 更新UI
    if (top > 0) {
        _bgImageView.frame = CGRectMake(_nameLab.left, bottom, width, top + kArrowHeight);
        _bgImageView.image = [[UIImage imageNamed:@"评论框"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        _commentView.frame = CGRectMake(_nameLab.left, bottom + kArrowHeight, width, top);
        rowHeight = _commentView.bottom + kBlank;
    } else {
        rowHeight = _timeLab.bottom + kBlank;
    }
    _bottomview.frame = CGRectMake(0, rowHeight, SCW, 1);
    rowHeight = _bottomview.bottom;
    
    // 这样做就是起到缓存行高的作用，省去重复计算!!!
    _moment.rowHeight = rowHeight;
}

#pragma mark - 点击事件
// 查看全文/收起
- (void)fullTextClicked:(UIButton *)sender
{
    _showAllBtn.titleLabel.backgroundColor = kHLBgColor;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _showAllBtn.titleLabel.backgroundColor = [UIColor clearColor];
        _moment.isFullText = !_moment.isFullText;
        if ([self.delegate respondsToSelector:@selector(didSelectFullText:)]) {
            [self.delegate didSelectFullText:self];
        }
    });
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


// 删除动态
//- (void)deleteMoment:(UIButton *)sender
//{
//    _deleteBtn.titleLabel.backgroundColor = [UIColor lightGrayColor];
//    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
//    dispatch_after(when, dispatch_get_main_queue(), ^{
//        _deleteBtn.titleLabel.backgroundColor = [UIColor clearColor];
//        if ([self.delegate respondsToSelector:@selector(didDeleteMoment:)]) {
//            [self.delegate didDeleteMoment:self];
//        }
//    });
//}


- (CGSize)showBtnSize:(UIButton *)button{
    
    NSString *content = button.titleLabel.text;
    UIFont *font = button.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, 21.0f);
    CGSize buttonSize = [content boundingRectWithSize:size
                                              options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{ NSFontAttributeName:font}
                                              context:nil].size;
    return buttonSize;
}



#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    // 点击动态正文或者赞高亮
    if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:andComment:andCell:)]) {
        [self.delegate didClickLink:link linkText:linkText andComment:nil andCell:self];
    }
}
@end

#pragma mark - ------------------ 评论 ------------------
@implementation CommentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _linkLabel = kMLLinkLabel();
        _linkLabel.delegate = self;
        [self addSubview:_linkLabel];
    }
    return self;
}

#pragma mark - Setter
- (void)setComment:(Comment *)comment
{
    _comment = comment;
    _linkLabel.attributedText = kMLLinkLabelAttributedText(comment);
    CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
    _linkLabel.frame = CGRectMake(10, 3, attrStrSize.width, attrStrSize.height);
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
