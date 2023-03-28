//
//  ThirdTableViewController.m
//  TableViewFloat
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 singularity. All rights reserved.
//

#import "ThirdTableViewController.h"

#import "RSProcessingOutWareHouseView.h"
#import "RSPublishingProjectCaseFirstButton.h"
#import "RSThirdProcessModel.h"


@interface ThirdTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView * headerView;

@property(nonatomic ,strong)UITableView * myTableView;

@property (nonatomic,strong)RSPublishingProjectCaseFirstButton * addPic;

@property (nonatomic,strong)NSMutableArray * imageArray;

@property (nonatomic,strong)RSProcessingOutWareHouseView * processingOutWareHouse;
@end

@implementation ThirdTableViewController

- (RSProcessingOutWareHouseView *)processingOutWareHouse{
    if (!_processingOutWareHouse) {
        self.processingOutWareHouse = [[RSProcessingOutWareHouseView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 187, SCW - 66 , 374)];
        self.processingOutWareHouse.backgroundColor = [UIColor whiteColor];
        self.processingOutWareHouse.layer.cornerRadius = 15;
    }
    return _processingOutWareHouse;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        
        Y = 88;
    }else{
        Y = 64;
    }
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCW,self.view.frame.size.height - Y - 44)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _imageArray = [NSMutableArray array];
    [self setCustomTabelHeaderView];
    
    [self reloadImageNewData];
}



- (void)reloadImageNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.billdtlid] forKey:@"billdtlid"];
    [phoneDict setObject:[NSNumber numberWithBool:false] forKey:@"processList"];
    [phoneDict setObject:[NSNumber numberWithBool:false] forKey:@"processFeeList"];
    [phoneDict setObject:[NSNumber numberWithBool:true] forKey:@"processPicList"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROCESSDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [_imageArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"processPicList"];
                for (int i = 0; i < array.count; i++){
                    RSThirdProcessModel * thirdProcessmodel = [[RSThirdProcessModel alloc]init];
                    thirdProcessmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"] integerValue];
                    thirdProcessmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                    thirdProcessmodel.createUser = [[array objectAtIndex:i]objectForKey:@"createUser"];
                    thirdProcessmodel.filePath = [[array objectAtIndex:i]objectForKey:@"filePath"];
                     thirdProcessmodel.processId = [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
                    thirdProcessmodel.name = [[array objectAtIndex:i]objectForKey:@"name"];
                    [_imageArray addObject:thirdProcessmodel];
                }
                [weakSelf nineGrid];
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取失败"];
        }
    }];
}




- (void)setCustomTabelHeaderView{
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 81)];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.headerView = headerView;
//    [self.view addSubview:headerView];
    
    RSPublishingProjectCaseFirstButton * addPic = [[RSPublishingProjectCaseFirstButton alloc]initWithFrame:CGRectMake(12, 3,115, 75)];
    [addPic setImage:[UIImage imageNamed:@"添加个人版"] forState:UIControlStateNormal];
    [addPic setTitle:@"添加" forState:UIControlStateNormal];
    [addPic addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    addPic.titleLabel.font = [UIFont systemFontOfSize:12];
    addPic.layer.cornerRadius = 5;
    [addPic setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    addPic.layer.borderColor = [UIColor colorWithHexColorStr:@"#E8E8E8"].CGColor;
    addPic.layer.borderWidth = 1;
    [addPic setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [headerView addSubview:addPic];
    self.addPic = addPic;
    if (self.usermodel.pwmsUser.HLGL_BBZX_JGGDCK == 1 && self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1) {
        self.addPic.hidden = NO;
    }else if(self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1 ){
        self.addPic.hidden = NO;
    }else{
        self.addPic.hidden = YES;
    }
    [headerView setupAutoHeightWithBottomView:addPic bottomMargin:12];
    [headerView layoutIfNeeded];
    self.myTableView.tableHeaderView = headerView;
}


//- (void)addThirdTitle:(NSString *)titleStr andImage:(UIImage *)image{
//    //这边要对图片进行处理
//    [_imageArray addObject:image];
//    [self nineGrid];
//}


- (void)nineGrid
{
    //图片
    for (UIImageView * imgv in self.headerView.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
        }
    }
    //(self.bounds.size.width - (ECA + 1)*margin)/ECA
    CGFloat width = (SCW - 4 * 12)/3;
    CGFloat height = 75;
    CGFloat widthSpace = 12;
    CGFloat heightSpace = 12;
    NSInteger count = _imageArray.count;
    _imageArray.count > 10000 ? (count = 10000) : (count = _imageArray.count);
    
    if (_imageArray.count > 0) {
        
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / 3;
            NSInteger colom = i % 3;
            CGFloat imageX =  colom * (12 + width) + 12;
            CGFloat imageY =  row * (12 + height) + 12;
            //            UIView * imageSelectView = [[UIView alloc]initWithFrame:CGRectMake(imageX, imageY, width, 75)];
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, width, height)];
            NSString * urlstr = [URL_HEADER_TEXT_IOS substringToIndex:[URL_HEADER_TEXT_IOS length] - 1];
            RSThirdProcessModel * thirdprocessmodel = _imageArray[i];
            [imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlstr,thirdprocessmodel.filePath]] placeholderImage:[UIImage imageNamed:@"512"]];
            imgv.contentMode = UIViewContentModeScaleAspectFill;
            imgv.clipsToBounds = YES;
            [self.headerView addSubview:imgv];
            
            imgv.userInteractionEnabled = YES;
            imgv.tag = 10000 + i;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)];
            [imgv addGestureRecognizer:tap];
            
            tap.view.tag = 10000 + i;
            
            
            
            UILabel * imageContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 58, imgv.yj_width, 18)];
            imageContentLabel.text = thirdprocessmodel.name;
            imageContentLabel.textAlignment = NSTextAlignmentLeft;
            imageContentLabel.font = [UIFont systemFontOfSize:11];
            imageContentLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            imageContentLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff" alpha:0.6];
            //[imageSelectView addSubview:imgv];
            [imgv addSubview:imageContentLabel];
            //[self.headerView addSubview:imageSelectView];
            [imageContentLabel bringSubviewToFront:imgv];
         
            
            if (i == _imageArray.count - 1)
            {
                if (_imageArray.count % 3 == 0) {
                    _addPic.frame = CGRectMake(15, CGRectGetMaxY(imgv.frame) + heightSpace, width, 75);
                } else {
                    _addPic.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), width, 75);
                }
                // _editv.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(_addPic.frame)+20);
                if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
                    self.headerView.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(_addPic.frame) + 12);
                }else{
                    self.headerView.frame = CGRectMake(0, 88, SCW, CGRectGetMaxY(_addPic.frame) + 12);
                }
            }
        }
        
        
    }else{
        
        _addPic.frame = CGRectMake(12, 3,115, 75);
        if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
            self.headerView.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(_addPic.frame) + 12);
        }else{
            self.headerView.frame = CGRectMake(0, 88, SCW, CGRectGetMaxY(_addPic.frame) + 12);
        }
    }
    [self.headerView setupAutoHeightWithBottomView:_addPic bottomMargin:12];
    [self.headerView layoutIfNeeded];
    self.myTableView.tableHeaderView = self.headerView;
}


- (void)showPicture:(UITapGestureRecognizer *)tap{
    
    if (self.usermodel.pwmsUser.HLGL_BBZX_JGGDCK == 1 && self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1) {
        
        
        self.processingOutWareHouse.addType = @"添加照片";
        RSThirdProcessModel * thirdProcessmodel = self.imageArray[tap.view.tag - 10000];
        self.processingOutWareHouse.thirdProcessmodel = thirdProcessmodel;
        self.processingOutWareHouse.billdtlid = thirdProcessmodel.billdtlid;
        self.processingOutWareHouse.VC = self;
        self.processingOutWareHouse.statusType = @"2";
        [self.processingOutWareHouse showView];
        RSWeakself
        self.processingOutWareHouse.processReload = ^(BOOL isreload) {
            if (isreload) {
                [weakSelf reloadImageNewData];
            }
        };
        
        
    }else if(self.usermodel.pwmsUser.HLGL_BBZX_JGGDCZ == 1 ){
        
        
        
        
        self.processingOutWareHouse.addType = @"添加照片";
        RSThirdProcessModel * thirdProcessmodel = self.imageArray[tap.view.tag - 10000];
        self.processingOutWareHouse.thirdProcessmodel = thirdProcessmodel;
        self.processingOutWareHouse.billdtlid = thirdProcessmodel.billdtlid;
        self.processingOutWareHouse.VC = self;
        self.processingOutWareHouse.statusType = @"2";
        [self.processingOutWareHouse showView];
        RSWeakself
        self.processingOutWareHouse.processReload = ^(BOOL isreload) {
            if (isreload) {
                [weakSelf reloadImageNewData];
            }
        };
        
        
    }else{

        RSThirdProcessModel * thirdprocessmodel = _imageArray[tap.view.tag - 10000];
        NSMutableArray * array = [NSMutableArray array];
        NSString * urlstr = [URL_HEADER_TEXT_IOS substringToIndex:[URL_HEADER_TEXT_IOS length] - 1];
        NSString * str = [NSString stringWithFormat:@"%@%@",urlstr,thirdprocessmodel.filePath];
        
        [array addObject:str];
        NSString * contentstr = [NSString stringWithFormat:@"%@",thirdprocessmodel.name];
        [XLPhotoBrowser showPhotoBrowserWithImages:array currentImageIndex:0 andContentStr:contentstr];
    }
}


- (void)addPictureAction:(UIButton *)addPicBtn{
    self.processingOutWareHouse.addType = @"添加照片";
    self.processingOutWareHouse.billdtlid = self.billdtlid;
    self.processingOutWareHouse.VC = self;
    self.processingOutWareHouse.statusType = @"1";
    [self.processingOutWareHouse showView];
    RSWeakself
    self.processingOutWareHouse.processReload = ^(BOOL isreload) {
        if (isreload) {
            [weakSelf reloadImageNewData];
        }
    };
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * THIRDCELLID = @"THIRDCELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:THIRDCELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:THIRDCELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
