//
//  DDShareUser.h
//  meizhuang
//
//  Created by Daniel on 16/6/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDShareUser : NSObject <NSCoding>

@property (strong, nonatomic) NSString *interfaceName;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expireDate;

- (instancetype)initWithInterface:(Class)interface;

@end
