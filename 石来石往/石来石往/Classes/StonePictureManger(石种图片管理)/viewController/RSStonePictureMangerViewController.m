//
//  RSStonePictureMangerViewController.m
//  石来石往
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSStonePictureMangerViewController.h"
#import "RSErrorView.h"
#import "RSHeaderReusableView.h"
#import "RSFootReusableView.h"
#import "RSStonePictureCollectionViewCell.h"
#import "RSStonePictureModel.h"
#import "RSStoneImageModel.h"
#import "UIImageView+WebCache.h"
#import <MJRefresh.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "RSStoneFlowLayout.h"
#import <HUPhotoBrowser.h>
//,UIImagePickerControllerDelegate,UINavigationControllerDelegate,
@interface RSStonePictureMangerViewController ()<RSStonePictureCollectionViewCellDelegate>
{
    //用来判断是那组的
    NSInteger _selectSection;
}
// 用来存放Cell的唯一标示符
@property (nonatomic, strong) NSMutableDictionary *cellDic;
/**获取上啦刷新的页数*/
@property (nonatomic,assign)int pageNum;
/**获取是上啦刷新，还是下拉刷新的地方 true是下拉刷新，false是下来刷新*/
@property (nonatomic,assign)BOOL isRefresh;
@property (nonatomic,strong)RSStonePictureModel * stonePicturemodel;
@property (nonatomic,strong)UICollectionView * collectionview;
/**保存数据*/
@property (nonatomic,strong)NSMutableArray * stoneArray;

@end

@implementation RSStonePictureMangerViewController
- (NSMutableArray *)stoneArray{
    if (_stoneArray == nil) {
        _stoneArray = [NSMutableArray array];
    }
    return _stoneArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.hidesBottomBarWhenPushed = YES;
//    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMangerCustomCollectionview];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.title = @"石种图片上传";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageNum = 2;
    [self loadStonePictureMangerData];
    
}

//下拉
- (void)loadStonePictureMangerData{
    self.isRefresh = true;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"1000"] forKey:@"item_num"];
    [phoneDict setObject:self.userModel.userID forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId": applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_STONE_LIULANG_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = nil;
                array = json[@"Data"];
                 [weakSelf.stoneArray removeAllObjects];
                if (array.count >= 1) {
                    for (int j = 0; j < array.count; j++) {
                        RSStonePictureModel * stonePicturemodel = [[RSStonePictureModel alloc]init];
                        stonePicturemodel.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        stonePicturemodel.proName = [[array objectAtIndex:j]objectForKey:@"proName"];
                        stonePicturemodel.sysUserId = [[array objectAtIndex:j]objectForKey:@"sysUserId"];
                        NSMutableArray * imgs = nil;
                        imgs = [[array objectAtIndex:j]objectForKey:@"photos"];
                        if (imgs.count == 0) {
                            NSMutableArray * tempArray = [NSMutableArray array];
                            for (int i = 0; i < 1; i++) {
                                RSStoneImageModel * stoneImagemodel = [[RSStoneImageModel alloc]init];
                                stoneImagemodel.url = @"";
                                stoneImagemodel.checkStatus = 343434;
                                stoneImagemodel.checkMessage = @"";
                                stoneImagemodel.imageID = @"1111111111111";
                                [tempArray addObject:stoneImagemodel];
                            }
                            stonePicturemodel.photos = tempArray;
                        }else{
                            NSMutableArray * tempArray = [NSMutableArray array];
                            //这边还要在添加一个数据
                            int i = 0;
                            for (; i < imgs.count; i++) {
                                RSStoneImageModel * stoneImagemodel = [[RSStoneImageModel alloc]init];
                                stoneImagemodel.checkStatus = [[[imgs objectAtIndex:i]objectForKey:@"checkStatus"] integerValue];
                                stoneImagemodel.checkMessage = [[imgs objectAtIndex:i]objectForKey:@"checkMessage"] ;
                                stoneImagemodel.imageID = [[imgs objectAtIndex:i]objectForKey:@"id"];
                                stoneImagemodel.url = [[imgs objectAtIndex:i]objectForKey:@"url"];
                                [tempArray addObject:stoneImagemodel];
                            }
                            if (i == imgs.count) {
                                for (int i = 0; i < 1; i++) {
                                    RSStoneImageModel * stoneImagemodel = [[RSStoneImageModel alloc]init];
                                    stoneImagemodel.url = @"";
                                    stoneImagemodel.checkStatus = 343434;
                                    stoneImagemodel.checkMessage = @"";
                                    stoneImagemodel.imageID = @"1111111111111";
                                    [tempArray addObject:stoneImagemodel];
                                }
                            }
                            if (tempArray.count > 6) {
                                [tempArray removeLastObject];
                            }
                            stonePicturemodel.photos = tempArray;
                        }
                      [weakSelf.stoneArray addObject:stonePicturemodel];
                    }
                }
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_header endRefreshing];
                self.pageNum = 2;
            }
        }else{
            [weakSelf.collectionview.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}








static NSString * HEADERRUESHID = @"headerrueshid";
static NSString * FOOTID = @"footid";
static NSString * COLLECTIONVIEWCELLID = @"collectionviewcellid";
#pragma mark -- 添加自定义导航栏
- (void)addMangerCustomCollectionview{
    
    RSStoneFlowLayout * stoneflowlayout = [[RSStoneFlowLayout alloc]init];
    
    //UICollectionViewFlowLayout *flowlayoutitem = [[UICollectionViewFlowLayout alloc]init];
    
   // flowlayoutitem.itemSize = CGSizeMake(100,100);
   // flowlayoutitem.minimumLineSpacing = 20;
   // flowlayoutitem.minimumInteritemSpacing = 0;
   // flowlayoutitem.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar) collectionViewLayout:stoneflowlayout];
    
    self.collectionview.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
//    self.collectionview.dataSource = self;
//    self.collectionview.delegate = self;
    
    self.collectionview.contentInset = UIEdgeInsetsMake(136, 0, 0, 0);
    //这边要添加tableviewHeaderView的视图
    RSErrorView * errorview = [[RSErrorView alloc]initWithFrame:CGRectMake(0, -136, SCW, 136)];
    errorview.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
    
    [self.collectionview registerClass:[RSHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERRUESHID];
    [self.collectionview registerClass:[RSFootReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTID];
    //[self.collectionview registerClass:[RSStonePictureCollectionViewCell class] forCellWithReuseIdentifier:COLLECTIONVIEWCELLID];
    [self.collectionview addSubview:errorview];
    [self.view addSubview:self.collectionview];
    //下拉
    RSWeakself
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadStonePictureMangerData];
    }];
    //上拉
    self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    RSStonePictureModel * stonePicturesmodel = self.stoneArray[section];
    return stonePicturesmodel.photos.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.stoneArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCW, 37);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCW, 11);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (iPhone4 || iPhone5) {
       return CGSizeMake(90, 90);
    }else if(iPhone6){
        return CGSizeMake(100, 100);
    }else if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS){
        return CGSizeMake(100, 100);
    }else{
        return CGSizeMake(120, 120);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            RSHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERRUESHID forIndexPath:indexPath];
            RSStonePictureModel * stonePicturemodel = self.stoneArray[indexPath.section];
            header.productLabel.text = [NSString stringWithFormat:@"%@",stonePicturemodel.proName];
            return header;
        }else{
            RSFootReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTID forIndexPath:indexPath];
            return foot;
        }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    /*
     // 每次先从字典中根据IndexPath取出唯一标识符
     NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
     // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
     if (identifier == nil) {
     identifier = [NSString stringWithFormat:@"%@%@", DayCell, [NSString stringWithFormat:@"%@", indexPath]];
     [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
     // 注册Cell
     [self.collectionView registerClass:[CalendarCollectionViewCell class]  forCellWithReuseIdentifier:identifier];
     }
     CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
     */
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", @"stone", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
        [self.collectionview registerClass:[RSStonePictureCollectionViewCell class]  forCellWithReuseIdentifier:identifier];
    }
    RSStonePictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    RSStonePictureModel * stonePicturemodel = self.stoneArray[indexPath.section];
    RSStoneImageModel * stoneImagemodel = stonePicturemodel.photos[indexPath.row];
    cell.stoneImagemodel = stoneImagemodel;
    cell.delegate = self;
    //这边是用来判断的最后的图片要可以点击效果
    if (stonePicturemodel.photos.lastObject) {
       cell.userInteractionEnabled = YES;
        if ([stoneImagemodel.url isEqualToString:@""]) {
            cell.deleteBtn.hidden = YES;
            cell.adoptImage.hidden = YES;
        }else{
            //cell.adoptImage.hidden = YES;
            cell.deleteBtn.hidden = NO;
        }
    }else{
        cell.deleteBtn.hidden = NO;
        cell.userInteractionEnabled = NO;
    }
    cell.stoneImagemodel = stoneImagemodel;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RSStonePictureCollectionViewCell *cell = (RSStonePictureCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    RSStonePictureModel * stonePicturemodel = self.stoneArray[indexPath.section];
    RSStoneImageModel * stoneImageModel = stonePicturemodel.photos[indexPath.row];
    if (indexPath.row == stonePicturemodel.photos.count - 1) {
        if ([stoneImageModel.url isEqualToString:@""]) {
             [self addPicture:stonePicturemodel andSection:indexPath.section];
        }else{
        [self showBrowserPictureRSStonePictureCollectionViewCell:cell andRSStonePictureModel:stonePicturemodel andIndexpath:indexPath];
        }
    }else{
        [self showBrowserPictureRSStonePictureCollectionViewCell:cell andRSStonePictureModel:stonePicturemodel andIndexpath:indexPath];
    }
}

#pragma mark -- 跳转到图片浏览器-- 由于ios11.0第三方好像不支持一样，就用了俩中浏览器
- (void)showBrowserPictureRSStonePictureCollectionViewCell:(RSStonePictureCollectionViewCell *)cell andRSStonePictureModel:(RSStonePictureModel *)stonePicturemodel andIndexpath:(NSIndexPath *)indexpath{
    NSMutableArray * imagUrls = [NSMutableArray array];
    for (RSStoneImageModel * stoneImagemodel in stonePicturemodel.photos) {
        if (![stoneImagemodel.url isEqualToString:@""]) {
            [imagUrls addObject:stoneImagemodel.url];
        }
    }
    [HUPhotoBrowser showFromImageView:cell.addImage withURLStrings:imagUrls atIndex:indexpath.row];
}

- (void)deleteShowPicturestonePicturecell:(RSStonePictureCollectionViewCell *)stonePicturecell{
    NSIndexPath * indexpath = [self.collectionview indexPathForCell:stonePicturecell];
    RSStonePictureModel * stonePicturemodel = self.stoneArray[indexpath.section];
    RSStoneImageModel * stoneImagemodel = stonePicturemodel.photos[indexpath.row];
    NSString * imageID = stoneImagemodel.imageID;
    [self deletStonePicture:imageID andNSIndexPath:indexpath];
}

/*
#pragma mark -- 删除图片
- (void)deleteShowPicture:(UIButton *)sender{
    RSStonePictureCollectionViewCell * cell = (RSStonePictureCollectionViewCell *)[[sender superview] class];
    NSIndexPath * indexpath = [self.collectionview indexPathForCell:cell];
    RSStonePictureModel * stonePicturemodel = self.stoneArray[indexpath.section];
    RSStoneImageModel * stoneImagemodel = stonePicturemodel.photos[indexpath.row];
    NSString * imageID = stoneImagemodel.imageID;
    [self deleteShowPicture:imageID];
}
*/

-(void)deletStonePicture:(NSString *)imageID  andNSIndexPath:(NSIndexPath *)indexpath{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:imageID forKey:@"imgId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //POST参数
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_STONE_SINGLE_DELETE_PICTURE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [weakSelf.collectionview.mj_header beginRefreshing];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [weakSelf.collectionview scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    }];
}


#pragma mark -- 添加图片
- (void)addPicture:(RSStonePictureModel *)stonePicturemodel andSection:(NSInteger)section{
    _selectSection = section;
    _stonePicturemodel = stonePicturemodel;
    //[self openPhotoAlbumAndOpenCamera];
    RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
    [selectTool openPhotoAlbumAndOpenCameraViewController:self];
    selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
        _photoEntityWillUpload = photoEntityWillUpload;
        [self uploadNewNetworkData];
    };
}

- (void)uploadNewNetworkData{
        //这边要怎么上传图片呢？
        NSArray *avatarArray = [NSArray arrayWithObject:_photoEntityWillUpload.image];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSData *imageData;
        for (UIImage *avatar in avatarArray)
        {
            imageData = UIImageJPEGRepresentation(avatar, 1);
            [dataArray addObject:imageData];
        }
        [self uploadSinglePictureImage:dataArray];
    
}

- (void)uploadSinglePictureImage:(NSMutableArray *)imagesArray{
    [SVProgressHUD showWithStatus:@"正在上传中....."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    RSStonePictureModel * stonePicturemodel = self.stoneArray[_selectSection];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:stonePicturemodel.proName forKey:@"proName"];
    [dict setObject:self.userModel.userID forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //POST参数
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getImageDataWithUrlString:URL_STONE_SINGLE_PICTURE_IOS withParameters:parameters andDataArray:imagesArray withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.collectionview.mj_header beginRefreshing];
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectSection] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
                });
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
                [weakSelf.collectionview.mj_header endRefreshing];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
            [weakSelf.collectionview.mj_header endRefreshing];
        }
    }];
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
