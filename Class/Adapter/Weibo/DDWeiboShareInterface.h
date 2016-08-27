//
//  DDWeiboShareInterface.h
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//
#import <WeiboSDK/WeiboSDK.h>

#import "DDShareInterface.h"
#import "DDAuthInterface.h"

@interface DDWeiboShareInterface : DDShareInterface <WeiboSDKDelegate, DDAuthInterfaceDelegate>

@end
