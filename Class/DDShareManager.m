//
//  DDShareManager.m
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDShareManager.h"
#import "DDQQFriendsShareInterface.h"
#import "DDQQZoneShareInterface.h"
#import "DDWechatSessionShareInterface.h"
#import "DDWechatTimelineShareInterface.h"
#import "DDWeiboShareInterface.h"

#import "DDQQAuthInterface.h"
#import "DDWechatAuthInterface.h"
#import "DDWeiboAuthInterface.h"

@interface DDShareManager () <DDShareInterfaceDelegate, DDAuthInterfaceDelegate>

@property (weak, nonatomic) id<DDShareDelegate> shareDelegate;
@property (weak, nonatomic) id<DDShareDelegate> authDelegate;
@property (strong, nonatomic) NSMutableArray<DDShareInterface *> *shareInterfaces;
@property (strong, nonatomic) NSMutableArray<DDAuthInterface *> *authInterfaces;

@end

@implementation DDShareManager

inline static BOOL _shareInterfaceCanShare(Class interface, DDShareItem *shareItem) {
    BOOL bShare = NO;
    if ([interface needLocalApplication]) bShare = [interface isApplicationInstall];
    else bShare = YES;
    return bShare && [interface canShareItem:shareItem];
}

inline static BOOL _authInterfaceCanAuth(Class interface) {
    if ([interface canAuthentication]) {
        if([interface needLocalApplication]) return [interface isApplicationInstall];
        else return YES;
    }
    else {
        return NO;
    }
}

+ (instancetype)defaultManager {
    static DDShareManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DDShareManager new];
    });
    return manager;
}

+ (NSArray<DDShareInterface *> *)avaliableInterfacesForShareItem:(DDShareItem *)item {
    NSMutableArray *arr = [NSMutableArray new];
    if (_shareInterfaceCanShare([DDQQZoneShareInterface class], item)) {
        [arr addObject:[[DDQQZoneShareInterface alloc] initWithItem:item]];
    }
    if (_shareInterfaceCanShare([DDQQFriendsShareInterface class], item)) {
        [arr addObject:[[DDQQFriendsShareInterface alloc] initWithItem:item]];
    }
    if (_shareInterfaceCanShare([DDWechatSessionShareInterface class], item)) {
        [arr addObject:[[DDWechatSessionShareInterface alloc] initWithItem:item]];
    }
    if (_shareInterfaceCanShare([DDWechatTimelineShareInterface class], item)) {
        [arr addObject:[[DDWechatTimelineShareInterface alloc] initWithItem:item]];
    }
    if (_shareInterfaceCanShare([DDWeiboShareInterface class], item)) {
        [arr addObject:[[DDWeiboShareInterface alloc] initWithItem:item]];
    }
    return arr;
}

+ (void)share:(DDShareItem *)item delegate:(id<DDShareDelegate>)delegate {
    [self shareWithInterfaces:[self avaliableInterfacesForShareItem:item] delegate:delegate];
}

+ (void)shareWithInterfaces:(NSArray<DDShareInterface *> *)interfaces delegate:(id<DDShareDelegate>)delegate {
    [[self defaultManager] shareWithInterfaces:interfaces delegate:delegate];
}

+ (NSArray<DDShareInterface *> *)avaliableInterfacesForAuthentication {
    NSMutableArray *arr = [NSMutableArray new];
    if (_authInterfaceCanAuth([DDQQAuthInterface class])) {
        [arr addObject:[[DDQQAuthInterface alloc] init]];
    }
    if (_authInterfaceCanAuth([DDWechatAuthInterface class])) {
        [arr addObject:[[DDWechatAuthInterface alloc] init]];
    }
    if (_authInterfaceCanAuth([DDWeiboAuthInterface class])) {
        [arr addObject:[[DDWeiboAuthInterface alloc] init]];
    }
    return arr;
}

+ (void)logout {
    [DDQQAuthInterface logout];
    [DDWechatAuthInterface logout];
    [DDWeiboAuthInterface logout];
}

+ (void)authWithInterface:(DDAuthInterface *)interface delegate:(id<DDShareDelegate>)delegate {
    [[self defaultManager] authWithInterface:interface delegate:delegate];
}

+ (BOOL)canOpenURL:(NSURL *)url {
    return [[DDShareManager defaultManager] canOpenURL:url];
}

+ (BOOL)openURL:(NSURL *)url {
    return [[DDShareManager defaultManager] openURL:url];
}

- (BOOL)canOpenURL:(NSURL *)URL {
    for (DDShareInterface *interface in self.shareInterfaces) {
        if ([[interface class] canOpenURL:URL]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)openURL:(NSURL *)url {
    for (DDShareInterface *interface in self.shareInterfaces) {
        if ([interface openURL:url]) {
            [_shareInterfaces removeObject:interface];
            return YES;
        }
    }
    for (DDAuthInterface *interface in self.authInterfaces) {
        if ([interface openURL:url]) {
            return YES;
        }
    }
    return NO;
}

- (void)shareWithInterfaces:(NSArray<DDShareInterface *> *)interfaces delegate:(id<DDShareDelegate>)delegate {
    self.shareDelegate = delegate;
    self.shareInterfaces = interfaces.mutableCopy;
    
    [self _dispatchShare];
}

- (void)_dispatchShare {
    if (self.shareInterfaces.count > 0) {
        DDShareInterface *interface = self.shareInterfaces.firstObject;
        interface.delegate = self;
        [interface send];
    }
    else {
        if ([self.shareDelegate respondsToSelector:@selector(allShareInterfacesDidFinish)]) {
            [self.shareDelegate allShareInterfacesDidFinish];
        }
    }
}

- (void)authWithInterface:(DDAuthInterface *)interface delegate:(id<DDShareDelegate>)delegate {
    if (interface) {
        self.authDelegate = delegate;
        _authInterfaces = @[interface].mutableCopy;
        interface.delegate = self;
        [interface auth];
    }
}

#pragma mark - delegate
- (void)shareDidSucceed:(DDShareInterface *)interface {
    if ([self.shareDelegate respondsToSelector:@selector(shareDidSucceed:)]) {
        [self.shareDelegate shareDidSucceed:interface];
    }
    
    [_shareInterfaces removeObject:interface];
    
    [self _dispatchShare];
}

- (void)shareDidFail:(DDShareInterface *)interface error:(NSError *)error {
    if ([self.shareDelegate respondsToSelector:@selector(shareDidFail:error:)]) {
        [self.shareDelegate shareDidFail:interface error:error];
    }
    [_shareInterfaces removeObject:interface];
    
    [self _dispatchShare];
}

- (void)authDidSucceed:(DDAuthInterface *)interface {
    if ([self.shareDelegate respondsToSelector:@selector(authDidSucceed:)]) {
        [self.shareDelegate authDidSucceed:interface];
    }
}

- (void)authDidFail:(DDAuthInterface *)interface error:(NSError *)error {
    if ([self.shareDelegate respondsToSelector:@selector(authDidFail:error:)]) {
        [self.shareDelegate authDidFail:interface error:error];
    }
}

@end
