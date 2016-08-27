//
//  DDQQFriendsShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/30.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDQQFriendsShareInterface.h"

@implementation DDQQFriendsShareInterface

+ (BOOL)canAuthentication { return YES; }
+ (BOOL)canShareImage { return YES; }
+ (BOOL)canShareText { return YES; }
+ (BOOL)canShareURL { return YES; }

- (NSString *)localizedName {
    return @"QQ";
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"icon_share_qq"];
}

- (QQApiSendResultCode)sendObject:(QQApiObject *)obj {
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    return [QQApiInterface sendReq:req];
}

@end
