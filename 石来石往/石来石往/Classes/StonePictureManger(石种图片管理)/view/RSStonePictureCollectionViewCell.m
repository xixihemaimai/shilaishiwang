//
//  RSStonePictureCollectionViewCell.m
//  石来石往
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSStonePictureCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation RSStonePictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView * addImage = [[UIImageView alloc]init];
        //[addbtn setBackgroundColor:[UIColor yellowColor]];
        addImage.userInteractionEnabled = YES;
        addImage.contentMode = UIViewContentModeScaleToFill;
        _addImage = addImage;
        
        [self.contentView addSubview:addImage];
        
        
    
         self.addImage.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        UIImageView *  adoptImage = [[UIImageView alloc]init];
        adoptImage.image = [UIImage imageNamed:@"审核-通过"];
        [adoptImage bringSubviewToFront:self.contentView];
        [self.contentView addSubview:adoptImage];
        _adoptImage = adoptImage;
        
        
        
       
        
        
        
        
        
       UILabel * noLabel = [[UILabel alloc]init];
        _noLabel = noLabel;
        
        
        noLabel.font = [UIFont systemFontOfSize:15];
        noLabel.hidden = NO;
        noLabel.textAlignment = NSTextAlignmentCenter;
        [noLabel bringSubviewToFront:self.contentView];
        [self.addImage addSubview:noLabel];
        
        
        UILabel * secondNoLabel = [[UILabel alloc]init];
        
        _secondNoLabel = secondNoLabel;
        secondNoLabel.font = [UIFont systemFontOfSize:15];
        secondNoLabel.hidden = NO;
        secondNoLabel.textAlignment = NSTextAlignmentCenter;
        [secondNoLabel bringSubviewToFront:self.contentView];
        [self.addImage addSubview:secondNoLabel];
        
        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn = deleteBtn;
        [deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        [deleteBtn bringSubviewToFront:self.contentView];
        [deleteBtn addTarget:self action:@selector(deleteShowPicture:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:deleteBtn];
    
        
        
        
        adoptImage.sd_layout
        .centerXEqualToView(self.contentView)
        .centerYEqualToView(self.contentView)
        .widthRatioToView(self.contentView, 0.5)
        .heightRatioToView(self.contentView ,0.5);
        
        
        
        
        self.deleteBtn.sd_layout
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .widthIs(20)
        .heightIs(20);
        
        
        
        self.noLabel.sd_layout
        .centerYEqualToView(self.addImage)
        .centerXEqualToView(self.addImage)
        .leftSpaceToView(self.addImage, 0)
        .rightSpaceToView(self.addImage, 0)
        .heightIs(14);
        
        
        self.secondNoLabel.sd_layout
        .leftSpaceToView(self.addImage, 0)
        .rightSpaceToView(self.addImage, 0)
        .topSpaceToView(noLabel, 7)
        .heightIs(14);
        
        
        
        
        
    }
    
    
    return self;
}


- (void)setStoneImagemodel:(RSStoneImageModel *)stoneImagemodel{
    _stoneImagemodel = stoneImagemodel;
    
    if (stoneImagemodel.checkStatus == 0) {
        self.noLabel.hidden = YES;
        self.secondNoLabel.hidden = NO;
        self.secondNoLabel.text = @"图片审核中";
        self.noLabel.textColor = [UIColor orangeColor];
        self.secondNoLabel.textColor = [UIColor orangeColor];
        self.adoptImage.hidden = YES;
    }else  if (stoneImagemodel.checkStatus == 1) {
        self.noLabel.hidden = YES;
        self.adoptImage.hidden = NO;
        self.secondNoLabel.hidden = YES;
    }else if (stoneImagemodel.checkStatus == 2){
        self.noLabel.hidden = NO;
        self.noLabel.text =@"重新添加图片";
        self.secondNoLabel.hidden = NO;
        self.secondNoLabel.text =@"审核不通过";
        self.adoptImage.hidden = YES;
        self.noLabel.textColor = [UIColor colorWithHexColorStr:@"#ff0000"];
        self.secondNoLabel.textColor = [UIColor colorWithHexColorStr:@"#ff0000"];
        
    }
    
    [self.addImage sd_setImageWithURL:[NSURL URLWithString:stoneImagemodel.url] placeholderImage:[UIImage imageNamed:@"正确4"]];
    
    
}





- (void)deleteShowPicture:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(deleteShowPicturestonePicturecell:)]) {
        [self.delegate deleteShowPicturestonePicturecell:self];
    }
    
}


@end
