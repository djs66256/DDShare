
//
//  DDShareConfiguration.m
//  meizhuang
//
//  Created by Daniel on 16/6/29.
//  Copyright © 2016年 Daniel. All rights reserved.
//
#import <WeiboSDK/WeiboSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>

#import "DDShareConfiguration.h"

@implementation DDShareConfiguration

+ (instancetype)defaultConfiguration {
    static dispatch_once_t onceToken;
    static DDShareConfiguration *config = nil;
    dispatch_once(&onceToken, ^{
        config = [DDShareConfiguration new];
    });
    return config;
}

- (void)setWeiboAppKey:(NSString *)weiboAppKey {
    _weiboAppKey = weiboAppKey;
    [WeiboSDK registerApp:weiboAppKey];
}

- (void)enableDebugMode:(BOOL)enable {
    [WeiboSDK enableDebugMode:enable];
}

- (void)setWechatAppId:(NSString *)wechatAppId {
    _wechatAppId = wechatAppId;
    [WXApi registerApp:wechatAppId];
}

- (void)setQqAppId:(NSString *)qqAppId {
    _qqAppId = qqAppId;
    
    // qq的app id注册方式 ╮(╯▽╰)╭
    TencentOAuth * __unused oauth = [[TencentOAuth alloc] initWithAppId:[DDShareConfiguration defaultConfiguration].qqAppId andDelegate:nil];
}

@end
