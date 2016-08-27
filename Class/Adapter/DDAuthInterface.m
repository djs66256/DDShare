//
//  DDAuthInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDAuthInterface.h"
#import "DDShareUser.h"

@implementation DDAuthInterface
@synthesize userInfo = _userInfo;

+ (BOOL)canAuthentication { return NO; }

+ (NSString *)userInfoKey { return [NSString stringWithFormat:@"%@.userInfo", NSStringFromClass(self.class)]; }
+ (DDShareUser *)userInfo {
    NSString *key = self.userInfoKey;
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    DDShareUser *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (userInfo) {
        if ([userInfo.expireDate timeIntervalSinceNow] > 0) {
            return userInfo;
        }
        else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return nil;
}
+ (BOOL)isLogin {
    return [self userInfo] != nil;
}
+ (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.userInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)needLocalApplication { return NO; }
+ (BOOL)isApplicationInstall { return NO; }

- (BOOL)openURL:(NSURL *)URL { return NO; }

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)noti {
    if (_status == DDShareInterfaceStatePendingAuth) {
        [self notifyFailureWithMessage:@"认证失败"];
    }
}

- (NSString *)localizedName { return nil; }

- (void)auth { _status = DDShareInterfaceStatePendingAuth; }

- (DDShareUser *)userInfo {
    if (_userInfo == nil) {
        _userInfo = [[self class] userInfo];
    }
    return _userInfo;
}

- (void)setUserInfo:(DDShareUser *)userInfo {
    if (_userInfo != userInfo) {
        _userInfo = userInfo;
        NSString *key = [self class].userInfoKey;
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)notifySuccess {
    _status = DDShareInterfaceStateFinished;
    if ([self.delegate respondsToSelector:@selector(authDidSucceed:)]) {
        [self.delegate authDidSucceed:self];
    }
}

- (void)notifyFailureWithMessage:(NSString *)message {
    _status = DDShareInterfaceStateFailed;
    if ([self.delegate respondsToSelector:@selector(authDidFail:error:)]) {
        NSError *error = [NSError errorWithDomain:@"error.mei.163.com" code:-1 userInfo:@{NSLocalizedDescriptionKey: message}];
        [self.delegate authDidFail:self error:error];
    }
}

@end
