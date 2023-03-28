//
//  RSTaoBaoTool.m
//  石来石往
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoTool.h"
#import "RSTaoBaoApplyShopViewController.h"
#import "RSTaobaoDistrictViewController.h"
#import "RSTaoBaoCommodityManagementViewController.h"
#import "RSTaobaoCollectionViewController.h"

@interface RSTaoBaoTool()<YBPopupMenuDelegate>

@property (nonatomic,strong)RSTaobaoUserModel * taobaoUsermodel;


@property (nonatomic,strong)UIViewController * viewContentController;


@property (nonatomic,strong)NSString * type;

@end



@implementation RSTaoBaoTool


- (void)showMenuContentType:(NSString *)type andOnView:(nonnull UIView *)view  andViewController:(UIViewController *)viewController andBlock:(nonnull void (^)(RSTaobaoUserModel * _Nonnull))block{
    RSWeakself
    [self loadTaoBaoUserInformation:^(BOOL isResult, RSTaobaoUserModel * _Nonnull taobaoUsermodel) {
        if (isResult) {
            NSArray * imageArray = [NSArray array];
            NSArray * array = [NSArray array];
            weakSelf.taobaoUsermodel = taobaoUsermodel;
            weakSelf.viewContentController = viewController;
            weakSelf.type = type;
            if ([self.type isEqualToString:@"搜索"] || [self.type isEqualToString:@"商店"] ||[self.type isEqualToString:@"活动"] ) {
                if ([taobaoUsermodel.userType isEqualToString:@"common"]) {
                    imageArray = @[@"主页",@"system-guanzhu复制",@"我的店铺"];
                    array = @[@"返回首页",@"收藏",@"我的店铺"];
                }else{
                    imageArray = @[@"主页",@"system-guanzhu复制",@"我的店铺"];
                    array = @[@"返回首页",@"收藏",@"我的店铺"];
                }
            }
//            else if ([self.type isEqualToString:@"活动"]){
//                if ([taobaoUsermodel.userType isEqualToString:@"common"]) {
//                    imageArray = @[@"主页",@"system-guanzhu复制",@"我的店铺"];
//                    array = @[@"返回首页",@"收藏",@"开通店铺"];
//                }else{
//                    imageArray = @[@"主页",@"收藏",@"我的店铺"];
//                    array = @[@"返回首页",@"system-guanzhu复制",@"我的店铺"];
//                }
//            }
            else if ([self.type isEqualToString:@"收藏"]){
                if ([taobaoUsermodel.userType isEqualToString:@"common"]) {
                    imageArray = @[@"主页",@"我的店铺"];
                    array = @[@"返回首页",@"我的店铺"];
                }else{
                    imageArray = @[@"主页",@"我的店铺"];
                    array = @[@"返回首页",@"我的店铺"];
                }
            }
//            else if ([self.type isEqualToString:@"商店"]){
//                if ([taobaoUsermodel.userType isEqualToString:@"common"]) {
//                    imageArray = @[@"主页",@"system-guanzhu复制",@"我的店铺"];
//                    array = @[@"返回首页",@"收藏",@"开通店铺"];
//                }else{
//                    imageArray = @[@"主页",@"system-guanzhu复制",@"我的店铺"];
//                    array = @[@"返回首页",@"收藏",@"我的店铺"];
//                }
//            }
            
            else{
                //首页
                if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
                    imageArray = @[@"system-guanzhu复制",@"我的店铺"];
                    array = @[@"收藏",@"我的店铺"];
                }else{
                    imageArray = @[@"system-guanzhu复制",@"我的店铺"];
                    array = @[@"收藏",@"我的店铺"];
                }
            }
            [YBPopupMenu showRelyOnView:view titles:array icons:imageArray menuWidth:190 andTag:0 delegate:self];
        }else{
            [SVProgressHUD showInfoWithStatus:@"你没有淘宝用户信息"];
        }
    }];
    if (block) {
        block(weakSelf.taobaoUsermodel);
    }
}





- (void)showMenuContentType:(NSString *)type andOnView:(nonnull UIView *)view  andViewController:(UIViewController *)viewController andUserModel:(RSTaobaoUserModel *) taobaoUsermodel{
    NSArray * imageArray = [NSArray array];
    NSArray * array = [NSArray array];
    self.viewContentController = viewController;
    self.type = type;
    self.taobaoUsermodel = taobaoUsermodel;
    if([self.type isEqualToString:@"首页"]){
        //首页
        if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
            imageArray = @[@"system-guanzhu复制",@"我的店铺"];
            array = @[@"收藏",@"我的店铺"];
        }else{
            imageArray = @[@"system-guanzhu复制",@"我的店铺"];
            array = @[@"收藏",@"我的店铺"];
        }
    }
    [YBPopupMenu showRelyOnView:view titles:array icons:imageArray menuWidth:190 andTag:0 delegate:self];
}




- (void)loadTaoBaoUserInformation:(void(^)(BOOL isResult,RSTaobaoUserModel * taobaoUsermodel))block{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if (verifykey.length > 0) {
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        //RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_TAOBAOUSERINFO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    RSTaobaoUserModel * taobaoUsermodel = [[RSTaobaoUserModel alloc]init];
                    taobaoUsermodel.address = json[@"data"][@"address"];
                    taobaoUsermodel.taoBaoUserID = [json[@"data"][@"id"] integerValue];
                    taobaoUsermodel.phone = json[@"data"][@"phone"];
                    taobaoUsermodel.shopLogo = json[@"data"][@"shopLogo"];
                    taobaoUsermodel.shopName = json[@"data"][@"shopName"];
                    taobaoUsermodel.userType = json[@"data"][@"userType"];
                    taobaoUsermodel.status = [json[@"data"][@"status"] integerValue];
                    //weakSelf.taobaoUsermodel = taobaoUsermodel;
                    block(true,taobaoUsermodel);
                }else{
                    [SVProgressHUD showErrorWithStatus:@"获取淘宝用户信息失败"];
                    block(false,nil);
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取淘宝用户信息失败"];
                block(false,nil);
            }
        }];
    }
}


- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    NSArray * array = [NSArray array];
    if ([self.type isEqualToString:@"搜索"] || [self.type isEqualToString:@"活动"] || [self.type isEqualToString:@"商店"]) {
        if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
            array = @[@"返回首页",@"收藏",@"我的店铺"];
        }else{
            array =  @[@"返回首页",@"收藏",@"我的店铺"];
        }
        NSString * str = array[index];
        if ([str isEqualToString:@"返回首页"]) {
            RSTaobaoDistrictViewController * vc = (RSTaobaoDistrictViewController *)self.viewContentController.navigationController.viewControllers[0];
            vc.taobaoUsermodel = self.taobaoUsermodel;
            [self.viewContentController.navigationController popToViewController:vc animated:YES];
        }else if([str isEqualToString:@"收藏"]){
            RSTaobaoCollectionViewController * taobaoCollectionVc = [[RSTaobaoCollectionViewController alloc]init];
            taobaoCollectionVc.taobaoUsermodel = self.taobaoUsermodel;
            [self.viewContentController.navigationController pushViewController:taobaoCollectionVc animated:YES];
        }else{
            if (self.taobaoUsermodel.status == 4) {
                //封禁状态
                [JHSysAlertUtil presentAlertViewWithTitle:@"因为你违反了相关责任问题" message:@"我司对你的淘石账户进行封禁" confirmTitle:@"确定" handler:nil];
            }else{
                if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
                    RSTaoBaoApplyShopViewController * taobaoApplyShopVc = [[RSTaoBaoApplyShopViewController alloc]init];
                    taobaoApplyShopVc.taobaoUsermodel = self.taobaoUsermodel;
                    [self.viewContentController.navigationController pushViewController:taobaoApplyShopVc animated:YES];
                }else{
                    RSTaoBaoCommodityManagementViewController * taobaoCommodityManagementViewVc = [[RSTaoBaoCommodityManagementViewController alloc]init];
                    taobaoCommodityManagementViewVc.taobaoUsermodel = self.taobaoUsermodel;
                    [self.viewContentController.navigationController pushViewController:taobaoCommodityManagementViewVc animated:YES];
                }
            }
        }
    }
    else if ([self.type isEqualToString:@"收藏"]){
        if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
            array = @[@"返回首页",@"我的店铺"];
        }else{
            array =  @[@"返回首页",@"我的店铺"];
        }
        NSString * str = array[index];
        if ([str isEqualToString:@"返回首页"]) {
            RSTaobaoDistrictViewController * vc =(RSTaobaoDistrictViewController *)self.viewContentController.navigationController.viewControllers[0];
            vc.taobaoUsermodel = self.taobaoUsermodel;
            [self.viewContentController.navigationController popToViewController:vc animated:YES];
            
        }else{
            if (self.taobaoUsermodel.status == 4) {
                //封禁状态
                [JHSysAlertUtil presentAlertViewWithTitle:@"因为你违反了相关责任问题" message:@"我司对你的淘石账户进行封禁" confirmTitle:@"确定" handler:nil];
            }else{
                if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
                    RSTaoBaoApplyShopViewController * taobaoApplyShopVc = [[RSTaoBaoApplyShopViewController alloc]init];
                    taobaoApplyShopVc.taobaoUsermodel = self.taobaoUsermodel;
                    
                    [self.viewContentController.navigationController pushViewController:taobaoApplyShopVc animated:YES];
                }else{
                    RSTaoBaoCommodityManagementViewController * taobaoCommodityManagementViewVc = [[RSTaoBaoCommodityManagementViewController alloc]init];
                    taobaoCommodityManagementViewVc.taobaoUsermodel = self.taobaoUsermodel;
                    
                    [self.viewContentController.navigationController pushViewController:taobaoCommodityManagementViewVc animated:YES];
                }
            }
        }
    }
//    else if ([self.type isEqualToString:@"商店"]){
//        if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
//            array = @[@"返回首页",@"收藏",@"开通店铺"];
//        }else{
//            array =  @[@"返回首页",@"收藏",@"我的店铺"];
//        }
//        NSString * str = array[index];
//        if ([str isEqualToString:@"返回首页"]) {
//            RSTaobaoDistrictViewController * vc = (RSTaobaoDistrictViewController *)self.viewContentController.navigationController.viewControllers[0];
//            vc.taobaoUsermodel = self.taobaoUsermodel;
//            [self.viewContentController.navigationController popToViewController:vc animated:YES];
//        }else if([str isEqualToString:@"收藏"]){
//            RSTaobaoCollectionViewController * taobaoCollectionVc = [[RSTaobaoCollectionViewController alloc]init];
//            taobaoCollectionVc.taobaoUsermodel = self.taobaoUsermodel;
//            [self.viewContentController.navigationController pushViewController:taobaoCollectionVc animated:YES];
//        }else{
//            if (self.taobaoUsermodel.status == 4) {
//                //封禁状态
//                [JHSysAlertUtil presentAlertViewWithTitle:@"因为你违反了相关责任问题" message:@"我司对你的淘石账户进行封禁" confirmTitle:@"确定" handler:nil];
//            }else{
//                if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
//                    RSTaoBaoApplyShopViewController * taobaoApplyShopVc = [[RSTaoBaoApplyShopViewController alloc]init];
//                    taobaoApplyShopVc.taobaoUsermodel = self.taobaoUsermodel;
//                    [self.viewContentController.navigationController pushViewController:taobaoApplyShopVc animated:YES];
//                }else{
//                    RSTaoBaoCommodityManagementViewController * taobaoCommodityManagementViewVc = [[RSTaoBaoCommodityManagementViewController alloc]init];
//                    taobaoCommodityManagementViewVc.taobaoUsermodel = self.taobaoUsermodel;
//                    [self.viewContentController.navigationController pushViewController:taobaoCommodityManagementViewVc animated:YES];
//                }
//            }
//        }
//    }
    else{
        //首页
        if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
            array = @[@"收藏",@"我的店铺"];
        }else{
            array = @[@"收藏",@"我的店铺"];
        }
        NSString * str = array[index];
        if([str isEqualToString:@"收藏"]){
            RSTaobaoCollectionViewController * taobaoCollectionVc = [[RSTaobaoCollectionViewController alloc]init];
            taobaoCollectionVc.taobaoUsermodel = self.taobaoUsermodel;
            [self.viewContentController.navigationController pushViewController:taobaoCollectionVc animated:YES];
        }
        else{
            if (self.taobaoUsermodel.status == 4) {
                //封禁状态
                [JHSysAlertUtil presentAlertViewWithTitle:@"因为你违反了相关责任问题" message:@"我司对你的淘石账户进行封禁" confirmTitle:@"确定" handler:nil];
            }else{
                if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
                    RSTaoBaoApplyShopViewController * taobaoApplyShopVc = [[RSTaoBaoApplyShopViewController alloc]init];
                    taobaoApplyShopVc.taobaoUsermodel = self.taobaoUsermodel;
                    [self.viewContentController.navigationController pushViewController:taobaoApplyShopVc animated:YES];
                }else{
                    RSTaoBaoCommodityManagementViewController * taobaoCommodityManagementViewVc = [[RSTaoBaoCommodityManagementViewController alloc]init];
                    taobaoCommodityManagementViewVc.taobaoUsermodel = self.taobaoUsermodel;
                    [self.viewContentController.navigationController pushViewController:taobaoCommodityManagementViewVc animated:YES];
                }
            }
        }
    }
}


@end
