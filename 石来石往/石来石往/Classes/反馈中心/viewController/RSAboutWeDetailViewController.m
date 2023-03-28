//
//  RSAboutWeDetailViewController.m
//  石来石往
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAboutWeDetailViewController.h"
#import "RSUserInformationViewController.h"



@interface RSAboutWeDetailViewController ()


/**版本视图*/
@property (nonatomic,strong)UIView * versionView;

/**描述视图*/
@property (nonatomic,strong)UIView * describeView;


@end

@implementation RSAboutWeDetailViewController


- (UIView *)versionView{
    if (!_versionView) {
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
        _versionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 180)];
        _versionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _versionView;
}

- (UIView *)describeView{
    if (!_describeView) {
        _describeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.versionView.frame), SCW, SCH - 180 - Height_NavBar)];
        _describeView.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    }
    return _describeView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.title = @"关于我们";
    
    
    [self.view addSubview:self.versionView];
    
    
    UIImageView * logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 32.5, 25, 65, 65)];
    logoImage.image = [UIImage imageNamed:@"logo"];
    logoImage.contentMode =  UIViewContentModeScaleAspectFill;
    [self.versionView addSubview:logoImage];
    
    
    UILabel * versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW/2 - 50, CGRectGetMaxY(logoImage.frame) + 10, 70, 15)];
    versionLabel.textAlignment = NSTextAlignmentLeft;
    versionLabel.text = @"最新版本";
    versionLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    versionLabel.font = [UIFont systemFontOfSize:15];
    [self.versionView addSubview:versionLabel];
    
    
    UILabel * versionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(versionLabel.frame), CGRectGetMaxY(logoImage.frame) + 10, 40, 15)];
    //versionTitleLabel.text = @"2.2.0";
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //当前版本号
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    versionTitleLabel.text = currentVersion;
    versionTitleLabel.textAlignment = NSTextAlignmentLeft;
    versionTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    versionTitleLabel.font = [UIFont systemFontOfSize:15];
    [self.versionView addSubview:versionTitleLabel];
    
    
    
    UIImageView * titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 60, CGRectGetMaxY(versionTitleLabel.frame) + 10, 120, 40)];
    titleImage.image = [UIImage imageNamed:@"石来石往"];
    titleImage.contentMode =  UIViewContentModeScaleAspectFill;
    [self.versionView addSubview:titleImage];
    
    
    
    
    [self.view addSubview:self.describeView];
    
 
    NSString * text = @"           石来石往，是由厦门瑞石信息科技有\n    限公司研发推出，该APP分为货主功能与\n    游客功能。\n           货主功能是专为石材市场与商户量身\n    定制的全新一站式移动智能办公管理系\n    统!游客功能主要针对石材买家现货查\n    询,供求查询，社交服务等为一体的信息\n    服务平台\n           适合对象:石材市场，石材企业，石\n    材买家等";
    NSRange allRange = [text rangeOfString:text];
    
    
    
    NSMutableParagraphStyle *tempParagraph = [[NSMutableParagraphStyle alloc] init];
    tempParagraph.lineSpacing = 3;
    tempParagraph.firstLineHeadIndent = 3;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#333333"],NSParagraphStyleAttributeName:tempParagraph} range:allRange];
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(SCW - 24, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    UILabel *lbTemp =[[UILabel alloc] init];
    lbTemp.frame = CGRectMake(SCW/2 - (SCW * 0.8)/2, 20, SCW * 0.8, rect.size.height);
    lbTemp.lineBreakMode =  NSLineBreakByCharWrapping;
    lbTemp.backgroundColor = [UIColor clearColor];
    lbTemp.numberOfLines = 0;
    lbTemp.attributedText = attrStr;
    lbTemp.textAlignment = NSTextAlignmentLeft;
    [self.describeView addSubview:lbTemp];
    
    
    
    
    UIButton * userProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userProtocolBtn setTitle:@"用户协议指引" forState:UIControlStateNormal];
    userProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    userProtocolBtn.tag = 0;
    [userProtocolBtn addTarget:self action:@selector(jumpInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    [userProtocolBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    userProtocolBtn.frame = CGRectMake(SCW/2 - 70, SCH - CGRectGetMaxY(self.versionView.frame) - 250, 140, 30);
    [self.describeView addSubview:userProtocolBtn];
    
    
    
    UILabel * andLabel = [[UILabel alloc]init];
    andLabel.text = @"和";
    andLabel.textAlignment = NSTextAlignmentCenter;
    andLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    andLabel.font = [UIFont systemFontOfSize:14];
    andLabel.frame = CGRectMake(0, CGRectGetMaxY(userProtocolBtn.frame), SCW, 20);
    [self.describeView addSubview:andLabel];
    
    
    
    
    UIButton * userPrivacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userPrivacyBtn setTitle:@"隐私政策指引" forState:UIControlStateNormal];
    userPrivacyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    userPrivacyBtn.tag = 1;
    [userPrivacyBtn addTarget:self action:@selector(jumpInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    [userPrivacyBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    userPrivacyBtn.frame = CGRectMake(SCW/2 - 70, CGRectGetMaxY(andLabel.frame), 140, 30);
    [self.describeView addSubview:userPrivacyBtn];
    
    
    
    UILabel * companyLabel = [[UILabel alloc]init];
    companyLabel.text = @"瑞石信息科技有限公司 版权所有";
    companyLabel.textAlignment = NSTextAlignmentCenter;
    companyLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    companyLabel.font = [UIFont systemFontOfSize:14];
    companyLabel.frame = CGRectMake(0, CGRectGetMaxY(userPrivacyBtn.frame) + 20, SCW, 20);
    [self.describeView addSubview:companyLabel];
    
    
    
}


-(void)jumpInformationAction:(UIButton *)jumpBtn{
    NSString * str = [NSString string];
     RSUserInformationViewController * userInformationVc = [[RSUserInformationViewController alloc]init];
    if (jumpBtn.tag == 0) {
      //用户
        str = @"https://www.slsw.link/slsw/UserAgreement.jsp";
        userInformationVc.title = @"用户协议指引";
    }else{
     //隐私
        str = @"https://www.slsw.link/slsw/agreement.jsp";
        userInformationVc.title = @"隐私政策指引";
    }
    userInformationVc.urlStr = str;
    [self.navigationController pushViewController:userInformationVc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
