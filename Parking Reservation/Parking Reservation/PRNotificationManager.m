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

- (void)scheduleNotifications:(NSDate *)date
{
    NSDate *tempDate = [NSDate dateWithTimeIntervalSinceNow:10];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSTimeZoneCalendarUnit) fromDate:tempDate];
    NSDateComponents *newComponents = [components copy];
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:NO];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Testing";
    content.body = @"This better work.";
    content.sound = [UNNotificationSound defaultSound];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"testingNotification" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Notification did not work.");
        }
    }];
}

@end
