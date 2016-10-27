//
//  PRNetworking.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/26/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "PRNetworking.h"

#define kNetworkingRoot @"http://ridecellparking.herokuapp.com/api/v1/"
#define kNetworkingPathSearch @"parkinglocations/search"

@implementation PRNetworking

- (instancetype)init
{
    if (self = [super init]) {
        NSURL * url = [NSURL URLWithString:kNetworkingRoot];
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static PRNetworking *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (BFTask *)GET:(NSString *)endpoint parameters:(id)parameters
{
    BFTaskCompletionSource *BFTask = [BFTaskCompletionSource taskCompletionSource];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer = responseSerializer;
    [self.manager GET:endpoint parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //do something, save response
        [BFTask setResult:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BFTask setError:error];
    }];
    return BFTask.task;
}

- (BFTask *)POST:(NSString *)endpoint parameters:(id)parameters
{
    BFTaskCompletionSource *BFTask = [BFTaskCompletionSource taskCompletionSource];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer = responseSerializer;
    [self.manager POST:endpoint parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //do something, save response
        [BFTask setResult:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BFTask setError:error];
    }];
    return BFTask.task;
}

- (BFTask *)PATCH:(NSString *)endpoint parameters:(id)parameters
{
    BFTaskCompletionSource *BFTask = [BFTaskCompletionSource taskCompletionSource];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer = responseSerializer;
    [self.manager PATCH:endpoint parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //do something, save response
        [BFTask setResult:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BFTask setError:error];
    }];
    return BFTask.task;
}

- (BFTask *)search:(NSDictionary *)options
{
    BFTask *task = [self GET:kNetworkingPathSearch parameters:options];
    return [task continueWithBlock:^id _Nullable(BFTask * _Nonnull continuedTask) {
        if (continuedTask.error == nil) {
            NSLog(@"%@", continuedTask.result);
        }
        return continuedTask;
    }];
}

@end
