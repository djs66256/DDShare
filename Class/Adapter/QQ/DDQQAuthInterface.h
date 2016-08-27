//
//  DDQQAuthInterface.h
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDAuthInterface.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface DDQQAuthInterface : DDAuthInterface <TencentSessionDelegate>

@property (strong, nonatomic) TencentOAuth *tencentOAuth;

@end
