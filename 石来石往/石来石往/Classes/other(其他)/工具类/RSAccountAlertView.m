//
//  RSAccountAlertView.m
//  石来石往
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSAccountAlertView.h"

#import "RSAccountAlertCell.h"
#import "RSAccountHeaderView.h"
@interface RSAccountAlertView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *bgView;
@end

@implementation RSAccountAlertView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setUI];
        });
    
    }
    return self;
}







- (void)setUI{
    
    //BILL_BL_CGRK 采购入库  BILL_BL_JGRK 加工入库 BILL_BL_PYRK 盘盈入库
    //BILL_BL_XSCK 销售出库  BILL_BL_JGCK 加工出库 BILL_BL_PKCK 盘亏出库
    //BILL_BL_YCCL 异常处理
    //BILL_BL_DB 调拨
    
    //BILL_SL_CGRK 大板采购入库 BILL_SL_JGRK 大板加工出库 BILL_SL_PYRK 大板盘盈入库
    //BILL_SL_XSCK 大板销售出库 BILL_SL_JGCK 大板加工出库 BILL_SL_PKCK 大板盘亏出库
    //BILL_SL_YCCL 大板异常处理 BILL_SL_DB 大板调拨
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 15;
    if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_CGRK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_BL_JGRK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_BL_PYRK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_CGRK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_JGRK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_PYRK"] ) {
        //荒料入库
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(SCW - 64 - 19 - 28, 24, 28, 28);
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //入库详情
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, SCW - 61, 28)];
        label.text = @"入库详情";
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        [self addSubview:label];
        
        //物料名称
        UILabel * mtlNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(label.frame) + 7, 62, 21)];
        mtlNameLabel.text = @"物料名称";
        mtlNameLabel.textAlignment = NSTextAlignmentLeft;
        mtlNameLabel.font = [UIFont systemFontOfSize:15];
        mtlNameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlNameLabel];
        
        
        //物料名称详情
        UILabel * mtlNameDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlNameLabel.frame), CGRectGetMaxY(label.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlNameLabel.frame) - 23, 21)];
        mtlNameDetailLabel.text = self.accountDetailmodel.mtlName;
        mtlNameDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlNameDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlNameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlNameDetailLabel];
        
        
        //物料类别
        UILabel * mtlTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlNameLabel.frame) + 7, 62, 21)];
        mtlTypeLabel.text = @"物料类型";
        mtlTypeLabel.textAlignment = NSTextAlignmentLeft;
        mtlTypeLabel.font = [UIFont systemFontOfSize:15];
        mtlTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlTypeLabel];
        
        
        //物料类型详情
        UILabel * mtlTypeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlTypeLabel.frame), CGRectGetMaxY(mtlNameDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlTypeLabel.frame) - 23, 21)];
        mtlTypeDetailLabel.text = self.accountDetailmodel.mtltypeName;
        mtlTypeDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlTypeDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlTypeDetailLabel];
        
        
        //长宽高
        UILabel * mtlShapeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlTypeLabel.frame) + 7, 80, 21)];
        mtlShapeLabel.text = @"长宽高(cm)";
        mtlShapeLabel.textAlignment = NSTextAlignmentLeft;
        mtlShapeLabel.font = [UIFont systemFontOfSize:15];
        mtlShapeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlShapeLabel];
        
        
        //长宽高
        UILabel * mtlShapeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlShapeLabel.frame), CGRectGetMaxY(mtlTypeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlShapeLabel.frame) - 23, 21)];
        mtlShapeDetailLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[self.accountDetailmodel.length doubleValue],[self.accountDetailmodel.width doubleValue],[self.accountDetailmodel.height doubleValue]];
        mtlShapeDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlShapeDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlShapeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlShapeDetailLabel];
        
        
        //体积
        UILabel * mtlVolomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlShapeLabel.frame) + 7, 70, 21)];
        mtlVolomeLabel.text = @"体积(m³)";
        mtlVolomeLabel.textAlignment = NSTextAlignmentLeft;
        mtlVolomeLabel.font = [UIFont systemFontOfSize:15];
        mtlVolomeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlVolomeLabel];
        
        
        
        UILabel * mtlVolomeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlVolomeLabel.frame), CGRectGetMaxY(mtlShapeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlVolomeLabel.frame) - 23, 21)];
        mtlVolomeDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.volume doubleValue]];
        mtlVolomeDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlVolomeDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlVolomeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlVolomeDetailLabel];
        
        //重量
        UILabel * mtlWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlVolomeLabel.frame) + 7, 62, 21)];
        mtlWeightLabel.text = @"重量(吨)";
        mtlWeightLabel.textAlignment = NSTextAlignmentLeft;
        mtlWeightLabel.font = [UIFont systemFontOfSize:15];
        mtlWeightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlWeightLabel];
        
        
        
        UILabel * mtlWeightDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlWeightLabel.frame), CGRectGetMaxY(mtlVolomeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlWeightLabel.frame) - 23,21)];
        mtlWeightDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.weight doubleValue]];;
        mtlWeightDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlWeightDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlWeightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlWeightDetailLabel];
        
        //入库日期
        
        UILabel * dateInLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlWeightDetailLabel.frame) + 7, 62, 21)];
        dateInLabel.text = @"入库日期";
        dateInLabel.textAlignment = NSTextAlignmentLeft;
        dateInLabel.font = [UIFont systemFontOfSize:15];
        dateInLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:dateInLabel];
        
        
        
        UILabel * dateInDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateInLabel.frame), CGRectGetMaxY(mtlWeightDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(dateInLabel.frame) - 23, 21)];
        dateInDetailLabel.text = self.accountDetailmodel.receiptDate;
        dateInDetailLabel.textAlignment = NSTextAlignmentRight;
        dateInDetailLabel.font = [UIFont systemFontOfSize:15];
        dateInDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:dateInDetailLabel];
        
        
        //入库类型
        
        UILabel * dateInTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(dateInDetailLabel.frame) + 7, 62, 21)];
        dateInTypeLabel.text = @"入库类型";
        dateInTypeLabel.textAlignment = NSTextAlignmentLeft;
        dateInTypeLabel.font = [UIFont systemFontOfSize:15];
        dateInTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:dateInTypeLabel];
        
        
        
        UILabel * dateInTypeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateInTypeLabel.frame), CGRectGetMaxY(dateInDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(dateInTypeLabel.frame) - 23, 21)];
        
        if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_CGRK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_CGRK"]) {
            dateInTypeDetailLabel.text = @"采购入库";
        }else if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_JGRK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_JGRK"]){
            dateInTypeDetailLabel.text = @"加工入库";
        }else{
            dateInTypeDetailLabel.text = @"盘盈入库";
        }
        
        
        dateInTypeDetailLabel.textAlignment = NSTextAlignmentRight;
        dateInTypeDetailLabel.font = [UIFont systemFontOfSize:15];
        dateInTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:dateInTypeDetailLabel];
        
        
        //入库仓库
        UILabel * dateInwarehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(dateInTypeDetailLabel.frame) + 7, 70, 21)];
        dateInwarehouseLabel.text = @"入库仓库";
        dateInwarehouseLabel.textAlignment = NSTextAlignmentLeft;
        dateInwarehouseLabel.font = [UIFont systemFontOfSize:15];
        dateInwarehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:dateInwarehouseLabel];
        
        
        
        UILabel * dateInwarehouseDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateInwarehouseLabel.frame), CGRectGetMaxY(dateInTypeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(dateInwarehouseLabel.frame) -23, 21)];
        dateInwarehouseDetailLabel.text = self.accountDetailmodel.whsInName;
        dateInwarehouseDetailLabel.textAlignment = NSTextAlignmentRight;
        dateInwarehouseDetailLabel.font = [UIFont systemFontOfSize:15];
        dateInwarehouseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:dateInwarehouseDetailLabel];
        
        
        
        
        
        
        
        
    }else if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_XSCK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_BL_JGCK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_BL_PKCK"] ||[self.accountDetailmodel.billType isEqualToString:@"BILL_SL_XSCK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_JGCK"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_PKCK"] ){
        
        
        //荒料出库
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(SCW - 64 - 19 - 28, 24, 28, 28);
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //入库详情
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, SCW - 61, 28)];
        label.text = @"出库详情";
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        [self addSubview:label];
        
        
        
        
        //物料名称
        UILabel * mtlNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(label.frame) + 7, 62, 21)];
        mtlNameLabel.text = @"物料名称";
        mtlNameLabel.textAlignment = NSTextAlignmentLeft;
        mtlNameLabel.font = [UIFont systemFontOfSize:15];
        mtlNameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlNameLabel];
        
        
        //物料名称详情
        UILabel * mtlNameDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlNameLabel.frame), CGRectGetMaxY(label.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlNameLabel.frame) - 23, 21)];
        mtlNameDetailLabel.text = self.accountDetailmodel.mtlName;
        mtlNameDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlNameDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlNameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlNameDetailLabel];
        
        
        //物料类别
        UILabel * mtlTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlNameLabel.frame) + 7, 70, 21)];
        mtlTypeLabel.text = @"物料类型";
        mtlTypeLabel.textAlignment = NSTextAlignmentLeft;
        mtlTypeLabel.font = [UIFont systemFontOfSize:15];
        mtlTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlTypeLabel];
        
        
        //物料类型详情
        UILabel * mtlTypeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlTypeLabel.frame), CGRectGetMaxY(mtlNameDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlTypeLabel.frame) - 23, 21)];
        mtlTypeDetailLabel.text = self.accountDetailmodel.mtltypeName;
        mtlTypeDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlTypeDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlTypeDetailLabel];
        
        
        //长宽高
        UILabel * mtlShapeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlTypeLabel.frame) + 7, 80, 21)];
        mtlShapeLabel.text = @"长宽高(cm)";
        mtlShapeLabel.textAlignment = NSTextAlignmentLeft;
        mtlShapeLabel.font = [UIFont systemFontOfSize:15];
        mtlShapeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlShapeLabel];
        
        
        //长宽高
        UILabel * mtlShapeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlShapeLabel.frame), CGRectGetMaxY(mtlTypeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlShapeLabel.frame) - 23, 21)];
        mtlShapeDetailLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[self.accountDetailmodel.length doubleValue],[self.accountDetailmodel.width doubleValue],[self.accountDetailmodel.height doubleValue]];
        mtlShapeDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlShapeDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlShapeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlShapeDetailLabel];
        
        
        //体积
        UILabel * mtlVolomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlShapeLabel.frame) + 7, 70, 21)];
        mtlVolomeLabel.text = @"体积(m³)";
        mtlVolomeLabel.textAlignment = NSTextAlignmentLeft;
        mtlVolomeLabel.font = [UIFont systemFontOfSize:15];
        mtlVolomeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlVolomeLabel];
        
        
        
        UILabel * mtlVolomeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlVolomeLabel.frame), CGRectGetMaxY(mtlShapeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlVolomeLabel.frame) - 23, 21)];
        mtlVolomeDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.volume doubleValue]];
        mtlVolomeDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlVolomeDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlVolomeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlVolomeDetailLabel];
        
        //重量
        UILabel * mtlWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlVolomeLabel.frame) + 7, 70, 21)];
        mtlWeightLabel.text = @"重量(吨)";
        mtlWeightLabel.textAlignment = NSTextAlignmentLeft;
        mtlWeightLabel.font = [UIFont systemFontOfSize:15];
        mtlWeightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlWeightLabel];
        
        
        
        UILabel * mtlWeightDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlWeightLabel.frame), CGRectGetMaxY(mtlVolomeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlWeightLabel.frame) - 23,21)];
        mtlWeightDetailLabel.text =  [NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.weight doubleValue]];
        mtlWeightDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlWeightDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlWeightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlWeightDetailLabel];
        
        //入库日期
        
        UILabel * dateInLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlWeightDetailLabel.frame) + 7, 70, 21)];
        dateInLabel.text = @"出库日期";
        dateInLabel.textAlignment = NSTextAlignmentLeft;
        dateInLabel.font = [UIFont systemFontOfSize:15];
        dateInLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:dateInLabel];
        
        
        
        UILabel * dateInDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateInLabel.frame), CGRectGetMaxY(mtlWeightDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(dateInLabel.frame) - 23, 21)];
        dateInDetailLabel.text = self.accountDetailmodel.billDate;
        dateInDetailLabel.textAlignment = NSTextAlignmentRight;
        dateInDetailLabel.font = [UIFont systemFontOfSize:15];
        dateInDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:dateInDetailLabel];
        
        
        //入库类型
        
        UILabel * dateInTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(dateInDetailLabel.frame) + 7, 70, 21)];
        dateInTypeLabel.text = @"出库类型";
        dateInTypeLabel.textAlignment = NSTextAlignmentLeft;
        dateInTypeLabel.font = [UIFont systemFontOfSize:15];
        dateInTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:dateInTypeLabel];
        
        
        
        UILabel * dateInTypeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateInTypeLabel.frame), CGRectGetMaxY(dateInDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(dateInTypeLabel.frame) - 23, 21)];
        
        if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_XSCK"] ||[self.accountDetailmodel.billType isEqualToString:@"BILL_SL_XSCK"] ) {
            dateInTypeDetailLabel.text = @"销售出库";
        }else if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_JGCK"] ||[self.accountDetailmodel.billType isEqualToString:@"BILL_SL_JGCK"] ){
            dateInTypeDetailLabel.text = @"加工出库";
        }else{
            dateInTypeDetailLabel.text = @"盘亏出库";
        }
//        dateInTypeDetailLabel.text = @"销售出库";
        dateInTypeDetailLabel.textAlignment = NSTextAlignmentRight;
        dateInTypeDetailLabel.font = [UIFont systemFontOfSize:15];
        dateInTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:dateInTypeDetailLabel];
        
        
        //入库仓库
        UILabel * dateInwarehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(dateInTypeDetailLabel.frame) + 7, 70, 21)];
        dateInwarehouseLabel.text = @"出库仓库";
        dateInwarehouseLabel.textAlignment = NSTextAlignmentLeft;
        dateInwarehouseLabel.font = [UIFont systemFontOfSize:15];
        dateInwarehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:dateInwarehouseLabel];
        
        
        
        UILabel * dateInwarehouseDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateInwarehouseLabel.frame), CGRectGetMaxY(dateInTypeDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(dateInwarehouseLabel.frame) -23, 21)];
        dateInwarehouseDetailLabel.text = self.accountDetailmodel.whsInName;
        dateInwarehouseDetailLabel.textAlignment = NSTextAlignmentRight;
        dateInwarehouseDetailLabel.font = [UIFont systemFontOfSize:15];
        dateInwarehouseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:dateInwarehouseDetailLabel];
        
        
        
    }else if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_DB"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_DB"]){
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(SCW - 61 - 19 - 28, 24, 28, 28);
        [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        
        
        //入库详情
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, SCW - 61, 28)];
        label.text = @"调拨详情";
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        [self addSubview:label];
        
        //物料名称
        UILabel * mtlNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(label.frame) + 7, 70, 21)];
        mtlNameLabel.text = @"调出仓库";
        mtlNameLabel.textAlignment = NSTextAlignmentLeft;
        mtlNameLabel.font = [UIFont systemFontOfSize:15];
        mtlNameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlNameLabel];
        
        
        //物料名称详情
        UILabel * mtlNameDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlNameLabel.frame), CGRectGetMaxY(label.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlNameLabel.frame) - 23, 21)];
        mtlNameDetailLabel.text = self.accountDetailmodel.whsName;
        mtlNameDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlNameDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlNameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlNameDetailLabel];
        
        
        //物料类别
        UILabel * mtlTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlNameDetailLabel.frame) + 7, 70, 21)];
        mtlTypeLabel.text = @"调入仓库";
        mtlTypeLabel.textAlignment = NSTextAlignmentLeft;
        mtlTypeLabel.font = [UIFont systemFontOfSize:15];
        mtlTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self addSubview:mtlTypeLabel];
        
        
        //物料类型详情
        UILabel * mtlTypeDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlTypeLabel.frame), CGRectGetMaxY(mtlNameDetailLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlTypeLabel.frame) - 23, 21)];
        mtlTypeDetailLabel.text = self.accountDetailmodel.whsInName;
        mtlTypeDetailLabel.textAlignment = NSTextAlignmentRight;
        mtlTypeDetailLabel.font = [UIFont systemFontOfSize:15];
        mtlTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:mtlTypeDetailLabel];
        
        
        
        
    }else if ([self.accountDetailmodel.billType isEqualToString:@"BILL_BL_YCCL"] || [self.accountDetailmodel.billType isEqualToString:@"BILL_SL_YCCL"]){
        
        if ([self.accountDetailmodel.abType isEqualToString:@"dlcl"]) {
            
            
            
            UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCW - 64, 390) style:UITableViewStylePlain];
            tableview.delegate = self;
            tableview.dataSource = self;
            tableview.estimatedRowHeight = 0;
            tableview.estimatedSectionFooterHeight = 0;
            tableview.estimatedSectionHeaderHeight = 0;
            tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addSubview:tableview];
            
            
            UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  SCW - 64, 105)];
            headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
           
            
            UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(SCW - 61 - 19 - 28, 4, 28, 28);
            [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:cancelBtn];
            
            //入库详情
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, SCW - 61, 28)];
            label.text = @"异常详情";
            label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:20];
            [headerView addSubview:label];
            
            UILabel * wuliaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), SCW - 61, 21)];
            wuliaoLabel.text = @"断裂处理";
            wuliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            wuliaoLabel.textAlignment = NSTextAlignmentCenter;
            wuliaoLabel.font = [UIFont systemFontOfSize:15];
            [headerView addSubview:wuliaoLabel];
            
             tableview.tableHeaderView = headerView;
            
            
            
        }else if ([self.accountDetailmodel.abType isEqualToString:@"ccbg"]){
            
            
            UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(SCW - 61 - 19 - 28, 24, 28, 28);
            [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cancelBtn];
            
            
            
            //入库详情
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, SCW - 61, 28)];
            label.text = @"异常详情";
            label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:20];
            [self addSubview:label];
            
            
            UILabel * wuliaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), SCW - 61, 21)];
            wuliaoLabel.text = @"尺寸变更";
            wuliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            wuliaoLabel.textAlignment = NSTextAlignmentCenter;
            wuliaoLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:wuliaoLabel];
            
            
            //物料名称
            UILabel * mtlNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(wuliaoLabel.frame) + 10, 80, 21)];
            mtlNameLabel.text = @"长宽高(cm)";
            mtlNameLabel.textAlignment = NSTextAlignmentLeft;
            mtlNameLabel.font = [UIFont systemFontOfSize:15];
            mtlNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
            [self addSubview:mtlNameLabel];
            
            
            //物料名称详情
            UILabel * mtlNameDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlNameLabel.frame), CGRectGetMaxY(wuliaoLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlNameLabel.frame) - 23, 21)];
            mtlNameDetailLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[self.accountDetailmodel.lengthIn doubleValue],[self.accountDetailmodel.widthIn doubleValue],[self.accountDetailmodel.heightIn doubleValue]];
            mtlNameDetailLabel.textAlignment = NSTextAlignmentRight;
            mtlNameDetailLabel.font = [UIFont systemFontOfSize:15];
            mtlNameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            [self addSubview:mtlNameDetailLabel];
            
            //长宽高删除的值
            UILabel * mtlNamemodifyDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlNameLabel.frame), CGRectGetMaxY(mtlNameDetailLabel.frame), SCW - 61 - CGRectGetMaxX(mtlNameLabel.frame) - 23, 14)];
          //  mtlNamemodifyDetailLabel.text = self.accountDetailmodel.mtlInName;
            mtlNamemodifyDetailLabel.textAlignment = NSTextAlignmentRight;
            mtlNamemodifyDetailLabel.font = [UIFont systemFontOfSize:10];
            mtlNamemodifyDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
            [self addSubview:mtlNamemodifyDetailLabel];
            
            
            NSMutableAttributedString * newPrice1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[self.accountDetailmodel.length doubleValue],[self.accountDetailmodel.width doubleValue],[self.accountDetailmodel.height doubleValue]]];
            [newPrice1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice1.length)];
            mtlNamemodifyDetailLabel.attributedText = newPrice1;
            
            
            
            //体积
            UILabel * volumeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(mtlNameLabel.frame) + 7, 70, 21)];
            volumeLabel.text = @"体积(m³)";
            volumeLabel.textAlignment = NSTextAlignmentLeft;
            volumeLabel.font = [UIFont systemFontOfSize:15];
            volumeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
            [self addSubview:volumeLabel];
            
            
            UILabel * volumeDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(volumeLabel.frame), CGRectGetMaxY(mtlNamemodifyDetailLabel.frame),SCW - 61 - CGRectGetMaxX(volumeLabel.frame) - 23 , 21)];
            volumeDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.volumeIn doubleValue]];
            volumeDetailLabel.textAlignment = NSTextAlignmentRight;
            volumeDetailLabel.font = [UIFont systemFontOfSize:15];
            volumeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            [self addSubview:volumeDetailLabel];
            
            
            UILabel * volumeModifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(volumeLabel.frame), CGRectGetMaxY(volumeDetailLabel.frame), SCW - 61 - CGRectGetMaxX(volumeLabel.frame) - 23, 14)];
            //volumeModifyLabel.text = self.accountDetailmodel.volume;
            volumeModifyLabel.textAlignment = NSTextAlignmentRight;
            volumeModifyLabel.font = [UIFont systemFontOfSize:10];
            volumeModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
            [self addSubview:volumeModifyLabel];
            
            NSMutableAttributedString * newPrice2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.1lf",[self.accountDetailmodel.volume doubleValue]]];
            [newPrice2 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice2.length)];
            volumeModifyLabel.attributedText = newPrice2;
            
            
            //重量
            
            UILabel * weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(volumeLabel.frame) + 7, 70, 21)];
            weightLabel.text = @"重量(吨)";
            weightLabel.textAlignment = NSTextAlignmentLeft;
            weightLabel.font = [UIFont systemFontOfSize:15];
            weightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
            [self addSubview:weightLabel];
            
            
            //详细
            UILabel * weightDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(weightLabel.frame), CGRectGetMaxY(volumeLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(volumeLabel.frame) - 23, 21)];
            weightDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.weightIn doubleValue]];
            weightDetailLabel.textAlignment = NSTextAlignmentRight;
            weightDetailLabel.font = [UIFont systemFontOfSize:15];
            weightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            [self addSubview:weightDetailLabel];
            
            
            //修改的值
            UILabel * weightModifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(weightLabel.frame), CGRectGetMaxY(weightDetailLabel.frame), SCW - 61 - CGRectGetMaxX(volumeLabel.frame) - 23, 14)];
            weightModifyLabel.textAlignment = NSTextAlignmentRight;
            weightModifyLabel.font = [UIFont systemFontOfSize:10];
            weightModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
            [self addSubview:weightModifyLabel];
            
            
            NSMutableAttributedString * newPrice3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.1lf",[self.accountDetailmodel.weight doubleValue]]];
            [newPrice3 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice3.length)];
            weightModifyLabel.attributedText = newPrice3;
            
            
            
        }else{
        
            UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(SCW - 61 - 19 - 28, 24, 28, 28);
            [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cancelBtn];
            
            
            
            //入库详情
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, SCW - 61, 28)];
            label.text = @"异常详情";
            label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:20];
            [self addSubview:label];
            
            
            UILabel * wuliaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), SCW - 61, 21)];
            wuliaoLabel.text = @"物料变更";
            wuliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            wuliaoLabel.textAlignment = NSTextAlignmentCenter;
            wuliaoLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:wuliaoLabel];
            
            
            
            //物料名称
            UILabel * mtlNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(wuliaoLabel.frame) + 10, 70, 21)];
            mtlNameLabel.text = @"物料名称";
            mtlNameLabel.textAlignment = NSTextAlignmentLeft;
            mtlNameLabel.font = [UIFont systemFontOfSize:15];
            mtlNameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
            [self addSubview:mtlNameLabel];
            
            
            //物料名称详情
            UILabel * mtlNameDetailLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlNameLabel.frame), CGRectGetMaxY(wuliaoLabel.frame) + 7, SCW - 61 - CGRectGetMaxX(mtlNameLabel.frame) - 23, 21)];
            mtlNameDetailLabel.text = self.accountDetailmodel.mtlInName;
            mtlNameDetailLabel.textAlignment = NSTextAlignmentRight;
            mtlNameDetailLabel.font = [UIFont systemFontOfSize:15];
            mtlNameDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            [self addSubview:mtlNameDetailLabel];
            
            //删除的值
            
           
            
            
            UILabel * deleteLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mtlNameLabel.frame), CGRectGetMaxY(mtlNameDetailLabel.frame), SCW - 61 - CGRectGetMaxX(mtlNameLabel.frame) - 23, 14)];
            //deleteLabel.text = self.accountDetailmodel.mtlName;
            deleteLabel.textAlignment = NSTextAlignmentRight;
            deleteLabel.font = [UIFont systemFontOfSize:10];
            deleteLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
            [self addSubview:deleteLabel];
            
            
            NSMutableAttributedString * newPrice1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",self.accountDetailmodel.mtlName]]];
            [newPrice1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice1.length)];
            deleteLabel.attributedText = newPrice1;
        }
    }
}




//取消
- (void)cancelAction:(UIButton *)cancelBtn{
//     [self closeView];
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}


#pragma mark ====展示view
- (void)showView
{
    if (self.bgView) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
    
}
-(void)tap:(UIGestureRecognizer *)tap
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}

- (void)closeView
{
    
    [self.bgView removeFromSuperview];
     self.bgView = nil;
    [self removeFromSuperview];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.accountDetailmodel.billDetailVos.count;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * ACCOUNTHEADVIEW = @"ACCOUNTHEADVIEW";
    RSAccountHeaderView * accountHeaderview = [[RSAccountHeaderView alloc]initWithReuseIdentifier:ACCOUNTHEADVIEW];
    if (section == 0) {
        accountHeaderview.nameLabel.text = @"处理前";
    }else{
       accountHeaderview.nameLabel.text = @"处理后";
    }
    return accountHeaderview;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ACCOUNTRUNCELLID = @"ACCOUNTRUNCELLID";
    RSAccountAlertCell * cell = [tableView dequeueReusableCellWithIdentifier:ACCOUNTRUNCELLID];
    if (!cell) {
        cell = [[RSAccountAlertCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ACCOUNTRUNCELLID];
    }
    
    if (indexPath.section == 0) {
        cell.shapeDetialLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[self.accountDetailmodel.length doubleValue],[self.accountDetailmodel.width doubleValue],[self.accountDetailmodel.height doubleValue]];
        cell.weightDetialLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.weight doubleValue]];
        cell.volumeDetialLabel.text =[NSString stringWithFormat:@"%0.3lf",[self.accountDetailmodel.volume doubleValue]];
    }else{
        RSAccountDetailModel * accountdetialmodel = self.accountDetailmodel.billDetailVos[indexPath.row];
        cell.shapeDetialLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[accountdetialmodel.length doubleValue],[accountdetialmodel.width doubleValue],[accountdetialmodel.height doubleValue]];
        cell.weightDetialLabel.text = [NSString stringWithFormat:@"%0.3lf",[accountdetialmodel.weight doubleValue]];
        cell.volumeDetialLabel.text =[NSString stringWithFormat:@"%0.3lf",[accountdetialmodel.volume doubleValue]];
        
    }
    return cell;
    
}




@end
