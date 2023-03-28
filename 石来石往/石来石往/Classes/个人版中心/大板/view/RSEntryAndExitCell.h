//
//  RSEntryAndExitCell.h
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSEntryAndExitModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSEntryAndExitCell : UITableViewCell

@property (nonatomic,strong)RSEntryAndExitModel * entryandexitmodel;
@property (nonatomic,strong) UIButton * codeSheetBtn;

@property (nonatomic,strong)UIButton * reportFormBtn;
@end

NS_ASSUME_NONNULL_END
