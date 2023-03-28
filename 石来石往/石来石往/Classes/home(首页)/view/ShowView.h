//
//  ShowView.h
//  封装
//
//  Created by 曾旭升 on 15/11/19.
//  Copyright (c) 2015年 RuishiInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectDelegate <NSObject>

//-(void)selectMore:(NSString *)moreString;
-(void)selectCodes:(NSString *)Codes andNames:(NSString *)Names;
@end
typedef enum {
    kGQXXDataTypeOneSelect = 0,//单选
    kGQXXDataTypeMoreSelect = 1,//多选
    kGQXXDataTypeInputText = 2,//输入框
}kGQXXDataTypeSelect;

@interface ShowView : UIView<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIView     *_mainV;
    NSString    *_strCodes;
    NSString    *_strNames;
    NSMutableArray *_selctMArr;
    UITableView    *_tableview;


}

@property(nonatomic,strong)NSArray *arr1;
@property(nonatomic,strong)NSArray *arr2;
@property(nonatomic,strong)UILabel *lblTitle;
@property(nonatomic,assign)kGQXXDataTypeSelect dataType;
@property(nonatomic,assign)BOOL    isMoreSelect;
@property(nonatomic,weak)id <selectDelegate>delegate;
-(id)initWithFrame:(CGRect)frame arr:(NSArray *)arr  andType:(kGQXXDataTypeSelect)type;
@end
