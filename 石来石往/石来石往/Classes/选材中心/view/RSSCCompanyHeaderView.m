//
//  RSSCCompanyHeaderView.m
//  石来石往
//
//  Created by mac on 2021/10/30.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCCompanyHeaderView.h"



@interface RSSCCompanyHeaderView()<MLLinkLabelDelegate>

//企业简介详情的高度
@property (nonatomic,assign)CGFloat linkIntrodcutHeight;

@property (nonatomic,assign)NSInteger enterpriseId;

@property (nonatomic,strong)RSSCCompanyHeaderModel * sccompanyHeaderModel;
//公司名称
@property (nonatomic,strong)UILabel * companyNameLabel;
//企业图片
@property (nonatomic,strong)UIImageView * companyImage;
//主营
@property (nonatomic,strong)UILabel * companyProductLabel;
//企业图片
@property (nonatomic,strong)UIImageView * companyBGImage;
//企业简介
@property (nonatomic,strong)UILabel * companyIntroductionLabel;
//联系电话1
@property (nonatomic,strong)UIButton * firstPhoneNameBtn;
//联系电话2
//@property (nonatomic,strong)UIButton * secondPhoneNameBtn;
//地址
@property (nonatomic,strong)UIButton * addressBtn;
//分割线
@property (nonatomic,strong)UIView * midView;
//联系人
@property (nonatomic,strong)UILabel * contactLabel;
//第二个分割线
@property (nonatomic,strong)UIView * contactView;

//地址
@property (nonatomic,strong)UILabel * addressLabel;
//第三分割线
@property (nonatomic,strong)UIView * addressView;
//门店
@property (nonatomic,strong)UILabel * storeLabel;
//几家数字
@property (nonatomic,strong)UILabel * storeNumberLabel;

//方向图片
@property (nonatomic,strong)UIImageView * storeImage;
//分隔视图
@property (nonatomic,strong)UIView * storeView;
//vip
@property (nonatomic,strong)UIImageView * vipImage;



//BCMidView 经营许可证分割服
@property (nonatomic,strong)UIView * bcMidView;

@property (nonatomic,strong)UILabel * bcLabel;

@property (nonatomic,strong)UIView * bcView;

//显示经营证书
@property (nonatomic,strong)UIScrollView * bcScrollView;
//证书数组
@property (nonatomic,strong)NSMutableArray * bcPitrueArray;

@end




@implementation RSSCCompanyHeaderView


- (NSMutableArray *)bcPitrueArray{
    if(!_bcPitrueArray){
        _bcPitrueArray = [NSMutableArray array];
    }
    return _bcPitrueArray;
}


-(instancetype)initWithFrame:(CGRect)frame withHeight:(CGFloat)height andEnterpriseId:(NSInteger)enterpriseId{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.sccompanyHeaderModel = sccompanyHeaderModel;
        self.enterpriseId = enterpriseId;
        [self loadHeadData];
        [self setUI];
    }
    return self;
}


#pragma mark -- 获取上半部分的数据
- (void)loadHeadData{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    [dict setObject:[NSString stringWithFormat:@"%ld",self.enterpriseId] forKey:@"id"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary * parameters = @{@"key":[NSString get_uuid],@"Data":dataStr,@"VerifyKey":[UserManger isLogin] ? [UserManger Verifykey] : @"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    NSLog(@"========================%@",parameters);
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ENTERPRISE_GET_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            CLog(@"===========================1=======2==========3=================%@",json);
            BOOL Result = [json[@"success"]boolValue];
            if (Result) {
                
             RSSCCompanyHeaderModel * sccompanyHeaderModel = [RSSCCompanyHeaderModel mj_objectWithKeyValues:json[@"data"]];
                
                sccompanyHeaderModel.enterpriseManList = [RSSCCompanyHeaderContactModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"enterpriseManList"]];
                sccompanyHeaderModel.enterpriseStoreList = [RSSCCompanyHeaderStoreModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"enterpriseStoreList"]];
                
                
                _bcPitrueArray = [RSBusinessLicenseListModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"businessLicenseList"]];
                
                weakSelf.sccompanyHeaderModel = sccompanyHeaderModel;
                
                NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
                
                weakSelf.companyNameLabel.text = weakSelf.sccompanyHeaderModel.nameCn;
                
               CGFloat height = [weakSelf getHeightLineWithString:weakSelf.sccompanyHeaderModel.nameCn withWidth:SCW - Width_Real(121) withFont:[UIFont systemFontOfSize:Width_Real(24) weight:UIFontWeightMedium]];
                
                if (height < 34) {
                    height = Height_Real(34);
                }
                
               weakSelf.companyNameLabel.sd_layout.leftSpaceToView(self , Width_Real(16)).topSpaceToView(self, Height_Real(12)).heightIs(height).rightSpaceToView(self , Width_Real(105));
                
                _vipImage.sd_layout.leftEqualToView(_companyNameLabel).topSpaceToView(_companyNameLabel, Height_Real(4)).widthIs(Width_Real(16)).heightEqualToWidth();
                
                weakSelf.height += height;
                
                
                [weakSelf.companyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,weakSelf.sccompanyHeaderModel.logoUrl]] placeholderImage:[UIImage imageNamed:@"01"]];
                
                weakSelf.height += Height_Real(40);
                
                [weakSelf.companyBGImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,weakSelf.sccompanyHeaderModel.backgroundUrl]] placeholderImage:[UIImage imageNamed:@"01"]];

                
                CGFloat companyProductLabelHieght = [weakSelf getHeightLineWithString:weakSelf.sccompanyHeaderModel.mainBusiness withWidth:SCW - Width_Real(121) withFont:[UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightMedium]];
                
               weakSelf.companyProductLabel.text = weakSelf.sccompanyHeaderModel.mainBusiness;
                
                _companyBGImage.sd_layout.leftEqualToView(_companyProductLabel).topSpaceToView(_companyProductLabel, Height_Real(4)).widthIs(SCW - Width_Real(75)).heightIs(Height_Real(180));
                
                weakSelf.linkLabel.text = weakSelf.sccompanyHeaderModel.introduction;
                
//                weakSelf.linkLabel.text = @"我是企业简介我是企业简介我是企业简介我是企我是企业简介我是企业简介我是企业简介我是企我是企业简介我是企业简介我是企业简介我是企我是企业简介我是企业简介我是企业简介我是企我是企业简介我是企业简介我是企业简介我是企我是企业简介我是企业简介我是企业简介我是企我是企业简介我是企业简介我是企业简介我是企...http://www.haixigufen.com/";
                
                RSSCCompanyHeaderContactModel * contactModel = weakSelf.sccompanyHeaderModel.enterpriseManList[0];
                [weakSelf.firstPhoneNameBtn setTitle:[NSString stringWithFormat:@"%@ %@",contactModel.contactManName,contactModel.contactNumber] forState:UIControlStateNormal];
                
//                [weakSelf.secondPhoneNameBtn setTitle:[NSString stringWithFormat:@"%@ %@",self.sccompanyHeaderModel.contacts,weakSelf.sccompanyHeaderModel.contactNumber2] forState:UIControlStateNormal];
                
                
                [weakSelf.addressBtn setTitle:weakSelf.sccompanyHeaderModel.address forState:UIControlStateNormal];
               RSSCCompanyHeaderStoreModel * storeModel = weakSelf.sccompanyHeaderModel.enterpriseStoreList[0];
                [weakSelf.storeBtn setTitle:[NSString stringWithFormat:@"%@ %@",storeModel.storeName,storeModel.storeAddress] forState:UIControlStateNormal];
                
                weakSelf.linkIntrodcutHeight = [weakSelf getHeightLineWithString:_linkLabel.text withWidth:SCW - Width_Real(32) withFont:[UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular]];
                
                
                
                
                weakSelf.height += companyProductLabelHieght;
                
                weakSelf.height += Height_Real(237);
                
                
                if (weakSelf.linkIntrodcutHeight >= 50) {
                    
                    weakSelf.moreBtn.hidden = false;
                    weakSelf.linkLabel.sd_layout.leftEqualToView(_companyIntroductionLabel).rightSpaceToView(weakSelf, Width_Real(16)).heightIs(Height_Real(50)).topSpaceToView(_companyIntroductionLabel, Height_Real(12));
                    
                   _moreBtn.sd_layout.leftEqualToView(_linkLabel).topSpaceToView(_linkLabel, 0).widthIs(Width_Real(80)).heightIs(Height_Real(20));
                    
                    _midView.sd_layout.leftEqualToView(_linkLabel).rightEqualToView(_linkLabel).topSpaceToView(_moreBtn, Height_Real(4)).heightIs(Height_Real(0.5));
                    
                    weakSelf.height += Height_Real(50);
                    //按键高度
                    weakSelf.height += Height_Real(20);
                    
                }else{
                    
                    weakSelf.moreBtn.hidden = YES;
                    
                    _linkLabel.sd_layout.leftEqualToView(_companyIntroductionLabel).rightSpaceToView(weakSelf, Width_Real(16)).heightIs(Height_Real(50)).topSpaceToView(_companyIntroductionLabel, Height_Real(12));
                    _midView.sd_layout.leftEqualToView(_linkLabel).rightEqualToView(_linkLabel).topSpaceToView(_linkLabel, Height_Real(4)).heightIs(Height_Real(0.5));
                    
                    weakSelf.height += Height_Real(50);
                }
                
                //这边有什么办法进行修改
                _contactLabel.sd_layout.leftEqualToView(_midView).topSpaceToView(_midView, Height_Real(14)).widthIs(Width_Real(60)).heightIs(Height_Real(21));
                
                _firstPhoneNameBtn.sd_layout.leftSpaceToView(_contactLabel, Width_Real(12)).topSpaceToView(_midView, Height_Real(14)).rightEqualToView(_midView).heightIs(Height_Real(21));
                
//                _secondPhoneNameBtn.sd_layout.leftSpaceToView(_contactLabel, Width_Real(12)).topSpaceToView(_firstPhoneNameBtn, Height_Real(2)).rightEqualToView(_midView).heightIs(Height_Real(20));
                
                _contactView.sd_layout.leftEqualToView(_contactLabel).rightEqualToView(_firstPhoneNameBtn).topSpaceToView(_firstPhoneNameBtn, Height_Real(12)).heightIs(Height_Real(0.5));
                
                _addressLabel.sd_layout.leftEqualToView(_contactView).topSpaceToView(_contactView, Height_Real(14)).widthIs(Width_Real(60)).heightIs(Height_Real(21));
                
                _addressBtn.sd_layout.leftSpaceToView(_addressLabel, Width_Real(12)).topSpaceToView(_contactView, Height_Real(14)).rightSpaceToView(self, Width_Real(16)).heightIs(Height_Real(20));
                
                _addressView.sd_layout.leftEqualToView(_addressLabel).rightEqualToView(_addressBtn).topSpaceToView(_addressBtn, Height_Real(14)).heightIs(Height_Real(0.5));
                
                _storeLabel.sd_layout.leftEqualToView(_addressView).topSpaceToView(_addressView, Height_Real(14)).widthIs(Width_Real(60)).heightIs(Height_Real(21));
                
                _storeImage.sd_layout.rightSpaceToView(self, Width_Real(24)).widthIs(Width_Real(5)).heightIs(Height_Real(10)).topSpaceToView(_addressView, Height_Real(20));
                
                
                
                _bcMidView.sd_layout.leftEqualToView(_addressLabel).rightEqualToView(_addressBtn).topSpaceToView(_storeLabel, Height_Real(14.5)).heightIs(Height_Real(0.5));
                
                _bcLabel.sd_layout.leftEqualToView(_bcMidView).topSpaceToView(_bcMidView, Height_Real(14.5)).widthIs(Width_Real(100)).heightIs(Height_Real(21));
                
                
                _bcView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(_bcLabel, 0).heightIs(84);
                
//                _bcScrollView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(_bcLabel, 10).heightIs(84);
                _bcScrollView.sd_layout.leftSpaceToView(_bcView, 8).rightSpaceToView(_bcView, 0).topSpaceToView(_bcView, 12).heightIs(60);
                
                _storeView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(_bcView, 0).heightIs(Height_Real(10));
//                weakSelf.height += Height_Real(179.5);

                weakSelf.height += Height_Real(299);
                
                _storeNumberLabel.text = [NSString stringWithFormat:@"%ld",sccompanyHeaderModel.enterpriseStoreList.count];
                
//                _bcPitrueArray = @[@"民生logo",@"民生logo",@"民生logo",@"民生logo",@"民生logo"];
                
                
                
                
                
                [weakSelf BCPitrueContent:_bcPitrueArray];
                
                
                if ([self.delegate respondsToSelector:@selector(moreCheckBtnSelectStatus:andHeight:isCollection:)]) {
                    [self.delegate moreCheckBtnSelectStatus:false andHeight:self.height isCollection:sccompanyHeaderModel.collectionState];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
        }
    }];
}

- (void)setUI{
    
    //公司名称
    UILabel * companyNameLabel = [[UILabel alloc]init];
    companyNameLabel.text = @"海西石材有限公司";
    companyNameLabel.numberOfLines = 0;
//    companyNameLabel.text = self.sccompanyHeaderModel.nameCn;
    companyNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    companyNameLabel.font = [UIFont systemFontOfSize:Width_Real(24) weight:UIFontWeightMedium];
    companyNameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:companyNameLabel];
    _companyNameLabel = companyNameLabel;
    
    CGFloat companyHeight = [self getHeightLineWithString:companyNameLabel.text withWidth:SCW - Width_Real(121) withFont:[UIFont systemFontOfSize:Width_Real(24) weight:UIFontWeightMedium]];
    
    
    companyNameLabel.sd_layout.leftSpaceToView(self , Width_Real(16)).topSpaceToView(self, Height_Real(12)).heightIs(companyHeight).rightSpaceToView(self , Width_Real(105));
    
//    _height += Height_Real(12) + Height_Real(34);
 
    //公司图片
    UIImageView * companyImage = [[UIImageView alloc]init];
    companyImage.image = [UIImage imageNamed:@"01"];
    [self addSubview:companyImage];
    _companyImage = companyImage;
    
    
    companyImage.sd_layout.topSpaceToView(self , Height_Real(16)).rightSpaceToView(self, Width_Real(16)).widthIs(Width_Real(89)).heightIs(Height_Real(66));
    
    companyImage.layer.shadowColor = [UIColor colorWithHexColorStr:@"#D2CBCB" alpha:0.25].CGColor;
    companyImage.layer.shadowOffset = CGSizeMake(Width_Real(4),Height_Real(6));
    companyImage.layer.shadowRadius = Width_Real(4);
    companyImage.layer.shadowOpacity = Width_Real(1);
    
    //VIP
    UIImageView * vipImage = [[UIImageView alloc]init];
    vipImage.image = [UIImage imageNamed:@"会员"];
    [self addSubview:vipImage];

    
    vipImage.sd_layout.leftEqualToView(companyNameLabel).topSpaceToView(companyNameLabel, Height_Real(4)).widthIs(Width_Real(16)).heightEqualToWidth();
    
//    _height += Height_Real(4) + Width_Real(16);
    
    _vipImage = vipImage;
    
    //公司主营
    UILabel * companyProductLabel = [[UILabel alloc]init];
    companyProductLabel.text = @"大理石加工 大板批发 石材工艺品加工 异性加工 荒料 大板";
    companyProductLabel.numberOfLines = 0;
    companyProductLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    companyProductLabel.font = [UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightMedium];
    companyProductLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:companyProductLabel];
    _companyProductLabel = companyProductLabel;
    
    CGFloat companyProductLabelHieght = [self getHeightLineWithString:companyProductLabel.text withWidth:SCW - Width_Real(121) withFont:[UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightMedium]];
    
//    companyProductLabelHieght += Height_Real(8);
    
    companyProductLabel.sd_layout.leftEqualToView(vipImage).topSpaceToView(vipImage, Height_Real(8)).rightEqualToView(companyNameLabel).heightIs(companyProductLabelHieght);
    
//    _height += Height_Real(8) + companyProductLabelHieght;
    
    
    
    //图片
    UIImageView * companyBGImage = [[UIImageView alloc]init];
    companyBGImage.image = [UIImage imageNamed:@"01"];
    [self addSubview:companyBGImage];
    companyBGImage.sd_layout.leftEqualToView(companyProductLabel).topSpaceToView(companyProductLabel, Height_Real(4)).widthIs(SCW - Width_Real(75)).heightIs(Height_Real(180));
    _companyBGImage = companyBGImage;
    
//    _height += Height_Real(4) + Height_Real(180);
    //企业简介
    UILabel * companyIntroductionLabel = [[UILabel alloc]init];
    companyIntroductionLabel.text = @"企业简介";
    companyIntroductionLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    companyIntroductionLabel.font = [UIFont systemFontOfSize:Width_Real(18) weight:UIFontWeightMedium];
    companyIntroductionLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:companyIntroductionLabel];
    companyIntroductionLabel.sd_layout.leftEqualToView(companyBGImage).topSpaceToView(companyBGImage, Height_Real(16)).widthIs(SCW/2).heightIs(Height_Real(25));
    _companyIntroductionLabel = companyIntroductionLabel;
    
//    _height += Height_Real(16) + Height_Real(25);
    
    
    
    //企业简介详情
    _linkLabel = kMLLinkLabel();
     UIFont * linklabelFont = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    _linkLabel.font = linklabelFont;
    _linkLabel.text = @"我是企业简介我是企业简介我是企业简介我是企...http://www.haixigufen.com/";
//    _linkLabel.text = self.sccompanyHeaderModel.introduction;
    _linkLabel.delegate = self;
    _linkLabel.numberOfLines = 0;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kLinkTextColor};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#333333"],NSBackgroundColorAttributeName:kHLBgColor};
    [self addSubview:_linkLabel];
    
    
    //查看更多-----按键和回收
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    [moreBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    _moreBtn = moreBtn;
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.5];
    [self addSubview:midView];
    _midView = midView;
   
    
    //这边要去获取简介详情的高度
    self.linkIntrodcutHeight = [self getHeightLineWithString:_linkLabel.text withWidth:SCW - Width_Real(32) withFont:[UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular]];
    
    
    
    
    if (self.linkIntrodcutHeight >= 50) {
        _moreBtn.hidden = false;
        
        _linkLabel.sd_layout.leftEqualToView(_companyIntroductionLabel).rightSpaceToView(self, Width_Real(16)).heightIs(Height_Real(50)).topSpaceToView(_companyIntroductionLabel, Height_Real(12));
        
//        _height += Height_Real(12) + Height_Real(50);
        
        _moreBtn.sd_layout.leftEqualToView(_linkLabel).topSpaceToView(_linkLabel, 0).widthIs(Width_Real(80)).heightIs(Height_Real(20));
        
//        _height += Height_Real(20);
        
        _midView.sd_layout.leftEqualToView(_linkLabel).rightEqualToView(_linkLabel).topSpaceToView(moreBtn, Height_Real(4)).heightIs(Height_Real(0.5));
        
//        _height += Height_Real(4) + Height_Real(0.5);
        
    }else{
        
        _linkLabel.sd_layout.leftEqualToView(companyIntroductionLabel).rightSpaceToView(self, Width_Real(16)).heightIs(Height_Real(50)).topSpaceToView(companyIntroductionLabel, Height_Real(12));
        
//        _height += Height_Real(12) + self.linkIntrodcutHeight;
        
        _moreBtn.hidden = true;
        
//        moreBtn.sd_layout.leftEqualToView(_linkLabel).topSpaceToView(_linkLabel, Height_Real(5)).widthIs(Width_Real(80)).heightIs(Height_Real(20));
        
        _midView.sd_layout.leftEqualToView(_linkLabel).rightEqualToView(_linkLabel).topSpaceToView(_linkLabel, Height_Real(4)).heightIs(Height_Real(0.5));
        
//        _height += Height_Real(4) + Height_Real(0.5);
    }
    

    //联系人
    UILabel * contactLabel = [[UILabel alloc]init];
    contactLabel.text = @"联系人:";
    contactLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    contactLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
    contactLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:contactLabel];
    
    contactLabel.sd_layout.leftEqualToView(midView).topSpaceToView(midView, Height_Real(14)).widthIs(Width_Real(60)).heightIs(Height_Real(21));
    _contactLabel = contactLabel;
   
    
    //有可能有俩个
    UIButton * firstPhoneNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstPhoneNameBtn setTitle:@"海先生 18825489996" forState:UIControlStateNormal];
    [firstPhoneNameBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    firstPhoneNameBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    firstPhoneNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    firstPhoneNameBtn.tag = 1;
    [firstPhoneNameBtn addTarget:self action:@selector(playCall:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:firstPhoneNameBtn];
    _firstPhoneNameBtn = firstPhoneNameBtn;
    firstPhoneNameBtn.sd_layout.leftSpaceToView(contactLabel, Width_Real(12)).topSpaceToView(midView, Height_Real(14)).rightEqualToView(midView).heightIs(Height_Real(21));
    
//    _height += Height_Real(4) + Height_Real(20);
    

//    UIButton * secondPhoneNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [secondPhoneNameBtn setTitle:@"海先生 18825489996" forState:UIControlStateNormal];
//    [secondPhoneNameBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
//    secondPhoneNameBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
//    secondPhoneNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    secondPhoneNameBtn.tag = 2;
//    [secondPhoneNameBtn addTarget:self action:@selector(playCall:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:secondPhoneNameBtn];
//
//    _secondPhoneNameBtn = secondPhoneNameBtn;
    
//    secondPhoneNameBtn.sd_layout.leftSpaceToView(contactLabel, Width_Real(12)).topSpaceToView(firstPhoneNameBtn, Height_Real(2)).rightEqualToView(midView).heightIs(Height_Real(20));
    
//    _height += Height_Real(2) + Height_Real(20);
    
   
    
    UIView * contactView = [[UIView alloc]init];
    contactView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.5];
    [self addSubview:contactView];
    
    contactView.sd_layout.leftEqualToView(contactLabel).rightEqualToView(firstPhoneNameBtn).topSpaceToView(firstPhoneNameBtn, Height_Real(12)).heightIs(Height_Real(0.5));
    _contactView = contactView;
//    _height += Height_Real(12) + Height_Real(0.5);
    
    
    //地址
    UILabel * addressLabel = [[UILabel alloc]init];
    addressLabel.text = @"地   址:";
    addressLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    addressLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:addressLabel];
    
    addressLabel.sd_layout.leftEqualToView(contactView).topSpaceToView(contactView, Height_Real(14)).widthIs(Width_Real(60)).heightIs(Height_Real(21));
    _addressLabel = addressLabel;
    
    UIButton * addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressBtn setTitle:@"中国福建省南安水头海西石材城" forState:UIControlStateNormal];
    addressBtn.titleLabel.numberOfLines = 0;
    [addressBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    addressBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [addressBtn addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addressBtn];
    _addressBtn = addressBtn;
    
    addressBtn.sd_layout.leftSpaceToView(addressLabel, Width_Real(12)).topSpaceToView(contactView, Height_Real(14)).rightSpaceToView(self, Width_Real(16)).heightIs(Height_Real(20));
    
    
//    _height += Height_Real(14) + Height_Real(20);
    
  
    
    UIView * addressView = [[UIView alloc]init];
    addressView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.5];
    [self addSubview:addressView];
    
    addressView.sd_layout.leftEqualToView(addressLabel).rightEqualToView(addressBtn).topSpaceToView(addressBtn, Height_Real(14)).heightIs(Height_Real(0.5));
    
//    _height += Height_Real(14) + Height_Real(0.5);
    _addressView = addressView;
   
    
    //需要跳转第三方地址
    UILabel * storeLabel = [[UILabel alloc]init];
    storeLabel.text = @"门   店:";
    storeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    storeLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
    storeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:storeLabel];
    _storeLabel = storeLabel;
    
    storeLabel.sd_layout.leftEqualToView(addressView).topSpaceToView(addressView, Height_Real(14)).widthIs(Width_Real(60)).heightIs(Height_Real(21));
    
    UIButton * storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [storeBtn setTitle:@"海西石材城" forState:UIControlStateNormal];
    storeBtn.titleLabel.numberOfLines = 0;
    [storeBtn addTarget:self action:@selector(showStoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [storeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    storeBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    storeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:storeBtn];
    _storeBtn = storeBtn;
    
    storeBtn.sd_layout.leftSpaceToView(storeLabel, Width_Real(12)).topSpaceToView(addressView, Height_Real(14)).heightIs(Height_Real(20)).rightSpaceToView(self, Width_Real(65));
    
//    _height += Height_Real(14) + Height_Real(20);
    
    
    
    //几家
    UILabel * storeNumberLabel = [[UILabel alloc]init];
    storeNumberLabel.text = @"1";
    storeNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    storeNumberLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
    storeNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:storeNumberLabel];
    
    storeNumberLabel.sd_layout.rightSpaceToView(self, Width_Real(42)).widthIs(Width_Real(23)).heightEqualToWidth().topSpaceToView(addressView, Height_Real(14));
    _storeNumberLabel = storeNumberLabel;
    
    //方向图片
    UIImageView * storeImage = [[UIImageView alloc]init];
    storeImage.image = [UIImage imageNamed:@"system-moreb"];
    [self addSubview:storeImage];
    
    storeImage.sd_layout.rightSpaceToView(self, Width_Real(24)).widthIs(Width_Real(5)).heightIs(Height_Real(10)).topSpaceToView(addressView, Height_Real(20));
    
    _storeImage = storeImage;
    
    
    
    UIView * BcMidView = [[UIView alloc]init];
    BcMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.5];
    [self addSubview:BcMidView];
    _bcMidView = BcMidView;
    
    _bcMidView.sd_layout.leftEqualToView(addressLabel).rightEqualToView(addressBtn).topSpaceToView(storeLabel, Height_Real(14.5)).heightIs(Height_Real(0.5));
    
    UILabel * bcLabel = [[UILabel alloc]init];
    bcLabel.text = @"经营许可证:";
    bcLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    bcLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
    bcLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:bcLabel];
    _bcLabel = bcLabel;
    _bcLabel.sd_layout.leftEqualToView(BcMidView).topSpaceToView(_bcMidView, Height_Real(14.5)).widthIs(Width_Real(100)).heightIs(Height_Real(21));
    
    UIView * bcView = [[UIView alloc]init];
    bcView.backgroundColor = UIColor.whiteColor;
    [self addSubview:bcView];
    _bcView = bcView;
    _bcView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(_bcLabel, 0).heightIs(84);
    
    UIScrollView * BCScrollview = [[UIScrollView alloc]init];
    BCScrollview.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [bcView addSubview:BCScrollview];
    _bcScrollView = BCScrollview;
    
    BCScrollview.sd_layout.leftSpaceToView(_bcView, 8).rightSpaceToView(_bcView, 0).topSpaceToView(_bcView, 12).heightIs(60);
    
    
    
    UIView * storeView = [[UIView alloc]init];
    storeView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE" alpha:1];
    [self addSubview:storeView];
    _storeView = storeView;
    //storeLabel
    
    storeView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(_bcView, 0).heightIs(Height_Real(10));
    
//    _height += Height_Real(14) + Height_Real(10);
    
    //    74 + companyProductLabelHieght + 237 +  + self.linkIntrodcutHeight + 查看更多高度距离上面高度 +  查看更多按钮高度  + 179.5
    //门店
    [self setupAutoHeightWithBottomView:storeView bottomMargin:0];
}



- (void)BCPitrueContent:(NSMutableArray *)pitures{
    for (UIView * view in self.bcScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < pitures.count; i++) {
        UIImageView * img = [[UIImageView alloc]init];
        int mid = 8;
        if (i == 0){
            mid = 16;
        }else{
            mid = 8;
        }
        img.frame = CGRectMake(i * 8 + i * 90 + 8, 0, 90, 60);
//        img.image = [UIImage imageNamed:@"背景"];
        NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
        RSBusinessLicenseListModel * model = pitures[i];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.url]] placeholderImage:[UIImage imageNamed:@"01"]];
        img.userInteractionEnabled = YES;
        img.tag = i;
        img.layer.cornerRadius = 2;
        img.layer.masksToBounds = true;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpShowBigPirtrue:)];
        [img addGestureRecognizer:tap];
        [_bcScrollView addSubview:img];
    }
    _bcScrollView.contentSize = CGSizeMake((pitures.count + 1) * 8  + pitures.count * 90 , 0);
}


//点击大图
- (void)jumpShowBigPirtrue:(UITapGestureRecognizer *)tap{
    NSLog(@"======%ld",tap.view.tag);
    if ([self.delegate respondsToSelector:@selector(showPitrueArray:andTag:)]){
        [self.delegate showPitrueArray:_bcPitrueArray andTag:tap.view.tag];
    }
}



#pragma mark 查看更多
- (void)moreAction:(UIButton *)moreBtn{
    moreBtn.selected = !moreBtn.selected;
//    CGFloat linkLabelHeight = [self getHeightLineWithString:_linkLabel.text withWidth:SCW - Width_Real(32) withFont:[UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular]];
    //这边要去判读是收起还是全文
    if (!moreBtn.selected) {
        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        
        _linkLabel.sd_layout.leftEqualToView(_companyIntroductionLabel).rightSpaceToView(self, Width_Real(16)).heightIs(Height_Real(50)).topSpaceToView(_companyIntroductionLabel, Height_Real(12));
        _height += Height_Real(50) - self.linkIntrodcutHeight;
    }else{
        
        _linkLabel.sd_layout.leftEqualToView(_companyIntroductionLabel).rightSpaceToView(self, Width_Real(16)).heightIs(self.linkIntrodcutHeight).topSpaceToView(_companyIntroductionLabel, Height_Real(12));
        _height += self.linkIntrodcutHeight - Height_Real(50);
        [moreBtn setTitle:@"收取" forState:UIControlStateNormal];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(moreCheckBtnSelectStatus:andHeight:isCollection:)]) {
        [self.delegate moreCheckBtnSelectStatus:moreBtn.selected andHeight:self.height isCollection:0];
    }
}

#pragma mark 跳转地址
- (void)addressAction:(UIButton *)addressBtn{
    if ([self.delegate respondsToSelector:@selector(jumpCompanyAddressActionDestination:andLat:andLon:)]) {
        [self.delegate jumpCompanyAddressActionDestination:self.sccompanyHeaderModel.address andLat:[NSString stringWithFormat:@"%lf",self.sccompanyHeaderModel.location.lat] andLon:[NSString stringWithFormat:@"%lf",self.sccompanyHeaderModel.location.lon]];
    }
}

#pragma mark 门店多个情况
- (void)showStoreAction:(UIButton *)storeBtn{
    if ([self.delegate respondsToSelector:@selector(showStoreContentWithArray:andType:)]) {
        [self.delegate showStoreContentWithArray:self.sccompanyHeaderModel.enterpriseStoreList andType:@"3"];
    }
}


#pragma mark 打电话
- (void)playCall:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(showStoreContentWithArray:andType:)]) {
        [self.delegate showStoreContentWithArray:self.sccompanyHeaderModel.enterpriseManList andType:@"4"];
    }
    
//    NSString * phone = @"";
//    if (btn.tag == 1) {
//        phone = self.sccompanyHeaderModel.contactNumber1;
//    }else
//    {
//        phone = self.sccompanyHeaderModel.contactNumber2;
//    }
//    if (phone.length > 0) {
//        UIWebView *webview = [[UIWebView alloc]init];
//        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone]]]];
//        [self addSubview:webview];
//    }else{
//        [SVProgressHUD showInfoWithStatus:@"请输入完成的电话号码"];
//    }
}


#pragma mark 字符串高度
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font{
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, MAXFLOAT);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:Width_Real(0)];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}


- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel{
    if (link.linkType == 1) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:linkText]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
        }
    }else if (link.linkType == 2){
        NSMutableString *  phoneMutableStr = [[NSMutableString alloc] initWithFormat:@"tel:%@",linkText];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneMutableStr]];
    }else if (link.linkType == 3){
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:linkText]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
        }
    }
}


@end
