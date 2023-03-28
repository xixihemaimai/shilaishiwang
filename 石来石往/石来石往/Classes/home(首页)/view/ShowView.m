//
//  ShowView.m
//  封装
//
//  Created by 曾旭升 on 15/11/19.
//  Copyright (c) 2015年 RuishiInfo. All rights reserved.
//

#import "ShowView.h"
#import "CompanyTableViewCell.h"
#import "UIView+Frame.h"
static NSUInteger _selectROW;
@implementation ShowView
-(id)initWithFrame:(CGRect)frame arr:(NSArray *)arr  andType:(kGQXXDataTypeSelect)type{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        if ([arr[0]isEqual:@"showInputDialog"]) {
            
        }else{
            _arr2 =arr;
            _selctMArr = [NSMutableArray array];
            NSMutableArray  *array = [NSMutableArray array];
                [array addObjectsFromArray:[arr[4] componentsSeparatedByString:@";"]];
            if (type == kGQXXDataTypeOneSelect) {
                [_selctMArr addObjectsFromArray:array];
            }else{
                for (int i =0; i<array.count; i++) {
                    if ([array[i] isEqual:@"1"]) {
                        [_selctMArr addObject:[NSString stringWithFormat:@"%d",i]];
                        
                    }
                }
            }
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden:)];
            tap.delegate =self;
            [self addGestureRecognizer:tap];
             _arr1=arr;
            float fVheight;
            float f = [_arr2[3] componentsSeparatedByString:@";"].count*36+100;
            if (f>SCH-100) {
                fVheight = SCH-100;
            }else{
                fVheight =f ;
            }
            _mainV = [[UIView alloc]initWithFrame:CGRectMake(20, 0,frame.size.width-40, fVheight)];
            
            _mainV.backgroundColor =[UIColor whiteColor];
            _mainV.center = self.center;
            [[_mainV layer]setCornerRadius:15.0];
            _lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, _mainV.frame.size.width, 20)];

            [_mainV addSubview:_lblTitle];
            UIButton *button = [[UIButton alloc] init];
            button.frame=CGRectMake(_mainV.frame.size.width-80,_mainV.frame.size.height-45, 60, 40);
            [button setImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"sure"] forState:UIControlStateHighlighted];
            
            [button addTarget:self action:@selector(sureBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_mainV addSubview:button];
            
            
            _tableview  = [[UITableView alloc]initWithFrame:CGRectMake(10, _lblTitle.bottom+15, _mainV.yj_width-20, fVheight-100) style:UITableViewStylePlain];
            _tableview.delegate=self;
            _tableview.dataSource =self;
            _tableview.rowHeight =36.0;
            _tableview.separatorStyle = NO;
            
            UILabel *lblLine = [[UILabel alloc]initWithFrame:CGRectMake(10,_tableview.top-2, _mainV.width -20, 1)];
            lblLine.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:244.0/255];
            [_mainV addSubview:lblLine];
            UILabel *lblLine1 = [[UILabel alloc]initWithFrame:CGRectMake(10,_tableview.bottom+2, _mainV.width -20, 1)];
            lblLine1.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:244.0/255];
            [_mainV addSubview:lblLine];
            [_mainV addSubview:lblLine1];
            
            [_mainV addSubview:_tableview];
            [self addSubview:_mainV];
         }
    }
    return self;
}

#pragma mark ----确定按钮
-(void)selectrow:(UIButton *)sender{

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arr2[3] componentsSeparatedByString:@";"].count;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"CompanyTableViewCell";
    CompanyTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CompanyTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    };
    cell.lbltittle.text =[_arr2[3] componentsSeparatedByString:@";"][indexPath.row];
    if ([_selctMArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
        if (_dataType == kGQXXDataTypeOneSelect) {
            cell.ImgSelect.image =[UIImage imageNamed:@"椭圆-2"];
            
        }else{
            cell.ImgSelect.image =[UIImage imageNamed:@"打钩-(1)"];
             
        }
       
    }else{
        if (_dataType == kGQXXDataTypeOneSelect) {
            cell.ImgSelect.image =[UIImage imageNamed:@"椭圆-1-拷贝"];
           
        }else{
            cell.ImgSelect.image =[UIImage imageNamed:@"圆角矩形-3"];
     
        }
        
        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_arr2[0] isEqual:@"showSingleChoiceDialog"]) {
        [_selctMArr removeAllObjects];
        [_selctMArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }else {
        if([_selctMArr containsObject:[NSString stringWithFormat:@"%ld",(long)(long)indexPath.row]]){
            [_selctMArr removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }else{
            [_selctMArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
    }
    [_tableview reloadData];

    
}
#pragma mark ----确定按钮
-(void)sureBtn:(UIButton *)sender{
    NSMutableArray *namesMarr = [NSMutableArray array];
    NSMutableArray  *idMarr = [NSMutableArray array];

    int i=0;
    for (NSString *string in _selctMArr) {
        if ([string isEqual:@"-1"]) {
            [self removeFromSuperview];
            return;
        }
        i = [string intValue];
        [idMarr addObject:[_arr2[2] componentsSeparatedByString:@";"][i]];
        [namesMarr addObject:[_arr2[3] componentsSeparatedByString:@";"][i]];
        i++;
    }


       [_delegate selectCodes:[idMarr componentsJoinedByString:@";"] andNames:[namesMarr componentsJoinedByString:@";"]];

  
    
    [self removeFromSuperview];
}




- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if (![touch.view isKindOfClass:[self class]]) {
        return NO;
    }
    return YES;

}
#pragma mark ---隐藏按钮
-(void)hidden:(UITapGestureRecognizer *)tap{
     [self removeFromSuperview];
}



@end
