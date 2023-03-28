//
//  RSMyRingCustomView.m
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyRingCustomView.h"
#import "XLPhotoBrowser.h"
#import <UIImageView+WebCache.h>


#import <HUPhotoBrowser.h>
#define EACHROWNUM 2
#define MARGIN 1


@interface RSMyRingCustomView ()<XLPhotoBrowserDelegate>


@property (nonatomic,strong)NSArray * imageArray;



@property (nonatomic,strong)NSString * contentStr;



@property (nonatomic,strong)NSString * cover;


@property (nonatomic,strong)NSString * viewType;





@end

@implementation RSMyRingCustomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        
        
        
        
        
        
    }
    
    return self;
}




//这边是视频的地方
- (void)addVideoURL:(NSString *)cover andViewType:(NSString *)viewType{
    
    _cover = cover;
    _viewType = viewType;
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:self.bounds];
    // [btn setBackgroundColor:[UIColor yellowColor]];
    
    image.userInteractionEnabled = YES;
    //[image sd_setImageWithURL:] placeholderImage:[UIImage imageNamed:@"图片加载失败"]];
    [image sd_setImageWithURL:[NSURL URLWithString:cover] placeholderImage:[UIImage imageNamed:@"512"]];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
    [image addGestureRecognizer:tap];
    tap.view.tag = self.tag;
    
     [self addSubview:image];
    
    
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.clipsToBounds = YES;
    UIImageView * playImage = [[UIImageView alloc]init];
    playImage.image = [UIImage imageNamed:@"shiping"];
    [image addSubview:playImage];
    playImage.contentMode = UIViewContentModeScaleAspectFill;
    playImage.clipsToBounds=YES;
    
    
    playImage.sd_layout
    .centerXEqualToView(image)
    .centerYEqualToView(image)
    .widthIs(20)
    .heightIs(20);
    
    // [btn setImage:image.image forState:UIControlStateNormal];
    
    
    //[btn addTarget:self action:@selector(choiceImageBrowser:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
    
}








#pragma mark -- 添加图片的个数
- (void)addPictureAndNSArray:(NSArray * )array andContentStr:(NSString *)contentStr{
    
    _contentStr = contentStr;
    if(array.count == 0){
     
        /**
         NSMutableArray * array = [NSMutableArray array];
         for (int i = 0; i <moment.photos.count; i++) {
         //aaaaa.png -> aaaaa_mini.jpg
         NSString * str =moment.photos[i];
         if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
         str = [str substringToIndex:str.length - 5];
         str = [str stringByAppendingString:@"_mini.jpg"];
         }else{
         str = [str substringToIndex:str.length - 4];
         str = [str stringByAppendingString:@"_mini.jpg"];
         }
         [array addObject:str];
         }
         */
        
        
        
    }else if (array.count == 1) {

        _imageArray = array;
        //一张图片
        UIImageView * image = [[UIImageView alloc]initWithFrame:self.bounds];
       // [btn setBackgroundColor:[UIColor yellowColor]];
        
        
        
        for (int i = 0; i <array.count; i++) {
            //aaaaa.png -> aaaaa_mini.jpg
            NSString * str =array[i];
            if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
                str = [str substringToIndex:str.length - 5];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }else{
                str = [str substringToIndex:str.length - 4];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }
            
             [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@"512"]];
            
        }
        

        
        image.userInteractionEnabled = YES;
       
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
        [image addGestureRecognizer:tap];
        
       // [btn setImage:image.image forState:UIControlStateNormal];
        
        
        //[btn addTarget:self action:@selector(choiceImageBrowser:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:image];
 
    }else if (array.count == 2){
        
        //俩张图片
        
        
        _imageArray = array;
      //  CGFloat btnStartX = MARGIN;
       // CGFloat btnStartY = MARGIN;
        CGFloat imageW = (self.bounds.size.width - (EACHROWNUM+1)*MARGIN)/EACHROWNUM;
       // NSInteger count = array.count/EACHROWNUM;
        CGFloat imageH = self.bounds.size.height;
        
        for (int i = 0; i< array.count; i++) {
            UIImageView *image = [[UIImageView alloc]init];
            //会影响y值
           // NSInteger row = i/EACHROWNUM;
           // CGFloat viewY = MARGIN + row*(MARGIN + viewH);
            //会影响x值
            NSInteger colom = i%EACHROWNUM;
            CGFloat imageX = MARGIN + colom*(MARGIN + imageW);
             image.userInteractionEnabled = YES;
            
            
            NSString * str =array[i];
            if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
                str = [str substringToIndex:str.length - 5];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }else{
                str = [str substringToIndex:str.length - 4];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@"512"]];
            image.contentMode = UIViewContentModeScaleAspectFill;
            image.clipsToBounds = YES;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
            [image addGestureRecognizer:tap];
            
           // [btn setImage:image.image forState:UIControlStateNormal];
            
           // btn.backgroundColor = [UIColor blueColor];
            image.frame = CGRectMake(imageX, 0, imageW, imageH);
            
            [self addSubview:image];
            
        }
    }else if (array.count == 3){
        //三张图片
        _imageArray = array;
        
        CGFloat imageW = (self.bounds.size.width - (EACHROWNUM+1)*MARGIN)/EACHROWNUM;
        
        //NSInteger count =  2/EACHROWNUM;
        CGFloat imageH = 36.5;
        
        for (int i = 0; i < 2; i++) {
            UIImageView *image = [[UIImageView alloc]init];
//            //会影响y值
            // NSInteger row = i/EACHROWNUM;
            CGFloat imageY = 0.0;
            if (i == 0) {
                  imageY = MARGIN;
            }else
            {
                imageY = 2 * MARGIN + 36.5;
            }
            
            NSString * str =array[i];
            if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
                str = [str substringToIndex:str.length - 5];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }else{
                str = [str substringToIndex:str.length - 4];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }
            
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@"512"]];
             image.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
            [image addGestureRecognizer:tap];
            image.contentMode = UIViewContentModeScaleAspectFill;
            image.clipsToBounds = YES;
//            //会影响x值
//            //NSInteger colom = i%EACHROWNUM;
//            //CGFloat btnX = MARGIN + colom*(MARGIN + btnW);
            
            image.frame = CGRectMake(1, imageY, imageW, imageH);
            [self addSubview:image];
            
        }
        
        
        NSString * str =array[2];
        if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
            str = [str substringToIndex:str.length - 5];
            
            str = [str stringByAppendingString:@"_mini.jpg"];
        }else{
            str = [str substringToIndex:str.length - 4];
            
            str = [str stringByAppendingString:@"_mini.jpg"];
        }
        
        
        CGFloat rightimageW = imageW;
        CGFloat rightimageH = self.bounds.size.width;
         UIImageView * rightImage = [[UIImageView alloc]initWithFrame:CGRectMake((2 * MARGIN) + 36.5, 1, rightimageW, rightimageH)];
        
        [rightImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@"512"]];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
        [rightImage addGestureRecognizer:tap];
        rightImage.contentMode = UIViewContentModeScaleAspectFill;
        rightImage.clipsToBounds = YES;
        
        rightImage.userInteractionEnabled = YES;
        //[rightBtn setBackgroundColor:[UIColor yellowColor]];
        
        [self addSubview:rightImage];
        
        
        
        
        
        
    }else if(array.count == 4){
        //等于4张图片
       // CGFloat btnStartX = MARGIN;
       // CGFloat btnStartY = MARGIN;
        _imageArray = array;
        CGFloat imageW = (self.bounds.size.width - (EACHROWNUM+1)*MARGIN)/EACHROWNUM;
        NSInteger count = array.count/EACHROWNUM;
        CGFloat imageH = (self.bounds.size.height - (count+1)*MARGIN)/count;
        
        for (int i = 0; i< array.count; i++) {
            UIImageView * image = [[UIImageView alloc]init];
            //会影响y值
            NSInteger row = i/EACHROWNUM;
            CGFloat imageY = MARGIN + row*(MARGIN + imageH);
            //会影响x值
            NSInteger colom = i%EACHROWNUM;
            CGFloat imageX = MARGIN + colom*(MARGIN + imageW);
            //btn.backgroundColor = [UIColor blueColor];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
            [image addGestureRecognizer:tap];
            
            NSString * str =array[i];
            if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
                str = [str substringToIndex:str.length - 5];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }else{
                str = [str substringToIndex:str.length - 4];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }
            
            
             image.userInteractionEnabled = YES;
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@"512"]];
            
            image.contentMode = UIViewContentModeScaleAspectFill;
            image.clipsToBounds = YES;
            
            //[btn setBackgroundColor:[UIColor yellowColor]];
            image.frame = CGRectMake(imageX, imageY, imageW, imageH);
            
            [self addSubview:image];
            
        }

        
        
        
        
    }else{
        
        
        _imageArray = array;
        CGFloat imageW = (self.bounds.size.width - (EACHROWNUM+1)*MARGIN)/EACHROWNUM;
        NSInteger count = 4/EACHROWNUM;
        CGFloat imageH = (self.bounds.size.height - (count+1)*MARGIN)/count;
        
        for (int i = 0; i< 4; i++) {
            UIImageView *image = [[UIImageView alloc]init];
            //会影响y值
            NSInteger row = i/EACHROWNUM;
            CGFloat imageY = MARGIN + row*(MARGIN + imageH);
            //会影响x值
            NSInteger colom = i%EACHROWNUM;
            CGFloat imageX = MARGIN + colom*(MARGIN + imageW);
            //btn.backgroundColor = [UIColor blueColor];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceImageBrowser:)];
            [image addGestureRecognizer:tap];
            
            
            
            NSString * str =array[i];
            if ([str rangeOfString:@".jpeg"].location !=NSNotFound || [str rangeOfString:@".JPEG"].location !=NSNotFound) {
                str = [str substringToIndex:str.length - 5];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }else{
                str = [str substringToIndex:str.length - 4];
                
                str = [str stringByAppendingString:@"_mini.jpg"];
            }
            
            
            
             image.userInteractionEnabled = YES;
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@"512"]];
            
            image.contentMode = UIViewContentModeScaleAspectFill;
            image.clipsToBounds = YES;
            
            image.frame = CGRectMake(imageX, imageY, imageW, imageH);
            
            [self addSubview:image];
            
        }
        
    }
 
}




- (void)choiceImageBrowser:(UITapGestureRecognizer *)tap{
    
    
    if ([_viewType isEqualToString:@"video"]) {
        
        //点击视频
        
        if ([self.delegate respondsToSelector:@selector(playSelectVideo:)]) {
            [self.delegate playSelectVideo:self.tag];
        }
    }else{
        //进入图片浏览器中（第三方框架)
        XLPhotoBrowser * browser = [XLPhotoBrowser showPhotoBrowserWithImages:_imageArray currentImageIndex:0 andContentStr:_contentStr];
        //  [HUPhotoBrowser showFromImageView:tap.view withURLStrings:_imageArray atIndex:0];
       
        browser.browserStyle = XLPhotoBrowserStylePageControl;
        [browser setActionSheetWithTitle:@"是否需要保存到相册里面" delegate:self cancelButtonTitle:@"取消" deleteButtonTitle:@"保存" otherButtonTitles:nil];
        
    }
}



/**
 *  点击底部actionSheet回调,对于图片添加了长按手势的底部功能组件
 *
 *  @param browser 图片浏览器
 *  @param actionSheetindex   点击的actionSheet索引
 *  @param currentImageIndex    当前展示的图片索引
 */
- (void)photoBrowser:(XLPhotoBrowser *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex{

    switch (actionSheetindex) {

        case 1:
        {
           // NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
        }
            break;
        default:
        {
            //// 保存
           // NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [browser saveCurrentShowImage];
        }
            break;
    }

}





@end
