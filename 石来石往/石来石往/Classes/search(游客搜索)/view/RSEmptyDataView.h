//
//  RSEmptyDataView.h
//  石来石往
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSEmptyDataViewDelegate <NSObject>

- (void)selectItemContentTitle:(NSString *)currentTitle andType:(NSInteger)type;

@end



@interface RSEmptyDataView : UIView

//@property (nonatomic,strong)NSArray * array;
/**type 为0 是荒料。1为大板*/
@property (nonatomic,assign)NSInteger type;

- (void)addKeywordArray:(NSArray *)keywordArray;

@property (nonatomic,strong)UIView * btnsView;

@property (nonatomic,weak)id<RSEmptyDataViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
