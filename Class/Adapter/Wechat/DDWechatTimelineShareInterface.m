//
//  DDWechatTimelineShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/29.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDWechatTimelineShareInterface.h"

@implementation DDWechatTimelineShareInterface

- (DDWechatScene)scene {
    return DDWechatSceneTimeline;
}

- (NSString *)localizedName {
    return @"朋友圈";
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:@"icon_share_wechat_timeline"];
}

@end
