//
//  PRNotificationManager.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/28/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "PRNotificationManager.h"
#import "ParkingLocationModel.h"

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

- (void)scheduleNotifications:(NSDate *)date forParkingLocation:(ParkingLocationModel *)parkingLocation
{
    NSDate *tempDate = [NSDate dateWithTimeIntervalSinceNow:10];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger options = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitTimeZone);
    NSDateComponents *components = [calendar components:options fromDate:tempDate];
    NSDateComponents *newComponents = [components copy];
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:NO];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Parking Reservation";
    content.body = @"Your parking reservation has expired.";
    content.categoryIdentifier = @"ParkingReservationExpiredCategoryIdentifier";
    content.userInfo = @{
                         @"NotificationType"    : @"ParkingReservationExpiredNotification",
                         @"parkingLocationID"   : @(parkingLocation.parkingLocationID),
                         @"parkingLocationName" : parkingLocation.name,
                         @"costPerMin"          : parkingLocation.costPerMin,
                         };
    content.sound = [UNNotificationSound defaultSound];
    
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ParkingNotificationExpiredRequestIdentifier" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Notification did not work.");
        }
    }];
}

@end
