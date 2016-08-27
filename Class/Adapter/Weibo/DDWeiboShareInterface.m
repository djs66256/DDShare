//
//  DDWeiboShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDShareItem.h"
#import "DDWeiboShareInterface.h"
#import "DDWeiboAuthInterface.h"
#import "DDShareUser.h"

@interface DDWeiboShareInterface ()

@property (strong, nonatomic) DDWeiboAuthInterface *authInterface;

@end

@implementation DDWeiboShareInterface

+ (BOOL)supportAppInnerShare { return YES; }
+ (BOOL)requiresAuthentication { return YES; }
+ (BOOL)isLogin { return [DDWeiboAuthInterface isLogin]; }

+ (BOOL)canShareText { return YES; }
+ (BOOL)canShareURL { return YES; }
+ (BOOL)canShareImage { return YES; }

- (NSString *)localizedName {
    return @"微博";
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"icon_share_weibo"];
}

- (BOOL)openURL:(NSURL *)URL {
    return [WeiboSDK handleOpenURL:URL delegate:self];
}

- (void)send {
    [super send];
    
    if (![DDWeiboAuthInterface isLogin]) {
        [self.authInterface auth];
    }
    else {
        DDShareUser *user = [DDWeiboAuthInterface userInfo];
        WBImageObject *imageObject = nil;
        NSString *text = self.shareItem.detail;
        if (self.shareItem.URL) {
            text = [NSString stringWithFormat:@"%@ %@", self.shareItem.detail, self.shareItem.URL.absoluteString];
        }
        if (self.shareItem.image) {
            imageObject = [[WBImageObject alloc] init];
            imageObject.imageData = self.shareItem.imageData;
        }
        [WBHttpRequest requestForShareAStatus:text
                            contatinsAPicture:imageObject
                                 orPictureUrl:nil
                              withAccessToken:user.token
                           andOtherProperties:nil
                                        queue:nil
                        withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                            if (error) {
                                [self notifyFailureWithMessage:error.localizedDescription ?: @"分享失败"];
                            }
                            else {
                                [self notifySuccess];
                            }
                        }];
    }
}

- (DDWeiboAuthInterface *)authInterface {
    if (_authInterface == nil) {
        _authInterface = [[DDWeiboAuthInterface alloc] init];
        _authInterface.delegate = self;
    }
    return _authInterface;
}

#pragma mark - delegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        [self notifySuccess];
    }
    else {
        [self notifyFailureWithMessage:@"分享失败"];
    }
}


- (void)authDidSucceed:(DDAuthInterface *)interface {
    [self send];
}

- (void)authDidFail:(DDAuthInterface *)interface error:(NSError *)error {
    [self notifyFailureWithMessage:error.localizedDescription];
}

@end
