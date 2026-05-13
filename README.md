# shilaishiwang


对XLPhotoBrowser第三方框架添加俩个方法
+ (instancetype)showPhotoBrowserWithImages:(NSArray *)images currentImageIndex:(NSInteger)currentImageIndex andContentStr:(NSString *)contentstr{
    // 数据校验
       if (images.count <= 0 || images == nil) {
           XLPBLog(@"一行代码展示图片浏览的方法,传入的数据源为空,请检查传入数据源");
           return nil;
       }
       for (id image in images) {
           if (![image isKindOfClass:[UIImage class]] &&
               ![image isKindOfClass:[NSString class]] &&
               ![image isKindOfClass:[NSURL class]] &&
               ![image isKindOfClass:[ALAsset class]]) {
               XLPBLog(@"识别到非法数据格式,请检查传入数据是否为 NSString/NSURL/ALAsset 中一种");
               return nil;
           }
       }

       XLPhotoBrowser *browser = [[XLPhotoBrowser alloc] init];
       browser.imageCount = images.count;
       browser.currentImageIndex = currentImageIndex;
       browser.images = images;

       [browser show];

       if (contentstr.length > 0) {
           dispatch_async(dispatch_get_main_queue(), ^{
               
               // 全屏顶层覆盖视图，永远不被遮挡（图片/视频都显示）
               UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
               coverView.userInteractionEnabled = NO; // 不拦截点击
               coverView.backgroundColor = [UIColor clearColor];
               
               // 文字Label
               UILabel *contentLabel = [[UILabel alloc] init];
               contentLabel.text = contentstr;
               contentLabel.font = [UIFont systemFontOfSize:16];
               contentLabel.textColor = [UIColor whiteColor];
               contentLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
               contentLabel.textAlignment = NSTextAlignmentRight;
               contentLabel.numberOfLines = 0;
//               contentLabel.layer.corner = 8;
               contentLabel.clipsToBounds = YES;
               
               CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//               CGFloat margin = 15;
//               CGFloat labelW = screenW - margin*2;
               
               // 自动计算文字高度
               CGSize maxSize = CGSizeMake(screenW, CGFLOAT_MAX);
               NSDictionary *attr = @{NSFontAttributeName:contentLabel.font};
               CGFloat labelH = [contentstr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 20;
               
               // 距离底部 50 pt（你要的位置）
               CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
               CGFloat bottomMargin = 50;
               CGFloat yPos = screenH - labelH - bottomMargin;
               
               contentLabel.frame = CGRectMake(0, yPos, screenW, labelH);
               [coverView addSubview:contentLabel];
               
               // 加到最顶层 window，永远显示
               UIWindow *window = [UIApplication sharedApplication].keyWindow;
               [window addSubview:coverView];
               [window bringSubviewToFront:coverView];
           });
       }
       
       return browser;
}


+(instancetype)showPhotoBrowserWithImages:(NSArray *)images andMiniImage:(NSArray *)miniImages currentImageIndex:(NSInteger)currentImageIndex{
    
    XLPhotoBrowser *browser = [[XLPhotoBrowser alloc] init];
      browser.imageCount = miniImages.count;
      browser.currentImageIndex = currentImageIndex;
      
      // ✅ 赋值属性（标准、安全）
      browser.miniImages = miniImages;
      browser.fullImages = images;
      browser.images = miniImages; // 默认显示小图
    
      // 显示浏览器
      [browser show];

      // ====================== 按钮 ======================
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      [btn setTitle:@"查看原图" forState:UIControlStateNormal];
      [btn setTitle:@"恢复小图" forState:UIControlStateSelected];
      [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      btn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
      btn.layer.cornerRadius = 8;
      btn.clipsToBounds = YES;

      CGFloat btnW = 160;
      CGFloat btnH = 44;
      btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - btnW)*0.5,
                             [UIScreen mainScreen].bounds.size.height - 120,
                             btnW, btnH);

      // ✅ 点击方法给 browser 自己
      [btn addTarget:browser action:@selector(originalBtnClick:) forControlEvents:UIControlEventTouchUpInside];

      // ✅ 加到 window，按钮 100% 显示
      UIWindow *window = [UIApplication sharedApplication].keyWindow;
      [window addSubview:btn];

      return browser;
}


- (void)originalBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        self.images = self.fullImages; // 显示原图
    } else {
        self.images = self.miniImages; // 显示小图
    }
    NSInteger index = self.currentImageIndex;
    self.currentImageIndex = index;
    [self show];
}


对于cocoapods的情况，要是pod install之后Other Linker Flags中的$(inherited)会变成 -ObjC2 怎么办？

Pods/Target Support Files/Pods-xxx/Pods-xxx.debug.xcconfig
Pods/Target Support Files/Pods-xxx/Pods-xxx.release.xcconfig
俩个文件进行修改

Pods - 你的项目名.debug.xcconfig
Pods - 你的项目名.release.xcconfig
变成-objc2 的方式直接去改，里面的代码，用打开方式-》打开文本菜单——>修改完成之后再报错
