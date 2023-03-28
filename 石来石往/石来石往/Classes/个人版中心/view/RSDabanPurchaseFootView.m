//
//  RSDabanPurchaseFootView.m
//  石来石往
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanPurchaseFootView.h"


@interface RSDabanPurchaseFootView()

{
    
    
    UIView * _view;
    
}

@end

@implementation RSDabanPurchaseFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5f5f5"];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCW - 24, 10)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:view];
        CGRect oldRect = view.bounds;
        oldRect.size.width = SCW - 24;
        _view = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = oldRect;
        view.layer.mask = maskLayer;
        
        
    }
    return self;
}



- (void)setSlstoragemanagementmodel:(RSSLStoragemanagementModel *)slstoragemanagementmodel{
    _slstoragemanagementmodel = slstoragemanagementmodel;
    if (slstoragemanagementmodel.isbool) {
//        if (_slstoragemanagementmodel.sliceArray.count > 0) {
        _view.hidden = NO;
//        }else{
//                _view.hidden = YES;
//        }
    }else{
        _view.hidden = YES;
    }
}


//- (void)setChoosingInventorymodel:(RSChoosingInventoryModel *)choosingInventorymodel{
//    _choosingInventorymodel = choosingInventorymodel;
//    if (_choosingInventorymodel.isBool) {
//        if (_choosingInventorymodel.sliceArray.count > 0) {
//            _view.hidden = NO;
//        }else{
//            _view.hidden = YES;
//        }
//    }else{
//        _view.hidden = YES;
//    }
//}


//- (void)setDict:(NSMutableDictionary *)dict{
//    _dict = dict;
//    BOOL isbool = [[_dict objectForKey:@"isbool"] boolValue];
//    NSArray * array = [_dict objectForKey:@"selectArray"];
//    if (isbool) {
//        if (array.count > 0) {
//            _view.hidden = NO;
//        }else{
//            _view.hidden = YES;
//        }
//    }else{
//        _view.hidden = YES;;
//    }
//}


@end
