//
//  RSDriverInformationCell.m
//  石来石往
//
//  Created by mac on 17/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDriverInformationCell.h"
#import "RSCustomButton.h"


@interface RSDriverInformationCell()


@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)UILabel * identityLabel;

@property (nonatomic,strong)UILabel * carCordLabel;

@property (nonatomic,strong)UILabel *phoneNumberLabel;

@end

@implementation RSDriverInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
        
        
//        UIView *contentview = [[UIView alloc]init];
//        contentview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
//        [self addSubview:contentview];
        
//        contentview.sd_layout
//        .leftSpaceToView(self,0)
//        .rightSpaceToView(self,0)
//        .topSpaceToView(self,0)
//        .bottomSpaceToView(self,0);
        
        
        UIView *headerview = [[UIView alloc]init];
        headerview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:headerview];
        
        headerview.sd_layout
        .leftSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(80);
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [headerview addSubview:nameLabel];
        _nameLabel = nameLabel;
        
//        UILabel * identityLabel = [[UILabel alloc]init];
//        identityLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        identityLabel.font = [UIFont systemFontOfSize:14];
//        [headerview addSubview:identityLabel];
//        _identityLabel = identityLabel;
        
//        UILabel * carCordLabel = [[UILabel alloc]init];
//        carCordLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        carCordLabel.font = [UIFont systemFontOfSize:14];
//        [headerview addSubview:carCordLabel];
//        _carCordLabel = carCordLabel;
        
        UILabel *phoneNumberLabel = [[UILabel alloc]init];
        phoneNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        phoneNumberLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:phoneNumberLabel];
        _phoneNumberLabel = phoneNumberLabel;
        phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
        
        UIView * fenview = [[UIView alloc]init];
        fenview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
        [headerview addSubview:fenview];
        
        nameLabel.sd_layout
        .leftSpaceToView(headerview,12)
        .topSpaceToView(headerview,13)
        .rightSpaceToView(headerview, 12)
        .heightIs(20);
        
        phoneNumberLabel.sd_layout
        .leftEqualToView(nameLabel)
        .rightEqualToView(nameLabel)
        .topSpaceToView(nameLabel, 13)
        .bottomSpaceToView(headerview, 13);
      
        
        
        
//        identityLabel.sd_layout
//        .leftEqualToView(nameLabel)
//        .topSpaceToView(nameLabel,10)
//        .widthRatioToView(headerview,0.7)
//        .heightIs(20);
        
        
//        carCordLabel.sd_layout
//        .topSpaceToView(identityLabel,10)
//        .leftEqualToView(identityLabel)
//        .widthRatioToView(headerview,0.7)
//        .bottomSpaceToView(headerview,10);
        
        fenview.sd_layout
        .leftSpaceToView(headerview,10)
        .rightSpaceToView(headerview,10)
        .bottomSpaceToView(headerview,0)
        .heightIs(1);
        
        UIView *  editview = [[UIView alloc]init];
        editview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:editview];
        _editview = editview;
        
        
        editview.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .topSpaceToView(headerview,0)
        .heightIs(33.5);
        
//        RSCustomButton *editBtn = [RSCustomButton buttonWithType:UIButtonTypeSystem];
//        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        [editBtn setImage:[UIImage imageNamed:@"k3"] forState:UIControlStateNormal];
//       // editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [editBtn setTintColor:[UIColor colorWithHexColorStr:@"#666666"]];
//        [editview addSubview:editBtn];
//        _editBtn = editBtn;
        
        
        RSCustomButton * removeBtn = [RSCustomButton buttonWithType:UIButtonTypeSystem];
        [removeBtn setTitle:@"删除" forState:UIControlStateNormal];
        [removeBtn setImage:[UIImage imageNamed:@"k4"] forState:UIControlStateNormal];
        //removeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        removeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [removeBtn setTintColor:[UIColor colorWithHexColorStr:@"#666666"]];
        _removeBtn = removeBtn;
        [editview addSubview:removeBtn];
        
        removeBtn.sd_layout
        .centerYEqualToView(editview)
        .rightSpaceToView(editview,12)
        .topSpaceToView(editview,10)
        .bottomSpaceToView(editview,10)
        .widthIs(60);
        
        
        
//        editBtn.sd_layout
//        .centerYEqualToView(editview)
//        .topEqualToView(removeBtn)
//        .bottomEqualToView(removeBtn)
//        .rightSpaceToView(removeBtn,5)
//        .widthIs(60);
        
        
    }
    return self;
}

- (void)setContact:(RSDirverContact *)contact{
    _contact = contact;
    
    _nameLabel.text = [NSString stringWithFormat:@"提货人:%@",contact.csnName];
    _phoneNumberLabel.text = [NSString stringWithFormat:@"电话号码:%@",contact.csnPhone];
    //_identityLabel.text = [NSString stringWithFormat:@"身份证号码:%@",contact.idCard];
    //_carCordLabel.text = [NSString stringWithFormat:@"车牌号:%@",contact.license];
    
    
    
    
}





@end
