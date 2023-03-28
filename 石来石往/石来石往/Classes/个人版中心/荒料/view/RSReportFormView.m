//
//  RSReportFormView.m
//  石来石往
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSReportFormView.h"
#import "JJOptionView.h"
#import "RSReportFormButton.h"
#import "MenuItemView.h"

@interface RSReportFormView ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

{
    /**开始时间*/
    UIButton * _beginTime;
    /**结束时间*/
    UIButton * _endTime;
    /**物料名称*/
    UITextView * _wuliaotextView;
    /**荒料号*/
    UITextView * _blockTextView;
    
    
    /**长的选择类型*/
    JJOptionView * _longTypeView;
    /**w宽的选择类型*/
    JJOptionView * _withTypeView;
    /**长输入的值*/
    UITextView * _longTextView;
    /**宽输入的值*/
    UITextView * _withTextView;
    
    UILabel * _luLaTypebel;
    /**入库类型*/
    MenuItemView * _luTypeView;
    /**所在的仓库*/
    MenuItemView * _warehouseView;
    
    UILabel *  _isFrozenLabel;
    /**是否冻结*/
     MenuItemView * _frozenView;
    
    
    
    //匝号
    UITextView * _turnTextView;
    
    //板号
    UITextView * _slNoTextView;
    
    
    /**重置*/
    UIButton * _reloadBtn;
    /**确定*/
    UIButton * _sureBtn;
    
    
    //业务员输入值
    UITextView * _salesmanTextView;
    
    
}
@property (nonatomic,strong)UITableView * tableview;

@end


@implementation RSReportFormView


- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW - 91, SCH) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        
    }
    return _tableview;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.tableview];
        [IQKeyboardManager sharedManager].enable = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setUI];
        });
        
    }
    return self;
}


- (void)setUI{
    
    UIView * headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    //入库时间
    UILabel * luLabel = [[UILabel alloc]init];
    if ( [self.selectFunctionType isEqualToString:@"荒料出库明细表"] || [self.selectFunctionType isEqualToString:@"大板出库明细表"]) {
        luLabel.text = @"出库时间";
    }else{
        luLabel.text = @"入库时间";
    }
    luLabel.textAlignment = NSTextAlignmentLeft;
    luLabel.font = [UIFont systemFontOfSize:16];
    luLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:luLabel];
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        luLabel.frame = CGRectMake(24, 10, 66, 23);
    }else{
        luLabel.frame = CGRectMake(24, 10, 66, 23);
    }
  
    //开始时间
    UIButton * beginTime = [UIButton buttonWithType:UIButtonTypeCustom];
    beginTime.frame = CGRectMake(24, CGRectGetMaxY(luLabel.frame) + 5, 101, 30);
    [beginTime setTitle:@"2019/01/03" forState:UIControlStateNormal];
    [beginTime setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
    beginTime.layer.cornerRadius = 17;
    [beginTime setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    beginTime.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerview addSubview:beginTime];
    [beginTime addTarget:self action:@selector(firstChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    _beginTime = beginTime;
    
    //中间的横线
    UIView * hengView = [[UIView alloc]init];
    hengView.frame = CGRectMake(CGRectGetMaxX(beginTime.frame) + 8, 50, 14, 2);
    hengView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
    [headerview addSubview:hengView];
    
    
    //结束时间
    UIButton * endTime = [UIButton buttonWithType:UIButtonTypeCustom];
    endTime.frame = CGRectMake(CGRectGetMaxX(hengView.frame) + 8,  CGRectGetMaxY(luLabel.frame) + 5, 101, 30);
    [endTime setTitle:@"2019/01/03" forState:UIControlStateNormal];
    [endTime setBackgroundColor:[UIColor colorWithHexColorStr:@"#F7F7F7"]];
    endTime.layer.cornerRadius = 17;
    [endTime setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    endTime.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerview addSubview:endTime];
    [endTime addTarget:self action:@selector(secondChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    _endTime = endTime;
    
    [self showDisplayTheTimeToSelectTime:beginTime andSecondTime:endTime];
    
    //物料名称
    UILabel * wuliaoLabel = [[UILabel alloc]init];
    if ([self.TimeStatus isEqualToString:@"1"]) {
        //不显示
        luLabel.hidden = YES;
        beginTime.hidden = YES;
        endTime.hidden = YES;
        hengView.hidden = YES;
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            wuliaoLabel.frame = CGRectMake(24, 10, 66, 23);
        }else{
            wuliaoLabel.frame = CGRectMake(24, 10, 66, 23);
        }
    }else{
        //显示
        luLabel.hidden = NO;
        beginTime.hidden = NO;
        endTime.hidden = NO;
        hengView.hidden = NO;
        wuliaoLabel.frame = CGRectMake(24, CGRectGetMaxY(beginTime.frame) + 10, 66, 23);
    }
    wuliaoLabel.text = @"物料名称";
    wuliaoLabel.textAlignment = NSTextAlignmentLeft;
    wuliaoLabel.font = [UIFont systemFontOfSize:16];
    wuliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:wuliaoLabel];
    
    //内容
    UITextView * wuliaotextView = [[UITextView alloc]init];
    wuliaotextView.frame = CGRectMake(24, CGRectGetMaxY(wuliaoLabel.frame) + 5,SCW - 91 - 48, 30);
    //wuliaoTextfield.placeholder = @"请输入物料名称";
    wuliaotextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    wuliaotextView.layer.cornerRadius = 17;
    [headerview addSubview:wuliaotextView];
     wuliaotextView.returnKeyType = UIReturnKeyDone;
    wuliaotextView.delegate = self;
    _wuliaotextView = wuliaotextView;
    
    //荒料号
    UILabel * blockLabel = [[UILabel alloc]init];
    blockLabel.text = @"荒料号";
    blockLabel.frame = CGRectMake(24, CGRectGetMaxY(wuliaotextView.frame) + 10, 66, 23);
    blockLabel.textAlignment = NSTextAlignmentLeft;
    blockLabel.font = [UIFont systemFontOfSize:16];
    blockLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:blockLabel];
    
    //荒料号内容
    UITextView * blockTextView = [[UITextView alloc]init];
   // blockTextfield.placeholder = @"请输入荒料名";
    blockTextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    blockTextView.layer.cornerRadius = 17;
    blockTextView.returnKeyType = UIReturnKeyDone;
     blockTextView.frame = CGRectMake(24, CGRectGetMaxY(blockLabel.frame) + 5, SCW - 91 - 48, 30);
    [headerview addSubview:blockTextView];
    blockTextView.delegate = self;
    _blockTextView = blockTextView;
    
    
     if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
         
      
         
         
         //业务员
         
         if ([self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
             if (![self.TimeStatus isEqualToString:@"1"]){

                 UILabel * salesmanLabel = [[UILabel alloc]init];
                 salesmanLabel.text = @"制单人";
                 salesmanLabel.textAlignment = NSTextAlignmentLeft;
                 salesmanLabel.font = [UIFont systemFontOfSize:16];
                 salesmanLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                 [headerview addSubview:salesmanLabel];
                 salesmanLabel.frame = CGRectMake(24,CGRectGetMaxY(_blockTextView.frame) + 10, 566, 23);
                 
                 
                 UITextView * salesmanTextView = [[UITextView alloc]init];
                 // blockTextfield.placeholder = @"请输入荒料名";
                 salesmanTextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
                 salesmanTextView.layer.cornerRadius = 17;
                 salesmanTextView.frame = CGRectMake(24, CGRectGetMaxY(salesmanLabel.frame) + 5, SCW - 91 - 48, 30);
                 [headerview addSubview:salesmanTextView];
                 salesmanTextView.returnKeyType = UIReturnKeyDone;
                 salesmanTextView.delegate = self;
                 _salesmanTextView = salesmanTextView;
             }
         }
         
         
         
     }else{
         
         
         
         if ([self.selectFunctionType isEqualToString:@"大板入库明细表"] || [self.selectFunctionType isEqualToString:@"大板出库明细表"]) {
             if (![self.TimeStatus isEqualToString:@"1"]){
                 
                 UILabel * salesmanLabel = [[UILabel alloc]init];
                 salesmanLabel.text = @"制单人";
                 salesmanLabel.textAlignment = NSTextAlignmentLeft;
                 salesmanLabel.font = [UIFont systemFontOfSize:16];
                 salesmanLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                 [headerview addSubview:salesmanLabel];
                 salesmanLabel.frame = CGRectMake(24,CGRectGetMaxY(_blockTextView.frame) + 10, 566, 23);
                 
                 
                 UITextView * salesmanTextView = [[UITextView alloc]init];
                 // blockTextfield.placeholder = @"请输入荒料名";
                 salesmanTextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
                 salesmanTextView.layer.cornerRadius = 17;
                 salesmanTextView.frame = CGRectMake(24, CGRectGetMaxY(salesmanLabel.frame) + 5, SCW - 91 - 48, 30);
                 [headerview addSubview:salesmanTextView];
                 salesmanTextView.returnKeyType = UIReturnKeyDone;
                 salesmanTextView.delegate = self;
                 _salesmanTextView = salesmanTextView;
             }
         }
         
         
         
         
         UILabel * turnNo = [[UILabel alloc]init];
         turnNo.text = @"匝号";
         turnNo.textAlignment = NSTextAlignmentLeft;
         turnNo.font = [UIFont systemFontOfSize:16];
         turnNo.textColor = [UIColor colorWithHexColorStr:@"#666666"];
         [headerview addSubview:turnNo];
        
         if ([self.selectFunctionType isEqualToString:@"大板入库明细表"] || [self.selectFunctionType isEqualToString:@"大板出库明细表"]) {
             if (![self.TimeStatus isEqualToString:@"1"]){
                turnNo.frame = CGRectMake(24,CGRectGetMaxY(_salesmanTextView.frame) + 10, 566, 23);
             }else{
                turnNo.frame = CGRectMake(24,CGRectGetMaxY(_blockTextView.frame) + 10, 566, 23);
             }
         }else{
              turnNo.frame = CGRectMake(24,CGRectGetMaxY(_blockTextView.frame) + 10, 566, 23);
         }
         
         UITextView * turnTextView = [[UITextView alloc]init];
         // blockTextfield.placeholder = @"请输入荒料名";
         turnTextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
         turnTextView.layer.cornerRadius = 17;
         turnTextView.frame = CGRectMake(24, CGRectGetMaxY(turnNo.frame) + 5, SCW - 91 - 48, 30);
         [headerview addSubview:turnTextView];
         turnTextView.returnKeyType = UIReturnKeyDone;
         turnTextView.delegate = self;
         _turnTextView = turnTextView;
         
         UILabel * slNoLabel = [[UILabel alloc]init];
         slNoLabel.text = @"板号";
         slNoLabel.textAlignment = NSTextAlignmentLeft;
         slNoLabel.font = [UIFont systemFontOfSize:16];
         slNoLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
         [headerview addSubview:slNoLabel];
         slNoLabel.frame = CGRectMake(24,CGRectGetMaxY(turnTextView.frame) + 10, 66, 23);
         
         UITextView * slNoTextView = [[UITextView alloc]init];
         // blockTextfield.placeholder = @"请输入荒料名";
         slNoTextView.returnKeyType = UIReturnKeyDone;
         slNoTextView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
         slNoTextView.layer.cornerRadius = 17;
         slNoTextView.frame = CGRectMake(24, CGRectGetMaxY(slNoLabel.frame) + 5, SCW - 91 - 48, 30);
         [headerview addSubview:slNoTextView];
         slNoTextView.returnKeyType = UIReturnKeyDone;
         slNoTextView.delegate = self;
         _slNoTextView = slNoTextView;

     }
    
    //长
    UILabel * longLabel = [[UILabel alloc]init];
    longLabel.text = @"长";
    longLabel.textAlignment = NSTextAlignmentLeft;
    longLabel.font = [UIFont systemFontOfSize:16];
    longLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:longLabel];
    
    if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
        if ([self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
            if (![self.TimeStatus isEqualToString:@"1"]){
                
               longLabel.frame = CGRectMake(24, CGRectGetMaxY(_salesmanTextView.frame) + 10, 66, 23);
            }else{
                longLabel.frame = CGRectMake(24, CGRectGetMaxY(blockTextView.frame) + 10, 66, 23);
            }
        }else{
            
            longLabel.frame = CGRectMake(24, CGRectGetMaxY(blockTextView.frame) + 10, 66, 23);
            
        }
    }else{
        longLabel.frame = CGRectMake(24, CGRectGetMaxY(_slNoTextView.frame) + 10, 66, 23);
    }
    JJOptionView * longTypeView = [[JJOptionView alloc]initWithFrame:CGRectMake(24, CGRectGetMaxY(longLabel.frame) + 5, 112, 30)];
    longTypeView.titleLabel.font = [UIFont systemFontOfSize:13];
    longTypeView.dataSource = @[@"大于",@"等于",@"小于"];
    longTypeView.selectType = @"ruku";
    longTypeView.title = @"请选择类型";
    longTypeView.layer.cornerRadius = 17;
    longTypeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    longTypeView.layer.masksToBounds = YES;
    [headerview addSubview:longTypeView];
    _longTypeView = longTypeView;
    
    longTypeView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
        self.longIndex = selectedIndex + 1;
    };
    
    UIView * longView = [[UIView alloc]init];
    longView.frame = CGRectMake(CGRectGetMaxX(longTypeView.frame) + 10, CGRectGetMaxY(longLabel.frame) + 2, 112, 30);
    longView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    [headerview addSubview:longView];
    longView.layer.cornerRadius = 17;
    
    
    UITextView * longTextView = [[UITextView alloc]init];
    longTextView.frame = CGRectMake(0, 0, 80, 30);
    longTextView.backgroundColor = [UIColor clearColor];
    [longView addSubview:longTextView];
    
    longTextView.delegate = self;
    longTextView.returnKeyType = UIReturnKeyDone;
    _longTextView = longTextView;
    
    UILabel * longcmLabel = [[UILabel alloc]init];
    longcmLabel.text = @"cm";
    longcmLabel.frame = CGRectMake(CGRectGetMaxX(longTextView.frame), 0, 32, 30);
    longcmLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    longcmLabel.font = [UIFont systemFontOfSize:13];
    longcmLabel.textAlignment = NSTextAlignmentLeft;
    [longView addSubview:longcmLabel];
 
    //宽
    UILabel * withLabel = [[UILabel alloc]init];
    withLabel.text = @"宽";
    withLabel.textAlignment = NSTextAlignmentLeft;
    withLabel.font = [UIFont systemFontOfSize:16];
    withLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:withLabel];
     withLabel.frame = CGRectMake(24, CGRectGetMaxY(longTypeView.frame) + 10, 66, 23);
    
    JJOptionView * withTypeView = [[JJOptionView alloc]initWithFrame:CGRectMake(24, CGRectGetMaxY(withLabel.frame) + 5, 112, 30)];
    withTypeView.titleLabel.font = [UIFont systemFontOfSize:13];
    withTypeView.title = @"请选择类型";
    withTypeView.dataSource = @[@"大于",@"等于",@"小于"];
     withTypeView.selectType = @"ruku";
    withTypeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    withTypeView.layer.cornerRadius = 17;
    withTypeView.layer.masksToBounds = YES;
    [headerview addSubview:withTypeView];
    _withTypeView = withTypeView;
    
    withTypeView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
        self.withIndex = selectedIndex + 1;
    };

    
    
    UIView * withView = [[UIView alloc]init];
    withView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    [headerview addSubview:withView];
     withView.frame = CGRectMake(CGRectGetMaxX(withTypeView.frame) + 7, CGRectGetMaxY(withLabel.frame) + 5, 112, 30);
    withView.layer.cornerRadius = 17;
    
    
    UITextView * withTextView = [[UITextView alloc]init];
    withTextView.backgroundColor = [UIColor clearColor];
     withTextView.frame = CGRectMake(0, 0, 80, 30);
    [withView addSubview:withTextView];
    withTextView.returnKeyType = UIReturnKeyDone;
    withTextView.delegate = self;
    _withTextView = withTextView;
    
    
    UILabel * withcmLabel = [[UILabel alloc]init];
    withcmLabel.text = @"cm";
    withcmLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    withcmLabel.font = [UIFont systemFontOfSize:13];
    withcmLabel.textAlignment = NSTextAlignmentLeft;
    [withView addSubview:withcmLabel];
    withcmLabel.frame = CGRectMake(CGRectGetMaxX(withTextView.frame), 0, 32, 30);
    
    
    //入库类型
    UILabel * luLaTypebel = [[UILabel alloc]init];
    
    luLaTypebel.textAlignment = NSTextAlignmentLeft;
    luLaTypebel.font = [UIFont systemFontOfSize:16];
    luLaTypebel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:luLaTypebel];
    luLaTypebel.frame = CGRectMake(24,CGRectGetMaxY(withTypeView.frame) + 10, 66, 23);
    _luLaTypebel = luLaTypebel;
    
    
    MenuItemView *luTypeView = [[MenuItemView alloc] initWithFrame:CGRectMake(24,CGRectGetMaxY(luLaTypebel.frame) + 5, SCW - 91 - 48, 30)];
    luTypeView.layer.cornerRadius = 17;
   // luTypeView.layer.borderColor = [UIColor whiteColor].CGColor;
    luTypeView.layer.masksToBounds = YES;
   
    
    if ( [self.selectFunctionType isEqualToString:@"荒料出库明细表"] || [self.selectFunctionType isEqualToString:@"大板出库明细表"]) {
        luLaTypebel.text = @"出库类型";
        luTypeView.itemText = @"请选出库类型";
        luTypeView.title.text = @"请选出库类型";
        luTypeView.items = @[@"请选出库类型",@"销售出库",@"加工出库",@"盘亏出库"];
        
    }else{
        luLaTypebel.text = @"入库类型";
        luTypeView.itemText = @"请选入库类型";
        luTypeView.title.text = @"请选入库类型";
        luTypeView.items = @[@"请选入库类型",@"采购入库",@"加工入库",@"盘盈入库"];
        
    }
    
    luTypeView.selectType = @"ruku";
    luTypeView.layer.borderWidth = 1.;
    luTypeView.layer.borderColor = [UIColor whiteColor].CGColor;
    luTypeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    //__weak typeof (self) weakSelf = self;
    [luTypeView setSelectedItemBlock:^(NSInteger index, NSString *item) {
        
    }];
    _luTypeView = luTypeView;
    //leftItemView.backgroundColor = [UIColor clearColor];
    [headerview addSubview:luTypeView];
    
    //所在仓库
    UILabel * warehousebel = [[UILabel alloc]init];
    warehousebel.text = @"所在仓库";
    warehousebel.frame = CGRectMake(24,CGRectGetMaxY(luTypeView.frame) + 10, 66, 23);
    warehousebel.textAlignment = NSTextAlignmentLeft;
    warehousebel.font = [UIFont systemFontOfSize:16];
    warehousebel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:warehousebel];

    MenuItemView *warehouseView = [[MenuItemView alloc] initWithFrame:CGRectMake(24,CGRectGetMaxY(warehousebel.frame) + 5,  SCW - 91 - 48, 30)];
    warehouseView.itemText = @"请选出所在仓库";
    warehouseView.title.text = @"请选出所在仓库";
    warehouseView.whsId = 0;
    //NSMutableArray * array = [NSMutableArray array];
    if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
        
       // NSString * str = @"请选出所在仓库";
        RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
        
        warehousemodel.code = @"";
        warehousemodel.createTime = @"";
        warehousemodel.name = @"请选出所在仓库";
        warehousemodel.updateTime = @"";
        warehousemodel.whstype = @"";
        warehousemodel.createUser = 0;
        warehousemodel.pwmsUserId = 0;
        warehousemodel.status = 0;
        warehousemodel.updateUser = 0;
        warehousemodel.WareHouseID = 0;
//        [array addObject:str];
//        for (RSWarehouseModel * warehousemodel in warehouseArray) {
//            [array addObject:warehousemodel.name];
//        }
        [warehouseArray insertObject:warehousemodel atIndex:0];
        warehouseView.items = warehouseArray;
        
    }else{
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"SL"];
//        NSString * str = @"请选出所在仓库";
//        [array addObject:str];
//        for (RSWarehouseModel * warehousemodel in warehouseArray) {
//            [array addObject:warehousemodel.name];
//        }
        RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
        warehousemodel.code = @"";
        warehousemodel.createTime = @"";
        warehousemodel.name = @"请选出所在仓库";
        warehousemodel.updateTime = @"";
        warehousemodel.whstype = @"";
        warehousemodel.createUser = 0;
        warehousemodel.pwmsUserId = 0;
        warehousemodel.status = 0;
        warehousemodel.updateUser = 0;
        warehousemodel.WareHouseID = 0;
        [warehouseArray insertObject:warehousemodel atIndex:0];
        warehouseView.items = warehouseArray;
    }
    //warehouseView.items = array;
    warehouseView.layer.cornerRadius = 17;
    warehouseView.layer.masksToBounds = YES;
//    warehouseView.selectType = @"ruku";
    warehouseView.selectType = @"newWareHouse";
    warehouseView.layer.borderWidth = 1.;
    warehouseView.layer.borderColor = [UIColor whiteColor].CGColor;
    warehouseView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
//    [warehouseView setSelectedItemBlock:^(NSInteger index, NSString *item) {
//        if ([item isEqualToString:@"请选出所在仓库"]) {
//           self.wareHouseIndex = 0;
//        }else{
//           self.wareHouseIndex = index;
//        }
//    }];
    [warehouseView setSelectedItemWarehouseBlock:^(NSInteger index, NSString *itemName) {
//        if ([itemName isEqualToString:@"请选出所在仓库"]) {
            self.wareHouseIndex = index;
//        }else{
//            self.wareHouseIndex = index;
//        }
    }];
    _warehouseView = warehouseView;
    //leftItemView.backgroundColor = [UIColor clearColor];
    [headerview addSubview:warehouseView];
    

    //是否冻结
    UILabel * isFrozenLabel = [[UILabel alloc]init];
    isFrozenLabel.text = @"是否冻结";
    isFrozenLabel.frame = CGRectMake(24,CGRectGetMaxY(warehouseView.frame) + 10, 66, 23);
    isFrozenLabel.textAlignment = NSTextAlignmentLeft;
    isFrozenLabel.font = [UIFont systemFontOfSize:16];
    isFrozenLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [headerview addSubview:isFrozenLabel];
    _isFrozenLabel = isFrozenLabel;
    
    MenuItemView *frozenView = [[MenuItemView alloc] initWithFrame:CGRectMake(24,CGRectGetMaxY(isFrozenLabel.frame) + 5, SCW - 91 - 48, 30)];
    frozenView.itemText = @"请选择";
    frozenView.title.text = @"请选择";
    frozenView.items = @[@"请选择",@"未冻结",@"冻结"];
    frozenView.layer.cornerRadius = 17;
    // luTypeView.layer.borderColor = [UIColor whiteColor].CGColor;
    frozenView.layer.masksToBounds = YES;
    frozenView.selectType = @"ruku";
    frozenView.layer.borderWidth = 1.;
    frozenView.layer.borderColor = [UIColor whiteColor].CGColor;
    frozenView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    //__weak typeof (self) weakSelf = self;
    [frozenView setSelectedItemBlock:^(NSInteger index, NSString *item) {
         self.frozenviewIndex = index;
    }];
    _frozenView = frozenView;
    //leftItemView.backgroundColor = [UIColor clearColor];
    [headerview addSubview:frozenView];
    
    
    
    
    
//    JJOptionView * frozenView = [[JJOptionView alloc]initWithFrame:CGRectMake(24,CGRectGetMaxY(isFrozenLabel.frame) + 5, SCW - 91 - 48, 30)];
//    frozenView.title = @"是否冻结";
//    frozenView.dataSource = @[@"未冻结",@"冻结"];
//    frozenView.selectType = @"isfrozen";
//    frozenView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
//    frozenView.layer.cornerRadius = 17;
//    frozenView.layer.masksToBounds = YES;
//    [headerview addSubview:frozenView];
//    _frozenView = frozenView;
//    frozenView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
//        self.frozenviewIndex = selectedIndex;
//    };
//
    
    
    if ([self.selectFunctionType isEqualToString:@"大板库存流水账"]) {
        
        
        if ([self.secondType isEqualToString:@"2"]) {
            if (![self.begimTimeStr isEqualToString:@""]) {
                [_beginTime setTitle:self.begimTimeStr forState:UIControlStateNormal];
            }
            if (![self.endTimeStr isEqualToString:@""]) {
                [_endTime setTitle:self.endTimeStr forState:UIControlStateNormal];
            }
            
            if (![self.wuStr isEqualToString:@""]) {
                _wuliaotextView.text = self.wuStr;
            }
            
            if (![self.blockStr isEqualToString:@""]) {
                _blockTextView.text = self.blockStr;
            }
            
            if (![self.turnsStr isEqualToString:@""]) {
                _turnTextView.text = self.turnsStr;
            }
            if (![self.slnoStr isEqualToString:@""]) {
                _slNoTextView.text = self.slnoStr;
            }
            
            if (![self.lentStr isEqualToString:@""]) {
                _longTextView.text = self.lentStr;
            }
            if (![self.withStr isEqualToString:@""]) {
                _withTextView.text = self.withStr;
            }
            //选择的值
            if (![self.lentType isEqualToString:@""]) {
                _longTypeView.title = self.lentType;
            }
            
            if (![self.withType isEqualToString:@""]) {
                _withTypeView.title = self.withType;
            }
            
            if (![self.luType isEqualToString:@""]) {
                _luTypeView.itemText = self.luType;
                _luTypeView.title.text = self.luType;
            }
            
            if (![self.wareNameStr isEqualToString:@"请选出所在仓库"]) {
                //确定所在的位置
                RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
                NSMutableArray * warehouseArray = [db getAllContent:@"SL"];
                RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
                warehousemodel.code = @"";
                warehousemodel.createTime = @"";
                warehousemodel.name = @"请选出所在仓库";
                warehousemodel.updateTime = @"";
                warehousemodel.whstype = @"";
                warehousemodel.createUser = 0;
                warehousemodel.pwmsUserId = 0;
                warehousemodel.status = 0;
                warehousemodel.updateUser = 0;
                warehousemodel.WareHouseID = 0;
                [warehouseArray insertObject:warehousemodel atIndex:0];
                for (int i = 0; i < warehouseArray.count; i++) {
                    RSWarehouseModel * warehousemodel = warehouseArray[i];
                    if ([self.wareNameStr isEqualToString:warehousemodel.name] && self.whsId == warehousemodel.WareHouseID) {
                        self.wareHouseIndex = i;
                        _warehouseView.whsId = warehousemodel.WareHouseID;
                        _warehouseView.title.text = warehousemodel.name;
                        _warehouseView.itemText = warehousemodel.name;
                    }
                }
                
            }else{
                _warehouseView.title.text = @"请选出所在仓库";
                _warehouseView.itemText = @"请选出所在仓库";
                _warehouseView.whsId = 0;
                _wareHouseIndex = 0;
            }
        }
    }
        
        UIView * functionview = [[UIView alloc]init];
        functionview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [headerview addSubview:functionview];
        if ([self.inSelect isEqualToString:@"1"] || [self.inSelect isEqualToString:@"2"]) {
            functionview.frame = CGRectMake((SCW - 91)/2 - 90,CGRectGetMaxY(warehouseView.frame) + 35, 180, 36);
        }else{
            functionview.frame = CGRectMake((SCW - 91)/2 - 90,CGRectGetMaxY(frozenView.frame) + 35, 180, 36);
        }

        
        UIButton * reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
        [reloadBtn setTitle:@"重置" forState:UIControlStateNormal];
        [reloadBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [functionview addSubview:reloadBtn];
        [reloadBtn addTarget:self action:@selector(reloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        reloadBtn.frame = CGRectMake(0,0, 90, 36);
        _reloadBtn = reloadBtn;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:reloadBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(17, 17)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = reloadBtn.bounds;
        reloadBtn.layer.mask = maskLayer;
        
        
        UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [functionview addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.frame = CGRectMake(CGRectGetMaxX(reloadBtn.frame),0, 90, 36);
        _sureBtn = sureBtn;
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:sureBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(17, 17)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.path = maskPath2.CGPath;
        maskLayer1.frame = sureBtn.bounds;
        sureBtn.layer.mask = maskLayer1;
        
        
        functionview.layer.cornerRadius = 17;
        [headerview setupAutoHeightWithBottomView:functionview bottomMargin:30];
        [headerview layoutIfNeeded];
        self.tableview.tableHeaderView = headerview;
        if ([self.inSelect isEqualToString:@"1"] || [self.inSelect isEqualToString:@"2"]) {
            frozenView.hidden = YES;
            isFrozenLabel.hidden = YES;
        }else{
            frozenView.hidden = NO;
            isFrozenLabel.hidden = NO;
        }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * SELFCELL = @"SELFCELL";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SELFCELL];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SELFCELL
                ];
    }
    return cell;
}






- (void)showDisplayTheTimeToSelectTime:(UIButton *)firstTimeBtn andSecondTime:(UIButton *)secondTimeBtn{
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    NSString * newBefordate = [beforDate substringToIndex:8];
    newBefordate = [NSString stringWithFormat:@"%@01",newBefordate];
    
    [firstTimeBtn setTitle:newBefordate forState:UIControlStateNormal];
    [secondTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
}



//修改开始时间
- (void)firstChangeTimeAction:(UIButton *)beginTime{
    NSDate * date = [self nsstringConversionNSDate:beginTime.currentTitle];
//    NSDate *currentDate = [NSDate date];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
//    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
//    [adcomps setYear:0];
//    [adcomps setMonth:0];
//    [adcomps setDay:0];
//    NSDate * newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
//    NSString *beforDate = [dateFormatter stringFromDate:newdate];
//    NSString * newBefordate = [beforDate substringToIndex:8];
//    newBefordate = [NSString stringWithFormat:@"%@01",newBefordate];
//    NSDate * date1 = [dateFormatter dateFromString:newBefordate];

    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy/MM/dd"];
        [beginTime setTitle:date forState:UIControlStateNormal];
    }];
    //datepicker.minLimitDate = [self maxtimeString:firstTimeBtn.currentTitle];
    //datepicker.maxLimitDate = [NSDate date];
    [datepicker show];
}

-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

//修改结束时间
- (void)secondChangeTimeAction:(UIButton *)endTime{
    NSDate * date = [self nsstringConversionNSDate:endTime.currentTitle];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy/MM/dd"];
        //结束时间
        [endTime setTitle:date forState:UIControlStateNormal];
        
    }];
    //datepicker.maxLimitDate = [NSDate date];
    //datepicker.minLimitDate = [self currentMinTime];
    [datepicker show];
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


//重置
- (void)reloadBtnAction:(UIButton *)reloadBtn{
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    NSString * newBefordate = [beforDate substringToIndex:8];
    newBefordate = [NSString stringWithFormat:@"%@01",newBefordate];
    [_beginTime setTitle:newBefordate forState:UIControlStateNormal];
    [_endTime setTitle:currentDateString forState:UIControlStateNormal];
    
    _wuliaotextView.text = @"";
    _blockTextView.text = @"";
    _longTextView.text = @"";
    _withTextView.text = @"";
    
    _longTypeView.title = @"请选择类型";
    _withTypeView.title = @"请选择类型";
  
    _warehouseView.title.text = @"请选出所在仓库";
    _warehouseView.itemText = @"请选出所在仓库";
    _warehouseView.whsId = 0;
    
    _frozenView.title.text =  @"请选择";
    _frozenView.itemText = @"请选择";
    //_luLaTypebel.text = @"入库类型";
    
    
    if ([self.selectFunctionType isEqualToString:@"荒料出库明细表"] || [self.selectFunctionType isEqualToString:@"大板出库明细表"]) {
        _luTypeView.itemText = @"请选出库类型";
        _luTypeView.title.text = @"请选出库类型";
    }else{
        _luTypeView.itemText = @"请选入库类型";
        _luTypeView.title.text = @"请选入库类型";
    }
    if ([self.inSelect isEqualToString:@"1"] ) {
        _isFrozenLabel.hidden = YES;
        _frozenView.hidden = YES;
    }else if ([self.inSelect isEqualToString:@"2"]){
        _isFrozenLabel.hidden = YES;
        _frozenView.hidden = YES;
    }
    else{
        _isFrozenLabel.hidden = NO;
        _frozenView.hidden = NO;
    }
    [_wuliaotextView resignFirstResponder];
    [_blockTextView resignFirstResponder];
    [_longTextView resignFirstResponder];
    [_withTextView resignFirstResponder];
    
    self.longIndex = 0;
    self.withIndex = 0;
    self.wareHouseIndex = 0;
    self.frozenviewIndex = 0;
    
     if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
         
         _salesmanTextView.text = @"";
         [_salesmanTextView resignFirstResponder];
         
         
         
     }else{
         
        _salesmanTextView.text = @"";
        [_salesmanTextView resignFirstResponder];
        _turnTextView.text = @"";
        _slNoTextView.text = @"";
        [_turnTextView resignFirstResponder];
        [_slNoTextView resignFirstResponder];
     }
//    if (self.reportformSelect) {
//        self.reportformSelect(self.inSelect,_beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _longTypeView.title,self.longIndex, _longTextView.text, _withTypeView.title,self.withIndex, _withTextView.text,  _luTypeView.title.text , _warehouseView.title.text, self.wareHouseIndex,_frozenView.title.text,self.frozenviewIndex);
//    }
}

//确定
- (void)sureBtnAction:(UIButton *)sureBtn{
    [_wuliaotextView resignFirstResponder];
    [_blockTextView resignFirstResponder];
    [_longTextView resignFirstResponder];
    [_withTextView resignFirstResponder];
    [_salesmanTextView resignFirstResponder];
    
    
    if ([self.selectFunctionType isEqualToString:@"荒料库存余额表"] || [self.selectFunctionType isEqualToString:@"荒料库存流水账"] || [self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
        
        
        if ([self.selectFunctionType isEqualToString:@"荒料入库明细表"] || [self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
            if (![self.TimeStatus isEqualToString:@"1"]){
                if (self.reportformCreateUserNameBLSelect) {
                    self.reportformCreateUserNameBLSelect(self.inSelect,_beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _longTypeView.title,self.longIndex, _longTextView.text, _withTypeView.title,self.withIndex, _withTextView.text,   _luTypeView.title.text , _warehouseView.title.text, self.wareHouseIndex,_frozenView.title.text,self.frozenviewIndex,_salesmanTextView.text);
                }
            }else{
                //这边要传递的值出来
                if (self.reportformSelect) {
                    self.reportformSelect(self.inSelect,_beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _longTypeView.title,self.longIndex, _longTextView.text, _withTypeView.title,self.withIndex, _withTextView.text,   _luTypeView.title.text , _warehouseView.title.text, self.wareHouseIndex,_frozenView.title.text,self.frozenviewIndex);
                }
            }
        }else{
            
            //这边要传递的值出来
            if (self.reportformSelect) {
                self.reportformSelect(self.inSelect,_beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _longTypeView.title,self.longIndex, _longTextView.text, _withTypeView.title,self.withIndex, _withTextView.text,   _luTypeView.title.text , _warehouseView.title.text, self.wareHouseIndex,_frozenView.title.text,self.frozenviewIndex);
            }
            
            
        }
        
        
        
        
        
    }else{
        
        
        if ([self.selectFunctionType isEqualToString:@"大板入库明细表"] || [self.selectFunctionType isEqualToString:@"大板出库明细表"]) {
            if (![self.TimeStatus isEqualToString:@"1"]){
                if (self.reportformCreateUserNameSLSelect) {
                    self.reportformCreateUserNameSLSelect(self.inSelect,_beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _longTypeView.title,self.longIndex, _longTextView.text, _withTypeView.title,self.withIndex, _withTextView.text,   _luTypeView.title.text , _warehouseView.title.text, self.wareHouseIndex,_frozenView.title.text,self.frozenviewIndex, _turnTextView.text, _slNoTextView.text,_salesmanTextView.text);
                }
            }else{
                if (self.reportformSLSelect) {
                    self.reportformSLSelect(self.inSelect,_beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _longTypeView.title,self.longIndex, _longTextView.text, _withTypeView.title,self.withIndex, _withTextView.text,   _luTypeView.title.text , _warehouseView.title.text, self.wareHouseIndex,_frozenView.title.text,self.frozenviewIndex, _turnTextView.text, _slNoTextView.text);
                }
            }
        }else{
            if (self.reportformSLSelect) {
                self.reportformSLSelect(self.inSelect,_beginTime.currentTitle, _endTime.currentTitle, _wuliaotextView.text, _blockTextView.text, _longTypeView.title,self.longIndex, _longTextView.text, _withTypeView.title,self.withIndex, _withTextView.text,   _luTypeView.title.text , _warehouseView.title.text, self.wareHouseIndex,_frozenView.title.text,self.frozenviewIndex, _turnTextView.text, _slNoTextView.text);
            }
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView == _longTextView || textView == _withTextView ) {
        if ([text isEqualToString:@"."] && ([textView.text rangeOfString:@"."].location != NSNotFound || [textView.text isEqualToString:@""])) {
            return NO;
        }
        //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
        NSMutableString *str = [[NSMutableString alloc] initWithString:textView.text];
        [str insertString:text atIndex:range.location];
        if (str.length >= [str rangeOfString:@"."].location+3){
            [_longTextView resignFirstResponder];
            [_withTextView resignFirstResponder];
            return NO;
        }
        return YES;
    }
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [_wuliaotextView resignFirstResponder];
        [_blockTextView resignFirstResponder];
        [_longTextView resignFirstResponder];
        [_withTextView resignFirstResponder];
        [_salesmanTextView resignFirstResponder];
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView == _wuliaotextView) {
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
        if ([temp length] < 1){
            _wuliaotextView.text = @"";
            [_wuliaotextView resignFirstResponder];
        }else{
            _wuliaotextView.text = temp;
            [_wuliaotextView resignFirstResponder];
        }
   }else if (textView == _blockTextView){
    NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] < 1){
        _blockTextView.text = @"";
        [_blockTextView resignFirstResponder];
    }else{
        _blockTextView.text = temp;
        [_blockTextView resignFirstResponder];
    }
   }else if (textView == _longTextView){
    NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] < 1){
        _longTextView.text = @"";
        [_longTextView resignFirstResponder];
    }else{
        _longTextView.text = temp;
        [_longTextView resignFirstResponder];
    }
  }else if (textView == _withTextView){
    NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] < 1){
        _withTextView.text = @"";
        [_withTextView resignFirstResponder];
    }else{
        _withTextView.text = temp;
        [_withTextView resignFirstResponder];
    }
  }else if (textView == _turnTextView){
      NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      temp = [self delSpaceAndNewline:temp];
      if ([temp length] < 1){
          _turnTextView.text = @"";
          [_turnTextView resignFirstResponder];
      }else{
          _turnTextView.text = temp;
          [_turnTextView resignFirstResponder];
      }
      
  }else if (textView == _slNoTextView)
  {
      NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      temp = [self delSpaceAndNewline:temp];
      if ([temp length] < 1){
          _slNoTextView.text = @"";
          [_slNoTextView resignFirstResponder];
      }else{
          _slNoTextView.text = temp;
          [_slNoTextView resignFirstResponder];
      }
  }else if (textView == _salesmanTextView){
      
      NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      temp = [self delSpaceAndNewline:temp];
      if ([temp length] < 1){
          _salesmanTextView.text = @"";
          [_salesmanTextView resignFirstResponder];
      }else{
          _salesmanTextView.text = temp;
          [_salesmanTextView resignFirstResponder];
      }
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}


@end
