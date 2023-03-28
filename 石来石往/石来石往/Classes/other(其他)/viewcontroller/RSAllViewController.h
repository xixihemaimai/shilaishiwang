//
//  RSAllViewController.h
//  石来石往
//
//  Created by mac on 17/5/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**这个类是用来登录，继承该类的*/
@interface RSAllViewController : UIViewController


@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)UICollectionView * collectionview;



- (NSString *)stringFromDate;

-(BOOL)istext:(UITextField *)textf;
-(BOOL)isnstring:(NSString *)textf;
- (BOOL)isValidPassword:(NSString *)pwd;
//手机号验证
-(BOOL)isTrueMobile:(NSString *)mobile;
//6位数字密码
- (BOOL)isPureNumandCharacters:(NSString *)string;

//数字验证
- (BOOL) deptNumInputShouldNumber:(NSString *)str;

//判断中文
- (BOOL)isContrainChineseStr:(NSString *)company;

//昵称
- (BOOL) validateNickname:(NSString *)nickname;

//用户名验证

- (BOOL) validateUserName:(NSString *)name;
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal string:(NSString *)str;

//根据金额内容进行判断，如果是只有整数位，就显示整数金额，如果是有小数位，就取小数位后两位，小数点后若为0则去掉不显示
-(NSString *)cutStr:(double)pNum;

/**密码设置成有字母和数字*/
- (BOOL) validatePassword:(NSString *)passWord;
/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid:(NSString *)name;

/*
 * 身份证
 */
-(BOOL)checkUserID:(NSString *)userID;

/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) validateCarNo:(NSString*) carNo;
/**
 只能是中文和英文
 */
- (BOOL)isEnglishAndChinese:(NSString *)textf;
/**
 跳转到第三方地图APP
 */
//-(void)navigationLocationTitle:(NSString *)title latitudeText:(NSString *)latitude longitudeText:(NSString *)longitude;


-(void)isAddjust;

/**清除空字符串*/
- (NSString *)delSpaceAndNewline:(NSString *)string;

//#pragma mark 字符串高度
//- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;
//#pragma mark 计算标签的宽度
//- (CGFloat)getWidthLineWithString:(NSString *)string andFont:(float)sizefont;
//#pragma mark 改变字符串中具体某字符串的颜色
//- (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize;

@end
