//
//  HomeLineChartView.m
//  CCLineChart
//
//  Created by CC on 2018/5/6.
//  Copyright © 2018年 CC. All rights reserved.
//

#import "HomeLineChartView.h"

@interface HomeLineChartView ()
@property (nonatomic, strong) UIView  *contentView;
@property (nonatomic,strong)UIView *lineChartView;
@property (nonatomic,strong)NSMutableArray *pointCenterArr;
@end


@implementation HomeLineChartView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        //左上角按钮
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 20)];
//        _titleLabel.font = [UIFont systemFontOfSize:12];
//        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0  blue:122/255.0  alpha:1];
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:_titleLabel];
//
//        //下面按钮
//        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
//        _bottomLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 10 - 20 / 2);
//        _bottomLabel.font = [UIFont systemFontOfSize:12];
//        _bottomLabel.textAlignment = NSTextAlignmentCenter;
//        _bottomLabel.textColor = [UIColor colorWithRed:0/255.0 green:165/255.0  blue:87/255.0  alpha:1];
//        _bottomLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:_bottomLabel];
        
        
        //中间区域
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        
        
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _contentView.bounds.size.width, _contentView.bounds.size.height)];
        imageview.image = [UIImage imageNamed:@"扫描线 copy"];
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        [_contentView addSubview:imageview];
        
        
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.frame = _contentView.bounds;
//        [_contentView.layer addSublayer:gradientLayer];
//
//        UIColor *lightColor = [UIColor colorWithRed:123 / 255.0 green:243 / 255.0 blue:249 / 255.0 alpha:0.5];
//
//        UIColor *whiteColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:0.5];
//        //可以设置多个colors,
//        gradientLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)whiteColor.CGColor];
//        //45度变色(由lightColor－>white)
//        gradientLayer.startPoint = CGPointMake(0, 1);
//        gradientLayer.endPoint = CGPointMake(0, 0);

        
        
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        //展示的图片
        cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"点"].CGImage);
        
        //每秒粒子产生个数的乘数因子，会和layer的birthRate相乘，然后确定每秒产生的粒子个数
        cell.birthRate = 2000;
        //每个粒子存活时长
        cell.lifetime = 5.0;
        //粒子生命周期范围
        cell.lifetimeRange = 0.3;
        //粒子透明度变化，设置为－0.4，就是每过一秒透明度就减少0.4，这样就有消失的效果,一般设置为负数。
        cell.alphaSpeed = -0.2;
        cell.alphaRange = 0.5;
        //粒子的速度
        cell.velocity = 40;
        //粒子的速度范围
        cell.velocityRange = 20;
        //周围发射的角度，如果为M_PI*2 就可以从360度任意位置发射
        //cell.emissionRange =  M_PI * 2;
        //粒子内容的颜色
        // cell.color = [[UIColor whiteColor] CGColor];
        
        //设置了颜色变化范围后每次产生的粒子的颜色都是随机的
        cell.redRange = 0.5;
        cell.blueRange = 0.5;
        cell.greenRange = 0.5;
        //缩放比例
        cell.scale = 0.2;
        //缩放比例范围
        cell.scaleRange = 0.02;
        //粒子的初始发射方向
        //cell.emissionLongitude = M_PI;
        //Y方向的加速度
       // cell.yAcceleration = 70.0;
        //X方向加速度
        // cell.xAcceleration = 20.0;
        
        CAEmitterLayer * emitterLayer = [CAEmitterLayer layer];
        
        //CGRect frame = CGRectMake(0, 0, _contentView.bounds.size.width, _contentView.bounds.size.height);
        //emitterLayer.frame = frame;
        
        //发射位置
        emitterLayer.emitterPosition = CGPointMake(_contentView.bounds.size.width * 0.5, _contentView.bounds.size.height);
        //粒子产生系数，默认为1
        emitterLayer.birthRate = 1;
        //发射器的尺寸
        emitterLayer.emitterSize = CGSizeMake(_contentView.bounds.size.width + 25, _contentView.bounds.size.height + 25);
        //发射的形状
        emitterLayer.emitterShape = kCAEmitterLayerLine;
        //发射的模式
        emitterLayer.emitterMode = kCAEmitterLayerOutline;
        //渲染模式
        emitterLayer.renderMode = kCAEmitterLayerCircle;
        emitterLayer.masksToBounds = NO;
        //_emitterLayer.zPosition = -1;
        emitterLayer.emitterCells = @[cell];
        //emitterView是自己创建的一个View
        [_contentView.layer addSublayer:emitterLayer];
        
        [self addLineChartView];
        
        self.pointCenterArr = [NSMutableArray array];   
    }
    return self;
    
}
#pragma mark - 外部赋值
//外部Y坐标轴赋值
-(void)setDataArrOfY:(NSArray *)dataArrOfY
{
    _dataArrOfY = dataArrOfY;
   // [self addYAxisViews];
}

//外部X坐标轴赋值
-(void)setDataArrOfX:(NSArray *)dataArrOfX
{
    _dataArrOfX = dataArrOfX;
   // [self addXAxisViews];
    //[self addLinesView];
}

//点数据
-(void)setDataArrOfPoint:(NSArray *)dataArrOfPoint
{
    _dataArrOfPoint = dataArrOfPoint;
    [self addPointView];
    //[self addBezierLine];
}

#pragma mark - UI
- (void)addLineChartView
{
    _lineChartView = [[UIView alloc]initWithFrame:CGRectMake(0, _contentView.bounds.size.height - 0.5, _contentView.bounds.size.width, 0.5)];
  //  _lineChartView.layer.masksToBounds = YES;
  //  _lineChartView.layer.borderWidth = 0.5;
  //  _lineChartView.layer.borderColor = [UIColor colorWithRed:216/255.0 green:216/255.0  blue:216/255.0  alpha:1].CGColor;
   // _lineChartView.backgroundColor = [UIColor clearColor];
    _lineChartView.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0  blue:216/255.0  alpha:1];
    [_contentView addSubview:_lineChartView];
}

-(void)addYAxisViews
{
    CGFloat height = _lineChartView.bounds.size.height / (_dataArrOfY.count - 1);
    for (int i = 0;i< _dataArrOfY.count ;i++ )
    {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, height * i - height / 2, 30, height)];
        leftLabel.font = [UIFont systemFontOfSize:10];
        leftLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0  blue:74/255.0  alpha:1];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        //leftLabel.text = _dataArrOfY[i];
        leftLabel.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:leftLabel];
    }
}

-(void)addXAxisViews
{
    CGFloat height = _lineChartView.bounds.size.width /( _dataArrOfX.count - 1);
    for (int i = 0;i< _dataArrOfX.count;i++ )
    {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*height - height / 2 + _lineChartView.frame.origin.x, _lineChartView.bounds.origin.y + _lineChartView.bounds.size.height, height, 20)];
        leftLabel.font = [UIFont systemFontOfSize:10];
        leftLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0  blue:74/255.0  alpha:1];
       // leftLabel.text = _dataArrOfX[i];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:leftLabel];
    }
    
}

-(void)addLinesView
{
    CGFloat white = _lineChartView.bounds.size.height /( _dataArrOfY.count - 1);
    CGFloat height = _lineChartView.bounds.size.width /( _dataArrOfX.count - 1);
    //横格
    for (int i = 0;i < _dataArrOfY.count - 2 ;i++ )
    {
        UIView *hengView = [[UIView alloc] initWithFrame:CGRectMake(0, white * (i + 1),_lineChartView.bounds.size.width , 0.5)];
        hengView.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0  blue:216/255.0  alpha:0.5];
        [_lineChartView addSubview:hengView];
    }
    //竖格
    for (int i = 0;i< _dataArrOfX.count - 2 ;i++ )
    {
        
        UIView *shuView = [[UIView alloc]initWithFrame:CGRectMake(height * (i + 1), 0, 0.5, _lineChartView.bounds.size.height)];
        shuView.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0  blue:216/255.0  alpha:0.5];
        [_lineChartView addSubview:shuView];
    }
}

#pragma mark - 点和根据点画贝塞尔曲线
-(void)addPointView
{
    //区域高
    CGFloat height = self.lineChartView.bounds.size.height;
    //y轴最小值
    float arrmin = [_dataArrOfY[_dataArrOfY.count - 1] floatValue];
    //y轴最大值
    float arrmax = [_dataArrOfY[0] floatValue];
    //区域宽
    CGFloat width = self.lineChartView.bounds.size.width;
    //X轴间距
    float Xmargin = width / (_dataArrOfX.count - 1 );
    
    for (int i = 0; i<_dataArrOfPoint.count; i++)
    {
        //nowFloat是当前值
        float nowFloat = [_dataArrOfPoint[i] floatValue];
        //点点的x就是(竖着的间距 * i),y坐标就是()
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake((Xmargin)*i - 2 / 2, height - (nowFloat - arrmin)/(arrmax - arrmin) * height - 2 / 2 , 2, 2)];
//        v.backgroundColor = [UIColor blueColor];
//        [_lineChartView addSubview:v];
        
        NSValue *point = [NSValue valueWithCGPoint:v.center];
        [self.pointCenterArr addObject:point];
    }
    
}

-(void)addBezierLine
{
    //取得起点
    CGPoint p1 = [[self.pointCenterArr objectAtIndex:0] CGPointValue];
    UIBezierPath *beizer = [UIBezierPath bezierPath];
    [beizer moveToPoint:p1];
    
    //添加线
    for (int i = 0;i<self.pointCenterArr.count;i++ )
    {
        if (i != 0)
        {
            CGPoint prePoint = [[self.pointCenterArr objectAtIndex:i-1] CGPointValue];
            CGPoint nowPoint = [[self.pointCenterArr objectAtIndex:i] CGPointValue];
            [beizer addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
        }
    }
    //显示线
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = beizer.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor colorWithRed:245/255.0 green:166/255.0  blue:35/255.0  alpha:1].CGColor;
    shapeLayer.lineWidth = 2;
    [_lineChartView.layer addSublayer:shapeLayer];
    //设置动画
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration =2.0f;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    [shapeLayer addAnimation:anmi forKey:@"stroke"];
    
    
    //遮罩层相关
    UIBezierPath *bezier1 = [UIBezierPath bezierPath];
    bezier1.lineCapStyle = kCGLineCapRound;
    bezier1.lineJoinStyle = kCGLineJoinMiter;
    [bezier1 moveToPoint:p1];
    CGPoint lastPoint;
    for (int i = 0;i<self.pointCenterArr.count;i++ )
    {
        if (i != 0)
        {
            CGPoint prePoint = [[self.pointCenterArr objectAtIndex:i-1] CGPointValue];
            CGPoint nowPoint = [[self.pointCenterArr objectAtIndex:i] CGPointValue];
            [bezier1 addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
            if (i == self.pointCenterArr.count-1)
            {
                lastPoint = nowPoint;
            }
        }
    }
    //获取最后一个点的X值
    CGFloat lastPointX = lastPoint.x;
    CGPoint lastPointX1 = CGPointMake(lastPointX,_lineChartView.bounds.size.height);
    [bezier1 addLineToPoint:lastPointX1];
    //回到原点
    [bezier1 addLineToPoint:CGPointMake(p1.x, _lineChartView.bounds.size.height)];
    [bezier1 addLineToPoint:p1];
    
    CAShapeLayer *shadeLayer = [CAShapeLayer layer];
    shadeLayer.path = bezier1.CGPath;
    shadeLayer.fillColor = [UIColor colorWithRed:245/255.0 green:166/255.0  blue:35/255.0  alpha:1].CGColor;
    [_lineChartView.layer addSublayer:shadeLayer];
    
    
    //渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 0, _lineChartView.bounds.size.height);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.cornerRadius = 5;
    gradientLayer.masksToBounds = YES;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:245/255.0 green:166/255.0  blue:35/255.0  alpha:0.6].CGColor,(__bridge id)[UIColor colorWithRed:245/255.0 green:166/255.0  blue:35/255.0  alpha:0.2].CGColor];
    gradientLayer.locations = @[@(0.5f)];

    CALayer *baseLayer = [CALayer layer];
    [baseLayer addSublayer:gradientLayer];
    [baseLayer setMask:shadeLayer];
    [_lineChartView.layer addSublayer:baseLayer];

    CABasicAnimation *anmi1 = [CABasicAnimation animation];
    anmi1.keyPath = @"bounds";
    anmi1.duration = 2.0f;
    anmi1.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 2*lastPoint.x, _lineChartView.bounds.size.height)];
    anmi1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi1.fillMode = kCAFillModeForwards;
    anmi1.autoreverses = NO;
    anmi1.removedOnCompletion = NO;
    [gradientLayer addAnimation:anmi1 forKey:@"bounds"]; 
}



@end
