//
//  RSCargoHeaderView.m
//  石来石往
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCargoHeaderView.h"
#import "RSOwerLinkManModel.h"


@interface RSCargoHeaderView ()

@property (nonatomic,strong) UIImageView * backgroundImage;

@property (nonatomic,strong)UIImageView * touImage;


//BCMidView 经营许可证分割服
@property (nonatomic,strong)UIView * bcMidView;
@property (nonatomic,strong)UILabel * bcLabel;
//显示经营证书
@property (nonatomic,strong)UIScrollView * bcScrollView;
//证书数组
@property (nonatomic,strong)NSMutableArray * bcPitrueArray;

@property (nonatomic,strong)UIView * bcView;
@end



@implementation RSCargoHeaderView



- (instancetype)initWithErpCodeStr:(NSString *)erpCodeStr andUserIDStr:(NSString *)userIDstr andUserModel:(RSUserModel *)usermodel{
    if (self = [super init]) {
        _erpCodeStr = erpCodeStr;
        _userIDStr = userIDstr;
        _usermodel = usermodel;
        [self loadHeadData];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changContacts) name:@"changContacts" object:nil];
    }
    return self;
}


- (instancetype)initWithErpCodeStr:(NSString *)erpCodeStr andUserIDStr:(NSString *)userIDstr andUserModel:(RSUserModel *)usermodel andDataSoure:(NSString *)dataSoure{
    if (self = [super init]) {
        _erpCodeStr = erpCodeStr;
        _userIDStr = userIDstr;
        _usermodel = usermodel;
        _dataSoure = dataSoure;
        [self loadHeadData];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changContacts) name:@"changContacts" object:nil];
    }
    return self;
}




- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        //[self loadHeadData];
        
    }
    return self;
}


- (void)setUI:(RSMyRingModel *)mymodel{
    
    
    //总的界面
    UIView * contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self addSubview:contentView];
    contentView.userInteractionEnabled = YES;
    
    
    //背景图片视图
    UIImageView * backgroundImage = [[UIImageView alloc]init];
    //backgroundImage.image = [UIImage imageNamed:@"720-450"];
    
    
    
   // NSString * imageStr = [NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,mymodel.backgroundImgUrl];
   // NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"%@",imageStr]];
   // backgroundImage.image = [UIImage imageWithData:data];
    
    [backgroundImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,mymodel.backgroundImgUrl]] placeholderImage:[UIImage imageNamed:@"720-450"]];
    _backgroundImage = backgroundImage;
    
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImage.clipsToBounds=YES;
    
    
    /**
     
     [oweImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.mymodel.backgroundImgUrl]] placeholderImage:[UIImage imageNamed:@"beijing"]];
     
     */
    
    [contentView addSubview:backgroundImage];
    backgroundImage.tag = 0;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundChangImage:)];
    [backgroundImage addGestureRecognizer:tap];
    backgroundImage.userInteractionEnabled = YES;
    
    
    
    //轻触设置相册封面
    UIImageView * attetionImageView = [[UIImageView alloc]init];
    attetionImageView.image = [UIImage imageNamed:@"轻触设置相册封面"];
    attetionImageView.contentMode = UIViewContentModeScaleAspectFill;
    attetionImageView.clipsToBounds = YES;
    [contentView addSubview:attetionImageView];
    [attetionImageView bringSubviewToFront:contentView];
    _attetionImageView = attetionImageView;
    if (![mymodel.backgroundImgUrl isEqualToString:@""]) {
        _attetionImageView.hidden = YES;
    }else{
        _attetionImageView.hidden = NO;
    }
    
    
    //返回
    UIButton * backImageBtn = [[UIButton alloc]init];
    //backImageBtn.image = [UIImage imageNamed:@"返回"];
    //backImageBtn.alpha = 0.5;
    [backImageBtn setImage:[UIImage imageNamed:@"上一页"] forState:UIControlStateNormal];
    backImageBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 11, 6, 11);
    [backImageBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000" alpha:0.5]];
    [backImageBtn addTarget:self action:@selector(backUpViewController:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImage addSubview:backImageBtn];
   // backImageBtn.userInteractionEnabled = YES;
    //backImage.contentMode = UIViewContentModeScaleAspectFill;
    //[backgroundImage addSubview:backImage];
   // UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backUpViewController:)];
    //[backImage addGestureRecognizer:tap4];
    
    
    //背景图片下面的视图
    UIView * backgroundNextView = [[UIView alloc]init];
    backgroundNextView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:backgroundNextView];
    
    
    UIImageView * touImage = [[UIImageView alloc]init];
    //touImage.image = [UIImage imageNamed:@"logo"];
    _touImage = touImage;
    [touImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,mymodel.ownerLogo]] placeholderImage:[UIImage imageNamed:@"logo"]];
    touImage.tag = 1;
    touImage.contentMode = UIViewContentModeScaleAspectFill;
    touImage.clipsToBounds=YES;
    [contentView addSubview:touImage];
    [touImage bringSubviewToFront:contentView];
    touImage.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touChangeImage:)];
    [touImage addGestureRecognizer:tap1];
    touImage.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    //中间视图的文字
    UILabel * centerNameLabel = [[UILabel alloc]init];
    centerNameLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    //centerNameLabel.text = @"海西石材城";
    centerNameLabel.text = [NSString stringWithFormat:@"%@",mymodel.ownerName];
    centerNameLabel.font = [UIFont systemFontOfSize:17];
    centerNameLabel.textAlignment = NSTextAlignmentRight;
    //centerNameLabel.userInteractionEnabled = YES;
    [contentView addSubview:centerNameLabel];
    [centerNameLabel bringSubviewToFront:contentView];
    
    
    
    //库存状态
    UILabel * stockStatusLabel = [[UILabel alloc]init];
    stockStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    stockStatusLabel.text = @"库存状态";
    UIFont * font1 = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    stockStatusLabel.font = font1;
    stockStatusLabel.textAlignment = NSTextAlignmentLeft;
    [backgroundNextView addSubview:stockStatusLabel];
    
    
    
    
    //中间视图的俩个按键
    UIView * huangView = [[UIView alloc]init];
    huangView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [backgroundNextView addSubview:huangView];
    //[huangView bringSubviewToFront:centerView];
    huangView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer * tap2  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(huangviewChangeAction:)];
    [huangView addGestureRecognizer:tap2];
    
    
    
    //荒料图片
    UIImageView * huangliaoImageView = [[UIImageView alloc]init];
    huangliaoImageView.contentMode = UIViewContentModeScaleAspectFill;
    huangliaoImageView.clipsToBounds = YES;
    huangliaoImageView.image = [UIImage imageNamed:@"荒料商圈"];
    [huangView addSubview:huangliaoImageView];
    
    
    UILabel * huangDataLabel = [[UILabel alloc]init];
    huangDataLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    //huangDataLabel.text = @"0.000m³";
  
    huangDataLabel.font = [UIFont systemFontOfSize:15];
    huangDataLabel.textAlignment = NSTextAlignmentLeft;
    [huangView addSubview:huangDataLabel];
    huangDataLabel.userInteractionEnabled =YES;
    
    
    UILabel * huangLabel = [[UILabel alloc]init];
    huangLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    huangLabel.text = @"荒料";
    huangLabel.font = [UIFont systemFontOfSize:12];
    huangLabel.textAlignment = NSTextAlignmentLeft;
    [huangView addSubview:huangLabel];
    huangLabel.userInteractionEnabled =YES;
    
//    UILabel * label = [[UILabel alloc]init];
//    label.text = @"-----";
//    label.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//    label.font = [UIFont systemFontOfSize:14];
//    label.transform=CGAffineTransformMakeRotation(M_PI/2);
//    [backgroundNextView addSubview:label];
    
    UIView * dabanView = [[UIView alloc]init];
    //[dabanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    dabanView.userInteractionEnabled = YES;
    dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [backgroundNextView addSubview:dabanView];
  //  [dabanView bringSubviewToFront:centerView];
    
    UITapGestureRecognizer * tap3  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dabanviewChangeAction:)];
    [dabanView addGestureRecognizer:tap3];
    
    
    //大板图片
    UIImageView * dabanImageView = [[UIImageView alloc]init];
    dabanImageView.contentMode = UIViewContentModeScaleAspectFill;
    dabanImageView.clipsToBounds = YES;
    dabanImageView.image = [UIImage imageNamed:@"大板商圈"];
    [dabanView addSubview:dabanImageView];
    
    
    
    
    UILabel * dabanDataLabel = [[UILabel alloc]init];
    dabanDataLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    dabanDataLabel.text = @"20515.230㎡";
    
    dabanDataLabel.font = [UIFont systemFontOfSize:15];
    dabanDataLabel.textAlignment = NSTextAlignmentLeft;
    [dabanView addSubview:dabanDataLabel];
    dabanDataLabel.userInteractionEnabled =YES;
    
    
    
    
    UILabel * dabanLabel = [[UILabel alloc]init];
    dabanLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    dabanLabel.text = @"大板";
    dabanLabel.font = [UIFont systemFontOfSize:12];
    dabanLabel.textAlignment = NSTextAlignmentLeft;
    [dabanView addSubview:dabanLabel];
    dabanLabel.userInteractionEnabled =YES;
    
    if (iPhone4 || iPhone5) {
        huangDataLabel.text = [NSString stringWithFormat:@"%0.1fm³",mymodel.blockNum];
        dabanDataLabel.text = [NSString stringWithFormat:@"%0.1fm²",mymodel.slabNum];
    }else{
        huangDataLabel.text = [NSString stringWithFormat:@"%0.3fm³",mymodel.blockNum];
        dabanDataLabel.text = [NSString stringWithFormat:@"%0.3fm²",mymodel.slabNum];
    }
    
    
    //下面的视图
    UIView * nextView = [[UIView alloc]init];
    nextView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:nextView];
    
    //联系电话
    UILabel * contactNumberLabel = [[UILabel alloc]init];
    contactNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    contactNumberLabel.text = @"联系电话";
    UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    contactNumberLabel.font = font;
    contactNumberLabel.textAlignment = NSTextAlignmentLeft;
    [nextView addSubview:contactNumberLabel];
    
    
    //联系电话下面的横线
    UIView * contactNumberView = [[UIView alloc]init];
    contactNumberView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [nextView addSubview:contactNumberView];
    
    //联系电话横线下面的视图
    UIView * numberView = [[UIView alloc]init];
    //[numberView setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    numberView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [nextView addSubview:numberView];
    numberView.userInteractionEnabled = YES;
    //UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contactNumberChangeAddress:)];
    //[numberView addGestureRecognizer:tap5];
    
    
    
    UIButton * contactBtn = [[UIButton alloc]init];
    [contactBtn setBackgroundColor:[UIColor whiteColor]];
    [numberView addSubview:contactBtn];
    contactBtn.tag = 1;
    [contactBtn addTarget:self action:@selector(contactNumberChangeAddress:) forControlEvents:UIControlEventTouchUpInside];
    

    //上面显示的图片和文字
    UIImageView * contactImage = [[UIImageView alloc]init];
    contactImage.image = [UIImage imageNamed:@"联系人信息"];
    [contactBtn addSubview:contactImage];
    
    
    UILabel * contactLabel = [[UILabel alloc]init];
    contactLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    //contactLabel.text = @"海西石材城 15254545888";
    if (mymodel.ownerLinkMan.count > 0) {
       RSOwerLinkManModel * owserlinkemodel = mymodel.ownerLinkMan[0];
        contactLabel.text = [NSString stringWithFormat:@"%@ %@",owserlinkemodel.ownerLinkMan,owserlinkemodel.ownerPhone];
    }
    contactLabel.font = [UIFont systemFontOfSize:15];
    contactLabel.textAlignment = NSTextAlignmentLeft;
    [contactBtn addSubview:contactLabel];
 
    
    //向右
    UIImageView * contactrightImage = [[UIImageView alloc]init];
    contactrightImage.image = [UIImage imageNamed:@"向右"];
    [contactBtn addSubview:contactrightImage];
    
    
    //联系人和地址的间隔线
    UIView * bottomContactView = [[UIView alloc]init];
    bottomContactView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [numberView addSubview:bottomContactView];
    
    
    

    UIButton * addressBtn = [[UIButton alloc]init];
    [addressBtn setBackgroundColor:[UIColor whiteColor]];
    [numberView addSubview:addressBtn];
    addressBtn.tag = 2;
    [addressBtn addTarget:self action:@selector(contactNumberChangeAddress:) forControlEvents:UIControlEventTouchUpInside];

    //下面显示的图片和文字
    UIImageView * addressImage = [[UIImageView alloc]init];
    addressImage.image = [UIImage imageNamed:@"地址"];
    [addressBtn addSubview:addressImage];
    
    
    UILabel * addressLabel = [[UILabel alloc]init];
    addressLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    //addressLabel.text = @"福建省南安市水头海西石材城";
    addressLabel.text = [NSString stringWithFormat:@"%@",mymodel.ownerAdress[0]];
    addressLabel.font = [UIFont systemFontOfSize:15];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    [addressBtn addSubview:addressLabel];
    
    //向右
    UIImageView * rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"向右"];
    [addressBtn addSubview:rightImage];
    
    
 
    
    UIView * BcMidView = [[UIView alloc]init];
    BcMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.5];
    [contentView addSubview:BcMidView];
    _bcMidView = BcMidView;
    
    
    UILabel * bcLabel = [[UILabel alloc]init];
    bcLabel.text = @"经营许可证:";
    bcLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    bcLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightRegular];
    bcLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:bcLabel];
    _bcLabel = bcLabel;
   
    
    UIView * bcView = [[UIView alloc]init];
    bcView.backgroundColor = UIColor.whiteColor;
    [contentView addSubview:bcView];
    _bcView = bcView;
 
    
    
    
    UIScrollView * BCScrollview = [[UIScrollView alloc]init];
    BCScrollview.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [bcView addSubview:BCScrollview];
    _bcScrollView = BCScrollview;
    
    
    
    
    //间隔
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F3F3F3"];
    [contentView addSubview:bottomview];
    
    //backgroundNextView
    //背景图片和下面的视图中间的视图
//    UIView * centerView = [[UIView alloc]init];
//    centerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    [contentView addSubview:centerView];
    
    
    
    contentView.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .rightSpaceToView(self, 0);
    
    backgroundImage.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(contentView, 0)
    .heightIs(250);
    
    attetionImageView.sd_layout
    .topSpaceToView(contentView, 130)
    .leftSpaceToView(contentView, 139)
    .rightSpaceToView(contentView, 140)
    .heightIs(13);
    
    
    
    backImageBtn.sd_layout
    .leftSpaceToView(backgroundImage, 8)
    .topSpaceToView(backgroundImage, 40.5)
    .widthIs(32)
    .heightEqualToWidth();
    
    backImageBtn.layer.cornerRadius = backImageBtn.yj_width * 0.5;
    backImageBtn.layer.masksToBounds = YES;
    
    
    backgroundNextView.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(backgroundImage, 0)
    .heightIs(130);
    
    
    touImage.sd_layout
    .topSpaceToView(contentView, 200)
    .widthIs(70)
    .heightEqualToWidth()
    .rightSpaceToView(contentView, 17);
    touImage.layer.cornerRadius = 7;
    touImage.layer.masksToBounds = YES;
    
    centerNameLabel.sd_layout
    .leftSpaceToView(contentView, 12)
    .topSpaceToView(contentView, 218)
    .rightSpaceToView(contentView, 96)
    .heightIs(17);
    
    stockStatusLabel.sd_layout
    .leftSpaceToView(backgroundNextView, 12)
    .topSpaceToView(backgroundNextView, 12)
    .rightSpaceToView(backgroundNextView, 12)
    .heightIs(15);
    
    huangView.sd_layout
    .leftSpaceToView(backgroundNextView, 12)
    .topSpaceToView(backgroundNextView, 40)
    .widthIs(SCW/2 - 18.5)
    .heightIs(75);
    
    huangView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
    huangView.layer.shadowOffset = CGSizeMake(0,1);
    huangView.layer.shadowOpacity = 1;
    huangView.layer.shadowRadius = 11;
    huangView.layer.cornerRadius = 5;
    
    
    huangliaoImageView.sd_layout
    .centerYEqualToView(huangView)
    .leftSpaceToView(huangView, 13)
    .widthIs(49)
    .heightEqualToWidth();
    
    
    
    huangDataLabel.sd_layout
    .leftSpaceToView(huangliaoImageView, 9)
    .rightSpaceToView(huangView, 0)
    .topSpaceToView(huangView, 24)
    .heightIs(15);
    
    huangLabel.sd_layout
    .leftEqualToView(huangDataLabel)
    .rightSpaceToView(huangView, 0)
    .topSpaceToView(huangDataLabel, 5)
    .heightIs(12);
    
    dabanView.sd_layout
    .rightSpaceToView(backgroundNextView, 12)
    .topSpaceToView(backgroundNextView, 40)
    .widthIs(SCW/2 - 18.5)
    .heightIs(75);
    
    dabanView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
    dabanView.layer.shadowOffset = CGSizeMake(0,1);
    dabanView.layer.shadowOpacity = 1;
    dabanView.layer.shadowRadius = 11;
    dabanView.layer.cornerRadius = 5;
    
    
    dabanImageView.sd_layout
    .centerYEqualToView(dabanView)
    .leftSpaceToView(dabanView, 13)
    .widthIs(49)
    .heightEqualToWidth();
    
    
    dabanDataLabel.sd_layout
    .leftSpaceToView(dabanImageView, 9)
    .topSpaceToView(dabanView, 24)
    .rightSpaceToView(dabanView, 0)
    .heightIs(15);
    
    dabanLabel.sd_layout
    .leftEqualToView(dabanDataLabel)
    .rightSpaceToView(dabanView, 0)
    .topSpaceToView(dabanDataLabel, 5)
    .heightIs(12);
    
    
    
    
    
    
    nextView.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(backgroundNextView, 0)
    .bottomSpaceToView(contentView, 138.5);
    

    
    contactNumberLabel.sd_layout
    .leftSpaceToView(nextView, 10)
    .topSpaceToView(nextView, 0)
    .rightSpaceToView(nextView, 0)
    .heightIs(30);
    
    contactNumberView.sd_layout
    .leftSpaceToView(nextView, 0)
    .rightSpaceToView(nextView, 0)
    .topSpaceToView(contactNumberLabel, 0)
    .heightIs(1);
    
    numberView.sd_layout
    .leftSpaceToView(nextView, 0)
    .rightSpaceToView(nextView, 0)
    .topSpaceToView(contactNumberView, 0)
    .bottomSpaceToView(nextView, 0);
    
    
    contactBtn.sd_layout
    .leftSpaceToView(numberView, 0)
    .topSpaceToView(numberView, 0)
    .rightSpaceToView(numberView, 0)
    .heightIs(40);
    
    
    bottomContactView.sd_layout
    .leftSpaceToView(numberView, 13)
    .rightSpaceToView(numberView, 0)
    .topSpaceToView(contactBtn, 0)
    .heightIs(1);
    
    
    addressBtn.sd_layout
    .leftSpaceToView(numberView, 0)
    .rightSpaceToView(numberView, 0)
    .bottomSpaceToView(numberView, 0)
    .topSpaceToView(bottomContactView, 0);
    
    
    contactImage.sd_layout
    .leftSpaceToView(contactBtn, 8.5)
    .centerYEqualToView(contactBtn)
    .widthIs(14)
    .heightEqualToWidth();
    
    contactLabel.sd_layout
    .leftSpaceToView(contactImage, 7)
    .topSpaceToView(contactBtn, 0)
    .bottomSpaceToView(contactBtn, 0)
    .widthRatioToView(contactBtn, 0.8);
    
    
    contactrightImage.sd_layout
    .centerYEqualToView(contactBtn)
    .rightSpaceToView(contactBtn, 16.5)
    .widthIs(20)
    .heightIs(20);
    
    
    
    
    addressImage.sd_layout
    .leftEqualToView(contactImage)
    .centerYEqualToView(addressBtn)
    .widthIs(14)
    .heightEqualToWidth();
    
    addressLabel.sd_layout
    .leftEqualToView(contactLabel)
    .widthRatioToView(addressBtn, 0.8)
    .topSpaceToView(addressBtn, 0)
    .bottomSpaceToView(addressBtn, 0);
    
    
    _bcMidView.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 0).topSpaceToView(nextView,0).heightIs(Height_Real(0.5));
    _bcLabel.sd_layout.leftEqualToView(_bcMidView).topSpaceToView(_bcMidView, Height_Real(14.5)).widthIs(Width_Real(100)).heightIs(Height_Real(21));
    
    _bcView.sd_layout.leftSpaceToView(contentView, 0).rightSpaceToView(contentView, 0).topSpaceToView(_bcLabel, 0).heightIs(84);

    
    BCScrollview.sd_layout.leftSpaceToView(_bcView, 8).rightSpaceToView(_bcView, 0).topSpaceToView(_bcView, 12).heightIs(60);
    
    
    
    rightImage.sd_layout
    .centerYEqualToView(addressBtn)
    .rightSpaceToView(addressBtn, 16.5)
    .widthIs(20)
    .heightIs(20);
    
    
    if ([self.dataSoure isEqualToString:@"DZYC"]) {
        addressBtn.hidden = YES;
        addressImage.hidden = YES;
        addressLabel.hidden = YES;
        rightImage.hidden = YES;
    }else{
        addressBtn.hidden = NO;
        addressImage.hidden = NO;
        addressLabel.hidden = NO;
        rightImage.hidden = NO;
    }
    
    bottomview.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(_bcView, 0)
    .bottomSpaceToView(contentView, 0);
    
//    centerView.sd_layout
//    .centerXEqualToView(contentView)
//    .leftSpaceToView(contentView, 31)
//    .rightSpaceToView(contentView, 31)
//    .heightIs(109)
//    .bottomSpaceToView(backgroundNextView, -54.5);
//    centerView.layer.cornerRadius = 6;
//    centerView.layer.masksToBounds = YES;
    
    
    
//    label.sd_layout
//    .centerXEqualToView(centerView)
//    .leftSpaceToView(huangView, 0)
//    .rightSpaceToView(dabanView, 0)
//    .topSpaceToView(centerNameLabel, 15)
//    .bottomSpaceToView(centerView, 10);
}






#pragma mark -- 获取上半部分的数据
- (void)loadHeadData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if ([self.dataSoure isEqualToString:@"DZYC"]) {
         [dict setObject:self.dataSoure forKey:@"dataSource"];
    }
    [dict setObject:self.erpCodeStr forKey:@"erpCode"];
    [dict setObject:self.userIDStr forKey:@"userId"];
    [dict setObject:@"1" forKey:@"version"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    //URL_HEADER_MY_QUAN_IOS
    //NSString * str = @"http://192.168.1.139:8080/slsw/hzpage.do";
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    NSLog(@"=====================%@",parameters);
    [network getDataWithUrlString:URL_HEADER_MY_QUAN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            NSLog(@"===========2323===========%@",json);
            if (Result) {
                NSMutableArray * array = nil;
                array = json[@"Data"];
                for (int n = 0; n < array.count; n++) {
                    RSMyRingModel * mymodel = [[RSMyRingModel alloc]init];
                    mymodel.ERP_USER_CODE = [[array objectAtIndex:n]objectForKey:@"ERP_USER_CODE"];
                    mymodel.backgroundImgUrl = [[array objectAtIndex:n]objectForKey:@"backgroundImgUrl"];
                    mymodel.blockNum = [[[array objectAtIndex:n]objectForKey:@"blockNum"] doubleValue];
                    mymodel.ownerAdress = [[array objectAtIndex:n]objectForKey:@"ownerAdress"];
                    //mymodel.ownerLinkMan = [[array objectAtIndex:n]objectForKey:@"ownerLinkMan"];
                    NSMutableArray * temp = [NSMutableArray array];
                    temp = [[array objectAtIndex:n]objectForKey:@"ownerLinkMan"];
                    for (int i = 0; i < temp.count; i++) {
                        RSOwerLinkManModel *  owerlinkmanmodel = [[RSOwerLinkManModel alloc]init];
                        owerlinkmanmodel.ownerLinkMan = [[temp objectAtIndex:i]objectForKey:@"ownerLinkMan"];
                        owerlinkmanmodel.ownerPhone = [[temp objectAtIndex:i]objectForKey:@"ownerPhone"];
                        [mymodel.ownerLinkMan addObject:owerlinkmanmodel];
                    }
                    
//                    weakSelf.bcPitrueArray = [array objectAtIndex:n]
                    weakSelf.bcPitrueArray = [RSBusinessLicenseListModel mj_objectArrayWithKeyValuesArray:[[array objectAtIndex:n]objectForKey:@"businessLicenseList"]];
                    
                    mymodel.ownerLogo = [[array objectAtIndex:n]objectForKey:@"ownerLogo"];
                    mymodel.ownerName = [[array objectAtIndex:n]objectForKey:@"ownerName"];
                    mymodel.ownerPhone = [[array objectAtIndex:n]objectForKey:@"ownerPhone"];
                    
                    mymodel.slabNum = [[[array objectAtIndex:n]objectForKey:@"slabNum"] doubleValue];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.mymodel = mymodel;
                        [weakSelf setUI:mymodel];

//                        weakSelf.bcPitrueArray = @[@"民生logo",@"民生logo",@"民生logo",@"民生logo",@"民生logo"];
                        
                        NSLog(@"===========2323===========%ld",weakSelf.bcPitrueArray.count);
                        
                        [weakSelf BCPitrueContent:weakSelf.bcPitrueArray];
                    });
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
        }
    }];
}



- (void)BCPitrueContent:(NSMutableArray *)pitures{
    for (UIView * view in self.bcScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < pitures.count; i++) {
        UIImageView * img = [[UIImageView alloc]init];
        img.frame = CGRectMake( i * 8 + i * 90 + 8, 0, 90, 60);
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
    _bcScrollView.contentSize = CGSizeMake((pitures.count + 1) * 8 + pitures.count * 90 , 0);
}

- (void)jumpShowBigPirtrue:(UITapGestureRecognizer *)tap{
//    NSLog(@"============%d",tap.view.tag);
    if ([self.cargodelegate respondsToSelector:@selector(showPitrueArray:andTag:)]){
        [self.cargodelegate showPitrueArray:_bcPitrueArray andTag:tap.view.tag];
    }
    
}

//FIXME:背景图片更换
- (void)backgroundChangImage:(UITapGestureRecognizer *)tap{
    if ([self.cargodelegate respondsToSelector:@selector(changBackgroundImageUserModel:andRSMyRingModel:andTag:andUImageView:)]) {
        [self.cargodelegate changBackgroundImageUserModel:self.usermodel andRSMyRingModel:self.mymodel andTag:self.backgroundImage.tag andUImageView:self.backgroundImage];
    }
}
//FIXME:头像图片更改
- (void)touChangeImage:(UITapGestureRecognizer *)tap1{
    if ([self.cargodelegate respondsToSelector:@selector(changBackgroundImageUserModel:andRSMyRingModel:andTag:andUImageView:)]) {
        [self.cargodelegate changBackgroundImageUserModel:self.usermodel andRSMyRingModel:self.mymodel andTag:self.touImage.tag andUImageView:self.touImage];
    }
}
//FIXME:荒料
- (void)huangviewChangeAction:(UITapGestureRecognizer *)tap2{
    
    if ([self.dataSoure isEqualToString:@"DZYC"]) {
        if ([self.cargodelegate respondsToSelector:@selector(jumpHuangTitleNameLabel:andTyle:andErpCodeStr:andUserModel:andDataSoure:)]) {
            [self.cargodelegate jumpHuangTitleNameLabel:[NSString stringWithFormat:@"%@--荒料汇总",self.mymodel.ownerName] andTyle:@"huangliao" andErpCodeStr:self.mymodel.ERP_USER_CODE andUserModel:self.usermodel andDataSoure:self.dataSoure];
        }
    }else{
        if ([self.cargodelegate respondsToSelector:@selector(jumpHuangTitleNameLabel:andTyle:andErpCodeStr:andUserModel:)]) {
            [self.cargodelegate jumpHuangTitleNameLabel:[NSString stringWithFormat:@"%@--荒料汇总",self.mymodel.ownerName] andTyle:@"huangliao" andErpCodeStr:self.mymodel.ERP_USER_CODE andUserModel:self.usermodel];
        }
    }
}
//FIXME:大板
- (void)dabanviewChangeAction:(UITapGestureRecognizer *)tap3{
    if ([self.dataSoure isEqualToString:@"DZYC"]) {
        if ([self.cargodelegate respondsToSelector:@selector(jumpDabanTitleNameLabel:andTyle:andErpCodeStr:andUserModel:andDataSoure:)]) {
            [self.cargodelegate jumpDabanTitleNameLabel:[NSString stringWithFormat:@"%@--大板汇总",self.mymodel.ownerName] andTyle:@"daban" andErpCodeStr:self.mymodel.ERP_USER_CODE andUserModel:self.usermodel andDataSoure:self.dataSoure];
        }
    }else{
        if ([self.cargodelegate respondsToSelector:@selector(jumpDabanTitleNameLabel:andTyle:andErpCodeStr:andUserModel:)]) {
            [self.cargodelegate jumpDabanTitleNameLabel:[NSString stringWithFormat:@"%@--大板汇总",self.mymodel.ownerName] andTyle:@"daban" andErpCodeStr:self.mymodel.ERP_USER_CODE andUserModel:self.usermodel];
        }
    }
}
//FIXME:返回上一个界面
- (void)backUpViewController:(UIButton *)btn{
    if ([self.cargodelegate respondsToSelector:@selector(backUp)]) {
        [self.cargodelegate backUp];
    }
}

//FIXME:进入地址和联系人
- (void)contactNumberChangeAddress:(UIButton *)btn{
    if ([self.cargodelegate respondsToSelector:@selector(jumpAddressAndMyRingModel:andSelectype:andUsermodel:)]) {
        if (btn.tag == 1) {
            [self.cargodelegate jumpAddressAndMyRingModel:self.mymodel andSelectype:@"1" andUsermodel:self.usermodel];
        }else{
            [self.cargodelegate jumpAddressAndMyRingModel:self.mymodel andSelectype:@"2" andUsermodel:self.usermodel];
        }
    }
}


- (void)changContacts{
    [self loadHeadData];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
