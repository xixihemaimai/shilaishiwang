//
//  RSMaterialDetailsViewController.m
//  石来石往
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSMaterialDetailsViewController.h"
#import "RSMaterialDetailsSecondCell.h"
#import "RSNewRoleViewController.h"

//模型
#import "RSRoleModel.h"


@interface RSMaterialDetailsViewController ()

@property (nonatomic,strong)NSMutableArray * imageArray;




@end

@implementation RSMaterialDetailsViewController




- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"角色管理";
    
//    self.titleArray = @[@"物料名称",@"物料类型",@"石种颜色",@"长度",@"数量",@"重量",@"体积",@"面积"];
//    self.detailArray = @[@"请填写物料名称",@"大理石",@"红色",@"厘米",@"颗",@"吨",@"立方米",@"平方米"];
    
//    [self.view addSubview:self.tableview];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    [addBtn addTarget:self action:@selector(addNewRoleAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
//    [self setCustomTableviewHeader];
//    [self setBottomUI];
    [self reloadRoleNewData];
    [self.tableview setupEmptyDataText:@"暂无数据" tapBlock:^{
        
    }];
}






- (void)addNewRoleAction:(UIButton *)addBtn{
    RSNewRoleViewController * newRoleVc = [[RSNewRoleViewController alloc]init];
    newRoleVc.usermodel = self.usermodel;
    newRoleVc.selectType = @"new";
    [self.navigationController pushViewController:newRoleVc animated:YES];
    newRoleVc.reload = ^(BOOL success) {
        if (success) {
            [self reloadRoleNewData];
        }
    };
}

//- (void)setCustomTableviewHeader{
//
//    UIView * headerView = [[UIView alloc]init];
//    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//
//    UILabel * titleLabel = [[UILabel alloc]init];
//    titleLabel.text = @"石种图片";
//    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.font = [UIFont systemFontOfSize:15];
//    [headerView addSubview:titleLabel];
//    _headerView = headerView;
//
//    titleLabel.sd_layout
//    .leftSpaceToView(headerView, 12)
//    .topSpaceToView(headerView, 26)
//    .heightIs(21)
//    .widthIs(62);
//
//
//    UIView * contentImageView = [[UIView alloc]init];
//    contentImageView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    [headerView addSubview:contentImageView];
//    _contentImageView = contentImageView;
//
//
//    contentImageView.sd_layout
//    .leftSpaceToView(titleLabel, 12)
//    .topSpaceToView(headerView, 0)
//    .heightIs(78)
//    .rightSpaceToView(headerView, 12);
//
//
//    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setTitle:@"+" forState:UIControlStateNormal];
//    [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F4F4F4"]];
//    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
//    [contentImageView addSubview:addBtn];
//    [addBtn addTarget:self action:@selector(addStonePictureAction:) forControlEvents:UIControlEventTouchUpInside];
//    _addBtn = addBtn;
//
//
//    addBtn.sd_layout
//    .rightSpaceToView(contentImageView, 0)
//    .topSpaceToView(contentImageView, 9)
//    .widthIs(60)
//    .heightEqualToWidth();
//    addBtn.layer.cornerRadius = 3;
//
//
//    UIView * bottomview = [[UIView alloc]init];
//    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
//    [headerView addSubview:bottomview];
//    _bottomview = bottomview;
//
//    bottomview.sd_layout
//    .leftSpaceToView(headerView, 0)
//    .rightSpaceToView(headerView, 0)
//    .heightIs(1)
//    .topSpaceToView(contentImageView, 0);
//
//    [headerView setupAutoHeightWithBottomView:bottomview bottomMargin:0];
//    [headerView layoutSubviews];
//    self.tableview.tableHeaderView = headerView;
//
//
//}



//- (void)setBottomUI{
//        for (int i = 0; i < 2; i++) {
//            UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
//            saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//            if (i == 0) {
//                [saveBtn setTitle:@"删除" forState:UIControlStateNormal];
//                [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
//                saveBtn.frame = CGRectMake(0, SCH - 50, SCW/2, 50);
//              //  [saveBtn addTarget:self action:@selector(alterationOfWasteRecoveryAction:) forControlEvents:UIControlEventTouchUpInside];
//            }else{
//                [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//                [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
//                saveBtn.frame = CGRectMake(SCW/2, SCH - 50, SCW/2, 50);
//                //[saveBtn addTarget:self action:@selector(alterationOfWasteSaveAction:) forControlEvents:UIControlEventTouchUpInside];
//            }
//            [self.view addSubview:saveBtn];
//            [saveBtn bringSubviewToFront:self.view];
//        }
//}

//添加图片
//- (void)addStonePictureAction:(UIButton *)addBtn{
//    [self selectPictures];
//}


//- (void)selectPictures
//{
//
//    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
//    RSWeakself
//    imagePickerVc.allowTakeVideo = NO;
//    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
//                       {
//                           for (int i=0; i<photos.count; i++)
//                           {
//                               // = photos[i]
//                               // ALAsset *asset = assets[i];
//                               //UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//                               UIImage * tempImg = photos[i];
//                               [weakSelf.imageArray addObject:tempImg];
//                               dispatch_async(dispatch_get_main_queue(), ^{
//                                   [weakSelf nineMarketGrid];
//                               });
//                           }
//                       });
//
//
//    }];
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
//}



//- (void)nineMarketGrid
//{
//    for (UIImageView *imgv in _contentImageView.subviews)
//    {
//        if ([imgv isKindOfClass:[UIImageView class]]) {
//            [imgv removeFromSuperview];
//        }
//    }
//    CGFloat width = 60;
//    CGFloat height = 60;
//    NSInteger count = self.imageArray.count;
//    //self.imageArray.count > 3 ? (count = 3) : (count = self.imageArray.count);
//    if (count < 1) {
//
//        _addBtn.sd_layout
//        .topSpaceToView(_contentImageView, 9)
//        .rightSpaceToView(_contentImageView, 0)
//        .widthIs(60)
//        .heightEqualToWidth();
//
//        [_contentImageView setupAutoHeightWithBottomView:_addBtn bottomMargin:9];
//        [_headerView setupAutoHeightWithBottomView:_bottomview bottomMargin:0];
//        [self.tableview.tableHeaderView layoutIfNeeded];
//        self.tableview.tableHeaderView = _headerView;
//    }else{
//        for (int i=0; i<count; i++)
//        {
//            NSInteger row = i / ECA;
//            NSInteger colom = i % ECA;
//            UIImageView *imgv = [[UIImageView alloc] init];
//            CGFloat imgX =  colom * (margin + width) + margin;
//            CGFloat imgY =  row * (margin + height) + margin;
//            imgv.frame = CGRectMake(imgX, imgY, width, height);
//            imgv.image = self.imageArray[i];
//            imgv.contentMode = UIViewContentModeScaleAspectFill;
//            imgv.clipsToBounds = YES;
//            imgv.userInteractionEnabled = YES;
//            [_contentImageView addSubview:imgv];
//            //添加手势
//            imgv.tag = 100000+i;
//
//            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showQuestionPicture:)];
//            tap.view.tag = 100000+i;
//            [imgv addGestureRecognizer:tap];
//            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
//            delete.frame = CGRectMake(width-16, 0, 16, 16);
//            [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
//            [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
//            delete.tag = 10+i;
//            [imgv addSubview:delete];
//
//            _addBtn.sd_layout
//            .leftSpaceToView(imgv, margin)
//            .topEqualToView(imgv)
//            .bottomEqualToView(imgv)
//            .widthIs(60);
//
//            [_contentImageView setupAutoHeightWithBottomView:imgv bottomMargin:9];
//
//            [_headerView setupAutoHeightWithBottomView:_bottomview bottomMargin:0];
//        }
//
//        [self.tableview.tableHeaderView layoutIfNeeded];
//        self.tableview.tableHeaderView = _headerView;
//    }
//}


//- (void)showQuestionPicture:(UITapGestureRecognizer *)tap{
//    [HUPhotoBrowser showFromImageView:_contentImageView.subviews[tap.view.tag - 100000] withImages:self.imageArray atIndex:tap.view.tag - 100000 dismiss:nil];
//}


//- (void)deleteEvent:(UIButton *)deletBtn{
//    [self.imageArray removeObjectAtIndex:deletBtn.tag-10];
//    [self nineMarketGrid];
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MATERIALDETAILCELLID = @"MATERIALDETAILCELLID";
    RSMaterialDetailsSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:MATERIALDETAILCELLID];
    if (!cell) {
        cell = [[RSMaterialDetailsSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MATERIALDETAILCELLID];
    }
   // cell.titleLabel.text = self.titleArray[indexPath.row];
    //cell.materiaTypeLabel.text = self.detailArray[indexPath.row];
    RSRoleModel * rolemodel = self.imageArray[indexPath.row];
    cell.nameDetialLabel.text = rolemodel.roleName;
    cell.editBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(materialDetailsDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(materialDetailsEditAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//FIXME:删除
- (void)materialDetailsDeleteAction:(UIButton *)deleteBtn{
     //URL_DELETEROLE_IOS
     RSRoleModel * rolemodel = self.imageArray[deleteBtn.tag];
    
    
    if (self.usermodel.pwmsUser.roleId == rolemodel.roleID) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"不能删除自己的账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
        
    }else{
        
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该项" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [self reloadRoleAllNewDataWithURL:URL_DELETEROLE_IOS andType:@"delete" andRoleID:rolemodel.roleID andIndex:deleteBtn.tag];
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
}


//URL,参数不同，返回的结果不同
- (void)reloadRoleAllNewDataWithURL:(NSString *)URL andType:(NSString *)type andRoleID:(NSInteger)roleId andIndex:(NSInteger)index{
    //URL_ROLELIST_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    if ([type isEqualToString:@"list"]) {
        //获取列表
    }else{
        //删除
        [phoneDict setObject:[NSNumber numberWithInteger:roleId] forKey:@"roleId"];
    }
    // [phoneDict setObject:[NSNumber numberWithInteger:accountId] forKey:@"userId"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL resutl = [json[@"success"]boolValue];
            //RSRoleModel.h
            if (resutl) {
                if ([type isEqualToString:@"list"]) {
                    [weakSelf.imageArray removeAllObjects];
                    weakSelf.imageArray = [RSRoleModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [weakSelf.tableview reloadData];
                }else{
                    [weakSelf.imageArray removeObjectAtIndex:index];
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                    [weakSelf.tableview reloadData];
                }
            }else{
                if ([type isEqualToString:@"list"]) {
                    [SVProgressHUD showErrorWithStatus:@"请求失败"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"该角色已使用 无法删除"];
                }
            }
        }else{
            if ([type isEqualToString:@"list"]) {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                // [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"该角色已使用 无法删除"];
            }
        }
    }];
}

//FIXME:获取角色的列表
- (void)reloadRoleNewData{
    [self reloadRoleAllNewDataWithURL:URL_ROLELIST_IOS andType:@"list" andRoleID:0 andIndex:0];
}

//编辑
- (void)materialDetailsEditAction:(UIButton *)editBtn{
    RSRoleModel * rolemodel = self.imageArray[editBtn.tag];
    if (self.usermodel.pwmsUser.roleId == rolemodel.roleID) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"不能编辑自己的账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        RSNewRoleViewController * newRoleVc = [[RSNewRoleViewController alloc]init];
        newRoleVc.usermodel = self.usermodel;
        newRoleVc.rolemodel = rolemodel;
        newRoleVc.selectType = @"edit";
        [self.navigationController pushViewController:newRoleVc animated:YES];
        newRoleVc.reload = ^(BOOL success) {
            if (success) {
                [self reloadRoleNewData];
            }
        };
    }
}



//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
