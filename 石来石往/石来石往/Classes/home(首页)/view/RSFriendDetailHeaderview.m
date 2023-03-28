//
//  RSFriendDetailHeaderview.m
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFriendDetailHeaderview.h"

@implementation RSFriendDetailHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        
        
        
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        [self.contentView addSubview:view];
        
        
        
        
        
        //评论
        UIButton * commentNumBtn = [[UIButton alloc]init];
        //commentNumBtn settextColor = [UIColor blackColor];
       // [commentNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //commentNumBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
         commentNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        commentNumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:commentNumBtn];
        
        _commentNumBtn = commentNumBtn;
        //赞
        UIButton * likeNumBtn = [[UIButton alloc]init];
        //likeNumBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        likeNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        likeNumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //likeNumBtn.textColor = [UIColor blackColor];
    //    [likeNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:likeNumBtn];
        
        _likeNumBtn = likeNumBtn;
        
        
        
        
        
    
        
        
//        UIView * bottomview = [[UIView alloc]init];
//        bottomview.backgroundColor = [UIColor redColor];
//        [self.contentView addSubview:bottomview];
//        _bottomview = bottomview;
        
        
        
        view.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .heightIs(10);
        
        
        
        likeNumBtn.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(view, 0)
        .bottomSpaceToView(self.contentView, 4)
        .widthIs(SCW/2 - 12);
        
        
        
        commentNumBtn.sd_layout
        .leftSpaceToView(likeNumBtn, 0)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(view, 0)
        .bottomSpaceToView(self.contentView, 4);
        
        
        
        
//        bottomview.sd_layout
//        .rightEqualToView(commentNumBtn)
//        .topSpaceToView(commentNumBtn, -5)
//        .heightIs(2)
//        .widthIs(40);
        
        
        
        

    }
    
    return self;
}

@end
