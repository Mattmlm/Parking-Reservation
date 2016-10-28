//
//  PRParkingLocationPreviewView.h
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingLocationModel.h"

@class PRParkingLocationPreviewView;

@protocol PRParkingLocationPreviewViewDelegate <NSObject>

- (void)parkingLocationPreviewView:(PRParkingLocationPreviewView *)previewView didReserveSpot:(ParkingLocationModel *)parkingLocation;

@end

@interface PRParkingLocationPreviewView : UIView

@property (readonly, nonatomic) ParkingLocationModel *parkingLocation;
@property (nonatomic, weak) id<PRParkingLocationPreviewViewDelegate> delegate;

- (void)updateSearchViewWith:(ParkingLocationModel *)parkingLocation;

@end
