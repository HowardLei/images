//
//  TabBarController.h
//  TabBarControllerCustomDemo
//
//  Created by sjimac01 on 2018/1/24.
//  Copyright © 2018年 sjimac01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAddView.h"

@interface TabBarController : UITabBarController
//导航栏
@property (nonatomic,strong) UIView *navView;
//导航栏上面的文字
@property (nonatomic,strong) UILabel *navWord;
//加号按钮
@property (nonatomic,strong) YYAddView *addView;
//背景
@property (nonatomic,strong) UIImageView *backImage;

@end
