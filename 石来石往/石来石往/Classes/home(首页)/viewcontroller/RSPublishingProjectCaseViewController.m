//
//  RSPublishingProjectCaseViewController.m
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPublishingProjectCaseViewController.h"
#import "RSPublisingProjectCaseButton.h"

#import "RSPublishingProjectCaseCustomCell.h"
#import "RSPublishingProjectCaseHeaderView.h"
#import <Photos/Photos.h>
#import "PhotoUploadHelper.h"

#import "RSPublishingProjectCaseFirstButton.h"
#import "RSPublishingProjectCaseFootView.h"
#define ECA 4
#define margin 10
#import "RSDraftViewController.h"
//,UIImagePickerControllerDelegate,UINavigationControllerDelegate
@interface RSPublishingProjectCaseViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    
    //选择相册的图片的数组
    NSMutableArray       * _imageArray;
    //这边数组是有多少个Cell的标识
    NSMutableArray       * _cellArray;
    //这边数组是选择每个cell图片的
    NSMutableArray      * _cellImageArray;
    
    //用来区分是上面添加图片，还是下面的添加的图片
    NSString            * tyle;
    
    //石材名称的次数
    NSInteger             count;
    
    
    //蒙版view
    UIView * _menview;
    
    //评论的内容
    UITextField * _textfield;
    //底部评论视图
    UIView * _commentview;
    
    /**正文的*/
    RSSFLabel * _sLabel;
    
    /**数据库*/
    FMDatabase * _db;
    
    /**正文评论的内容*/
    NSString * _textStr;
    
    /**标题评论的内容*/
    NSString * _textfieldStr;
    
    
   
    
    
    
    /**记录修改工程案例用料图片的位置的值*/
    NSInteger _changMaterialIndex;
 
    
}
//用来保存点击那个Cell的按键
@property (nonatomic,assign)NSInteger  tempIndex;

// 用来存放Cell的唯一标示符未完成
@property (nonatomic, strong) NSMutableDictionary *cellPublishNoCompelteDic;

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)RSPublishingProjectCaseFirstButton * selectImageBtn;


@property (nonatomic,strong) UIView * addSelectView;



@property (nonatomic,strong)UITextField * titleField;


@property (nonatomic,strong)UITextView * projectText;


@property (nonatomic,strong)RSProjectCaseModel * projectcasemodel;

/**记录修改工程案例图片的位置的值*/
@property (nonatomic,assign)NSInteger changeEngineerIndex;


@end

@implementation RSPublishingProjectCaseViewController
- (UITableView *)tableview{
    if (!_tableview) {
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    //这边是把正文和标题和ID都存到本地文件去
    // 数据库文件保存在沙盒缓存的路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 拼接数据库文件名
    NSString *filename = [path stringByAppendingPathComponent:@"enginerring.sqlite"];
    
    // 创建数据库的对象
    FMDatabase *db = [FMDatabase databaseWithPath:filename];
    _db = db;
    // 打开数据库
    BOOL success = [_db open];
    if (success) {
       // NSLog(@"打开数据库成功");
        // 创建表
        NSString *sql = @"create table if not exists t_enginerring(id integer primary key autoincrement,engineeringID integer NOT NULL, 'title' text ,'inPutText' text);";
        // executeUpdate:执行创建表/删除表/添加/删除/修改操作
        if ([_db executeUpdate:sql]) {
          //  NSLog(@"创建表成功");
        }else{
           // NSLog(@"创建表失败");
        }
    }else{
        //NSLog(@"打开数据库失败");
    }
    
    _textfieldStr = @"";
    _textStr = @"";
    
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _imageArray = [NSMutableArray array];
    _cellArray = [NSMutableArray array];
    _cellImageArray = [NSMutableArray array];
    count = 1;
 
    if ([self.goodCreat isEqualToString:@"0"]) {
        //新建
        RSProjectCaseThirdModel * projectcasethirdmodel = [[RSProjectCaseThirdModel alloc]init];
        projectcasethirdmodel.proName = @"石材名称";
        projectcasethirdmodel.imgId = @"";
        projectcasethirdmodel.stoneId = @"";
        projectcasethirdmodel.imgUrl = @"";
        projectcasethirdmodel.changMaterial = @"";
        [_cellArray addObject:projectcasethirdmodel];
        [self insertTextfieldContentStr:_textfield andTextViewContentStr:_projectText];
        
    }else{
        //已经存在了
        [self loadPublishCaseProjectDetail];
    }
  
    self.title = @"发布工程案例";
    [self.view addSubview:self.tableview];
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
    UIButton * publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [publishBtn addTarget:self action:@selector(loadServie:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:publishBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [publishBtn addTarget:self action:@selector(sendEnginerringAction:) forControlEvents:UIControlEventTouchUpInside];
   
    UIView * headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    //这边添加一个View
    UIView * addSelectView =[[UIView alloc]init];
    addSelectView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerview addSubview:addSelectView];
    _addSelectView = addSelectView;
    
    RSPublishingProjectCaseFirstButton * selectImageBtn = [[RSPublishingProjectCaseFirstButton alloc]init];
    [selectImageBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [selectImageBtn setTitle:@"添加案例图片" forState:UIControlStateNormal];
    [selectImageBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    if (iPhone4 || iPhone5) {
      selectImageBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }else{
      selectImageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    [addSelectView addSubview:selectImageBtn];
    [selectImageBtn addTarget:self action:@selector(addSelectImageAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectImageBtn = selectImageBtn;
    
    //中间的分隔视图
    UIView * firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [headerview addSubview:firstView];
    
    //输入文章标题
    UITextField * titleField = [[UITextField alloc]init];
    titleField.placeholder = @"请输入文章标题";
   //  [titleField setValue:[UIColor colorWithHexColorStr:@"#333333"] forKeyPath:@"_placeholderLabel.textColor"];
    if ([UIDevice currentDevice].systemVersion.floatValue <= 12.0) {
                  
                  [titleField setValue:[UIColor colorWithHexColorStr:@"#333333"] forKeyPath:@"_placeholderLabel.textColor"];
              }else{
                  
                  
                  NSMutableAttributedString * place = [[NSMutableAttributedString alloc]initWithString:titleField.text];
                  
                  [place addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, place.length)];
                  
                  titleField.attributedPlaceholder = place;
                  
              }
    
    
    
    titleField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    titleField.font = [UIFont systemFontOfSize:15];
    titleField.delegate = self;
    [titleField addTarget:self action:@selector(inputTitleText:) forControlEvents:UIControlEventEditingChanged];
    titleField.textAlignment = NSTextAlignmentLeft;
    titleField.borderStyle = UITextBorderStyleNone;
    [headerview addSubview:titleField];
    _titleField = titleField;
    
    //第二个分隔
    UIView * secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [headerview addSubview:secondView];
    
    UITextView * projectText = [[UITextView alloc]init];
    projectText.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    projectText.font = [UIFont systemFontOfSize:15];
    projectText.delegate = self;
    projectText.textAlignment = NSTextAlignmentLeft;
    [headerview addSubview:projectText];
    _projectText = projectText;
    
    RSSFLabel * sLabel = [[RSSFLabel alloc]init];
    sLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    sLabel.font = [UIFont systemFontOfSize:15];
    sLabel.textAlignment = NSTextAlignmentLeft;
    sLabel.text = @"请输入正文";
    sLabel.numberOfLines = 0;
    [projectText addSubview:sLabel];
    _sLabel = sLabel;

    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
    [headerview addSubview:bottomview];
    addSelectView.sd_layout
    .leftSpaceToView(headerview, 12)
    .topSpaceToView(headerview, 10)
    .rightSpaceToView(headerview, 12)
    .heightIs(120);
    
    if (iPhone5 || iPhone4) {
        selectImageBtn.sd_layout
        .topSpaceToView(addSelectView, 10)
        .leftSpaceToView(addSelectView, 0)
        .widthIs(100)
        .heightIs(80)
        .centerXEqualToView(addSelectView);
    }else{
        selectImageBtn.sd_layout
        .topSpaceToView(addSelectView, 10)
        .leftSpaceToView(addSelectView, 0)
        .widthIs(100)
        .heightIs(100);
       // .centerXEqualToView(addSelectView);
    }
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, selectImageBtn.yj_width, selectImageBtn.yj_height);//虚线框的大小
    borderLayer.position = CGPointMake(CGRectGetMidX(selectImageBtn.bounds),CGRectGetMidY(selectImageBtn.bounds));//虚线框锚点
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;//矩形路径
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];//虚线宽度
    //虚线边框
    borderLayer.lineDashPattern = @[@5, @5];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor colorWithHexColorStr:@"#FD9835"].CGColor;
    [selectImageBtn.layer addSublayer:borderLayer];
    [addSelectView setupAutoHeightWithBottomView:selectImageBtn bottomMargin:8];
    
    firstView.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .heightIs(1)
    .topSpaceToView(addSelectView, 10);
    
    titleField.sd_layout
    .leftSpaceToView(headerview, 12)
    .rightSpaceToView(headerview, 12)
    .topSpaceToView(firstView, 0)
    .heightIs(45);
    
    secondView.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(titleField, 0)
    .heightIs(1);
    
    projectText.sd_layout
    .leftSpaceToView(headerview, 8)
    .rightSpaceToView(headerview, 8)
    .topSpaceToView(secondView, 0)
    .heightIs(81);
    
    sLabel.sd_layout
    .leftSpaceToView(projectText, 0)
    .topSpaceToView(projectText, 0)
    .rightSpaceToView(projectText, 0)
    .heightIs(63);

    bottomview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(projectText, 0)
    .heightIs(10);
    [headerview setupAutoHeightWithBottomView:bottomview bottomMargin:0];
    [headerview layoutSubviews];
    self.tableview.tableHeaderView = headerview;
    //删除
    CGFloat bottomH = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        bottomH = 34;
    }else{
        bottomH = 0;
    }
    UIButton * deleteBtn = [[UIButton alloc]init];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:deleteBtn];
    [deleteBtn bringSubviewToFront:self.view];
    [deleteBtn addTarget:self action:@selector(deleteEngineerCaseAction:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, bottomH)
    .heightIs(45);
    if (![self.goodCreat isEqualToString:@"0"]) {
        //已经存在
        [self select];
        deleteBtn.hidden = NO;
    }else{
         deleteBtn.hidden = YES;
        _titleField.text = self.loadtitle;
    }
    _changeEngineerIndex = 0;
    _changMaterialIndex = 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * RSPUBLISHINGPROJECTCASEHEADERVIEW = @"RSPUBLISHINGPROJECTCASEHEADERVIEW";
    RSPublishingProjectCaseHeaderView * publishingProjectCaseHeaderview = [[RSPublishingProjectCaseHeaderView alloc]initWithReuseIdentifier:RSPUBLISHINGPROJECTCASEHEADERVIEW];
    return publishingProjectCaseHeaderview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString * PUBlishingProjectCaseFootview = @"publishingProjectCaseFootview";
    RSPublishingProjectCaseFootView * publishingProjectCaseFootview = [[RSPublishingProjectCaseFootView alloc]initWithReuseIdentifier:PUBlishingProjectCaseFootview];
    [publishingProjectCaseFootview.addBtn addTarget:self action:@selector(AddCaseMeterialPicture:) forControlEvents:UIControlEventTouchUpInside];
    return publishingProjectCaseFootview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [_cellPublishNoCompelteDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", @"PUBLISHINGPROJECTCASECELL", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellPublishNoCompelteDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
    }
    RSPublishingProjectCaseCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RSPublishingProjectCaseCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[indexPath.row];
    if ([projectcasethirdmodel.imgUrl isEqualToString:@""]) {
        [cell.indexpathBtn setTitle:@"添加案例用料图片" forState:UIControlStateNormal];
        [cell.indexpathBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        cell.deleteBtn.hidden = YES;
        cell.indexpathBtn.imageView.sd_layout
        .widthIs(16)
        .heightIs(16)
        //.leftSpaceToView(cell.indexpathBtn.titleLabel, 60)
        //.rightSpaceToView(cell.indexpathBtn.titleLabel, -32)
        //.bottomSpaceToView(cell.indexpathBtn.titleLabel, 10);
        .centerXEqualToView(cell.indexpathBtn)
        .centerYEqualToView(cell.indexpathBtn);
        
        cell.indexpathBtn.titleLabel.sd_layout
        .topSpaceToView(cell.indexpathBtn.imageView, 0)
        .leftSpaceToView(cell.indexpathBtn, 0)
        .rightSpaceToView(cell.indexpathBtn, 0)
        .bottomSpaceToView(cell.indexpathBtn, 0);
    }else{
        cell.deleteBtn.hidden = NO;
        [cell.indexpathBtn setTitle:@"" forState:UIControlStateNormal];
        [cell.indexpathBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:projectcasethirdmodel.imgUrl]]] forState:UIControlStateNormal];
        cell.indexpathBtn.imageView.sd_layout
        .widthIs(cell.indexpathBtn.yj_width)
        .heightIs(cell.indexpathBtn.yj_height)
        .topSpaceToView(cell.indexpathBtn, 0)
        .rightSpaceToView(cell.indexpathBtn, 0);
    }
    
    cell.indexpathBtn.tag = 100000000+indexPath.row;
    [cell.indexpathBtn addTarget:self action:@selector(cellIndexpathSelectImage:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = 100000000+indexPath.row;;
    [cell.deleteBtn addTarget:self action:@selector(deleteSelectImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.stoneNameBtn.tag = 100000000+indexPath.row;
    [cell.stoneNameBtn setTitle:projectcasethirdmodel.proName forState:UIControlStateNormal];
    [cell.stoneNameBtn addTarget:self action:@selector(changStoneNameAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}








#pragma mark -- 组头添加图片
- (void)addSelectImageAction:(UIButton *)selectBtn{
    tyle = @"1";
    //这边要对相册的选择了
    if (_imageArray.count >= 3) {
        [SVProgressHUD showInfoWithStatus:@"最多只能选择3张图片"];
    }else{
        [self selectLocalImage];
    }
    //自己设置一下的位置的值
    _changeEngineerIndex = 100;
}


- (void)selectLocalImage{
    RSWeakself
    RSSelectNeedImageTool * selectNeedImageTool = [[RSSelectNeedImageTool alloc]init];
    selectNeedImageTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
        _photoEntityWillUpload = photoEntityWillUpload;
        if ([tyle isEqualToString:@"1"]) {
            if (_changeEngineerIndex == 100) {
                [weakSelf uploadAddSingleProjectCaseImg:_photoEntityWillUpload.image];
            }else{
                //这边要对图片进行修改的判断
                RSProjectCaseImageModel * projectcaseimagemodel = _imageArray[_changeEngineerIndex];
                if ([projectcaseimagemodel.changEngineer isEqualToString:@"1"]) {
                    //这边只能修改图片
                    [weakSelf modificationOfEngineeringCases:_changeEngineerIndex andImage:_photoEntityWillUpload.image];
                }else{
                    [weakSelf uploadAddSingleProjectCaseImg:_photoEntityWillUpload.image];
                }
            }
        }else{
            if (_cellArray.count >= 10) {
                [SVProgressHUD showInfoWithStatus:@"最多只能添加10"];
            }else{
                RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[_changMaterialIndex];
                if ([projectcasethirdmodel.changMaterial isEqualToString:@"1"]){
                    [weakSelf modificationOfEngineeringCases:_changMaterialIndex andImage:_photoEntityWillUpload.image];
                }else{
                    [weakSelf loadAddCaseStone:_photoEntityWillUpload.image];
                }
            }
        }

    };
    
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开系统相机
        [selectNeedImageTool openCameraViewController:weakSelf];
       // [weakSelf openCanmera];
    }];
    [alert addAction:action1];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开系统相册
        [weakSelf selectPictures];
    }];
    [alert addAction:action2];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这边去取消操作
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action3];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
           alert.modalPresentationStyle = UIModalPresentationFullScreen;
       }
    [self presentViewController:alert animated:YES completion:nil];
}

//
////FIXME:系统相机
//- (void)openCanmera{
//    //调用系统的相机的功能
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        picker.delegate = self;
//        //设置拍照后的图片可被编辑
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        //先检查相机可用是否
//        BOOL cameraIsAvailable = [self checkCamera];
//        if (YES == cameraIsAvailable) {
//            [self presentViewController:picker animated:YES completion:nil];
//        }else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
//            [alert show];
//        }
//    }
//}
//
//







#pragma mark -- uitextviewDelegate 正文

- (void)textViewDidChange:(UITextView *)textView
{
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([temp length]!=0) {
            _sLabel.text = @"";
            temp = [self delSpaceAndNewline:temp];
            _textStr = temp;
            [self updateProjectTextContentStr:textView];
        }else{
            _sLabel.text = @"请输入正文";
            _textStr = @"";
            [self updateProjectTextContentStr:textView];
        }
}



- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length]!=0) {
        _sLabel.text = @"";
        temp = [self delSpaceAndNewline:temp];
        _textStr = temp;
        [self updateProjectTextContentStr:textView];
        
    }else{
        _sLabel.text = @"请输入正文";
        _textStr = @"";
         [self updateProjectTextContentStr:textView];
    }
}



- (void)inputTitleText:(UITextField *)textfield{
    NSString *temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length]!=0) {
        _textfieldStr = temp;
        [self updateTitleContentStr:textfield];
    }else{
        _textfieldStr = @"";
        [self updateTitleContentStr:textfield];
    }
    
}

//添加到数据库（添加一个工程ID和）
- (void)insertTextfieldContentStr:(UITextField *)textfield andTextViewContentStr:(UITextView *)textview{
    BOOL result = [_db executeUpdate:@"insert into t_enginerring (engineeringID,title,inPutText) values (?,?,?);",@(_engineeringID),textfield.text,textview.text];
    if (result) {
        //NSLog(@"添加数据成功");
    }else{
       // NSLog(@"添加数据失败");
    }
}


//修改正文
- (void)updateProjectTextContentStr:(UITextView *)textview{
    BOOL result = [_db executeUpdate:@"update t_enginerring set inPutText = ? where engineeringID = ? ;",_textStr,@(_engineeringID)];
    if (result) {
       // NSLog(@"修改成功");
    }else{
       // NSLog(@"修改失败");
    }
}

//修改标题
- (void)updateTitleContentStr:(UITextField *)textfield{
    BOOL result = [_db executeUpdate:@"update t_enginerring set title = ? where engineeringID = ?;",_textfieldStr,@(_engineeringID)];
    if (result) {
        //NSLog(@"修改成功");
    }else{
       // NSLog(@"修改失败");
    }
}



//查询
- (void)select {
    // 返回一个结果集合(一条记录)
    FMResultSet * result = [_db executeQuery:@"select * from t_enginerring where id = (select max(id) as id from t_enginerring where engineeringID = (?));",@(_engineeringID)];
    // 获取字段的值
    while ([result next]) { // 判断是否有下一条记录
        // 根据字段名从结果集合里取出字段的值
        NSInteger engineeringID = [result intForColumn:@"engineeringID"];
        NSString * title = [result stringForColumn:@"title"];
        NSString *  inPutText = [result stringForColumn:@"inPutText"];
       // NSLog(@"engineeringID = %ld title = %@,inPutText = %@",engineeringID,title,inPutText);
        _projectText.text = inPutText;
        _textStr = inPutText;
        _textfieldStr = title;
        _titleField.text = title;
        if ([_projectText.text length] < 1) {
            _sLabel.text = @"请输入正文";
        }else{
            _sLabel.text = @"";
        }
    }
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location < 50)
    {
        if ([string isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            //在这里做你响应return键的代码
            [textField resignFirstResponder];
            return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        }
        return  YES;
    } else {
        return NO;
    }
    
}

#pragma mark -- uitextfielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length]!=0) {
        _textfieldStr = temp;
        [self updateTitleContentStr:textField];
    }else{
        _textfieldStr = @"";
        [self updateTitleContentStr:textField];
    }
    [textField resignFirstResponder];
    return YES;
}

- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    
    NSRange range = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 500)
    {
        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            //在这里做你响应return键的代码
            [textView resignFirstResponder];
            return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        }
        return  YES;
    } else {
        return NO;
    }
}






//#pragma mark -- 检查相机是否可用
//- (BOOL)checkCamera
//{
//    NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    if(AVAuthorizationStatusRestricted == authStatus ||
//       AVAuthorizationStatusDenied == authStatus)
//    {
//        //相机不可用
//        return NO;
//    }
//    //相机可用
//    return YES;
//}




//#pragma mark -- 当用户选取完成后调用
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//
//        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
//        if (mediaMetadata)
//        {
//
//        } else {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//        }
//
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//
//        } else {
//
//        }
//    }
//}
//
//- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
//{
//    //[[RSMessageView shareMessageView] showMessageWithType:@"努力加载中" messageType:kRSMessageTypeIndicator];
//    RSWeakself
//    [PhotoUploadHelper
//     processPickedUIImage:[self scaleToSize:pickedImage]
//     withMediaMetadata:mediaMetadata
//     completeBlock:^(XPhotoUploaderContentEntity *photo) {
//         _photoEntityWillUpload = photo;
//         if ([tyle isEqualToString:@"1"]) {
//             if (_changeEngineerIndex == 100) {
//                     [weakSelf uploadAddSingleProjectCaseImg:_photoEntityWillUpload.image];
//                 }else{
//                 //这边要对图片进行修改的判断
//                 RSProjectCaseImageModel * projectcaseimagemodel = _imageArray[_changeEngineerIndex];
//                 if ([projectcaseimagemodel.changEngineer isEqualToString:@"1"]) {
//                     //这边只能修改图片
//                      [weakSelf modificationOfEngineeringCases:_changeEngineerIndex andImage:_photoEntityWillUpload.image];
//                 }else{
//                      [weakSelf uploadAddSingleProjectCaseImg:_photoEntityWillUpload.image];
//                 }
//                }
//         }else{
//             if (_cellArray.count >= 10) {
//                 [SVProgressHUD showInfoWithStatus:@"最多只能添加10"];
//             }else{
//                 RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[_changMaterialIndex];
//                 if ([projectcasethirdmodel.changMaterial isEqualToString:@"1"]){
//                     [weakSelf modificationOfEngineeringCases:_changMaterialIndex andImage:_photoEntityWillUpload.image];
//                 }else{
//                     [weakSelf loadAddCaseStone:_photoEntityWillUpload.image];
//                 }
//             }
//         }
//     }
//     failedBlock:^(NSDictionary *errorInfo) {
//     }];
//}

//获取用户的图片信息
- (void)loadPublishCaseProjectDetail{
    [SVProgressHUD showInfoWithStatus:@"正在获取网络数据..........."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.engineeringID]forKey:@"caseId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROJECTCASEDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableDictionary * mutableDict = [NSMutableDictionary dictionary];
                mutableDict = json[@"Data"];
                weakSelf.projectcasemodel = [[RSProjectCaseModel alloc]init];
                weakSelf.projectcasemodel.CREATE_TIME = mutableDict[@"CREATE_TIME"];
                weakSelf.projectcasemodel.CONTENT = mutableDict[@"CONTENT"];
                weakSelf.projectcasemodel.ID = mutableDict[@"ID"];
                weakSelf.projectcasemodel.TITLE = mutableDict[@"TITLE"];
                weakSelf.projectcasemodel.UPDATE_TIME = mutableDict[@"UPDATE_TIME"];
                weakSelf.projectcasemodel.USER_NAME = mutableDict[@"USER_NAME"];
                NSMutableArray * tempArray = [NSMutableArray array];
                tempArray = mutableDict[@"IMG"];
                for (int j = 0; j < tempArray.count; j++) {
                    RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
                    projectcaseimagemodel.imgId = [[tempArray objectAtIndex:j]objectForKey:@"imgId"];
                    projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:j]objectForKey:@"imgUrl"];
                    projectcaseimagemodel.changEngineer = @"1";
                    [_imageArray addObject:projectcaseimagemodel];
                }
                weakSelf.projectcasemodel.IMG = _imageArray;
                NSMutableArray * caseDetailArray = [NSMutableArray array];
                caseDetailArray = mutableDict[@"CASESTONEIMG"];
                for (int n = 0 ; n < caseDetailArray.count; n++) {
                    RSProjectCaseThirdModel * projectcasethirdmodel = [[RSProjectCaseThirdModel alloc]init];
                    projectcasethirdmodel.imgId = [[caseDetailArray objectAtIndex:n]objectForKey:@"imgId"];
                    projectcasethirdmodel.imgUrl = [[caseDetailArray objectAtIndex:n]objectForKey:@"imgUrl"];
                    projectcasethirdmodel.stoneId = [[caseDetailArray objectAtIndex:n]objectForKey:@"stoneId"];
                    projectcasethirdmodel.proName = [[caseDetailArray objectAtIndex:n]objectForKey:@"proName"];
                    projectcasethirdmodel.changMaterial = @"1";
                    [_cellArray addObject:projectcasethirdmodel];
                }
                weakSelf.projectcasemodel.CASESTONEIMG = _cellArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf ninePublishGrid];
                    [weakSelf showImage];
                    if ([weakSelf.projectcasemodel.CONTENT length] < 1) {
                        [weakSelf select];
                    }else{
                        weakSelf.projectText.text = weakSelf.projectcasemodel.CONTENT;
                        _textStr = weakSelf.projectcasemodel.CONTENT;
                    }
                    if ([weakSelf.projectcasemodel.TITLE length] < 1) {
                        [weakSelf select];
                    }else{
                        _textfieldStr = weakSelf.projectcasemodel.TITLE;
                        weakSelf.titleField.text = weakSelf.projectcasemodel.TITLE;
                    }
                     [weakSelf.tableview reloadData];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
        }
    }];
}

//添加工程案例的图片
- (void)uploadAddSingleProjectCaseImg:(UIImage *)image{
    [SVProgressHUD showWithStatus:@"图片正在上传中,请等待中......."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)self.engineeringID] forKey:@"id"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    NSArray *avatarArray = [NSArray arrayWithObject:image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getImageDataWithUrlString:URL_ADDSINGLEPROJECTCASEIMG_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [SVProgressHUD dismiss];
                //这边是把图片添加到图片数组中
                RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
                projectcaseimagemodel.imgId = json[@"Data"][@"imgId"];
                projectcaseimagemodel.imgUrl = json[@"Data"][@"imgUrl"];
                projectcaseimagemodel.changEngineer = @"1";
                [_imageArray addObject:projectcaseimagemodel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf ninePublishGrid];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
        }
    }];
}


//FIXME:工程案例图片修改-----后台还有问题，等着处理
- (void)modificationOfEngineeringCases:(NSInteger)index andImage:(UIImage *)image{
    //图片id    imgId    Int
    [SVProgressHUD showWithStatus:@"图片正在修改中,请等待中......."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
    RSProjectCaseThirdModel * projectcasethirdmodel= [[RSProjectCaseThirdModel alloc]init];
    if ([tyle isEqualToString:@"1"]) {
        projectcaseimagemodel = _imageArray[index];
         [dict setObject:projectcaseimagemodel.imgId forKey:@"imgId"];
    }else{
        projectcasethirdmodel = _cellArray[index];
        [dict setObject:projectcasethirdmodel.imgId forKey:@"imgId"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    NSArray *avatarArray = [NSArray arrayWithObject:image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    [network getImageDataWithUrlString:URL_UPDATEPROJECTCASEIMA_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success){
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [SVProgressHUD dismiss];
                if ([tyle isEqualToString:@"1"]) {
                    projectcaseimagemodel.imgId = json[@"Data"][@"imgId"];
                    projectcaseimagemodel.imgUrl = json[@"Data"][@"imgUrl"];
                    /**修改了也要设置为已经有图片了*/
                    projectcaseimagemodel.changEngineer = projectcaseimagemodel.changEngineer;
                    //这边要对数组里面的模型进行修改
                    [_imageArray replaceObjectAtIndex:index withObject:projectcaseimagemodel];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf ninePublishGrid];
                    });
                }else{
                    projectcasethirdmodel.imgId = json[@"Data"][@"imgId"];
                    projectcasethirdmodel.imgUrl = json[@"Data"][@"imgUrl"];
                    projectcasethirdmodel.stoneId = projectcasethirdmodel.stoneId;
                    projectcasethirdmodel.proName = projectcasethirdmodel.proName;
                    projectcasethirdmodel.changMaterial = @"1";
                    [_cellArray replaceObjectAtIndex:index withObject:projectcasethirdmodel];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf showImage];
                        [weakSelf.tableview reloadData];
                    });
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"修改失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"修改失败"];
        }
    }];
}

//添加工程案例的案例用料
- (void)loadAddCaseStone:(UIImage *)image{
    [SVProgressHUD showWithStatus:@"图片正在上传中,请等待中......."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)self.engineeringID] forKey:@"caseId"];
    RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[self.tempIndex - 100000000];
    [dict setObject:projectcasethirdmodel.proName forKey:@"proName"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    NSArray *avatarArray = [NSArray arrayWithObject:image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getImageDataWithUrlString:URL_ADDCASESTONE_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableDictionary * mutableDict = [NSMutableDictionary dictionary];
                mutableDict = json[@"Data"];
                NSMutableArray * array = [NSMutableArray array];
                array = mutableDict[@"CASESTONEIMG"];
                for (int i = 0; i < array.count; i++) {
                    RSProjectCaseThirdModel * projectcasethirdmodel = [[RSProjectCaseThirdModel alloc]init];
                    projectcasethirdmodel.imgId = [[array objectAtIndex:i]objectForKey:@"imgId"];
                    projectcasethirdmodel.imgUrl = [[array objectAtIndex:i]objectForKey:@"imgUrl"];
                    projectcasethirdmodel.stoneId = [[array objectAtIndex:i]objectForKey:@"stoneId"];
                    projectcasethirdmodel.proName = [[array objectAtIndex:i]objectForKey:@"proName"];
                    projectcasethirdmodel.changMaterial = @"1";
                    [_cellArray replaceObjectAtIndex:weakSelf.tempIndex - 100000000 withObject:projectcasethirdmodel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showImage];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取失败"];
        }
    }];
}



//#pragma mark -- 对图片进行压缩
//- (UIImage *)scaleToSize:(UIImage *)img {
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
//
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    //返回新的改变大小后的图片
//    return scaledImage;
//}


- (void)selectPictures{
    NSInteger imagesCount = 0;
    if ([tyle isEqualToString:@"1"]) {
        imagesCount = 1;
    }else{
        imagesCount = 1;
    }
    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:imagesCount delegate:self];
    RSWeakself
    imagePickerVc.allowPickingVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           for (int i=0; i<photos.count; i++)
                           {
                               // = photos[i]
                               // ALAsset *asset = assets[i];
                               //UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                               UIImage * tempImg = photos[i];
                               if ([tyle isEqualToString:@"1"]) {
//                                   if (_imageArray.count >= 3) {
//                                        [SVProgressHUD showInfoWithStatus:@"最多只能添加3"];
//                                   }else{
                                       //这边也需要做个判断是否修改
                                   //10000000000
                                       if (_changeEngineerIndex == 100) {
                                           [weakSelf uploadAddSingleProjectCaseImg:tempImg];
                                       }else{
                                           RSProjectCaseImageModel * projectcaseimagemodel = _imageArray[_changeEngineerIndex];
                                           if ([projectcaseimagemodel.changEngineer isEqualToString:@"1"]) {
                                               //这边只能修改图片
                                               [weakSelf modificationOfEngineeringCases:_changeEngineerIndex andImage:tempImg];
                                           }else{
                                               [weakSelf uploadAddSingleProjectCaseImg:tempImg];
                                           }
                                       }
                                 //  }
                               }else{
                                   if (_cellArray.count >= 10) {
                                       [SVProgressHUD showInfoWithStatus:@"最多只能添加10"];
                                   }else{
                                       RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[_changMaterialIndex];
                                       if ([projectcasethirdmodel.changMaterial isEqualToString:@"1"]) {
                                           [weakSelf modificationOfEngineeringCases:_changMaterialIndex andImage:tempImg];
                                       }else{
                                            [weakSelf loadAddCaseStone:tempImg];
                                       }
                                   }
                               }
                           }
                       });
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
           imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
       }
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}






- (void)ninePublishGrid
{
    for (UIImageView *imgv in self.addSelectView.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
        }
    }
    CGFloat width = 0.0;
    CGFloat height = 0.0;
    
    if (iPhone4 || iPhone5) {
        width = 80;
        height = 80;
        
    }else{
        
        width = 100;
         height = 100;
        
    }
  
    
    NSInteger count = _imageArray.count;
    
    _imageArray.count > 3 ? (count = 3) : (count = _imageArray.count);
    if (count < 1) {
        
        self.selectImageBtn.sd_layout
        .leftSpaceToView(self.addSelectView,0)
        .topSpaceToView(self.addSelectView, 10)
        .widthIs(width)
        .heightIs(height);
        self.selectImageBtn.hidden = NO;
        // [self.tableviewFootView setupAutoHeightWithBottomView:self.selectImageBtn bottomMargin:15];
    }
    else{
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / ECA;
            NSInteger colom = i % ECA;
            UIImageView *imgv = [[UIImageView alloc] init];
            CGFloat imgX =  colom * (margin + width) + margin;
            CGFloat imgY =  row * (margin + height) + margin;
            imgv.frame = CGRectMake(imgX, imgY, width, height);
            //imgv.image = _imageArray[i];
            RSProjectCaseImageModel * projectcaseimagemodel = _imageArray[i];
            imgv.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:projectcaseimagemodel.imgUrl]]];
            imgv.userInteractionEnabled = YES;
            [self.addSelectView addSubview:imgv];
            //添加手势
            imgv.tag = 100000+i;

            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSelectLoaclImagePicture:)];
            tap.view.tag = 100000+i;
            [imgv addGestureRecognizer:tap];
            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
            delete.frame = CGRectMake(width-16, 0, 16, 16);
            [delete setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteSelectLocalImageAction:) forControlEvents:UIControlEventTouchUpInside];
            delete.tag = 10+i;
            [imgv addSubview:delete];
            self.selectImageBtn.sd_layout
            .leftSpaceToView(imgv, margin)
            .topSpaceToView(imgv, imgY)
            .bottomEqualToView(imgv)
            .widthIs(100);
            [self.addSelectView setupAutoHeightWithBottomView:imgv bottomMargin:10];
            if (count >= 3) {
                self.selectImageBtn.hidden = YES;
            }else{
                self.selectImageBtn.hidden = NO;
            }
        }
    }
}

- (void)deleteSelectLocalImageAction:(UIButton *)btn{
    tyle = @"1";
    //FIXME:删除
    [self deleteLoaclChoiceImage:btn.tag];
}



//FIXME:删除该工程案例
- (void)deleteEngineerCaseAction:(UIButton *)deleteBtn{
    [SVProgressHUD showInfoWithStatus:@"正在删除改工程案例中,请等待中........"];
    //FIXME:删除或者恢复工程案例 status 删除传2  恢复的话传1 -- 还没有接的地方
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%ld",self.engineeringID] forKey:@"caseId"];
        [dict setObject:[NSString stringWithFormat:@"2"] forKey:@"status"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_CHANGEPROJECTCASESTATUS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    [SVProgressHUD dismiss];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    if ([weakSelf.delegate respondsToSelector:@selector(reDraft)]) {
                        [weakSelf.delegate reDraft];
                    }
                }else{
                     [SVProgressHUD showInfoWithStatus:@"删除失败"];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"删除失败"];
            }
        }];
}







- (void)showSelectLoaclImagePicture:(UITapGestureRecognizer *)tap{
   RSWeakself
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"是否修改工程案例图片"
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf selectLocalImage];
        _changeEngineerIndex = tap.view.tag - 100000;
        tyle = @"1";
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        alertController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alertController animated:YES completion:nil];
}




- (void)showImage{
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.tempIndex - 100000000 inSection:0];
        RSPublishingProjectCaseCustomCell * publishingProjectCaseCell = [self.tableview cellForRowAtIndexPath:indexpath];
        for (NSInteger i = 0; i < _cellArray.count; i++) {
            if (self.tempIndex - 100000000 == i) {
                RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[self.tempIndex - 100000000];
                //UIImage * image = _cellImageArray[self.tempIndex - 100000000];
                UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:projectcasethirdmodel.imgUrl]]];
                [publishingProjectCaseCell.indexpathBtn setImage:image forState:UIControlStateNormal];
                [publishingProjectCaseCell.indexpathBtn setTitle:@"" forState:UIControlStateNormal];
                publishingProjectCaseCell.deleteBtn.hidden = NO;
                publishingProjectCaseCell.indexpathBtn.imageView.sd_layout
                .widthIs(publishingProjectCaseCell.indexpathBtn.yj_width)
                .heightIs(publishingProjectCaseCell.indexpathBtn.yj_height)
                //.topSpaceToView(publishingProjectCaseCell.indexpathBtn, 0)
                .bottomSpaceToView(publishingProjectCaseCell.indexpathBtn, 0)
                .rightSpaceToView(publishingProjectCaseCell.indexpathBtn, 0)
                .leftSpaceToView(publishingProjectCaseCell.indexpathBtn, 0);
                break;
            }
          }
}


- (void)cellIndexpathSelectImage:(UIButton *)btn{
    tyle = @"2";
    //这边要进行判断名字有没有改动，改动了才可以选择图片
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:btn.tag - 100000000  inSection:0];
    RSPublishingProjectCaseCustomCell * cell = [self.tableview cellForRowAtIndexPath:indexpath];
    //NSString * str = _cellArray[btn.tag - 100000000];
     RSProjectCaseThirdModel * projectcasethirdmodel =  _cellArray[btn.tag - 100000000];
    if ([cell.stoneNameBtn.currentTitle isEqualToString:@"石材名称"] && [projectcasethirdmodel.proName isEqualToString:@"石材名称"]) {
        [SVProgressHUD showInfoWithStatus:@"请选需改石材名称之后，才能进行上传图片的动作"];
    }else{
        self.tempIndex = btn.tag;
        for (NSInteger i = 0; i < _cellArray.count; i++) {
            if (self.tempIndex - 100000000 == i) {
                RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[i];
                if (![projectcasethirdmodel.imgUrl isEqual:@""]) {
                    //这边去添加修改工程案例用料的图片的方法
                    RSWeakself
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"是否修改工程案例用料的图片"
                                                                                              message: nil
                                                                                       preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [weakSelf selectLocalImage];
                        _changMaterialIndex = i;
                        tyle = @"2";
                    }]];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }]];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertController.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertController animated:YES completion:nil];
                }else{
                    [self selectLocalImage];
                }
            }
        }
    }
}




- (void)deleteSelectImageAction:(UIButton *)btn{
    tyle = @"2";
    self.tempIndex = btn.tag;
    [self deleteLoaclChoiceImage:self.tempIndex];
}


- (void)deleteLoaclChoiceImage:(NSInteger)index{
    // 图片id    imgId    Int    工程案例和案例用料的图片都可以使用
    //案例用料id    stoneId    String    Android使用，ios传空就行
    RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
    RSProjectCaseThirdModel * projectcasethirdmodel= [[RSProjectCaseThirdModel alloc]init];
    if ([tyle isEqualToString:@"1"]) {
            projectcaseimagemodel =  _imageArray[index - 10];
    }else{
            projectcasethirdmodel = _cellArray[index - 100000000];
        
    }
    [SVProgressHUD showWithStatus:@"图片正在删除中,请等待中......."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //[dict setObject:[NSString stringWithFormat:@"%ld",self.engineeringID] forKey:@"caseId"];
    if ([tyle isEqualToString:@"1"]) {
        [dict setObject:projectcaseimagemodel.imgId forKey:@"imgId"];
    }else{
        [dict setObject:projectcasethirdmodel.imgId forKey:@"imgId"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DELETESINGLEPROJECTCASEIMG_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [SVProgressHUD dismiss];
                if ([tyle isEqualToString:@"1"]) {
                    [_imageArray removeObjectAtIndex:index-10];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf ninePublishGrid];
                    });
                }else{
                     [_cellArray removeObjectAtIndex:self.tempIndex - 100000000];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf showImage];
                    });
                     [weakSelf.tableview reloadData];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取失败"];
            }
        }else{
             [SVProgressHUD showInfoWithStatus:@"获取失败"];
        }
    }];
}


- (void)changStoneNameAction:(UIButton *)changStoneNameBtn{
    
    tyle = @"2";
    self.tempIndex = changStoneNameBtn.tag;
    //这边要做一个视图从底部往头部走,也要添加一个蒙版
    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCW, SCH - 64)];
    menview.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:0.5];
    menview.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChangeStoneNameMenview:)];
    
    [menview addGestureRecognizer:tap];
    _menview = menview;
    [self.view addSubview:_menview];
    
    
    //这边要添加一个视图
    UIView * commentview = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - 64 - 40, SCW, 40)];
    commentview.userInteractionEnabled = YES;
    commentview.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [menview addSubview:commentview];
    _commentview = commentview;
    
    //textfield
    UITextField * textfield = [[UITextField alloc]init];
    textfield.backgroundColor = [UIColor whiteColor];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    [textfield becomeFirstResponder];
    [commentview addSubview:textfield];
    _textfield = textfield;
    _textfield.tag = changStoneNameBtn.tag;
    
    
    textfield.sd_layout
    .topSpaceToView(commentview, 5)
    .bottomSpaceToView(commentview, 5)
    .leftSpaceToView(commentview, 12)
    .widthRatioToView(commentview, 0.75);
    
    //发送按键
    UIButton * transmitBtn = [[UIButton alloc]init];
    [transmitBtn setTitle:@"发送" forState:UIControlStateNormal];
    [transmitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [transmitBtn addTarget:self action:@selector(changStoneNameTextFieldAction:) forControlEvents:UIControlEventTouchUpInside];
    [commentview addSubview:transmitBtn];
    transmitBtn.tag = self.tempIndex;
    
    transmitBtn.sd_layout
    .leftSpaceToView(textfield, 5)
    .rightSpaceToView(commentview, 12)
    .topSpaceToView(commentview, 0)
    .bottomSpaceToView(commentview, 0);
}


#pragma mark -- 发送评论内容
- (void)changStoneNameTextFieldAction:(UIButton *)btn{
    NSString *temp = [_textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //看剩下的字符串的长度是否为零
    if ([temp length]!=0) {
       //这边要改变数组和cell的内容
        //这边要对图片的数组进行处理，也要对cell里面的图片进行处理
        
        self.tempIndex = btn.tag;
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.tempIndex - 100000000 inSection:0];
        RSPublishingProjectCaseCustomCell * publishingProjectCaseCell = [self.tableview cellForRowAtIndexPath:indexpath];
       // [_cellArray replaceObjectAtIndex:self.tempIndex - 100000000 withObject:temp];
        RSProjectCaseThirdModel * projectcasethirdmodel = _cellArray[self.tempIndex - 100000000];
        projectcasethirdmodel.proName = temp;
        [publishingProjectCaseCell.stoneNameBtn setTitle:temp forState:UIControlStateNormal];
        //[self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [SVProgressHUD showInfoWithStatus:@"你没有评论内容"];
    }
    [_commentview removeFromSuperview];
    [_menview removeFromSuperview];
}



#pragma mark -- 显示键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    
    //258
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            _commentview.frame  = CGRectMake(0.0f,SCH - offset- 64 - 40, SCW, 40);
        }];
    }
}


#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        _commentview.frame = CGRectMake(0, 0, SCW, 40);
    }];
}

- (void)cancelChangeStoneNameMenview:(UITapGestureRecognizer *)tap{
    //移除蒙版
    [_menview removeFromSuperview];
    [_commentview removeFromSuperview];
}







//添加
- (void)AddCaseMeterialPicture:(UIButton *)addBtn{
    if (_cellArray.count > 10  && _cellImageArray.count > 10) {
        [SVProgressHUD showInfoWithStatus:@"最多只能添加10个案例用料"];
    }else{
        RSProjectCaseThirdModel * projectcasethirdmodel = [[RSProjectCaseThirdModel alloc]init];
        projectcasethirdmodel.proName = @"石材名称";
        projectcasethirdmodel.imgId = @"";
        projectcasethirdmodel.stoneId = @"";
        projectcasethirdmodel.imgUrl = @"";
        projectcasethirdmodel.changMaterial = @"";
        [_cellArray insertObject:projectcasethirdmodel atIndex:0];
        [self.tableview reloadData];
    }
}


//FIXME:发布
- (void)sendEnginerringAction:(UIButton *)publishBtn{
    
    //这边要判断有
    //图片
    if (_imageArray.count < 1) {
        [SVProgressHUD showInfoWithStatus:@"请添加图片"];
        return;
    }
    
    //主题
       NSString * temp1 = [_textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp1 length] < 1 && [_textfieldStr length] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请填入主题"];
        return;
    }
    //请输入正文
     NSString * temp2 = [_projectText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([temp2 length] < 1 && [_textStr length] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请填入正文"];
        return;
    }
    [self engineerCasePublish];
}

//FIXME: 工程案例草稿补全 (发布) -- 没有开始测试
- (void)engineerCasePublish{
    [SVProgressHUD showInfoWithStatus:@"正在发布工程案例中，请等待......."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.engineeringID]forKey:@"caseId"];
    [phoneDict setObject:_textStr forKey:@"title"];
    [phoneDict setObject:_textfieldStr forKey:@"content"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_REPLENISPROJECTCASE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [SVProgressHUD dismiss];
                
                if ([weakSelf.delegate respondsToSelector:@selector(reDraft)]) {
                    [weakSelf.delegate reDraft];
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"发布工程案例失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"发布工程案例失败"];
        }
    }];
}






-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}

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
