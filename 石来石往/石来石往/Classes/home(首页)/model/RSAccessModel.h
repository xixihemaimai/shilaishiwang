//
//  RSAccessModel.h
//  石来石往
//
//  Created by mac on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAccessModel : NSObject


/**系统管理*/
@property (nonatomic,assign)BOOL SysManage;
/**移动管理*/
@property (nonatomic,assign)BOOL appManage;
/**前端管理*/
@property (nonatomic,assign)BOOL webManage;
/**移动权限管理*/
@property (nonatomic,assign)BOOL appManage_qxgl;
/**移动我的收藏*/
@property (nonatomic,assign)BOOL appManage_sc;
/**移动石种图片上传*/
@property (nonatomic,assign)BOOL appManage_tppp;
/**移动商圈*/
@property (nonatomic,assign)BOOL appManage_sq;
/**移动业务管理*/
@property (nonatomic,assign)BOOL appManage_ywbl;
/**移动报表中心*/
@property (nonatomic,assign)BOOL appManage_ywbl_bbzx;

/**移动大板出库*/
@property (nonatomic,assign)BOOL appManage_ywbl_dbck;

/**移动荒料出库*/
@property (nonatomic,assign)BOOL appManage_ywbl_hlck;
/**个人中心*/
@property (nonatomic,assign)BOOL appManage_grzx;
/**移动出库记录*/
@property (nonatomic,assign)BOOL appManage_ywbl_ckjl;
/**移动等级评定*/
@property (nonatomic,assign)BOOL appManage_ywbl_djpd;

/**移动结算中心*/
@property (nonatomic,assign)BOOL appManage_ywbl_jszx;

@property (nonatomic,assign)BOOL publicAccess;





@end
