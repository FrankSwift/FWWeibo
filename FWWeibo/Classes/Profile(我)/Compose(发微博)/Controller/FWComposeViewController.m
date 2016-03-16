//
//  FWComposeViewController.m
//  FWWeibo
//
//  Created by travelzen on 16/1/29.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWComposeViewController.h"
#import "FWEmotionTextView.h"
#import "FWComposeToolBar.h"
#import "FWComposePhotosView.h"
#import "FWAccount.h"
#import "FWAccountTool.h"
#import "FWEmotionKeyboard.h"
#import "FWStatusTool.h"
#import "FWEmotion.h"

@interface FWComposeViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入框 */
@property(nonatomic, weak) FWEmotionTextView *textView;

/** 工具栏 */
@property(nonatomic, weak) FWComposeToolBar *toolbar;

/** 相册 */
@property(nonatomic, weak) FWComposePhotosView *photosView;

/** 是否正在切换键盘 */
@property (nonatomic, assign, getter=isChangingKeyboard) BOOL changingKeyboard;

/** 自定义键盘 */
@property (nonatomic, strong, nullable) FWEmotionKeyboard *keyboard;
@end
@implementation FWComposeViewController

- (FWEmotionKeyboard *)keyboard{
    if (!_keyboard) {
        _keyboard = [FWEmotionKeyboard keyboard];
        _keyboard.width = KScreenWidth;
        _keyboard.height = 216;
    }
    
    return _keyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavBar];
    
    // 添加输入控件
    [self setupTextView];

    // 添加工具条
    [self setupToolbar];
    
    // 添加显示图片的相册控件
    [self setupPhotosView];
    
    // 监听监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:FWEmotionDidSelectedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelete) name:FWEmotionDidDeleteNotification object:nil];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 通知
/**
 *  监听表情选中的通知
 */
- (void)emotionDidSelected:(NSNotification *)noti{
    FWEmotion *emotion =  noti.userInfo[FWSelectedEmotion];
    
    [self.textView appendEmotion:emotion];
    
    [self textViewDidChange:self.textView];
    
}

/**
 *  监听表情删除的通知
 */
- (void)emotionDidDelete{
    [self.textView deleteBackward];
}
#pragma mark - 逻辑
#pragma mark 取消
- (void)cancel{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 发送
- (void)send{
    if (self.photosView.images.count) {//有图片
        //发送有图片的微博
        [self sendStatusWithImages];
    }else{
        //发送没有图片的微博
        [self sendStatusWithoutImages];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 发送有图片的微博
- (void)sendStatusWithImages{
//    NSString *urlStr = @"https://upload.api.weibo.com/2/statuses/upload.json";
//    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
//    parameters[@"access_token"] = [FWAccountTool account].access_token;
//    parameters[@"status"] = self.textView.text;
//    
//    NSMutableDictionary *photoParams = [NSMutableDictionary dictionaryWithCapacity:0];
//    UIImage *firstImg = [self.photosView.images firstObject];
//    NSData *date = UIImageJPEGRepresentation(firstImg, 1.0);
//    photoParams[@"date"] = date;
//    photoParams[@"name"] = @"pic";
//    photoParams[@"fileName"] = @"text.jpg";
//    photoParams[@"mimeType"] = @"image/jpeg";
//    
//   [FWHttpTool post:urlStr params:parameters photoParams:photoParams constructingBodyWithBlock:^(id formData) {
//       
//   } success:^(id responseObj) {
//       FWLog(@"请求成功:%@",responseObj);
//   } failure:^(NSError *error) {
//       FWLog(@"请求失败:%@",error);
//   }];
    
}

#pragma mark 发送没有图片的微博
- (void)sendStatusWithoutImages{
    FWSendStatusParam *param = [[FWSendStatusParam alloc] init];
    param.access_token = [FWAccountTool account].access_token;
    param.status = self.textView.realText;
    [FWStatusTool sendStatus:param success:^(FWSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}

#pragma mark 键盘弹出
- (void)keyboardWillShow:(NSNotification *)noti{
    CGFloat duration = [noti.userInfo[UIKeyboardWillHideNotification] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

#pragma mark 键盘消失
- (void)keyboardWillHide:(NSNotification *)noti{
    if (self.isChangingKeyboard)    return;
    
    CGFloat duration = [noti.userInfo[UIKeyboardWillHideNotification] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 视图
#pragma mark 设置导航栏
- (void)setupNavBar{
    NSString *name = [FWAccountTool account].screen_name;
    if (name) {
        // 构建文字
        NSString *prefix = @"发微博";
        NSString *text = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[text rangeOfString:name]];
        
        // 创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.title = @"发微博";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

#pragma mark 添加输入控件
- (void)setupTextView{
    FWEmotionTextView *textView = [[FWEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placehoder = @"分享新鲜事...";
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark 添加工具条
- (void)setupToolbar{
    FWComposeToolBar *toolBar = [[FWComposeToolBar alloc] initWithButtonClick:^(FWComposeToolBar *toolBar, FWComposeToolbarButtonType type) {
        switch (type) {
            case FWComposeToolbarButtonTypeCamera:
                
                [self openCamera];
                break;
            case FWComposeToolbarButtonTypePicture:
                [self openPicture];
                break;
            case FWComposeToolbarButtonTypeMention:
                FWLog(@"FWComposeToolbarButtonTypeMention");
                break;
            case FWComposeToolbarButtonTypeTrend:
                FWLog(@"FWComposeToolbarButtonTypeTrend");
                break;
            case FWComposeToolbarButtonTypeEmotion:
                [self openEmotion];
                break;
        }
    }];
    
    
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.y = self.view.height - toolBar.height;
    toolBar.x = 0;
    [self.view addSubview:toolBar];
    self.toolbar = toolBar;

}

#pragma mark 打开照相机
- (void)openCamera{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark 打开相册
- (void)openPicture{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark 打开表情
- (void)openEmotion{
    
    self.changingKeyboard = YES;
    
    if(self.textView.inputView){//自定义键盘
        self.textView.inputView = nil;
        self.toolbar.showEmotionButton = YES;
    }else{//系统自带键盘
       
        self.textView.inputView = self.keyboard;
        self.toolbar.showEmotionButton = NO;
    }
    
    [self.textView resignFirstResponder];
    self.changingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
    
   
}

#pragma mark 添加显示图片的相册控件
- (void)setupPhotosView{
    FWComposePhotosView *photosView = [[FWComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 100;
    photosView.x = 10;
    [self.textView addSubview:photosView];
    
    self.photosView = photosView;
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.changingKeyboard = NO;
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.将图片添加到相册
    [self.photosView addImage:image];
    
}

@end
