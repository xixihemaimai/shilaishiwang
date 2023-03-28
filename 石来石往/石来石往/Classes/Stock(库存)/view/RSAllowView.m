//
//  RSAllowView.m
//  石来石往
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAllowView.h"
@interface RSAllowView ()<UITextViewDelegate>

@property (nonatomic,assign)CGFloat height;

@end

@implementation RSAllowView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        UIView *menView = [[UIView alloc]initWithFrame:self.bounds];
        menView.backgroundColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:0.5];
        [self addSubview:menView];
        
        //最外层视图
        UIView * allowArgeeView = [[UIView alloc]initWithFrame:CGRectMake(12, (SCH/2)/2 , CGRectGetWidth(menView.frame) - 24, SCH/2)];
        allowArgeeView.backgroundColor = [UIColor whiteColor];
        //allowArgeeView.userInteractionEnabled = YES;
        [menView addSubview:allowArgeeView];
        allowArgeeView.layer.cornerRadius = 10;
        allowArgeeView.layer.masksToBounds = YES;
    
        
        //标题
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(allowArgeeView.frame), 50)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.text = @"石来石往货主版使用权限";
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [allowArgeeView addSubview:titleLabel];
        
        //标题和下面对的分界线
        UIView * midview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(allowArgeeView.frame), 1)];
        midview.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [allowArgeeView addSubview:midview];
        
        
        //责任方 (甲)
        UILabel * nailLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(midview.frame), CGRectGetWidth(allowArgeeView.frame) - 24, 30)];
        nailLabel.text = @"甲方:福建海西石材交易中心有限公司";
        nailLabel.textColor = [UIColor colorWithRed:112/255.0 green:162/255.0 blue:255/255.0 alpha:1.0];
        nailLabel.backgroundColor = [UIColor whiteColor];
        nailLabel.textAlignment = NSTextAlignmentLeft;
        
//        if (iPhone5 || iPhone4) {
//             nailLabel.font = [UIFont systemFontOfSize:16];
//        }else{
        nailLabel.font = [UIFont systemFontOfSize:17];
//        }
        [allowArgeeView addSubview:nailLabel];
        
        
        //责任方（乙）
        UILabel * bLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(nailLabel.frame), CGRectGetWidth(allowArgeeView.frame) -24, 30)];
        bLabel.textColor = [UIColor colorWithRed:112/255.0 green:162/255.0 blue:255/255.0 alpha:1.0];
        bLabel.textAlignment = NSTextAlignmentLeft;
        _bLabel = bLabel;
        bLabel.font = [UIFont systemFontOfSize:17];
        [allowArgeeView addSubview:bLabel];
        bLabel.backgroundColor = [UIColor whiteColor];
        

        UITextView * text = [[UITextView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(bLabel.frame) + 1, CGRectGetWidth(allowArgeeView.frame) - 24, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(bLabel.frame) - 10 - 40)];
        text.text = @"1、乙方自愿申请注册石来石往货主版，完全接受本协议并遵守甲方相关业务规则和业务规定，乙方用于注册主账户、添加子账户的手机号码信息需要与预留在甲方处用于办理荒料、大板出库的纸质授权书上授权人、被授权人信息一致。注册、变更主账户、添加子账户信息经甲方根据纸质授权书信息审核通过后有权享受相应开通服务。\n 2、乙方同意使用石来石往软件办理寄存在甲方所有出入货物手续，乙方通过石来石往软件提交的出库信息，乙方均予以承认，由此引发的一切后果由乙方自行承担。本协议自签字/盖章后当天起生效，如有更换人员，授权人将提前来甲方公司办理更换被授权人手续并取消石来石往上该人员的权限。\n 3、石来石往致力于为乙方提供文明健康、规范有序、专一的石材供求网络环境,乙方不得利用石来石往平台服务制作、复制、发布、传播干扰平台正常运营以及侵犯其他乙方或第三方合法权益的内容,乙方不得发布与石材行业无关的广告，否则甲方有权不经通知随时删除。\n 4、用户不得利用石来石往上载、复制、发送如下内容，一经发现，甲方将永久禁止该账户使用:\n (1) 反对宪法所确定的基本原则的;\n (2) 危害国家安全,泄露国家秘密，颠覆国家政权,破坏国家统一的;\n (3) 损害国家荣誉和利益的;\n (4) 煽动民族仇恨,民族歧视,破坏民族团结的;\n (5) 破坏国家宗教政策,宣扬邪教和封建迷信的;\n (6) 散布谣言,扰乱社会秩序,破坏社会稳定的;\n (7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；\n (8) 侮辱或者诽谤他人，侵害他人合法权益的；\n (9) 含有法律、行政法规禁止的其他内容的信息。\n 5、石来石往密码由乙方自行设定。乙方应妥善保管帐号和密码。使用完毕后，应安全退出，因乙方保管不善可能导致帐号被他人使用或信息数据泄漏，责任由乙方自行承担。乙方理解并同意，在乙方未进行举报或提出帐号申诉等方式明确告知石来石往帐号被他人使用或信息数据泄漏等情况并告知甲方禁止该账户使用前，甲方有理由相信该帐号行为是乙方使用帐号的行为。\n 6、本协议有效期与甲乙双方签署的《荒料仓储保管合同》、《场地摊位仓储协议》的合同期限一致。在《荒料仓储保管合同》、《场地摊位仓储协议》有效期内，若乙方完成甲方石来石往的注销使用手续时，本协议即为终止。在乙方违反本协议规定或其他甲方业务规定的情况下，甲方有权中止或终止本协议。协议终止并不意味着终止前所发生的未完成操作指令的撤销，也不能消除因终止前的操作所带来的任何法律后果。\n 7、双方在履行本协议过程中，如发生争议，应协商解决。协商解决不成的，任何一方均可向甲方所在地人民法院提起诉讼。双方因诉讼所发生的费用（含诉讼费用、双方的律师代理费、差旅费等费用由败诉方承担。";
//        NSString * str = @"1、乙方自愿申请注册石来石往货主版，完全接受本协议并遵守甲方相关业务规则和业务规定，乙方用于注册主账户、添加子账户的手机号码信息需要与预留在甲方处用于办理荒料、大板出库的纸质授权书上授权人、被授权人信息一致。注册、变更主账户、添加子账户信息经甲方根据纸质授权书信息审核通过后有权享受相应开通服务。";
//        NSString * str1 = @"2、乙方同意使用石来石往软件办理寄存在甲方所有出入货物手续，乙方通过石来石往软件提交的出库信息，乙方均予以承认，由此引发的一切后果由乙方自行承担。本协议自签字/盖章后当天起生效，如有更换人员，授权人将提前来甲方公司办理更换被授权人手续并取消石来石往上该人员的权限。";
//        NSString * str2 = @"3、石来石往致力于为乙方提供文明健康、规范有序、专一的石材供求网络环境,乙方不得利用石来石往平台服务制作、复制、发布、传播干扰平台正常运营以及侵犯其他乙方或第三方合法权益的内容,乙方不得发布与石材行业无关的广告，否则甲方有权不经通知随时删除。";
//
//        NSString * str3 = @"4、用户不得利用石来石往上载、复制、发送如下内容，一经发现，甲方将永久禁止该账户使用:";
//        NSString * str4 = @"(1) 反对宪法所确定的基本原则的;";
//        NSString * str5 = @"(2) 危害国家安全,泄露国家秘密，颠覆国家政权,破坏国家统一的;";
//        NSString * str6 = @"(3) 损害国家荣誉和利益的;";
//        NSString * str7 = @"(4) 煽动民族仇恨,民族歧视,破坏民族团结的;";
//        NSString * str8 = @"(5) 破坏国家宗教政策,宣扬邪教和封建迷信的;";
//        NSString * str9 = @"(6) 散布谣言,扰乱社会秩序,破坏社会稳定的;";
//        NSString * str10 = @"(7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；";
//        NSString * str11 = @"(8) 侮辱或者诽谤他人，侵害他人合法权益的；";
//        NSString * str12 = @"(9) 含有法律、行政法规禁止的其他内容的信息。";
//        NSString * str13 = @"5、石来石往密码由乙方自行设定。乙方应妥善保管帐号和密码。使用完毕后，应安全退出，因乙方保管不善可能导致帐号被他人使用或信息数据泄漏，责任由乙方自行承担。乙方理解并同意，在乙方未进行举报或提出帐号申诉等方式明确告知石来石往帐号被他人使用或信息数据泄漏等情况并告知甲方禁止该账户使用前，甲方有理由相信该帐号行为是乙方使用帐号的行为。";
//        NSString * str14 = @"6、本协议有效期与甲乙双方签署的《荒料仓储保管合同》、《场地摊位仓储协议》的合同期限一致。在《荒料仓储保管合同》、《场地摊位仓储协议》有效期内，若乙方完成甲方石来石往的注销使用手续时，本协议即为终止。在乙方违反本协议规定或其他甲方业务规定的情况下，甲方有权中止或终止本协议。协议终止并不意味着终止前所发生的未完成操作指令的撤销，也不能消除因终止前的操作所带来的任何法律后果。";
//        NSString * str15 = @"7、双方在履行本协议过程中，如发生争议，应协商解决。协商解决不成的，任何一方均可向甲方所在地人民法院提起诉讼。双方因诉讼所发生的费用（含诉讼费用、双方的律师代理费、差旅费等费用由败诉方承担。";
//        text.text = [NSString stringWithFormat:@"%@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n %@\n",str,str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15];
        text.showsVerticalScrollIndicator = NO;
        text.showsHorizontalScrollIndicator = NO;
        text.textColor = [UIColor colorWithHexColorStr:@"#4D4D4D"];
        text.editable = NO;
        text.font = [UIFont systemFontOfSize:17];
        [allowArgeeView addSubview:text];
        text.delegate = self;
        
        self.height = [self getHeightByTextView:text withContent:text.text withFontSize:17 withTextColor:[UIColor colorWithHexColorStr:@"#4D4D4D"]];
        
        

        UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(text.frame), CGRectGetWidth(allowArgeeView.frame), 2)];
        bottomview.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [allowArgeeView addSubview:bottomview];
        
        UIButton * noagreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomview.frame), allowArgeeView.frame.size.width/2 - 1, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(bottomview.frame))];
        [noagreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
        [noagreeBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
        //noagreeBtn.enabled = NO;
        [noagreeBtn setBackgroundColor:[UIColor whiteColor]];
        [allowArgeeView addSubview:noagreeBtn];
        _noagreeBtn = noagreeBtn;
        
        UIView * btnMidView = [[UIView alloc]initWithFrame:CGRectMake(allowArgeeView.frame.size.width/2 - 1, CGRectGetMaxY(bottomview.frame), 2, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(bottomview.frame))];
        btnMidView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [allowArgeeView addSubview:btnMidView];
        
        
        
        UIButton * agreenBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnMidView.frame), CGRectGetMaxY(bottomview.frame), allowArgeeView.frame.size.width/2 - 1, CGRectGetHeight(allowArgeeView.frame) - CGRectGetMaxY(bottomview.frame))];
        [agreenBtn setTitle:@"同意" forState:UIControlStateNormal];
        [agreenBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
        agreenBtn.enabled = NO;
        [agreenBtn setBackgroundColor:[UIColor whiteColor]];
        [allowArgeeView addSubview:agreenBtn];
        _agreenBtn = agreenBtn;
    }
    return self;
}

//计算UITextView的滑动高度
- (CGFloat)getHeightByTextView:(UITextView *)myTextView withContent:(NSString *)content withFontSize:(CGFloat)size withTextColor:(UIColor *)color
{
     CGFloat newSizeH = 0.;
     //UITextView的实际高度
    if (@available(iOS 7.0,*)) {
        //7.0以后需要自己计算高度
        float fPadding = 48; //8.0px x 2
        CGSize constraint = CGSizeMake(myTextView.contentSize.width - fPadding, CGFLOAT_MAX);
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica Neue" size:size],NSFontAttributeName,color,NSForegroundColorAttributeName, nil];
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect rect = [myTextView.text boundingRectWithSize:constraint options:options  attributes:attrsDictionary context:nil];
        newSizeH = rect.size.height;
    }else{
        newSizeH = myTextView.contentSize.height + 10;
    }
    return newSizeH;
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat postion = 300;
    if (iPhone6){
        postion = 300;
    }else if (iPhone6p || iphonex || iPhoneXS) {
        postion = 450;
    }
//    else if (iphonex || iPhoneXS ){
//        postion = 450;
//    }
    else{
        postion = 600;
    }
//        if (iPhoneXR){
//        NSLog(@"323");
//        postion = 580;
//    }else if (iPhoneXSMax){
//        postion = 580;
//    }else if (iPhone12_Mini){
//        postion = 580;
//    }else if (iPhone12){
//        postion = 580;
//    }else if (iPhone12_ProMax){
//        postion = 580;
//    }
    if (scrollView.contentOffset.y > self.height - postion) {
        _noagreeBtn.enabled = YES;
        _agreenBtn.enabled = YES;
        [_agreenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    }else{
        _noagreeBtn.enabled = YES;
        _agreenBtn.enabled = NO;
        [_agreenBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
//    if (iPhone6) {
//        if (scrollView.contentOffset.y > 1050) {
//            _noagreeBtn.enabled = YES;
//            _agreenBtn.enabled = YES;
//            [_agreenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//        }else{
//            _noagreeBtn.enabled = YES;
//            _agreenBtn.enabled = NO;
//            [_agreenBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
//        }
//    }else if (iPhone6p){
//        if (scrollView.contentOffset.y > 900) {
//            _noagreeBtn.enabled = YES;
//            _agreenBtn.enabled = YES;
//            [_agreenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//        }else{
//            _noagreeBtn.enabled = YES;
//            _agreenBtn.enabled = NO;
//            [_agreenBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
//        }
//    }else if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS){
//        if (scrollView.contentOffset.y > 850) {
//            _noagreeBtn.enabled = YES;
//            _agreenBtn.enabled = YES;
//            [_agreenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//        }else{
//            _noagreeBtn.enabled = YES;
//            _agreenBtn.enabled = NO;
//            [_agreenBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
//        }
//    }
    
}








@end
