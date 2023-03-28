//
//  RSPersonlPublishDB.m
//  石来石往
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonlPublishDB.h"
#import "RSPersonlCreatFile.h"
#import "RSWarehouseModel.h"
#import "RSMaterialModel.h"
#import "RSTypeModel.h"
#import "RSColorModel.h"
#import "RSSLStoragemanagementModel.h"
@implementation RSPersonlPublishDB


- (RSPersonlPublishDB *)initWithCreatTypeList:(NSString *)creatList{
    if (self = [super init]) {
        _creatList = creatList;
        /**
         NSString* fullPath = nil;
         NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

         if ([paths count] > 0) {
             fullPath = (NSString*)[paths objectAtIndex:0];
             if ([aPath length] > 0) {
                 fullPath = [fullPath stringByAppendingPathComponent:aPath];
             }
         }
         */
        NSString* dbPath = [RSPersonlCreatFile getPathWithinDocumentDir:creatList];
         NSLog(@"%@",dbPath);
        //创建文件管理器
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //判断文件是否存在
        BOOL existFile = [fileManager fileExistsAtPath:dbPath];
        if (existFile == NO) {
           NSString* poemDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:creatList];
           [fileManager copyItemAtPath:poemDBPath toPath:dbPath error:nil];
        }
        _db = [[FMDatabase alloc] initWithPath:dbPath];
        BOOL success = [_db open];
        if (success == NO) {
        return nil;
        }
    }
    return self;
}


//建立数据库表
- (BOOL)createContentTable
{
    [_db beginTransaction];
    BOOL success = false;
    //仓库
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        success  = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_Warehouselist(warehouseID integer primary key autoincrement,id integer NOT NULL, 'code' text,'createTime' text,createUser integer,'name' text,pwmsUserId integer,status integer,'updateTime' text,updateUser integer,'whstype' text);"];
    }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
        //物料
         success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_Materiallist (materiallistID integer primary key autoincrement,id integer NOT NULL, 'code' text,'color' text,'createTime' text,'createUser' text,'name' text,pwmsUserId integer,status integer,'type' text,'updateTime' text,updateUser integer,colorId integer,typeId integer);"];
    }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
         //类型
          success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_Typelist (typelistID integer primary key autoincrement,id integer NOT NULL, 'code' text,'createTime' text,createUser integer,'name' text,status integer,'updateTime' text,updateUser integer);"];
    }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
       //颜色
         success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_Colorlist (colorlistID integer primary key autoincrement,id integer NOT NULL, 'code' text,'createTime' text,createUser integer,'name' text,status integer,'updateTime' text,updateUser integer);"];
    }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
        //加工厂
        success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_FactoryList(warehouseID integer primary key autoincrement,id integer NOT NULL, 'code' text,'createTime' text,createUser integer,'name' text,pwmsUserId integer,status integer,'updateTime' text,updateUser integer);"];
    }
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild");
        return NO;
    }
    else {
        NSLog(@"success12");
    }
    return YES;
}



/**增加数据 注意，在物料才需要把colorid和typeId传上,color和type,不需要whsType  在仓库不需要colorid和typeid，需要whsType*/
-(BOOL)addContentID:(NSInteger)contentID andCode:(NSString *)code andCreateTime:(NSString *)createTime andCreateUser:(NSInteger)createUser andName:(NSString *)name andPwmsUserId:(NSInteger)pwmsUserId andStatus:(NSInteger)status andUpdateTime:(NSString *)updateTime andUpdateUser:(NSInteger)updateUser
         andWhsType:(NSString *)whsType andColor:(NSString *)color andType:(NSString *)type
         andColorId:(NSString *)colorId andTypeId:(NSString *)typeId
{
    [_db beginTransaction];
    BOOL success = NO;
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        //仓库
        /**
         warehouseID integer primary key autoincrement,id integer NOT NULL, 'code' text,'createTime' text,createUser integer,'name' text,pwmsUserId integer,status integer,'updateTime' text,updateUser integer,'whsType' text,
         */
        success = [_db executeUpdate:@"INSERT INTO t_Warehouselist(id,code,createTime,createUser,name,pwmsUserId,status,updateTime,updateUser,whstype) VALUES (?,?,?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:contentID],code,createTime,[NSNumber numberWithInteger:createUser],name,[NSNumber numberWithInteger:pwmsUserId],[NSNumber numberWithInteger:status],updateTime,[NSNumber numberWithInteger:updateUser],whsType];
    }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
        //物料
        
        /**
         ,colorId integer,typeId integer
         materiallistID integer primary key autoincrement,id integer NOT NULL, 'code' text,'colorId' text,'createTime' text,'createUser' text,'name' text,pwmsUserId integer,status integer,'typeId' text,'updateTime' text,updateUser integer,
         */
        success = [_db executeUpdate:@"INSERT INTO t_Materiallist(id,code,color,createTime,createUser,name,pwmsUserId,status,type,updateTime,updateUser,colorId,typeId) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?);",contentID,code,color,createTime,createUser,name,pwmsUserId,status,type,updateTime,updateUser,colorId,typeId];
    }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
        //类别
        
        /**
         typelistID integer primary key autoincrement,id integer NOT NULL, 'code' text,'createTime' text,createUser integer,'name' text,status integer,'updateTime' text,updateUser integer,
         
         */
        success = [_db executeUpdate:@"INSERT INTO t_Typelist(id,code,createTime,createUser,name,status,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?);",contentID,code,createTime,createUser,name,status,updateTime,updateUser];
    }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
        //颜色
        
        /**
         
         colorlistID integer primary key autoincrement,id integer NOT NULL, 'code' text,'createTime' text,createUser integer,'name' text,status integer,'updateTime' text,updateUser integer,)
         */
        
        success = [_db executeUpdate:@"INSERT INTO t_Colorlist(id,code,createTime,createUser,name,status,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?);",contentID,code,createTime,createUser,name,status,updateTime,updateUser];
    }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
        
        success = [_db executeUpdate:@"INSERT INTO t_FactoryList(id,code,createTime,createUser,name,pwmsUserId,status,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:contentID],code,createTime,[NSNumber numberWithInteger:createUser],name,[NSNumber numberWithInteger:pwmsUserId],[NSNumber numberWithInteger:status],updateTime,[NSNumber numberWithInteger:updateUser]];
        
        
        
    }
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild  yes  no");
        return NO;
    }
    return YES;
}

//批处理数据 仅作示例
- (void)batchAddMutableArray:(NSMutableArray *)array{
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i<array.count; i++) {
            BOOL success = NO;
            if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
                //仓库
                RSWarehouseModel * warehousemodel = array[i];
               
                success = [_db executeUpdate:@"INSERT INTO t_Warehouselist(id,code,createTime,createUser,name,pwmsUserId,status,updateTime,updateUser,whsType) VALUES (?,?,?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:warehousemodel.WareHouseID],warehousemodel.code,warehousemodel.createTime,[NSNumber numberWithInteger:warehousemodel.createUser],warehousemodel.name,[NSNumber numberWithInteger:warehousemodel.pwmsUserId],[NSNumber numberWithInteger:warehousemodel.status],warehousemodel.updateTime,[NSNumber numberWithInteger:warehousemodel.updateUser],warehousemodel.whstype];
            }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
                //物料
                RSMaterialModel * materialmodel = array[i];
                
                success = [_db executeUpdate:@"INSERT INTO t_Materiallist(id,code,color,createTime,createUser,name,pwmsUserId,status,type,updateTime,updateUser,colorId,typeId) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:materialmodel.MAterialID],materialmodel.code,materialmodel.color ,materialmodel.createTime,[NSNumber numberWithInteger:materialmodel.createUser],materialmodel.name,[NSNumber numberWithInteger:materialmodel.pwmsUserId],[NSNumber numberWithInteger:materialmodel.status],materialmodel.type,materialmodel.updateTime,[NSNumber numberWithInteger:materialmodel.updateUser],[NSNumber numberWithInteger:materialmodel.colorId],[NSNumber numberWithInteger:materialmodel.typeId]];
            }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
                
                RSTypeModel * typemodel = array[i];
                //类别
                success = [_db executeUpdate:@"INSERT INTO t_Typelist(id,code,createTime,createUser,name,status,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:typemodel.TypeID],typemodel.code,typemodel.createTime,[NSNumber numberWithInteger:typemodel.createUser],typemodel.name,[NSNumber numberWithInteger:typemodel.status],typemodel.updateTime,[NSNumber numberWithInteger:typemodel.updateUser]];
            }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
                //颜色
                RSColorModel * colormodel = array[i];
                success = [_db executeUpdate:@"INSERT INTO t_Colorlist(id,code,createTime,createUser,name,status,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:colormodel.ColorID],colormodel.code,colormodel.createTime,[NSNumber numberWithInteger:colormodel.createUser],colormodel.name,[NSNumber numberWithInteger:colormodel.status],colormodel.updateTime,[NSNumber numberWithInteger:colormodel.updateUser]];
            }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
                
                RSWarehouseModel * warehousemodel = array[i];
                
                success = [_db executeUpdate:@"INSERT INTO t_FactoryList(id,code,createTime,createUser,name,pwmsUserId,status,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:warehousemodel.WareHouseID],warehousemodel.code,warehousemodel.createTime,[NSNumber numberWithInteger:warehousemodel.createUser],warehousemodel.name,[NSNumber numberWithInteger:warehousemodel.pwmsUserId],[NSNumber numberWithInteger:warehousemodel.status],warehousemodel.updateTime,[NSNumber numberWithInteger:warehousemodel.updateUser]];
            }
            if (!success ) {
                NSLog(@"插入失败1");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    }
    @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
}


- (NSMutableArray *)searchSLNameContent:(NSArray *)searchArray{
    NSMutableArray * array = [NSMutableArray array];
    NSString * sqlStr = [NSString string];
    for (int j = 0; j < searchArray.count; j++) {
        RSOcrBlockDetailModel * ocrBlockDetailmodel = searchArray[j];
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Materiallist WHERE name = '%@'", ocrBlockDetailmodel.stoneName];
        FMResultSet* rs = [_db executeQuery:sqlStr];
        if ([rs next]) {
            RSSLStoragemanagementModel * slstoragemanagemenmodel = [[RSSLStoragemanagementModel alloc]init];
            slstoragemanagemenmodel.billid = 0;
            slstoragemanagemenmodel.billdtlid = 0;
            slstoragemanagemenmodel.mtlId = [[rs stringForColumn:@"id"]integerValue];
            slstoragemanagemenmodel.mtltypeId = [[rs stringForColumn:@"typeId"] integerValue];
            slstoragemanagemenmodel.storeareaId = -1;
            slstoragemanagemenmodel.qty = 1;
            slstoragemanagemenmodel.blockNo = ocrBlockDetailmodel.stoneNo;
            slstoragemanagemenmodel.turnsNo = ocrBlockDetailmodel.turnsNo;
            slstoragemanagemenmodel.slNo = ocrBlockDetailmodel.slNo;
            //slstoragemanagemenmodel.SLockNo 
            slstoragemanagemenmodel.mtlName = [rs stringForColumn:@"name"];
            slstoragemanagemenmodel.mtltypeName = [rs stringForColumn:@"type"];
            slstoragemanagemenmodel.storeareaName = @"";
            
            NSString *multiplyStr = @"1.0";
            
            NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
            
            NSDecimalNumber *multiplyNum = [NSDecimalNumber decimalNumberWithString:multiplyStr];
            
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            
            slstoragemanagemenmodel.length = [oneNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
            //
            //
            //                slstoragemanagemenmodel.length = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
            
            
            NSDecimalNumber *widthNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
            
            
            //                slstoragemanagemenmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
            slstoragemanagemenmodel.width = [widthNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
            
            
            
            
            NSString *multiplyTwoStr = @"1.00";
            
            NSDecimalNumber *heightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
            
            
            NSDecimalNumber *multiplyTwoNum = [NSDecimalNumber decimalNumberWithString:multiplyTwoStr];
            
            
            NSDecimalNumberHandler *roundTwoUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            
            
            slstoragemanagemenmodel.height = [heightNum decimalNumberByMultiplyingBy:multiplyTwoNum withBehavior:roundTwoUp];
            
            
            //                slstoragemanagemenmodel.height = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
            
            
            
            NSString *multiplyThirdStr = @"1.000";
            
            NSDecimalNumber *areaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            
            
            NSDecimalNumber *multiplyThirdNum = [NSDecimalNumber decimalNumberWithString:multiplyThirdStr];
            
            
            NSDecimalNumberHandler *roundThirdUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            
            
            slstoragemanagemenmodel.area = [areaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            
            
            //                slstoragemanagemenmodel.area = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            
            NSDecimalNumber *dedAreaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
            
            slstoragemanagemenmodel.dedArea = [dedAreaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            //                slstoragemanagemenmodel.dedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
            
            
            NSDecimalNumber *preAreaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
            
            slstoragemanagemenmodel.preArea = [preAreaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            
            //                slstoragemanagemenmodel.preArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
            NSDecimalNumber *weightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
            
            
            slstoragemanagemenmodel.weight = [weightNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            //                slstoragemanagemenmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
            
          
            
            //slstoragemanagemenmodel.dedLengthOne
            //slstoragemanagemenmodel.dedWidthOne
            //slstoragemanagemenmodel.dedLengthTwo
            //slstoragemanagemenmodel.dedWidthTwo
            //slstoragemanagemenmodel.dedLengthThree
            //slstoragemanagemenmodel.dedWidthThree
            //slstoragemanagemenmodel.dedLengthFour
            //slstoragemanagemenmodel.dedWidthFour
            [array addObject:slstoragemanagemenmodel];
    
        }else{
            sqlStr=[NSString stringWithFormat:@"SELECT  * FROM t_Materiallist WHERE replace( '%@',name,'')  != '%@' or name like '%%@%'", ocrBlockDetailmodel.stoneName,ocrBlockDetailmodel.stoneName,ocrBlockDetailmodel.stoneName];
            //select * from PWMS_DIC_COLOR  where replace( '黑21',NAME, '')  != '黑21' or NAME like '%黑21%'
            FMResultSet * rs = [_db executeQuery:sqlStr];
            if ([rs next]) {
                
                RSSLStoragemanagementModel * slstoragemanagemenmodel = [[RSSLStoragemanagementModel alloc]init];
                slstoragemanagemenmodel.billid = 0;
                slstoragemanagemenmodel.billdtlid = 0;
                slstoragemanagemenmodel.mtlId = [[rs stringForColumn:@"id"]integerValue];
                slstoragemanagemenmodel.mtltypeId = [[rs stringForColumn:@"typeId"] integerValue];
                slstoragemanagemenmodel.storeareaId = -1;
                slstoragemanagemenmodel.qty = 1;
                slstoragemanagemenmodel.blockNo = ocrBlockDetailmodel.stoneNo;
                slstoragemanagemenmodel.turnsNo = ocrBlockDetailmodel.turnsNo;
                slstoragemanagemenmodel.slNo = ocrBlockDetailmodel.slNo;
                //slstoragemanagemenmodel.SLockNo
                slstoragemanagemenmodel.mtlName = [rs stringForColumn:@"name"];
                slstoragemanagemenmodel.mtltypeName = [rs stringForColumn:@"type"];
                slstoragemanagemenmodel.storeareaName = @"";
                
                
                
                NSString *multiplyStr = @"1.0";
                
                NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
                
                NSDecimalNumber *multiplyNum = [NSDecimalNumber decimalNumberWithString:multiplyStr];
                
                NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                slstoragemanagemenmodel.length = [oneNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
                //
                //
                //                slstoragemanagemenmodel.length = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
                
                
                NSDecimalNumber *widthNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                
                
                //                slstoragemanagemenmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                slstoragemanagemenmodel.width = [widthNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
                
                
                
                
                NSString *multiplyTwoStr = @"1.00";
                
                NSDecimalNumber *heightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                NSDecimalNumber *multiplyTwoNum = [NSDecimalNumber decimalNumberWithString:multiplyTwoStr];
                
                
                NSDecimalNumberHandler *roundTwoUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                slstoragemanagemenmodel.height = [heightNum decimalNumberByMultiplyingBy:multiplyTwoNum withBehavior:roundTwoUp];
                
                
                //                slstoragemanagemenmodel.height = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                
                NSString *multiplyThirdStr = @"1.000";
                
                NSDecimalNumber *areaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                
                NSDecimalNumber *multiplyThirdNum = [NSDecimalNumber decimalNumberWithString:multiplyThirdStr];
                
                
                NSDecimalNumberHandler *roundThirdUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                slstoragemanagemenmodel.area = [areaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
                
                //                slstoragemanagemenmodel.area = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                NSDecimalNumber *dedAreaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                slstoragemanagemenmodel.dedArea = [dedAreaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                //                slstoragemanagemenmodel.dedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                
                NSDecimalNumber *preAreaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
                
                slstoragemanagemenmodel.preArea = [preAreaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
                //                slstoragemanagemenmodel.preArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
                NSDecimalNumber *weightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
                
                
                slstoragemanagemenmodel.weight = [weightNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                //                slstoragemanagemenmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
        
                
                //slstoragemanagemenmodel.preArea
                //slstoragemanagemenmodel.dedArea
                //slstoragemanagemenmodel.area
                //slstoragemanagemenmodel.dedLengthOne
                //slstoragemanagemenmodel.dedWidthOne
                //slstoragemanagemenmodel.dedLengthTwo
                //slstoragemanagemenmodel.dedWidthTwo
                //slstoragemanagemenmodel.dedLengthThree
                //slstoragemanagemenmodel.dedWidthThree
                //slstoragemanagemenmodel.dedLengthFour
                //slstoragemanagemenmodel.dedWidthFour
                
                 [array addObject:slstoragemanagemenmodel];
                
            }else{
                
                RSSLStoragemanagementModel * slstoragemanagemenmodel = [[RSSLStoragemanagementModel alloc]init];
                slstoragemanagemenmodel.billid = 0;
                slstoragemanagemenmodel.billdtlid = 0;
                slstoragemanagemenmodel.mtlId = -1;
                slstoragemanagemenmodel.mtltypeId = -1;
                slstoragemanagemenmodel.storeareaId = -1;
                slstoragemanagemenmodel.mtlName = @"";
                slstoragemanagemenmodel.mtltypeName = ocrBlockDetailmodel.stoneType;
                
                
                slstoragemanagemenmodel.qty = 1;
                slstoragemanagemenmodel.blockNo = ocrBlockDetailmodel.stoneNo;
                slstoragemanagemenmodel.turnsNo = ocrBlockDetailmodel.turnsNo;
                slstoragemanagemenmodel.slNo = ocrBlockDetailmodel.slNo;
                //slstoragemanagemenmodel.SLockNo
                slstoragemanagemenmodel.storeareaName = @"";
                
                
                NSString *multiplyStr = @"1.0";
                
                NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];

                 NSDecimalNumber *multiplyNum = [NSDecimalNumber decimalNumberWithString:multiplyStr];

                NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];

               slstoragemanagemenmodel.length = [oneNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
//
//
//                slstoragemanagemenmodel.length = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
                
                
                NSDecimalNumber *widthNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                
                
//                slstoragemanagemenmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                slstoragemanagemenmodel.width = [widthNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
                
                
                
                
                NSString *multiplyTwoStr = @"1.00";
                
                NSDecimalNumber *heightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                NSDecimalNumber *multiplyTwoNum = [NSDecimalNumber decimalNumberWithString:multiplyTwoStr];
                
                
                NSDecimalNumberHandler *roundTwoUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                slstoragemanagemenmodel.height = [heightNum decimalNumberByMultiplyingBy:multiplyTwoNum withBehavior:roundTwoUp];
                
                
//                slstoragemanagemenmodel.height = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                
                NSString *multiplyThirdStr = @"1.000";
                
                NSDecimalNumber *areaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                NSDecimalNumber *multiplyThirdNum = [NSDecimalNumber decimalNumberWithString:multiplyThirdStr];
                
                
                NSDecimalNumberHandler *roundThirdUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                slstoragemanagemenmodel.area = [areaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
//                slstoragemanagemenmodel.area = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                 NSDecimalNumber *dedAreaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                slstoragemanagemenmodel.dedArea = [dedAreaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
//                slstoragemanagemenmodel.dedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                
                NSDecimalNumber *preAreaNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
                
                 slstoragemanagemenmodel.preArea = [preAreaNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
//                slstoragemanagemenmodel.preArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
                 NSDecimalNumber *weightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
                
                
                slstoragemanagemenmodel.weight = [weightNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
               
                
//                slstoragemanagemenmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
                //slstoragemanagemenmodel.preArea
                //slstoragemanagemenmodel.dedArea
                //slstoragemanagemenmodel.area
                //slstoragemanagemenmodel.dedLengthOne
                //slstoragemanagemenmodel.dedWidthOne
                //slstoragemanagemenmodel.dedLengthTwo
                //slstoragemanagemenmodel.dedWidthTwo
                //slstoragemanagemenmodel.dedLengthThree
                //slstoragemanagemenmodel.dedWidthThree
                //slstoragemanagemenmodel.dedLengthFour
                //slstoragemanagemenmodel.dedWidthFour
                
                 [array addObject:slstoragemanagemenmodel];
                
            }
        }
        [rs close];
    }
    return array;
}


//搜索单条内容
- (NSMutableArray *)searchNameContent:(NSArray *)searchArray{
    NSMutableArray * array = [NSMutableArray array];
    NSString * sqlStr = [NSString string];
    for (int i = 0; i < searchArray.count; i++) {
        RSOcrBlockDetailModel * ocrBlockDetailmodel = searchArray[i];
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Materiallist WHERE name = '%@'", ocrBlockDetailmodel.stoneName];
        FMResultSet* rs = [_db executeQuery:sqlStr];
        if ([rs next]) {
            RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
            storagemanagementmodel.mtlName = [rs stringForColumn:@"name"];
            storagemanagementmodel.mtltypeName = [rs stringForColumn:@"type"];
            storagemanagementmodel.mtltypeId = [[rs stringForColumn:@"typeId"] integerValue];
            storagemanagementmodel.blockNo = ocrBlockDetailmodel.stoneNo;
            storagemanagementmodel.slNo = ocrBlockDetailmodel.slNo;
            storagemanagementmodel.turnsNo = ocrBlockDetailmodel.turnsNo;
           
            
            
            NSString *multiplyStr = @"1.0";
            
            NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
            
            NSDecimalNumber *multiplyNum = [NSDecimalNumber decimalNumberWithString:multiplyStr];
            
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            
            storagemanagementmodel.length = [oneNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
            
            
            
            
            //                storagemanagementmodel.length =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
            
            
            
            
            NSDecimalNumber *widthNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
            
            
            
            storagemanagementmodel.width = [widthNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
            
            //                storagemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
            
            
            
            NSString *multiplyTwoStr = @"1.00";
            
            NSDecimalNumber *heightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
            
            
            NSDecimalNumber *multiplyTwoNum = [NSDecimalNumber decimalNumberWithString:multiplyTwoStr];
            
            
            NSDecimalNumberHandler *roundTwoUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            
            
            storagemanagementmodel.height = [heightNum decimalNumberByMultiplyingBy:multiplyTwoNum withBehavior:roundTwoUp];
            
            
            
            
            //                storagemanagementmodel.height =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
            
            
            NSString *multiplyThirdStr = @"1.000";
            
            NSDecimalNumber *preVaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            
            
            NSDecimalNumber *multiplyThirdNum = [NSDecimalNumber decimalNumberWithString:multiplyThirdStr];
            
            
            NSDecimalNumberHandler *roundThirdUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            
            
            storagemanagementmodel.preVaqty = [preVaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            
            
            //                storagemanagementmodel.preVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
            
            NSDecimalNumber *dedVaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
            
            storagemanagementmodel.dedVaqty = [dedVaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            //                storagemanagementmodel.dedVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
            
            NSDecimalNumber *vaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            
            storagemanagementmodel.vaqty = [vaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            
            //                storagemanagementmodel.vaqty =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            
            NSDecimalNumber *volumeNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            
            storagemanagementmodel.volume = [volumeNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            //                 storagemanagementmodel.volume =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            NSDecimalNumber *weightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
            
            storagemanagementmodel.weight = [weightNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
            
            //                storagemanagementmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
            
            
//            storagemanagementmodel.length =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
//            storagemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
//
//            storagemanagementmodel.height =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
//
//            storagemanagementmodel.preVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
//            storagemanagementmodel.dedVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
//            storagemanagementmodel.vaqty =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
//            storagemanagementmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
//            storagemanagementmodel.volume =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
            storagemanagementmodel.name = [rs stringForColumn:@"name"];
            storagemanagementmodel.materialId = [[rs stringForColumn:@"id"] integerValue];
            storagemanagementmodel.mtlId = [[rs stringForColumn:@"id"]integerValue];
            storagemanagementmodel.qty = 1;
            storagemanagementmodel.storeareaId = -1;
            [array addObject:storagemanagementmodel];
        }else{
            sqlStr=[NSString stringWithFormat:@"SELECT  * FROM t_Materiallist WHERE replace( '%@',name,'')  != '%@' or name like '%%@%'", ocrBlockDetailmodel.stoneName,ocrBlockDetailmodel.stoneName,ocrBlockDetailmodel.stoneName];
            //select * from PWMS_DIC_COLOR  where replace( '黑21',NAME, '')  != '黑21' or NAME like '%黑21%'
            FMResultSet * rs = [_db executeQuery:sqlStr];
            if ([rs next]) {
                //这边是多条的状态，只取第一条
                RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                storagemanagementmodel.mtlName = [rs stringForColumn:@"name"];
                storagemanagementmodel.mtltypeName = [rs stringForColumn:@"type"];
                storagemanagementmodel.mtltypeId = [[rs stringForColumn:@"typeId"] integerValue];
                storagemanagementmodel.blockNo = ocrBlockDetailmodel.stoneNo;
                storagemanagementmodel.slNo = ocrBlockDetailmodel.slNo;
                storagemanagementmodel.turnsNo = ocrBlockDetailmodel.turnsNo;
                
                
                NSString *multiplyStr = @"1.0";
                
                NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
                
                NSDecimalNumber *multiplyNum = [NSDecimalNumber decimalNumberWithString:multiplyStr];
                
                NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                storagemanagementmodel.length = [oneNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
                
                
                
                
                //                storagemanagementmodel.length =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
                
                
                
                
                NSDecimalNumber *widthNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                
                
                
                storagemanagementmodel.width = [widthNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
                
                //                storagemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                
                
                
                NSString *multiplyTwoStr = @"1.00";
                
                NSDecimalNumber *heightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                NSDecimalNumber *multiplyTwoNum = [NSDecimalNumber decimalNumberWithString:multiplyTwoStr];
                
                
                NSDecimalNumberHandler *roundTwoUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                storagemanagementmodel.height = [heightNum decimalNumberByMultiplyingBy:multiplyTwoNum withBehavior:roundTwoUp];
                
                
                
                
                //                storagemanagementmodel.height =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                NSString *multiplyThirdStr = @"1.000";
                
                NSDecimalNumber *preVaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                
                NSDecimalNumber *multiplyThirdNum = [NSDecimalNumber decimalNumberWithString:multiplyThirdStr];
                
                
                NSDecimalNumberHandler *roundThirdUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                storagemanagementmodel.preVaqty = [preVaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
                
                //                storagemanagementmodel.preVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
                
                NSDecimalNumber *dedVaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                storagemanagementmodel.dedVaqty = [dedVaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                //                storagemanagementmodel.dedVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                NSDecimalNumber *vaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                storagemanagementmodel.vaqty = [vaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
                //                storagemanagementmodel.vaqty =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                NSDecimalNumber *volumeNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                storagemanagementmodel.volume = [volumeNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                //                 storagemanagementmodel.volume =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                NSDecimalNumber *weightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
                
                storagemanagementmodel.weight = [weightNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                //                storagemanagementmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
                
//                storagemanagementmodel.length =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
//                storagemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
//
//                storagemanagementmodel.height =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
//
//                storagemanagementmodel.preVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
//                storagemanagementmodel.dedVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
//                storagemanagementmodel.vaqty =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
//                storagemanagementmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
//                storagemanagementmodel.volume =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                storagemanagementmodel.qty = 1;
                storagemanagementmodel.storeareaId = -1;
                storagemanagementmodel.name = [rs stringForColumn:@"name"];
                storagemanagementmodel.materialId = [[rs stringForColumn:@"id"] integerValue];
                storagemanagementmodel.mtlId = [[rs stringForColumn:@"id"]integerValue];
                
                [array addObject:storagemanagementmodel];
            }else{
                RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                storagemanagementmodel.mtltypeId = -1;
                storagemanagementmodel.name = @"";
                storagemanagementmodel.materialId = -1;
                storagemanagementmodel.mtlId = -1;
                storagemanagementmodel.mtlName = @"";
                storagemanagementmodel.mtltypeName = ocrBlockDetailmodel.stoneType;
                
                storagemanagementmodel.blockNo = ocrBlockDetailmodel.stoneNo;
                storagemanagementmodel.slNo = ocrBlockDetailmodel.slNo;
                storagemanagementmodel.turnsNo = ocrBlockDetailmodel.turnsNo;
                
                
                
                NSString *multiplyStr = @"1.0";
                
                NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
                
                NSDecimalNumber *multiplyNum = [NSDecimalNumber decimalNumberWithString:multiplyStr];
                
                NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                storagemanagementmodel.length = [oneNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
                
                
                
                
//                storagemanagementmodel.length =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.length]]];
                
                
                
                
                NSDecimalNumber *widthNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                
                
                
                storagemanagementmodel.width = [widthNum decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
                
//                storagemanagementmodel.width = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.width]]];
                
                
                
                NSString *multiplyTwoStr = @"1.00";
                
                NSDecimalNumber *heightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                NSDecimalNumber *multiplyTwoNum = [NSDecimalNumber decimalNumberWithString:multiplyTwoStr];
                
                
                NSDecimalNumberHandler *roundTwoUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                storagemanagementmodel.height = [heightNum decimalNumberByMultiplyingBy:multiplyTwoNum withBehavior:roundTwoUp];
                
                
                
                
//                storagemanagementmodel.height =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.height]]];
                
                
                NSString *multiplyThirdStr = @"1.000";
                
                NSDecimalNumber *preVaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                
                NSDecimalNumber *multiplyThirdNum = [NSDecimalNumber decimalNumberWithString:multiplyThirdStr];
                
                
                NSDecimalNumberHandler *roundThirdUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                
                
                storagemanagementmodel.preVaqty = [preVaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
                
//                storagemanagementmodel.preVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.preVaqty]]];
                
                NSDecimalNumber *dedVaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                storagemanagementmodel.dedVaqty = [dedVaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
//                storagemanagementmodel.dedVaqty = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.dedVaqty]]];
                
                 NSDecimalNumber *vaqtyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                storagemanagementmodel.vaqty = [vaqtyNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
//                storagemanagementmodel.vaqty =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                 NSDecimalNumber *volumeNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                
                storagemanagementmodel.volume = [volumeNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
                
                
//                 storagemanagementmodel.volume =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.vaqty]]];
                  NSDecimalNumber *weightNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
                
                storagemanagementmodel.weight = [weightNum decimalNumberByMultiplyingBy:multiplyThirdNum withBehavior:roundThirdUp];
                
//                storagemanagementmodel.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:ocrBlockDetailmodel.weight]]];
               
                storagemanagementmodel.qty = 1;
                storagemanagementmodel.storeareaId = -1;
                [array addObject:storagemanagementmodel];
            }
        }
        [rs close];
    }
    return array;
}

- (NSString *)notRounding:(id)price
               afterPoint:(NSInteger)position {
    //生成format格式
    NSString *format = [NSString stringWithFormat:@"%%.%ldf",(long)position];
    CGFloat value = 0.;
    //string 和 number 兼容
    if ([price respondsToSelector:@selector(doubleValue)]) {
        value = [price doubleValue];
    }
    NSString *number = [NSString stringWithFormat:format,value];
    return number;
}




//搜索内容
- (NSMutableArray*)serachContent:(NSString*)searchText
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    NSString * sqlStr = [NSString string];
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Warehouselist WHERE name LIKE '%@%%'", searchText];
    }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Materiallist WHERE name LIKE '%@%%'", searchText];
    }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Typelist WHERE name LIKE '%@%%'", searchText];
    }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Colorlist WHERE name LIKE '%@%%'", searchText];
    }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
        
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_FactoryList WHERE name LIKE '%@%%'", searchText];
    }
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
            RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
            warehousemodel.code = [rs stringForColumn:@"code"];
            warehousemodel.createTime = [rs stringForColumn:@"createTime"];
            warehousemodel.name = [rs stringForColumn:@"name"];
            warehousemodel.updateTime = [rs stringForColumn:@"updateTime"];
            warehousemodel.whstype = [rs stringForColumn:@"whstype"];
            warehousemodel.WareHouseID = [[rs stringForColumn:@"id"] integerValue];
            warehousemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            warehousemodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
            warehousemodel.status = [[rs stringForColumn:@"status"] integerValue];
            warehousemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:warehousemodel];
        }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
            RSMaterialModel * materialmodel = [[RSMaterialModel alloc]init];
            materialmodel.code = [rs stringForColumn:@"code"];
            materialmodel.createTime = [rs stringForColumn:@"createTime"];
            materialmodel.name = [rs stringForColumn:@"name"];
            materialmodel.updateTime = [rs stringForColumn:@"updateTime"];
            materialmodel.color = [rs stringForColumn:@"color"];
            materialmodel.type = [rs stringForColumn:@"type"];
            materialmodel.colorId = [[rs stringForColumn:@"colorId"]integerValue];
              materialmodel.typeId = [[rs stringForColumn:@"typeId"]integerValue];
            materialmodel.MAterialID = [[rs stringForColumn:@"id"] integerValue];
            materialmodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            materialmodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
            materialmodel.status = [[rs stringForColumn:@"status"] integerValue];
            materialmodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:materialmodel];
        }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
            RSTypeModel * typemodel = [[RSTypeModel alloc]init];
            typemodel.code = [rs stringForColumn:@"code"];
            typemodel.createTime = [rs stringForColumn:@"createTime"];
            typemodel.name = [rs stringForColumn:@"name"];
            typemodel.updateTime = [rs stringForColumn:@"updateTime"];
            typemodel.TypeID = [[rs stringForColumn:@"id"] integerValue];
            typemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            typemodel.status = [[rs stringForColumn:@"status"] integerValue];
            typemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:typemodel];
        }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
            RSColorModel * colormodel = [[RSColorModel alloc]init];
            colormodel.code = [rs stringForColumn:@"code"];
            colormodel.createTime = [rs stringForColumn:@"createTime"];
            colormodel.name = [rs stringForColumn:@"name"];
            colormodel.updateTime = [rs stringForColumn:@"updateTime"];
            colormodel.ColorID = [[rs stringForColumn:@"id"] integerValue];
            colormodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            colormodel.status = [[rs stringForColumn:@"status"] integerValue];
            colormodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:colormodel];
        }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
            RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
            warehousemodel.code = [rs stringForColumn:@"code"];
            warehousemodel.createTime = [rs stringForColumn:@"createTime"];
            warehousemodel.name = [rs stringForColumn:@"name"];
            warehousemodel.updateTime = [rs stringForColumn:@"updateTime"];
            warehousemodel.whstype = @"";
            warehousemodel.WareHouseID = [[rs stringForColumn:@"id"] integerValue];
            warehousemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            warehousemodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
            warehousemodel.status = [[rs stringForColumn:@"status"] integerValue];
            warehousemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:warehousemodel];
        }
    }
    [rs close];
//    NSMutableArray* sort = [NSMutableArray array];
//    if (result && [result count] > 0) {
////        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creatTime" ascending:NO];
//        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"productName" ascending:NO];
//        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//        sort = [NSMutableArray arrayWithArray:[result sortedArrayUsingDescriptors:sortDescriptors]];
//    }
    return result;
}

//ContentID:(NSInteger)contentID andCode:(NSString *)code andCreateTime:(NSString *)createTime andCreateUser:(NSInteger)createUser andName:(NSString *)name andPwmsUserId:(NSInteger)pwmsUserId andStatus:(NSInteger)status andUpdateTime:(NSString *)updateTime andUpdateUser:(NSInteger)updateUser
//andWhsType:(NSString *)whsType andColorId:(NSString *)colorId andTypeId:(NSString *)typeId

/**更新数据 注意，在物料才需要把color和type传上,不需要whsType  在仓库不需要color和type，需要whsType*/
- (BOOL)updateContentID:(NSInteger)ID andCode:(NSString *)code andCreateTime:(NSString *)createTime andCreateUser:(NSInteger)createUser andName:(NSString *)name andPwmsUserId:(NSInteger)pwmsUserId andStatus:(NSInteger)status andUpdateTime:(NSString *)updateTime andUpdateUser:(NSInteger)updateUser andWhsType:(NSString *)whsType andColor:(NSString *)color andType:(NSString *)type andColorID:(NSInteger)colorId andTypeID:(NSInteger)typeId
{
    [_db beginTransaction];
    NSString * sqlStr = [NSString string];
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        sqlStr=[NSString stringWithFormat:@"UPDATE t_Warehouselist SET code ='%@', createTime='%@',createUser = '%@',name = '%@', pwmsUserId = '%@',status = '%@',updateTime = '%@', updateUser = '%@', whstype = '%@' WHERE id = '%@'", code, createTime,[NSNumber numberWithInteger:createUser],name,[NSNumber numberWithInteger:pwmsUserId],[NSNumber numberWithInteger:status],updateTime,[NSNumber numberWithInteger:updateUser],whsType,[NSNumber numberWithInteger:ID]];
    }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
        
        
    //(id,code,color,createTime,createUser,name,pwmsUserId,status,type,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?,?,?,?)
      
        
        
        sqlStr=[NSString stringWithFormat:@"UPDATE t_Materiallist SET code ='%@', color='%@',createTime = '%@',createUser = '%@', name = '%@',pwmsUserId = '%@',status = '%@',type = '%@', updateTime = '%@', updateUser = '%@',colorId = '%@', typeId = '%@' WHERE id = '%@'",code,color,createTime,[NSNumber numberWithInteger:createUser],name,[NSNumber numberWithInteger:pwmsUserId],[NSNumber numberWithInteger:status],type,updateTime,[NSNumber numberWithInteger:updateUser],[NSNumber numberWithInteger:colorId],[NSNumber numberWithInteger:typeId],[NSNumber numberWithInteger:ID]];
    }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
        
        //id,code,createTime,createUser,name,status,updateTime,updateUser) VALUES (?,?,?,?,?,?,?,?)
        
        sqlStr=[NSString stringWithFormat:@"UPDATE t_Typelist SET code ='%@', createTime='%@',createUser = '%@',name = '%@', status = '%@',updateTime = '%@',updateUser = '%@' WHERE id = '%@'",code,createTime,[NSNumber numberWithInteger:createUser],name,[NSNumber numberWithInteger:status],updateTime,[NSNumber numberWithInteger:updateUser],[NSNumber numberWithInteger:ID]];
    }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
        //id,code,createTime,createUser,name,status,updateTime,updateUser)
         sqlStr=[NSString stringWithFormat:@"UPDATE t_Colorlist SET code ='%@', createTime='%@',createUser = '%@',name = '%@', status = '%@',updateTime = '%@',updateUser = '%@' WHERE id = '%@'",code,createTime,[NSNumber numberWithInteger:createUser],name,[NSNumber numberWithInteger:status],updateTime,[NSNumber numberWithInteger:updateUser],[NSNumber numberWithInteger:ID]];
    }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
        
           sqlStr=[NSString stringWithFormat:@"UPDATE t_FactoryList SET code ='%@', createTime='%@',createUser = '%@',name = '%@', pwmsUserId = '%@',status = '%@',updateTime = '%@', updateUser = '%@', WHERE id = '%@'", code, createTime,[NSNumber numberWithInteger:createUser],name,[NSNumber numberWithInteger:pwmsUserId],[NSNumber numberWithInteger:status],updateTime,[NSNumber numberWithInteger:updateUser],[NSNumber numberWithInteger:ID]];
        
    }
    BOOL success = [_db executeUpdate:sqlStr];
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild  yes  no");
        return NO;
    }
    return YES;
}




- (NSMutableArray *)getWarehouseID:(NSInteger)warehouseID
{
    //@"SELECT  *  FROM t_Materiallist WHERE name = '%@'"
    NSMutableArray* result = [NSMutableArray array];
    NSString * sqlStr = [NSString string];
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Warehouselist WHERE id = '%ld'",warehouseID];
        
    }
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
        warehousemodel.code = [rs stringForColumn:@"code"];
        warehousemodel.createTime = [rs stringForColumn:@"createTime"];
        warehousemodel.name = [rs stringForColumn:@"name"];
        warehousemodel.updateTime = [rs stringForColumn:@"updateTime"];
        warehousemodel.whstype = [rs stringForColumn:@"whstype"];
        warehousemodel.WareHouseID = [[rs stringForColumn:@"id"] integerValue];
        warehousemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
        warehousemodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
        warehousemodel.status = [[rs stringForColumn:@"status"] integerValue];
        warehousemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
        [result addObject:warehousemodel];
    }
    [rs close];
    return result;
}







- (NSMutableArray*)getAllContent:(NSString *)whsType
{
    //@"SELECT  *  FROM t_Materiallist WHERE name = '%@'"
    NSMutableArray* result = [NSMutableArray array];
    NSString * sqlStr = [NSString string];
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Warehouselist WHERE whstype = '%@'",whsType];
        
    }
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
        warehousemodel.code = [rs stringForColumn:@"code"];
        warehousemodel.createTime = [rs stringForColumn:@"createTime"];
        warehousemodel.name = [rs stringForColumn:@"name"];
        warehousemodel.updateTime = [rs stringForColumn:@"updateTime"];
        warehousemodel.whstype = [rs stringForColumn:@"whstype"];
        warehousemodel.WareHouseID = [[rs stringForColumn:@"id"] integerValue];
        warehousemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
        warehousemodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
        warehousemodel.status = [[rs stringForColumn:@"status"] integerValue];
        warehousemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
        [result addObject:warehousemodel];
    }
    [rs close];
    return result;
}



//获取所有数据
- (NSMutableArray*)getAllContent
{
    NSMutableArray* result = [NSMutableArray array];
    NSString * sqlStr = [NSString string];
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
         sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Warehouselist"];
    }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Materiallist"];
    }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Typelist"];
    }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_Colorlist"];
    }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_FactoryList"];
    }
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
            RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
            warehousemodel.code = [rs stringForColumn:@"code"];
            warehousemodel.createTime = [rs stringForColumn:@"createTime"];
            warehousemodel.name = [rs stringForColumn:@"name"];
            warehousemodel.updateTime = [rs stringForColumn:@"updateTime"];
            warehousemodel.whstype = [rs stringForColumn:@"whstype"];
            warehousemodel.WareHouseID = [[rs stringForColumn:@"id"] integerValue];
            warehousemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            warehousemodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
            warehousemodel.status = [[rs stringForColumn:@"status"] integerValue];
            warehousemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:warehousemodel];
        }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
            RSMaterialModel * materialmodel = [[RSMaterialModel alloc]init];
            materialmodel.code = [rs stringForColumn:@"code"];
            materialmodel.createTime = [rs stringForColumn:@"createTime"];
            materialmodel.name = [rs stringForColumn:@"name"];
            materialmodel.updateTime = [rs stringForColumn:@"updateTime"];
            materialmodel.color = [rs stringForColumn:@"color"];
            materialmodel.type = [rs stringForColumn:@"type"];
            materialmodel.colorId = [[rs stringForColumn:@"colorId"]integerValue];
            materialmodel.typeId = [[rs stringForColumn:@"typeId"]integerValue];
            
            materialmodel.MAterialID = [[rs stringForColumn:@"id"] integerValue];
            materialmodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            materialmodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
            materialmodel.status = [[rs stringForColumn:@"status"] integerValue];
            materialmodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:materialmodel];
        }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
            RSTypeModel * typemodel = [[RSTypeModel alloc]init];
            typemodel.code = [rs stringForColumn:@"code"];
            typemodel.createTime = [rs stringForColumn:@"createTime"];
            typemodel.name = [rs stringForColumn:@"name"];
            typemodel.updateTime = [rs stringForColumn:@"updateTime"];
            typemodel.TypeID = [[rs stringForColumn:@"id"] integerValue];
            typemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            typemodel.status = [[rs stringForColumn:@"status"] integerValue];
            typemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:typemodel];
        }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
            RSColorModel * colormodel = [[RSColorModel alloc]init];
            colormodel.code = [rs stringForColumn:@"code"];
            colormodel.createTime = [rs stringForColumn:@"createTime"];
            colormodel.name = [rs stringForColumn:@"name"];
            colormodel.updateTime = [rs stringForColumn:@"updateTime"];
            colormodel.ColorID = [[rs stringForColumn:@"id"] integerValue];
            colormodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            colormodel.status = [[rs stringForColumn:@"status"] integerValue];
            colormodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:colormodel];
        }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
            RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
            warehousemodel.code = [rs stringForColumn:@"code"];
            warehousemodel.createTime = [rs stringForColumn:@"createTime"];
            warehousemodel.name = [rs stringForColumn:@"name"];
            warehousemodel.updateTime = [rs stringForColumn:@"updateTime"];
            warehousemodel.whstype = @"";
            warehousemodel.WareHouseID = [[rs stringForColumn:@"id"] integerValue];
            warehousemodel.createUser = [[rs stringForColumn:@"createUser"] integerValue];
            warehousemodel.pwmsUserId = [[rs stringForColumn:@"pwmsUserId"] integerValue];
            warehousemodel.status = [[rs stringForColumn:@"status"] integerValue];
            warehousemodel.updateUser = [[rs stringForColumn:@"updateUser"] integerValue];
            [result addObject:warehousemodel];
        }
    }
    [rs close];
//    NSMutableArray* sort = [NSMutableArray array];
//    if (result && [result count] > 0) {
//        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES] ;
//        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//
//        sort = [NSMutableArray arrayWithArray:<#(nonnull NSArray *)#>]
//
//        sort = [NSMutableArray arrayWithArray:[result sortedArrayUsingDescriptors:sortDescriptors]];
//    }
    return result;
}

//删除单条内容
- (void)deleteContent:(NSInteger)ID
{
    [_db beginTransaction];
    BOOL success = NO;
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        success = [_db executeUpdate:@"DELETE FROM t_Warehouselist WHERE id = '%ld%%'", ID];
    }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
        success = [_db executeUpdate:@"DELETE FROM t_Materiallist WHERE id = '%ld%%'", ID];
    }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
        success = [_db executeUpdate:@"DELETE FROM t_Typelist WHERE id = '%ld%%'", ID];
    }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
        success = [_db executeUpdate:@"DELETE FROM t_Colorlist WHERE id = '%ld%%'", ID];
    }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
        success = [_db executeUpdate:@"DELETE FROM t_FactoryList WHERE id = '%ld%%'", ID];
    }
    [_db commit];
    if(!success ||[_db hadError])
    {
        [_db rollback];
        NSLog(@"error1");
    }
}



//删除所有数据
- (void)deleteAllContent
{
    [_db beginTransaction];
    BOOL success = NO;
    if ([self.creatList isEqualToString:@"Warehouselist.sqlite"]) {
        success = [_db executeUpdate:@"DELETE  FROM t_Warehouselist;"];
    }else if ([self.creatList isEqualToString:@"Materiallist.sqlite"]){
        success = [_db executeUpdate:@"DELETE  FROM t_Materiallist;"];
    }else if ([self.creatList isEqualToString:@"Typelist.sqlite"]){
        success = [_db executeUpdate:@"DELETE  FROM t_Typelist;"];
    }else if ([self.creatList isEqualToString:@"Colorlist.sqlite"]){
        success = [_db executeUpdate:@"DELETE  FROM t_Colorlist;"];
    }else if ([self.creatList isEqualToString:@"Factory.sqlite"]){
        success = [_db executeUpdate:@"DELETE  FROM t_FactoryList;"];
    }
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"error1");
        //return NO;
    }
}

//FMDatabaseQueue仅作示例
//- (void)explamFMDatabaseQueue:(WiFiInfoModel*)brandInfo{
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:nil];
//
//    [queue inDatabase:^(FMDatabase *db) {//从这个block中直接获得打开的数据库实例
//
//        BOOL success = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
//                        [NSString stringWithFormat:@"%@",brandInfo.wifiName],
//                        brandInfo.wifiPassword,
//                        brandInfo.creatTime];
//        BOOL success2 = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
//                         [NSString stringWithFormat:@"%@",brandInfo.wifiName],
//                         brandInfo.wifiPassword,
//                         brandInfo.creatTime];
//        BOOL success3 = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
//                         [NSString stringWithFormat:@"%@",brandInfo.wifiName],
//                         brandInfo.wifiPassword,
//                         brandInfo.creatTime];
//
//        FMResultSet *rs = [db executeQuery:@"select * from t_student"];
//        while ([rs next]) {
//            // …
//        }
//    }];
//}

//多条数据插入的时候
/**
 
 FMDatabase * _dataBase = [[FMDatabase alloc]initWithPath:dbString];
 [_dataBase beginTransaction];//开启一个事务
 BOOL isRollBack = NO;
 @try {
 for(CityModel * model in modelArr){
 BOOL res = [_dataBase executeUpdate:@“SQL语句及其参数”];
 if(!res){
 //数据存储失败
 }
 }
 } @catch (NSException *exception) {
 isRollBack = YES;
 [_dataBase rollback];//回滚事务
 } @finally {
 if(!isRollBack){
 [_dataBase commit];//重新提交事务
 }
 }
 [_dataBase close];
 
 */

@end
