//
//  RSVariousFunctionsViewController.m
//  石来石往
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSVariousFunctionsViewController.h"
#define ECA 2
#define MARGIN 30
#import "RSVariousButton.h"
#import "RSPersonalFunctionViewController.h"

//荒料报表中库存余额表
#import "RSPersonalBalanceViewController.h"
//荒料报表中库存流水账
#import "RSRunningAccountViewController.h"
//荒料报表中荒料出库表
#import "RSRawMaterialViewController.h"
//荒料加工跟单
#import "RSMachiningOutController.h"

//荒料出材率
#import "NewSkipViewController.h"


//大板库存余额表
#import "RSSLStatementViewController.h"

//大板库存流水账
#import "RSSLRunningAccountViewController.h"
//大板出入库
#import "RSSLEntryAndExitViewController.h"

//大板现货展示区
#import "RSSLAllSelectSegmentViewController.h"
//荒料现货展示区
#import "RSBLAllSelectSegmentViewController.h"


@interface RSVariousFunctionsViewController ()

@property (nonatomic,strong)UIView * contetnView;

@end

@implementation RSVariousFunctionsViewController

- (UIView *)contetnView{
    if (!_contetnView) {
        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
        _contetnView = [[UIView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight))];
        _contetnView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    }
    return _contetnView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //self.tabBarController.tabBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"荒料入库";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:self.contetnView];
    //CGFloat btnW = (self.view.bounds.size.width - (ECA + 1)*MARGIN)/ECA;
   // CGFloat btnW = 143;
    CGFloat btnW = (SCW - (ECA + 1)*MARGIN)/ECA;
    CGFloat btnH = 116;
    //CGFloat btnH = btnW;
    int count = 0;
    if ([self.selectType isEqualToString:@"huangliaoruku"] || [self.selectType isEqualToString:@"huangliaochuku"] || [self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"dabanchuku"]) {
        //荒料入库和大板入库，荒料出库，大板出库
        count = 3;
    }else if ([self.selectType isEqualToString:@"baobiaozhongxin"]){
        //报表中心
        count = 6;
    }else if ([self.selectType isEqualToString:@"baobiaozhongxin1"]){
        count = 4;
    }else if([self.selectType isEqualToString:@"kucunguanli"] || [self.selectType isEqualToString:@"kucunguanli1"]){
        //仓库管理
        count = 3;
    }else{
        count = 0;
    }
    for (int i = 0 ; i < count; i++) {
        RSVariousButton * publishBtn = [RSVariousButton buttonWithType:UIButtonTypeCustom];
        publishBtn.adjustsImageWhenHighlighted = NO;
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        CGFloat btnX =  colom * (MARGIN + btnW) + MARGIN;
        CGFloat btnY =  row * (MARGIN + btnH) + MARGIN;
        publishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        publishBtn.layer.cornerRadius = 5;
        [publishBtn LX_SetShadowPathWith:[UIColor colorWithHexColorStr:@"#DEEBFE"] shadowOpacity:1 shadowRadius:3 shadowSide:LXShadowPathNoTop shadowPathWidth:10];
        if ([self.selectType isEqualToString:@"huangliaoruku"] || [self.selectType isEqualToString:@"huangliaochuku"] || [self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"dabanchuku"]) {
            //荒料入库和大板入库，荒料出库，大板出库
            if ([self.selectType isEqualToString:@"huangliaoruku"]) {
                //HLGL_HLRK_CGRK 荒料采购入库
                //HLGL_HLRK_JGRK 荒料加工入库
                //HLGL_HLRK_PYRK荒料盘盈入库
                if (i == 0) {
                    [publishBtn setTitle:@"采购入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 11"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"加工入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 3"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"盘盈入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标"] forState:UIControlStateNormal];
                }
            }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
                if (i == 0) {
                    [publishBtn setTitle:@"销售出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 2"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"加工出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 3"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"盘亏出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 4"] forState:UIControlStateNormal];
                }
            }else if ([self.selectType isEqualToString:@"dabanruku"]){
                if (i == 0) {
                    [publishBtn setTitle:@"采购入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 11"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"加工入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 3"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"盘盈入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标"] forState:UIControlStateNormal];
                }
            }else{
                //dabanchuku
                if (i == 0) {
                    [publishBtn setTitle:@"销售出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 2"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"加工出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 3"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"盘亏出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 4"] forState:UIControlStateNormal];
                }
            }
        }else if ([self.selectType isEqualToString:@"baobiaozhongxin"] || [self.selectType isEqualToString:@"baobiaozhongxin1"] ){
            //报表中心
            if ([self.selectType isEqualToString:@"baobiaozhongxin"]) {
                //荒料部分
                if (i == 0) {
                    [publishBtn setTitle:@"荒料库存余额表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 7"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"荒料库存流水账" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 8"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"荒料入库明细表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 9"] forState:UIControlStateNormal];
                }else if (i == 3){
                    
                    [publishBtn setTitle:@"荒料出库明细表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 10"] forState:UIControlStateNormal];
                    
                }else if (i == 4){
                    [publishBtn setTitle:@"加工跟单" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"加工跟单"] forState:UIControlStateNormal];
                }else{
                    [publishBtn setTitle:@"出材率" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"出材率"] forState:UIControlStateNormal];
                }
            }else{
                //大板部分
                if (i == 0) {
                    [publishBtn setTitle:@"大板库存余额表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 7"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"大板库存流水账" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 8"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"大板入库明细表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 9"] forState:UIControlStateNormal];
                }else{
                    [publishBtn setTitle:@"大板出库明细表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 10"] forState:UIControlStateNormal];
                }
            }
        }else if([self.selectType isEqualToString:@"kucunguanli"] || [self.selectType isEqualToString:@"kucunguanli1"]){
            //仓库管理
            if ([self.selectType isEqualToString:@"kucunguanli"]) {
                if (i == 0) {
                    [publishBtn setTitle:@"异常处理" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 5"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"调拨" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 6"] forState:UIControlStateNormal];
                }else if (i == 2){
                    
                    [publishBtn setTitle:@"现货展示区" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"现货展示区"] forState:UIControlStateNormal];
                    
                }
            }else{
                if (i == 0) {
                    [publishBtn setTitle:@"异常处理" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 5"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"调拨" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 6"] forState:UIControlStateNormal];
                }else if (i == 2){
                    
                    [publishBtn setTitle:@"现货展示区" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"现货展示区"] forState:UIControlStateNormal];
                    
                }
            }
        }
        [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(jumpFunctionView:) forControlEvents:UIControlEventTouchUpInside];
        [self.contetnView addSubview:publishBtn];
        [publishBtn bringSubviewToFront:self.contetnView];
    }
}


- (void)jumpFunctionView:(RSVariousButton *)publishBtn{
    if ([self.selectType isEqualToString:@"baobiaozhongxin1"]) {
        //DBGL_BBZX 大板报表中心
        //大板
        if ([publishBtn.currentTitle isEqualToString:@"大板库存余额表"]) {
            //DBGL_BBZX_KCYE大板库存余额
            if (self.usermodel.pwmsUser.DBGL_BBZX_KCYE == 1) {
                RSSLStatementViewController * slstatementVc = [[RSSLStatementViewController alloc]init];
                slstatementVc.usermodel = self.usermodel;
                slstatementVc.title = publishBtn.currentTitle;
                slstatementVc.selectFunctionType = publishBtn.currentTitle;
                [self.navigationController pushViewController:slstatementVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"大板库存流水账"]) {
            //大板库存流水账
            //DBGL_BBZX_KCLS大板库存流水
            if (self.usermodel.pwmsUser.DBGL_BBZX_KCLS == 1) {
                RSSLRunningAccountViewController * slrunningAccountVc = [[RSSLRunningAccountViewController alloc]init];
                slrunningAccountVc.usermodel = self.usermodel;
                slrunningAccountVc.title = publishBtn.currentTitle;
                slrunningAccountVc.selectFunctionType = publishBtn.currentTitle;
                [self.navigationController pushViewController:slrunningAccountVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"大板入库明细表"]) {
            //DBGL_BBZX_RKMX大板入库明细
            if (self.usermodel.pwmsUser.DBGL_BBZX_RKMX == 1) {
                RSSLEntryAndExitViewController * slEntryAndExitVc = [[RSSLEntryAndExitViewController alloc]init];
                slEntryAndExitVc.title = publishBtn.currentTitle;
                slEntryAndExitVc.selectFunctionType = publishBtn.currentTitle;
                slEntryAndExitVc.usermodel = self.usermodel;
                slEntryAndExitVc.searchTypeIndex = 1;
                [self.navigationController pushViewController:slEntryAndExitVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"大板出库明细表"]) {
            //DBGL_BBZX_CKMX大板出库明细
            if (self.usermodel.pwmsUser.DBGL_BBZX_CKMX == 1) {
                RSSLEntryAndExitViewController * slEntryAndExitVc = [[RSSLEntryAndExitViewController alloc]init];
                slEntryAndExitVc.title = publishBtn.currentTitle;
                slEntryAndExitVc.selectFunctionType = publishBtn.currentTitle;
                slEntryAndExitVc.usermodel = self.usermodel;
                slEntryAndExitVc.searchTypeIndex = 2;
                [self.navigationController pushViewController:slEntryAndExitVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
    }else if ([self.selectType isEqualToString:@"baobiaozhongxin"]){
        //HLGL_BBZX报表中心
        //HLGL_BBZX_KCYE荒料库存余额
        //HLGL_BBZX_KCLS荒料库存流水
        //HLGL_BBZX_RKMX荒料入库明细
        //HLGL_BBZX_CKMX 荒料出库明细
        //加工出库表
        if ([publishBtn.currentTitle isEqualToString:@"荒料库存余额表"]) {
            if (self.usermodel.pwmsUser.HLGL_BBZX_KCYE == 1) {
                // HLGL_BBZX_KCYE荒料库存余额
                RSPersonalBalanceViewController * personalBalanceVc = [[RSPersonalBalanceViewController alloc]init];
                personalBalanceVc.title = publishBtn.currentTitle;
                personalBalanceVc.selectFunctionType = publishBtn.currentTitle;
                personalBalanceVc.usermodel = self.usermodel;
                [self.navigationController pushViewController:personalBalanceVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"荒料库存流水账"]) {
            //荒料库存流水账
            //HLGL_BBZX_KCLS荒料库存流水
            if (self.usermodel.pwmsUser.HLGL_BBZX_KCLS == 1) {
                RSRunningAccountViewController * runningAccountVc = [[RSRunningAccountViewController alloc]init];
                runningAccountVc.title = publishBtn.currentTitle;
                runningAccountVc.selectFunctionType = publishBtn.currentTitle;
                runningAccountVc.usermodel = self.usermodel;
                [self.navigationController pushViewController:runningAccountVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"荒料入库明细表"]) {
            if (self.usermodel.pwmsUser.HLGL_BBZX_RKMX == 1) {
                //HLGL_BBZX_RKMX荒料入库明细
                RSRawMaterialViewController * rawMaterialVc = [[RSRawMaterialViewController alloc]init];
                rawMaterialVc.title = publishBtn.currentTitle;
                rawMaterialVc.selectFunctionType = publishBtn.currentTitle;
                rawMaterialVc.usermodel = self.usermodel;
                rawMaterialVc.searchTypeIndex = 1;
                [self.navigationController pushViewController:rawMaterialVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"荒料出库明细表"]) {
            if (self.usermodel.pwmsUser.HLGL_BBZX_CKMX == 1) {
                //HLGL_BBZX_CKMX 荒料出库明细
                RSRawMaterialViewController * rawMaterialVc = [[RSRawMaterialViewController alloc]init];
                rawMaterialVc.title = publishBtn.currentTitle;
                rawMaterialVc.selectFunctionType = publishBtn.currentTitle;
                rawMaterialVc.usermodel = self.usermodel;
                rawMaterialVc.searchTypeIndex = 2;
                [self.navigationController pushViewController:rawMaterialVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"加工跟单"]) {
            if (self.usermodel.pwmsUser.HLGL_BBZX_JGGDCK == 1 || self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1) {
            
            RSMachiningOutController * machiningoutVc = [[RSMachiningOutController alloc]init];
            
            machiningoutVc.usermodel = self.usermodel;
            machiningoutVc.selectType = self.selectType;
            machiningoutVc.selectFunctionType = publishBtn.currentTitle;
            [self.navigationController pushViewController:machiningoutVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"出材率"]) {
            if (self.usermodel.pwmsUser.HLGL_BBZX_CCL == 1) {
                NewSkipViewController * newSkipVc = [[NewSkipViewController alloc]init];
                [self.navigationController pushViewController:newSkipVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
    }else if([self.selectType isEqualToString:@"huangliaoruku"]){
        if ([publishBtn.currentTitle isEqualToString:@"采购入库"]) {
            if (self.usermodel.pwmsUser.HLGL_HLRK_CGRK == 1) {
                //HLGL_HLRK_CGRK 荒料采购入库
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.selectShow = @"BILL_BL_CGRK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"加工入库"]) {
            if (self.usermodel.pwmsUser.HLGL_HLRK_JGRK == 1) {
                //HLGL_HLRK_JGRK 荒料加工入库
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.selectShow = @"BILL_BL_JGRK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"盘盈入库"]) {
            if (self.usermodel.pwmsUser.HLGL_HLRK_PYRK == 1) {
                //HLGL_HLRK_PYRK 荒料盘盈入库
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.selectShow = @"BILL_BL_PYRK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
        if ([publishBtn.currentTitle isEqualToString:@"销售出库"]) {
            if (self.usermodel.pwmsUser.HLGL_HLCK_XSCK == 1) {
                //HLGL_HLCK_XSCK 荒料销售出库
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.selectShow = @"BILL_BL_XSCK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"加工出库"]) {
            if (self.usermodel.pwmsUser.HLGL_HLCK_JGCK == 1) {
                //HLGL_HLCK_JGCK 荒料加工出库
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.selectShow = @"BILL_BL_JGCK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"盘亏出库"]) {
            if (self.usermodel.pwmsUser.HLGL_HLCK_PKCK == 1) {
                //HLGL_HLCK_PKCK 荒料盘亏出库
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.selectShow = @"BILL_BL_PKCK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        if ([publishBtn.currentTitle isEqualToString:@"异常处理"]) {
            if (self.usermodel.pwmsUser.HLGL_KCGL_YCCL == 1) {
                //HLGL_KCGL_YCCL 荒料异常处理
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_BL_YCCL";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"调拨"]) {
            if (self.usermodel.pwmsUser.HLGL_KCGL_DB == 1) {
                //HLGL_KCGL_DB 荒料调拨
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_BL_DB";
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"现货展示区"]) {
            if (self.usermodel.pwmsUser.HLGL_KCGL_XHZS == 1) {
                RSBLAllSelectSegmentViewController * blSpotShowAreaVc = [[RSBLAllSelectSegmentViewController alloc]init];
                blSpotShowAreaVc.selectType = self.selectType;
                blSpotShowAreaVc.title = publishBtn.currentTitle;
                blSpotShowAreaVc.usermodel = self.usermodel;
                blSpotShowAreaVc.selectFunctionType = publishBtn.currentTitle;
                [self.navigationController pushViewController:blSpotShowAreaVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
    }else if ([self.selectType isEqualToString:@"dabanruku"]){
        if ([publishBtn.currentTitle isEqualToString:@"采购入库"]) {
            if (self.usermodel.pwmsUser.DBGL_DBRK_CGRK == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_CGRK";
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"加工入库"]) {
            //DBGL_DBRK_JGRK大板加工入库
            if (self.usermodel.pwmsUser.DBGL_DBRK_JGRK == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_JGRK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"盘盈入库"]) {
            //DBGL_DBRK_PYRK大板盘盈入库
            if (self.usermodel.pwmsUser.DBGL_DBRK_PYRK == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_PYRK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
        if ([publishBtn.currentTitle isEqualToString:@"销售出库"]) {
            //DBGL_DBCK_XSCK大板销售出库
            if (self.usermodel.pwmsUser.DBGL_DBCK_XSCK == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_XSCK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"加工出库"]) {
            //DBGL_DBCK_JGCK大板加工出库
            if (self.usermodel.pwmsUser.DBGL_DBCK_JGCK == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_JGCK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"盘亏出库"]) {
            //DBGL_DBCK_PKCK大板盘亏出库
            if (self.usermodel.pwmsUser.DBGL_DBCK_PKCK == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_PKCK";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        if ([publishBtn.currentTitle isEqualToString:@"异常处理"]) {
            //DBGL_KCGL_YCCL大板异常处理
            if (self.usermodel.pwmsUser.DBGL_KCGL_YCCL == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_YCCL";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"调拨"]) {
            //DBGL_KCGL_DB大板调拨
            if (self.usermodel.pwmsUser.DBGL_KCGL_DB == 1) {
                RSPersonalFunctionViewController * personalFunctionVc = [[RSPersonalFunctionViewController alloc]init];
                personalFunctionVc.selectType = self.selectType;
                personalFunctionVc.title = publishBtn.currentTitle;
                personalFunctionVc.selectFunctionType = publishBtn.currentTitle;
                personalFunctionVc.usermodel = self.usermodel;
                personalFunctionVc.selectShow = @"BILL_SL_DB";
                [self.navigationController pushViewController:personalFunctionVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
            }
        }
        if ([publishBtn.currentTitle isEqualToString:@"现货展示区"]) {
          if (self.usermodel.pwmsUser.DBGL_KCGL_XHZS == 1) {
            //HLGL_KCGL_DB 荒料调拨
            RSSLAllSelectSegmentViewController * slSpotShowAreaVc = [[RSSLAllSelectSegmentViewController alloc]init];
            slSpotShowAreaVc.selectType = self.selectType;
            slSpotShowAreaVc.title = publishBtn.currentTitle;
            slSpotShowAreaVc.selectFunctionType = publishBtn.currentTitle;
            slSpotShowAreaVc.usermodel = self.usermodel;
            [self.navigationController pushViewController:slSpotShowAreaVc animated:YES];
          }else{
            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
          }
        }
    }
}




- (void)dealloc{
    //self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}





@end
