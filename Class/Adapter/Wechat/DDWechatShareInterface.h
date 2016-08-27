//
//  DDWechatShareInterface.h
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <3rdPartySDK/WXApi.h>

#import "DDShareInterface.h"

typedef NS_ENUM(int, DDWechatScene) {
    DDWechatSceneSession = WXSceneSession,
    DDWechatSceneTimeline = WXSceneTimeline
};

@interface DDWechatShareInterface : DDShareInterface <WXApiDelegate>

@property (readonly, nonatomic) DDWechatScene scene;

@end
