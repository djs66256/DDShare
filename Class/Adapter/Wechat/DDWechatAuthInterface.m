//
//  DDWechatAuthInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//
#import <3rdPartySDK/WXApi.h>

#import "DDWechatAuthInterface.h"

@implementation DDWechatAuthInterface

+ (BOOL)canAuthentication { return YES; }
+ (BOOL)needLocalApplication { return YES; }
+ (BOOL)isApplicationInstall { return [WXApi isWXAppInstalled]; }

- (WechatAuthSDK *)wechatAuth {
    if (_wechatAuth == nil) {
        _wechatAuth = [[WechatAuthSDK alloc] init];
        _wechatAuth.delegate = self;
    }
    return _wechatAuth;
}

- (NSString *)localizedName {
    return @"微信";
}

- (void)auth {
    [super auth];
    [self.wechatAuth Auth:@"" nonceStr:@"" timeStamp:@"" scope:@"" signature:@"" schemeData:@""];
}

#pragma mark - delegate
- (void)onAuthFinish:(int)errCode AuthCode:(NSString *)authCode {
    
}

@end
