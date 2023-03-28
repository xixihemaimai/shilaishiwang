//
//  RSCLSelectCenterCell.m
//  石来石往
//
//  Created by mac on 2022/8/17.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSCLSelectCenterCell.h"

@interface RSCLSelectCenterCell()

@property (nonatomic,strong)UIImageView * clSelectCenterImage;

@property (nonatomic,strong)UILabel * companyLabel;




@end

@implementation RSCLSelectCenterCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _clSelectCenterImage = [[UIImageView alloc]init];
        _clSelectCenterImage.image = [UIImage imageNamed:@"背景"];
        [self.contentView addSubview:_clSelectCenterImage];
        
        _clSelectCenterImage.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, Width_Real(16)).widthIs(Width_Real(109)).heightIs(Width_Real(73));
        
        _clSelectCenterImage.layer.cornerRadius = Width_Real(4);
        _clSelectCenterImage.layer.masksToBounds = true;
        
        _companyLabel = [[UILabel alloc]init];
        _companyLabel.text = @"海西石材城";
        _companyLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        _companyLabel.font = [UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightMedium];
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_companyLabel];
        
        _companyLabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(_clSelectCenterImage, 12).heightIs(Width_Real(22.5)).rightSpaceToView(self.contentView, 100);
        
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"删除-(4)"] forState:UIControlStateNormal];
        [self.contentView addSubview:_deleteBtn];
        
        _deleteBtn.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 13).widthIs(Width_Real(35)).heightEqualToWidth();
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
        [self.contentView addSubview:midView];
        
        midView.sd_layout.rightSpaceToView(self.contentView, 0).heightIs(Width_Real(0.5)).leftSpaceToView(_clSelectCenterImage, Width_Real(1)).bottomSpaceToView(self.contentView, 0);
        
        
        
    }
    return self;
}


- (void)setModel:(RSCLSelectionModel *)model{
    _model = model;
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    [_clSelectCenterImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_model.logo]] placeholderImage:[UIImage imageNamed:@"背景"]];
    _companyLabel.text = _model.name;
    
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
