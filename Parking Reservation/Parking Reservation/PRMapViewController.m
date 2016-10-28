//
//  ViewController.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/26/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "PRMapViewController.h"
#import "PRNetworking.h"
#import "ParkingLocationModel.h"
#import "ParkingLocationAnnotation.h"

@interface PRMapViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSArray <ParkingLocationModel*>* data;

@end

@implementation PRMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set to SF
    CLLocationCoordinate2D centerCoords = CLLocationCoordinate2DMake(37.787359, -122.408227);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoords, 500, 500);
    self.mapView.region = region;
    self.mapView.delegate = self;
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    BFTask *task = [[PRNetworking sharedInstance] search:@{
                                            @"lat"  : @(centerCoords.latitude),
                                            @"lng"  : @(centerCoords.longitude),
                                            }];
    [task continueWithBlock:^id _Nullable(BFTask * _Nonnull t) {
        NSLog(@"%@", t.result);
        for (id item in t.result) {
            if ([item isKindOfClass:ParkingLocationModel.class]) {
                ParkingLocationModel *parkingLocation = (ParkingLocationModel*)item;
                ParkingLocationAnnotation *annotation = [[ParkingLocationAnnotation alloc] initWithParkingLocation:parkingLocation];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mapView addAnnotation:annotation];
                });
            }
        }
        return nil;
    }];
}

- (MKMapView *)mapView
{
    return !_mapView ? _mapView = ({
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:mapView];
        mapView;
    }) : _mapView;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation) {
        return nil;
    } else {
        NSString *pinReuseIdentifier = @"pinAnnotation";
        
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)
        [self.mapView dequeueReusableAnnotationViewWithIdentifier:pinReuseIdentifier];
        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinReuseIdentifier];
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
}


@end
