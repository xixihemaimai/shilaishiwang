//
//  RSErpUserListModel.m
//  石来石往
//
//  Created by mac on 2020/4/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSErpUserListModel.h"

@implementation RSErpUserListModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    // [aCoder encodeObject:self.accType forKey:@"accType"];
    
    
    
    [aCoder encodeObject:self.erpUserCode forKey:@"erpUserCode"];
    [aCoder encodeObject:self.erpUserName forKey:@"erpUserName"];
    [aCoder encodeObject:self.erpUserType forKey:@"erpUserType"];
    [aCoder encodeInteger:self.parentId forKey:@"parentId"];
     [aCoder encodeObject:self.subUserIdentity forKey:@"subUserIdentity"];
    
    [aCoder encodeObject:self.subUserName forKey:@"subUserName"];
    
    [aCoder encodeInteger:self.sysUserId forKey:@"sysUserId"];
    

    
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        self.erpUserCode = [aDecoder decodeObjectForKey:@"erpUserCode"];
        self.erpUserName = [aDecoder decodeObjectForKey:@"erpUserName"];
        self.erpUserType = [aDecoder decodeObjectForKey:@"erpUserType"];
        
        
        self.parentId = [aDecoder decodeIntegerForKey:@"parentId"];
        self.subUserIdentity = [aDecoder decodeObjectForKey:@"subUserIdentity"];
        self.subUserName = [aDecoder decodeObjectForKey:@"subUserName"];
        
        
        
        self.sysUserId  = [aDecoder decodeIntegerForKey:@"sysUserId"];
        
    }
    return self;
}



@end
