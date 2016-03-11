//
//  FWHttpTool.m
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWHttpTool.h"
#import "AFNetworking.h"

@implementation FWHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ?: success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ?: success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         !failure ?: failure(error);
    }];

}

+ (void)post:(NSString *)url params:(NSDictionary *)params photoParams:(NSDictionary *)photoParams constructingBodyWithBlock:(void (^)(id))constructing success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:photoParams[@"date"] name:photoParams[@"name"] fileName:photoParams[@"fileName"] mimeType:photoParams[@"mimeType"]];
        !constructing ?: constructing(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ?: success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
    }];

}
@end
