//
//  OMChannelGuideViewController.m
//  MobileApp
//
//  Created by Rober on 26/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMChannelGuideViewController.h"
#import "MZFormSheetController.h"
#import "IGTimeoutApplication.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "MobileApp-Swift.h"

@interface OMChannelGuideViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagenflechas;
@property NSMutableArray *Locationsobj;
@property NSArray *fruitImages;
@property NSArray *LOCATIONSOBJ;
@property Locations * LOCALLocations;
@property CLLocationCoordinate2D StartLocation;
@property CZPickerView *pickerWithImage;

@end



@implementation OMChannelGuideViewController

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    CLLocation *currentLocation = location;
    
    CLLocationCoordinate2D coordinate = [currentLocation coordinate];
    self.StartLocation = coordinate;
}

-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    //------
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CurrentLocationIdentifier]; // call this method
    
    if (IPHONE)
    {
        _vBack.hidden = YES;
        
    }
    else
    {
        if (_Logueado)
        {
            _vBack.hidden = NO;
            
        }
        else
        {
            _vBack.hidden = YES;
        }
        
    }
    
    //Habilita el boton back
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    _sView.contentSize = CGSizeMake(self.view.bounds.size.width, 1200);
    _sView1.contentSize = CGSizeMake(self.view.bounds.size.width, 900);
    _svGeneral.delegate = self;
    
    RequestSwiftObjC *requesswift = [RequestSwiftObjC new];
    self.LOCATIONSOBJ = [requesswift GetLOCALTIONS];
    self.Locationsobj = [[NSMutableArray alloc] initWithCapacity:self.LOCATIONSOBJ.count];
    int i=0;
    
    int lneg = self.LOCATIONSOBJ.count;
    
    if (self.LOCATIONSOBJ != nil && self.LOCATIONSOBJ.count >= 1)
    {
        for (Locations *loc in self.LOCATIONSOBJ)
        {
            
            NSArray *LocationSplit = [loc.Coordinate componentsSeparatedByString:@","];
            
            MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
            myAnnotation.coordinate = CLLocationCoordinate2DMake([LocationSplit[0] doubleValue], [LocationSplit[1] doubleValue]);
            myAnnotation.title = [[loc.City stringByAppendingString:@" - "] stringByAppendingString:loc.Address] ;
            myAnnotation.subtitle = loc.Address;
            [_mapView addAnnotation:myAnnotation];
            
            [self.Locationsobj addObject:[[loc.City stringByAppendingString:@" - "] stringByAppendingString:loc.Address]];
            i++;
        }
        
    }
    
    [(IGTimeoutApplication *)[UIApplication sharedApplication] invalidateTimer];
    
    self.navigationController.navigationBar.topItem.title = IGEmptyString;
    self.title = @"Canales de Contacto";
    [self.navigationController.navigationBar setTintColor:OM_COLOR_LIGHT_GREEN];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    self.phoneNational.tag = OM_TAG_FIVE;
    self.phoneNationalText.tag = OM_TAG_FIVE;
    self.phoneOneButtonWhitText.tag = OM_TAG_ONE;
    self.phoneOneButton.tag = OM_TAG_TWO;
    self.phoneTwoButton.tag = OM_TAG_THREE;
    self.phoneTwoButtonWhitText.tag = OM_TAG_FOUR;
    self.emailButtonWhitText.tag = OM_TAG_ONE;
    self.emailButton.tag = OM_TAG_TWO;
    self.emailTwoButtonWhitText.tag = OM_TAG_THREE;
    self.emailTwoButton.tag = OM_TAG_FOUR;
    
    self.mapView.delegate = self;
    
    
    
    //View Area
    /*MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
     region.center.latitude = 4.69595;
     region.center.longitude = -74.050004;
     region.span.longitudeDelta = 0.010f;
     region.span.longitudeDelta = 0.010f;
     [_mapView setRegion:region animated:YES];
     //objectos ejemplo pickerview*/
    
    
    
    
    /*MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
     myAnnotation.coordinate = CLLocationCoordinate2DMake(4.69595, -74.050004);
     myAnnotation.title = @"Old Mutual";
     myAnnotation.subtitle = @"Bogota: Avenida 19 No. 109A - 30";
     [_mapView addAnnotation:myAnnotation];*/
    
    
    
    
    /*GetUtilObjects *getutulobject = [GetUtilObjects new];
     
     [getutulobject GetRoteDirectionsWithLocationStart:location LocationEnd:location];*/
    
    
    [_btOficinas.layer setBorderWidth:1.0];
    [_btOficinas.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [_btOficinas.layer setCornerRadius:1.0];
    
    
    
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    //initialize your map view and add it to your view hierarchy - **set its delegate to self***
    
    RequestSwiftObjC * request = [RequestSwiftObjC alloc];
    NSString * snumero = [request GetNumeroDeCedula];
    
    if (IPHONE)
    {
        _vAgente.hidden = YES;
    }
    
    
    if ([snumero  isEqual: @""])
    {
        if (IPHONE)
        {
            self.vAgentes.hidden = YES;
            self.lyBotton.constant = 0;
            _vAgente.hidden = YES;
            _lyHeigthContainerAgentes.constant = 0;
            _lyTopspacingAgente.constant = 0;
        }
        else
        {
            self.vAgentes.hidden = YES;
            self.lyBotton.constant = 0;
            _vAgente.hidden = YES;
            _lyHeigthContainerAgentes.constant = 0;
            _lyTopspacingAgente.constant = -400;
        }
        
    }
    else
    {
        self.vAgentes.hidden = NO;
        self.lyBotton.constant = 0;
        _vAgente.hidden = NO;
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DrawPolyline:)
                                                 name:@"DrawRute"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ShowAgentes:)
                                                 name:@"NMostarAgente"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ChangeHeigthView:)
                                                 name:@"NChangeHeigthView1"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SendEmailFunc:)
                                                 name:@"NSendEmail"
                                               object:nil];
    
    
    ShowControllsController *showcon = [ShowControllsController alloc];
    [showcon SetGuiaDeCanalesControllerWithView:self];
}
-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    
    
    NSLog(@"%@",error.userInfo);
    
    NSLog(@"Location Services Enabled");
    
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
        UIAlertView    *alert = [[UIAlertView alloc] initWithTitle:@"Apreciado Cliente"
                                                           message:@"Verificar su conexión de ubicación."
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        if(_isAlertOpen == NO){
            [alert show];
            _isAlertOpen = YES;}
        
    }
}



- (void)ChangeHeigthView:(NSNotification *) notification
{
    
    RequestSwiftObjC * request = [RequestSwiftObjC alloc];
    NSString * snumero = [request GetNumeroDeCedula];
    
    
    AgentesContainerTableController * agetes = [AgentesContainerTableController alloc];
    
    NSInteger maxAge = agetes.GetMaxAgentes;
    if (![snumero  isEqual: @""])
    {
        _lyHeigthContainerAgentes.constant = maxAge;
    }
    
}

- (void) SendEmailFunc:(NSNotification *) notification
{
    NSString *emailAddress;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    switch (1) {
        case 101 ... 102:
            emailAddress = @"cliente@oldmutual.com.co";
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Canales de Contacto" action:@"Touch" label:@"Email persona natural" value:0] build]];
            break;
        default:
            emailAddress = @"servicioempresa@oldmutual.com.co";
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Canales de Contacto" action:@"Touch" label:@"Email servicio empresarial" value:0] build]];
            break;
    }
    
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    if (controller == nil) {
        return;
    }
    controller.mailComposeDelegate = self;
    
    [controller setToRecipients:[NSArray arrayWithObject:emailAddress]];
    
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)triBack:(UIButton *)sender
{
    [self dismissModalViewControllerAnimated:true];
}

- (void)ShowAgentes:(NSNotification*)notification {
    
    _vAgente.hidden = NO;
    _lyHeigthVAgentes.constant = 400;
    _lyTopspacingAgente.constant = -72;
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //[super scrollViewWillBeginDragging:scrollView];   // pull to refresh
    
    _imagenflechas.hidden = YES;
    
}

- (void) viewDidAppear:(BOOL)animated
{
    if (self.LOCATIONSOBJ != nil && self.LOCATIONSOBJ.count >= 1)
    {
        NSString *data = @"";
        [self.btOficinas setTitle:[data stringByAppendingString:self.Locationsobj[0]] forState:UIControlStateNormal];
        
        Locations *loc = self.LOCATIONSOBJ[0];
        
        //_lbNombreOficina.text = loc.Name;
        [_lbDireccionOficina setTitle:[data stringByAppendingString:loc.Address] forState:UIControlStateNormal];
        
        _lbHorariosOficina.text = loc.Schedule;
        MKCoordinateRegion region;
        MKCoordinateSpan oficinaCordinate;
        oficinaCordinate.latitudeDelta = 0.010f;
        oficinaCordinate.longitudeDelta = 0.010f;
        CLLocationCoordinate2D location;
        NSArray *LocationSplit = [loc.Coordinate componentsSeparatedByString:@","];
        location.latitude = [LocationSplit[0] doubleValue];
        location.longitude = [LocationSplit[1] doubleValue];
        region.span = oficinaCordinate;
        region.center = location;
        
        
        [self.mapView setRegion:region animated:YES];
        
        
        
        GetUtilObjects *getutulobject = [GetUtilObjects new];
        
        
        [getutulobject GetRoteDirectionsWithLocationStart:self.StartLocation LocationEnd:location];
        
        
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeCallPhone:(id)sender {
    
    NSString *phone;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    switch ([sender tag]) {
            
        case 101 ... 102:
            phone = @"0316584000";
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Canales de Contacto" action:@"Touch" label:@"Llamar persona natural" value:0] build]];
            break;
        case 105:
            phone = @"018000517526";
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Canales de Contacto" action:@"Touch" label:@"Llamar linea nacional" value:0] build]];
            break;
        default:
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Canales de Contacto" action:@"Touch" label:@"Llamar servicio empresarial" value:0] build]];
            phone = @"0316584123";
            break;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"tel:%@", phone]]];
}

- (IBAction)sendEmail:(id)sender {
    
    NSString *emailAddress;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    switch ([sender tag]) {
        case 101 ... 102:
            emailAddress = @"cliente@oldmutual.com.co";
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Canales de Contacto" action:@"Touch" label:@"Email persona natural" value:0] build]];
            break;
        default:
            emailAddress = @"servicioempresa@oldmutual.com.co";
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Canales de Contacto" action:@"Touch" label:@"Email servicio empresarial" value:0] build]];
            break;
    }
    
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    if (controller == nil) {
        return;
    }
    controller.mailComposeDelegate = self;
    
    [controller setToRecipients:[NSArray arrayWithObject:emailAddress]];
    
    
    [self presentViewController:controller animated:YES completion:nil];
}



- (IBAction)locationMap:(id)sender {
    
    float spanX = 0.005f;
    float spanY = 0.005f;
    MKCoordinateRegion region;
    region.center.latitude = 4.69595;
    region.center.longitude = -74.050004;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
    //  [self.mapView setCenter:_mapView.userLocation.coordinate animated:YES];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{
    if (result == MFMailComposeResultSent) {
        [self showAlert:OM_ALERT_TITLE_SEND_EMAIL message:OM_ALERT_MESSAGE_SEND_EMAIL];
    }
    else if (result == MFMailComposeResultFailed) {
        [self showAlert:OM_DEAR_CLIENT message:[NSString stringWithFormat:OM_ALERT_MESSAGE_SEND_EMAIL_ERROR, [error description]]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) showAlert:(NSString *)title
          message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:OM_TXT_ACCEPT
                                          otherButtonTitles:nil];
    [alert show];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"icon_location_google.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
            
            // Add an image to the left callout.
            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location.png"]];
            pinView.leftCalloutAccessoryView = iconView;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

- (NSAttributedString *)czpickerView:(CZPickerView *)pickerView
               attributedTitleForRow:(NSInteger)row{
    
    NSAttributedString *att = [[NSAttributedString alloc]
                               initWithString:self.Locationsobj[row]
                               attributes:@{
                                            NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0]
                                            }];
    return att;
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    return self.Locationsobj[row];
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return self.Locationsobj.count;
}
- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    NSLog(@"%@ is chosen!", self.Locationsobj[row]);
    
    
    NSString *data = @"";
    [self.btOficinas setTitle:[data stringByAppendingString:self.Locationsobj[row]] forState:UIControlStateNormal];
    
    Locations *loc = self.LOCATIONSOBJ[row];
    _LOCALLocations = self.LOCATIONSOBJ[row];
    
    //_lbNombreOficina.text = loc.Name;
    [_lbDireccionOficina setTitle:[data stringByAppendingString:loc.Address] forState:UIControlStateNormal];
    
    _lbHorariosOficina.text = loc.Schedule;
    MKCoordinateRegion region;
    MKCoordinateSpan oficinaCordinate;
    oficinaCordinate.latitudeDelta = 0.010f;
    oficinaCordinate.longitudeDelta = 0.010f;
    CLLocationCoordinate2D location;
    NSArray *LocationSplit = [loc.Coordinate componentsSeparatedByString:@","];
    location.latitude = [LocationSplit[0] doubleValue];
    location.longitude = [LocationSplit[1] doubleValue];
    region.span = oficinaCordinate;
    region.center = location;
    
    GetUtilObjects *getutulobject = [GetUtilObjects new];
    
    CLLocationCoordinate2D startLocation;
    startLocation.latitude = 4.69595;
    startLocation.longitude = -74.050004;
    
    [getutulobject GetRoteDirectionsWithLocationStart:self.StartLocation LocationEnd:location];
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)triVerOficinasOldmutual:(UIButton *)sender {
    
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Oficinas" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.headerTitleFont = [UIFont systemFontOfSize: 40];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = NO;
    [picker show];
}

- (IBAction)closePopup:(id)sender {
    
    [(IGTimeoutApplication *)[UIApplication sharedApplication] resetIdleTimer];
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
    }];
    
}

- (IBAction)triNavegar:(UIButton *)sender
{
    
    //Waze is installed. Launch Waze and start navigation
    NSArray *LocationSplit = [_LOCALLocations.Coordinate componentsSeparatedByString:@","];
    
    NSString *urlStr = [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes", [LocationSplit[0] doubleValue], [LocationSplit[1] doubleValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"waze://"]]) {
        
        
    } else {
        //Waze is not installed. Launcimplementationimplementationh AppStore to install Waze app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/id323229106"]];
    }
}

#pragma mark - CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    CLLocationCoordinate2D coordinate = [currentLocation coordinate];
    self.StartLocation = coordinate;
    
    
    
}

- (void)DrawPolyline:(NSNotification*)notification {
    
    NSString *encodedString = @"";
    
    NSDictionary* userInfo = notification.userInfo;
    encodedString = (NSString*)userInfo[@"SDEcode"];
    //NSLog (@"Successfully received test notification! %i", total.intValue);
    
    self.routeLine = [self polylineWithEncodedString: encodedString];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView addOverlay:self.routeLine];
    
    
}

- (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString {
    const char *bytes = [encodedString UTF8String];
    NSUInteger length = [encodedString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;
    
    NSUInteger count = length / 4;
    CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    NSUInteger coordIdx = 0;
    
    float latitude = 0;
    float longitude = 0;
    while (idx < length) {
        char byte = 0;
        int res = 0;
        char shift = 0;
        
        do {
            byte = bytes[idx++] - 63;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
        latitude += deltaLat;
        
        shift = 0;
        res = 0;
        
        do {
            byte = bytes[idx++] - 0x3F;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
        longitude += deltaLon;
        
        float finalLat = latitude * 1E-5;
        float finalLon = longitude * 1E-5;
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
        coords[coordIdx++] = coord;
        
        if (coordIdx == count) {
            NSUInteger newCount = count + 10;
            coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
            count = newCount;
        }
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coords count:coordIdx];
    free(coords);
    
    return polyline;
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
    self.routeLineView.fillColor = [UIColor redColor];
    self.routeLineView.strokeColor = [UIColor redColor];
    self.routeLineView.lineWidth = 5;
    
    
    return self.routeLineView;
    
}

- (IBAction)triShowFacebook:(UIButton *)sender {
    //   [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/252640334936797"]];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/OldMutualColombia/"]];
    
    if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/252640334936797"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/OldMutualColombia/"]];
    }
    
    
}
- (IBAction)triShowTwitter:(UIButton *)sender {
    //   [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/OldMutualCol"]];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"twitter://user?screen_name=OldMutualCol"]];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/OldMutualCol"]];
    }
    
    
}
- (IBAction)triShowYoutube:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.youtube.com/oldmutualcol"]];
    
}
- (IBAction)triShowInstagram:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.instagram.com/oldmutualcol/"]];
    
}
- (IBAction)triShowLinkein:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.linkedin.com/company/24994094/"]];
    
}
- (IBAction)trisecondnumber:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:0314841300"]];
}
- (IBAction)triphonenational:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:018000517526"]];
}


@end
