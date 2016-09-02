//
//  DDShareItem.h
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, DDShareType) {
    DDShareTypeUndefined = 0,
    DDShareTypeURL,
    DDShareTypeText,
    DDShareTypeImage
};

@interface DDShareItem : NSObject

@property (assign, nonatomic) NSInteger shareType;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;

@property (strong, nonatomic) NSURL *URL;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *thumbImage;

@property (strong, readonly, nonatomic) NSData *imageData;          // < 5M
@property (strong, readonly, nonatomic) NSData *thumbImageData;     // < 32K

@end
