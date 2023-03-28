//
//  RSPersonalBalanceCell.h
//  石来石往
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBalanceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSPersonalBalanceCell : UITableViewCell

//@property (nonatomic,strong)NSString * selectFunctionType;
@property (nonatomic,strong)RSBalanceModel * balancemodel;

//
@property (nonatomic,strong) UIButton * codeSheetBtn;

@property (nonatomic,strong) UIButton * reportFormBtn;
@end


NS_ASSUME_NONNULL_END
