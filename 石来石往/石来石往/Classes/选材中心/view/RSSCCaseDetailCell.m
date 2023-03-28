//
//  RSSCCaseDetailCell.m
//  石来石往
//
//  Created by mac on 2021/12/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCCaseDetailCell.h"

@interface RSSCCaseDetailCell()


@end

@implementation RSSCCaseDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView * showImage = [[UIImageView alloc]init];
        showImage.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:showImage];
        showImage.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).rightSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(self.contentView, Height_Real(10)).bottomSpaceToView(self.contentView, Height_Real(10));
        
        showImage.contentMode = UIViewContentModeScaleAspectFill;
        showImage.layer.cornerRadius = Width_Real(4);
        showImage.layer.masksToBounds = YES;
        
        _showImage = showImage;
        
    }
    return self;
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
