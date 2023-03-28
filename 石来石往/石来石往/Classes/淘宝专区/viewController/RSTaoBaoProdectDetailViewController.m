//
//  RSTaoBaoProdectDetailViewController.m
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProdectDetailViewController.h"

//荒料
#import "RSTaoBaoProductDetailHeaderView.h"
//大板
#import "RSTaoBaoProductDetailSLHeaderView.h"

#import "RSTaoBaoProductDetialCell.h"
#import "RSTaoBaoProductDetailFootView.h"

//相册
#import "RSTaoBaoVideoAndPictureViewController.h"
//模型
#import "RSTaobaoInventoryDetModel.h"


@interface RSTaoBaoProdectDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    //物料名称
    UITextField * _nameTextField;
    
    UITextField * _originalpriceTextField;
    //价钱
    UITextField * _priceTextField;
    
    //总重量
    UITextField * _weightTextField;
    
    //体积
    UITextField * _vomlueTextField;
    
    
    //跳转到视频和图片的按键
    UIButton * _albumBtn;
    
    
    
    UILabel * _originalpriceLabel;
    
    UILabel * _priceLabel;
    
    //添加
    UIButton * _addBtn;
    //保存
    UIButton * _saveBtn;
    //上架还是下架
    UIButton * _onShelfBtn;
    //取消
    UIButton * _cancelBtn;
    
}

@property (nonatomic,strong)UITableView * tableview;



@end

@implementation RSTaoBaoProdectDetailViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    //去除导航栏下方的横线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
//                                                  forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y) style:UITableViewStyleGrouped];
    self.tableview = tableview;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 98, 0);
    [self.view addSubview:tableview];
    [self setTableviewHeaderView];
    [self setBottomView];
    if (self.joinType == 0 || self.joinType == 3) {
        [self relodNewAddNewData];
    }else{
        [self reloadSignerNewData];
    }
}


//获取单条数据
- (void)reloadSignerNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    //URL_TAOBAOGETINVENTORYLIST_IOS
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.taobaomangementmodel.mangementID] forKey:@"id"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_TAOBAOGETINVENTORY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                RSTaoBaoMangementModel * taobaomangementmodel = [[RSTaoBaoMangementModel alloc]init];
                taobaomangementmodel.createTime = json[@"data"][@"createTime"];
                taobaomangementmodel.mangementID = [json[@"data"][@"id"] integerValue];
                taobaomangementmodel.identityId = json[@"data"][@"identityId"];
                taobaomangementmodel.inventory = json[@"data"][@"inventory"];
                taobaomangementmodel.isComplete = [json[@"data"][@"isComplete"] integerValue];
                taobaomangementmodel.originalPrice = json[@"data"][@"originalPrice"];
                taobaomangementmodel.price = json[@"data"][@"price"];
                taobaomangementmodel.status = [json[@"data"][@"status"] integerValue];
                taobaomangementmodel.stockType = json[@"data"][@"stockType"];
                taobaomangementmodel.stoneName = json[@"data"][@"stoneName"];
                taobaomangementmodel.tsUserId = json[@"data"][@"tsUserId"];
                taobaomangementmodel.updateTime = json[@"data"][@"updateTime"];
                
                taobaomangementmodel.unit = json[@"data"][@"unit"];
                taobaomangementmodel.weight = json[@"data"][@"weight"];
                
                taobaomangementmodel.videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                taobaomangementmodel.videoAndPicturemodel.imageId = [json[@"data"][@"video"][@"imageId"] integerValue];
                taobaomangementmodel.videoAndPicturemodel.videoId = [json[@"data"][@"video"][@"videoId"] integerValue];
                taobaomangementmodel.videoAndPicturemodel.imageUrl = json[@"data"][@"video"][@"imageUrl"];
                taobaomangementmodel.videoAndPicturemodel.videoUrl = json[@"data"][@"video"][@"videoUrl"];
                NSMutableArray * temp = [NSMutableArray array];
                temp = json[@"data"][@"imageList"];
                [taobaomangementmodel.imageList removeAllObjects];
                for (int j = 0; j < temp.count; j++) {
                    RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                    videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
                    videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
                    videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
                    videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
                    [taobaomangementmodel.imageList addObject:videoAndPicturemodel];
                }
                NSMutableArray *  stoneList = [NSMutableArray array];
                stoneList = json[@"data"][@"stoneDtlList"];
                if ([weakSelf.type isEqualToString:@"荒料"]) {
                    for (int n = 0; n < stoneList.count; n++) {
                        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = [[RSTaobaoInventoryDetModel alloc]init];
                        taobaoInventoryDetmodel.InventoryDetID = [[[stoneList objectAtIndex:n]objectForKey:@"id"]integerValue];
                        taobaoInventoryDetmodel.stoneType = [[stoneList objectAtIndex:n]objectForKey:@"stoneType"];
                        taobaoInventoryDetmodel.warehouseName = [[stoneList objectAtIndex:n]objectForKey:@"warehouseName"];
                        taobaoInventoryDetmodel.blockNo = [[stoneList objectAtIndex:n]objectForKey:@"blockNo"];
                        taobaoInventoryDetmodel.turnNo = [[stoneList objectAtIndex:n]objectForKey:@"turnNo"];
                        taobaoInventoryDetmodel.turnQty = [[[stoneList objectAtIndex:n]objectForKey:@"turnQty"]integerValue];
                        taobaoInventoryDetmodel.length =  [[stoneList objectAtIndex:n]objectForKey:@"length"];
                        taobaoInventoryDetmodel.width = [[stoneList objectAtIndex:n]objectForKey:@"width"];
                        taobaoInventoryDetmodel.height = [[stoneList objectAtIndex:n]objectForKey:@"height"];
                        taobaoInventoryDetmodel.volume = [[stoneList objectAtIndex:n]objectForKey:@"volume"];
                        taobaoInventoryDetmodel.weight = [[stoneList objectAtIndex:n]objectForKey:@"weight"];
                        taobaoInventoryDetmodel.preArea = [[stoneList objectAtIndex:n]objectForKey:@"preArea"];
                        taobaoInventoryDetmodel.dedArea = [[stoneList objectAtIndex:n]objectForKey:@"dedArea"];
                         taobaoInventoryDetmodel.inventoryId = [[[stoneList objectAtIndex:n]objectForKey:@"inventoryId"]integerValue];
                        taobaoInventoryDetmodel.area = [[stoneList objectAtIndex:n]objectForKey:@"area"];
                        
                        [taobaomangementmodel.stoneDtlList addObject:taobaoInventoryDetmodel];
                    }
//
                    weakSelf.taobaomangementmodel = taobaomangementmodel;
                    
                    
                    NSString * str = [NSString string];
                    str = @"0.000";
                    //这边是对总体积进行计算
                    for (int i = 0; i <self.taobaomangementmodel.stoneDtlList.count; i++) {
                      RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = self.taobaomangementmodel.stoneDtlList[i];
                      str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoInventoryDetmodel.volume floatValue]]];
                    }
                         

                    _nameTextField.text = weakSelf.taobaomangementmodel.stoneName;
                    _priceTextField.text = [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.price floatValue]];
                    _vomlueTextField.text = str;
                    _originalpriceTextField.text =  [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.originalPrice floatValue]];
                    
                    
                    _weightTextField.text = [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.weight floatValue]];
                    
                    
                    if ([weakSelf.type isEqualToString:@"荒料"]) {
                        if ([taobaomangementmodel.unit isEqualToString:@""]) {
                            _priceLabel.text = @"价格/m³";
                            _originalpriceLabel.text = @"原价格/m³";
                        }else if ([taobaomangementmodel.unit isEqualToString:@"立方米"]){
                            _priceLabel.text = @"价格/m³";
                            _originalpriceLabel.text = @"原价格/m³";
                        }else{
                            _priceLabel.text = @"价格/吨";
                            _originalpriceLabel.text = @"原价格/吨";
                        }
                    }else{
                        
                        _priceLabel.text = @"价格/m²";
                        _originalpriceLabel.text = @"原价格/m²";
                        
                    }
                    [weakSelf.tableview reloadData];
                }else{
                    NSMutableArray * temp = [NSMutableArray array];
                    for (int n = 0; n < stoneList.count; n++) {
                        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = [[RSTaobaoInventoryDetModel alloc]init];
                        taobaoInventoryDetmodel.InventoryDetID = [[[stoneList objectAtIndex:n]objectForKey:@"id"]integerValue];
                        taobaoInventoryDetmodel.stoneType = [[stoneList objectAtIndex:n]objectForKey:@"stoneType"];
                        taobaoInventoryDetmodel.warehouseName = [[stoneList objectAtIndex:n]objectForKey:@"warehouseName"];
                        taobaoInventoryDetmodel.blockNo = [[stoneList objectAtIndex:n]objectForKey:@"blockNo"];
                        taobaoInventoryDetmodel.turnNo = [[stoneList objectAtIndex:n]objectForKey:@"turnNo"];
                        taobaoInventoryDetmodel.turnQty = [[[stoneList objectAtIndex:n]objectForKey:@"turnQty"]integerValue];
                        taobaoInventoryDetmodel.length =  [[stoneList objectAtIndex:n]objectForKey:@"length"];
                        taobaoInventoryDetmodel.width = [[stoneList objectAtIndex:n]objectForKey:@"width"];
                        taobaoInventoryDetmodel.height = [[stoneList objectAtIndex:n]objectForKey:@"height"];
                        taobaoInventoryDetmodel.volume = [[stoneList objectAtIndex:n]objectForKey:@"volume"];
                        taobaoInventoryDetmodel.weight = [[stoneList objectAtIndex:n]objectForKey:@"weight"];
                        taobaoInventoryDetmodel.preArea = [[stoneList objectAtIndex:n]objectForKey:@"preArea"];
                        taobaoInventoryDetmodel.dedArea = [[stoneList objectAtIndex:n]objectForKey:@"dedArea"];
                        taobaoInventoryDetmodel.inventoryId = [[[stoneList objectAtIndex:n]objectForKey:@"inventoryId"]integerValue];
                        taobaoInventoryDetmodel.isOpen = false;
                        taobaoInventoryDetmodel.area = [[stoneList objectAtIndex:n]objectForKey:@"area"];
                        [temp addObject:taobaoInventoryDetmodel];
                    }
                    //大板
                    taobaomangementmodel.stoneDtlList = [weakSelf changeArrayRule:temp];
                    weakSelf.taobaomangementmodel = taobaomangementmodel;
                    NSString * str = [NSString string];
                    str = @"0.000";
                    //这边是对总体积进行计算
                    for (int i = 0; i <self.taobaomangementmodel.stoneDtlList.count; i++) {
                        NSArray * array = self.taobaomangementmodel.stoneDtlList[i];
                        for (int j = 0; j < array.count; j++) {
                           RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[j]
                            ;
                           str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoInventoryDetmodel.area floatValue]]];
                        }
                    }
                    _nameTextField.text = weakSelf.taobaomangementmodel.stoneName;
                    _priceTextField.text = [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.price floatValue]];
                    _vomlueTextField.text = str;
                    _originalpriceTextField.text =  [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.originalPrice floatValue]];
                    
                    
                    _weightTextField.text = [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.weight floatValue]];
                    
                    
                    if ([weakSelf.type isEqualToString:@"荒料"]) {
                        if ([taobaomangementmodel.unit isEqualToString:@""]) {
                            _priceLabel.text = @"价格/m³";
                            _originalpriceLabel.text = @"原价格/m³";
                        }else if ([taobaomangementmodel.unit isEqualToString:@"立方米"]){
                            _priceLabel.text = @"价格/m³";
                            _originalpriceLabel.text = @"原价格/m³";
                        }else{
                            _priceLabel.text = @"价格/吨";
                            _originalpriceLabel.text = @"原价格/吨";
                        }
                    }else{
                        
                        _priceLabel.text = @"价格/m²";
                        _originalpriceLabel.text = @"原价格/m²";
                        
                    }
                    
                    
                    [weakSelf.tableview reloadData];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


//添加获取数据
- (void)relodNewAddNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    //URL_TAOBAOGETINVENTORYLIST_IOS
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * str = [NSString string];
    if ([self.type isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else{
        str = @"daban";
    }
    [phoneDict setObject:str forKey:@"stockType"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_TAOBAOADDINVENTORY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                RSTaoBaoMangementModel * taobaomangementmodel = [[RSTaoBaoMangementModel alloc]init];
                taobaomangementmodel.createTime = json[@"data"][@"createTime"];
                taobaomangementmodel.mangementID = [json[@"data"][@"id"] integerValue];
                taobaomangementmodel.identityId = json[@"data"][@"identityId"];
                taobaomangementmodel.inventory = json[@"data"][@"inventory"];
                taobaomangementmodel.originalPrice = json[@"data"][@"originalPrice"];
                taobaomangementmodel.price = json[@"data"][@"price"];
                taobaomangementmodel.status = [json[@"data"][@"status"] integerValue];
                taobaomangementmodel.stockType = json[@"data"][@"stockType"];
                taobaomangementmodel.stoneName = json[@"data"][@"stoneName"];
                taobaomangementmodel.tsUserId = json[@"data"][@"tsUserId"];
                taobaomangementmodel.updateTime = json[@"data"][@"updateTime"];
                taobaomangementmodel.unit = json[@"data"][@"unit"];
                taobaomangementmodel.weight = json[@"data"][@"weight"];
              
                taobaomangementmodel.imageList = json[@"data"][@"imageList"];
                taobaomangementmodel.stoneDtlList = json[@"data"][@"stoneDtlList"];
                
                taobaomangementmodel.videoAndPicturemodel.imageId = [json[@"data"][@"video"][@"imageId"] integerValue];
                taobaomangementmodel.videoAndPicturemodel.videoId = [json[@"data"][@"video"][@"videoId"] integerValue];
                taobaomangementmodel.videoAndPicturemodel.imageUrl = json[@"data"][@"video"][@"imageUrl"];
                taobaomangementmodel.videoAndPicturemodel.videoUrl = json[@"data"][@"video"][@"videoUrl"];
                
                weakSelf.taobaomangementmodel = taobaomangementmodel;
                
                _nameTextField.text = weakSelf.taobaomangementmodel.stoneName;
                
                _priceTextField.text = [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.price floatValue]];
                
                _vomlueTextField.text = [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.inventory floatValue]];
                
                _originalpriceTextField.text =  [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.originalPrice floatValue]];
                _weightTextField.text = [NSString stringWithFormat:@"%0.3lf",[weakSelf.taobaomangementmodel.weight floatValue]];
                
                if ([weakSelf.type isEqualToString:@"荒料"]) {
                    if ([taobaomangementmodel.unit isEqualToString:@""]) {
                        _priceLabel.text = @"价格/m³";
                        _originalpriceLabel.text = @"原价格/m³";
                    }else if ([taobaomangementmodel.unit isEqualToString:@"立方米"]){
                        _priceLabel.text = @"价格/m³";
                        _originalpriceLabel.text = @"原价格/m³";
                    }else{
                        _priceLabel.text = @"价格/吨";
                        _originalpriceLabel.text = @"原价格/吨";
                    }
                }else{
                    
                    _priceLabel.text = @"价格/m²";
                    _originalpriceLabel.text = @"原价格/m²";
                    
                }
                
                [_onShelfBtn setTitle:@"上架" forState:UIControlStateNormal];
                [weakSelf.tableview reloadData];
                
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取失败"];
        }
    }];
}





- (void)setTableviewHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    //请输入物料名称
    UIView * nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 46)];
    nameView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:nameView];
    
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 20)];
    nameLabel.text = @"物料名称";
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [nameView addSubview:nameLabel];
    
    UITextField * nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 13, SCW - CGRectGetMaxX(nameLabel.frame) - 10 - 24, 20)];
    nameTextField.textAlignment = NSTextAlignmentRight;
    nameTextField.placeholder = @"请选择物料名称";
    nameTextField.font = [UIFont systemFontOfSize:15];
    nameTextField.returnKeyType = UIReturnKeyDone;
    nameTextField.delegate = self;
    nameTextField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [nameView addSubview:nameTextField];
    _nameTextField = nameTextField;
    
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(12, 45, SCW - 24, 1)];
    firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [nameView addSubview:firstView];
    
    
    //原价格
    UIView * originalPriceView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nameView.frame), SCW, 46)];
    originalPriceView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:originalPriceView];
    
    UILabel * originalpriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 70, 20)];
    originalpriceLabel.text = @"原价格/m³";
    originalpriceLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    originalpriceLabel.font = [UIFont systemFontOfSize:15];
    originalpriceLabel.textAlignment = NSTextAlignmentLeft;
    [originalPriceView addSubview:originalpriceLabel];
    
    _originalpriceLabel = originalpriceLabel;
    
    UITextField * originalpriceTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(originalpriceLabel.frame) + 10, 13, SCW - CGRectGetMaxX(originalpriceLabel.frame) - 10 - 24, 20)];
    originalpriceTextField.textAlignment = NSTextAlignmentRight;
    originalpriceTextField.placeholder = @"请填写价格";
    originalpriceTextField.font = [UIFont systemFontOfSize:15];
    originalpriceTextField.returnKeyType = UIReturnKeyDone;
    originalpriceTextField.delegate = self;
    originalpriceTextField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [originalPriceView addSubview:originalpriceTextField];
    _originalpriceTextField = originalpriceTextField;
    
    
    UIView * newView = [[UIView alloc]initWithFrame:CGRectMake(12, 45, SCW - 24, 1)];
    newView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [originalPriceView addSubview:newView];
    
    
    
    //价格
    UIView * priceView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(originalPriceView.frame), SCW, 46)];
    priceView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:priceView];
    
    
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 20)];
    
    priceLabel.text = @"价格/m³";
    
    priceLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    [priceView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    
    UITextField * priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame) + 10, 13, SCW - CGRectGetMaxX(priceLabel.frame) - 10 - 24, 20)];
    priceTextField.textAlignment = NSTextAlignmentRight;
    priceTextField.placeholder = @"请填写价格";
    priceTextField.font = [UIFont systemFontOfSize:15];
      priceTextField.returnKeyType = UIReturnKeyDone;
    priceTextField.delegate = self;
    priceTextField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [priceView addSubview:priceTextField];
    _priceTextField = priceTextField;
    
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(12, 45, SCW - 24, 1)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [priceView addSubview:secondView];
    
    
    //计价单位
    UIView * valuationView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(priceView.frame), SCW, 46)];
    valuationView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
     [headerView addSubview:valuationView];
    
    
    UIButton * valuationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, valuationView.yj_width, valuationView.yj_height - 1)];
    [valuationBtn setTitle:@"计价单位" forState:UIControlStateNormal];
    [valuationBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    valuationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [valuationBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [valuationView addSubview:valuationBtn];
    [valuationBtn addTarget:self action:@selector(selectedValuationAction:) forControlEvents:UIControlEventTouchUpInside];
    
        
    UIView * valuationsecondView = [[UIView alloc]initWithFrame:CGRectMake(12, 45, SCW - 24, 1)];
    valuationsecondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [valuationView addSubview:valuationsecondView];
    
    
    //总重量
    UIView * weightView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(valuationView.frame), SCW, 46)];
    weightView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:weightView];
    
    
    
    UILabel * weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 20)];
    weightLabel.text = @"总重量";
    weightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    weightLabel.font = [UIFont systemFontOfSize:15];
    weightLabel.textAlignment = NSTextAlignmentLeft;
    [weightView addSubview:weightLabel];
    
    UITextField * weightTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(weightLabel.frame) + 10, 13, SCW - CGRectGetMaxX(weightLabel.frame) - 10 - 24, 20)];
    weightTextField.textAlignment = NSTextAlignmentRight;
    weightTextField.placeholder = @"0.000";
    weightTextField.font = [UIFont systemFontOfSize:15];
    weightTextField.delegate = self;
    weightTextField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    weightTextField.returnKeyType = UIReturnKeyDone;
    [weightView addSubview:weightTextField];
    _weightTextField = weightTextField;
    
    UIView * weightthirdView = [[UIView alloc]initWithFrame:CGRectMake(12, 45, SCW - 24, 1)];
    weightthirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [weightView addSubview:weightthirdView];
    
    
     UIView * vomlueView = [[UIView alloc]init];
    if ([self.type isEqualToString:@"荒料"]) {
        
        vomlueView.frame = CGRectMake(0, CGRectGetMaxY(weightView.frame), SCW, 46);
        valuationView.hidden = NO;
        valuationBtn.hidden = NO;
        valuationsecondView.hidden = NO;
        weightView.hidden = NO;
        weightLabel.hidden = NO;
        weightTextField.hidden = NO;
        weightthirdView.hidden = NO;
        
    }else{
        
        vomlueView.frame = CGRectMake(0, CGRectGetMaxY(priceView.frame), SCW, 46);
        valuationView.hidden = YES;
        valuationBtn.hidden = YES;
        valuationsecondView.hidden = YES;
        weightView.hidden = YES;
        weightLabel.hidden = YES;
        weightTextField.hidden = YES;
        weightthirdView.hidden = YES;
        
    }
    //总体积
    vomlueView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:vomlueView];
    
    
    
    UILabel * vomlueLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 20)];
    
    if ([self.type isEqualToString:@"荒料"]) {
       vomlueLabel.text = @"总体积";
    }else{
       vomlueLabel.text = @"总面积";
    }
    vomlueLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    vomlueLabel.font = [UIFont systemFontOfSize:15];
    vomlueLabel.textAlignment = NSTextAlignmentLeft;
    [vomlueView addSubview:vomlueLabel];
    
    UITextField * vomlueTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(vomlueLabel.frame) + 10, 13, SCW - CGRectGetMaxX(vomlueLabel.frame) - 10 - 24, 20)];
    vomlueTextField.textAlignment = NSTextAlignmentRight;
    vomlueTextField.placeholder = @"0.000";
    vomlueTextField.font = [UIFont systemFontOfSize:15];
    vomlueTextField.delegate = self;
    vomlueTextField.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    vomlueTextField.returnKeyType = UIReturnKeyDone;
    [vomlueView addSubview:vomlueTextField];
    //vomlueTextField.enabled = false;
    _vomlueTextField = vomlueTextField;
    
    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(12, 45, SCW - 24, 1)];
    thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [vomlueView addSubview:thirdView];
    
    //相册
    UIView * albumView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(vomlueView.frame), SCW, 46)];
    albumView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:albumView];
    
    
    UILabel * albumLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 20)];
    albumLabel.text = @"相册";
    albumLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    albumLabel.font = [UIFont systemFontOfSize:15];
    albumLabel.textAlignment = NSTextAlignmentLeft;
    [albumView addSubview:albumLabel];
    
    UIButton * albumBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(albumLabel.frame) + 10, 13, SCW - CGRectGetMaxX(albumLabel.frame) - 10 - 24, 20)];
    [albumBtn setTitle:@"添加照片/视频>" forState:UIControlStateNormal];
    [albumBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [albumBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    albumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    albumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [albumBtn addTarget:self action:@selector(addVideoAndAblumAction:) forControlEvents:UIControlEventTouchUpInside];
    [albumView addSubview:albumBtn];
    _albumBtn = albumBtn;
    
    UIView * fiveView = [[UIView alloc]initWithFrame:CGRectMake(12, 45, SCW - 24, 1)];
    fiveView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [albumView addSubview:fiveView];
    
  
    
    [headerView setupAutoHeightWithBottomView:albumView bottomMargin:0];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    

    if ([self.typeStatus isEqualToString:@"已上架"]) {
        
        nameTextField.enabled = NO;
        priceTextField.enabled = NO;
        vomlueTextField.enabled = NO;
        originalpriceTextField.enabled= NO;
        albumBtn.enabled = YES;
        weightTextField.enabled = NO;
        
    }else{
        
        
        nameTextField.enabled = YES;
        priceTextField.enabled = YES;
        vomlueTextField.enabled = NO;
        weightTextField.enabled = NO;
        originalpriceTextField.enabled = YES;
        albumBtn.enabled = YES;
    }
}


//选择计价单位
- (void)selectedValuationAction:(UIButton *)valuationBtn{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择你需要的计价单位" message:@"荒料部分计价单位" preferredStyle:UIAlertControllerStyleActionSheet];
    if ([_originalpriceLabel.text isEqualToString:@"原价格/m³"] && [_priceLabel.text isEqualToString:@"价格/m³"]) {
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"立方米" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            _originalpriceLabel.text = @"原价格/m³";
            _priceLabel.text = @"价格/m³";
        }];
        [alert addAction:action1];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"吨" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _originalpriceLabel.text = @"原价格/吨";
            _priceLabel.text = @"价格/吨";
        }];
        [alert addAction:action2];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action3];
    }else{
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"立方米" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _originalpriceLabel.text = @"原价格/m³";
            _priceLabel.text = @"价格/m³";
        }];
        [alert addAction:action1];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"吨" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            _originalpriceLabel.text = @"原价格/吨";
            _priceLabel.text = @"价格/吨";
        }];
        [alert addAction:action2];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action3];
    }
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alert animated:YES completion:nil];
    
}




//添加视频和图片
- (void)addVideoAndAblumAction:(UIButton *)albumBtn{
    RSTaoBaoVideoAndPictureViewController * taobaoVideoAndPictureVc = [[RSTaoBaoVideoAndPictureViewController alloc]init];
    taobaoVideoAndPictureVc.taobaoUsermodel = self.taobaoUsermodel;
    taobaoVideoAndPictureVc.taobaoManagementmodel = self.taobaomangementmodel;
    [self.navigationController pushViewController:taobaoVideoAndPictureVc animated:YES];
}



- (void)setBottomView{
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - 98, SCW, 98)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    [bottomView bringSubviewToFront:self.view];
    
    
    // 添加
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(SCW - 40, 8, 24, 24);
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
    [bottomView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    _addBtn = addBtn;
    
    
    //内容
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCW, 49)];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [bottomView addSubview:contentView];
    
    
    //保存
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.frame = CGRectMake(SCW - 12 - 47, 12, 47, 23);
    [contentView addSubview:saveBtn];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    saveBtn.layer.cornerRadius = 12;
    saveBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF4B33"].CGColor;
    saveBtn.layer.borderWidth = 1;
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn = saveBtn;
    
    //上架
    UIButton * onShelfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [onShelfBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    onShelfBtn.frame = CGRectMake(SCW - 20 - 47 - 47 , 12, 47, 23);
    [contentView addSubview:onShelfBtn];
    onShelfBtn.layer.cornerRadius = 12;
    onShelfBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    onShelfBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF4B33"].CGColor;
    onShelfBtn.layer.borderWidth = 1;
    [onShelfBtn addTarget:self action:@selector(onShelfAction:) forControlEvents:UIControlEventTouchUpInside];
    _onShelfBtn = onShelfBtn;
    
    
    //取消
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(SCW - 28 - 47 - 47 - 47, 12, 47, 23);
    [contentView addSubview:cancelBtn];
    cancelBtn.layer.cornerRadius = 12;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    cancelBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF4B33"].CGColor;
    cancelBtn.layer.borderWidth = 1;
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn = cancelBtn;
    
    if ([self.typeStatus isEqualToString:@"已上架"]) {
        addBtn.hidden = YES;
        saveBtn.hidden = YES;
        cancelBtn.hidden = YES;
        onShelfBtn.hidden = NO;
        [onShelfBtn setTitle:@"下架" forState:UIControlStateNormal];
    }else{
        addBtn.hidden = NO;
        saveBtn.hidden = NO;
        cancelBtn.hidden = NO;
        onShelfBtn.hidden = NO;
        [onShelfBtn setTitle:@"上架" forState:UIControlStateNormal];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.taobaomangementmodel.stoneDtlList.count;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.type isEqualToString:@"荒料"]) {
        return 0;
    }else{
        NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[section];
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[0];
        if (taobaoInventoryDetmodel.isOpen) {
            return array.count;
        }else {
            return 0;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 158;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.typeStatus isEqualToString:@"已上架"]) {
       return 209;
    }else{
       return 244;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * TAOBAOPRODUCTDETIALHEADERVIEW = @"TAOBAOPRODUCTDETIALHEADERVIEW";
    if ([self.type isEqualToString:@"荒料"]) {
        RSTaoBaoProductDetailHeaderView  * taoBaoProductDetailHeaderview = [[RSTaoBaoProductDetailHeaderView alloc]initWithReuseIdentifier:TAOBAOPRODUCTDETIALHEADERVIEW];
        
        taoBaoProductDetailHeaderview.addressTextField.tag = section;
        taoBaoProductDetailHeaderview.blockNoLabelTextField.tag = section;
        taoBaoProductDetailHeaderview.typeTextField.tag = section;
        taoBaoProductDetailHeaderview.widthTextField.tag = section;
        taoBaoProductDetailHeaderview.areaTextField.tag = section;
        taoBaoProductDetailHeaderview.lenghtTextField.tag = section;
        taoBaoProductDetailHeaderview.heightTextField.tag = section;
        taoBaoProductDetailHeaderview.totalTextField.tag = section;
        taoBaoProductDetailHeaderview.deleteBtn.tag = section;
        //taoBaoProductDetailHeaderview.addressTextField.tag = section;
        
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = self.taobaomangementmodel.stoneDtlList[section];
        
        
        taoBaoProductDetailHeaderview.blockNoLabelTextField.text = taobaoInventoryDetmodel.blockNo;
        taoBaoProductDetailHeaderview.typeTextField.text = taobaoInventoryDetmodel.stoneType;
        
        taoBaoProductDetailHeaderview.widthTextField.text = [NSString stringWithFormat:@"%0.1lf",[taobaoInventoryDetmodel.width  floatValue]];
        taoBaoProductDetailHeaderview.areaTextField.text = [NSString stringWithFormat:@"%0.3lf",[taobaoInventoryDetmodel.volume  floatValue]];
        taoBaoProductDetailHeaderview.lenghtTextField.text = [NSString stringWithFormat:@"%0.1lf",[taobaoInventoryDetmodel.length  floatValue]];
        taoBaoProductDetailHeaderview.heightTextField.text = [NSString stringWithFormat:@"%0.2lf",[taobaoInventoryDetmodel.height  floatValue]];
        taoBaoProductDetailHeaderview.totalTextField.text = [NSString stringWithFormat:@"%0.3lf",[taobaoInventoryDetmodel.weight  floatValue]];
        taoBaoProductDetailHeaderview.addressTextField.text = taobaoInventoryDetmodel.warehouseName;
        
        
        [taoBaoProductDetailHeaderview.blockNoLabelTextField addTarget:self action:@selector(taoBaoProudctEndContent:) forControlEvents:UIControlEventEditingDidEnd];
        [taoBaoProductDetailHeaderview.typeTextField addTarget:self action:@selector(taoBaoProudctEndContent:) forControlEvents:UIControlEventEditingDidEnd];
        [taoBaoProductDetailHeaderview.addressTextField addTarget:self action:@selector(taoBaoProudctEndContent:) forControlEvents:UIControlEventEditingDidEnd];
        
        
        
        [taoBaoProductDetailHeaderview.widthTextField addTarget:self action:@selector(taoBaoProudctContent:) forControlEvents:UIControlEventEditingChanged];
        [taoBaoProductDetailHeaderview.areaTextField addTarget:self action:@selector(taoBaoProudctContent:) forControlEvents:UIControlEventEditingChanged];
        [taoBaoProductDetailHeaderview.lenghtTextField addTarget:self action:@selector(taoBaoProudctContent:) forControlEvents:UIControlEventEditingChanged];
        [taoBaoProductDetailHeaderview.heightTextField addTarget:self action:@selector(taoBaoProudctContent:) forControlEvents:UIControlEventEditingChanged];
        [taoBaoProductDetailHeaderview.totalTextField addTarget:self action:@selector(taoBaoProudctContent:) forControlEvents:UIControlEventEditingChanged];
     
        [taoBaoProductDetailHeaderview.deleteBtn addTarget:self action:@selector(taobaoProdctContentDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.typeStatus isEqualToString:@"已上架"]) {
            
            taoBaoProductDetailHeaderview.addressTextField.enabled = NO;
            taoBaoProductDetailHeaderview.blockNoLabelTextField.enabled = NO;
            taoBaoProductDetailHeaderview.typeTextField.enabled = NO;
            taoBaoProductDetailHeaderview.widthTextField.enabled = NO;
            taoBaoProductDetailHeaderview.areaTextField.enabled = NO;
            taoBaoProductDetailHeaderview.lenghtTextField.enabled = NO;
            taoBaoProductDetailHeaderview.heightTextField.enabled = NO;
            taoBaoProductDetailHeaderview.totalTextField.enabled = NO;
            taoBaoProductDetailHeaderview.addressTextField.enabled = NO;
            taoBaoProductDetailHeaderview.deleteBtn.hidden = YES;
            
        }else{
            
            taoBaoProductDetailHeaderview.addressTextField.enabled = YES;
            taoBaoProductDetailHeaderview.blockNoLabelTextField.enabled = YES;
            taoBaoProductDetailHeaderview.typeTextField.enabled = YES;
            taoBaoProductDetailHeaderview.widthTextField.enabled = YES;
            taoBaoProductDetailHeaderview.areaTextField.enabled = YES;
            taoBaoProductDetailHeaderview.lenghtTextField.enabled = YES;
            taoBaoProductDetailHeaderview.heightTextField.enabled = YES;
            taoBaoProductDetailHeaderview.totalTextField.enabled = YES;
            taoBaoProductDetailHeaderview.addressTextField.enabled = YES;
            taoBaoProductDetailHeaderview.deleteBtn.hidden = NO;
        }
        return taoBaoProductDetailHeaderview;
        
    }else{
        
        RSTaoBaoProductDetailSLHeaderView  * taoBaoProductDetailHeaderview = [[RSTaoBaoProductDetailSLHeaderView alloc]initWithReuseIdentifier:TAOBAOPRODUCTDETIALHEADERVIEW];
        
        taoBaoProductDetailHeaderview.addressTextField.tag = section;
        taoBaoProductDetailHeaderview.blockNoLabelTextField.tag = section;
        taoBaoProductDetailHeaderview.typeTextField.tag = section;
        taoBaoProductDetailHeaderview.areaTextField.tag = section;
        taoBaoProductDetailHeaderview.totalTextField.tag = section;
        taoBaoProductDetailHeaderview.deleteBtn.tag = section;
        
        
        taoBaoProductDetailHeaderview.addTurnsBtn.tag = section;
        
        
        [taoBaoProductDetailHeaderview.blockNoLabelTextField addTarget:self action:@selector(taoBaoSLProudctContent:) forControlEvents:UIControlEventEditingDidEnd];
        [taoBaoProductDetailHeaderview.typeTextField addTarget:self action:@selector(taoBaoSLProudctContent:) forControlEvents:UIControlEventEditingDidEnd];
        [taoBaoProductDetailHeaderview.addressTextField addTarget:self action:@selector(taoBaoSLProudctContent:) forControlEvents:UIControlEventEditingDidEnd];
        
        
        
        [taoBaoProductDetailHeaderview.areaTextField addTarget:self action:@selector(taoBaoSLProudctContent:) forControlEvents:UIControlEventEditingDidEnd];
        [taoBaoProductDetailHeaderview.totalTextField addTarget:self action:@selector(taoBaoSLProudctContent:) forControlEvents:UIControlEventEditingDidEnd];
       
        
        
        [taoBaoProductDetailHeaderview.deleteBtn addTarget:self action:@selector(taobaoProdctContentSLDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [taoBaoProductDetailHeaderview.addTurnsBtn addTarget:self action:@selector(closeAndOpenCurrentContentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        

        NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[section];
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[0];
        if (taobaoInventoryDetmodel.isOpen) {
            
            [taoBaoProductDetailHeaderview.addTurnsBtn setImage:[UIImage imageNamed:@"向上-(1)-拷贝-4"] forState:UIControlStateNormal];
            
        }else{
            
            [taoBaoProductDetailHeaderview.addTurnsBtn setImage:[UIImage imageNamed:@"向下-(1)-拷贝-4"] forState:UIControlStateNormal];
        }
        
        taoBaoProductDetailHeaderview.blockNoLabelTextField.text = taobaoInventoryDetmodel.blockNo;
        
        taoBaoProductDetailHeaderview.typeTextField.text = taobaoInventoryDetmodel.stoneType;
        
        taoBaoProductDetailHeaderview.totalTextField.text = [NSString stringWithFormat:@"%ld",array.count];
        
        NSString * str = [NSString string];
        str = @"0.000";
        for (int i = 0; i < array.count; i++) {
            RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[i];
           str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoInventoryDetmodel.area floatValue]]];
        }
        taoBaoProductDetailHeaderview.areaTextField.enabled = NO;
        taoBaoProductDetailHeaderview.totalTextField.enabled = NO;
        
        taoBaoProductDetailHeaderview.areaTextField.text = [NSString stringWithFormat:@"%@",str];
        
        taoBaoProductDetailHeaderview.addressTextField.text = taobaoInventoryDetmodel.warehouseName;
        
        if ([self.typeStatus isEqualToString:@"已上架"]) {
            taoBaoProductDetailHeaderview.addressTextField.enabled = NO;
            taoBaoProductDetailHeaderview.blockNoLabelTextField.enabled = NO;
            taoBaoProductDetailHeaderview.typeTextField.enabled = NO;
           
            taoBaoProductDetailHeaderview.addressTextField.enabled = NO;
            taoBaoProductDetailHeaderview.deleteBtn.hidden = YES;
            taoBaoProductDetailHeaderview.addTurnsBtn.hidden = YES;
        }else{
            taoBaoProductDetailHeaderview.addressTextField.enabled = YES;
            taoBaoProductDetailHeaderview.blockNoLabelTextField.enabled = YES;
            taoBaoProductDetailHeaderview.typeTextField.enabled = YES;
            //taoBaoProductDetailHeaderview.areaTextField.enabled = YES;
            //taoBaoProductDetailHeaderview.totalTextField.enabled = YES;
            taoBaoProductDetailHeaderview.addressTextField.enabled = YES;
            taoBaoProductDetailHeaderview.deleteBtn.hidden = NO;
            taoBaoProductDetailHeaderview.addTurnsBtn.hidden = NO;
        }
        return taoBaoProductDetailHeaderview;
    }
}




//荒料
- (void)taoBaoProudctContent:(UITextField *)textfield{
    RSTaoBaoProductDetailHeaderView  * taoBaoProductDetailHeaderview = (RSTaoBaoProductDetailHeaderView *)[self.tableview headerViewForSection:textfield.tag];
    NSString * temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = self.taobaomangementmodel.stoneDtlList[textfield.tag];
    if (taoBaoProductDetailHeaderview.widthTextField == textfield){
        taoBaoProductDetailHeaderview.widthTextField.text = temp;
        taobaoInventoryDetmodel.width =  [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.widthTextField.text];
        if ([taoBaoProductDetailHeaderview.lenghtTextField.text length] > 0 && [taoBaoProductDetailHeaderview.widthTextField.text length] > 0 && [taoBaoProductDetailHeaderview.heightTextField.text length] > 0) {
            //技算原始面积
            taoBaoProductDetailHeaderview.areaTextField.text = [self calculateByMultiplying:taoBaoProductDetailHeaderview.lenghtTextField.text secondNumber:taoBaoProductDetailHeaderview.widthTextField.text thirdNumber:taoBaoProductDetailHeaderview.heightTextField.text];
            taobaoInventoryDetmodel.volume = [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.areaTextField.text];
        }
    }else if (taoBaoProductDetailHeaderview.areaTextField == textfield){
        taoBaoProductDetailHeaderview.areaTextField.text = temp;
        taobaoInventoryDetmodel.volume = [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.areaTextField.text];
    }else if (taoBaoProductDetailHeaderview.lenghtTextField == textfield){
        taoBaoProductDetailHeaderview.lenghtTextField.text = temp;
        taobaoInventoryDetmodel.length = [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.lenghtTextField.text];
        if ([taoBaoProductDetailHeaderview.lenghtTextField.text length] > 0 && [taoBaoProductDetailHeaderview.widthTextField.text length] > 0 && [taoBaoProductDetailHeaderview.heightTextField.text length] > 0) {
            //技算原始面积
            taoBaoProductDetailHeaderview.areaTextField.text = [self calculateByMultiplying:taoBaoProductDetailHeaderview.lenghtTextField.text secondNumber:taoBaoProductDetailHeaderview.widthTextField.text thirdNumber:taoBaoProductDetailHeaderview.heightTextField.text];
            taobaoInventoryDetmodel.volume = [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.areaTextField.text];
        }
    }else if (taoBaoProductDetailHeaderview.heightTextField == textfield){
        taoBaoProductDetailHeaderview.heightTextField.text = temp;
        taobaoInventoryDetmodel.height = [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.heightTextField.text];
        if ([taoBaoProductDetailHeaderview.lenghtTextField.text length] > 0 && [taoBaoProductDetailHeaderview.widthTextField.text length] > 0 && [taoBaoProductDetailHeaderview.heightTextField.text length] > 0) {
            //技算原始面积
            taoBaoProductDetailHeaderview.areaTextField.text = [self calculateByMultiplying:taoBaoProductDetailHeaderview.lenghtTextField.text secondNumber:taoBaoProductDetailHeaderview.widthTextField.text thirdNumber:taoBaoProductDetailHeaderview.heightTextField.text];
            taobaoInventoryDetmodel.volume = [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.areaTextField.text];
        }
    }else if (taoBaoProductDetailHeaderview.totalTextField == textfield){
        taoBaoProductDetailHeaderview.totalTextField.text = temp;
        taobaoInventoryDetmodel.weight = [NSDecimalNumber decimalNumberWithString:taoBaoProductDetailHeaderview.totalTextField.text];
    }
    [self reloadHuanliaoTotalVomlue];
    [self reloadHuanliaoTotalWeight];
}


- (void)taoBaoProudctEndContent:(UITextField *)textfield{
    RSTaoBaoProductDetailHeaderView  * taoBaoProductDetailHeaderview = (RSTaoBaoProductDetailHeaderView *)[self.tableview headerViewForSection:textfield.tag];
    NSString * temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = self.taobaomangementmodel.stoneDtlList[textfield.tag];
    if (taoBaoProductDetailHeaderview.addressTextField == textfield){
        taoBaoProductDetailHeaderview.addressTextField.text = temp;
        taobaoInventoryDetmodel.warehouseName = taoBaoProductDetailHeaderview.addressTextField.text;
    }else if (taoBaoProductDetailHeaderview.blockNoLabelTextField == textfield) {
        taoBaoProductDetailHeaderview.blockNoLabelTextField.text = temp;
        taobaoInventoryDetmodel.blockNo = taoBaoProductDetailHeaderview.blockNoLabelTextField.text;
    }else if (taoBaoProductDetailHeaderview.typeTextField == textfield){
        taoBaoProductDetailHeaderview.typeTextField.text = temp;
        taobaoInventoryDetmodel.stoneType =  taoBaoProductDetailHeaderview.typeTextField.text;
    }
}





- (void)reloadHuanliaoTotalVomlue{
    NSString * str = [NSString string];
    str = @"0.000";
    //这边是对总体积进行计算
    for (int i = 0; i <self.taobaomangementmodel.stoneDtlList.count; i++) {
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = self.taobaomangementmodel.stoneDtlList[i];
        str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoInventoryDetmodel.volume floatValue]]];
    }
    _vomlueTextField.text = str;
}


- (void)reloadHuanliaoTotalWeight{
    NSString * str = [NSString string];
    str = @"0.000";
    //这边是对总体积进行计算
    for (int i = 0; i <self.taobaomangementmodel.stoneDtlList.count; i++) {
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = self.taobaomangementmodel.stoneDtlList[i];
        str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoInventoryDetmodel.weight floatValue]]];
    }
    _weightTextField.text = str;
}












- (void)reloadDabanTotalArea{
    NSString * str = [NSString string];
    str = @"0.000";
    //这边是对总体积进行计算
    for (int i = 0; i <self.taobaomangementmodel.stoneDtlList.count; i++) {
        NSArray * array = self.taobaomangementmodel.stoneDtlList[i];
        for (int j = 0; j < array.count; j++) {
           RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[j]
            ;
           str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoInventoryDetmodel.area floatValue]]];
        }
    }
    _vomlueTextField.text = str;
}


//荒料头部删除
- (void)taobaoProdctContentDeleteAction:(UIButton *)deleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料吗?" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              [self.taobaomangementmodel.stoneDtlList removeObjectAtIndex:deleteBtn.tag];
                 [self reloadHuanliaoTotalVomlue];
                [self reloadHuanliaoTotalWeight];
                 [self.tableview reloadData];
         }];
         [alertView addAction:alert];
         UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         }];
         [alertView addAction:alert1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
           
           alertView.modalPresentationStyle = UIModalPresentationFullScreen;
       }
         [self presentViewController:alertView animated:YES completion:nil];
   
   
}



//添加
- (void)addAction:(UIButton *)addBtn{
    if ([self.type isEqualToString:@"荒料"]) {
        /**
         Id标识    id    Int    修改明细传正确id  如是新增的明细则不传或者传0
         石种类型    stoneType    String
         荒料号    blockNo    String
         匝号    turnNo    String    如是荒料传“”字符串即可
         片数    turnQty    Int    荒料传1
         长    length    Decimal    1位
         宽    width    Decimal    1位
         高    height    Decimal    2位
         体积    volume    Decimal    3位 大板传 0
         重量    weight    Decimal    3位 大板传0
         原始面积    preArea    Decimal    3位 荒料传0
         扣尺面积    dedArea    Decimal    3位 荒料传0
         实际面积    area    Decimal    3位 荒料传0
         */
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = [[RSTaobaoInventoryDetModel alloc]init];
        taobaoInventoryDetmodel.InventoryDetID = 0;
        taobaoInventoryDetmodel.stoneType = @"";
        taobaoInventoryDetmodel.warehouseName = @"";
        taobaoInventoryDetmodel.blockNo = @"";
        taobaoInventoryDetmodel.turnNo = @"";
        taobaoInventoryDetmodel.turnQty = 1;
        taobaoInventoryDetmodel.inventoryId = 0;
        taobaoInventoryDetmodel.length =  [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.width = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.height = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.volume = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.weight = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.preArea = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.dedArea = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.area = [NSDecimalNumber decimalNumberWithString:@"0"];
        
        
        NSMutableArray  * array = [NSMutableArray array];
        for (int i = 0; i < self.taobaomangementmodel.stoneDtlList.count; i++) {
            RSTaobaoInventoryDetModel * taobaoInventoryDetmodel1 =  self.taobaomangementmodel.stoneDtlList[i];
            [array addObject:taobaoInventoryDetmodel1];
        }
        [array addObject:taobaoInventoryDetmodel];
        self.taobaomangementmodel.stoneDtlList = array;
        
        [self.tableview reloadData];
        [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:self.taobaomangementmodel.stoneDtlList.count - 1] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        
    }else{
        
        
        NSMutableArray  * array = [NSMutableArray array];
        for (int i = 0; i < self.taobaomangementmodel.stoneDtlList.count; i++) {
            NSMutableArray * tempArray =  self.taobaomangementmodel.stoneDtlList[i];
            for (int j = 0; j < tempArray.count; j++) {
                RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = tempArray[j];
                [array addObject:taobaoInventoryDetmodel];
            }
        }
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = [[RSTaobaoInventoryDetModel alloc]init];
        taobaoInventoryDetmodel.InventoryDetID = 0;
        taobaoInventoryDetmodel.stoneType = @"";
        taobaoInventoryDetmodel.warehouseName = @"";
        taobaoInventoryDetmodel.blockNo = @"";
        taobaoInventoryDetmodel.turnNo = @"";
        taobaoInventoryDetmodel.turnQty = 1;
        taobaoInventoryDetmodel.inventoryId = 0;
        taobaoInventoryDetmodel.isOpen = false;
        taobaoInventoryDetmodel.length =  [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.width = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.height = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.volume = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.weight = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.preArea = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.dedArea = [NSDecimalNumber decimalNumberWithString:@"0"];
        taobaoInventoryDetmodel.area = [NSDecimalNumber decimalNumberWithString:@"0"];
        [array addObject:taobaoInventoryDetmodel];
        
        self.taobaomangementmodel.stoneDtlList = [self changeArrayRule:array];
        [self.tableview reloadData];
        
        [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:self.taobaomangementmodel.stoneDtlList.count - 1] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}






//大板
- (void)taoBaoSLProudctContent:(UITextField *)textfield{
    RSTaoBaoProductDetailSLHeaderView  * taoBaoProductDetailSLHeaderview = (RSTaoBaoProductDetailSLHeaderView *)[self.tableview headerViewForSection:textfield.tag];
    NSString * temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[textfield.tag];
    for (int i = 0; i < array.count; i++) {
          RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[i];
         if ([temp length] > 0) {
                if (taoBaoProductDetailSLHeaderview.blockNoLabelTextField == textfield) {
                    taoBaoProductDetailSLHeaderview.blockNoLabelTextField.text = temp;
                    for (int i = 0; i < array.count; i++) {
                        taobaoInventoryDetmodel.blockNo = taoBaoProductDetailSLHeaderview.blockNoLabelTextField.text;
                    }
                }else if (taoBaoProductDetailSLHeaderview.typeTextField == textfield){
                    taoBaoProductDetailSLHeaderview.typeTextField.text = temp;
                    for (int i = 0; i < array.count; i++) {
                        taobaoInventoryDetmodel.stoneType = taoBaoProductDetailSLHeaderview.typeTextField.text;
                    }
                }
                else if (taoBaoProductDetailSLHeaderview.addressTextField == textfield){
                    taoBaoProductDetailSLHeaderview.addressTextField.text = temp;
                    for (int i = 0; i < array.count; i++) {
                        taobaoInventoryDetmodel.warehouseName = taoBaoProductDetailSLHeaderview.addressTextField.text;
                    }
                }
            }
    }
}




//大板Cell的内容
- (void)taoBaoProdctCellContent:(UITextField *)textfield{
    UIView *v = [textfield superview];
    UIView *v1 = [v superview];
    UIView * v2 = [v1 superview];
    RSTaoBaoProductDetialCell *cell = (RSTaoBaoProductDetialCell *)[v2 superview];
    NSIndexPath *indexPathAll = [self.tableview indexPathForCell:cell];
    NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[indexPathAll.section];
    RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[textfield.tag];
    NSString * temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        if (cell.turnNoTextField == textfield) {
            //匝号
            cell.turnNoTextField.text = temp;
            taobaoInventoryDetmodel.turnNo = cell.turnNoTextField.text;
        }else if (cell.numberTextField == textfield){
            //片数
            cell.numberTextField.text = temp;
            taobaoInventoryDetmodel.turnQty = [cell.numberTextField.text integerValue];
            if ([cell.lenghtTextField.text length] > 0 && [cell.widthTextField.text length] > 0) {
                //技算原始面积
                cell.primitiveAreaTextField.text = [self calculateByMultiplying:cell.lenghtTextField.text secondNumber:cell.widthTextField.text andNumber:cell.numberTextField.text];
                
                //这边还要乘与片数
                taobaoInventoryDetmodel.preArea =[NSDecimalNumber decimalNumberWithString:cell.primitiveAreaTextField.text];
            }
            
            if ([cell.primitiveAreaTextField.text length] > 0 && [cell.buckleAreaTextField.text length] > 0) {
                cell.actualAreaTextField.text = [self calculateDecimalByMultiplying:cell.primitiveAreaTextField.text secondNumber:cell.buckleAreaTextField.text];
                taobaoInventoryDetmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaTextField.text];
                if ([cell.actualAreaTextField.text containsString:@"-"]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                    
                }
            }
            
        }else if (cell.lenghtTextField == textfield){
            cell.lenghtTextField.text = temp;
            
            taobaoInventoryDetmodel.length = [NSDecimalNumber decimalNumberWithString:cell.lenghtTextField.text];
            //长
            if ([cell.lenghtTextField.text length] > 0 && [cell.widthTextField.text length] > 0) {
                //技算原始面积
                cell.primitiveAreaTextField.text = [self calculateByMultiplying:cell.lenghtTextField.text secondNumber:cell.widthTextField.text andNumber:cell.numberTextField.text];
                
                //这边还要乘与片数
                taobaoInventoryDetmodel.preArea =[NSDecimalNumber decimalNumberWithString:cell.primitiveAreaTextField.text];
            }
            
            if ([cell.primitiveAreaTextField.text length] > 0 && [cell.buckleAreaTextField.text length] > 0) {
                cell.actualAreaTextField.text = [self calculateDecimalByMultiplying:cell.primitiveAreaTextField.text secondNumber:cell.buckleAreaTextField.text];
                taobaoInventoryDetmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaTextField.text];
                if ([cell.actualAreaTextField.text containsString:@"-"]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                           
                                           alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                       }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }
            }
            
            
        }
        else if (cell.widthTextField == textfield){
            //宽
            cell.widthTextField.text = temp;
            
            taobaoInventoryDetmodel.width = [NSDecimalNumber decimalNumberWithString:cell.widthTextField.text];
            //长
            if ([cell.lenghtTextField.text length] > 0 && [cell.widthTextField.text length] > 0) {
                //技算原始面积
                cell.primitiveAreaTextField.text = [self calculateByMultiplying:cell.lenghtTextField.text secondNumber:cell.widthTextField.text andNumber:cell.numberTextField.text];
                
                //这边还要乘与片数
                
                
                
                taobaoInventoryDetmodel.preArea =[NSDecimalNumber decimalNumberWithString:cell.primitiveAreaTextField.text];
            }
            
            if ([cell.primitiveAreaTextField.text length] > 0 && [cell.buckleAreaTextField.text length] > 0) {
                cell.actualAreaTextField.text = [self calculateDecimalByMultiplying:cell.primitiveAreaTextField.text secondNumber:cell.buckleAreaTextField.text];
                taobaoInventoryDetmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaTextField.text];
                if ([cell.actualAreaTextField.text containsString:@"-"]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                           
                                           alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                       }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }
            }
            
        }else if (cell.heightTextField == textfield){
            //厚
            
            cell.heightTextField.text = temp;
            taobaoInventoryDetmodel.height = [NSDecimalNumber decimalNumberWithString:cell.heightTextField.text];
            
            
            
        }else if (cell.primitiveAreaTextField == textfield){
            //原始面积
            cell.primitiveAreaTextField.text = temp;
            
            taobaoInventoryDetmodel.preArea = [NSDecimalNumber decimalNumberWithString:cell.primitiveAreaTextField.text];
            
            if ([cell.primitiveAreaTextField.text length] > 0 && [cell.buckleAreaTextField.text length] > 0) {
                cell.actualAreaTextField.text = [self calculateDecimalByMultiplying:cell.primitiveAreaTextField.text secondNumber:cell.buckleAreaTextField.text];
                taobaoInventoryDetmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaTextField.text];
                if ([cell.actualAreaTextField.text containsString:@"-"]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                           
                                           alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                       }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }
            }
            
        }else if (cell.buckleAreaTextField == textfield){
            //扣尺面积
            cell.buckleAreaTextField.text = temp;
            taobaoInventoryDetmodel.dedArea = [NSDecimalNumber decimalNumberWithString:cell.buckleAreaTextField.text];
            if ([cell.primitiveAreaTextField.text length] > 0 && [cell.buckleAreaTextField.text length] > 0) {
                cell.actualAreaTextField.text = [self calculateDecimalByMultiplying:cell.primitiveAreaTextField.text secondNumber:cell.buckleAreaTextField.text];
                taobaoInventoryDetmodel.area =[NSDecimalNumber decimalNumberWithString:cell.actualAreaTextField.text];
                if ([cell.actualAreaTextField.text containsString:@"-"]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"通过计算，你的实际面积会变成负值,请自动修改实际面积的值" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                           
                                           alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                       }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }
            }
        }else if (cell.actualAreaTextField == textfield){
            //实际面积
            cell.actualAreaTextField.text = temp;
            taobaoInventoryDetmodel.area = [NSDecimalNumber decimalNumberWithString:cell.actualAreaTextField.text];
        }
    }
    
    RSTaoBaoProductDetailSLHeaderView  * taoBaoProductDetailHeaderview = (RSTaoBaoProductDetailSLHeaderView *)[self.tableview headerViewForSection:indexPathAll.section];
    //变化匝数
    taoBaoProductDetailHeaderview.totalTextField.text = [NSString stringWithFormat:@"%ld",array.count];
    //变化总面积
    NSString * str = [NSString string];
    str = @"0.000";
    for (int i = 0; i < array.count; i++) {
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[i];
        
        str = [self calculateNumberByAdding:str secondNumber:[NSString stringWithFormat:@"%lf",[taobaoInventoryDetmodel.area floatValue]]];
    }
    taoBaoProductDetailHeaderview.areaTextField.text = [NSString stringWithFormat:@"%@",str];
    
    
    [self reloadDabanTotalArea];
    
    //    [self changDabanHeaderAreaValue:textfield];
    
    
    
}




//- (void)changDabanHeaderAreaValue:(UITextField *)textfield{
//
//
//
//
//
//}


//添加匝(大板尾部视图)
- (void)addTurnAction:(UIButton *)addTurnBtn{
    NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[addTurnBtn.tag];
    RSTaobaoInventoryDetModel * taobaoInventoryDetmodel1 = array[0];
    RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = [[RSTaobaoInventoryDetModel alloc]init];
    taobaoInventoryDetmodel.InventoryDetID = 0;
    taobaoInventoryDetmodel.stoneType = taobaoInventoryDetmodel1.stoneType;
    taobaoInventoryDetmodel.warehouseName = taobaoInventoryDetmodel1.warehouseName;
    taobaoInventoryDetmodel.blockNo = taobaoInventoryDetmodel1.blockNo;
    taobaoInventoryDetmodel.turnNo = taobaoInventoryDetmodel1.turnNo;
    taobaoInventoryDetmodel.isOpen = taobaoInventoryDetmodel1.isOpen;
    taobaoInventoryDetmodel.turnQty = 1;
    taobaoInventoryDetmodel.inventoryId = 0;
    taobaoInventoryDetmodel.length =  [NSDecimalNumber decimalNumberWithString:@"0"];
    taobaoInventoryDetmodel.width = [NSDecimalNumber decimalNumberWithString:@"0"];
    taobaoInventoryDetmodel.height = [NSDecimalNumber decimalNumberWithString:@"0"];
    taobaoInventoryDetmodel.volume = [NSDecimalNumber decimalNumberWithString:@"0"];
    taobaoInventoryDetmodel.weight = [NSDecimalNumber decimalNumberWithString:@"0"];
    taobaoInventoryDetmodel.preArea = [NSDecimalNumber decimalNumberWithString:@"0"];
    taobaoInventoryDetmodel.dedArea = [NSDecimalNumber decimalNumberWithString:@"0"];
    taobaoInventoryDetmodel.area = [NSDecimalNumber decimalNumberWithString:@"0"];
    [array addObject:taobaoInventoryDetmodel];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:addTurnBtn.tag] withRowAnimation:UITableViewRowAnimationNone];
}


//大板头部删除按键
- (void)taobaoProdctContentSLDeleteAction:(UIButton *)deleteBtn{
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.taobaomangementmodel.stoneDtlList removeObjectAtIndex:deleteBtn.tag];
        [self reloadDabanTotalArea];
        [self.tableview reloadData];
        
    }];
    [alertView addAction:alert];
    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:alert1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alertView animated:YES completion:nil];
    
}


//大板头部展开或者关闭的匝信息
- (void)closeAndOpenCurrentContentAction:(UIButton *)addTurnsBtn{
    NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[addTurnsBtn.tag];
    addTurnsBtn.selected = !addTurnsBtn.selected;
    for (int i = 0 ; i < array.count; i++) {
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[i];
        taobaoInventoryDetmodel.isOpen = !taobaoInventoryDetmodel.isOpen;
    }
    [self.tableview reloadData];
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:addTurnsBtn.tag] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}


//大板cell里面的删除按键
- (void)deleteCellContentAction:(UIButton *)deleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料吗?" preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           UIView *v = [deleteBtn superview];//获取父类view
              UIView *v1 = [v superview];
              UIView * v2 = [v1 superview];
              RSTaoBaoProductDetialCell *cell = (RSTaoBaoProductDetialCell *)[v2 superview];//获取cell
              NSIndexPath *indexPathAll = [self.tableview indexPathForCell:cell];//获取cell对应的section
              NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[indexPathAll.section];
              if (array.count <= 1) {
                  [self.taobaomangementmodel.stoneDtlList removeObjectAtIndex:indexPathAll.section];
                  [self.tableview reloadData];
              }else{
                 [array removeObjectAtIndex:deleteBtn.tag];
                 [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:indexPathAll.section] withRowAnimation:UITableViewRowAnimationNone];
              }
              [self reloadDabanTotalArea];
      }];
      [alertView addAction:alert];
      UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      }];
      [alertView addAction:alert1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
    }
      [self presentViewController:alertView animated:YES completion:nil];
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.type isEqualToString:@"荒料"]) {
        return 10;
    }else{
        if ([self.typeStatus isEqualToString:@"已上架"]) {
            return 10;
        }else{
            return 50;
        }
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString * TAOBAOPRODUCTDETIALFOOTVIEW = @"TAOBAOPRODUCTDETIALFOOTVIEW";
    RSTaoBaoProductDetailFootView * taobaoProductDetailFootview = [[RSTaoBaoProductDetailFootView alloc]initWithReuseIdentifier:TAOBAOPRODUCTDETIALFOOTVIEW];
    if ([self.type isEqualToString:@"荒料"]) {
        CGRect rect6 = CGRectMake(0, 0, SCW - 24,10);
        CGRect oldRect2 = rect6;
        oldRect2.size.width = SCW - 24;
        UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect2 byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
        maskLayer2.path = maskPath2.CGPath;
        maskLayer2.frame = oldRect2;
        taobaoProductDetailFootview.backView.layer.mask = maskLayer2;
        taobaoProductDetailFootview.addTurnsBtn.hidden = YES;
    }else{
        taobaoProductDetailFootview.addTurnsBtn.tag = section;
        CGRect rect6 = CGRectMake(0, 0, SCW - 24,10);
        if ([self.typeStatus isEqualToString:@"已上架"]) {
            rect6 = CGRectMake(0, 0, SCW - 24,10);
        }else{
            rect6 = CGRectMake(0, 0, SCW - 24,50);
        }
        CGRect oldRect2 = rect6;
        oldRect2.size.width = SCW - 24;
        UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect2 byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
        maskLayer2.path = maskPath2.CGPath;
        maskLayer2.frame = oldRect2;
        taobaoProductDetailFootview.backView.layer.mask = maskLayer2;
         if ([self.typeStatus isEqualToString:@"已上架"]) {
             taobaoProductDetailFootview.addTurnsBtn.hidden = YES;
         }else{
             taobaoProductDetailFootview.addTurnsBtn.hidden = NO;
         }
        [taobaoProductDetailFootview.addTurnsBtn addTarget:self action:@selector(addTurnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return taobaoProductDetailFootview;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TAOBAOPRODUCTDETIALCELLID = @"TAOBAOPRODUCTDETIALCELLID";
    RSTaoBaoProductDetialCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOPRODUCTDETIALCELLID];
    if (!cell) {
        cell = [[RSTaoBaoProductDetialCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOPRODUCTDETIALCELLID];
    }
    cell.tag = indexPath.section;
    cell.turnNoTextField.tag = indexPath.row;
    cell.numberTextField.tag = indexPath.row;
    cell.lenghtTextField.tag = indexPath.row;
    cell.widthTextField.tag = indexPath.row;
    cell.heightTextField.tag = indexPath.row;
    cell.primitiveAreaTextField.tag = indexPath.row;
    cell.buckleAreaTextField.tag = indexPath.row;
    cell.actualAreaTextField.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    
    NSMutableArray * array = self.taobaomangementmodel.stoneDtlList[indexPath.section];
    RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[indexPath.row];
    
    [cell.deleteBtn addTarget:self action:@selector(deleteCellContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.turnNoTextField.text = taobaoInventoryDetmodel.turnNo;
    cell.numberTextField.text = [NSString stringWithFormat:@"%ld",taobaoInventoryDetmodel.turnQty];
    cell.lenghtTextField.text = [NSString stringWithFormat:@"%0.1lf",[taobaoInventoryDetmodel.length floatValue]];
    
    
    cell.widthTextField.text = [NSString stringWithFormat:@"%0.1lf",[taobaoInventoryDetmodel.width floatValue]];
    cell.heightTextField.text = [NSString stringWithFormat:@"%0.2lf",[taobaoInventoryDetmodel.height floatValue]];
    cell.primitiveAreaTextField.text = [NSString stringWithFormat:@"%0.3lf",[taobaoInventoryDetmodel.preArea floatValue]];
    cell.buckleAreaTextField.text = [NSString stringWithFormat:@"%0.3lf",[taobaoInventoryDetmodel.dedArea floatValue]];
    cell.actualAreaTextField.text = [NSString stringWithFormat:@"%0.3lf",[taobaoInventoryDetmodel.area floatValue]];
    
    
    [cell.turnNoTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    [cell.numberTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    [cell.lenghtTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    [cell.widthTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    [cell.heightTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    [cell.primitiveAreaTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    [cell.buckleAreaTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    [cell.actualAreaTextField addTarget:self action:@selector(taoBaoProdctCellContent:) forControlEvents:UIControlEventEditingChanged];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_priceTextField == textField) {
        if ([_priceTextField.text isEqualToString:@"0.000"] || [_priceTextField.text isEqualToString:@"0.00"] || [_priceTextField.text isEqualToString:@"0.0"] || [_priceTextField.text isEqualToString:@"0"]) {
            _priceTextField.text = @"";
        }
    }else if (_originalpriceTextField == textField){
        if ([_originalpriceTextField.text isEqualToString:@"0.000"] || [_originalpriceTextField.text isEqualToString:@"0.00"] || [_originalpriceTextField.text isEqualToString:@"0.0"] || [_originalpriceTextField.text isEqualToString:@"0"]) {
            _originalpriceTextField.text = @"";
        }
    }else if (_vomlueTextField == textField){
        if ([_vomlueTextField.text isEqualToString:@"0.000"] || [_vomlueTextField.text isEqualToString:@"0.00"] || [_vomlueTextField.text isEqualToString:@"0.0"] || [_vomlueTextField.text isEqualToString:@"0"]) {
                  _vomlueTextField.text = @"";
        }
    }else if (_weightTextField == textField){
        if ([_weightTextField.text isEqualToString:@"0.000"] || [_weightTextField.text isEqualToString:@"0.00"] || [_weightTextField.text isEqualToString:@"0.0"] || [_weightTextField.text isEqualToString:@"0"]) {
                  _weightTextField.text = @"";
        }
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        if (_nameTextField == textField) {
            _nameTextField.text = temp;
            self.taobaomangementmodel.stoneName = _nameTextField.text;
            
        }else if (_priceTextField == textField){
            _priceTextField.text = temp;
            self.taobaomangementmodel.price = [NSDecimalNumber decimalNumberWithString:_priceTextField.text];
        }else if (_vomlueTextField == textField){
            _vomlueTextField.text = temp;
             self.taobaomangementmodel.inventory = [NSDecimalNumber decimalNumberWithString:_vomlueTextField.text];
        }else if (_originalpriceTextField == textField){
            
            _originalpriceTextField.text = temp;
            self.taobaomangementmodel.originalPrice = [NSDecimalNumber decimalNumberWithString:_originalpriceTextField.text];
        } else if (_weightTextField == textField){
            _weightTextField.text = temp;
            self.taobaomangementmodel.weight = [NSDecimalNumber decimalNumberWithString:_weightTextField.text];
        }
    }else{
        if (_nameTextField == textField) {
            _nameTextField.text = @"";
        }else if (_priceTextField == textField){
            _priceTextField.text = @"";
        }else if (_vomlueTextField == textField){
            _vomlueTextField.text = @"";
        }else if (_originalpriceTextField == textField){
            _originalpriceTextField.text = @"";
        }else if (_weightTextField == textField){
            _weightTextField.text = @"";
        }
    }
}


- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}





-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if (textField == _priceTextField ||  textField == _originalpriceTextField) {
        //    限制只能输入数字
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];
            if ((single >= '0' && single <= '9') || single == '.') {
                if([textField.text length] == 0){
                    if(single == '.') {
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                
                if (single == '.') {
                    if(!isHaveDian)
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {
                        
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else if (textField == _vomlueTextField){
        
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                if([textField.text length] == 0){
                    if(single == '.') {
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                
                if (single == '.') {
                    if(!isHaveDian)
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {
                        
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 3) {
                            return YES;
                        }else{
                            
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else{
        return YES;
    }
}


//长和宽相乘 并转化
-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2
{
    
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    // NSDecimalNumber * newNum = [multiplyingNum decimalNumberByMultiplyingBy:num3];
    NSDecimalNumber *num4 = [NSDecimalNumber decimalNumberWithString:@"10000"];
    //NSDecimalNumber * dividingNum = [newNum decimalNumberByDividingBy:num4];
    NSDecimalNumber * dividingNum =[multiplyingNum decimalNumberByDividingBy:num4 withBehavior:Handler];
    return [dividingNum stringValue];
}

//长和宽在乘与片数并转换

-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2 andNumber:(NSString *)number
{
    
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    NSDecimalNumber * qty = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber * newNum = [multiplyingNum decimalNumberByMultiplyingBy:qty];
    NSDecimalNumber *num4 = [NSDecimalNumber decimalNumberWithString:@"10000"];
    //NSDecimalNumber * dividingNum = [newNum decimalNumberByDividingBy:num4];
    NSDecimalNumber * dividingNum =[newNum decimalNumberByDividingBy:num4 withBehavior:Handler];
    return [dividingNum stringValue];
}








//长和宽和高相乘为体积 并转化
-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2 thirdNumber:(NSString *)number3
{
    
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    NSDecimalNumber *num3 = [NSDecimalNumber decimalNumberWithString:number3];
    NSDecimalNumber * newNum = [multiplyingNum decimalNumberByMultiplyingBy:num3];
    NSDecimalNumber *num4 = [NSDecimalNumber decimalNumberWithString:@"1000000"];
    //NSDecimalNumber * dividingNum = [newNum decimalNumberByDividingBy:num4];
    NSDecimalNumber * dividingNum =[newNum decimalNumberByDividingBy:num4 withBehavior:Handler];
    return [dividingNum stringValue];
}


//减
-(NSString *)calculateDecimalByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2{
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber * multiplyingNum = [num1 decimalNumberBySubtracting:num2 withBehavior:Handler];
    return [multiplyingNum stringValue];
}


//相加
- (NSString *)calculateNumberByAdding:(NSString *)number1 secondNumber:(NSString *)number2{
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber * addNum = [num1 decimalNumberByAdding:num2 withBehavior:Handler];
    return [addNum stringValue];
}





//下架和上架
- (void)onShelfAction:(UIButton *)onShelfBtn{
    if ([onShelfBtn.currentTitle isEqualToString:@"下架"]) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        //URL_TAOBAOGETINVENTORYLIST_IOS
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        NSMutableArray * array = [NSMutableArray array];
        [array addObject:[NSNumber numberWithInteger:self.taobaomangementmodel.mangementID]];
        [phoneDict setObject:array forKey:@"ids"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"status"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_TAOBAOUPDATEINVENTORYST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    _cancelBtn.hidden = NO;
                    _onShelfBtn.hidden = NO;
                    [_onShelfBtn setTitle:@"上架" forState:UIControlStateNormal];
                    _saveBtn.hidden = NO;
                    _addBtn.hidden = NO;
                    _originalpriceTextField.enabled = YES;
                    _nameTextField.enabled = YES;
                    _priceTextField.enabled = YES;
                    _vomlueTextField.enabled = YES;
                    _albumBtn.enabled = YES;
                    
                    weakSelf.typeStatus = @"下架";
                    [weakSelf.tableview reloadData];
                    NSDictionary * dict = @{@"Type":self.type};
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveAndUpdate" object:dict];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"下架失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"下架失败"];
            }
        }];
    }else{
        //上架
        [self saveAndUpdateNewDataType:@"上架"];
    }
}


//取消
- (void)cancelAction:(UIButton *)cancelBtn{
    //未完成上个页面要进行重新请求
    NSDictionary * dict = @{@"Type":self.type};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveAndUpdate" object:dict];
    [self.navigationController popViewControllerAnimated:YES];
}


//保存
- (void)saveAction:(UIButton *)saveBtn{
    [self saveAndUpdateNewDataType:@"保存"];
}









//type 是值的是保存还是上架
- (void)saveAndUpdateNewDataType:(NSString *)type{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    //判断是上架还是保存
    if ([type isEqualToString:@"上架"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"status"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"status"];
    }
    if ([self.type isEqualToString:@"荒料"]) {
        [phoneDict setObject:@"huangliao" forKey:@"stockType"];
    }else{
        [phoneDict setObject:@"daban" forKey:@"stockType"];
    }
    [phoneDict setObject:[NSNumber numberWithInteger:self.taobaomangementmodel.mangementID] forKey:@"id"];
    [phoneDict setObject:_vomlueTextField.text forKey:@"inventory"];
    [phoneDict setObject:self.taobaomangementmodel.originalPrice forKey:@"originalPrice"];
    [phoneDict setObject:self.taobaomangementmodel.price forKey:@"price"];
    [phoneDict setObject:self.taobaomangementmodel.stoneName forKey:@"stoneName"];
    [phoneDict setObject:self.taobaomangementmodel.stockType forKey:@"stockType"];
    [phoneDict setObject:self.taobaomangementmodel.identityId forKey:@"identityId"];
    [phoneDict setObject:_weightTextField.text forKey:@"weight"];
    if ([self.type isEqualToString:@"荒料"]) {
        if ([_priceLabel.text isEqualToString:@"价格/m³"] && [_originalpriceLabel.text isEqualToString:@"原价格/m³"]) {
             [phoneDict setObject:@"立方米" forKey:@"unit"];
        }else{
             [phoneDict setObject:@"吨" forKey:@"unit"];
        }
    }else{
        [phoneDict setObject:@"平方米" forKey:@"unit"];
    }
    NSMutableArray * stoneDtlListArray = [NSMutableArray array];
    if ([self.type isEqualToString:@"荒料"]) {
        for (int i = 0; i < self.taobaomangementmodel.stoneDtlList.count; i++) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = self.taobaomangementmodel.stoneDtlList[i];
            [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.InventoryDetID] forKey:@"id"];
            [dict setObject:taobaoInventoryDetmodel.stoneType forKey:@"stoneType"];
            [dict setObject:taobaoInventoryDetmodel.blockNo forKey:@"blockNo"];
            [dict setObject:taobaoInventoryDetmodel.turnNo forKey:@"turnNo"];
            [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.turnQty] forKey:@"turnQty"];
            [dict setObject:taobaoInventoryDetmodel.length forKey:@"length"];
            [dict setObject:taobaoInventoryDetmodel.width forKey:@"width"];
            [dict setObject:taobaoInventoryDetmodel.height forKey:@"height"];
            [dict setObject:taobaoInventoryDetmodel.volume forKey:@"volume"];
            [dict setObject:taobaoInventoryDetmodel.weight forKey:@"weight"];
            [dict setObject:taobaoInventoryDetmodel.preArea forKey:@"preArea"];
            [dict setObject:taobaoInventoryDetmodel.dedArea forKey:@"dedArea"];
            [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.inventoryId] forKey:@"inventoryId"];
            [dict setObject:taobaoInventoryDetmodel.warehouseName forKey:@"warehouseName"];
            [dict setObject:taobaoInventoryDetmodel.area forKey:@"area"];
            [dict setObject:taobaoInventoryDetmodel.turnNo forKey:@"turnNo"];
            [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.turnQty] forKey:@"turnQty"];
            [dict setObject:taobaoInventoryDetmodel.preArea forKey:@"preArea"];
            [dict setObject:taobaoInventoryDetmodel.dedArea forKey:@"dedArea"];
            [stoneDtlListArray addObject:dict];
        }
    }else{
        for (int i = 0; i < self.taobaomangementmodel.stoneDtlList.count; i++) {
            NSMutableArray * tempArray =  self.taobaomangementmodel.stoneDtlList[i];
            for (int j = 0; j < tempArray.count; j++) {
                RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = tempArray[j];
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.InventoryDetID] forKey:@"id"];
                [dict setObject:taobaoInventoryDetmodel.stoneType forKey:@"stoneType"];
                [dict setObject:taobaoInventoryDetmodel.blockNo forKey:@"blockNo"];
                [dict setObject:taobaoInventoryDetmodel.turnNo forKey:@"turnNo"];
                [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.turnQty] forKey:@"turnQty"];
                [dict setObject:taobaoInventoryDetmodel.length forKey:@"length"];
                [dict setObject:taobaoInventoryDetmodel.width forKey:@"width"];
                [dict setObject:taobaoInventoryDetmodel.height forKey:@"height"];
                [dict setObject:taobaoInventoryDetmodel.volume forKey:@"volume"];
                [dict setObject:taobaoInventoryDetmodel.weight forKey:@"weight"];
                [dict setObject:taobaoInventoryDetmodel.preArea forKey:@"preArea"];
                [dict setObject:taobaoInventoryDetmodel.dedArea forKey:@"dedArea"];
                [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.inventoryId] forKey:@"inventoryId"];
                [dict setObject:taobaoInventoryDetmodel.warehouseName forKey:@"warehouseName"];
                [dict setObject:taobaoInventoryDetmodel.area forKey:@"area"];
                [dict setObject:taobaoInventoryDetmodel.turnNo forKey:@"turnNo"];
                [dict setObject:[NSNumber numberWithInteger:taobaoInventoryDetmodel.turnQty] forKey:@"turnQty"];
                [dict setObject:taobaoInventoryDetmodel.preArea forKey:@"preArea"];
                [dict setObject:taobaoInventoryDetmodel.dedArea forKey:@"dedArea"];
                [stoneDtlListArray addObject:dict];
            }
        }
    }
    [phoneDict setObject:stoneDtlListArray forKey:@"stoneDtlList"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_TAOBAOUPDATEINVENTORY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            [weakSelf.taobaomangementmodel.stoneDtlList removeAllObjects];
            if (isresult) {
                
                weakSelf.taobaomangementmodel.mangementID = [json[@"data"][@"id"] integerValue];
                weakSelf.taobaomangementmodel.inventory = json[@"data"][@"inventory"];
                weakSelf.taobaomangementmodel.isComplete = [json[@"data"][@"isComplete"] integerValue];
                weakSelf.taobaomangementmodel.originalPrice = json[@"data"][@"originalPrice"];
                weakSelf.taobaomangementmodel.price = json[@"data"][@"price"];
                weakSelf.taobaomangementmodel.status = [json[@"data"][@"status"] integerValue];
                weakSelf.taobaomangementmodel.stockType = json[@"data"][@"stockType"];
                weakSelf.taobaomangementmodel.stoneName = json[@"data"][@"stoneName"];
                weakSelf.taobaomangementmodel.unit = json[@"data"][@"unit"];
                weakSelf.taobaomangementmodel.weight = json[@"data"][@"weight"];
                
                NSMutableArray *  stoneList = [NSMutableArray array];
                stoneList = json[@"data"][@"stoneDtlList"];
                if ([self.type isEqualToString:@"荒料"]) {
                        for (int n = 0; n < stoneList.count; n++) {
                            RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = [[RSTaobaoInventoryDetModel alloc]init];
                            taobaoInventoryDetmodel.InventoryDetID = [[[stoneList objectAtIndex:n]objectForKey:@"id"]integerValue];
                            taobaoInventoryDetmodel.stoneType = [[stoneList objectAtIndex:n]objectForKey:@"stoneType"];
                            taobaoInventoryDetmodel.warehouseName = [[stoneList objectAtIndex:n]objectForKey:@"warehouseName"];
                            taobaoInventoryDetmodel.blockNo = [[stoneList objectAtIndex:n]objectForKey:@"blockNo"];
                            taobaoInventoryDetmodel.turnNo = [[stoneList objectAtIndex:n]objectForKey:@"turnNo"];
                            taobaoInventoryDetmodel.turnQty = [[[stoneList objectAtIndex:n]objectForKey:@"turnQty"]integerValue];
                            taobaoInventoryDetmodel.length =  [[stoneList objectAtIndex:n]objectForKey:@"length"];
                            taobaoInventoryDetmodel.width = [[stoneList objectAtIndex:n]objectForKey:@"width"];
                            taobaoInventoryDetmodel.height = [[stoneList objectAtIndex:n]objectForKey:@"height"];
                            taobaoInventoryDetmodel.volume = [[stoneList objectAtIndex:n]objectForKey:@"volume"];
                            taobaoInventoryDetmodel.weight = [[stoneList objectAtIndex:n]objectForKey:@"weight"];
                            taobaoInventoryDetmodel.preArea = [[stoneList objectAtIndex:n]objectForKey:@"preArea"];
                            taobaoInventoryDetmodel.dedArea = [[stoneList objectAtIndex:n]objectForKey:@"dedArea"];
                            taobaoInventoryDetmodel.inventoryId = [[[stoneList objectAtIndex:n]objectForKey:@"inventoryId"]integerValue];
                            taobaoInventoryDetmodel.area = [[stoneList objectAtIndex:n]objectForKey:@"area"];
                            [weakSelf.taobaomangementmodel.stoneDtlList addObject:taobaoInventoryDetmodel];
                        }
                    [weakSelf reloadHuanliaoTotalVomlue];
                    [weakSelf reloadHuanliaoTotalWeight];
                }else{
                    NSMutableArray * temp = [NSMutableArray array];
                    for (int n = 0; n < stoneList.count; n++) {
                        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = [[RSTaobaoInventoryDetModel alloc]init];
                        taobaoInventoryDetmodel.InventoryDetID = [[[stoneList objectAtIndex:n]objectForKey:@"id"]integerValue];
                        taobaoInventoryDetmodel.stoneType = [[stoneList objectAtIndex:n]objectForKey:@"stoneType"];
                        taobaoInventoryDetmodel.warehouseName = [[stoneList objectAtIndex:n]objectForKey:@"warehouseName"];
                        taobaoInventoryDetmodel.blockNo = [[stoneList objectAtIndex:n]objectForKey:@"blockNo"];
                        taobaoInventoryDetmodel.turnNo = [[stoneList objectAtIndex:n]objectForKey:@"turnNo"];
                        taobaoInventoryDetmodel.turnQty = [[[stoneList objectAtIndex:n]objectForKey:@"turnQty"]integerValue];
                        taobaoInventoryDetmodel.isOpen = false;
                        taobaoInventoryDetmodel.length =  [[stoneList objectAtIndex:n]objectForKey:@"length"];
                        taobaoInventoryDetmodel.width = [[stoneList objectAtIndex:n]objectForKey:@"width"];
                        taobaoInventoryDetmodel.height = [[stoneList objectAtIndex:n]objectForKey:@"height"];
                        taobaoInventoryDetmodel.volume = [[stoneList objectAtIndex:n]objectForKey:@"volume"];
                        taobaoInventoryDetmodel.weight = [[stoneList objectAtIndex:n]objectForKey:@"weight"];
                        taobaoInventoryDetmodel.preArea = [[stoneList objectAtIndex:n]objectForKey:@"preArea"];
                        taobaoInventoryDetmodel.dedArea = [[stoneList objectAtIndex:n]objectForKey:@"dedArea"];
                        taobaoInventoryDetmodel.inventoryId = [[[stoneList objectAtIndex:n]objectForKey:@"inventoryId"]integerValue];
                        taobaoInventoryDetmodel.area = [[stoneList objectAtIndex:n]objectForKey:@"area"];
                        [temp addObject:taobaoInventoryDetmodel];
                    }
                    //大板
                    weakSelf.taobaomangementmodel.stoneDtlList = [weakSelf changeArrayRule:temp];
                    [weakSelf reloadDabanTotalArea];
                }
                
                if ([type isEqualToString:@"上架"]) {
                    //未完成上个页面要进行重新请求
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    if ([weakSelf.type isEqualToString:@"荒料"]) {
                        if ([weakSelf.taobaomangementmodel.unit isEqualToString:@""]) {
                            _priceLabel.text = @"价格/m³";
                            _originalpriceLabel.text = @"原价格/m³";
                        }else if ([weakSelf.taobaomangementmodel.unit isEqualToString:@"立方米"]){
                            _priceLabel.text = @"价格/m³";
                            _originalpriceLabel.text = @"原价格/m³";
                        }else{
                            _priceLabel.text = @"价格/吨";
                            _originalpriceLabel.text = @"原价格/吨";
                        }
                    }else{
                        _priceLabel.text = @"价格/m²";
                        _originalpriceLabel.text = @"原价格/m²";
                    }
                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                }
                NSDictionary * dict = @{@"Type":self.type};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"saveAndUpdate" object:dict];
                [weakSelf.tableview reloadData];
            }else{
                if ([type isEqualToString:@"上架"]) {
                    [SVProgressHUD showErrorWithStatus:@"该商品数据不完整，请填充完整后再上架"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"保存失败"];
                }
            }
        }else{
            if ([type isEqualToString:@"上架"]) {
                 [SVProgressHUD showErrorWithStatus:@"该商品数据不完整，请填充完整后再上架"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }
        }
    }];
}



- (NSMutableArray *)changeArrayRule:(NSArray *)contentarray{
    NSMutableArray *dateMutablearray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
    for (int i = 0; i < array.count; i ++) {
        //NSString *string = array[i];
        RSTaobaoInventoryDetModel * taobaoInventoryDetmodel = array[i];
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:taobaoInventoryDetmodel];
        for (int j = i+1;j < array.count; j ++) {
            RSTaobaoInventoryDetModel * taobaoInventoryDetmodel1 = array[j];
            if([taobaoInventoryDetmodel1.blockNo isEqualToString:taobaoInventoryDetmodel.blockNo]){
                [tempArray addObject:taobaoInventoryDetmodel1];
                [array removeObjectAtIndex:j];
                j = j - 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    return dateMutablearray;
}




@end
