//
//  DDShareConfiguration.h
//  meizhuang
//
//  Created by Daniel on 16/6/29.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDShareConfiguration : NSObject

@property (strong, nonatomic) NSString *weiboAppKey;
@property (strong, nonatomic) NSString *weiboRedirectURI;

@property (strong, nonatomic) NSString *wechatAppId;

@property (strong, nonatomic) NSString *qqAppId;

+ (instancetype)defaultConfiguration;
- (void)enableDebugMode:(BOOL)enable;

@end
