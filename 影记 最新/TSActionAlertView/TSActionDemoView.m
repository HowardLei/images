//
//  TSActionDemoView.m
//  TSAlertActionDemo
//
//  Created by Dylan Chen on 2017/8/15.
//  Copyright © 2017年 Dylan Chen. All rights reserved.
//

#import "TSActionDemoView.h"
#import "ViewController.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

//设置委托协议
@interface TSActionDemoView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic)UIButton * headerBtn;//头部视图

@property (strong,nonatomic)UIButton * FromPictBtn;//从相册选择按钮
@property (strong,nonatomic)UIButton * TakePictBtn;//拍照上传按钮
// 图片
@property(strong,nonatomic)UIImageView *imageView;
// 文字
@property(strong,nonatomic)UIScrollView *scrollView;

//图像选择控制器
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;

@end
@implementation TSActionDemoView

//在懒加载中初始化imageView和imagePickerVC



- (instancetype)init{
    if (self = [super init]) {
        //改变一些本身的属性简易在这里改
        //change some propertys for TSActionAlertView
        
    }
    return self;
}

- (void)layoutContainerView{
    //布局containerview的位置,就是那个看得到的视图
    //layout self.containerView   self.containerview is the alertView
    CGFloat hight = 400;
    CGFloat spideLeft = (ScreenWidth - TSACTIONVIEW_CONTAINER_WIDTH)/2;
    CGFloat spideTop = (ScreenHeight - hight) * 0.4;
    self.containerView.frame = CGRectMake(spideLeft, spideTop,TSACTIONVIEW_CONTAINER_WIDTH, hight);
    
}

- (void)setupContainerViewAttributes{
    //设置containerview的属性,比如切边啥的
    //add propertys for  self.containerView
    
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.cornerRadius = 15;
    
}

- (void)setupContainerSubViews{
 
    [self.containerView addSubview:self.imageView];
    [self.containerView addSubview:self.scrollView];
}

- (void)layoutContainerViewSubViews{
    //设置子视图的frame
    self.imageView.frame = CGRectMake(0, 0, TSACTIONVIEW_CONTAINER_WIDTH, 170);
    self.scrollView.frame = CGRectMake(0, 170, TSACTIONVIEW_CONTAINER_WIDTH, 230);
}


#pragma mark - Action



-(UIImageView *)imageView
{
    //ViewController *vc = [[ViewController alloc] init];

    if(_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor greenColor];
        _imageView.image = [UIImage imageNamed:@"yyf"];
        
    }
    return _imageView;
}


-(UIScrollView *)scrollView
{
    if(_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor redColor];
//        隐藏水平滚动条
        _scrollView.showsVerticalScrollIndicator = NO;
//        显示竖直滚动条
        _scrollView.showsVerticalScrollIndicator = YES;
        
        
    }
    return _scrollView;
}
@end
