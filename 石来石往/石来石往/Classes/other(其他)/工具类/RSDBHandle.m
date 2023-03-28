//
//  RSDBHandle.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDBHandle.h"
#import <FMDatabase.h>
@implementation RSDBHandle
static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"searchModel.sqlite"];
    
    
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_searchModel (id integer PRIMARY KEY, searchModel blob NOT NULL, searchModel_idstr varchar NOT NULL);"];
}


+ (NSDictionary *)statusesWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (params[@"category"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_searchModel WHERE searchModel_idstr = %@ ;", params[@"category"]];
    }else{
        sql = @"SELECT * FROM t_searchModel;";
    }
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"searchModel"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        return status;
    }
    return @{};
}

+ (void)saveStatuses:(NSDictionary *)statuses andParam:(NSDictionary *)ParamDict
{
    NSString *category = ParamDict[@"category"];
    
    [RSDBHandle delect:ParamDict[@"category"]];
    
    NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:statuses];
    [_db executeUpdateWithFormat:@"INSERT INTO t_searchModel(searchModel, searchModel_idstr) VALUES (%@, %@);", statusData, category];
}

+ (BOOL)delect:(NSString *)searchModel_idstr
{
    BOOL success = YES;
    NSString * newSql = [NSString stringWithFormat:@"DELETE  FROM t_searchModel WHERE searchModel_idstr = ?"];
    BOOL isCan =  [_db executeUpdate:newSql,searchModel_idstr];
    if (!isCan) {
        success = NO;
        
      //  NSLog(@"删除失败");
    }
    return success;
}


//
//+ (void)deleteSearchModelName:(NSArray *)array{
//    
//    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":array};
//    
//    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
//    NSDictionary *parmDict  = @{@"category":@"1"};
//    
//    
//    
//    [RSDBHandle saveStatuses:searchDict andParam:parmDict];
//}


/*
 - (void)prepareData
 {

   测试数据 ，字段暂时 只用一个 titleString，后续可以根据需求 相应加入新的字段
 
,@{@"content_name":@"口红"},@{@"content_name":@"眼霜"},@{@"content_name":@"洗面奶"},@{@"content_name":@"防晒霜"},@{@"content_name":@"补水"},@{@"content_name":@"香水"},@{@"content_name":@"眉笔"}
NSDictionary *testDict = @{@"section_id":@"1",@"section_title":@"热搜",@"section_content":@[@{@"content_name":@"奥特曼"},@{@"content_name":@"白玉兰"}]};
NSMutableArray *testArray = [@[] mutableCopy];
[testArray addObject:testDict];

 去数据查看 是否有数据
NSDictionary *parmDict  = @{@"category":@"1"};
NSDictionary *dbDictionary =  [RSDBHandle statusesWithParams:parmDict];

if (dbDictionary.count) {
    [testArray addObject:dbDictionary];
    [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
}

for (NSDictionary *sectionDict in testArray) {
    RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:sectionDict];
    [self.sectionArray addObject:model];
}
}

*/


/*
- (void)reloadData:(NSString *)textString
{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    
    由于数据量并不大 这样每次存入再删除没问题  存数据库
    NSDictionary *parmDict  = @{@"category":@"1"};
    [RSDBHandle saveStatuses:searchDict andParam:parmDict];
    
    RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.rsSearchCollectionView reloadData];
    //self.rsSearchTextField.text = @"";
}




 */





@end
