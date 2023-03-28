//
//  RSDetailChoiceCell.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDetailChoiceCell.h"
#import "RSFilmView.h"
#import "RSTurnsCountModel.h"
@interface RSDetailChoiceCell()


/**匝号*/
@property (nonatomic,strong)UILabel * turnsLabel;

/**片号*/
@property (nonatomic,strong)UILabel *filmNumberLabel;


/**主要是用来对IOS11出现选中的片数错误的处理*/
@property (nonatomic,assign)NSInteger countMark;


@property (nonatomic,assign)NSInteger count;

@end


//static NSInteger count = 0;
@implementation RSDetailChoiceCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //匝号
        UILabel * turnsLabel = [[UILabel alloc]init];
        turnsLabel.text = @"匝号";
        turnsLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        turnsLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:turnsLabel];
        _turnsLabel = turnsLabel;
        turnsLabel.sd_layout
        .leftSpaceToView(self.contentView,12)
        .topSpaceToView(self.contentView,12)
        .heightIs(20)
        .widthIs(40);
        
        
        UIButton * turnsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        turnsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [turnsBtn addTarget:self action:@selector(ChoiceTurnsCount:) forControlEvents:UIControlEventTouchUpInside];
        [turnsBtn setTitle:@"6-1" forState:UIControlStateNormal];
         [turnsBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f5f5f5"]];
        [turnsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[turnsBtn setBackgroundColor:[UIColor yellowColor]];
//        turnsBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        turnsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _turnsBtn = turnsBtn;
        turnsBtn.layer.cornerRadius = 2;
        turnsBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:turnsBtn];
   
        turnsBtn.sd_layout
        .leftSpaceToView(turnsLabel,19.5)
        .topEqualToView(turnsLabel)
        .bottomEqualToView(turnsLabel)
        .widthIs(150);
        
        //片号
        UILabel *filmNumberLabel = [[UILabel alloc]init];
        filmNumberLabel.text = @"片号";
        filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        filmNumberLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:filmNumberLabel];
        _filmNumberLabel = filmNumberLabel;
        filmNumberLabel.sd_layout
        .leftSpaceToView(self.contentView,12)
        .topSpaceToView(turnsLabel,12)
        .rightEqualToView(turnsLabel)
        .heightIs(20);
        
        
        //用来设置九宫格
        RSFilmView *filmview = [[RSFilmView alloc]init];
        _filmview = filmview;
        [self.contentView addSubview:filmview];
        filmview.sd_layout
//        .topEqualToView(filmNumberLabel)
        .topSpaceToView(turnsLabel, 4.5)
        .leftSpaceToView(filmNumberLabel,12)
        .rightSpaceToView(self.contentView,12)
        .heightIs(0);
        
        
        
        UILabel * bottomLabel = [[UILabel alloc]init];
        bottomLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomLabel];
        
        bottomLabel.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .topSpaceToView(filmview,0)
        .heightIs(1);

    }
    return self;
 
}

- (void)setTurnsModel:(RSTurnsCountModel *)turnsModel{
    
    _turnsModel = turnsModel;
    
    [_turnsBtn setTitle:[NSString stringWithFormat:@"%@",turnsModel.turnsID] forState:UIControlStateNormal];
    
    CGSize size = CGSizeMake(SCW - 70 , MAXFLOAT);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:_turnsBtn.titleLabel.font, NSFontAttributeName,nil];
    CGRect textFrame = [_turnsBtn.currentTitle boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesDeviceMetrics attributes:dic context:nil];
    _turnsBtn.sd_layout.widthIs(textFrame.size.width + 10);
    
    if (turnsModel.turnsStatus == 1) {
        [_turnsBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff570a"]];
        [_turnsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _turnsBtn.selected = YES;
    }else{
        [_turnsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_turnsBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f5f5f5"]];
        _turnsBtn.selected = NO;
    }
    if (turnsModel.pieces.count < 1 || turnsModel.pieces == nil) {
         [self setupAutoHeightWithBottomView:_filmNumberLabel bottomMargin:20];
    }else{
        _filmview.sd_layout
        .topEqualToView(_filmNumberLabel);
         //用来判断有多少片的地方
        _filmview.filmArray = turnsModel.pieces;
        //这边也需要把piecesModel里面的值送进来
        [self setupAutoHeightWithBottomView:_filmview bottomMargin:0];
    }
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
        if (self.countMark == 0) {
            _count = self.tempTurnsCount;
            self.countMark++;
        }
    }else{
        _count = self.tempTurnsCount;
    }
}





#pragma mark -- 这边是选择匝数
- (void)ChoiceTurnsCount:(UIButton *)btn{
   
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
    self.count +=self.turnsModel.pieces.count;
        self.turnsModel.turnsStatus = btn.selected;
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff570a"]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if ([self.deleagete respondsToSelector:@selector(selectTurnsNumberCount:andTurnsCountModel:andBtn:)]) {
            [self.deleagete selectTurnsNumberCount:self.count andTurnsCountModel:self.turnsModel andBtn:btn];
        }
        
    }else{
        
    self.count -= self.turnsModel.pieces.count;
        self.turnsModel.turnsStatus = btn.selected;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f5f5f5"]];
        if ([self.deleagete respondsToSelector:@selector(selectTurnsNumberCount:andTurnsCountModel:andBtn:)]) {
            [self.deleagete selectTurnsNumberCount:self.count andTurnsCountModel:self.turnsModel andBtn:btn];
        }
        
    }
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
