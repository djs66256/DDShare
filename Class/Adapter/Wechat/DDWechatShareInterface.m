//
//  DDWechatShareInterface.m
//  meizhuang
//
//  Created by Daniel on 16/6/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//
#import "DDWechatShareInterface.h"
#import "DDShareItem.h"

@implementation DDWechatShareInterface

+ (BOOL)needLocalApplication { return YES; }
+ (BOOL)isApplicationInstall {
    return [WXApi isWXAppInstalled];
}

+ (BOOL)canShareText { return YES; }
+ (BOOL)canShareImage { return YES; }
+ (BOOL)canShareURL { return YES; }

- (BOOL)openURL:(NSURL *)URL {
    return [WXApi handleOpenURL:URL delegate:self];
}

- (void)send {
    [super send];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.scene = self.scene;
    if (self.shareItem.shareType == DDShareTypeText) {
        req.bText = YES;
        req.text = self.shareItem.detail;
    }
    else {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.shareItem.title;
        message.description = self.shareItem.detail;
        
        // NOTE: thumbImage must be setted by 'setThumbImage:'
        //message.thumbData = self.shareItem.thumbImageData;
        [message setThumbImage:self.shareItem.thumbImage];
        req.message = message;
        req.bText = NO;
        
        if (self.shareItem.shareType == DDShareTypeImage) {
            WXImageObject *imageObj = [WXImageObject object];
            imageObj.imageData = self.shareItem.imageData;
            message.mediaObject = imageObj;
        }
        else if (self.shareItem.shareType == DDShareTypeURL) {
            WXWebpageObject *urlObj = [WXWebpageObject object];
            urlObj.webpageUrl = self.shareItem.URL.absoluteString;
            message.mediaObject = urlObj;
        }
        else {
            [self notifyFailureWithMessage:@"未知分享类型"];
            return;
        }
    }
    
    if (![WXApi sendReq:req]) {
        [self notifyFailureWithMessage:@"分享失败"];
    }
}

#pragma mark - delegate
-(void)onResp:(BaseResp*)resp {
    if (resp.errCode == WXSuccess) {
        [self notifySuccess];
    }
    else {
        [self notifyFailureWithMessage:resp.errStr ?: @"分享失败"];
    }
}

@end
