//
//  RSContactsModel.h
//  石来石往
//
//  Created by mac on 2019/1/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSContactsModel : NSObject

@property (nonatomic,strong)NSString * CONTACTS_NAME;

@property (nonatomic,strong)NSString * CONTACTS_PHONE;

@property (nonatomic,strong)NSString * ContactsId;

@property (nonatomic,assign)NSInteger IS_DEFAULT;
@end

NS_ASSUME_NONNULL_END
