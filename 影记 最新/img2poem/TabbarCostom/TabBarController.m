//
//  TabBarController.m
//  TabBarControllerCustomDemo
//
//  Created by sjimac01 on 2018/1/24.
//  Copyright © 2018年 sjimac01. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "FunctionViewController.h"
#import "CenterViewController.h"
#import "TSActionDemoView.h"
#import "TSActionAlertView.h"
#import "ViewController.h"
#import "Tabbar.h"
#import "UIView+YYExtension.h"
#import "YYAddView.h"
#import "ITShareController.h"
#define YYScreenW [UIScreen mainScreen].bounds.size.width
#define YYScreenH [UIScreen mainScreen].bounds.size.height

@interface TabBarController ()
@property (strong, nonatomic) Tabbar *customTabbar;
@property (nonatomic, strong) ViewController *controller;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 功能
    FunctionViewController *funcVC = [[FunctionViewController alloc] init];
    [self setViewController:funcVC title:@"我的" image:@"TB_function_normal" selectImage:@"TB_function_press"];
    self.controller.delegate = funcVC;
    
    self.customTabbar = [[Tabbar alloc] initWithCenterImage:@"add" selectImage:@"add" target:self action:@selector(CenterButtonClick)];
    [self setValue:self.customTabbar forKey:@"tabBar"];
    // 社区
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setViewController:homeVC title:@"社区" image:@"TB_home_normal" selectImage:@"TB_home_press"];
}

#pragma mark - 添加子控制器
-(void)setViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    static NSInteger index = 0;
    viewController.tabBarItem.title = title;
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.tag = index;
    index++;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

- (void)CenterButtonClick {
    [self presentViewController:self.controller animated:YES completion:nil];
}

- (ViewController *)controller {
    if (_controller == nil) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *centerVC = [storyboard instantiateInitialViewController];
        _controller = centerVC;
    }
    return _controller;
}
@end
