//
//  RSInformationModel.h
//  石来石往
//
//  Created by mac on 17/6/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSInformationModel : NSObject

/**
 资讯ID    newsId    Int
 资讯类别    type    String
 资讯表体    title    String
 发布人    publisher    String
 发布时间    publishTime    String
 
 
 
 */


/**发布人*/
@property (nonatomic,strong)NSString * publisher;
/**发布时间*/
@property (nonatomic,strong)NSString * publishTime;
/**资讯表体*/
@property (nonatomic,strong)NSString * title;
/**资讯类别*/
@property (nonatomic,strong)NSString * type;
/**资讯的图片*/
//@property (nonatomic,strong)NSString * url;

/**新闻的ID*/
@property (nonatomic,assign)NSInteger newsId;



@end
