//
//  RSInformationCell.m
//  石来石往
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSInformationCell.h"


@interface RSInformationCell ()

{
    
    UILabel * _firstLabel;
    
    UILabel * _firstdateLabel;
    
    UILabel * _secondLabel;
    
    UILabel * _seconddateLabel;
    
    
    UILabel * _thirdLabel;
    
    UILabel * _thirddateLabel;
    
}

@end

@implementation RSInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //总显示的view
        UIView * xinView = [[UIView alloc]init];
        xinView.userInteractionEnabled = YES;
        xinView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:xinView];
        xinView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .heightIs(107.5);
        
        
        
        
        //要显示的View
        UIView * midView = [[UIView alloc]init];
        midView.userInteractionEnabled = YES;
        midView.layer.cornerRadius = 5;
        midView.layer.masksToBounds = YES;
        midView.layer.borderWidth = 1;
        midView.layer.borderColor = [UIColor colorWithHexColorStr:@"8fbcfe"].CGColor;
        midView.backgroundColor = [UIColor whiteColor];
        
        [xinView addSubview:midView];
        midView.sd_layout
        .leftSpaceToView(xinView,12)
        .rightSpaceToView(xinView,12)
        .topSpaceToView(xinView, 0)
        .heightIs(100);
        
        //第一个蓝色的view
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"3385ff"];
        [midView addSubview:showView];
        
        showView.sd_layout
        .leftSpaceToView(midView, 0)
        .rightSpaceToView(midView, 0)
        .topSpaceToView(midView, 0)
        .heightIs(25);
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"信息标题";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor whiteColor];
        [showView addSubview:titleLabel];
        
        UILabel * dateLabel = [[UILabel alloc]init];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.text = @"发布时间";
        [showView addSubview:dateLabel];
        
        
       
        
        
        titleLabel.sd_layout
        .leftSpaceToView(showView,20)
        .topSpaceToView(showView,0)
        .bottomSpaceToView(showView,0)
        .widthIs((SCW/2)/2);
        
        dateLabel.sd_layout
        .leftSpaceToView(titleLabel,60)
        .rightSpaceToView(showView,20)
        .widthIs((SCW/2)/2)
        .topSpaceToView(showView,0)
        .bottomSpaceToView(showView,0);
        
        //第一组的显示的内容
        
       
        
        
        
        
        UIView * firstview = [[UIView alloc]init];
        firstview.tag =  2000;
        firstview.userInteractionEnabled = YES;
        firstview.backgroundColor = [UIColor whiteColor];
        [midView addSubview:firstview];
        
        firstview.sd_layout
        .topSpaceToView(showView, 0)
        .leftSpaceToView(midView, 0)
        .rightSpaceToView(midView, 0)
        .heightIs(25);
        
       //  UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceCell:)];
        //[firstview addGestureRecognizer:tap1];
        
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"img_trumpet"];
        [firstview addSubview:imageview];
        
        
        imageview.sd_layout
        .leftSpaceToView(firstview,5)
        .centerYEqualToView(firstview)
        .heightIs(10)
        .widthIs(15);
        
        UILabel *firstLabel = [[UILabel alloc]init];
        firstLabel.font = [UIFont systemFontOfSize:10];
        firstLabel.textAlignment = NSTextAlignmentLeft;
        firstLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        firstLabel.text = @"石来石往上线了";
        [firstview addSubview:firstLabel];
        _firstLabel = firstLabel;
        


        UILabel *firstdateLabel = [[UILabel alloc]init];
        firstdateLabel.text = @"2017-05-19 18:00";
        firstdateLabel.textAlignment = NSTextAlignmentRight;
        firstdateLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        firstdateLabel.font = [UIFont systemFontOfSize:10];
        [firstview addSubview:firstdateLabel];
        _firstdateLabel = firstdateLabel;
        
        
        UILabel  * firstBottomLabel = [[UILabel alloc]init];
        firstBottomLabel.text = @"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
        firstBottomLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        
        
        
//        firstBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        [firstview addSubview:firstBottomLabel];
        

        firstLabel.sd_layout
        .leftSpaceToView(imageview,5)
        .centerYEqualToView(firstview)
        .heightIs(10)
        .widthIs(120);
        
        
        
        firstdateLabel.sd_layout
        .leftSpaceToView(firstLabel,10)
        .rightSpaceToView(firstview,10)
        .centerYEqualToView(firstview)
        .heightIs(10);
        
        
        
        firstBottomLabel.sd_layout
        .leftSpaceToView(firstview, 12)
        .rightSpaceToView(firstview, 12)
        .bottomSpaceToView(firstview, 0)
        .heightIs(3);
        
        
        //第二组显示内容
        
        UIView * secondview = [[UIView alloc]init];
        secondview.tag = 2001;
        secondview.userInteractionEnabled = YES;
        secondview.backgroundColor = [UIColor whiteColor];
        [midView addSubview:secondview];
        
        secondview.sd_layout
        .topSpaceToView(firstview, 0)
        .leftSpaceToView(midView, 0)
        .rightSpaceToView(midView, 0)
        .heightIs(25);
        
        
        //UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceCell1:)];
        //[secondview addGestureRecognizer:tap2];
        
        
        
        UIImageView *secondimageview = [[UIImageView alloc]init];
        secondimageview.image = [UIImage imageNamed:@"img_trumpet"];
        [secondview addSubview:secondimageview];
        
        
        secondimageview.sd_layout
        .leftSpaceToView(secondview,5)
        .centerYEqualToView(secondview)
        .heightIs(10)
        .widthIs(15);
        
    
        UILabel *secondLabel = [[UILabel alloc]init];
        _secondLabel = secondLabel;
        secondLabel.font = [UIFont systemFontOfSize:10];
        secondLabel.textAlignment = NSTextAlignmentLeft;
        secondLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        secondLabel.text = @"石来石往上线了";
        [secondview addSubview:secondLabel];
        //_firstLabel = firstLabel;
        
        
        
        UILabel *seconddateLabel = [[UILabel alloc]init];
        _seconddateLabel = seconddateLabel;
        seconddateLabel.text = @"2017-05-19 18:00";
        seconddateLabel.textAlignment = NSTextAlignmentRight;
        seconddateLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        seconddateLabel.font = [UIFont systemFontOfSize:10];
        [secondview addSubview:seconddateLabel];
        //_firstdateLabel = firstdateLabel;
        
        
        UILabel  * secondeBottomLabel = [[UILabel alloc]init];
        secondeBottomLabel.text = @"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
        secondeBottomLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        [secondview addSubview:secondeBottomLabel];
        
        
        secondLabel.sd_layout
        .leftSpaceToView(secondimageview,5)
        .centerYEqualToView(secondview)
        .heightIs(10)
        .widthIs(120);
        
        
        
        seconddateLabel.sd_layout
        .leftSpaceToView(secondLabel,10)
        .rightSpaceToView(secondview,10)
        .centerYEqualToView(secondview)
        .heightIs(10);
        
        secondeBottomLabel.sd_layout
        .leftSpaceToView(secondview, 12)
        .rightSpaceToView(secondview, 12)
        .bottomSpaceToView(secondview, 0)
        .heightIs(3);
        
        
        //第三组
        
        UIView * thirdview = [[UIView alloc]init];
        thirdview.tag = 2002;
        thirdview.userInteractionEnabled = YES;
        thirdview.backgroundColor = [UIColor whiteColor];
        [midView addSubview:thirdview];
        
        thirdview.sd_layout
        .topSpaceToView(secondview, 0)
        .leftSpaceToView(midView, 0)
        .rightSpaceToView(midView, 0)
        .heightIs(25);
        
        
       // UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceCell2:)];
        //[thirdview addGestureRecognizer:tap3];
        
        UIImageView *thirdimageview = [[UIImageView alloc]init];
        thirdimageview.image = [UIImage imageNamed:@"img_trumpet"];
        [thirdview addSubview:thirdimageview];
        
        
        thirdimageview.sd_layout
        .leftSpaceToView(thirdview,5)
        .centerYEqualToView(thirdview)
        .heightIs(10)
        .widthIs(15);
        
        UILabel *thirdLabel = [[UILabel alloc]init];
        _thirdLabel = thirdLabel;
        thirdLabel.font = [UIFont systemFontOfSize:10];
        thirdLabel.textAlignment = NSTextAlignmentLeft;
        thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        thirdLabel.text = @"石来石往上线了";
        [thirdview addSubview:thirdLabel];
        //_firstLabel = firstLabel;
        
        
        
        UILabel *thirddateLabel = [[UILabel alloc]init];
        _thirddateLabel = thirddateLabel;
        thirddateLabel.text = @"2017-05-19 18:00";
        thirddateLabel.textAlignment = NSTextAlignmentRight;
        thirddateLabel.textColor = [UIColor colorWithHexColorStr:@"#8fbcfe"];
        thirddateLabel.font = [UIFont systemFontOfSize:10];
        [thirdview addSubview:thirddateLabel];
        //_firstdateLabel = firstdateLabel;
        
        thirdLabel.sd_layout
        .leftSpaceToView(thirdimageview,5)
        .centerYEqualToView(thirdview)
        .heightIs(10)
        .widthIs(120);
        
        
        
        thirddateLabel.sd_layout
        .leftSpaceToView(thirdLabel,10)
        .rightSpaceToView(thirdview,10)
        .centerYEqualToView(thirdview)
        .heightIs(10);
        

    }
    return self;
}


- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    
    for (int i = 0;i < dataArray.count ; i++) {
        
        RSInformationModel * informationModel = [_dataArray objectAtIndex:i];
        if (i == 0) {
            _firstLabel.text = [NSString stringWithFormat:@"%@",informationModel.title];
            _firstdateLabel.text = [NSString stringWithFormat:@"%@",informationModel.publishTime];
        }else if (i == 1){
            _secondLabel.text = [NSString stringWithFormat:@"%@",informationModel.title];
            _seconddateLabel.text = [NSString stringWithFormat:@"%@",informationModel.publishTime];
        }else if (i == 2){
            _thirdLabel.text = [NSString stringWithFormat:@"%@",informationModel.title];
            _thirddateLabel.text = [NSString stringWithFormat:@"%@",informationModel.publishTime];
        }
    }
}


/*
#pragma mark -- 选中哪个数组
- (void)choiceCell:(UITapGestureRecognizer *)tap{
   
    
    if ([self.delegate respondsToSelector:@selector(sendH5Url:)]) {
        RSInformationModel * informationModel = _dataArray[0];
        
        [self.delegate sendH5Url:informationModel.url];
    }
    
}


#pragma mark -- 选中哪个数组
- (void)choiceCell1:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(sendH5Url:)]) {
        RSInformationModel * informationModel = _dataArray[1];
        
        [self.delegate sendH5Url:informationModel.url];
    }
    
    
}

#pragma mark -- 选中哪个数组
- (void)choiceCell2:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(sendH5Url:)]) {
        RSInformationModel * informationModel = _dataArray[2];
        
        [self.delegate sendH5Url:informationModel.url];
    }
    
    
}

*/
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
