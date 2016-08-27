//
//  DDQQZoneShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/30.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDQQZoneShareInterface.h"

@implementation DDQQZoneShareInterface

+ (BOOL)canAuthentication { return YES; }
+ (BOOL)canShareURL { return YES; }


- (NSString *)localizedName {
    return @"QQ空间";
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"icon_share_qzone"];
}

- (QQApiSendResultCode)sendObject:(QQApiObject *)obj {
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    return [QQApiInterface SendReqToQZone:req];
}

@end
