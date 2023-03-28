//
//  RSTradingAreaView.m
//  石来石往
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSTradingAreaView.h"
#import "RSTradingAreaModel.h"
#import "RSTradViewCell.h"

#import "RSNewSearchCollectionCell.h"
#import "RSNewSearchHeaderReusableView.h"
#import "RSNewSearchImageCell.h"
#import "RSChangeSelectSearchContentView.h"

#import "RSHotStoneModel.h"
#import "CommentView.h"


@interface RSTradingAreaView() <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextViewDelegate,RSChangeSelectSearchContentViewDelegate,MomentCellDelegate,UITextFieldDelegate>

//@property (nonatomic,assign)NSInteger nowpage;
//
//@property (nonatomic,strong)NSString * searchStr;


@property (nonatomic,strong)UICollectionView * collectionview;

/**搜索历史的数组*/
@property (nonatomic,strong)NSMutableArray * newSerachArray;


@property (nonatomic,strong)RSChangeSelectSearchContentView * changeSelectView;

//全部按键
@property (nonatomic,strong)UIButton * allBtn;

/**猜你喜欢的数组*/
@property (nonatomic,strong)NSMutableArray * likeStoneArray;


@property (nonatomic,strong)NSMutableString * str;

/**获取是上啦刷新，还是下拉刷新的地方 true是下拉刷新，false是下来刷新*/
@property (nonatomic,assign)BOOL isRefresh;
/**获取上啦刷新的页数*/
@property (nonatomic,assign)int pageNum;
/**选择你要看的选择的类型*/
@property (nonatomic,strong)NSString * selectStr;

/**评论的模型*/
@property (nonatomic,strong)Comment * currentComment;

/**商圈的Cell*/
@property (nonatomic,strong)MomentCell * cell;

/**评论框*/
//@property (nonatomic,strong)UITextField * currenttextfield;

/**区分点击了那个类型的全部，荒料等按键*/
@property (nonatomic,strong)NSString * selectType;

/**清除搜索的按键*/
@property (nonatomic,strong)UIButton * deleteBtn;

@property(nonatomic,strong)CommentView *cmtView;

@end


@implementation RSTradingAreaView

- (NSMutableArray *)searchDataArray{
    
    if (!_searchDataArray) {
        
        _searchDataArray = [NSMutableArray array];
    }
    return _searchDataArray;
}


- (NSMutableArray *)likeStoneArray{
    if (!_likeStoneArray) {
        _likeStoneArray = [NSMutableArray array];
    }
    return _likeStoneArray;
}
- (NSMutableString *)str{
    if (!_str) {
        _str = [NSMutableString string];
    }
    return _str;
}

- (NSMutableArray *)newSerachArray{
    if (!_newSerachArray) {
        _newSerachArray = [NSMutableArray array];
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        for (NSString * str in array) {
            [_newSerachArray addObject:str];
            
        }
    }
    return _newSerachArray;
}


- (RSChangeSelectSearchContentView *)changeSelectView{
    if (!_changeSelectView) {
        CGFloat H = 0.0;
        CGFloat bottomH = 0.0;
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            H = 88;
            bottomH = 34;
        }else{
            H = 64;
            bottomH = 0.0;
        }
        _changeSelectView = [[RSChangeSelectSearchContentView alloc]initWithFrame:CGRectMake(0, H, SCW, self.bounds.size.height - H)];
        _changeSelectView.delegate = self;
    }
    return _changeSelectView;
}


//- (UITextField *)currenttextfield{
//
//    if (!_currenttextfield) {
//        _currenttextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, SCH, SCW, 50)];
//        _currenttextfield.delegate = self;
//        _currenttextfield.textAlignment = NSTextAlignmentLeft;
//        _currenttextfield.textColor = [UIColor blackColor];
//        _currenttextfield.font = [UIFont systemFontOfSize:18];
//        _currenttextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//        _currenttextfield.placeholder = @"回复:";
//         _currenttextfield.returnKeyType = UIReturnKeySend;
//    }
//    return _currenttextfield;
//}


-(CommentView *)cmtView
{
    if (!_cmtView){
        _cmtView = [[CommentView alloc]initWithFrame:CGRectMake(0, SCH, SCW, 50)];
        _cmtView.inputView.delegate = self;
        _cmtView.inputView.zw_placeHolder = @"回复";
    }
    return _cmtView;
}




- (UITableView *)tableview{
    if (!_tableview) {
        CGFloat H = 0.0;
        CGFloat bottomH = 0.0;
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            H = 88;
            bottomH = 34;
        }else{
            H = 64;
            bottomH = 0.0;
        }
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, H, SCW, SCH - H) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.hidden = YES;
        _tableview.estimatedRowHeight =0;
        _tableview.estimatedSectionHeaderHeight =0;
        _tableview.estimatedSectionFooterHeight =0;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return _tableview;
}


- (UICollectionView *)collectionview{
    if (!_collectionview) {
        CGFloat H = 0.0;
        CGFloat bottomH = 0.0;
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            H = 88;
            bottomH = 34;
        }else{
            H = 64;
            bottomH = 0.0;
        }
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((SCW - 17 - 16 - 6)/3,80);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, H, SCW, self.bounds.size.height - H) collectionViewLayout:layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.hidden = NO;
        _collectionview.backgroundColor = [UIColor whiteColor];
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
    }
    return _collectionview;
}

static NSString * RSNEWSEARCHHEADERREUSABLEVIEW = @"RSNEWSEARCHHEADERREUSABLEVIEW";
static NSString * NEWCOLLECTIONVIEW = @"NEWCOLLECTIONVIEW";
static NSString * FRISTNEWCOLLECTIONVIEW = @"FRISTNEWCOLLECTIONVIEW";




- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //这边是要对进入评论详情界面做的事情。
        //删除其中一个商圈
        self.pageNum = 2;
        self.isRefresh = true;
        //这边要创建导航栏搜索框
        self.selectStr = @"";
        self.selectType = @"0";

        [self addSubview:self.tableview];
        
        [self addSubview:self.collectionview];
        [self.collectionview registerClass:[RSNewSearchCollectionCell class] forCellWithReuseIdentifier:FRISTNEWCOLLECTIONVIEW];
        [self.collectionview registerClass:[RSNewSearchImageCell class] forCellWithReuseIdentifier:NEWCOLLECTIONVIEW];
        [self.collectionview registerClass:[RSNewSearchHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RSNEWSEARCHHEADERREUSABLEVIEW];

        [self creatPlist];
        
        [self creatCustomSearchView];
        
        [self loadLikeStoneNewData];

          RSWeakself
        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf searchContentNewData];
        }];
        
        
      
        self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上拉加载更多
            [weakSelf searchContentMoreNewData];
        }];
        
        [self.tableview setupEmptyDataText:@"无加载数据" tapBlock:^{
            // [weakSelf searchContentNewData];
        }];
        
        
        //[self addSubview:self.currenttextfield];
        [self addSubview:self.cmtView];
        [self.cmtView bringSubviewToFront:self];
        //[self.currenttextfield bringSubviewToFront:self];
    }
    return self;
}



- (void)loadLikeStoneNewData{
    if (self.likeStoneArray.count < 1) {
        self.str = [NSMutableString stringWithFormat:@""];
    }else{
        for (int i = 0; i < self.likeStoneArray.count; i++) {
            RSHotStoneModel * hotStoneModel = self.likeStoneArray[i];
                [self.str appendString:[NSString stringWithFormat:@"%@,",hotStoneModel.stoneName]];
        }
        [self.likeStoneArray removeAllObjects];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInt:6] forKey:@"size"];
    [phoneDict setObject:self.str forKey:@"excludeList"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LIKESTONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                weakSelf.likeStoneArray = [RSHotStoneModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                  [weakSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
            }else{
                 [weakSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
            }
        }else{
              [weakSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }
    }];
}


//创建导航栏上面的视图
- (void)creatCustomSearchView{
  
    CGFloat H = 0.0;
    CGFloat bottomH = 0.0;
    CGFloat  Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        H = 88;
        bottomH = 34;
        Y = 47;
    }else{
        H = 64;
        Y = 27;
        bottomH = 0.0;
    }
    UIView * navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, H)];
    navigationView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self addSubview:navigationView];
    //这边是搜索界面的视图
    
    NSInteger width = 0;
    if (iPhone4 || iPhone5) {
        width = 260;
    }else{
        width = 293;
    }
    
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(17, Y, width, 29)];
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    searchView.layer.borderWidth = 1;
    searchView.layer.borderColor = [UIColor colorWithHexColorStr:@"#E5E5E5"].CGColor;
    searchView.layer.cornerRadius = 5;
    searchView.layer.masksToBounds = YES;
    [navigationView addSubview:searchView];
    
    
    //全部的按键
    UIButton * allBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 45, 20)];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    allBtn.selected = NO;
    [allBtn setBackgroundColor:[UIColor clearColor]];
    [allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [allBtn addTarget:self action:@selector(changSelectContent:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:allBtn];
    _allBtn = allBtn;
    
    //向下的图片
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allBtn.frame) + 4, 12, 10, 6)];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.image = [UIImage imageNamed:@"Shape"];
    [searchView addSubview:imageview];
    
    //搜索的界面
    UITextField * searchTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + 13, 0, searchView.yj_width - (CGRectGetMaxX(imageview.frame) + 13), 29)];
    
    
    searchTextfield.delegate = self;
    searchTextfield.borderStyle = UITextBorderStyleNone;
    searchTextfield.backgroundColor = [UIColor clearColor];
    searchTextfield.font = [UIFont systemFontOfSize:12];
    searchTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    searchTextfield.textAlignment = NSTextAlignmentLeft;
    searchTextfield.returnKeyType = UIReturnKeySend;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索全部" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"],
                                                                                                     NSFontAttributeName:searchTextfield.font}];
    searchTextfield.attributedPlaceholder = attrString;
    
    
    [searchView addSubview:searchTextfield];
    _searchTextfield = searchTextfield;
    
    
    
    UIButton * deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchView.frame) - 15 - 30, 7, 15, 15)];
    [deleteBtn setImage:[UIImage imageNamed:@"清除"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor clearColor]];
    [searchView addSubview:deleteBtn];
    deleteBtn.hidden = YES;
    [deleteBtn addTarget:self action:@selector(deleteAllSearchContent:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn bringSubviewToFront:searchView];
    _deleteBtn = deleteBtn;
    
    //取消按键
    UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchView.frame), Y, SCW - CGRectGetMaxX(searchView.frame), 29)];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [navigationView addSubview:cancelBtn];
    
    [cancelBtn addTarget:self action:@selector(cancelSearchContent:) forControlEvents:UIControlEventTouchUpInside];
    
}


/**清除所要搜索的内容*/
- (void)deleteAllSearchContent:(UIButton *)deletBtn{
    deletBtn.hidden = YES;
    self.collectionview.hidden = NO;
    self.tableview.hidden = YES;
    self.searchTextfield.text = @"";
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    //self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    //self.currenttextfield.placeholder = @"回复";
    //self.currenttextfield.text = @"";
    //[self.currenttextfield resignFirstResponder];
    [self.searchTextfield resignFirstResponder];
    
}

//全部的搜索按键
- (void)changSelectContent:(UIButton *)allBtn{
    
    allBtn.selected = !allBtn.selected;
    if (allBtn.selected) {
        //选中
        [self addSubview:self.changeSelectView];
        [self.changeSelectView showMenView];
    }else{
        //取消
        [self.changeSelectView removeFromSuperview];
        [self.changeSelectView hideMenView];
    }
    
}



#pragma mark -- RSChangeSelectSearchContentViewDelegate
- (void)hideSelectSearchContentView{
    
    self.allBtn.selected = NO;
    [self.changeSelectView removeFromSuperview];
    [self.changeSelectView hideMenView];
}

- (void)selectNeedSearchContent:(NSInteger)tag{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索全部" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"],
                                                                                                     NSFontAttributeName:_searchTextfield.font}];
    switch (tag) {
        case 10000:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索荒料" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"荒料" forState:UIControlStateNormal];
            self.selectStr = @"huangliao";
            break;
        case 10001:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索大板" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"大板" forState:UIControlStateNormal];
            self.selectStr = @"daban";
            break;
        case 10002:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索花岗岩" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"花岗岩" forState:UIControlStateNormal];
            
            self.selectStr = @"huagangyan";
            break;
        case 10003:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索生活" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"生活" forState:UIControlStateNormal];
            self.selectStr = @"shenghuo";
            break;
        case 10004:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索辅料" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"辅料" forState:UIControlStateNormal];
            self.selectStr = @"fuliao";
            break;
        case 10005:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索求购" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"求购" forState:UIControlStateNormal];
            self.selectStr = @"qiugou";
            break;
            
        case 100:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索全部" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
            self.selectStr = @"";
            break;
        default:
            attrString = [[NSAttributedString alloc] initWithString:@"搜索全部" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"], NSFontAttributeName:_searchTextfield.font}];
            _searchTextfield.attributedPlaceholder = attrString;
            [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
            self.selectStr = @"";
            break;
    }
    self.allBtn.selected = NO;
    self.searchTextfield.text = @"";
    self.tableview.hidden = YES;
    self.collectionview.hidden = NO;
    [self.searchTextfield resignFirstResponder];
    [self.changeSelectView removeFromSuperview];
    [self.changeSelectView hideMenView];
}





//取消搜索的内容
- (void)cancelSearchContent:(UIButton *)cancelBtn{
    _searchTextfield.text = @"";
    //self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索全部" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#C4C4C4"],
                                                                                                     NSFontAttributeName:_searchTextfield.font}];
    self.searchTextfield.attributedPlaceholder = attrString;
    [_searchTextfield resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(cancelBtnAction)]) {
        [self.delegate cancelBtnAction];
    }
    self.tableview.hidden = YES;
    self.collectionview.hidden = NO;
}



//创建Plist的文件
- (void)creatPlist{
    //将字典保存到document文件->获取appdocument路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //要创建的plist文件名 -> 路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
    //添加
    //    [self.newSerachArray addObject:@"白"];
    //    [self.newSerachArray addObject:@"白玉兰"];
    //    [self.newSerachArray addObject:@"奥特曼"];
    [self.newSerachArray writeToFile:filePath atomically:YES];
}


- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
            self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
            if ([temp length] < 1){
                self.cmtView.inputView.text = @"";
                self.tableview.hidden = YES;
                self.cmtView.inputView.zw_placeHolder = @"回复";
                self.collectionview.hidden = NO;
            }else{
                self.cmtView.inputView.text = temp;
                //如果等于1那么传的是userId ,2 就是传commentUserId
                NSString * str = [NSString string];
                if ([self.selectType isEqualToString:@"1"]) {
                    str = self.usermodel.userID;
                }else{
                    str = _currentComment.commentUserId;
                }
                [self obtailComment:self.cmtView.inputView.text andType:@"pl" andUserID:self.usermodel.userID andMoment:_cell.moment.friendId andCommentMod:[self.selectType intValue] andcommentUserId:str andCommentId:@""];
            }
          //  self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
        self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
            //[textField resignFirstResponder];
        [self.cmtView.inputView resignFirstResponder];
        self.cmtView.inputView.zw_placeHolder = @"回复";
        return NO;
    }
    return YES;
}





#pragma mark -- uitextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
//    if (textField == self.currenttextfield) {
//        self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
//        if ([temp length] < 1){
//            self.currenttextfield.text = @"";
//            self.tableview.hidden = YES;
//            self.collectionview.hidden = NO;
//        }else{
//            self.currenttextfield.text = temp;
//            //如果等于1那么传的是userId ,2 就是传commentUserId
//            NSString * str = [NSString string];
//            if ([self.selectType isEqualToString:@"1"]) {
//                str = self.usermodel.userID;
//            }else{
//                str = _currentComment.commentUserId;
//            }
//            [self obtailComment:self.currenttextfield.text andType:@"pl" andUserID:self.usermodel.userID andMoment:_cell.moment.friendId andCommentMod:[self.selectType intValue] andcommentUserId:str andCommentId:@""];
//        }
//        self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
//         [textField resignFirstResponder];
//    }else{
        if ([temp length] > 0) {
            self.deleteBtn.hidden = NO;
            //[self searchContentNewData];
            [self.tableview.mj_header beginRefreshing];
            self.collectionview.hidden = NO;
            self.tableview.hidden = YES;
            //这边开始去搜索
            if (self.newSerachArray.count > 0) {
                BOOL isContans =  [self.newSerachArray containsObject:temp];
                if (!isContans) {
                    [self.newSerachArray addObject:temp];
                    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
                    [self.newSerachArray writeToFile:filePath atomically:YES];
                    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.newSerachArray.count - 1 inSection:0];
                    [self.collectionview insertItemsAtIndexPaths:@[indexpath]];
                }
            }else{
                [self.newSerachArray addObject:temp];
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
                [self.newSerachArray writeToFile:filePath atomically:YES];
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.newSerachArray.count - 1 inSection:0];
                [self.collectionview insertItemsAtIndexPaths:@[indexpath]];
            }
        }else{
            self.deleteBtn.hidden = YES;
            self.tableview.hidden = YES;
            self.collectionview.hidden = NO;
        }
//        self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
        [textField resignFirstResponder];
//    }
    return YES;
}





#pragma mark -- UItableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * NEWSEARCHID = @"NEWSEARCHID";
    MomentCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWSEARCHID];
    if (!cell) {
        cell = [[MomentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWSEARCHID];
    }
    //cell.textLabel.text = @"1";
    //cell.detailTextLabel.text = @"2";
    Moment * moment = [self.searchDataArray objectAtIndex:indexPath.row];
    cell.moment = moment;
    cell.delegate = self;
    [cell.attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.attentionBtn.tag = 1000+indexPath.row;
    cell.menuView.shareBtn.tag = 100000 + indexPath.row;
    cell.menuView.commentBtn.tag = 100000 + indexPath.row;
    cell.menuView.likeBtn.tag = 100000 + indexPath.row;
    //没有关注和关注的状态
    if ([[NSString stringWithFormat:@"%@",moment.attstatus] isEqualToString:@"0"]) {
        [cell.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [cell.attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#4C618E"] forState:UIControlStateNormal];
        [cell.attentionBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        cell.attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#4C618E"].CGColor;
    }else{
        [cell.attentionBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [cell.attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#B2B2B2"] forState:UIControlStateNormal];
        [cell.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        cell.attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
    }
    if ([[NSString stringWithFormat:@"%@",moment.likestatus] isEqualToString:@"0"]) {
        //没有点赞
        cell.menuView.likeBtn.selected = NO;
        cell.menuView.likeBtn.backgroundColor = [UIColor clearColor];
        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
        [cell.menuView.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    }else{
        //已经点赞
        cell.menuView.likeBtn.selected = YES;
        [cell.menuView.likeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353D40"]];
        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path1"] forState:UIControlStateNormal];
        [cell.menuView.likeBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    cell.tag = indexPath.row;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Moment * moment = self.searchDataArray[indexPath.row];
    return moment.rowHeight;
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.searchDataArray.count - 2) {
        [self.tableview.mj_footer beginRefreshing];
    }
}



#pragma mark -- UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.newSerachArray.count;
    }else{
        return self.likeStoneArray.count;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString * str = self.newSerachArray[indexPath.row];
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        NSInteger width = size.width;
        return CGSizeMake(width + 28, 34);
    }else{
        return CGSizeMake((SCW - 17 - 16 - 6)/3, 80);
    }
}

//内容整体边距设置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(0, 17, 0, 16);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 9;
    }else{
        return 3;
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 9;
    }else{
        return 3;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(SCW, 50);
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RSNewSearchHeaderReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RSNEWSEARCHHEADERREUSABLEVIEW forIndexPath:indexPath];
        if (indexPath.section == 0) {
            header.allDeleteBtn.tag = 0;
            header.titleLabel.text = @"搜索历史";
            [header.allDeleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
            header.allDeleteBtn.sd_layout
            .centerYEqualToView(header)
            .rightSpaceToView(header, 21)
            .widthIs(14)
            .heightIs(14);
            
        }else{
            header.allDeleteBtn.tag = 1;
            header.titleLabel.text = @"猜你想找";
            [header.allDeleteBtn setImage:[UIImage imageNamed:@"换一换"] forState:UIControlStateNormal];
            [header.allDeleteBtn setTitle:@"换一换" forState:UIControlStateNormal];
            header.allDeleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            header.allDeleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [header.allDeleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#6A6A6A"] forState:UIControlStateNormal];
            header.allDeleteBtn.sd_layout
            .centerYEqualToView(header)
            .rightSpaceToView(header, 0)
            .widthIs(100)
            .heightIs(14);
        }
        [header.allDeleteBtn addTarget:self action:@selector(deleteAllContent:) forControlEvents:UIControlEventTouchUpInside];
        return header;
    }
    return nil;
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RSNewSearchCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:FRISTNEWCOLLECTIONVIEW forIndexPath:indexPath];
        cell.label.text = self.newSerachArray[indexPath.row];
        UILongPressGestureRecognizer * longPan = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteCellLabelContent:)];
        [cell.label addGestureRecognizer:longPan];
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteAlreadyContent:) forControlEvents:UIControlEventTouchUpInside];
        longPan.view.tag = indexPath.row;
        return cell;
    }else{
        RSNewSearchImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NEWCOLLECTIONVIEW forIndexPath:indexPath];
        RSHotStoneModel * hotStoneModel = self.likeStoneArray[indexPath.row];
        cell.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        cell.hotStoneModel = hotStoneModel;
        return cell;
    }
}

- (void)deleteCellLabelContent:(UILongPressGestureRecognizer *)longPan{
    if (longPan.state == UIGestureRecognizerStateEnded) {
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:longPan.view.tag inSection:0];
        RSNewSearchCollectionCell * cell = (RSNewSearchCollectionCell *)[self.collectionview cellForItemAtIndexPath:indexpath];
        cell.deleteBtn.hidden = !cell.deleteBtn.hidden;
        cell.deleteBtn.enabled = !cell.deleteBtn.enabled;
    }
}

- (void)deleteAlreadyContent:(UIButton *)deleteBtn{
    //这边要去删除本地plist的数据
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    for (int i = 0; i < array.count; i++) {
        NSString * str = array[i];
        NSString * newStr = [self.newSerachArray objectAtIndex:deleteBtn.tag];
        if ([str isEqualToString:newStr]) {
            [self.newSerachArray removeObjectAtIndex:deleteBtn.tag];
            [self.newSerachArray writeToFile:filePath atomically:YES];
            break;
        }
    }
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:deleteBtn.tag inSection:0];
    [self.collectionview deleteItemsAtIndexPaths:@[indexpath]];
}



- (void)deleteAllContent:(UIButton *)allDeleteBtn{
    if (allDeleteBtn.tag == 0) {
        //清除plist文件，可以根据我上面讲的方式进去本地查看plist文件是否被清除
        NSFileManager *fileMger = [NSFileManager defaultManager];
        NSString *xiaoXiPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"newSearch.plist"];
        //如果文件路径存在的话
        BOOL bRet = [fileMger fileExistsAtPath:xiaoXiPath];
        if (bRet) {
            NSError *err;
            [fileMger removeItemAtPath:xiaoXiPath error:&err];
        }
        [self.newSerachArray removeAllObjects];
        [self.collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }else{
         [self loadLikeStoneNewData];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    self.deleteBtn.hidden = NO;
    if (indexPath.section == 0) {
        //这边要去判断下数组里面有没有这个搜索的东西了
        NSString * str = self.newSerachArray[indexPath.row];
        _searchTextfield.text = str;
       // self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
        self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
        //[self searchContentNewData];
         [self.tableview.mj_header beginRefreshing];
        self.tableview.hidden = NO;
        self.collectionview.hidden = YES;
        if (self.newSerachArray.count > 0) {
            BOOL isContans =  [self.newSerachArray containsObject:self.searchTextfield.text];
            if (!isContans) {
                [self.newSerachArray addObject:self.searchTextfield.text];
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
                [self.newSerachArray writeToFile:filePath atomically:YES];
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.newSerachArray.count - 1 inSection:0];
                [self.collectionview insertItemsAtIndexPaths:@[indexpath]];
            }
        }else{
            [self.newSerachArray addObject:self.searchTextfield.text];
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
            [self.newSerachArray writeToFile:filePath atomically:YES];
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.newSerachArray.count - 1 inSection:0];
            [self.collectionview insertItemsAtIndexPaths:@[indexpath]];
        }
        //[_searchTextfield becomeFirstResponder];
    }else{
        RSHotStoneModel * hotStoneModel = self.likeStoneArray[indexPath.row];
        self.searchTextfield.text = hotStoneModel.stoneName;
       // self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
        self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
        //[self searchContentNewData];
        [self.tableview.mj_header beginRefreshing];
        self.tableview.hidden = NO;
        self.collectionview.hidden = YES;
        if (self.newSerachArray.count > 0) {
            BOOL isContans =  [self.newSerachArray containsObject:self.searchTextfield.text];
            if (!isContans) {
                [self.newSerachArray addObject:self.searchTextfield.text];
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
                [self.newSerachArray writeToFile:filePath atomically:YES];
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.newSerachArray.count - 1 inSection:0];
                [self.collectionview insertItemsAtIndexPaths:@[indexpath]];
            }
        }else{
            [self.newSerachArray addObject:self.searchTextfield.text];
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [docPath stringByAppendingPathComponent:@"newSearch.plist"];
            [self.newSerachArray writeToFile:filePath atomically:YES];
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.newSerachArray.count - 1 inSection:0];
            [self.collectionview insertItemsAtIndexPaths:@[indexpath]];
        }
        // [_searchTextfield becomeFirstResponder];
    }
}





//搜索时候网络内容
- (void)searchContentNewData{
    self.isRefresh = true;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.searchTextfield.text forKey:@"searchText"];
    [phoneDict setObject:@"" forKey:@"showType"];
    [phoneDict setObject:self.selectStr forKey:@"friendType"];
    NSString * str = nil;
    if (self.usermodel.userID == nil) {
        str = @"-1";
    }else{
        str = self.usermodel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    // [phoneDict setObject:EPRID(1) forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    [weakSelf.searchDataArray removeAllObjects];
                    NSMutableArray * array = [NSMutableArray array];
                    array = json[@"Data"];
                    if (array.count > 0) {
                        for (int j = 0; j < array.count; j++) {
                            Moment *moment = [[Moment alloc]init];
                            moment.index = j;
                            moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                            moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                            moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
                            moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
                            moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                            moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                            moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                            moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
                            moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                            moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
                            moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                            moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                            moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
                            moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                            moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                            moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                            moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                            moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                            moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                            moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                            moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                            moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                            moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                            moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                            moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                            moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                            moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
                            moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                            moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
                            moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                            moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                            moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
                            moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                            moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
                            NSMutableArray * tempArray = [NSMutableArray array];
                            //评论
                            tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
                            for (int i = 0 ; i < tempArray.count; i++) {
                                Comment * commen = [[Comment alloc]init];
                                commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
                                commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
                                commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
                                commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
                                commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
                                commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
                                commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
                                commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
                                commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
                                commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
                                commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
                                commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
                                commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
                                commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
                                [moment.commentList addObject:commen];
                            }
                            NSMutableArray * likeArray = [NSMutableArray array];
                            likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
                            for (int n = 0; n < likeArray.count; n++) {
                                RSLike * like = [[RSLike alloc]init];
                                like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
                                like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
                                like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
                                like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
                                [moment.likeList addObject:like];
                            }
                            [weakSelf.searchDataArray addObject:moment];
                        }
                        weakSelf.pageNum = 2;
                        [weakSelf.tableview reloadData];
                    }
                    weakSelf.tableview.hidden = NO;
                    weakSelf.collectionview.hidden = YES;
                    [weakSelf.tableview.mj_header endRefreshing];
                }else{
                    weakSelf.tableview.hidden = YES;
                    weakSelf.collectionview.hidden = NO;
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_header endRefreshing];
                }
            }else{
                weakSelf.tableview.hidden = YES;
                weakSelf.collectionview.hidden = NO;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }];
}


- (void)searchContentMoreNewData{
    self.isRefresh = false;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.searchTextfield.text forKey:@"searchText"];
    [phoneDict setObject:@"" forKey:@"showType"];
    [phoneDict setObject:self.selectStr  forKey:@"friendType"];
    NSString * str = nil;
    if (self.usermodel.userID == nil) {
        str = @"-1";
    }else{
        str = self.usermodel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    // [phoneDict setObject:EPRID(1) forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    NSMutableArray * array = [NSMutableArray array];
                    array = json[@"Data"];
                    if (array.count > 0) {
                        //NSMutableArray * temp = [NSMutableArray array];
                        for (int j = 0; j < array.count; j++) {
                            Moment *moment = [[Moment alloc]init];
                            moment.index = j;
                            moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                            moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                            moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
                            moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
                            moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                            moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                            moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                            moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
                            moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                            moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
                            moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                            moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                            moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
                            moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                            moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                            moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                            moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                            moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                            moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                            moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                            moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                            moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                            moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                            moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                            moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                            moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                            moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
                            moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                            moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
                            moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                            moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                            moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
                            moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                            moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
                            NSMutableArray * tempArray = [NSMutableArray array];
                            //评论
                            tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
                            for (int i = 0 ; i < tempArray.count; i++) {
                                Comment * commen = [[Comment alloc]init];
                                commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
                                commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
                                commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
                                commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
                                commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
                                commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
                                commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
                                commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
                                commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
                                commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
                                commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
                                commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
                                commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
                                commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
                                [moment.commentList addObject:commen];
                            }
                            NSMutableArray * likeArray = [NSMutableArray array];
                            likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
                            for (int n = 0; n < likeArray.count; n++) {
                                RSLike * like = [[RSLike alloc]init];
                                like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
                                like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
                                like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
                                like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
                                [moment.likeList addObject:like];
                            }
                            //[temp addObject:moment];
                            [weakSelf.searchDataArray addObject:moment];
                            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:weakSelf.searchDataArray.count -1 inSection:0];
                            [weakSelf.tableview insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                        }
                        // [weakSelf.searchDataArray addObjectsFromArray:temp];
                        weakSelf.pageNum++;
                        //[weakSelf.tableview reloadData];
                    }
                    [weakSelf.tableview.mj_footer endRefreshing];
                }else{
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
            }else{
                 [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    
//    self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    _cell.imageListView.userInteractionEnabled = YES;
//    [self.currenttextfield resignFirstResponder];
    self.collectionview.hidden = NO;
    self.tableview.hidden = YES;
    
    
    /**
     friendDetailVc.title = moment.HZName;
     friendDetailVc.titleStyle = self.title;
     friendDetailVc.friendID = moment.friendId;
     friendDetailVc.selectStr = _selectStr;
     
     */
    
    
    Moment * moment = self.searchDataArray[indexPath.row];
   // self.selectStr
    
    if ([self.delegate respondsToSelector:@selector(searchcontextTitle:andFriendID:andSelectStr:)]) {
        [self.delegate searchcontextTitle:moment.HZName andFriendID:moment.friendId andSelectStr:self.selectStr];
    }
    
    
    
//    if ([self.delegate respondsToSelector:@selector(searchcontextText:)]) {
//        [self.delegate searchcontextText:_searchTextfield.text];
//    }
}

// 点击用户头像
- (void)didClickProfile:(MomentCell *)cell{
    self.searchTextfield.text = @"";
    self.tableview.hidden = YES;
    self.collectionview.hidden = NO;
//    self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    _cell.imageListView.userInteractionEnabled = YES;
//    [self.currenttextfield resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didShowFriendsCell:)]) {
        [self.delegate didShowFriendsCell:cell];
    }
}

//点击用户名称
- (void)didClickName:(MomentCell *)cell{
    
    self.searchTextfield.text = @"";
    self.tableview.hidden = YES;
    self.collectionview.hidden = NO;
    
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    //self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    _cell.imageListView.userInteractionEnabled = YES;
    //[self.currenttextfield resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didShowFriendsCell:)]) {
        [self.delegate didShowFriendsCell:cell];
    }
}

// 点赞
- (void)didLikeMoment:(MomentCell *)cell{
    _cell.imageListView.userInteractionEnabled = YES;
//    self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
//    [self.currenttextfield resignFirstResponder];
    
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    
    
    cell.menuView.likeBtn.selected = !cell.menuView.likeBtn.selected;
    if (cell.menuView.likeBtn.selected) {
        [cell.menuView.likeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#353D40"]];
        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path1"] forState:UIControlStateNormal];
        [cell.menuView.likeBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        cell.menuView.likeBtn.backgroundColor = [UIColor clearColor];
        [cell.menuView.likeBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
        [cell.menuView.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    }
    _cell = cell;
    //这边还是要网络请求
    [self obtailComment:@"" andType:@"dz" andUserID:self.usermodel.userID andMoment:_cell.moment.friendId andCommentMod:1 andcommentUserId:self.usermodel.userID andCommentId:@""];
}

// 评论
- (void)didAddComment:(MomentCell *)cell{
//    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax){
       // self.currenttextfield.frame = CGRectMake(0, SCH - 50, SCW, 50);
//    }else{
//        self.currenttextfield.frame = CGRectMake(0, SCH - 50, SCW, 50);
//    }
//    self.currenttextfield.text = @"";
    self.cmtView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    self.cmtView.inputView.text = @"";
    self.selectType = @"1";
   // self.currenttextfield.placeholder = @"回复";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    _cell = cell;
    cell.menuView.show = NO;
    cell.imageListView.userInteractionEnabled = NO;
    //[self.currenttextfield becomeFirstResponder];
    [self.cmtView.inputView becomeFirstResponder];
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}

//分享
- (void)didShareMoment:(MomentCell *)cell{
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    //self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    _cell.imageListView.userInteractionEnabled = YES;
    //[self.currenttextfield resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didShowFriendShareCell:)]) {
        [self.delegate didShowFriendShareCell:cell];
    }
}

//全文/收起
- (void)didSelectFullText:(MomentCell *)cell
{
    _cell.imageListView.userInteractionEnabled = YES;
    //self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    //[self.currenttextfield resignFirstResponder];
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didCurrentShowImageView{
    _cell.imageListView.userInteractionEnabled = YES;
//    self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
   // [self.currenttextfield resignFirstResponder];
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
}


// 选择评论
- (void)didSelectComment:(Comment *)comment andMomentCell:(MomentCell *)cell{
    
    self.cmtView.inputView.text = @"";
    _cell.imageListView.userInteractionEnabled = YES;
    _currentComment = comment;
    _cell = cell;
    if ([_currentComment.commentName isEqualToString:self.usermodel.userName]) {
        //这边是做的
            
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除该评论" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{

              [self obtailComment:@"" andType:@"sc" andUserID:self.usermodel.userID andMoment:_cell.moment.friendId andCommentMod:0 andcommentUserId: _currentComment.relUserId andCommentId: _currentComment.commentId];
        }];
        
        
        
      
        
        
    }else{
        
//        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax){
          //  self.currenttextfield.frame = CGRectMake(0, SCH - 50, SCW, 50);
        self.cmtView.frame = CGRectMake(0, SCH - 50, SCW, 50);
//        }else{
//            self.currenttextfield.frame = CGRectMake(0, SCH - 260 - 130, SCW, 50);
//        }
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
        _cell.memberImageView.userInteractionEnabled = NO;
        self.selectType = @"2";
        cell.menuView.show = NO;
        //[self.currenttextfield becomeFirstResponder];
        [self.cmtView.inputView becomeFirstResponder];
        self.cmtView.inputView.zw_placeHolder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
        //self.currenttextfield.placeholder = [NSString stringWithFormat:@"回复%@:",comment.commentName];
    }
}


// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText andComment:(Comment *)comment andCell:(MomentCell *)cell{
   // self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    _cell.imageListView.userInteractionEnabled = YES;
    _cell = cell;
    _currentComment = comment;
    //[self.currenttextfield resignFirstResponder];
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
    }else{
        
        self.searchTextfield.text = @"";
        self.tableview.hidden = YES;
        self.collectionview.hidden = NO;
        if ([_currentComment.commentName isEqualToString:linkText]) {
            if ([self.delegate respondsToSelector:@selector(didShowFriendsYKFriend:)]) {
                [self.delegate didShowFriendsYKFriend:_currentComment];
            }
            return;
        }
        
        if ([_currentComment.relUser isEqualToString:linkText]) {
            if ([self.delegate respondsToSelector:@selector(didShowFriendYKFriendReUser:)]) {
                [self.delegate didShowFriendYKFriendReUser:_currentComment];
            }
            return;
        }
    }
}



//点击视频的动作
- (void)didCurrentCellVideoUrl:(Moment *)moment{
    
    self.searchTextfield.text = @"";
    self.tableview.hidden = YES;
    self.collectionview.hidden = NO;
//    self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    _cell.imageListView.userInteractionEnabled = YES;
    //[self.currenttextfield resignFirstResponder];
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didShowFriendsVideoMoment:)]) {
        [self.delegate didShowFriendsVideoMoment:moment];
    }
}

//点击点赞里面内容的部分
- (void)didLikeContentTitleLike:(RSLike *)like{
    self.searchTextfield.text = @"";
    self.tableview.hidden = YES;
    self.collectionview.hidden = NO;
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
//    self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    _cell.imageListView.userInteractionEnabled = YES;
//    [self.currenttextfield resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didShowFriendsLikeContentLike:)]) {
        [self.delegate didShowFriendsLikeContentLike:like];
    }
}

//关注
- (void)attentionAction:(UIButton *)attentionBtn{
    //这边是关注要做的事情
   // self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView resignFirstResponder];
    _cell.imageListView.userInteractionEnabled = YES;
   // [self.currenttextfield resignFirstResponder];
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:attentionBtn.tag - 1000 inSection:0];
    Moment * moment = self.searchDataArray[indexpath.row];
    _cell = (MomentCell *)[self.tableview cellForRowAtIndexPath:indexpath];
    RSWeakself
    if ( [attentionBtn.currentTitle isEqualToString:@"已关注"]) {
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
            [weakSelf obtailComment:@"" andType:@"gz" andUserID:self.usermodel.userID andMoment:moment.friendId andCommentMod:1 andcommentUserId:self.usermodel.userID andCommentId:@""];
        }];
    }else{
        [weakSelf obtailComment:@"" andType:@"gz" andUserID:self.usermodel.userID andMoment:moment.friendId andCommentMod:1 andcommentUserId:self.usermodel.userID andCommentId:@""];
    }
    
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _cell.imageListView.userInteractionEnabled = YES;
    //self.currenttextfield.frame = CGRectMake(0, SCH, SCW, 50);
    //[self.currenttextfield resignFirstResponder];
    self.cmtView.inputView.text = @"";
    self.cmtView.inputView.zw_placeHolder = @"回复";
    self.cmtView.frame = CGRectMake(0, SCH, SCW, 50);
    [self.cmtView.inputView resignFirstResponder];
    NSIndexPath *indexPath =  [self.tableview indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    MomentCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    cell.menuView.show = NO;
}



- (void)obtailComment:(NSString *)commentStr andType:(NSString *)type andUserID:(NSString *)userId andMoment:(NSString *)friendId andCommentMod:(int)commentMod andcommentUserId:(NSString *)commentUserId andCommentId:(NSString *)commentId{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    // 商圈id    friendId    int
    [phoneDict setObject:friendId forKey:@"friendId"];
    // 操作人id    userId    int    评论/点赞人 id
    [phoneDict setObject:userId forKey:@"userId"];
    // 评论内容    commenter    String
    [phoneDict setObject:commentStr forKey:@"commenter"];
    // 操作类别    type    String    pl/dz/gz  评论/点赞/关注
    [phoneDict setObject:type forKey:@"type"];
    //被评论人    relUserId    Int    评论人的回复对象id
    //如果等于1那么传的是userId ,2 就是传commentUserId
    [phoneDict setObject:commentUserId forKey:@"relUserId"];
    // 评论模式    CommentMod    Int    1：评论商圈  2:评论用户
    
    //删除commentId
    [phoneDict setObject:commentId forKey:@"commentId"];
    
    //评论时才传改参数
    [phoneDict setObject:[NSString stringWithFormat:@"%d",commentMod] forKey:@"commentMod"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DIANZAO_PL_GZ_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                if ([type isEqualToString:@"dz"]) {
                    
                     [weakSelf loadFriendDetailOneNewData:_cell andType:@"dz"];
                    //点赞
//                    if (_cell.menuView.likeBtn.selected) {
//                        _cell.moment.isPraise = 1;
//                        NSString * status = json[@"Data"][@"status"];
//                        _cell.moment.likestatus = status;
//                        _cell.menuView.likeBtn.selected = YES;
//                        RSLike * like = [[RSLike alloc]init];
//                        like.SYS_USER_ID = _cell.moment.userid;
//                        like.USER_NAME = self.usermodel.userName;
//                        like.USER_TYPE = self.usermodel.userType;
//                        like.likeID = _cell.moment.userid;
//                        [_cell.moment.likeList addObject:like];
//                    }else{
//                        _cell.moment.isPraise = 0;
//                        NSString * status = json[@"Data"][@"status"];
//                        _cell.moment.likestatus = status;
//                        _cell.menuView.likeBtn.selected = NO;
//                        for (int i = 0; i < _cell.moment.likeList.count; i++) {
//                            RSLike * like = _cell.moment.likeList[i];
//                            if ([like.USER_NAME isEqualToString:self.usermodel.userName]) {
//                                [_cell.moment.likeList removeObjectAtIndex:i];
//                            }
//                        }
//                    }
//                    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }else if ([type isEqualToString:@"pl"]){
                    //评论
                    
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"pl"];
                    
//                    Comment * currentComment = [[Comment alloc]init];
//                    currentComment.comment = [NSString stringWithFormat:@"%@",json[@"Data"][@"value"]];
//                    //这边是当前用户自己
//                    currentComment.relUser = self.usermodel.userName;
//                    currentComment.relUserId = [NSString stringWithFormat:@"%@",json[@"Data"][@"beCommentedUserId"]];
//                    currentComment.commentUserId = [NSString stringWithFormat:@"%@",json[@"Data"][@"commentUserId"]];
//                    currentComment.commentId = [NSString stringWithFormat:@"%@",json[@"Data"][@"id"]];
//                    currentComment.commentUserType = self.usermodel.userType;
//                    if ([self.selectType isEqualToString:@"1"]) {
//                        currentComment.commentmod = 1;
//
//                        Moment * moment = _cell.moment;
//                        currentComment.relUserType = self.usermodel.userType;
//                        //当前用户自己
//                        currentComment.commentName = self.usermodel.userName;
//                        [moment.commentList addObject:currentComment];
//                        [self.searchDataArray replaceObjectAtIndex:_cell.tag withObject:moment];
//                        //[self.tableView reloadData];
//                        [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    }else if ([self.selectType isEqualToString:@"2"]){
//
//                        Moment *moment = _cell.moment;
//                        if (_currentComment.commentmod == 2) {
//                            //别人评论之后和评论你在评论别人的东西
//                            currentComment.relUserType = _currentComment.relUserType;
//                            currentComment.commentmod = 2;
//                            //当前登录者
//                            currentComment.relUser = self.usermodel.userName;
//                            currentComment.commentName = _currentComment.relUser;
//                            [moment.commentList addObject:currentComment];
//                            [self.searchDataArray replaceObjectAtIndex:_cell.tag withObject:moment];
//                        }else{
//                            //直接评论
//                            currentComment.commentmod = 2;
//                            //当前登录者
//                            currentComment.relUser = self.usermodel.userName;
//                            currentComment.commentName = _currentComment.commentName;
//                            [moment.commentList addObject:currentComment];
//                            [self.searchDataArray replaceObjectAtIndex:_cell.tag withObject:moment];
//                        }
//                        [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    }
                    
                }else if([type isEqualToString:@"gz"]){
                    NSString * attentionStr = json[@"Data"][@"status"];
                    NSString * codeStr = [NSString stringWithFormat:@"%@",attentionStr];
                    for (int i = 0 ; i < weakSelf.searchDataArray.count; i++) {
                        Moment * moment = weakSelf.searchDataArray[i];
                        if ([weakSelf.cell.moment.HZName isEqualToString:moment.HZName]) {
                           moment.attstatus =[NSString stringWithFormat:@"%@",codeStr];
                           [weakSelf.searchDataArray replaceObjectAtIndex:i withObject:moment];
                            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                           [weakSelf.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                        }
                    }
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"gz"];
                }else{
                    //删除评论
                    [weakSelf loadFriendDetailOneNewData:_cell andType:@"sc"];
                }
            }else{
                if ([type isEqualToString:@"pl"]) {
                    [SVProgressHUD showErrorWithStatus:@"评论失败"];
                }else if ([type isEqualToString:@"dz"]){
                    [SVProgressHUD showErrorWithStatus:@"点赞失败"];
                }else if ([type isEqualToString:@"gz"]){
                    [SVProgressHUD showErrorWithStatus:@"关注失败"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"删除失败"];
                }
            }
        }else{
            if ([type isEqualToString:@"pl"]) {
                [SVProgressHUD showErrorWithStatus:@"评论失败"];
            }else if ([type isEqualToString:@"dz"]){
                [SVProgressHUD showErrorWithStatus:@"点赞失败"];
            }else if ([type isEqualToString:@"gz"]){
                [SVProgressHUD showErrorWithStatus:@"关注失败"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
            
        }
    }];
}

//获取特定的朋友圈
- (void)loadFriendDetailOneNewData:(MomentCell *)cell andType:(NSString *)type{
    self.isRefresh = true;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"item_num"];
    [phoneDict setObject:@"" forKey:@"showType"];
    [phoneDict setObject:self.selectStr forKey:@"friendType"];
    [phoneDict setObject:cell.moment.friendId forKey:@"friendId"];
    NSString * str = nil;
    if (self.usermodel.userID == nil) {
        str = @"-1";
        // self.userModel.userID = [NSString stringWithFormat:@"%@",str];
    }else{
        str = self.usermodel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    // [phoneDict setObject:EPRID(1) forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int j = 0; j < array.count; j++) {
                    Moment *moment = [[Moment alloc]init];
                    moment.index = j;
                    moment.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                    moment.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                    moment.content = [[array objectAtIndex:j] objectForKey:@"content"];
                    moment.url = [[array objectAtIndex:j] objectForKey:@"url"];
                    moment.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                    moment.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                    moment.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                    moment.day = [[array objectAtIndex:j]objectForKey:@"day"];
                    moment.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                    moment.month = [[array objectAtIndex:j]objectForKey:@"month"];
                    moment.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                    moment.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                    moment.status = [[array objectAtIndex:j]objectForKey:@"status"];
                    moment.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                    moment.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                    moment.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                    moment.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                    moment.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                    moment.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                    moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                    moment.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                    moment.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                    moment.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                    moment.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                    moment.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                    moment.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                    moment.type = [[array objectAtIndex:j]objectForKey:@"type"];
                    moment.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                    moment.video = [[array objectAtIndex:j]objectForKey:@"video"];
                    moment.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                    moment.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                    moment.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"] doubleValue];
                    moment.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                    moment.sys_user_id = [[array objectAtIndex:j]objectForKey:@"sys_user_id"];
                    NSMutableArray * tempArray = [NSMutableArray array];
                    //评论
                    tempArray = [[array objectAtIndex:j]objectForKey:@"comment"];
                    for (int i = 0 ; i < tempArray.count; i++) {
                        Comment * commen = [[Comment alloc]init];
                        commen.comment = [[tempArray objectAtIndex:i]objectForKey:@"comment"];
                        commen.commentId = [[tempArray objectAtIndex:i]objectForKey:@"commentId"];
                        commen.commentUserId = [[tempArray objectAtIndex:i]objectForKey:@"commentUserId"];
                        commen.commentHZLogo = [[tempArray objectAtIndex:i]objectForKey:@"commentHZLogo"];
                        commen.commentName = [[tempArray objectAtIndex:i]objectForKey:@"commentName"];
                        commen.relUserId = [[tempArray objectAtIndex:i]objectForKey:@"relUserId"];
                        commen.day = [[tempArray objectAtIndex:i]objectForKey:@"day"];
                        commen.month = [[tempArray objectAtIndex:i]objectForKey:@"month"];
                        commen.relUser = [[tempArray objectAtIndex:i]objectForKey:@"relUser"];
                        commen.commentUserType = [[tempArray objectAtIndex:i]objectForKey:@"commentUserType"];
                        commen.relUserType = [[tempArray objectAtIndex:i]objectForKey:@"relUserType"];
                        commen.timedate = [[tempArray objectAtIndex:i]objectForKey:@"timedate"];
                        commen.year = [[tempArray objectAtIndex:i]objectForKey:@"year"];
                        commen.commentmod = [[[tempArray objectAtIndex:i]objectForKey:@"commentmod"] intValue];
                        [moment.commentList addObject:commen];
                    }
                    NSMutableArray * likeArray = [NSMutableArray array];
                    likeArray = [[array objectAtIndex:j]objectForKey:@"likeList"];
                    for (int n = 0; n < likeArray.count; n++) {
                        RSLike * like = [[RSLike alloc]init];
                        like.SYS_USER_ID = [[likeArray objectAtIndex:n]objectForKey:@"SYS_USER_ID"];
                        like.likeID = [[likeArray objectAtIndex:n]objectForKey:@"likeID"];
                        like.USER_TYPE = [[likeArray objectAtIndex:n]objectForKey:@"USER_TYPE"];
                        like.USER_NAME = [[likeArray objectAtIndex:n]objectForKey:@"USER_NAME"];
                        [moment.likeList addObject:like];
                    }
                    
                    if ([type isEqualToString:@"pl"] || [type isEqualToString:@"sc"]) {
                        cell.moment.commentList = moment.commentList;
                    }else if ([type isEqualToString:@"dz"]){
                        cell.moment.likestatus = moment.likestatus;
                        cell.moment.likenum = moment.likenum;
                        cell.moment.likeList = moment.likeList;
                    }
                    
                    
                    
                    if ([weakSelf.delegate respondsToSelector:@selector(didShowFriendsFuntion:andType:)]) {
                        [weakSelf.delegate didShowFriendsFuntion:moment andType:type];
                    }
                    
                    
                    /**
                     NSDictionary *dict = @{@"moment": weakSelf.moment,@"Type":type};
                     [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"refreshFriendStatus" object:nil userInfo:dict]];
                     
                     
                     */
                    
                    [UIView setAnimationsEnabled:NO];
                   // [weakSelf.searchDataArray replaceObjectAtIndex:cell.tag withObject:moment];
                    [weakSelf.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                   // [weakSelf.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_cell.tag inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                    [UIView setAnimationsEnabled:YES];
                }
            }
        }
    }];
}






@end
