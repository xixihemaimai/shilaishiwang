//
//  RSShowView.h
//  StoneOnlineApp
//
//  Created by 曾旭升 on 16/3/8.
//  Copyright © 2016年 RuishiInfo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kShowDataTypeOne = 0,//单选
    kShowDataTypeMore = 1,//多选
    kShowDataTypeInputText = 2,//输入框
}kShowDataType;


@protocol selectDelegate <NSObject>
-(void)selectCodes:(NSString *)Codes andNames:(NSString *)Names;
@end


@interface RSShowView : UIView<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_arrData;
    NSArray *_arrCompanyName;
    NSArray *_arrCount;
    NSMutableArray *_mArrSelect;
}

@property (weak, nonatomic) id<selectDelegate>detelage;
@property (assign, nonatomic) kShowDataType type;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

-(void)initData:(NSArray *)arr;
- (IBAction)btnSure:(UIButton *)sender;
- (IBAction)hidden:(UITapGestureRecognizer *)sender;

@end
