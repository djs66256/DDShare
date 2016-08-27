//
//  DDQQAuthInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//
#import <TencentOpenAPI/TencentApiInterface.h>
#import "DDShareUser.h"
#import "DDQQAuthInterface.h"
#import "DDShareConfiguration.h"

@implementation DDQQAuthInterface

//+ (BOOL)needLocalApplication { return YES; }
//+ (BOOL)isApplicationInstall {
//    return [TencentApiInterface isTencentAppInstall:kIphoneQQ] || [TencentApiInterface isTencentAppInstall:kIphoneQZONE];
//}

- (NSString *)localizedName {
    return @"QQ";
}

- (TencentOAuth *)tencentOAuth {
    if (_tencentOAuth == nil) {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:[DDShareConfiguration defaultConfiguration].qqAppId andDelegate:self];
    }
    return _tencentOAuth;
}

- (void)auth {
    [super auth];
    if (![self.tencentOAuth authorize:@[@"get_user_info", @"get_simple_userinfo"]]) {
        [self notifyFailureWithMessage:@"认证失败"];
    }
}

- (void)tencentDidLogin {
    DDShareUser *user = [[DDShareUser alloc] initWithInterface:self.class];
    user.token = self.tencentOAuth.accessToken;
    user.expireDate = self.tencentOAuth.expirationDate;
    self.userInfo = user;
    
    [self notifySuccess];
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    [self notifyFailureWithMessage:@"认证失败"];
}

- (void)tencentDidNotNetWork {
    [self notifyFailureWithMessage:@"认证失败"];
}

@end
