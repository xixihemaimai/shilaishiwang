//
//  RSDetailChoiceCell.h
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSTurnsCountModel,RSFilmView;
#import "RSPiecesModel.h"


@protocol RSDetailChoiceCellDelegate <NSObject>

- (void)selectTurnsNumberCount:(NSInteger)count andTurnsCountModel:(RSTurnsCountModel *)turnsCountModel andBtn:(UIButton *)btn;

@end


@interface RSDetailChoiceCell : UITableViewCell

@property (nonatomic,strong)RSTurnsCountModel *turnsModel;

/**九宫格的视图*/
@property (nonatomic,strong)RSFilmView *filmview;
/**按匝*/
@property (nonatomic,strong)UIButton * turnsBtn;

@property (nonatomic,weak)id<RSDetailChoiceCellDelegate>deleagete;

@property (nonatomic,assign)NSInteger tempTurnsCount;


@end

