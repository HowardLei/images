//
//  HomeViewController.m
//  TabBarControllerCustomDemo
//
//  Created by sjimac01 on 2018/1/24.
//  Copyright © 2018年 sjimac01. All rights reserved.
//

#import "HomeViewController.h"
#import "Define.h"
#import "HomeCell.h"
#import "HomeDetailViewController.h"
#import "Tabbar.h"

@interface HomeViewController () <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) NSMutableArray *dataSource;       // 图片数组
@property(strong, nonatomic) NSMutableArray *titles;           // 主标题数组
@property(strong, nonatomic) NSMutableArray *titleTwos;        // 副标题数组
@property(strong, nonatomic) NSMutableArray *contents;         // 内容数组
@property(strong, nonatomic) UIView *headerView;               // 头部
@property(strong, nonatomic) UILabel *timeLabel;               // 时间
@property(strong, nonatomic) UILabel *titleLabel;              // Today
@property(strong, nonatomic) UIButton *userButton;             //

@end

@implementation HomeViewController {
    NSIndexPath *selectIndexPath;
}
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // 设置 navigaitonControllerDelegate
    self.navigationController.delegate = self;
    // 隐藏状态栏
    [UIView animateWithDuration:0.2 animations:^{
        [UIApplication.sharedApplication setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self buildHeaderView];
}

#pragma mark - Today 头像 UI
- (UIView *)buildHeaderView {
    // header
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 115);
    // 日期
    self.timeLabel.frame = CGRectMake(SCREEN_RATIO(22), 30, SCREEN_WIDTH / 2, 14);
    self.timeLabel.text = [self getWeekDay];
    // 标题
    self.titleLabel.frame = CGRectMake(SCREEN_RATIO(22), 55, (SCREEN_WIDTH / 3) * 2, 30);

    // 登录按钮
    self.userButton.frame = CGRectMake(SCREEN_WIDTH - 44 - SCREEN_RATIO(22), 38, 44, 44);
    self.userButton.layer.masksToBounds = YES;
    self.userButton.layer.cornerRadius = 22;
    [self.userButton addTarget:self action:@selector(userButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    设置图片的显示
    [self.userButton setImage:[UIImage imageNamed:@"Mine_photo_define"] forState:UIControlStateNormal];
//    [imageView setContentScaleFactor:[[UIScreen mainScreen]scale]];
//    imageView.contentMode=UIViewContentModeScaleAspectFill;
//    imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
//    imageView.clipsToBounds=YES;
    [self.headerView addSubview:self.timeLabel];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.userButton];

    return self.headerView;
}
#pragma mark - ==============================Click============================
- (void)userButtonClick {

}
#pragma mark - 获取当前时间，日期
- (NSString *)getWeekDay {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *dateTime = [formatter stringFromDate:date];
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    NSString *weekTime = [weekdays objectAtIndex:theComponents.weekday];
    return [NSString stringWithFormat:@"%@  %@", dateTime, weekTime];
}
#pragma mark - 截屏
- (UIImage *)imageFromView {
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark - ==============================Data============================
//在此改变文字和图片
- (void)initData {
    [self.dataSource addObjectsFromArray:@[@"zlr.jpg", @"8.png", @"2.png", @"4.png"]];
    [self.titles addObject:@"#男孩👦的故事#"];
    [self.titles addObject:@"#茉莉花#"];
    [self.titles addObject:@"#桃花#"];
    [self.titles addObject:@"#金花茶#"];

    [self.titleTwos addObject:@""];
    [self.titleTwos addObject:@""];
    [self.titleTwos addObject:@""];
    [self.titleTwos addObject:@""];

    [self.contents addObject:@"男孩嘴上带着疑问的表情，他把电话还给了我，我不知道这一天还能持续多久。事实上，我爱上了他，但我不知道下一步该做什么。"];
    [self.contents addObject:@"                     昨夜风花几度红\n                     今朝栀子满庭空\n                     多情最属江南柳\n                     植物依然绿荫中"];
    [self.contents addObject:@"                     邂逅几因看梅柳\n                     相逢何必问牛铃\n                     春风叶绿江南岸\n                     植物花红塞北汀"];
    [self.contents addObject:@"                     茶烟缭绕云遮路\n                     蛛网缠绵雨打铃\n                     一叶扁舟归棹晚\n                     谁家植物最关情"];
}

#pragma mark - ==============================Delegate============================


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCREEN_WIDTH - 40) * 1.3 + 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOMECELLID"];
    if (cell == nil) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HOMECELLID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldGroupAccessibilityChildren = YES;
    }
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.contentLabel.text = self.titleTwos[indexPath.row];
    cell.bgimageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    cell.transform = CGAffineTransformMakeScale(1, 1);
    return cell;
}

// TODO: 即将进入高亮状态
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    selectIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 animations:^{
        cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }];
    return YES;
}

// TODO: 结束高亮状态
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%u", cell.selected);
    if ([selectIndexPath isEqual:indexPath]) {
        [UIView animateWithDuration:0.2 animations:^{
            cell.transform = CGAffineTransformMakeScale(1, 1);
            return;
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    HomeDetailViewController *detail = [[HomeDetailViewController alloc] init];
    detail.selectIndexPath = indexPath;
    detail.bgImage = [self imageFromView];
    detail.titles = self.titles[indexPath.row];
    detail.titleTwo = self.titleTwos[indexPath.row];
    detail.content = self.contents[indexPath.row];
    detail.imageName = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - UIViewControllerAnimatedTransitioning
// MARK: 设置代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return self;
}
// MARK: 设置动画时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    HomeCell *cell = (HomeCell *) [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [toVC valueForKeyPath:@"headerImageView"];
    UIView *fromView = cell.bgView;
    UIView *containerView = [transitionContext containerView];
    UIView *snapShotView = [[UIImageView alloc] initWithImage:cell.bgimageView.image];
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    fromView.hidden = YES;
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toView.hidden = YES;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 30)];
    titleLabel.textColor = COLOR_WHITE;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = FONT_B(25);
    titleLabel.text = cell.titleLabel.text;
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (SCREEN_WIDTH - 40) * 1.3 - 30, SCREEN_WIDTH - 44, 15)];
    contentLabel.font = FONT_PF(15);
    contentLabel.textColor = COLOR_WHITE;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.alpha = 0.5;
    contentLabel.text = cell.contentLabel.text;
    [snapShotView addSubview:titleLabel];
    [snapShotView addSubview:contentLabel];
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0f;
        Tabbar *tabBar = (Tabbar *) self.tabBarController.tabBar;
        if (IPHONE_X) {
            tabBar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 83);
        } else {
            tabBar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 49);
        }
        snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
        titleLabel.frame = CGRectMake(22, 30, SCREEN_WIDTH - 30, 30);
        contentLabel.frame = CGRectMake(22, SCREEN_WIDTH * 1.3 - 30, SCREEN_WIDTH * 1.3 - 44, 15);
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        fromView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self.tableView reloadData];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}


#pragma mark - ==============================实例化============================

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_CLEAR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = COLOR_CLEAR;

    }
    return _headerView;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT_14;
        _timeLabel.textColor = COLOR_6;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT_B(30);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = COLOR_3;
        _titleLabel.text = HOME_TITLE;
    }
    return _titleLabel;
}

- (UIButton *)userButton {
    if (_userButton == nil) {
        _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userButton.backgroundColor = COLOR_CLEAR;
    }
    return _userButton;
}

- (NSMutableArray *)titles {
    if (_titles == nil) {
        _titles = [[NSMutableArray alloc] init];
    }
    return _titles;
}

- (NSMutableArray *)titleTwos {
    if (_titleTwos == nil) {
        _titleTwos = [[NSMutableArray alloc] init];
    }
    return _titleTwos;
}

- (NSMutableArray *)contents {
    if (_contents == nil) {
        _contents = [[NSMutableArray alloc] init];
    }
    return _contents;
}

@end
