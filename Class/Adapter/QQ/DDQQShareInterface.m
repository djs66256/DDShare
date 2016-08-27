//
//  DDQQShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDQQShareInterface.h"
#import "DDShareItem.h"

@implementation DDQQShareInterface

+ (BOOL)needLocalApplication { return YES; }
+ (BOOL)isApplicationInstall {
    return [QQApiInterface isQQInstalled];
}

+ (BOOL)canOpenURL:(NSURL *)URL {
    return [TencentApiInterface canOpenURL:URL delegate:nil];
}

- (BOOL)openURL:(NSURL *)URL {
    return [TencentApiInterface handleOpenURL:URL delegate:self];
}

- (void)send {
    [super send];
    
    QQApiObject *obj = nil;
    if (self.shareItem.shareType == DDShareTypeText) {
        obj = [QQApiTextObject objectWithText:self.shareItem.title];
    }
    else if (self.shareItem.shareType == DDShareTypeImage) {
        obj = [QQApiImageObject objectWithData:self.shareItem.imageData
                              previewImageData:self.shareItem.thumbImageData
                                         title:self.shareItem.title
                                   description:self.shareItem.detail];
    }
    else if (self.shareItem.shareType == DDShareTypeURL) {
        obj = [QQApiURLObject objectWithURL:self.shareItem.URL
                                      title:self.shareItem.title
                                description:self.shareItem.detail
                           previewImageData:self.shareItem.thumbImageData
                          targetContentType:QQApiURLTargetTypeNews];
    }
    else {
        [self notifyFailureWithMessage:@"未知分享类型"];
        return ;
    }
    obj.title = self.shareItem.title;
    obj.description = self.shareItem.detail;
    
    if ([self sendObject:obj] != EQQAPISENDSUCESS) {
        [self notifyFailureWithMessage:@"分享失败"];
    }
}

- (QQApiSendResultCode)sendObject:(QQApiObject *)obj {
    return EQQAPIQQNOTSUPPORTAPI;
}

#pragma mark - delegate
- (void)onReq:(QQBaseReq *)req {
//    if (req.type == ESENDMESSAGETOQQREQTYPE) {
//        
//    }
}

- (void)onResp:(QQBaseResp *)resp {
    if (resp.type == ESENDMESSAGETOQQREQTYPE) {
        if (resp.errorDescription) {
            [self notifyFailureWithMessage:resp.errorDescription ?: @"分享失败"];
        }
        else {
            [self notifySuccess];
        }
    }
}

- (void)isOnlineResponse:(NSDictionary *)response {
    
}

- (BOOL)onTencentReq:(TencentApiReq *)req {
    return NO;
}

- (BOOL)onTencentResp:(TencentApiResp *)resp {
    return NO;
}

@end
