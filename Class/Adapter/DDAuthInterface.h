//
//  DDAuthInterface.h
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDShareInterface.h"

@protocol DDAuthInterfaceDelegate;
@class DDShareUser;
@interface DDAuthInterface : NSObject

@property (weak, nonatomic) id<DDAuthInterfaceDelegate> delegate;
@property (assign, nonatomic) DDShareInterfaceState status;
@property (strong, nonatomic) DDShareUser *userInfo;

@property (readonly, nonatomic) NSString *localizedName;
@property (readonly, nonatomic) UIImage *iconImage;

+ (BOOL)canAuthentication; // for override, default NO.
- (void)auth; // for override

+ (DDShareUser *)userInfo;
+ (BOOL)isLogin;
+ (void)logout;

- (BOOL)openURL:(NSURL *)URL; // for override, default return NO.

+ (BOOL)needLocalApplication; // for override, default NO.
+ (BOOL)isApplicationInstall; // for override, default NO.

- (void)notifySuccess; // for override
- (void)notifyFailureWithMessage:(NSString *)error; // for override

@end

@protocol DDAuthInterfaceDelegate <NSObject>
@optional
- (void)authDidSucceed:(DDAuthInterface *)interface;
- (void)authDidFail:(DDAuthInterface *)interface error:(NSError *)error;

@end