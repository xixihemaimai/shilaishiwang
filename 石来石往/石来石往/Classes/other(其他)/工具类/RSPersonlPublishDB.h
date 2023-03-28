//
//  RSPersonlPublishDB.h
//  石来石往
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
//荒料入库模型
#import "RSOcrBlockJsonModel.h"
#import "RSOcrBlockDetailModel.h"
#import "RSStoragemanagementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSPersonlPublishDB : NSObject
{
    /**数据库*/
    FMDatabase * _db;
}


/**判断创建了那些表*/
@property (nonatomic,strong)NSString * creatList;


//- (BOOL)creatSQLContentTable;

- (RSPersonlPublishDB *)initWithCreatTypeList:(NSString * )creatList;


/**创建数据表*/
- (BOOL)createContentTable;


//增加数据
-(BOOL)addContentID:(NSInteger)contentID andCode:(NSString *)code andCreateTime:(NSString *)createTime andCreateUser:(NSInteger)createUser andName:(NSString *)name andPwmsUserId:(NSInteger)pwmsUserId andStatus:(NSInteger)status andUpdateTime:(NSString *)updateTime andUpdateUser:(NSInteger)updateUser
         andWhsType:(NSString *)whsType andColor:(NSString *)color andType:(NSString *)type
         andColorId:(NSString *)colorId andTypeId:(NSString *)typeId;


/**批处理数据 仅作示例*/
- (void)batchAddMutableArray:(NSMutableArray *)array;


/**搜索内容*/
- (NSMutableArray*)serachContent:(NSString*)searchText;


/**更新数据*/
- (BOOL)updateContentID:(NSInteger)ID andCode:(NSString *)code andCreateTime:(NSString *)createTime andCreateUser:(NSInteger)createUser andName:(NSString *)name andPwmsUserId:(NSInteger)pwmsUserId andStatus:(NSInteger)status andUpdateTime:(NSString *)updateTime andUpdateUser:(NSInteger)updateUser andWhsType:(NSString *)whsType andColor:(NSString *)color andType:(NSString *)type andColorID:(NSInteger)colorId andTypeID:(NSInteger)typeId;

/**获取所有数据*/
- (NSMutableArray*)getAllContent;


/**删除单条内容*/
- (void)deleteContent:(NSInteger)ID;


/**删除所有数据*/
- (void)deleteAllContent;
/**搜索荒料单条物料的数据*/
//- (RSOcrBlockDetailModel *)searchNameContent:(RSOcrBlockDetailModel *)searchStr;
- (NSMutableArray *)searchNameContent:(NSArray *)searchArray;

/**搜索大板单条物料的数据*/
- (NSMutableArray *)searchSLNameContent:(NSArray *)searchArray;


//搜索荒料和大板仓库的位置
- (NSMutableArray*)getAllContent:(NSString *)whsType;

//搜索仓库的ID的模型
- (NSMutableArray *)getWarehouseID:(NSInteger)warehouseID;
@end

NS_ASSUME_NONNULL_END
