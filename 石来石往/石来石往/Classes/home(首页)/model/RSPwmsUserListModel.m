//
//  RSPwmsUserListModel.m
//  石来石往
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPwmsUserListModel.h"

@implementation RSPwmsUserListModel

/**公司名称主账号 公司名称与用户名称相同*/
//@property (nonatomic,strong)NSString * companyName;
/**创建时间createTime*/
//@property (nonatomic,strong)NSString * createTime;
/**id*/
//@property (nonatomic,strong)NSString * pwmsUserListID;
/**状态0 待审核 1 正常 2 删除status*/
//@property (nonatomic,strong)NSString * status;
/**所属石来石往用户IDsysUserId*/
//@property (nonatomic,strong)NSString * sysUserId;
/**用户名称userName*/
//@property (nonatomic,strong)NSString * userName;




- (void)encodeWithCoder:(NSCoder *)aCoder{
    // [aCoder encodeObject:self.accType forKey:@"accType"];
    
    
    
    [aCoder encodeObject:self.companyName forKey:@"companyName"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    
    [aCoder encodeInteger:self.pwmsUserListID forKey:@"pwmsUserListID"];
    [aCoder encodeInteger:self.status forKey:@"status"];
    [aCoder encodeInteger:self.sysUserId forKey:@"sysUserId"];
   // [aCoder encodeObject:self.pwmsUserListID forKey:@"pwmsUserListID"];
   // [aCoder encodeObject:self.status forKey:@"status"];
   // [aCoder encodeObject:self.sysUserId forKey:@"sysUserId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        //self.accType= [aDecoder decodeObjectForKey:@"accType"];
        self.companyName = [aDecoder decodeObjectForKey:@"companyName"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        
        self.pwmsUserListID = [aDecoder decodeIntegerForKey:@"pwmsUserListID"];
        self.status = [aDecoder decodeIntegerForKey:@"status"];
        self.sysUserId  = [aDecoder decodeIntegerForKey:@"sysUserId"];
       // self.pwmsUserListID = [aDecoder decodeObjectForKey:@"pwmsUserListID"];
       // self.status = [aDecoder decodeObjectForKey:@"status"];
       // self.sysUserId = [aDecoder decodeObjectForKey:@"sysUserId"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
    }
    return self;
}






+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"pwmsUserListID" : @"id"
             };
}



@end
