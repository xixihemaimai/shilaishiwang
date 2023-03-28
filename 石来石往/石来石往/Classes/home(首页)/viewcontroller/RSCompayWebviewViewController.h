//
//  RSCompayWebviewViewController.h
//  石来石往
//
//  Created by mac on 17/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPhotoUploaderContentEntity.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import <WebKit/WebKit.h>




@interface RSCompayWebviewViewController : UIViewController
{
    XPhotoUploaderContentEntity         *_photoEntityWillUpload;
}


/**用来保存我的圈显示的引导图*/
@property (nonatomic,strong)NSString * tempUrl;

/**记录显示那个网页*/
@property (nonatomic,assign)NSUInteger webtag;







/**显示的网页*/
@property (nonatomic,strong)NSString * urlStr;
/**显示的导航标题*/
@property (nonatomic,strong)NSString * titleStr;

@property (nonatomic,strong)NSArray * rightBtnArr;

//@property (nonatomic,assign)BOOL isWebRight;//是网页创建的右按键
//
//@property (nonatomic,assign)BOOL isClickRight;//是网页创建的右按键

@property (nonatomic,strong)UILabel * titleLabel;

@property (nonatomic,strong)UIButton * saveBtn;


//判读右边有没有按键的值
@property (nonatomic,assign) BOOL showRightBtn;

//显示右边的按键的显示的内容
@property (nonatomic, strong) NSString *saveBtnStr;

@end
