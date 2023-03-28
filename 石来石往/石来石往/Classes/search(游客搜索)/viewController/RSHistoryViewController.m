//
//  RSHistoryViewController.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHistoryViewController.h"

#import "RSSelectCollectionLayout.h"

#import "RSSelectCollectionReusableView.h"

#import "RSSearchCollectionViewCell.h"

#import "RSDBHandle.h"

#import "RSSearchSecondModel.h"

#import "RSSearchSectionModel.h"

#import "RSHistoryCell.h"


/**实时搜索的模型*/
#import "RSHistorySearchModel.h"

#import "RSNSStringColorTool.h"


#import "RSSearchHuangAndDabanViewController.h"
#import "RSDetailSegmentViewController.h"

@interface RSHistoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionReusableViewButtonDelegate,SelectCollectionCellDelegate,UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

{  //删除textfield内容的按键
    UIButton * _cancleBtn;
}


/**存储网络请求的热搜，与本地缓存的历史搜索model数组*/
@property (nonatomic,strong)NSMutableArray * sectionArray;

/**搜索的数组字典*/
@property (nonatomic,strong)NSMutableArray * searchArray;


/**搜索框中输入的值，网络请求之后的数组*/
@property (nonatomic,strong)NSMutableArray * historyArray;


@end

@implementation RSHistoryViewController

- (NSMutableArray *)sectionArray{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

- (NSMutableArray *)searchArray{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}




- (NSMutableArray *)historyArray{
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}


static NSString *const rsSearchCollectionViewCell = @"rsSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";

static NSString * tableviewID = @"tableviewID";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"------------------%d",self.navigationController.navigationBar.isTranslucent);
    self.navigationController.navigationBar.translucent = YES;
//    NSLog(@"------------------%d",self.navigationController.navigationBar.isTranslucent);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCW * 0.65, 35)];
    view.layer.borderWidth = 2;
    view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    view.layer.cornerRadius = 15;
    view.layer.borderColor = [UIColor colorWithHexColorStr:@"f1f1f1"].CGColor;
    self.navigationItem.titleView = view;
    
    
    UIImageView * searchImage = [[UIImageView alloc]init];
    searchImage.image = [UIImage imageNamed:@"cxSearch"];
    [view addSubview:searchImage];
    
    searchImage.sd_layout.leftSpaceToView(view, 5).topSpaceToView(view, 7.5).bottomSpaceToView(view, 7.5).widthIs(20);
    
    UITextField * textfield = [[UITextField alloc]init];
//    textfield.backgroundColor = [UIColor clearColor];
    textfield.returnKeyType = UIReturnKeySearch;
    [textfield becomeFirstResponder];
    textfield.delegate = self;
    textfield.placeholder = @"找石材";
    _rsSearchTextField = textfield;
    [view addSubview:textfield];
    
    textfield.sd_layout.leftSpaceToView(searchImage, 10).topEqualToView(view).bottomEqualToView(view).widthRatioToView(view, 0.7);
    
    UIButton * cancleBtn = [[UIButton alloc]init];
    _cancleBtn = cancleBtn;
    cancleBtn.hidden = YES;
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"删除-(2)"] forState:UIControlStateNormal];
    [view addSubview:cancleBtn];
    
    [cancleBtn addTarget:self action:@selector(removeSearchContent:) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.sd_layout.leftSpaceToView(textfield, 20).rightSpaceToView(view, 10).topSpaceToView(view, 7.5).bottomSpaceToView(view,7.5).widthIs(19);
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 35)];
    [searchBtn setTitle:@"取消" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBtn addTarget:self action:@selector(currentSearchTextfield:) forControlEvents:UIControlEventTouchUpInside];
//    self.view.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = item;
    [self addCustomRSSearchCollectionView];
    [self prepareData];
    /***  可以做实时搜索*/
    [self.rsSearchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self addCustomTableviewConntroller];
}


- (void)addCustomRSSearchCollectionView{
    self.rsSearchCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar) collectionViewLayout:[[RSSelectCollectionLayout alloc]init]];
    self.rsSearchCollectionView.backgroundColor = [UIColor whiteColor];
    self.rsSearchCollectionView.delegate= self;
    self.rsSearchCollectionView.dataSource = self;
    self.rsSearchCollectionView.scrollEnabled = false;
    [self.rsSearchCollectionView registerClass:[RSSelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [self.rsSearchCollectionView registerClass:[RSSearchCollectionViewCell class] forCellWithReuseIdentifier:rsSearchCollectionViewCell];
    [self.view addSubview:self.rsSearchCollectionView];
}


- (void)addCustomTableviewConntroller{
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCW, SCH) style:UITableViewStyleGrouped];
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.hidden = YES;
    [self.tableview registerClass:[RSHistoryCell class] forCellReuseIdentifier:tableviewID];
}

#pragma mark -- 实时搜索
- (void)textFieldChange:(UITextField *)textfield{
    UITextField * textField = textfield;
    if(textField.markedTextRange == Nil){
        _cancleBtn.hidden = NO;
        self.tableview.hidden = NO;
//        self.rsSearchCollectionView.hidden = YES;
        self.rsSearchTextField.text = textField.text;
        //实时搜索
        [self realTimeSearch:self.rsSearchTextField.text];
    }else{
        _cancleBtn.hidden = YES;
        self.tableview.hidden = YES;
//        self.rsSearchCollectionView.hidden = NO;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:tableviewID];
    RSHistorySearchModel * historySearchModel = self.historyArray[indexPath.row];
    NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.rsSearchTextField.text andModelStr:historySearchModel.mtlname];
    cell.nameLabel.attributedText = attributedstring;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



//FIXME:UITableviewCell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // 这边还要从模型里面拿到数据添加到历史记录中
    if (![self.searchArray containsObject:[NSDictionary dictionaryWithObject:self.rsSearchTextField.text forKey:@"content_name"]]) {
        [self reloadData:self.rsSearchTextField.text];
    }
    [self.rsSearchTextField resignFirstResponder];
    RSHistorySearchModel * historySearchModel  = self.historyArray[indexPath.row];
    self.rsSearchTextField.text = [NSString stringWithFormat:@"%@",historySearchModel.mtlname];
//    self.rsSearchCollectionView.hidden = NO;
   // self.contentScrollview.hidden = NO;
    //self.titleview.hidden = NO;
    self.tableview.hidden = YES;
    //[self reloadChildViewController];
    if ([historySearchModel.type isEqualToString:@"2"]) {
        RSDetailSegmentViewController * detailVc = [[RSDetailSegmentViewController alloc]init];
        detailVc.tempStr1 =@"-1";
        detailVc.tempStr2 = @"-1";
        detailVc.tempStr3 = @"-1";
        detailVc.tempStr4 = @"-1";
        detailVc.btnStr1 = @"-1";
        detailVc.btnStr2 = @"-1";
        detailVc.btnStr3 = @"-1";
        detailVc.btnStr4 = @"-1";
        detailVc.imageUrl = historySearchModel.imgUrl;
        detailVc.shitouName = historySearchModel.stoneId;
        //数量
        detailVc.keAndZaStr = historySearchModel.turnsQty;
        detailVc.piAndFangStr = historySearchModel.vaqty;
        detailVc.title = historySearchModel.stoneId;
        detailVc.dataSource = @"HXSC";
        detailVc.phone = historySearchModel.phone;
        detailVc.weight = historySearchModel.weight;
        detailVc.stoneName = historySearchModel.stoneId;
        detailVc.companyName = historySearchModel.companyName;
        detailVc.searchType = historySearchModel.stockType;
        detailVc.titleStr = historySearchModel.blockId;
        detailVc.userModel = self.userModel;
        detailVc.erpCode = historySearchModel.erpCode;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        //这边要进行一个判断是那种类型
        RSSearchHuangAndDabanViewController * searchHuangAndDabanVc = [[RSSearchHuangAndDabanViewController alloc]init];
        searchHuangAndDabanVc.usermodel = self.userModel;
        searchHuangAndDabanVc.searchStr = self.rsSearchTextField.text;
        searchHuangAndDabanVc.title = self.rsSearchTextField.text;
        [self.navigationController pushViewController:searchHuangAndDabanVc animated:YES];
    }
}

#pragma mark -- 实时搜索
- (void)realTimeSearch:(NSString *)str{
    //URL_REALTIMESEARCH URL_HEADER_ATTION_SEARCH_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",str] forKey:@"search_text"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_ATTION_SEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSLog(@"-----222-------------%d",weakSelf.navigationController.navigationBar.isTranslucent);
                weakSelf.navigationController.navigationBar.translucent = YES;
                NSLog(@"------------------%d",weakSelf.navigationController.navigationBar.isTranslucent);
                
               [weakSelf.historyArray removeAllObjects];
               weakSelf.historyArray = [RSHistorySearchModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
               [weakSelf.tableview reloadData];
            }
        }
    }];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    RSSearchSectionModel *sectionModel =  self.sectionArray[section];
    return sectionModel.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RSSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:rsSearchCollectionViewCell forIndexPath:indexPath];
    RSSearchSectionModel *sectionModel = self.sectionArray[indexPath.section];
    RSSearchSecondModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.content_name forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        RSSelectCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        RSSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
            [view setImage:@"cxCool"];
            view.delectButton.hidden = YES;
        }else{
            [view setImage:@"cxSearch"];
            view.delectButton.hidden = NO;
        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RSSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        RSSearchSecondModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [RSSearchCollectionViewCell getSizeWithText:contentModel.content_name];
    }
    return CGSizeMake(80, 24);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - SelectCollectionCellDelegate点击搜索过的
- (void)selectButttonClick:(RSSearchCollectionViewCell *)cell;
{
    [self.rsSearchTextField resignFirstResponder];
    NSIndexPath* indexPath = [self.rsSearchCollectionView indexPathForCell:cell];
    RSSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    RSSearchSecondModel *contentModel = sectionModel.section_contentArray[indexPath.row];
   // [self jumpSegmentViewController:contentModel.content_name];
    self.rsSearchTextField.text  = [NSString stringWithFormat:@"%@",contentModel.content_name];
   // self.rsSearchCollectionView.hidden = YES;
    self.tableview.hidden = NO;
    _cancleBtn.hidden = NO;
    [self realTimeSearch:self.rsSearchTextField.text];
}


#pragma mark -- 长按需要做的事情
- (void)longSelectButttonClick:(UILongPressGestureRecognizer *)longPress{
    CGPoint location = [longPress locationInView:self.rsSearchCollectionView];
    NSIndexPath * indexpath = [self.rsSearchCollectionView indexPathForItemAtPoint:location];
    if (indexpath.section == 0) return;
    RSWeakself
    [JHSysAlertUtil presentAlertViewWithTitle:@"温馨提示" message:@"你要对这个值进行删除吗" cancelTitle:@"确定" defaultTitle:@"取消" distinct:NO cancel:^{
        //这边是要你删除的东西
           RSSearchSectionModel *sectionModel =  weakSelf.sectionArray[indexpath.section];
           RSSearchSecondModel *contentModel = sectionModel.section_contentArray[indexpath.row];
       for (int j=0; j<weakSelf.searchArray.count; j++) {
           if ([weakSelf.searchArray[j][@"content_name"] isEqualToString:contentModel.content_name]) {
               [weakSelf.searchArray removeObjectAtIndex:j];
           }
       }
       sectionModel.section_contentArray = [NSMutableArray arrayWithArray:self.searchArray];
       [weakSelf.rsSearchCollectionView reloadData];
       [weakSelf deleteSearchModelName:self.searchArray];
    } confirm:^{}];
}



#pragma mark -- 删除没有collectviewCell的东西
- (void)deleteSearchModelName:(NSArray *)array{
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":array};
    NSDictionary *parmDict  = @{@"category":@"1"};
    [RSDBHandle saveStatuses:searchDict andParam:parmDict];
    RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.rsSearchCollectionView reloadData];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(RSSelectCollectionReusableView *)view;
{
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
        [self.searchArray removeAllObjects];
        [self.rsSearchCollectionView reloadData];
        [RSDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
    }
}

#pragma mark - scrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   [self.rsSearchTextField resignFirstResponder];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//}


#pragma mark - textFieldDelegate 代理方法了
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.rsSearchTextField resignFirstResponder];
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
         //[self.rsSearchTextField resignFirstResponder];
        return NO;
    }
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
       //[self realTimeSearch:textField.text];
        self.tableview.hidden = YES;
//        self.rsSearchCollectionView.hidden = YES;
        self.rsSearchTextField.text = textField.text;
        return YES;
    }
    self.tableview.hidden = YES;
//    self.rsSearchCollectionView.hidden = YES;
    [self reloadData:textField.text];
    self.rsSearchTextField.text = textField.text;
   //[self realTimeSearch:self.rsSearchTextField.text];
    return YES;
}

#pragma mark -- 跳转转到RSHuangAndDaViewController中
- (void)jumpSegmentViewController:(NSString *)str{
    /*
    //这边要做一个跳转界面的东西
    YBSegmentViewController * segmentVc = [[YBSegmentViewController alloc]init];
    segmentVc.searchStr = str;
    segmentVc.searchType = self.searchType;
    segmentVc.userModel = self.userModel;
    //[self.rsSearchTextField resignFirstResponder];
    [self.navigationController pushViewController:segmentVc animated:YES];
    */
//     RSHuangAndDaViewController * huangAndDaVc = [[RSHuangAndDaViewController alloc]init];
//     huangAndDaVc.userModel = self.userModel;
//     huangAndDaVc.searchStr = str;
//     [self.navigationController pushViewController:huangAndDaVc animated:YES];
}

- (void)prepareData
{
    /**
     *  测试数据 ，字段暂时 只用一个 titleString，后续可以根据需求 相应加入新的字段
     */
    //,@{@"content_name":@"口红"},@{@"content_name":@"眼霜"},@{@"content_name":@"洗面奶"},@{@"content_name":@"防晒霜"},@{@"content_name":@"补水"},@{@"content_name":@"香水"},@{@"content_name":@"眉笔"}
    NSDictionary *testDict = @{@"section_id":@"1",@"section_title":@"热搜",@"section_content":@[@{@"content_name":@"奥特曼"},@{@"content_name":@"白玉兰"}]};
    NSMutableArray *testArray = [@[] mutableCopy];
    [testArray addObject:testDict];
    /***  去数据查看 是否有数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [RSDBHandle statusesWithParams:parmDict];
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    for (NSDictionary *sectionDict in testArray) {
        RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}

- (void)reloadData:(NSString *)textString
{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [RSDBHandle saveStatuses:searchDict andParam:parmDict];
    
    RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.rsSearchCollectionView reloadData];
    //self.rsSearchTextField.text = @"";
}

#pragma mark -- 点击当前搜索(取消)
- (void)currentSearchTextfield:(UIButton *)btn{
    [self.rsSearchTextField resignFirstResponder];
    self.rsSearchTextField.text = @"";
    self.tableview.hidden = YES;
//    self.rsSearchCollectionView.hidden = NO;
    _cancleBtn.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 移除当前显示搜索的内容
- (void)removeSearchContent:(UIButton *)btn{
    self.rsSearchTextField.text = @"";
//    self.rsSearchCollectionView.hidden = NO;
    self.tableview.hidden = YES;
    _cancleBtn.hidden = YES;
}



- (void)backUpHSViewController{
    self.rsSearchTextField.text = @"";
    self.tableview.hidden = YES;
//    self.rsSearchCollectionView.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}





@end
