//
//  DDWechatAuthInterface.h
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//
#import <3rdPartySDK/WechatAuthSDK.h>

#import "DDAuthInterface.h"

@interface DDWechatAuthInterface : DDAuthInterface <WechatAuthAPIDelegate>

@property (strong, nonatomic) WechatAuthSDK *wechatAuth;

@end
