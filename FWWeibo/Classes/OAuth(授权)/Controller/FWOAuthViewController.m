//
//  FWOAuthViewController.m
//  FWWeibo
//
//  Created by travelzen on 16/2/14.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWOAuthViewController.h"
#import "FWControllerTool.h"
#import "FWAccount.h"
#import "FWAccountTool.h"


@interface FWOAuthViewController ()<UIWebViewDelegate>

@end
@implementation FWOAuthViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",FWAppKey,FWRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在请求.."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
/**
 *  UIWebView每当发送一个请求之前, 都会先条用这个代理方法
 *  @param request        即将发送的请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //1.获得请求地址
    NSString *url = request.URL.absoluteString;
    //2.判断url是否为回调地址
    NSString *rangeStr = [FWRedirectURI stringByAppendingFormat:@"/?code="];
    NSRange range = [url rangeOfString:rangeStr];
    
    if (range.location != NSNotFound) {
        NSString *code = [url substringFromIndex:range.length + range.location];
        
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

/**
 *  根据请求成功标记获取accessToken
 */
- (void)accessTokenWithCode:(NSString *)code{
    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    parameters[@"client_id"] = FWAppKey;
    parameters[@"client_secret"] = FWAppSecret;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = FWRedirectURI;
    
    FWAccessTokenParam *param = [[FWAccessTokenParam alloc] init];
    param.client_id = FWAppKey;
    param.client_secret = FWAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = FWRedirectURI;
    [FWAccountTool accessTokenWithParam:param success:^(FWAccount *result) {
        [MBProgressHUD hideHUD];
        
        [FWAccountTool save:result];
        
        [FWControllerTool chooseRootViewController];
    } failure:^(NSError *error) {
        FWLog(@"请求失败:%@",error);
        [MBProgressHUD hideHUD];
    }];
//    [FWHttpTool post:urlStr params:parameters success:^(id responseObj) {
//        [MBProgressHUD hideHUD];
//    
//        //字典转模型
//        FWAccount *account = [FWAccount accountWithDict:responseObj];
//
//        //储存账号模型
//        [FWAccountTool save:account];
//        
//        [FWControllerTool chooseRootViewController];
//    } failure:^(NSError *error) {
//        FWLog(@"请求失败:%@",error);
//        [MBProgressHUD hideHUD];
//    }];
    
}

@end
