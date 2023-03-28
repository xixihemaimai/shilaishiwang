//
//  MenuView.h
//  YHMenu
//
//  Created by Boris on 2018/5/10.
//  Copyright © 2018年 Boris. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchBlock)();
typedef void(^IndexBlock)(NSInteger row);
@interface MenuView : UIView<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic,strong)NSString * text;
@property (nonatomic,strong)NSString * selectType;
@property (nonatomic,assign)NSInteger whsId;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, copy) TouchBlock touchBlock;
@property (nonatomic, copy) IndexBlock indexBlock;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGFloat layerHeight, layerWidth;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleSource, *imgSource;

- (id)initWithFrame:(CGRect)frame
          menuWidth:(CGFloat)width
             height:(CGFloat)height
              point:(CGPoint)point
              items:(NSArray *)items
          imgSource:(NSArray *)imgSource
             andText:(NSString *)text
             andSelectType:(NSString *)selectType
             andWhsId:(NSInteger)whsId
             action:(void(^)(NSInteger index))action;
@end
