//
//  MSShareInterface.h
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDShareInterfaceState) {
    DDShareInterfaceStateNone = 0,
    DDShareInterfaceStatePendingShare,
    DDShareInterfaceStatePendingAuth,
    DDShareInterfaceStatePendingSend,
    DDShareInterfaceStatePendingRefreshToken,
    DDShareInterfaceStateFinished,
    DDShareInterfaceStateFailed
};

@protocol DDShareInterfaceDelegate;
@class DDShareItem;
@interface DDShareInterface : NSObject

@property (weak, nonatomic) id<DDShareInterfaceDelegate> delegate;
@property (assign, nonatomic) DDShareInterfaceState status;
@property (strong, nonatomic) __kindof DDShareItem *shareItem;

@property (readonly, nonatomic) NSString *localizedName;
@property (readonly, nonatomic) UIImage *iconImage;

// 分享
+ (BOOL)canShareItem:(DDShareItem *)item;
+ (BOOL)supportAppInnerShare;
+ (BOOL)requiresAuthentication;
+ (BOOL)isLogin;

// for override
+ (BOOL)canShareText;
+ (BOOL)canShareImage;
+ (BOOL)canShareURL;

- (BOOL)openURL:(NSURL *)URL;

+ (BOOL)needLocalApplication;
+ (BOOL)isApplicationInstall;

- (instancetype)initWithItem:(DDShareItem *)shareItem;

- (void)send;

- (void)notifySuccess;
- (void)notifyFailureWithMessage:(NSString *)error;

- (void)applicationDidBecomeActiveNotification:(NSNotification *)noti;

@end

@protocol DDShareInterfaceDelegate <NSObject>

- (void)shareDidSucceed:(DDShareInterface *)interface;
- (void)shareDidFail:(DDShareInterface *)interface error:(NSError *)error;

@end
