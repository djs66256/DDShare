//
//  DDShareManager.h
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDShareDelegate;
@class DDShareItem, DDShareInterface, DDAuthInterface;
@interface DDShareManager : NSObject

+ (instancetype)defaultManager;

+ (BOOL)canOpenURL:(NSURL *)url;
+ (BOOL)openURL:(NSURL *)url;

+ (NSArray<DDShareInterface *> *)avaliableInterfacesForShareItem:(DDShareItem *)item;

+ (void)share:(DDShareItem *)item delegate:(id<DDShareDelegate>)delegate;
+ (void)shareWithInterfaces:(NSArray<DDShareInterface *> *)interfaces delegate:(id<DDShareDelegate>)delegate;

+ (NSArray<DDAuthInterface *> *)avaliableInterfacesForAuthentication;
+ (void)authWithInterface:(DDAuthInterface *)interface delegate:(id<DDShareDelegate>)delegate;

+ (void)logout;

@end

@protocol DDShareDelegate <NSObject>

@optional
- (void)authDidSucceed:(DDAuthInterface *)interface;
- (void)authDidFail:(DDAuthInterface *)interface error:(NSError *)error;

- (void)shareDidSucceed:(DDShareInterface *)interface;
- (void)shareDidFail:(DDShareInterface *)interface error:(NSError *)error;
- (void)allShareInterfacesDidFinish;

@end
