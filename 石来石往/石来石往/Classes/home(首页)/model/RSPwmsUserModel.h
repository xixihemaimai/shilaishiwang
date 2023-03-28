//
//  RSPwmsUserModel.h
//  石来石往
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSPwmsUserModel : NSObject<NSCopying>
/**权限列表*/
/**大板管理*/
@property (nonatomic,assign)BOOL DBGL;
/**大板报表中心*/
@property (nonatomic,assign)BOOL DBGL_BBZX;
/**大板出库明细*/
@property (nonatomic,assign)BOOL DBGL_BBZX_CKMX;
/**大板库存流水*/
@property (nonatomic,assign)BOOL DBGL_BBZX_KCLS;
/**大板库存余额*/
@property (nonatomic,assign)BOOL DBGL_BBZX_KCYE;
/**大板入库明细*/
@property (nonatomic,assign)BOOL DBGL_BBZX_RKMX;
/**大板出库*/
@property (nonatomic,assign)BOOL DBGL_DBCK;
/**大板加工出库*/
@property (nonatomic,assign)BOOL DBGL_DBCK_JGCK;
/**大板盘亏出库*/
@property (nonatomic,assign)BOOL DBGL_DBCK_PKCK;
/**大板销售出库*/
@property (nonatomic,assign)BOOL DBGL_DBCK_XSCK;
/**大板入库*/
@property (nonatomic,assign)BOOL DBGL_DBRK;
/**大板采购入库*/
@property (nonatomic,assign)BOOL DBGL_DBRK_CGRK;
/**大板加工入库*/
@property (nonatomic,assign)BOOL DBGL_DBRK_JGRK;
/**大板盘盈入库*/
@property (nonatomic,assign)BOOL DBGL_DBRK_PYRK;
/**大板库存管理*/
@property (nonatomic,assign)BOOL DBGL_KCGL;
/**大板调拨*/
@property (nonatomic,assign)BOOL DBGL_KCGL_DB;
/**大板异常处理*/
@property (nonatomic,assign)BOOL DBGL_KCGL_YCCL;
/**荒料管理*/
@property (nonatomic,assign)BOOL HLGL;
/**荒料报表中心*/
@property (nonatomic,assign)BOOL HLGL_BBZX;
/**荒料出库明细*/
@property (nonatomic,assign)BOOL HLGL_BBZX_CKMX;
/**荒料库存流水*/
@property (nonatomic,assign)BOOL HLGL_BBZX_KCLS;
/**荒料库存余额*/
@property (nonatomic,assign)BOOL HLGL_BBZX_KCYE;
/**荒料入库明细*/
@property (nonatomic,assign)BOOL HLGL_BBZX_RKMX;
/**荒料出库*/
@property (nonatomic,assign)BOOL HLGL_HLCK;
/**荒料加工出库*/
@property (nonatomic,assign)BOOL HLGL_HLCK_JGCK;
/**荒料盘亏出库*/
@property (nonatomic,assign)BOOL HLGL_HLCK_PKCK;
/**荒料销售出库*/
@property (nonatomic,assign)BOOL HLGL_HLCK_XSCK;
/**荒料入库*/
@property (nonatomic,assign)BOOL HLGL_HLRK;
/**荒料采购入库*/
@property (nonatomic,assign)BOOL HLGL_HLRK_CGRK;
/**荒料加工入库*/
@property (nonatomic,assign)BOOL HLGL_HLRK_JGRK;
/**荒料盘盈入库*/
@property (nonatomic,assign)BOOL HLGL_HLRK_PYRK;
/**荒料库存管理*/
@property (nonatomic,assign)BOOL HLGL_KCGL;
/**荒料调拨*/
@property (nonatomic,assign)BOOL HLGL_KCGL_DB;
/**荒料异常处理*/
@property (nonatomic,assign)BOOL HLGL_KCGL_YCCL;
/**基础数据*/
@property (nonatomic,assign)BOOL JCSJ;
/**仓库管理*/
@property (nonatomic,assign)BOOL JCSJ_CKGL;
/**物料字典*/
@property (nonatomic,assign)BOOL JCSJ_WLZD;
/**通用权利*/
@property (nonatomic,assign)BOOL TYQX;
/**系统管理*/
@property (nonatomic,assign)BOOL XTGL;
/**角色管理*/
@property (nonatomic,assign)BOOL XTGL_JSGL;
/**用户管理*/
@property (nonatomic,assign)BOOL XTGL_YHGL;
/**模板管理*/
@property (nonatomic,assign)BOOL XTGL_MBGL;
/**加工跟单操作*/
@property (nonatomic,assign)BOOL HLGL_BBZX_JGGDCZ;
/**加工跟单查看*/
@property (nonatomic,assign)BOOL HLGL_BBZX_JGGDCK;
/**加工厂字典权限节点 加工厂*/
@property (nonatomic,assign)BOOL JCSJ_JGC;
/**现货展示(荒料)*/
@property (nonatomic,assign)BOOL HLGL_KCGL_XHZS;
/**现货展示(大板)*/
@property (nonatomic,assign)BOOL DBGL_KCGL_XHZS;
/**出材率*/
@property (nonatomic,assign)BOOL HLGL_BBZX_CCL;






/**公司名称*/
@property (nonatomic,strong)NSString * companyName;

/**个人版用户ID*/
@property (nonatomic,assign)NSInteger pwmsUserModelID;
/**个人版主账号ID*/
@property (nonatomic,assign)NSInteger parentId;
/**个人版角色ID*/
@property (nonatomic,assign)NSInteger roleId;

/**所属石来石往用户ID*/
@property (nonatomic,assign)NSInteger sysUserId;
/**用户名称*/
@property (nonatomic,strong)NSString * userName;
/**个人类型*/
@property (nonatomic,strong)NSString * userType;


@end

NS_ASSUME_NONNULL_END
