//
//  ViewController.m
//  img2poem
//
//  Created by 周朗睿 on 2019/9/8.
//  Copyright © 2019 周朗睿. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

// 重写类方法，更改编码模式 Unicode->中文
@interface NSArray (Log)
@end

@interface NSDictionary (Log)
@end

@implementation NSArray (Log)
/// 打印数组和字典时会自动调用这个方法,在分类中重写这个方法时,在使用时不需要导入头文件
- (NSString *)descriptionWithLocale:(id)locale {
    // 创建可变字符串
    NSMutableString *stringM = [NSMutableString string];
    // 拼接开头
    [stringM appendString:@"(\n"];
    // 遍历出元素,拼接中间的内容部分
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [stringM appendFormat:@"\t%@,\n", obj];
    }];
    // 拼接结尾
    [stringM appendString:@")\n"];
    return stringM;
}
@end

@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale {
    // 创建可变字符串
    NSMutableString *stringM = [NSMutableString string];
    // 拼接开头
    [stringM appendString:@"{\n"];
    //  遍历出元素,拼接中间的内容部分
    [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
        [stringM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    // 拼接结尾
    [stringM appendString:@"}\n"];
    return stringM;
}
@end

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

// 显示结果的uilabel
@property(weak, nonatomic) IBOutlet UILabel *poemlabel;
// 传递图片的imgview
@property(weak, nonatomic) IBOutlet UIImageView *imgView;
@property(nonatomic, strong) UIImagePickerController *imagePickerController;
//添加关闭弹窗的手势
@property(nonatomic, strong) UITapGestureRecognizer *closeGesture;
@property(nonatomic, strong) NSMutableDictionary<NSString *, id> *controllerDict;
@end

// 全局变量 生成诗歌项目的access token
NSString *poem_token = nil;
NSString *img_result = nil;
NSString *poem_result = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPoemAccessToken]; //获取poem的accesstoken
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
    [self.view addGestureRecognizer:tap1];
    // NSLog(@"tap1okokokok");
    // 为imageView添加点击事件：
    self.imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatar)];
    [self.imgView addGestureRecognizer:tap];
    // NSLog(@"tapokokokok");
}

- (IBAction)returnButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)Tap:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        // delegate 遵循了两个代理
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

- (void)tapAvatar {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        [self checkCameraPermission];//检查相机权限
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        [self checkAlbumPermission];//检查相册权限
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    [alert addAction:camera];
    [alert addAction:album];
    [alert addAction:cancel];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Camera

- (void)checkCameraPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [self takePhoto];
            }
        }];
    } else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        [self alertAlbum];
    } else {
        [self takePhoto];
    }
}

- (void)takePhoto {
    //判断相机是否可用，防止模拟器点击【相机】导致崩溃
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:^{

        }];
    } else {
        NSLog(@"不能使用模拟器进行拍照");
    }
}

#pragma mark - Album

- (void)checkAlbumPermission {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    [self selectAlbum];
                }
            });
        }];
    } else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [self alertAlbum];
    } else {
        [self selectAlbum];
    }
}

- (void)selectAlbum {
    //判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:^{
        }];
    }
}

- (void)alertAlbum {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请在设置中打开相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    self.imgView.image = image;
    [self img2word];
}

// 生成诗button
// 通过拖线添加generateButton 点击该按钮可以根据setLabel中的关键词生成诗，并返回至getLabel
- (IBAction)generateButton:(id)sender {
    //[self img2word];
    [self word2poem];
    if ([self.delegate respondsToSelector:@selector(addImage:andPoem:)]) {
        [self.delegate addImage:self.imgView.image andPoem:@"string"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 生成故事button
- (IBAction)img:(id)sender {
    //[self img2word];
}

// 获取access_token的方法
- (void)getPoemAccessToken {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //一但用了这个返回的那个responseObject就是NSData，如果不用就是简单的
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"image/jpeg", @"text/plain", nil];
    NSDictionary<NSString *, NSString *> *dict = @{@"grant_type": @"client_credentials",
        //@"client_id":@"填写你的API Key",
        @"client_id": @"5Ypt1T0NeB8NybBpUEMvt5HA",
        //@"client_secret":@"填写你的Secret Key"
        @"client_secret": @"W6P5RGA5cfVQ2adkugixHSzAjKzv9h3t"
    };
    [manager POST:@"https://aip.baidubce.com/oauth/2.0/token" parameters:dict progress:nil
          success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
              NSDictionary *dict = (NSDictionary *) responseObject;
              NSString *accessToken = dict[@"access_token"];
              //d_accessToken = dict[@"access_token"];
              NSLog(@"accessToken请求成功%@", accessToken);
              poem_token = dict[@"access_token"];
          }
          failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
              NSLog(@"请求失败--%@", error);
          }];
}

// 图像识别
- (void)img2word {
    //1 创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求头 header
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *headerFieldValueDictionary = @{@"Content-Type": @"application/x-www-form-urlencoded"};
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    manager.requestSerializer = requestSerializer;

    NSString *code = [self img2base64];
    // 请求的url
    NSString *img_url = [NSString stringWithFormat:@"https://aip.baidubce.com/rest/2.0/image-classify/v1/plant?access_token=%@", poem_token];

    NSDictionary<NSString *, NSString *> *paramDict = @{@"image": code};
    [manager POST:img_url parameters:paramDict progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        img_result = responseObject[@"result"][0][@"name"];
        NSLog(@"图像识别请求成功%@", responseObject[@"result"][0][@"name"]);
    }     failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        NSLog(@"请求失败----%@", error);
    }];
    //[self word2poem];
}

// 关键词生成诗
- (void)word2poem {
    if ([self.imgView.image isEqual:[UIImage imageNamed:@"imageinit"]]) {
        // FIXME: 为什么这个地方的弹窗一弹就消失了？
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法生存诗歌" message:@"对不起，您并没有设置该图片，请重新设置" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"好的，我重新添加一下" style:UIAlertActionStyleCancel handler:nil];
//        [alertController addAction:cancalAction];
//        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        //1 创建会话管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 设置请求头 header
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        NSDictionary *headerFieldValueDictionary = @{@"Content-Type": @"application/json"};
        if (headerFieldValueDictionary != nil) {
            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
                NSString *value = headerFieldValueDictionary[httpHeaderField];
                [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
            }
        }
        manager.requestSerializer = requestSerializer;
        //2 发送post请求
        NSDictionary *paramDict = @{@"text": img_result};
        [manager POST:[NSString stringWithFormat:@"https://aip.baidubce.com/rpc/2.0/creation/v1/poem?access_token=%@", poem_token] parameters:paramDict progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            NSArray *arr = [responseObject objectForKey:@"poem"];
            NSDictionary *dic = arr[0];
            NSString *content = dic[@"content"];
            NSLog(@"%@", content);
            poem_result = content;
            NSLog(@"请求成功%@", responseObject);
            // 生成一个 view
        }     failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSLog(@"请求失败----%@", error);
        }];
    }
}

// 获取base64的方法
- (NSString *)img2base64 {
    NSData *imgData = UIImageJPEGRepresentation(self.imgView.image, 1.0f);
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //NSLog(@"base64 success%@",encodedImageStr);
    return encodedImageStr;
}

// 反向解码，检验img2base64是否奏效
- (void)base64toimg {
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:[self img2base64] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 400)];
    [imgView setImage:decodedImage];
    [self.view addSubview:imgView];
    NSLog(@"decodedImage==%@", decodedImageData);
}

// 进行urlencode处理
- (NSString *)urlEncodeStr:(NSString *)input {
    NSCharacterSet *encode_set = [NSCharacterSet URLUserAllowedCharacterSet];
    NSString *nickname = [input stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    //return nickname;
    NSString *charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    //NSString * hStr2 = @"这是一对小括号 ()<>[]{}";
    NSString *hString2 = [nickname stringByAddingPercentEncodingWithAllowedCharacters:set];
    // NSLog(@"hString2 ====== %@",hString2);
    return hString2;
}

- (NSDictionary *)jsonDictWithString:(NSString *)string {
    if (string && 0 != string.length) {
        NSError *error;
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"json解析失败：%@", error);
            return nil;
        }
        return jsonDict;
    }
    return nil;
}
@end
