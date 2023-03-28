//
//  RSSCCaseHeaderView.h
//  石来石往
//
//  Created by mac on 2021/10/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCaseTypeModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSSCCaseHeaderViewDelegate <NSObject>


- (void)jumpCaseTypeIndex:(NSInteger)index;

@end


@interface RSSCCaseHeaderView : UICollectionReusableView

@property (nonatomic,weak)id<RSSCCaseHeaderViewDelegate>delegate;

@property (nonatomic,strong)NSArray * caseArray;

@end

NS_ASSUME_NONNULL_END
