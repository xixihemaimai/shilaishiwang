//
//  RSInformationCell.h
//  石来石往
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSInformationModel.h"



@protocol RSInformationCellDelegate <NSObject>

@optional
- (void)sendH5Url:(NSString *)url;

@end

@interface RSInformationCell : UITableViewCell

@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,weak)id<RSInformationCellDelegate>delegate;
@end
