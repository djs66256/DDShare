//
//  DDShareUser.m
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DDShareUser.h"

@implementation DDShareUser

- (instancetype)initWithInterface:(Class)interface
{
    self = [super init];
    if (self) {
        _interfaceName = NSStringFromClass(interface);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _interfaceName = [coder decodeObjectForKey:NSStringFromSelector(@selector(interfaceName))];
        _token = [coder decodeObjectForKey:NSStringFromSelector(@selector(token))];
        _expireDate = [coder decodeObjectForKey:NSStringFromSelector(@selector(expireDate))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (_interfaceName) [aCoder encodeObject:_interfaceName forKey:NSStringFromSelector(@selector(interfaceName))];
    if (_token) [aCoder encodeObject:_token forKey:NSStringFromSelector(@selector(token))];
    if (_expireDate) [aCoder encodeObject:_expireDate forKey:NSStringFromSelector(@selector(expireDate))];
}

@end
