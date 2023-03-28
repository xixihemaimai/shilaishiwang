//
//  RSPiecesModel.h
//  石来石往
//
//  Created by mac on 17/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPiecesModel : NSObject

/**片数里面的面积*/
@property (nonatomic,strong)NSString * area;
/**片数里面的片数ID*/
@property (nonatomic,strong)NSString * pieceID;
/**片数的显示的名字*/
@property (nonatomic,strong)NSString * pieceNum;

/**选择的状态*/
@property (nonatomic,assign)NSInteger status;

@end
