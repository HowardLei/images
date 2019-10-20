//
//  ITShareController.m
//  img2poem
//
//  Created by 雷维卡 on 2019/10/19.
//  Copyright © 2019 周朗睿. All rights reserved.
//

#import "ITShareController.h"
#import "Masonry.h"

@interface ITShareController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *finishButton;
@end

@implementation ITShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.dataDict[@"image"];
    self.label.text = self.dataDict[@"poem"];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.label];
    [self.view addSubview:self.editButton];
    [self.view addSubview:self.finishButton];
    [self.view addSubview:self.cancelButton];
    // 设置控件的布局
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
    }];
}
// MARK: - Button's events
- (void)dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchToController:(UIViewController *)viewController {
    [self dismissController];
    [self presentViewController:viewController animated:YES completion:nil];
}
// MARK: - Lazy loading data
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}
- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton addTarget:self action:@selector(dismissController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton *)editButton {
    if (_editButton == nil) {
        _editButton = [[UIButton alloc] init];
    }
    return _editButton;
}
- (UIButton *)finishButton {
    if (_finishButton == nil) {
        _finishButton = [[UIButton alloc] init];
        [_finishButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}
@end
