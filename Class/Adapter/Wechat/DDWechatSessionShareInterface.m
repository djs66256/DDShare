//
//  DDWechatSessionShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/29.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDWechatSessionShareInterface.h"

@implementation DDWechatSessionShareInterface

- (DDWechatScene)scene {
    return DDWechatSceneSession;
}

- (NSString *)localizedName {
    return @"微信好友";
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"icon_share_wechat"];
}

@end
