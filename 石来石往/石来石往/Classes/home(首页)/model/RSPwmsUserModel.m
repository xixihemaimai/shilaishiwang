//
//  RSPwmsUserModel.m
//  石来石往
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPwmsUserModel.h"

@implementation RSPwmsUserModel



- (void)encodeWithCoder:(NSCoder *)aCoder{
   
    
    
    
    
    
    [aCoder encodeBool:self.DBGL forKey:@"DBGL"];
    
    [aCoder encodeBool:self.DBGL_BBZX forKey:@"DBGL_BBZX"];
    [aCoder encodeBool:self.DBGL_BBZX_CKMX forKey:@"DBGL_BBZX_CKMX"];
    [aCoder encodeBool:self.DBGL_BBZX_KCLS forKey:@"DBGL_BBZX_KCLS"];
    [aCoder encodeBool:self.DBGL_BBZX_KCYE forKey:@"DBGL_BBZX_KCYE"];
    [aCoder encodeBool:self.DBGL_BBZX_RKMX forKey:@"DBGL_BBZX_RKMX"];
    [aCoder encodeBool:self.DBGL_DBCK forKey:@"DBGL_DBCK"];
    [aCoder encodeBool:self.DBGL_DBCK_JGCK forKey:@"DBGL_DBCK_JGCK"];
    [aCoder encodeBool:self.DBGL_DBCK_PKCK forKey:@"DBGL_DBCK_PKCK"];
    [aCoder encodeBool:self.DBGL_DBCK_XSCK forKey:@"DBGL_DBCK_XSCK"];
    [aCoder encodeBool:self.DBGL_DBRK forKey:@"DBGL_DBRK"];
    [aCoder encodeBool:self.DBGL_DBRK_CGRK forKey:@"DBGL_DBRK_CGRK"];
    [aCoder encodeBool:self.DBGL_DBRK_JGRK forKey:@"DBGL_DBRK_JGRK"];
    [aCoder encodeBool:self.DBGL_DBRK_PYRK forKey:@"DBGL_DBRK_PYRK"];
    
     [aCoder encodeBool:self.DBGL_KCGL forKey:@"DBGL_KCGL"];
     [aCoder encodeBool:self.DBGL_KCGL_DB forKey:@"DBGL_KCGL_DB"];
     [aCoder encodeBool:self.DBGL_KCGL_YCCL forKey:@"DBGL_KCGL_YCCL"];
 
    [aCoder encodeBool:self.HLGL forKey:@"HLGL"];
    [aCoder encodeBool:self.HLGL_BBZX forKey:@"HLGL_BBZX"];
    [aCoder encodeBool:self.HLGL_BBZX_CKMX forKey:@"HLGL_BBZX_CKMX"];
    [aCoder encodeBool:self.HLGL_BBZX_KCLS forKey:@"HLGL_BBZX_KCLS"];
    
     [aCoder encodeBool:self.HLGL_BBZX_KCYE forKey:@"HLGL_BBZX_KCYE"];
     [aCoder encodeBool:self.HLGL_BBZX_RKMX forKey:@"HLGL_BBZX_RKMX"];
    
     [aCoder encodeBool:self.HLGL_HLCK forKey:@"HLGL_HLCK"];
     [aCoder encodeBool:self.HLGL_HLCK_JGCK forKey:@"HLGL_HLCK_JGCK"];
     [aCoder encodeBool:self.HLGL_HLCK_PKCK forKey:@"HLGL_HLCK_PKCK"];
     [aCoder encodeBool:self.HLGL_HLCK_XSCK forKey:@"HLGL_HLCK_XSCK"];
     [aCoder encodeBool:self.HLGL_HLRK forKey:@"HLGL_HLRK"];
     [aCoder encodeBool:self.HLGL_HLRK_CGRK forKey:@"HLGL_HLRK_CGRK"];
     [aCoder encodeBool:self.HLGL_HLRK_JGRK forKey:@"HLGL_HLRK_JGRK"];
     [aCoder encodeBool:self.HLGL_HLRK_PYRK forKey:@"HLGL_HLRK_PYRK"];
     [aCoder encodeBool:self.HLGL_KCGL forKey:@"HLGL_KCGL"];
    
     [aCoder encodeBool:self.HLGL_KCGL_DB forKey:@"HLGL_KCGL_DB"];
     [aCoder encodeBool:self.HLGL_KCGL_YCCL forKey:@"HLGL_KCGL_YCCL"];
     [aCoder encodeBool:self.JCSJ forKey:@"JCSJ"];
     [aCoder encodeBool:self.JCSJ_CKGL forKey:@"JCSJ_CKGL"];
     [aCoder encodeBool:self.JCSJ_WLZD forKey:@"JCSJ_WLZD"];
    
    [aCoder encodeBool:self.TYQX forKey:@"TYQX"];
    [aCoder encodeBool:self.XTGL forKey:@"XTGL"];
    [aCoder encodeBool:self.XTGL_JSGL forKey:@"XTGL_JSGL"];
    [aCoder encodeBool:self.XTGL_YHGL forKey:@"XTGL_YHGL"];
    [aCoder encodeBool:self.XTGL_MBGL forKey:@"XTGL_MBGL"];
    [aCoder encodeBool:self.HLGL_BBZX_JGGDCZ forKey:@"HLGL_BBZX_JGGDCZ"];
    [aCoder encodeBool:self.HLGL_BBZX_JGGDCK forKey:@"HLGL_BBZX_JGGDCK"];
    [aCoder encodeBool:self.JCSJ_JGC forKey:@"JCSJ_JGC"];
 
    [aCoder encodeBool:self.HLGL_KCGL_XHZS forKey:@"HLGL_KCGL_XHZS"];
    [aCoder encodeBool:self.DBGL_KCGL_XHZS forKey:@"DBGL_KCGL_XHZS"];
    [aCoder encodeBool:self.HLGL_BBZX_CCL forKey:@"HLGL_BBZX_CCL"];
    
    
    [aCoder encodeObject:self.companyName forKey:@"companyName"];
    
    [aCoder encodeInteger:self.pwmsUserModelID forKey:@"pwmsUserModelID"];
    [aCoder encodeInteger:self.parentId forKey:@"parentId"];
    [aCoder encodeInteger:self.roleId forKey:@"roleId"];
    [aCoder encodeInteger:self.sysUserId forKey:@"sysUserId"];
    
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userType forKey:@"userType"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        self.DBGL = [aDecoder decodeBoolForKey:@"DBGL"];
        self.DBGL_BBZX = [aDecoder decodeBoolForKey:@"DBGL_BBZX"];
        self.DBGL_BBZX_CKMX = [aDecoder decodeBoolForKey:@"DBGL_BBZX_CKMX"];
        self.DBGL_BBZX_KCLS = [aDecoder decodeBoolForKey:@"DBGL_BBZX_KCLS"];
        self.DBGL_BBZX_KCYE = [aDecoder decodeBoolForKey:@"DBGL_BBZX_KCYE"];
        self.DBGL_BBZX_RKMX = [aDecoder decodeBoolForKey:@"DBGL_BBZX_RKMX"];
        self.DBGL_DBCK = [aDecoder decodeBoolForKey:@"DBGL_DBCK"];
        self.DBGL_DBCK_JGCK = [aDecoder decodeBoolForKey:@"DBGL_DBCK_JGCK"];
        self.DBGL_DBCK_PKCK = [aDecoder decodeBoolForKey:@"DBGL_DBCK_PKCK"];
        self.DBGL_DBCK_XSCK = [aDecoder decodeBoolForKey:@"DBGL_DBCK_XSCK"];
        self.DBGL_DBRK = [aDecoder decodeBoolForKey:@"DBGL_DBRK"];
        self.DBGL_DBRK_CGRK = [aDecoder decodeBoolForKey:@"DBGL_DBRK_CGRK"];
        self.DBGL_DBRK_JGRK = [aDecoder decodeBoolForKey:@"DBGL_DBRK_JGRK"];
        self.DBGL_DBRK_PYRK = [aDecoder decodeBoolForKey:@"DBGL_DBRK_PYRK"];
        self.DBGL_KCGL = [aDecoder decodeBoolForKey:@"DBGL_KCGL"];
        self.DBGL_KCGL_DB = [aDecoder decodeBoolForKey:@"DBGL_KCGL_DB"];
        self.DBGL_KCGL_YCCL = [aDecoder decodeBoolForKey:@"DBGL_KCGL_YCCL"];
        
        
        /**
         DBGL = 1;大板管理
         "DBGL_BBZX" = 1; 大板报表中心
         "DBGL_BBZX_CKMX" = 1; 大板出库明细
         "DBGL_BBZX_KCLS" = 1; 大板库存流水
         "DBGL_BBZX_KCYE" = 1; 大板库存余额
         "DBGL_BBZX_RKMX" = 1; 大板入库明细
         "DBGL_DBCK" = 1; 大板出库
         "DBGL_DBCK_JGCK" = 1; 大板加工出库
         "DBGL_DBCK_PKCK" = 1;大板盘亏出库
         "DBGL_DBCK_XSCK" = 1; 大板销售出库
         "DBGL_DBRK" = 1;大板入库
         "DBGL_DBRK_CGRK" = 1;大板采购入库
         "DBGL_DBRK_JGRK" = 1;大板加工入库
         "DBGL_DBRK_PYRK" = 1;大板盘盈入库
         "DBGL_KCGL" = 1;大板库存管理
         "DBGL_KCGL_DB" = 1;大板调拨
         "DBGL_KCGL_YCCL" = 1;大板异常处理
         HLGL = 1;荒料管理
         "HLGL_BBZX" = 1;荒料报表中心
         "HLGL_BBZX_CKMX" = 1;荒料出库明细
         "HLGL_BBZX_KCLS" = 1;荒料库存流水
         "HLGL_BBZX_KCYE" = 1;荒料库存余额
         "HLGL_BBZX_RKMX" = 1;荒料入库明细
         "HLGL_HLCK" = 1;荒料出库
         "HLGL_HLCK_JGCK" = 1;荒料加工出库
         "HLGL_HLCK_PKCK" = 1;荒料盘亏出库
         "HLGL_HLCK_XSCK" = 1;荒料销售出库
         "HLGL_HLRK" = 1;荒料入库
         "HLGL_HLRK_CGRK" = 1;荒料采购入库
         "HLGL_HLRK_JGRK" = 1;荒料加工入库
         "HLGL_HLRK_PYRK" = 1;荒料盘盈入库
         "HLGL_KCGL" = 1;荒料库存管理
         "HLGL_KCGL_DB" = 1;荒料调拨
         "HLGL_KCGL_YCCL" = 1;荒料异常处理
         JCSJ = 1;基础数据
         "JCSJ_CKGL" = 1;仓库管理
         "JCSJ_WLZD" = 1;物料字典
         TYQX = 1;通用权利
         XTGL = 1;系统管理
         "XTGL_JSGL" = 1;角色管理
         "XTGL_YHGL" = 1;用户管理
         "XTGL_MBGL" = 1;模板管理
         HLGL_KCGL_JGGDCZ        加工跟单操作  （勾上此权限有加工跟单所有权限）
         HLGL_KCGL_JGGDCK        加工跟单查看  （勾上此权限有加工跟单查看权限）
         HLGL_KCGL_XHZS 现货展示(荒料)
         
         DBGL_KCGL_XHZS 现货展示(大板)
         HLGL_BBZX_CCL 出材率
         加工厂字典权限节点
         JCSJ_JGC   加工厂
         
         
         
         
         */
        self.HLGL = [aDecoder decodeBoolForKey:@"HLGL"];
        self.HLGL_BBZX = [aDecoder decodeBoolForKey:@"HLGL_BBZX"];
        self.HLGL_BBZX_CKMX = [aDecoder decodeBoolForKey:@"HLGL_BBZX_CKMX"];
         self.HLGL_BBZX_KCLS = [aDecoder decodeBoolForKey:@"HLGL_BBZX_KCLS"];
         self.HLGL_BBZX_KCYE = [aDecoder decodeBoolForKey:@"HLGL_BBZX_KCYE"];
         self.HLGL_BBZX_RKMX = [aDecoder decodeBoolForKey:@"HLGL_BBZX_RKMX"];
         self.HLGL_HLCK = [aDecoder decodeBoolForKey:@"HLGL_HLCK"];
         self.HLGL_HLCK_JGCK = [aDecoder decodeBoolForKey:@"HLGL_HLCK_JGCK"];
         self.HLGL_HLCK_PKCK = [aDecoder decodeBoolForKey:@"HLGL_HLCK_PKCK"];
         self.HLGL_HLCK_XSCK = [aDecoder decodeBoolForKey:@"HLGL_HLCK_XSCK"];
         self.HLGL_HLRK = [aDecoder decodeBoolForKey:@"HLGL_HLRK"];
         self.HLGL_HLRK_CGRK = [aDecoder decodeBoolForKey:@"HLGL_HLRK_CGRK"];
         self.HLGL_HLRK_JGRK = [aDecoder decodeBoolForKey:@"HLGL_HLRK_JGRK"];
         self.HLGL_HLRK_PYRK = [aDecoder decodeBoolForKey:@"HLGL_HLRK_PYRK"];
         self.HLGL_KCGL = [aDecoder decodeBoolForKey:@"HLGL_KCGL"];
         self.HLGL_KCGL_DB = [aDecoder decodeBoolForKey:@"HLGL_KCGL_DB"];
        
        self.HLGL_KCGL_YCCL = [aDecoder decodeBoolForKey:@"HLGL_KCGL_YCCL"];
        self.JCSJ = [aDecoder decodeBoolForKey:@"JCSJ"];
        self.JCSJ_CKGL = [aDecoder decodeBoolForKey:@"JCSJ_CKGL"];
        self.JCSJ_WLZD = [aDecoder decodeBoolForKey:@"JCSJ_WLZD"];
        self.TYQX = [aDecoder decodeBoolForKey:@"TYQX"];
        self.XTGL = [aDecoder decodeBoolForKey:@"XTGL"];
        self.XTGL_JSGL = [aDecoder decodeBoolForKey:@"XTGL_JSGL"];
        self.XTGL_YHGL = [aDecoder decodeBoolForKey:@"XTGL_YHGL"];
        self.XTGL_MBGL = [aDecoder decodeBoolForKey:@"XTGL_MBGL"];
        
        /**
         [aCoder encodeBool:self.HLGL_KCGL_JGGDCZ forKey:@"HLGL_KCGL_JGGDCZ"];
         [aCoder encodeBool:self.HLGL_KCGL_JGGDCK forKey:@"HLGL_KCGL_JGGDCK"];
         [aCoder encodeBool:self.JCSJ_JGC forKey:@"JCSJ_JGC"];
         */
        self.HLGL_BBZX_JGGDCZ = [aDecoder decodeBoolForKey:@"HLGL_BBZX_JGGDCZ"];
        self.HLGL_BBZX_JGGDCK = [aDecoder decodeBoolForKey:@"HLGL_BBZX_JGGDCK"];
        self.JCSJ_JGC = [aDecoder decodeBoolForKey:@"JCSJ_JGC"];
        
        self.HLGL_KCGL_XHZS = [aDecoder decodeBoolForKey:@"HLGL_KCGL_XHZS"];
        self.DBGL_KCGL_XHZS = [aDecoder decodeBoolForKey:@"DBGL_KCGL_XHZS"];
        self.HLGL_BBZX_CCL = [aDecoder decodeBoolForKey:@"HLGL_BBZX_CCL"];
        
        self.companyName = [aDecoder decodeObjectForKey:@"companyName"];
         self.pwmsUserModelID = [aDecoder decodeIntegerForKey:@"pwmsUserModelID"];
         self.parentId = [aDecoder decodeIntegerForKey:@"parentId"];
         self.roleId = [aDecoder decodeIntegerForKey:@"roleId"];
         self.sysUserId = [aDecoder decodeIntegerForKey:@"sysUserId"];
         self.userName = [aDecoder decodeObjectForKey:@"userName"];
         self.userType = [aDecoder decodeObjectForKey:@"userType"];
    }
    return self;
}


+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"pwmsUserModelID" : @"id"
             };
}





@end
