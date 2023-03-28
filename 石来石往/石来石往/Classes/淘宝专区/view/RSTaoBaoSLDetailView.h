//
//  RSTaoBaoSLDetailView.h
//  石来石往
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTaobaoStoneDtlModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol RSTaoBaoSLDetailViewDelegate;


@interface RSTaoBaoSLDetailView : UIView

@property (nonatomic,strong)NSArray * contactsArray;

@property (nonatomic,weak)id<RSTaoBaoSLDetailViewDelegate>delegate;

@end

@protocol RSTaoBaoSLDetailViewDelegate <NSObject>

-(void)hideCurrentShowView:(RSTaoBaoSLDetailView *)contactsActionView;

@end

NS_ASSUME_NONNULL_END
