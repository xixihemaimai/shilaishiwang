//
//  RSStockCell.m
//  石来石往
//
//  Created by mac on 17/5/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSStockCell.h"


@interface RSStockCell ()

@property (nonatomic,strong)NSArray *imageArray;


@property (nonatomic,strong)NSArray *textArray;
@end

@implementation RSStockCell

- (NSArray *)imageArray{
    if (_imageArray == nil) {
        //@"结算中心" ,@"等级评定"
        //,@" 补充切图 copy 35备份1001",@" 补充切图 copy 35备份1002"
        _imageArray = @[@"荒料出库",@"大板出库",@"报表中心",@"出库记录",@" 补充切图 copy 28",@" 补充切图 copy 17复制",@" 补充切图 copy 10复制",@"意见反馈"];
    }
    return _imageArray;
}

- (NSArray *)textArray{
    if (_textArray == nil) {
        //,@"账单付款",@"财务付款"
        _textArray = @[@"荒料出库",@"大板出库",@"报表中心",@"出库记录",@"服务中心",@"石种图片上传",@"工程案例",@"市场投诉"];
    }
    return _textArray;
}
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
        
        self.contentView.backgroundColor =  [UIColor colorWithHexColorStr:@"#f9f9f9"];
        
        
        CGFloat margin = 1;
        NSInteger event = 2;
        //CGFloat count = 4/2;
        CGFloat btnW = (SCW - (event+1)*margin)/event;
        CGFloat btnH = 0.0;
        if (iPhone4 || iPhone5 || iPhone6) {
             btnH = 72;
        }else{
            btnH = 92;
        }
        
        //6
        for (int i = 0; i < 8; i++) {
            UIButton *btn = [[UIButton alloc]init];
            //self.view = view;
            btn.tag = 10000+i;
           // btn.userInteractionEnabled = YES;
            btn.backgroundColor = [UIColor whiteColor];
            NSInteger row = i / event;
            CGFloat btnY = margin + row *(btnH + margin);
            NSInteger colom = i % event;
            CGFloat btnX = margin + colom * (btnW  + margin);
            btn.frame =CGRectMake(btnX, btnY, btnW, btnH);
            [btn addTarget:self action:@selector(choiceButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self addCustomWithContentCell:btn andIndex:i];
        }
    }
    
    return self;
}

- (void)addCustomWithContentCell:(UIButton *)btn andIndex:(NSInteger)index{
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:self.imageArray[index]];
    [btn addSubview:imageview];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = self.textArray[index];
    label.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    label.font = [UIFont systemFontOfSize:15];
    [btn addSubview:label];
    
    imageview.sd_layout
    .centerYEqualToView(btn)
    .leftSpaceToView(btn,30)
    .widthIs(37)
    .heightIs(37);
    
    label.sd_layout
    .centerYEqualToView(btn)
    .leftSpaceToView(imageview,10)
    .widthRatioToView(btn,0.5)
    .heightIs(35);
    

}





//点击为来进行跳转不同的界面
- (void)choiceButton:(UIButton *)btn{

    [btn setBackgroundImage:[UIImage imageNamed:@"矩形-4"] forState:UIControlStateHighlighted];
    //cell代理
    if ([self.delegate respondsToSelector:@selector(choiceNeedButton:)]) {
        [self.delegate choiceNeedButton:btn];
    }
    
    
}



@end
