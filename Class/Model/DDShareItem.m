//
//  DDShareItem.m
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//
#import <ImageIO/ImageIO.h>

#import "DDShareItem.h"

@implementation DDShareItem
@synthesize thumbImageData = _thumbImageData;
@synthesize imageData = _imageData;

- (NSData *)imageData {
    if (_imageData == nil && self.image) {
        UIImage *image = self.image;
        if (self.image.size.width > 1000 || self.image.size.height > 1000) {
            image = [self thumbImageWithImage:self.image maxPixelSize:1000 forceCreated:YES];
        }
        _imageData = UIImagePNGRepresentation(image);
    }
    return _imageData;
}

- (UIImage *)thumbImage {
    if (_thumbImage == nil) {
        _thumbImage = [self thumbImageWithImage:self.image maxPixelSize:80 forceCreated:NO];
    }
    return _thumbImage;
}

- (NSData *)thumbImageData {
    if (_thumbImageData == nil && self.thumbImage) {
        _thumbImageData = UIImagePNGRepresentation(self.thumbImage);
    }
    return _thumbImageData;
}

- (UIImage *)thumbImageWithImage:(UIImage *)image maxPixelSize:(NSInteger)size forceCreated:(BOOL)forceCreated {
    CFStringRef thumbnailCreatedKey = forceCreated ? kCGImageSourceCreateThumbnailFromImageAlways:kCGImageSourceCreateThumbnailFromImageIfAbsent;
    NSDictionary *options = @{(__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize: @(size),
                              (__bridge NSString *)thumbnailCreatedKey : @YES};
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)UIImagePNGRepresentation(image), (__bridge CFDictionaryRef)options);
    CGImageRef thumbImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, (__bridge CFDictionaryRef)options);
    UIImage *UIThumbImage = [UIImage imageWithCGImage:thumbImage];
    
CLEAR:
    CGImageRelease(thumbImage);
    if (imageSource) {
        CFRelease(imageSource);
    }
    
    return UIThumbImage;
}

@end
