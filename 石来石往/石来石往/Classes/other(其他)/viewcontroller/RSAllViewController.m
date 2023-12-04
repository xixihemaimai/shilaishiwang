//
//  RSAllViewController.m
//  石来石往
//
//  Created by mac on 17/5/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAllViewController.h"

@interface RSAllViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation RSAllViewController

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0.01;
        _tableview.estimatedSectionHeaderHeight = 0.01;
        _tableview.backgroundColor = [UIColor whiteColor];
//        _tableview.backgroundColor = KCustomAdjustColor([UIColor colorWithHexString:@"#FFFDFD"], [UIColor blackColor]);
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
        _tableview.showsVerticalScrollIndicator = false;
        _tableview.emptyDataSetSource = self;
        _tableview.emptyDataSetDelegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}


- (UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 0;
//        layout.itemSize = CGSizeMake(0, 0);
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionview = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionview.showsVerticalScrollIndicator = false;
        _collectionview.showsHorizontalScrollIndicator = false;
        _collectionview.backgroundColor = [UIColor whiteColor];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.emptyDataSetSource = self;
        _collectionview.emptyDataSetDelegate = self;
    }
    return _collectionview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getServerTime];
    self.view.backgroundColor = [UIColor whiteColor];
    if(@available(ios 15.0,*)){
        
    }else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (void)isAddjust{
    if (@available(iOS 11.0, *)) {
      self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
      self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (@available(iOS 15.0, *)) {
        self.tableview.sectionHeaderTopPadding = 0.0;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//公司名称
- (BOOL)isContrainChineseStr:(NSString *)company
{
    NSString *regex = @"^[\u4e00-\u9fa5]{0,19}$";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate1 evaluateWithObject:company];
}

- (NSString *)stringFromDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *string = [fmt stringFromDate:date];
    return string;
}

- (BOOL)isEnglishAndChinese:(NSString *)textf{
    //@"^[\u4e00-\u9fa5a-zA-Z]*$" [a-zA-Z\u4e00-\u9fa5]+
    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:textf]; 
}

-(BOOL)istext:(UITextField *)textf
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if (textf.text.length<=0||textf.text==nil||[textf.text isEqualToString:@""]||[textf.text isKindOfClass:[NSNull class]]||[[textf.text stringByTrimmingCharactersInSet:set]length]==0)
    {
        return YES;
    }
    else
        return NO;
}

-(BOOL)isnstring:(NSString *)textf;
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if (textf.length<=0||textf==nil||[textf isEqualToString:@""]||[textf isKindOfClass:[NSNull class]]||[[textf stringByTrimmingCharactersInSet:set]length]==0)
    {
        return YES;
    }
    else
        return NO;
}

//密码验证
- (BOOL)isValidPassword:(NSString *)pwd {
    //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
    NSString *regex = @"^(""[a-zA-Z]|[0-9]){6,20}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:pwd];
}

//手机号验证
- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:mobile];
   // NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    //^1[3456789]\\d{9}$
//    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
//    ^1[3456789]\\d{9}$
    NSString * MOBILE = @"^1[3456789]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
}

/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) validateCarNo:(NSString*) carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

/**密码设置有大小写字母和数字*/
- (BOOL)validatePassword:(NSString *)passWord
{
   // NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";
    NSString * passWordRegex = @"[0-9a-zA-Z\u4e00-\u9fa5\\.\\*\\)\\(\\+\\$\\[\\?\\\\\\^\\{\\|\\]\\}%%%@\'\",。‘、-【】·！_——=:;；<>《》‘’“”!#~]+";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/* 身份证
 *
 *
 */
-(BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}

/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid:(NSString *)name
{
    BOOL isValid = NO;
    
    if (name.length > 0)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = YES;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = YES;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = YES;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = YES;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            if (!isValid)
            {
                break;
            }
        }
    }
    return isValid;
}


// 昵称
- (BOOL) validateNickname:(NSString *)nickname

{
    
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:nickname];
    
}



- (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{2,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//用户名验证 失效
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal string:(NSString *)str;
{
    NSString *hanzi = containChinese ? @"\\u4e00-\\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:str];
}


//根据金额内容进行判断，如果是只有整数位，就显示整数金额，如果是有小数位，就取小数位后两位，小数点后若为0则去掉不显示
-(NSString *)cutStr:(double)pNum
{
    
    NSString *res=[NSString stringWithFormat:@"%.2f",pNum];
    if(([res intValue]-pNum)==0.0)
    {
        res=[NSString stringWithFormat:@"%d",(int)pNum];
    }
    return res;
    
}

- (BOOL)isPureNumandCharacters:(NSString *)string
{
    if(string.length!=6)
    {
        return NO;
    }
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

/*
 *  获取服务器时间，并计算客户端与服务器端时间差，存入NSUserDefaults中
 */
- (void)getServerTime
{
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GET_SERVER_DATE_IOS withParameters:nil withBlock:^(id json, BOOL success) {
//        CLog(@"++++++++++++++222222++++++++++2323+++++++++++++%@",json);
//        CLog(@"++++++++++++++222222+++++++++++++++++++++++%@",json[@"msg"]);
        if (success) {
            NSString *timeInterval = json[@"Data"];
            timeInterval = [timeInterval substringWithRange:NSMakeRange(6, timeInterval.length - 8)];
            NSTimeInterval sTime = (double)[timeInterval doubleValue];
            NSTimeInterval pTime = [[NSDate date] timeIntervalSince1970]*1000;
            long long sections = sTime - pTime;
            //将服务器时间与手机端时间的差值封装存入kTimeIntervalForPhoneAndServer中
            NSNumber *sectionValue = [NSNumber numberWithLongLong:sections];
            [[NSUserDefaults standardUserDefaults] setObject:sectionValue forKey:@"kTimeIntervalForPhoneAndServer"];
        }
    }];
}


//清除空字符串
- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


//FIXME:UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Height_Real(0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc]init];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
//}


//FIXME:UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [[UICollectionViewCell alloc]init];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
}

//组头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
// 返回每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(0, 0);
}
//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//动态设置某个分区头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}
//动态设置某个分区尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}



//#pragma mark 跳转到第三方地图APP
///// @param title 目的地的名字
///// @param latitude 纬度
///// @param longitude 经度
//-(void)navigationLocationTitle:(NSString *)title latitudeText:(NSString *)latitude longitudeText:(NSString *)longitude{
//    CLLocationDegrees lon = [NSString stringWithFormat:@"%@",longitude].floatValue;
//    CLLocationDegrees latt = [NSString stringWithFormat:@"%@",latitude].floatValue;
//    NSMutableArray *maps = [NSMutableArray array];
//    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
//    iosMapDic[@"title"] = @"苹果地图";
//    [maps addObject:iosMapDic];
//    //百度地图
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
//        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
//        baiduMapDic[@"title"] = @"百度地图";
//        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=%@&mode=driving&coord_type=gcj02",latitude,longitude,title] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        baiduMapDic[@"url"] = urlString;
//        [maps addObject:baiduMapDic];
//    }
//    //高德地图
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
//        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
//        gaodeMapDic[@"title"] = @"高德地图";
//        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&backScheme=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",@"辰邦急救",@"iosorun",latt,lon,title] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        gaodeMapDic[@"url"] = urlString;
//        [maps addObject:gaodeMapDic];
//    }
//    //谷歌地图
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
//        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
//        googleMapDic[@"title"] = @"谷歌地图";
//        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@&directionsmode=driving",@"导航测试",@"nav123456",title] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        googleMapDic[@"url"] = urlString;
//        [maps addObject:googleMapDic];
//    }
//    //腾讯地图
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
//        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
//        qqMapDic[@"title"] = @"腾讯地图";
//        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=%@&coord_type=1&policy=0",latitude,longitude,title ] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        qqMapDic[@"url"] = urlString;
//        [maps addObject:qqMapDic];
//    }
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:@"导航去需要到地方" preferredStyle:UIAlertControllerStyleActionSheet];
//    NSInteger index = maps.count;
//    
//    for (int i = 0; i < index; i++) {
//        NSString * actititle = maps[i][@"title"];
//        //苹果原生地图方法
//        if (i == 0) {
//            UIAlertAction * action = [UIAlertAction actionWithTitle:actititle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                [self navAppleMapTitle:title latitudeText:latitude longitudeText:longitude];
//            }];
//            [alert addAction:action];
//        }else{
//            UIAlertAction * action = [UIAlertAction actionWithTitle:actititle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSString *urlString = maps[i][@"url"];
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//            }];
//            [alert addAction:action];
//        }
//    }
//    UIAlertAction *cancleAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alert addAction:cancleAct];
//    [self presentViewController:alert animated:YES completion:^{}];
//}
//
//
////苹果地图
//- (void)navAppleMapTitle:(NSString *)mapTitle latitudeText:(NSString *)latitude longitudeText:(NSString *)longitude
//{
//
//  CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
//  MKMapItem * currentLoc = [MKMapItem mapItemForCurrentLocation];
//  MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
//  toLocation.name = mapTitle;
//  NSArray *items = @[currentLoc,toLocation];
//  NSDictionary *dic = @{
//                        MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
//                        MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
//                        MKLaunchOptionsShowsTrafficKey : @(YES)
//                        };
//  [MKMapItem openMapsWithItems:items launchOptions:dic];
//}




- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"暂无数据icon1123"];
}

// 返回文字的提示
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor colorWithHexColorStr:@"#AAAAAA"]
                                 };
    NSAttributedString *attributedStr = [[NSAttributedString alloc]initWithString:title attributes:attributes];
    return attributedStr;
}


// 垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return -Height_Real(64);
    return 0;
}

//是否允许点击 (默认是 YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

//要求知道空的状态应该渲染和显示 (Default is YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

//空白区域点击响应:
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{ // Do something}

//点击button 响应
//- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ // Do something}

//#pragma mark 字符串高度
//- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font{
//    //1.1最大允许绘制的文本范围
//    CGSize size = CGSizeMake(width, MAXFLOAT);
//    //1.2配置计算时的行截取方法,和contentLabel对应
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    [style setLineSpacing:Width_Real(0)];
//    //1.3配置计算时的字体的大小
//    //1.4配置属性字典
//    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
//    //2.计算
//    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
//    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
//    return height;
//}
//
//#pragma mark 计算标签的宽度
//- (CGFloat)getWidthLineWithString:(NSString *)string andFont:(float)sizefont{
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:Width_Real(sizefont)]};
//    CGFloat length = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 5;
//    return length;
//}
//
//#pragma mark 改变字符串中具体某字符串的颜色
//- (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize {
//    NSString *tempStr = theLab.text;
//    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
//    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
//    NSRange markRange = [tempStr rangeOfString:change];
//    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
//    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
//    theLab.attributedText = strAtt;
//}





- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isNewData" object:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"PageOne"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"PageOne"];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}





@end
