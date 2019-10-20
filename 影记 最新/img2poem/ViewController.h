//
//  ViewController.h
//  img2poem
//
//  Created by 周朗睿 on 2019/9/8.
//  Copyright © 2019 周朗睿. All rights reserved.
//

#import <UIKit/UIKit.h>
//调用系统相机，引入头文件
#import <AVFoundation/AVFoundation.h>
//调用系统相册，引入头文件
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@protocol ViewControllerDelegate <NSObject>
- (void)addImage:(UIImage *)image andPoem:(NSString *)poem;
@end

@interface ViewController : UIViewController
@property (nonatomic, weak) id<ViewControllerDelegate> delegate;
@end



