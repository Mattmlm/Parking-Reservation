//
//  PRParkingLocationPreviewView.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "PRParkingLocationPreviewView.h"
#import "PRNetworking.h"

@interface PRParkingLocationPreviewView()

@property (nonatomic) UILabel *parkingSpotNameTitleLabel;
@property (nonatomic) UILabel *parkingSpotNameLabel;
@property (nonatomic) UILabel *parkingSpotNumberTitleLabel;
@property (nonatomic) UILabel *parkingSpotNumberLabel;
@property (nonatomic) UILabel *parkingSpotCostTitleLabel;
@property (nonatomic) UILabel *parkingSpotCostLabel;
@property (nonatomic) UIButton *reserveButton;

@property (nonatomic, copy) ParkingLocationModel *parkingLocation;

@end

@implementation PRParkingLocationPreviewView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.parkingSpotNumberTitleLabel];
        [self addSubview:self.parkingSpotNumberLabel];
        [self addSubview:self.parkingSpotNameTitleLabel];
        [self addSubview:self.parkingSpotNameLabel];
        [self addSubview:self.parkingSpotCostTitleLabel];
        [self addSubview:self.parkingSpotCostLabel];
        [self addSubview:self.reserveButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
    
    [self.parkingSpotNumberTitleLabel sizeToFit];
    CGRect numberTitleLabelFrame = self.parkingSpotNumberTitleLabel.frame;
    numberTitleLabelFrame.origin.x = 15;
    numberTitleLabelFrame.origin.y = 15;
    self.parkingSpotNumberTitleLabel.frame = numberTitleLabelFrame;
    
    CGAffineTransform rightOfTitleLabelTransform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.parkingSpotNumberTitleLabel.frame), 0);
    self.parkingSpotNumberLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNumberTitleLabel.frame, rightOfTitleLabelTransform);
    
    CGAffineTransform bottomOfNumberLabelTransform = CGAffineTransformMakeTranslation(0, self.parkingSpotNumberTitleLabel.frame.size.height + 10);
    self.parkingSpotNameTitleLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNumberTitleLabel.frame, bottomOfNumberLabelTransform);
    [self.parkingSpotNameTitleLabel sizeToFit];
    
    rightOfTitleLabelTransform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.parkingSpotNameTitleLabel.frame), 0);
    self.parkingSpotNameLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNameTitleLabel.frame, rightOfTitleLabelTransform);
    
    CGAffineTransform bottomOfNameLabelTransform = CGAffineTransformMakeTranslation(0, self.parkingSpotNameTitleLabel.frame.size.height + 10);
    self.parkingSpotCostTitleLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNameTitleLabel.frame, bottomOfNameLabelTransform);
    [self.parkingSpotCostTitleLabel sizeToFit];
    
    rightOfTitleLabelTransform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.parkingSpotCostTitleLabel.frame), 0);
    self.parkingSpotCostLabel.frame = CGRectApplyAffineTransform(self.parkingSpotCostTitleLabel.frame, rightOfTitleLabelTransform);
    
    self.reserveButton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 15 - self.reserveButton.bounds.size.height / 2);
}

- (void)updateSearchViewWith:(ParkingLocationModel *)parkingLocation
{
    self.parkingLocation = [parkingLocation copy];
    self.parkingSpotNameLabel.text = parkingLocation.name;
    self.parkingSpotNumberLabel.text = [NSString stringWithFormat:@"%d", parkingLocation.parkingLocationID];
    self.parkingSpotCostLabel.text = [NSString stringWithFormat:@"%@/min", parkingLocation.costPerMin];
    [self.reserveButton setBackgroundColor:[UIColor blueColor]];
    [self.reserveButton setEnabled:YES];
}

- (void)reserveSpot:(id)sender
{
    BFTask *reserveTask = [[PRNetworking sharedInstance] reserve:self.parkingLocation.parkingLocationID withOptions:nil];
    
    [reserveTask continueWithBlock:^id _Nullable(BFTask * _Nonnull t) {
        NSLog(@"%@", t.result);
        NSLog(@"%@", t.error);
        
        NSError *mantleError;
        ParkingLocationModel *parkingLocation = [MTLJSONAdapter modelOfClass:ParkingLocationModel.class fromJSONDictionary:t.result error:&mantleError];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate parkingLocationPreviewView:self didReserveSpot:parkingLocation];
        });
        
        return nil;
    }];
}

#pragma mark - Lazy initializers

- (UILabel *)parkingSpotNameTitleLabel
{
    return !_parkingSpotNameTitleLabel ? _parkingSpotNameTitleLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"Spot Name:";
        label;
    }) : _parkingSpotNameTitleLabel;
}

- (UILabel *)parkingSpotNameLabel
{
    return !_parkingSpotNameLabel ? _parkingSpotNameLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"N/A";
        label;
    }) : _parkingSpotNameLabel;
}

- (UILabel *)parkingSpotNumberTitleLabel
{
    return !_parkingSpotNumberTitleLabel ? _parkingSpotNumberTitleLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"Spot #:";
        label;
    }) : _parkingSpotNumberTitleLabel;
}

- (UILabel *)parkingSpotNumberLabel
{
    return !_parkingSpotNumberLabel ? _parkingSpotNumberLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"--";
        label;
    }) : _parkingSpotNumberLabel;
}

- (UILabel *)parkingSpotCostTitleLabel
{
    return !_parkingSpotCostTitleLabel ? _parkingSpotCostTitleLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"Cost per min:";
        label;
    }) : _parkingSpotCostTitleLabel;
}

- (UILabel *)parkingSpotCostLabel
{
    return !_parkingSpotCostLabel ? _parkingSpotCostLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"--/min";
        label;
    }) : _parkingSpotCostLabel;
}

- (UIButton *)reserveButton
{
    return !_reserveButton ? _reserveButton =
    ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Reserve Spot" forState:UIControlStateNormal];
        [button setContentEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 15)];
        [button sizeToFit];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        [button addTarget:self action:@selector(reserveSpot:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 5;
        button.enabled = NO;
        button;
    }) : _reserveButton;
}

@end
