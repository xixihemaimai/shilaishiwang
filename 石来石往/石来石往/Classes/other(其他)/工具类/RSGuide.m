//
//  RSGuide.m
//  StoneOnlineApp
//
//  Created by 曾旭升 on 15/7/9.
//  Copyright (c) 2015年 RuishiInfo. All rights reserved.
//

#import "RSGuide.h"

@implementation RSGuide
-(NSArray *)image:(int)page{
    NSArray *arr;
    if (page ==0) {
        arr =[NSArray arrayWithObjects:@"引导内容-ios_02", nil];
    }else if(page ==1){
       arr =[NSArray arrayWithObjects:@"publish1",@"publish2",@"publish3", nil];
    
    }else if(page ==2){
        arr =[NSArray arrayWithObjects:@"荒料入库-新增_02",@"荒料入库选择_02",@"荒料入库-添加入库物料_02",@"荒料入库保存_02", nil];
        
    }
    else if(page ==3){
        arr =[NSArray arrayWithObjects:@"creatBlock", nil];
        
    }
    else if(page ==4){
        arr =[NSArray arrayWithObjects:@"添加荒料-新增_02",@"添加荒料-输入物料的尺寸_02",nil];
        
        
    }else if(page ==5){
        arr = [NSArray arrayWithObject:@"Outmateriel"];

    }else if (page ==6){
    arr = [NSArray arrayWithObject:@"propertySet"];
    }
    else if(page ==7){
        arr =[NSArray arrayWithObjects:@"荒料出库-仓库选择_02",@"荒料出库-选择_02",@"荒料出库-添加_02",@"荒料出库-保存_02", nil];
        
    }
    else if(page ==8){
        arr =[NSArray arrayWithObjects:@"creatOutBlock", nil];
        
    }
    else if(page ==9){
        arr =[NSArray arrayWithObjects:@"引导内容-ios_04", nil];
        
    }else if(page ==10){
        arr =[NSArray arrayWithObjects:@"引导内容-ios_05",@"引导内容-ios_07",@"引导内容-ios_09", nil];
        
    }
    
    return arr;

}


@end
