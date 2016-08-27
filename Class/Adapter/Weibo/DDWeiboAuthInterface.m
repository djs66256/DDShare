//
//  DDWeiboAuthInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDWeiboAuthInterface.h"
#import "DDShareUser.h"
#import "DDShareConfiguration.h"

@implementation DDWeiboAuthInterface

+ (BOOL)canAuthentication { return YES; }

- (NSString *)localizedName {
    return @"微博";
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"icon_share_weibo"];
}

- (BOOL)openURL:(NSURL *)URL {
    return [WeiboSDK handleOpenURL:URL delegate:self];
}

- (void)auth {
    [super auth];
    
    WBAuthorizeRequest *authReq = [WBAuthorizeRequest request];
    authReq.redirectURI = [DDShareConfiguration defaultConfiguration].weiboRedirectURI;
    authReq.scope = @"all";
    authReq.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    authReq.shouldShowWebViewForAuthIfCannotSSO = YES;
    [WeiboSDK sendRequest:authReq];
}

#pragma mark - delegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess && [response isKindOfClass:[WBAuthorizeResponse class]]) {
        WBAuthorizeResponse *authResp = (WBAuthorizeResponse *)response;
        DDShareUser *user = [[DDShareUser alloc] initWithInterface:self.class];
        user.token = authResp.accessToken;
        user.expireDate = authResp.expirationDate;
        self.userInfo = user;
        [self notifySuccess];
    }
    else {
        [self notifyFailureWithMessage:@"认证失败"];
    }
}

@end
