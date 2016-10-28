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
#import "PRParkingLocationPreviewView.h"

@interface PRMapViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) PRParkingLocationPreviewView *previewView;
@property (nonatomic, strong) NSArray <ParkingLocationModel*>* data;

@end

@implementation PRMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Set to SF
    CLLocationCoordinate2D centerCoords = CLLocationCoordinate2DMake(37.787359, -122.408227);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoords, 350, 350);
    self.mapView.region = region;
    self.mapView.delegate = self;
    
    // Load parking locations
    [self loadPinsForCoordinate:centerCoords];
    
    [self setupSearchView];
}

- (void)setupSearchView
{
    CGRect popupViewRect = CGRectInset(self.view.bounds, 15, (self.view.bounds.size.height/4));
    popupViewRect.origin.y = 15;
    self.previewView = [[PRParkingLocationPreviewView alloc] initWithFrame:popupViewRect];
    [self.view addSubview:self.previewView];
}

- (void)updateSearchViewWith:(ParkingLocationModel *)parkingLocation
{
    [self.previewView updateSearchViewWith:parkingLocation];
}

- (MKMapView *)mapView
{
    return !_mapView ? _mapView = ({
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:mapView];
        mapView;
    }) : _mapView;
}

#pragma mark - Data Handling

- (void)loadPinsForCoordinate:(CLLocationCoordinate2D)coordinate
{
    BFTask *task = [[PRNetworking sharedInstance] search:@{
                                                           @"lat"  : @(coordinate.latitude),
                                                           @"lng"  : @(coordinate.longitude),
                                                           }];
    [task continueWithBlock:^id _Nullable(BFTask * _Nonnull t) {
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

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self loadPinsForCoordinate:mapView.centerCoordinate];
}

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

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:ParkingLocationAnnotation.class]) {
        ParkingLocationAnnotation *annotation = view.annotation;
        [self updateSearchViewWith:annotation.parkingLocation];
    }
}

@end
