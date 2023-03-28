//
//  UIViewController+RSController.m
//  石来石往
//
//  Created by mac on 2021/10/31.
//  Copyright © 2021 mac. All rights reserved.
//

#import "UIViewController+RSController.h"

@implementation UIViewController (RSController)

#pragma mark 跳转到第三方地图APP
/// @param title 目的地的名字
/// @param latitude 纬度
/// @param longitude 经度
-(void)navigationLocationTitle:(NSString *)title latitudeText:(NSString *)latitude longitudeText:(NSString *)longitude{
    CLLocationDegrees lon = [NSString stringWithFormat:@"%@",longitude].floatValue;
    CLLocationDegrees latt = [NSString stringWithFormat:@"%@",latitude].floatValue;
    NSMutableArray *maps = [NSMutableArray array];
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=%@&mode=driving&coord_type=gcj02",latitude,longitude,title] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&backScheme=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",@"辰邦急救",@"iosorun",latt,lon,title] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@&directionsmode=driving",@"导航测试",@"nav123456",title] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=%@&coord_type=1&policy=0",latitude,longitude,title ] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:@"导航去需要到地方" preferredStyle:UIAlertControllerStyleActionSheet];
    NSInteger index = maps.count;
    
    for (int i = 0; i < index; i++) {
        NSString * actititle = maps[i][@"title"];
        //苹果原生地图方法
        if (i == 0) {
            UIAlertAction * action = [UIAlertAction actionWithTitle:actititle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self navAppleMapTitle:title latitudeText:latitude longitudeText:longitude];
            }];
            [alert addAction:action];
        }else{
            UIAlertAction * action = [UIAlertAction actionWithTitle:actititle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *urlString = maps[i][@"url"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }];
            [alert addAction:action];
        }
    }
    UIAlertAction *cancleAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancleAct];
    [self presentViewController:alert animated:YES completion:^{}];
}


//苹果地图
- (void)navAppleMapTitle:(NSString *)mapTitle latitudeText:(NSString *)latitude longitudeText:(NSString *)longitude
{

  CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
  MKMapItem * currentLoc = [MKMapItem mapItemForCurrentLocation];
  MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
  toLocation.name = mapTitle;
  NSArray *items = @[currentLoc,toLocation];
  NSDictionary *dic = @{
                        MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                        MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                        MKLaunchOptionsShowsTrafficKey : @(YES)
                        };
  [MKMapItem openMapsWithItems:items launchOptions:dic];
}


#pragma mark 字符串高度
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font{
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, MAXFLOAT);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:Width_Real(0)];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}

#pragma mark 计算标签的宽度
- (CGFloat)getWidthLineWithString:(NSString *)string andFont:(float)sizefont{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:Width_Real(sizefont)]};
    CGFloat length = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 5;
    return length;
}

#pragma mark 改变字符串中具体某字符串的颜色
- (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize {
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    NSRange markRange = [tempStr rangeOfString:change];
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}


@end
