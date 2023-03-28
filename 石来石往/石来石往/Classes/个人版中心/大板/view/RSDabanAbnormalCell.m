//
//  RSDabanAbnormalCell.m
//  石来石往
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanAbnormalCell.h"
#import "RSDabanContentView.h"
#import "RSDabanContentFootView.h"

@interface RSDabanAbnormalCell()
{
    
    UIView * _exceptionView;
    
    RSDabanContentView * _dabanContentView;
    
    RSDabanContentFootView * _dabanContentFootView;
    
}

@end

@implementation RSDabanAbnormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        UIView * exceptionView = [[UIView alloc]init];
        exceptionView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [self.contentView addSubview:exceptionView];
        
        exceptionView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .heightIs(98);
        
        
        exceptionView.layer.cornerRadius = 8;
        _exceptionView = exceptionView;
        
        
        UIImageView * yellewView = [[UIImageView alloc]init];
        //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
        yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
        yellewView.contentMode = UIViewContentModeScaleAspectFill;
        yellewView.clipsToBounds = YES;
        [exceptionView addSubview:yellewView];
        
        
        yellewView.sd_layout
        .leftSpaceToView(exceptionView, 0)
        .topSpaceToView(exceptionView, 18)
        .heightIs(17)
        .widthIs(4);
        
        UIImageView * blueView = [[UIImageView alloc]init];
        blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
        blueView.contentMode = UIViewContentModeScaleAspectFill;
        blueView.clipsToBounds = YES;
        [exceptionView addSubview:blueView];
        
        blueView.sd_layout
        .rightSpaceToView(exceptionView, 0)
        .topSpaceToView(exceptionView, 18)
        .heightIs(17)
        .widthIs(4);
        
        //物料名称
        UILabel * productNameLabel = [[UILabel alloc]init];
        productNameLabel.text = @"白玉兰";
        productNameLabel.font = [UIFont systemFontOfSize:17];
        productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productNameLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productNameLabel];
        
        
        productNameLabel.sd_layout
        .leftSpaceToView(exceptionView, 14)
        .topSpaceToView(exceptionView, 14)
        .widthRatioToView(exceptionView, 0.4)
        .heightIs(24);
        
        
        //物料号
        UILabel * productNumberLabel = [[UILabel alloc]init];
        productNumberLabel.text = @"ESB00295/DH-539";
        productNumberLabel.font = [UIFont systemFontOfSize:12];
        productNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productNumberLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productNumberLabel];
        
        productNumberLabel.sd_layout
        .leftEqualToView(productNameLabel)
        .topSpaceToView(productNameLabel, 0)
        .rightEqualToView(productNameLabel)
        .heightIs(17);
        
        
        //分割线
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [exceptionView addSubview:midView];
        
        midView.sd_layout
        .leftSpaceToView(exceptionView, 0)
        .rightSpaceToView(exceptionView, 0)
        .topSpaceToView(productNumberLabel, 5)
        .heightIs(1);
        
        UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
        [downBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [exceptionView addSubview:downBtn];
        _downBtn = downBtn;
        
        
        downBtn.sd_layout
        .leftSpaceToView(exceptionView, 10)
        .topSpaceToView(midView, 0)
        .rightSpaceToView(exceptionView, 10)
        .heightIs(37);
        
        
        
        
        //匝号
        UILabel * productTurnLabel = [[UILabel alloc]init];
        productTurnLabel.text = @"匝号：5-5";
        productTurnLabel.font = [UIFont systemFontOfSize:14];
        productTurnLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productTurnLabel.textAlignment = NSTextAlignmentLeft;
        [downBtn addSubview:productTurnLabel];
        
        productTurnLabel.sd_layout
        .leftSpaceToView(downBtn, 1)
        .topSpaceToView(downBtn, 10)
        .widthRatioToView(downBtn, 0.5)
        .heightIs(20);
        
        
        //编辑按键
        UIButton * productEidtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [productEidtBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        // [productEidtBtn setTitle:@"" forState:UIControlStateNormal];
        // [productEidtBtn setTitleColor:[UIColor colorWithHexColorStr:@""] forState:UIControlStateNormal];
        //[productEidtBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
        [exceptionView addSubview:productEidtBtn];
        
        _productEidtBtn = productEidtBtn;
        
        
        
        //删除按键
        UIButton * productDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [productDeleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
        // [productDeleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
        [exceptionView addSubview:productDeleteBtn];
        _productDeleteBtn = productDeleteBtn;
        
        
        UIImageView * downImageView = [[UIImageView alloc]init];
        // [downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
        downImageView.image = [UIImage imageNamed:@"system-pull-down"];
        downImageView.clipsToBounds = YES;
        downImageView.contentMode = UIViewContentModeScaleAspectFill;
        [downBtn addSubview:downImageView];
        _downImageView = downImageView;
        
        
        productDeleteBtn.sd_layout
        .rightSpaceToView(exceptionView, 16)
        .topSpaceToView(exceptionView, 14)
        .widthIs(28)
        .heightEqualToWidth();
        
        
        productEidtBtn.sd_layout
        .rightSpaceToView(productDeleteBtn, 10)
        .topEqualToView(productDeleteBtn)
        .bottomEqualToView(productDeleteBtn)
        .widthIs(28);
        
        
        
        downImageView.sd_layout
        .topSpaceToView(downBtn, 16)
        .rightSpaceToView(downBtn, 11)
        .widthIs(16)
        .heightIs(9);
        
        
        
        
        //这边是显示有多少片的view
        RSDabanContentView * dabanContentView = [[RSDabanContentView alloc]init];
        dabanContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:dabanContentView];
        _dabanContentView = dabanContentView;
        dabanContentView.sd_layout
        .leftEqualToView(exceptionView)
        .rightEqualToView(exceptionView)
        .topSpaceToView(exceptionView, 0)
        .heightIs(0);
        
        
        RSDabanContentFootView * dabanContentFootView = [[RSDabanContentFootView alloc]init];
        [self.contentView addSubview:dabanContentFootView];
        _dabanContentFootView = dabanContentFootView;
        
        dabanContentFootView.sd_layout
        .leftEqualToView(dabanContentView)
        .rightEqualToView(dabanContentView)
        .topSpaceToView(dabanContentView, 0)
        .heightIs(0);
        
        
        
        
    }
    return self;
}



- (void)setChoosingInventorymodel:(RSChoosingInventoryModel *)choosingInventorymodel{
    
   // BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
   // NSInteger count = [[dict objectForKey:@"count"]integerValue];
    _choosingInventorymodel = choosingInventorymodel;
    
    
    for (UIView * view in _dabanContentFootView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView * view in _dabanContentView.subviews) {
        [view removeFromSuperview];
    }
 
    
    NSInteger count = choosingInventorymodel.selectArray.count;
    if (choosingInventorymodel.newIsBool) {
        
        _exceptionView.layer.cornerRadius = 0;
        
        CGRect rect = CGRectMake(0, 0, SCW - 24, 98);
        CGRect oldRect = rect;
        oldRect.size.width = SCW - 24;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = oldRect;
        _exceptionView.layer.mask = maskLayer;
        if (count > 0) {
            _dabanContentView.sd_layout
            .topSpaceToView(_exceptionView, 0)
            .heightIs(count * 118);
            _dabanContentView.dataArray = choosingInventorymodel.selectArray;
            _dabanContentFootView.sd_layout
            .topSpaceToView(_dabanContentView, 0)
            .heightIs(10);
            _dabanContentFootView.isbool = _choosingInventorymodel.newIsBool;
        }else{
            _dabanContentView.sd_layout
            .topSpaceToView(_exceptionView, 0)
            .heightIs(0);
            _dabanContentFootView.sd_layout
            .topSpaceToView(_dabanContentView, 0)
            .heightIs(0);
            _exceptionView.layer.cornerRadius = 8;
            _dabanContentFootView.isbool = false;
        }
       // [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down copy 2"] forState:UIControlStateNormal];
         self.downImageView.image = [UIImage imageNamed:@"system-pull-down copy 2"];
    }else{
        _dabanContentView.sd_layout
        .topSpaceToView(_exceptionView, 0)
        .heightIs(0);
        _dabanContentFootView.sd_layout
        .topSpaceToView(_dabanContentView, 0)
        .heightIs(0);
        _exceptionView.layer.cornerRadius = 8;
        //_dabanContentView.count = 0;
        // [_dabanContentView.dataArray removeAllObjects];
        _dabanContentFootView.isbool = _choosingInventorymodel.newIsBool;
       // [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
        self.downImageView.image = [UIImage imageNamed:@"system-pull-down"];
    }
    
    
}


//- (void)setDict:(NSMutableDictionary *)dict{
//    _dict = dict;
//    BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
//    NSInteger count = [[dict objectForKey:@"count"]integerValue];
//
//    for (UIView * view in _dabanContentFootView.subviews) {
//        [view removeFromSuperview];
//    }
//    for (UIView * view in _dabanContentView.subviews) {
//        [view removeFromSuperview];
//    }
//
//
//    if (isbool) {
//
//        _exceptionView.layer.cornerRadius = 0;
//
//        CGRect rect = CGRectMake(0, 0, SCW - 24, 98);
//        CGRect oldRect = rect;
//        oldRect.size.width = SCW - 24;
//
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
//
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.path = maskPath.CGPath;
//        maskLayer.frame = oldRect;
//        _exceptionView.layer.mask = maskLayer;
//        if (count > 0) {
//            _dabanContentView.sd_layout
//            .topSpaceToView(_exceptionView, 0)
//            .heightIs(count * 118);
//            _dabanContentView.count = count;
//
//            _dabanContentFootView.sd_layout
//            .topSpaceToView(_dabanContentView, 0)
//            .heightIs(10);
//            _dabanContentFootView.isbool = isbool;
//        }else{
//            _dabanContentView.sd_layout
//            .topSpaceToView(_exceptionView, 0)
//            .heightIs(0);
//            _dabanContentFootView.sd_layout
//            .topSpaceToView(_dabanContentView, 0)
//            .heightIs(0);
//            _exceptionView.layer.cornerRadius = 8;
//            _dabanContentView.count = 0;
//            _dabanContentFootView.isbool = false;
//        }
//        [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down copy 2"] forState:UIControlStateNormal];
//    }else{
//        _dabanContentView.sd_layout
//        .topSpaceToView(_exceptionView, 0)
//        .heightIs(0);
//        _dabanContentFootView.sd_layout
//        .topSpaceToView(_dabanContentView, 0)
//        .heightIs(0);
//        _exceptionView.layer.cornerRadius = 8;
//        _dabanContentView.count = 0;
//        _dabanContentFootView.isbool = isbool;
//        [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
//    }
//
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
