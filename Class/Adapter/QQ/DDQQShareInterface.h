//
//  DDQQShareInterface.h
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

/*
 分享消息类型         | QQ好友  QQ空间	web QQ好友    web QQ空间
 QQApiTextObject    | 支持    不支持	不支持         不支持
 QQApiImageObject   | 支持    不支持	不支持         不支持
 QQApiNewsObject    | 支持    支持	支持          支持
 QQApiAudioObject   | 支持    支持	支持          支持
 QQApiVideoObject   | 支持    支持	支持          支持
 */

#import "DDShareInterface.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface DDQQShareInterface : DDShareInterface <TencentApiInterfaceDelegate, QQApiInterfaceDelegate>

- (QQApiSendResultCode)sendObject:(QQApiObject *)obj;

@end
