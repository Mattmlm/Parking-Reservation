//
//  PRNotificationManager.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/28/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "PRNotificationManager.h"

@implementation PRNotificationManager

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static PRNotificationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)registerNotifications
{
    
}

@end
