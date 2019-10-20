//
//  FunctionViewController.m
//  TabBarControllerCustomDemo
//
//  Created by sjimac01 on 2018/1/24.
//  Copyright © 2018年 sjimac01. All rights reserved.
//

#import "FunctionViewController.h"
#import "XHCardSwitchView.h"
#import "ViewController.h"

@interface FunctionViewController ()
@property (nonatomic, strong) XHCardSwitchView *xhCardSwithchView;
@property (nonatomic, strong) NSMutableArray<UIView *> *views;
@property (nonatomic, weak) id delegate;
@end

@implementation FunctionViewController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.views.count != 0) {
        if ([self.delegate respondsToSelector:nil]) {
            
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:1.0];
    XHCardSwitchView *xhcard = [[XHCardSwitchView alloc] initWithFrame:CGRectMake(0, 75, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 145)];
    [self.views addObject:[self addCardWithPictureName:@"1.png" poemContent:@"121.png"]];
    [self.views addObject:[self addCardWithPictureName:@"6.png" poemContent:@"141.png"]];
    [self.views addObject:[self addCardWithPictureName:@"12.png" poemContent:@"113.png"]];
    [self.views addObject:[self addCardWithPictureName:@"4.png" poemContent:@"161.png"]];
    [self.views addObject:[self addCard1With:@"zlr.jpg" :@"231.png"]];
    [xhcard initCard:self.views];
    self.xhCardSwithchView = xhcard;
    [self.view addSubview:self.xhCardSwithchView];
}

//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender {
    sender.backgroundColor = [UIColor clearColor];
}
/*
-(NSArray *)cardArr{
    NSMutableArray *muarr = [[NSMutableArray alloc]init];
    
    UIView *card1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-120, 350)];
    card1.backgroundColor = [UIColor blackColor];
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.image = [UIImage imageNamed:@"yyf.png"];
    imageView1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-120, 290);
    [imageView1 setContentScaleFactor:[[UIScreen mainScreen]scale]];
    imageView1.contentMode=UIViewContentModeScaleAspectFill;
    imageView1.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    imageView1.clipsToBounds=YES;
    UILabel *label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(0, 290, [UIScreen mainScreen].bounds.size.width-120, 90);
    label1.text = @"杨一帆真漂亮\n杨一帆真漂亮\n杨一帆真漂亮\n杨一帆真漂亮\n";
    //文字居中显示
    label1.textAlignment = UITextAlignmentCenter;
    //自动折行设置
    label1.lineBreakMode = UILineBreakModeWordWrap;
    label1.numberOfLines=4;
    [card1 addSubview:imageView1];
    [card1 addSubview:label1];
    [muarr addObject:card1];
    
    
    
    
    UIView *card2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-120, 350)];
    card2.backgroundColor = [UIColor greenColor];
    UIImageView *imageView2 = [[UIImageView alloc]init];
    imageView2.image = [UIImage imageNamed:@"Home_demo_01.png"];
    imageView2.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-120, 350);
    [card2 addSubview:imageView2];
    [muarr addObject:card2];
    UIView *card3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-120, 350)];
    card3.backgroundColor = [UIColor blackColor];
    [muarr addObject:card3];
    UIView *card4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-120, 350)];
    card4.backgroundColor = [UIColor blueColor];
    [muarr addObject:card4];
    
    return [muarr copy];
    
}
 */

// 格式化生成card的方法
- (UIView *)addCardWithPictureName:(NSString *)pictureName poemContent:(NSString *)poemContent {
    // 创建一个新的card，并把大小设置完毕
//    设置card的位置和大小
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(-100, 100, [UIScreen mainScreen].bounds.size.width - 80, 500)];
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
    imageView2.frame = CGRectMake(10,220 , [UIScreen mainScreen].bounds.size.width-100, 250);
    //  设置imageView的图片按原来比例显示
    [imageView2 setContentScaleFactor:[[UIScreen mainScreen]scale]];
    imageView2.contentMode=UIViewContentModeScaleAspectFit;
    imageView2.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    imageView2.clipsToBounds=YES;
    // 把imageviewx添加到card里面
    [card addSubview:imageView2];
//    // 初始化一个uilabel，用来存放诗
//    UILabel *label = [[UILabel alloc]init];
//    // 设置label的大小
//    label.frame = CGRectMake(0, 297, [UIScreen mainScreen].bounds.size.width-120, 90);
//    // 通过传入的string来设置label的内容
//    label.text = poemContent;
//    //文字居中显示
//    label.textAlignment = UITextAlignmentCenter;
//    //自动折行设置，设置为4行
//    label.lineBreakMode = UILineBreakModeWordWrap;
//    label.numberOfLines=0;
//
//
//    // 把label添加到card里面
//    [card addSubview:label];
    
    return card; // 返回已经处理好的card
}
- (UIView *)addCard1With :(NSString *)pictureName :(NSString *)poemContent {
    // 创建一个新的card，并把大小设置完毕
    //    设置card的位置和大小
    UIView *card = [[UIView alloc]initWithFrame:CGRectMake(-100, 300, [UIScreen mainScreen].bounds.size.width-80, 500)];
    card.backgroundColor = [UIColor whiteColor];
    // 初始化uiimageview，用来存放图片
    UIImageView *imageView = [[UIImageView alloc]init];
    // 通过图片名，设置存放图片的内容
    imageView.image = [UIImage imageNamed:pictureName];
    // 设置imageview的大小
    imageView.frame = CGRectMake(10,10 , [UIScreen mainScreen].bounds.size.width-100, 190);
    //  设置imageView的图片按原来比例显示
    [imageView setContentScaleFactor:[[UIScreen mainScreen]scale]];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds=YES;
    // 把imageviewx添加到card里面
    [card addSubview:imageView];
    
    
    // 初始化uiimageview，用来存放图片
    UIImageView *imageView2 = [[UIImageView alloc]init];
    // 通过图片名，设置存放图片的内容
    imageView2.image = [UIImage imageNamed:poemContent];
    // 设置imageview的大小
    imageView2.frame = CGRectMake(10,185 , [UIScreen mainScreen].bounds.size.width-100, 250);
    //  设置imageView的图片按原来比例显示
    [imageView2 setContentScaleFactor:[[UIScreen mainScreen]scale]];
    imageView2.contentMode=UIViewContentModeScaleAspectFit;
    imageView2.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    imageView2.clipsToBounds=YES;
    // 把imageviewx添加到card里面
    [card addSubview:imageView2];
    
    return card; // 返回已经处理好的card
}

/// 将自定义的图片与注释添加到卡片当中
/// @param picture 需要展示的图片
/// @param poemContent 需要展示的诗歌
- (UIView *)addCardWithImage:(UIImage *)picture poemContent:(NSString *)poemContent {
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(-100, 100, [UIScreen mainScreen].bounds.size.width - 80, 500)];
     card.backgroundColor = [UIColor whiteColor];
     // 初始化uiimageview，用来存放图片
     UIImageView *imageView = [[UIImageView alloc] init];
     // 通过图片名，设置存放图片的内容
     imageView.image = picture;
     // 设置imageview的大小
     imageView.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 100, 190);
    //  设置imageView的图片按原来比例显示
     [imageView setContentScaleFactor:[UIScreen.mainScreen scale]];
     imageView.contentMode = UIViewContentModeScaleAspectFill;
     imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
     imageView.clipsToBounds = YES;
     // 把 imageviewx 添加到card里面
     [card addSubview:imageView];
     
     // 初始化uiimageview，用来存放图片
     UIImageView *imageView2 = [[UIImageView alloc] init];
     // 通过图片名，设置存放图片的内容
     imageView2.image = [UIImage imageNamed:poemContent];
     // 设置imageview的大小
     imageView2.frame = CGRectMake(10,220 , [UIScreen mainScreen].bounds.size.width-100, 250);
     //  设置imageView的图片按原来比例显示
     [imageView2 setContentScaleFactor:[[UIScreen mainScreen]scale]];
     imageView2.contentMode=UIViewContentModeScaleAspectFit;
     imageView2.autoresizingMask=UIViewAutoresizingFlexibleHeight;
     imageView2.clipsToBounds=YES;
     // 把imageviewx添加到card里面
     [card addSubview:imageView2];
    return card;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//实现毛玻璃效果
- (void)uivisualEffectViewStyle{
    
    //    获取屏幕的宽度
    CGFloat ScreenW = [[UIScreen mainScreen]bounds].size.width;
    //    获取屏幕的高度
    CGFloat ScreenH = [[UIScreen mainScreen]bounds].size.height;
    //实现模糊效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];;
    effectView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    [self.view addSubview:effectView];
}
// MARK: - Lazy loading data
- (NSMutableArray<UIView *> *)views {
    if (_views == nil) {
        _views = [NSMutableArray arrayWithCapacity:5];
        NSLog(@"%lu", _views.count);
    }
    return _views;
}
@end
