//
//  MenuView.m
//  YHMenu
//
//  Created by Boris on 2018/5/10.
//  Copyright © 2018年 Boris. All rights reserved.
//

#import "MenuView.h"
#import "HEMenuTableCell.h"

#import "RSWarehouseModel.h"

#define kHEMenuTableCell @"HEMenuTableCell"
#define YHSafeAreaTopHeight (YHkHeight == 812.f ? 88.f : 64.f)
#define YHkWidth [UIScreen mainScreen].bounds.size.width
#define YHkHeight [UIScreen mainScreen].bounds.size.height
#define kTriangleHeight 5.f //底的1/2倍
#define kTriangleToHeight 5.f  // 三角形的高,
#define kItemHeight 40.f       // item 高

@implementation MenuView
#pragma mark -------控件初始化------------
- (NSMutableArray *)titleSource
{
    if (!_titleSource) {
        self.titleSource = [NSMutableArray array];
    }
    return _titleSource;
}


- (NSMutableArray *)imgSource
{
    if (!_imgSource) {
        self.imgSource = [NSMutableArray array];
    }
    return _imgSource;
}



- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = ({
            UITableView *tableView = [UITableView new];
            tableView.delegate = self;
            tableView.dataSource = self;
            [tableView registerClass:[HEMenuTableCell class] forCellReuseIdentifier:kHEMenuTableCell];
            tableView.tableFooterView = [UIView new];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.showsVerticalScrollIndicator = NO;
            tableView.showsHorizontalScrollIndicator = NO;
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
            tableView;
        });
    }
    return _tableView;
}

#pragma mark ----------生命周期---------
- (instancetype)initWithFrame:(CGRect)frame menuWidth:(CGFloat)width height:(CGFloat)height point:(CGPoint)point items:(NSArray *)items imgSource:(NSArray *)imgSource andText:(NSString *)text andSelectType:(NSString *)selectType andWhsId:(NSInteger)whsId action:(void (^)(NSInteger row))action
{
    self = [super initWithFrame:(frame)];
    if (self) {
        self.text = text;
        self.selectType = selectType;
        self.whsId = whsId;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.point = CGPointMake(point.x, YHSafeAreaTopHeight + point.y);
        self.layerWidth = width;
        [self.titleSource removeAllObjects];
        [self.titleSource addObjectsFromArray:items];
        [self.imgSource removeAllObjects];
        [self.imgSource addObjectsFromArray:imgSource];
        if (_imgSource.count != _titleSource.count) {
            [_imgSource removeAllObjects];
        }
        if (imgSource.count == 0 && imgSource != nil) {
            self.layerWidth = 100;
        }
        __weak typeof(self)weakSelf = self;
        if (action) {
            weakSelf.indexBlock = ^(NSInteger row) {
                action(row);
            };
        }
        self.layerHeight = _titleSource.count > 5 ? height : items.count*kItemHeight;
        [self addSubview:self.tableView];
        CGFloat y1 = self.point.y + kTriangleHeight;
        CGFloat x2 = self.point.x - self.layerWidth + kTriangleHeight +kTriangleHeight;
        _tableView.frame = CGRectMake(x2, y1, self.layerWidth, self.layerHeight);
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}



/***
 *                       x           y
 *                      /\
 *              x2    x1  x4   x3
 *              |-------  ----|     y1
 *              |             |
 *              |             |
 *              |             |
 *              |             |
 *              |             |
 *              |-------------|     y2
 *
 *
 *
 ****************/



#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect 

{
    
    CGFloat y1 = self.point.y + kTriangleHeight;
    CGFloat y2 = y1 + self.layerHeight;
    CGFloat x1 = self.point.x - kTriangleHeight;
    CGFloat x2 = self.point.x - self.layerWidth + kTriangleHeight +kTriangleToHeight;
    CGFloat x3 = self.point.x + kTriangleHeight +kTriangleToHeight;
    CGFloat x4 = self.point.x + kTriangleHeight;
   
    
    
    // 设置背景色
    [[UIColor yellowColor] set];
    //拿到当前视图准备好的画板
    CGContextRef  context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    // 起始点1
    CGContextMoveToPoint(context, self.point.x, self.point.y);//设置起点
    // 起始点2
    CGContextAddLineToPoint(context, x1, y1);
    // table左上角
    CGContextAddLineToPoint(context, x2, y1);
    // table左下角
    CGContextAddLineToPoint(context, x2, y2);
    // table 右下角
    CGContextAddLineToPoint(context, x3, y2);
    // table 右上角
    CGContextAddLineToPoint(context, x3, y1);
    // 起始点2
    CGContextAddLineToPoint(context,x4, y1);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor whiteColor] setFill];  //设置填充色
    [[UIColor colorWithHexColorStr:@"#000000" alpha:0.2] setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
    
}


#pragma mark -----------UI事件------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kItemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    HEMenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HEMenuTableCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHEMenuTableCell width:self.layerWidth height:kItemHeight];
    }
    if (indexPath.row == 0) {
        cell.lineView.hidden = YES;
    }
    
    
    if ([self.selectType isEqualToString:@"ruku"]) {
        if ([self.text isEqualToString:self.titleSource[indexPath.row]]) {
            cell.iconImg.hidden = NO;
        }else{
            cell.iconImg.hidden = YES;
        }
        cell.conLabel.text = self.titleSource[indexPath.row];
        
    }else if ([self.selectType isEqualToString:@"newWareHouse"]){
        RSWarehouseModel * warehousemodel = self.titleSource[indexPath.row];
        if ([self.text isEqualToString:warehousemodel.name] && self.whsId == warehousemodel.WareHouseID) {
            cell.iconImg.hidden = NO;
        }else{
            cell.iconImg.hidden = YES;
        }
        cell.conLabel.text = warehousemodel.name;
    }
    //[cell setContentByTitArray:self.titleSource ImgArray:self.imgSource row:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.indexBlock) {
        self.indexBlock(indexPath.row);
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.touchBlock) {
        self.touchBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
