//
//  FunctionViewController.m
//  TabBarControllerCustomDemo
//
//  Created by sjimac01 on 2018/1/24.
//  Copyright © 2018年 sjimac01. All rights reserved.
//

#import "FunctionViewController.h"
#import "XHCardSwitchView.h"

@interface FunctionViewController ()
@property(nonatomic, strong) XHCardSwitchView *xhCardSwithchView;
@property(nonatomic, strong) NSMutableArray<UIView *> *cardViews;
@end

@implementation FunctionViewController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // FIXME: 当从图片添加到图片了以后布局混乱了
    if (self.cardViews.count > 5) {
        [self.xhCardSwithchView removeFromSuperview];
        self.xhCardSwithchView = nil;
        XHCardSwitchView *xhcard = [[XHCardSwitchView alloc] initWithFrame:CGRectMake(0, 75, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 145)];
        [xhcard initCard:self.cardViews];
        self.xhCardSwithchView = xhcard;
        [self.view addSubview:self.xhCardSwithchView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:1.0];
    XHCardSwitchView *xhcard = [[XHCardSwitchView alloc] initWithFrame:CGRectMake(0, 75, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 145)];
    [self.cardViews addObject:[self addCardWithPictureName:@"1.png" poemContent:@"121.png"]];
    [self.cardViews addObject:[self addCardWithPictureName:@"6.png" poemContent:@"141.png"]];
    [self.cardViews addObject:[self addCardWithPictureName:@"12.png" poemContent:@"113.png"]];
    [self.cardViews addObject:[self addCardWithPictureName:@"4.png" poemContent:@"161.png"]];
    [self.cardViews addObject:[self addCard1With:@"zlr.jpg" :@"231.png"]];
    [xhcard initCard:self.cardViews];
    self.xhCardSwithchView = xhcard;
    [self.view addSubview:self.xhCardSwithchView];
}

//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender {
    sender.backgroundColor = [UIColor clearColor];
}

// 格式化生成card的方法
- (UIView *)addCardWithPictureName:(NSString *)pictureName poemContent:(NSString *)poemContent {
    // 创建一个新的card，并把大小设置完毕
    // 设置card的位置和大小
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(-100, 100, [UIScreen mainScreen].bounds.size.width - 80, 500)];
    card.backgroundColor = [UIColor whiteColor];
    // 初始化uiimageview，用来存放图片
    UIImageView *imageView = [[UIImageView alloc] init];
    // 通过图片名，设置存放图片的内容
    imageView.image = [UIImage imageNamed:pictureName];
    // 设置 imageView 的大小
    imageView.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 100, 190);
    //  设置 imageView 的图片按原来比例显示
    imageView.contentScaleFactor = UIScreen.mainScreen.scale;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
    // 把 imageView 添加到 card 里面
    [card addSubview:imageView];

    // 初始化 UIImageView ，用来存放图片
    UIImageView *imageView2 = [[UIImageView alloc] init];
    // 通过图片名，设置存放图片的内容
    imageView2.image = [UIImage imageNamed:poemContent];
    // 设置imageview的大小
    imageView2.frame = CGRectMake(10, 220, UIScreen.mainScreen.bounds.size.width - 100, 250);
    //  设置imageView的图片按原来比例显示
    imageView2.contentScaleFactor = UIScreen.mainScreen.scale;
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView2.clipsToBounds = YES;
    // 把 imageviewx 添加到 card 里面
    [card addSubview:imageView2];
    return card; // 返回已经处理好的card
}

- (UIView *)addCard1With:(NSString *)pictureName :(NSString *)poemContent {
    // 创建一个新的card，并把大小设置完毕
    //    设置card的位置和大小
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(-100, 300, [UIScreen mainScreen].bounds.size.width - 80, 500)];
    card.backgroundColor = [UIColor whiteColor];
    // 初始化uiimageview，用来存放图片
    UIImageView *imageView = [[UIImageView alloc] init];
    // 通过图片名，设置存放图片的内容
    imageView.image = [UIImage imageNamed:pictureName];
    // 设置imageview的大小
    imageView.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 100, 190);
    //  设置imageView的图片按原来比例显示
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
    // 把imageviewx添加到card里面
    [card addSubview:imageView];

    // 初始化uiimageview，用来存放图片
    UIImageView *imageView2 = [[UIImageView alloc] init];
    // 通过图片名，设置存放图片的内容
    imageView2.image = [UIImage imageNamed:poemContent];
    // 设置imageview的大小
    imageView2.frame = CGRectMake(10, 185, [UIScreen mainScreen].bounds.size.width - 100, 250);
    //  设置imageView的图片按原来比例显示
    [imageView2 setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView2.clipsToBounds = YES;
    // 把imageviewx添加到card里面
    [card addSubview:imageView2];
    return card; // 返回已经处理好的card
}

/**
 * 将自定义的图片与注释添加到卡片当中
 * @param picture 需要展示的图片
 * @param poemContent 需要展示的诗歌
 * @return 展示卡片
 */
- (UIView *)addCardWithImage:(UIImage *)picture poemContent:(NSString *)poemContent {
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(-100, 100, UIScreen.mainScreen.bounds.size.width - 80, 500)];
    card.backgroundColor = UIColor.whiteColor;
    // 初始化uiimageview，用来存放图片
    UIImageView *imageView = [[UIImageView alloc] init];
    // 通过图片名，设置存放图片的内容
    imageView.image = picture;
    // 设置imageview的大小
    imageView.frame = CGRectMake(10, 10, UIScreen.mainScreen.bounds.size.width - 100, 190);
    //  设置imageView的图片按原来比例显示
    imageView.contentScaleFactor = UIScreen.mainScreen.scale;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
    // 把 imageviewx 添加到card里面
    [card addSubview:imageView];

    // 创建一个 Label 保存诗歌
    UILabel *poemLabel = [[UILabel alloc] init];
    poemLabel.frame = CGRectMake(10, 220, UIScreen.mainScreen.bounds.size.width - 100, 250);
    poemLabel.text = poemContent;
    poemLabel.backgroundColor = UIColor.redColor;
    [card addSubview:poemLabel];
    return card;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现毛玻璃效果
- (void)uivisualEffectViewStyle {
    // 获取屏幕的宽度
    CGFloat ScreenW = [[UIScreen mainScreen] bounds].size.width;
    // 获取屏幕的高度
    CGFloat ScreenH = [[UIScreen mainScreen] bounds].size.height;
    //实现模糊效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];;
    effectView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    [self.view addSubview:effectView];
}

// MARK: - Lazy loading data
- (NSMutableArray<UIView *> *)cardViews {
    if (_cardViews == nil) {
        _cardViews = [NSMutableArray array];
    }
    return _cardViews;
}

// 添加图片到
- (void)addImage:(UIImage *)image andPoem:(NSString *)poem {
    UIView *card = [self addCardWithImage:image poemContent:poem];
    [self.cardViews addObject:card];
}
@end
