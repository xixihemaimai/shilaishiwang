//
//  RSFilmView.h
//  石来石往
//
//  Created by mac on 17/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPiecesModel.h"


@protocol RSFilmViewDelegate <NSObject>

- (void)choiceSliceCount:(NSInteger)count andPSPiecesModel:(RSPiecesModel *)piecesModel andBtn:(UIButton *)btn;

@end

@interface RSFilmView : UIView

@property (nonatomic,strong)NSArray * filmArray;


@property (nonatomic,weak)id<RSFilmViewDelegate>delegate;


@property (nonatomic,strong)RSPiecesModel *piecesModel;

/**获取模型里面的数组pieces的模型里面的数据*/
@property (nonatomic,strong)NSMutableArray *dataAry;

/**用来存放选中多少片，之后返回来的数据*/
@property (nonatomic,assign)NSInteger  tempselectCount;




@end
