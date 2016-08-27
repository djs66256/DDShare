//
//  MSShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDShareInterface.h"
#import "DDShareItem.h"

@implementation DDShareInterface

+ (BOOL)supportAppInnerShare { return NO; }
+ (BOOL)requiresAuthentication { return NO; }
+ (BOOL)isLogin { return NO; }

+ (BOOL)canShareItem:(DDShareItem *)item {
    switch (item.shareType) {
        case DDShareTypeText:
            return [self canShareText];
        case DDShareTypeImage:
            return [self canShareImage];
        case DDShareTypeURL:
            return [self canShareURL];
        default:
            return NO;
    }
}

+ (BOOL)canShareText { return NO; }
+ (BOOL)canShareURL { return NO; }
+ (BOOL)canShareImage { return NO; }

+ (BOOL)needLocalApplication { return NO; }
+ (BOOL)isApplicationInstall { return NO; }

- (BOOL)openURL:(NSURL *)URL { return NO; }

- (instancetype)initWithItem:(DDShareItem *)shareItem
{
    self = [super init];
    if (self) {
        _shareItem = shareItem;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)noti {
    if (_status == DDShareInterfaceStatePendingShare) {
        [self notifyFailureWithMessage:@"分享失败"];
    }
}

- (NSString *)localizedName { return nil; }

- (void)send {
    _status = DDShareInterfaceStatePendingShare;
}

- (void)notifySuccess {
    _status = DDShareInterfaceStateFinished;
    if ([self.delegate respondsToSelector:@selector(shareDidSucceed:)]) {
        [self.delegate shareDidSucceed:self];
    }
}

- (void)notifyFailureWithMessage:(NSString *)message {
    _status = DDShareInterfaceStateFailed;
    if ([self.delegate respondsToSelector:@selector(shareDidFail:error:)]) {
        NSError *error = [NSError errorWithDomain:@"error.mei.163.com" code:-1 userInfo:@{NSLocalizedDescriptionKey: message}];
        [self.delegate shareDidFail:self error:error];
    }
}

@end
