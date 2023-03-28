//
//  RSSCCaseDetailViewController.m
//  石来石往
//
//  Created by mac on 2021/10/29.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCCaseDetailViewController.h"
#import "ZKImgRunLoopView.h"
#import "RSSCCaseDetailCell.h"
#import "RSPublishingProjectCaseFirstButton.h"

@interface RSSCCaseDetailViewController ()

@end

@implementation RSSCCaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"案例详情";
    [self isAddjust];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar);
    [self.view addSubview:self.tableview];
    
    [self.tableview registerClass:[RSSCCaseDetailCell class] forCellReuseIdentifier:@"casedetail"];
    
//    [self loadSingleCaseDetail];
    //这边设置头部视图
    [self setHeaderViewUI];
}

//- (void)loadSingleCaseDetail{
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    [phoneDict setObject:[NSNumber numberWithInteger:self.enterpriseId] forKey:@"enterpriseId"];
//    //URL_CASE_QUERY_IOS
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    CLog(@"++++++++++++++++++++++++++++%@",parameters);
//    RSWeakself
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_CASE_QUERY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            CLog(@"++++++++++++++++++++++++++++%@",json);
//            if ([json[@"success"] boolValue]) {
//            }
//        }
//    }];
//}



- (void)setHeaderViewUI{
    
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    //这边要设置图片轮播图
    ZKImgRunLoopView * imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, SCW, Height_Real(373)) placeholderImg:[UIImage imageNamed:@"01"]];
//    imgRunView.backgroundColor = [UIColor yellowColor];
    imgRunView.pageControl.hidden = NO;
    [headerView addSubview:imgRunView];
    imgRunView.pageControl.PageControlContentMode =  JhPageControlContentModeCenter;
    imgRunView.pageControl.PageControlStyle = JhPageControlStyelDefault;
    imgRunView.pageControl.currentColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#ffffff" alpha:0.5];
    imgRunView.pageControl.controlSpacing = Width_Real(8);
    imgRunView.pageControl.yj_y = Height_Real(373) - Height_Real(12);
    imgRunView.pageControl.yj_centerX = headerView.yj_centerX;
//    _imgRunView = imgRunView;
    
    //对于图片进行修改
//    self.casesModel
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    NSMutableArray * urlList = [NSMutableArray array];
    for (int i = 0; i < self.casesModel.urlList.count; i++) {
        [urlList addObject:[NSString stringWithFormat:@"%@%@",url,self.casesModel.urlList[i]]];
    }
    
    imgRunView.imgUrlArray = urlList;
    
    //名字
    UILabel * nameLabel = [[UILabel alloc]init];
//    nameLabel.text = @"无极洞石案例赏析";
    nameLabel.text = self.casesModel.caseCategoryNameCn;
    nameLabel.font = [UIFont systemFontOfSize:Width_Real(24) weight:UIFontWeightMedium];
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:nameLabel];
    
    nameLabel.sd_layout.leftSpaceToView(headerView, Width_Real(16)).rightSpaceToView(headerView, Width_Real(16)).topSpaceToView(imgRunView, Height_Real(12)).heightIs(Height_Real(34));
    
    //公司图片
    UIImageView * companyImage = [[UIImageView alloc]init];
//    companyImage.image = [UIImage imageNamed:@"01"];
    [headerView addSubview:companyImage];
    companyImage.sd_layout.leftEqualToView(nameLabel).topSpaceToView(nameLabel, Height_Real(9)).widthIs(Width_Real(28)).heightEqualToWidth();
    
    companyImage.layer.cornerRadius = companyImage.yj_width * 0.5;
    companyImage.layer.masksToBounds = true;
    
    [companyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,self.casesModel.logoUrl]] placeholderImage:[UIImage imageNamed:@"01"]];
    
    //公司名字
    UILabel * companyNameLabel = [[UILabel alloc]init];
//    companyNameLabel.text = @"海西石材有限公司";
    companyNameLabel.text = self.casesModel.enterpriseNameCn;
    companyNameLabel.font = [UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightRegular];
    companyNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    companyNameLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:companyNameLabel];
    
    companyNameLabel.sd_layout.leftSpaceToView(companyImage, Width_Real(8)).topSpaceToView(nameLabel, Height_Real(12)).rightSpaceToView(headerView, Width_Real(16)).heightIs(Height_Real(23));
    
    //收藏
//    RSPublishingProjectCaseFirstButton * collectionBtn = [[RSPublishingProjectCaseFirstButton alloc]init];
//    [collectionBtn addTarget:self action:@selector(collectionCurrentCompanyAction:) forControlEvents:UIControlEventTouchUpInside];
//    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
//    [collectionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
//    [collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
//    [collectionBtn setImage:[UIImage imageNamed:@"b27_icon_star_yellow"] forState:UIControlStateSelected];
//    [collectionBtn setImage:[UIImage imageNamed:@"b27_icon_star_gray"] forState:UIControlStateNormal];
//    [headerView addSubview:collectionBtn];
//    collectionBtn.imageView.sd_layout.topSpaceToView(collectionBtn, 0).rightSpaceToView(collectionBtn, 0);
//    collectionBtn.titleLabel.sd_layout.topSpaceToView(collectionBtn.imageView, 0);
//    collectionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    collectionBtn.sd_layout.rightSpaceToView(headerView, Width_Real(16)).topSpaceToView(nameLabel, 0).widthIs(Width_Real(50)).heightEqualToWidth();
   
    
    //简介
    UILabel * briefLabel = [[UILabel alloc]init];
    briefLabel.numberOfLines = 0;
//    briefLabel.text = @"此处是石材简介此处是石材简介此处是石材简介此处是石材简介此处是石材简介此处是石材简介";
    briefLabel.text = self.casesModel.notes;
    briefLabel.font = [UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightRegular];
    briefLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    briefLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:briefLabel];
    
    briefLabel.sd_layout.leftEqualToView(companyImage).rightSpaceToView(headerView, Width_Real(16)).topSpaceToView(companyImage, Height_Real(16)).heightIs([self getHeightLineWithString:briefLabel.text withWidth:SCW - Width_Real(32) withFont:[UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightRegular]]);
    
    //案例用料
    UILabel * caseLabel = [[UILabel alloc]init];
//    caseLabel.numberOfLines = 1;
    // ————————
    caseLabel.text = @"案例用料";
//    caseLabel.text = casesModel.caseCategoryNameCn;
    caseLabel.font = [UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightMedium];
    caseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    caseLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:caseLabel];
    caseLabel.sd_layout.centerXEqualToView(headerView).topSpaceToView(briefLabel, Height_Real(12)).widthIs(Width_Real(100)).heightIs(Height_Real(23));
    

    UIView * leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333" alpha:0.3];
    [headerView addSubview:leftView];
    
    leftView.sd_layout.leftSpaceToView(headerView, Width_Real(16)).rightSpaceToView(caseLabel, Width_Real(5)).heightIs(Height_Real(0.5)).topSpaceToView(briefLabel, Height_Real(23.5));
    
    UIView * rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333" alpha:0.3];
    [headerView addSubview:rightView];
    
    rightView.sd_layout.leftSpaceToView(caseLabel, Width_Real(5)).rightSpaceToView(headerView, Width_Real(16)).heightIs(Height_Real(0.5)).topSpaceToView(briefLabel, Height_Real(23.5));
    
    //图片
//    UIImageView * caseImage = [[UIImageView alloc]init];
//    caseImage.backgroundColor = [UIColor yellowColor];
//    [headerView addSubview:caseImage];
//    caseImage.sd_layout.leftSpaceToView(headerView, Width_Real(16)).rightSpaceToView(headerView, Width_Real(16)).topSpaceToView(caseLabel, Height_Real(12)).heightIs(Height_Real(175));
    
    
    
//    ZKImgRunLoopView * caseImage = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(Width_Real(16), CGRectGetMaxY(imgRunView.frame) + Height_Real(193), SCW - Width_Real(32) , Height_Real(175)) placeholderImg:[UIImage imageNamed:@"01"]];
////    caseImage.backgroundColor = [UIColor yellowColor];
//    caseImage.pageControl.hidden = NO;
//    [headerView addSubview:caseImage];
//    caseImage.pageControl.PageControlContentMode =  JhPageControlContentModeCenter;
//    caseImage.pageControl.PageControlStyle = JhPageControlStyelDefault;
//    caseImage.pageControl.currentColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    caseImage.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#ffffff" alpha:0.5];
//    caseImage.pageControl.controlSpacing = Width_Real(8);
//    caseImage.pageControl.yj_y = Height_Real(175) - Height_Real(12);
//    caseImage.pageControl.yj_centerX = headerView.yj_centerX;
//
//    NSMutableArray * stoneUrlList = [NSMutableArray array];
//    for (int i = 0; i < self.casesModel.stoneUrlList.count; i++) {
//        [stoneUrlList addObject:[NSString stringWithFormat:@"%@%@",url,self.casesModel.stoneUrlList[i]]];
//    }
//    caseImage.imgUrlArray = stoneUrlList;
//
//
//    //石头
//    UILabel * stoneNameLabel = [[UILabel alloc]init];
//    stoneNameLabel.text = @"人造洞石（无极黑洞石）";
//    stoneNameLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
//    stoneNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//    stoneNameLabel.textAlignment = NSTextAlignmentLeft;
//    [headerView addSubview:stoneNameLabel];
//    stoneNameLabel.sd_layout.leftEqualToView(caseImage).rightEqualToView(caseImage).topSpaceToView(caseImage, Height_Real(12)).heightIs(21);
    
    [headerView setupAutoHeightWithBottomView:caseLabel bottomMargin:20];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}


//- (void)collectionCurrentCompanyAction:(UIButton *)sender{
//    sender.selected = !sender.selected;
//    NSLog(@"收藏");
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.casesModel.stoneUrlList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Height_Real(195);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [[UITableViewCell alloc]init];
    RSSCCaseDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"casedetail"];
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    [cell.showImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,self.casesModel.stoneUrlList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"01"]];
    return cell;
}








@end
