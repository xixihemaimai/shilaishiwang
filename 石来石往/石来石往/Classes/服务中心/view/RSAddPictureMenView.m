//
//  RSAddPictureMenView.m
//  石来石往
//
//  Created by mac on 2018/3/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAddPictureMenView.h"



@implementation RSAddPictureMenView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        
        //添加图片的view
        UIView * upLoadPictureView = [[UIView alloc]init];
        upLoadPictureView.backgroundColor = [UIColor whiteColor];
        [self addSubview:upLoadPictureView];
        
        //添加图片label
        UILabel * uploadLabel = [[UILabel alloc]init];
        uploadLabel.text = @"添加图片,并上传图片";
        uploadLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        uploadLabel.font = [UIFont systemFontOfSize:18];
        uploadLabel.textAlignment = NSTextAlignmentCenter;
        [upLoadPictureView addSubview:uploadLabel];
        
        //添加图片的view
        UIView * addPictureView = [[UIView alloc]init];
        addPictureView.backgroundColor = [UIColor clearColor];
        addPictureView.layer.cornerRadius = 5;
        addPictureView.layer.borderWidth = 1;
        addPictureView.layer.borderColor = [UIColor colorWithHexColorStr:@"#f9f9f9"].CGColor;
        addPictureView.layer.masksToBounds = YES;
        [upLoadPictureView addSubview:addPictureView];
        _addPictureView = addPictureView;
        
        //添加图片的按键
        UIButton * addPictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //_addPic.frame = CGRectMake(0, 0, 62.5, 62.5);
        [addPictureBtn setImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
        //[addPictureBtn addTarget:self action:@selector(addServicePicture:) forControlEvents:UIControlEventTouchUpInside];
        [addPictureView addSubview:addPictureBtn];
        _addPictureBtn = addPictureBtn;
        
        
        //上传按键
//        UIButton * uploadBtn = [[UIButton alloc]init];
//        [uploadBtn setTitle:@"上传图片" forState:UIControlStateNormal];
//        [uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        uploadBtn.layer.cornerRadius = 5;
//        uploadBtn.layer.masksToBounds = YES;
//        [uploadBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
//        uploadBtn.enabled = NO;
//        uploadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [upLoadPictureView addSubview:uploadBtn];
//        _uploadBtn = uploadBtn;
        
        upLoadPictureView.sd_layout
        .centerYEqualToView(self)
        .centerXEqualToView(self)
        .leftSpaceToView(self, 20)
        .rightSpaceToView(self, 20)
        .heightIs(190);
        
        
        upLoadPictureView.layer.cornerRadius = 5;
        upLoadPictureView.layer.masksToBounds = YES;
        
        uploadLabel.sd_layout
        .leftSpaceToView(upLoadPictureView, 12)
        .rightSpaceToView(upLoadPictureView, 12)
        .topSpaceToView(upLoadPictureView, 10)
        .heightIs(15);
        
        
        addPictureView.sd_layout
        .leftEqualToView(uploadLabel)
        .rightEqualToView(uploadLabel)
        .topSpaceToView(uploadLabel, 30)
        .heightIs(80);
        
        addPictureBtn.sd_layout
        .centerYEqualToView(addPictureView)
        .leftSpaceToView(addPictureView, 12)
        .widthIs(62.5)
        .heightIs(62.5);
        
//        uploadBtn.sd_layout
//        .leftEqualToView(addPictureView)
//        .rightEqualToView(addPictureView)
//        .topSpaceToView(addPictureView, 15)
//        .heightIs(45);
        
        
    }
    return self;
}


@end
