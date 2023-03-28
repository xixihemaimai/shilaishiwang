//
//  RSChoosingSliceModel.h
//  石来石往
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSChoosingSliceModel : NSObject


//长宽高
@property (nonatomic,strong)NSString * lenth;

@property (nonatomic,strong)NSString * wide;

@property (nonatomic,strong)NSString * height;

//原来长宽高
@property (nonatomic,strong)NSString * originalLenth;
@property (nonatomic,strong)NSString * originalWide;
@property (nonatomic,strong)NSString * originalHeight;

//体积
@property (nonatomic,strong)NSString * area;
//原来体积
@property (nonatomic,strong)NSString * originalArea;

//扣尺面积
@property (nonatomic,strong)NSString * deductionArea;
//原始扣尺面积
@property (nonatomic,strong)NSString * originalDeductionArea;
//实际面积
@property (nonatomic,strong)NSString * actualArea;
//原始实际面积
@property (nonatomic,strong)NSString * originalActualArea;




@end

NS_ASSUME_NONNULL_END
