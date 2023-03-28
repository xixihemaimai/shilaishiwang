//
//  RSSLStatementCell.h
//  石来石往
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBalanceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLStatementCell : UITableViewCell

@property (nonatomic,strong)RSBalanceModel * balancemodel;

@property (nonatomic,strong) UIButton * codeSheetBtn;

@property (nonatomic,strong)UIButton * reportFormBtn;
@end

NS_ASSUME_NONNULL_END
