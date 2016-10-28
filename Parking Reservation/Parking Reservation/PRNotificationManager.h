//
//  PRNotificationManager.h
//  Parking Reservation
//
//  Created by Matt Mo on 10/28/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;

@interface PRNotificationManager : NSObject

- (instancetype)init NS_UNAVAILABLE NS_DESIGNATED_INITIALIZER;
+ (instancetype)sharedInstance;

@end
