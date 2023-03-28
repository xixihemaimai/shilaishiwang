//
//  RSTemplateModel.h
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTemplateModel : NSObject

/**
 
 模板ID    id    Int
 模板名称    modelName    String
 模板类别    modelType    String
 所属用户    pwmsUserId    Int
 模板状态    status    String
 审核备注    notes    String
 模板配置    model    String
 是否默认模板    isDefault    Int
 模板图片地址    image    String
 创建人    createUser    String
 创建时间    createTime    String
 修改人    updateUser    String
 修改时间    updateTime    String
 
 */
@property (nonatomic,assign)NSInteger tempID;
@property (nonatomic,assign)NSInteger pwmsUserId;
@property (nonatomic,assign)NSInteger isDefault;
@property (nonatomic,strong)NSString * modelName;
@property (nonatomic,strong)NSString * modelType;
@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,strong)NSString * status;
@property (nonatomic,strong)NSString * notes;
@property (nonatomic,strong)NSString * model;
@property (nonatomic,strong)NSString * image;
@property (nonatomic,strong)NSString * createUser;
@property (nonatomic,strong)NSString * updateUser;
@property (nonatomic,strong)NSString * updateTime;

@end

NS_ASSUME_NONNULL_END
