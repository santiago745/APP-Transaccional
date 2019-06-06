//
//  OMChannelGuideViewController.h
//  MobileApp
//
//  Created by Rober on 26/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import "CZPicker.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface OMChannelGuideViewController : UIViewController<MFMailComposeViewControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UIScrollViewDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
}

- (IBAction)closePopup:(id)sender;
@property (nonatomic) BOOL *Logueado;
@property (nonatomic) BOOL isAlertOpen;

@property (weak, nonatomic) IBOutlet UIButton *phoneNationalText;

@property (weak, nonatomic) IBOutlet UIButton *phoneNational;
@property (strong, nonatomic) IBOutlet UIButton *phoneOneButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneOneButtonWhitText;
@property (strong, nonatomic) IBOutlet UIButton *phoneTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneTwoButtonWhitText;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButtonWhitText;
@property (strong, nonatomic) IBOutlet UIButton *emailTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *emailTwoButtonWhitText;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btOficinas;
@property (weak, nonatomic) IBOutlet UILabel *lbNombreOficina;
@property (weak, nonatomic) IBOutlet UIButton *lbDireccionOficina;
@property (weak, nonatomic) IBOutlet UILabel *lbHorariosOficina;

@property (weak, nonatomic) IBOutlet UIView *vAgentes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyBotton;

@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay vie
@property (weak, nonatomic) IBOutlet UIScrollView *svGeneral;


- (IBAction)triNavegar:(UIButton*)sender;

- (IBAction)makeCallPhone:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)locationMap:(id)sender;
- (IBAction)triVerOficinasOldmutual:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *vBack;

@property (weak, nonatomic) IBOutlet UIButton *btBack;

- (IBAction)triBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *sView;
@property (weak, nonatomic) IBOutlet UIScrollView *sView1;
@property (weak, nonatomic) IBOutlet UIView *vAgente;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyHeigthVAgentes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyTopspacingAgente;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyHeigthContainerAgentes;

@end
