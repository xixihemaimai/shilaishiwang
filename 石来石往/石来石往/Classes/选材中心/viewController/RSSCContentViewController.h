//
//  RSSCContentViewController.h
//  石来石往
//
//  Created by mac on 2021/10/26.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSAllViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSCContentViewController : RSAllViewController

//石种名称
@property (nonatomic,copy)NSString * stoneName;
//企业名称
@property (nonatomic,copy)NSString * nameCn;
//精选案例
@property (nonatomic,copy)NSString * subject;
//判断到底需不需要显示组头信息 0需要 1不需要
@property (nonatomic,assign)NSInteger type;

//判断需不需要显示仓库的位置 true是显示，false不显示
@property (nonatomic,assign)BOOL isExhibitionLocation;




- (void)selectionCenterShowContentWithSearchType:(NSString *)stoneType andNameCn:(NSString *)nameCn andStoneName:(NSString *)stoneName andSubject:(NSString *)subject andPageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead;

@end

NS_ASSUME_NONNULL_END
