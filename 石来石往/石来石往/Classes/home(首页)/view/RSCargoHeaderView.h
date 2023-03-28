//
//  RSCargoHeaderView.h
//  石来石往
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSUserModel.h"
#import "RSMyRingModel.h"
#import "RSBusinessLicenseListModel.h"


@protocol RSCargoHeaderViewDelegate <NSObject>


@optional
//返回界面
- (void)backUp;

/**RSUserModel mymodel tag  对象 */
//背景
- (void)changBackgroundImageUserModel:(RSUserModel *)usermodel andRSMyRingModel:(RSMyRingModel *)mymodel andTag:(NSInteger)selectIndex andUImageView:(UIImageView *)backgroundImage;

//头像
- (void)changeTouImageUserModel:(RSUserModel *)usermodel andRSMyRingModel:(RSMyRingModel *)mymodel andTag:(NSInteger)selectIndex andUImageView:(UIImageView *)touImage;




//荒料
- (void)jumpHuangTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel;

//大板
- (void)jumpDabanTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel;

//大众云仓的代理
//荒料
- (void)jumpHuangTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel andDataSoure:(NSString *)dataSource;

//大板
- (void)jumpDabanTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel andDataSoure:(NSString *)dataSource;



//地址
- (void)jumpAddressAndMyRingModel:(RSMyRingModel *)mymodel andSelectype:(NSString *)type andUsermodel:(RSUserModel *)usermodel;


//展示大图
- (void)showPitrueArray:(NSMutableArray *)pictrueArray andTag:(NSInteger)tag;


@end

@interface RSCargoHeaderView : UIView

/**要的上半部分的接口的参数*/
@property (nonatomic,strong)NSString * erpCodeStr;

/**要的上半部分的接口参数*/
@property (nonatomic,strong)NSString * userIDStr;

/**区分是大众云仓还是个人主页*/
@property (nonatomic,strong)NSString * dataSoure;



/**提醒用户图片*/
@property (nonatomic,strong)UIImageView * attetionImageView;

@property (nonatomic,strong)RSUserModel * usermodel;


@property (nonatomic,strong)RSMyRingModel * mymodel;





@property (nonatomic,weak)id<RSCargoHeaderViewDelegate> cargodelegate;

- (instancetype)initWithErpCodeStr:(NSString *)erpCodeStr andUserIDStr:(NSString *)userIDstr andUserModel:(RSUserModel *)usermodel;


- (instancetype)initWithErpCodeStr:(NSString *)erpCodeStr andUserIDStr:(NSString *)userIDstr andUserModel:(RSUserModel *)usermodel andDataSoure:(NSString *)dataSoure;
@end
