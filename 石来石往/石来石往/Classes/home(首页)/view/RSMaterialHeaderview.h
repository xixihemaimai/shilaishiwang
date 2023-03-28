//
//  RSMaterialHeaderview.h
//  石来石往
//
//  Created by mac on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSMasteMainModel.h"


@interface RSMaterialHeaderview : UITableViewHeaderFooterView

@property (nonatomic,strong)UIButton * productMoreBtn;

@property (nonatomic,strong)UIView * showView;




/**图片*/
@property (nonatomic,strong)UIImageView * productImage;

/**产品名称*/
@property (nonatomic,strong) UILabel * productName;

/**产品匝数*/
@property (nonatomic,strong)UILabel * productTurn;
/**产品的数量*/
@property (nonatomic,strong)UILabel * productNum;


@property (nonatomic,strong)RSMasteMainModel * mastemainmodel;



@end
