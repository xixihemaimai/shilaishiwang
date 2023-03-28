//
//  RSReportFormView.h
//  石来石往
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN



@interface RSReportFormView : UIView

//1 荒料入库明细表 2 荒料出库明细表 3 库存余额表 库存流水账
@property (nonatomic,strong)NSString * inSelect;
/**长的选择的位置*/
@property (nonatomic,assign)NSInteger longIndex;
/**宽的选择的位置*/
@property (nonatomic,assign)NSInteger withIndex;
/**仓库的选择位置*/
@property (nonatomic,assign)NSInteger wareHouseIndex;
/**是否解冻*/
@property (nonatomic,assign)NSInteger frozenviewIndex;

@property (nonatomic,strong)NSString * selectFunctionType;




//开始时间
@property (nonatomic,strong)NSString * begimTimeStr;
//结束时间
@property (nonatomic,strong)NSString * endTimeStr;
//物料名称
@property (nonatomic,strong)NSString * wuStr;
//荒料号
@property (nonatomic,strong)NSString * blockStr;
//匝号
@property (nonatomic,strong)NSString * turnsStr;
//板号
@property (nonatomic,strong)NSString * slnoStr;

//长的类型
@property (nonatomic,strong)NSString * lentType;

//长的值
@property (nonatomic,strong)NSString * lentStr;
//宽
//长的类型
@property (nonatomic,strong)NSString * withType;
//宽的值
@property (nonatomic,strong)NSString * withStr;
//入库类型
@property (nonatomic,strong)NSString * luType;
//所在仓库
@property (nonatomic,strong)NSString * wareNameStr;
//获取所在仓库的仓库ID
@property (nonatomic,assign)NSInteger whsId;



@property (nonatomic,strong)NSString * secondType;

/**荒料现货展示和大板现货展示不需要时间，1为要显示0不显示*/
@property (nonatomic,strong)NSString * TimeStatus;



//荒料
//这边要开始时间，结束时间，物料名称，荒料号，长的类型，长的输入的值，宽的类型，宽输入的值，入库的类型，所在的仓库，是否冻结
@property (nonatomic,strong)void(^reportformSelect)(NSString * inSelect,NSString * beginTime,NSString * endTime,NSString * wuliaoTextView,NSString * blockTextView,NSString * longTypeView,NSInteger longIndex,NSString * longTextView,NSString * withTypeView,NSInteger withIndex,NSString * withTextView,NSString * luTypeView,NSString * wareHouseView,NSInteger wareHouseIndex,NSString * frozenView,NSInteger frozenviewIndex);


@property (nonatomic,strong)void(^reportformCreateUserNameBLSelect)(NSString * inSelect,NSString * beginTime,NSString * endTime,NSString * wuliaoTextView,NSString * blockTextView,NSString * longTypeView,NSInteger longIndex,NSString * longTextView,NSString * withTypeView,NSInteger withIndex,NSString * withTextView,NSString * luTypeView,NSString * wareHouseView,NSInteger wareHouseIndex,NSString * frozenView,NSInteger frozenviewIndex,NSString * createUserName);



//大板
@property (nonatomic,strong)void(^reportformSLSelect)(NSString * inSelect,NSString * beginTime,NSString * endTime,NSString * wuliaoTextView,NSString * blockTextView,NSString * longTypeView,NSInteger longIndex,NSString * longTextView,NSString * withTypeView,NSInteger withIndex,NSString * withTextView,NSString * luTypeView,NSString * wareHouseView,NSInteger wareHouseIndex,NSString * frozenView,NSInteger frozenviewIndex,NSString * turnNoStr,NSString * slNoStr);

@property (nonatomic,strong)void(^reportformCreateUserNameSLSelect)(NSString * inSelect,NSString * beginTime,NSString * endTime,NSString * wuliaoTextView,NSString * blockTextView,NSString * longTypeView,NSInteger longIndex,NSString * longTextView,NSString * withTypeView,NSInteger withIndex,NSString * withTextView,NSString * luTypeView,NSString * wareHouseView,NSInteger wareHouseIndex,NSString * frozenView,NSInteger frozenviewIndex,NSString * turnNoStr,NSString * slNoStr,NSString * createUserName);




@end

NS_ASSUME_NONNULL_END
