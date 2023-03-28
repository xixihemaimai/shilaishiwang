//
//  RSCasesModel.m
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSCasesModel.h"

@implementation RSCasesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"caseId" : @"id"
             };
}
@end
