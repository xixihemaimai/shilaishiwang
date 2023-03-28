//
//  RSMyRingHeaderview.m
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyRingHeaderview.h"

#import "RSMyRingCustomView.h"




@interface RSMyRingHeaderview ()<RSMyRingCustomViewDelegate>

{
   
    
    
    
    //内容
    UITextView * _textview;
    
 
}


@end


@implementation RSMyRingHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        //日
        UILabel * dayTimeLabel = [[UILabel alloc]init];
        dayTimeLabel.font = [UIFont systemFontOfSize:28];
        dayTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        dayTimeLabel.text = @"05";
        [self.contentView addSubview:dayTimeLabel];
        _dayTimeLabel = dayTimeLabel;
        //月
        UILabel * monthTimeLabel = [[UILabel alloc]init];
        
        monthTimeLabel.font = [UIFont systemFontOfSize:12];
        monthTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        monthTimeLabel.text = @"5月";
        [self.contentView addSubview:monthTimeLabel];
        _monthTimeLabel = monthTimeLabel;
        
        
        
        
        //这边是显示图片的view,这边想做一个自定义view,在从模型里面传图片的个数进去
        RSMyRingCustomView * view = [[RSMyRingCustomView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _view.userInteractionEnabled = YES;
        _view = view;
        
       
        
        
        
        UITextView * textview = [[UITextView alloc]init];
        textview.backgroundColor = [UIColor whiteColor];
        textview.editable = NO;
        textview.font = [UIFont systemFontOfSize:15];
        textview.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:textview];
        _textview = textview;
        
        
        UIImageView * weiImage = [[UIImageView alloc]init];
        weiImage.image = [UIImage imageNamed:@"内容违规"];
        [weiImage bringSubviewToFront:_textview];
       
        _weiImage.hidden = YES;
        [_textview addSubview:weiImage];
        _weiImage = weiImage;
        
         dayTimeLabel.sd_layout
         .leftSpaceToView(self.contentView,12)
         .topSpaceToView(self.contentView, 5)
         .heightIs(24)
         .widthIs(40);
         
         
        
        monthTimeLabel.sd_layout
        .leftSpaceToView(dayTimeLabel, -3)
        .topSpaceToView(dayTimeLabel, 16)
        .bottomEqualToView(dayTimeLabel)
        .widthIs(35);
        
        
        
        view.sd_layout
        .leftSpaceToView(monthTimeLabel, 10)
        .centerYEqualToView(self.contentView)
        .widthIs(75)
        .heightIs(75);
        
        
        
        
        
        textview.sd_layout
        .leftSpaceToView(view, 5)
        .topEqualToView(view)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0);
       
        
        
        
        weiImage.sd_layout
        .centerYEqualToView(_textview)
        .rightSpaceToView(_textview, 12)
        .widthIs(60)
        .heightIs(35);
        
        
        
        
        
    }
    
    return self;
    
    
}









- (void)setFriendmodel:(RSFriendModel *)friendmodel{
    
    
    
    _friendmodel = friendmodel;
    
    _textview.text = [NSString stringWithFormat:@"%@",friendmodel.content];
    _view.tag = friendmodel.index;
    
    
    if ([friendmodel.status isEqualToString:@"1"]) {
        _weiImage.hidden = YES;
        
    }else if ([friendmodel.status isEqualToString:@"2"]){
        _weiImage.hidden = NO;
    }
    
    //利用几个值来判断里面的值不一样
    //timeMark oweDay oweTimeMarkYear oweMonth
 
        //这边是显示文字处理
        if ([friendmodel.timeMark isEqualToString:@"0"]) {
            
            _dayTimeLabel.sd_layout
            .leftSpaceToView(self.contentView,12)
            .topSpaceToView(self.contentView, 5)
            .heightIs(30)
            .widthIs(60);
            
            _view.sd_layout
            .leftSpaceToView(_dayTimeLabel, 20);
            
            _dayTimeLabel.text = [NSString stringWithFormat:@"今天"];
   
            _monthTimeLabel.text = [NSString stringWithFormat:@"%@",friendmodel.month];
            _monthTimeLabel.hidden = YES;    
            
            
        }else if([friendmodel.timeMark isEqualToString:@"1"]){
            
            _dayTimeLabel.sd_layout
            .leftSpaceToView(self.contentView,12)
            .topSpaceToView(self.contentView, 5)
            .heightIs(30)
            .widthIs(60);
            
            _view.sd_layout
            .leftSpaceToView(_dayTimeLabel, 20);
            
            
            
            _dayTimeLabel.text = [NSString stringWithFormat:@"昨天"];
            _monthTimeLabel.text = [NSString stringWithFormat:@"%@",friendmodel.month];
            _monthTimeLabel.hidden = YES;
            
            
        }else if([friendmodel.timeMark isEqualToString:@"2"]){
            _dayTimeLabel.sd_layout
            .leftSpaceToView(self.contentView,12)
            .topSpaceToView(self.contentView, 5)
            .heightIs(30)
            .widthIs(60);
            
            _view.sd_layout
            .leftSpaceToView(_dayTimeLabel, 20);
            
            _dayTimeLabel.text = [NSString stringWithFormat:@"前天"];
            _monthTimeLabel.text = [NSString stringWithFormat:@"%@",friendmodel.month];
            _monthTimeLabel.hidden = YES;
            
            
            
            
            
        }else{
            if (friendmodel.day.length <= 1) {
                _dayTimeLabel.text = [NSString stringWithFormat:@"0%@",friendmodel.day];
            }else{
                _dayTimeLabel.text = [NSString stringWithFormat:@"%@",friendmodel.day];
            }
            _monthTimeLabel.text = [NSString stringWithFormat:@"%@月",friendmodel.month];

        }
        
        
    
    
    
    
        
    if ([friendmodel.viewType isEqualToString:@"video"]) {
        
        //这边是视频
        for (UIView *view in _view.subviews) {
            [view removeFromSuperview];
        }
        
        
        //friendmodel.index
        //friendmodel.cover
        
      
        _view.delegate = self;
        [_view addVideoURL:friendmodel.cover andViewType:friendmodel.viewType];
        
        
        
        
    }else if([friendmodel.viewType isEqualToString:@"picture"]){
        
        //这边是图片的
        if (friendmodel.photos.count < 1) {
            
            for (UIView *view in _view.subviews) {
                [view removeFromSuperview];
            }
            _textview.backgroundColor = [UIColor colorWithHexColorStr:@"F3F3F5"];
            
           
           
           CGSize size = [_textview.text boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
            
            
            _textview.sd_layout
            .leftSpaceToView(_monthTimeLabel, 26)
            .heightIs(size.height + 20);
            
            _view.sd_layout
            .heightIs(35);
            
            [_view addPictureAndNSArray:friendmodel.photos andContentStr:_textview.text];
            
            
        }else if(friendmodel.photos.count == 1){
            
            for (UIView *view in _view.subviews) {
                [view removeFromSuperview];
            }
            [_view addPictureAndNSArray:friendmodel.photos andContentStr:_textview.text];
            
        }else if (friendmodel.photos.count == 2){
            for (UIView *view in _view.subviews) {
                [view removeFromSuperview];
            }
            [_view addPictureAndNSArray:friendmodel.photos andContentStr:_textview.text];
            
        }else if (friendmodel.photos.count == 3){
            for (UIView *view in _view.subviews) {
                [view removeFromSuperview];
            }
            [_view addPictureAndNSArray:friendmodel.photos andContentStr:_textview.text];
        }else{
            
            for (UIView *view in _view.subviews) {
                [view removeFromSuperview];
            }
            [_view addPictureAndNSArray:friendmodel.photos andContentStr:_textview.text];
        }
        
    }else{
        
        _textview.backgroundColor = [UIColor colorWithHexColorStr:@"F3F3F5"];
        CGSize size = [_textview.text boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
        _textview.sd_layout
        .leftSpaceToView(_monthTimeLabel, 26)
        .heightIs(size.height + 20);
        
        _view.sd_layout
        .heightIs(35);
        
         [_view addPictureAndNSArray:friendmodel.photos andContentStr:_textview.text];
    }
}


- (void)playSelectVideo:(NSInteger)index{
    //myRingPlaySelectVideoIndex
    if ([self.delegate respondsToSelector:@selector(myRingPlaySelectVideoIndex:)]) {
        [self.delegate myRingPlaySelectVideoIndex:index];
    }
}



- (void)setMyModel:(RSMyRingModel *)myModel{
    _myModel = myModel;
}


@end
