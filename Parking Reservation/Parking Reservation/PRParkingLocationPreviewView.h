//
//  PRParkingLocationPreviewView.h
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingLocationModel.h"

@interface PRParkingLocationPreviewView : UIView

@property (readonly, nonatomic) ParkingLocationModel *parkingLocation;

- (void)updateSearchViewWith:(ParkingLocationModel *)parkingLocation;

@end
