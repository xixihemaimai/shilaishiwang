//
//  RSApplyListModel.h
//  石来石往
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSApplyListModel : NSObject



 /**
 个人版账户ID    id    Int
 账户名称    userName    String    主账号 账户名称和公司名称相同
 公司名称    companyName    String    主账号 账户名称和公司名称相同
 联系人电话    contactPhone    String    联系人电话
 审核结果备注    notes    String
 状态    status    Int     0 审核中 1 正常
 申请时间    createTime    String
 石来石往账户ID    sysUserId    Int
 
  private String signingMode;
 */


/**账户名称 */
@property (nonatomic,strong)NSString * userName;
/**个人版账户ID*/
@property (nonatomic,assign)NSInteger applyID;
/**公司名称 */
@property (nonatomic,strong)NSString * companyName;
/**联系人电话*/
@property (nonatomic,strong)NSString * contactPhone;
/**审核结果备注*/
@property (nonatomic,strong)NSString * notes;
/**状态*/
@property (nonatomic,assign)NSInteger status;
/** 申请时间  */
@property (nonatomic,strong)NSString * createTime;
/**石来石往账户ID*/
@property (nonatomic,assign)NSInteger sysUserId;
/**模式*/
@property (nonatomic,strong)NSString * signingMode;

@end

NS_ASSUME_NONNULL_END
