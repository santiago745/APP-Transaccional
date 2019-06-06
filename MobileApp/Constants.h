//
//  Constants.h
//  OldMutual
//
//  Created by Armando Restrepo on 11/20/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#ifndef salesforce_Constants_h
#define salesforce_Constants_h

#pragma mark - Global config

#define USE_TEST_REPOS NO
#define FLURRY_APP_ID @"HPX8WSVKNQXP6XBVVF49"
#define CUSTOM_DATE_FORMAT @"dd-MM-yyyy"
#define GOOGLE_URL @"https://www.google.com"

//Google Analytics
static NSString *const kAllowTracking = @"allowTracking";

//Development
//Google analitycs tracking code and allow device tracking property
//static NSString *const kTrackingId = @"UA-65894496-1";

//Production
//Google analitycs tracking code and allow device tracking property
static NSString *const kTrackingId =  @"UA-53882459-6";
// comunicacion objectos swift


//Devices
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

//Fonts
#define OM_FONT_MONSERRAT_BOLD [UIFont fontWithName:@"Montserrat-Bold" size:18]
#define OM_FONT_HELVETICANEUE_MEDIUM [UIFont fontWithName:@"HelveticaNeue" size:12]
#define OM_FONT_HELVETICANEUE_BIG [UIFont fontWithName:@"HelveticaNeue" size:14]
#define OM_FONT_HELVETICANEUE_BIGGEST [UIFont fontWithName:@"HelveticaNeue" size:16]
#define OM_FONT_HELVETICANEUE_BIGGEST_IPAD [UIFont fontWithName:@"HelveticaNeue" size:18]
#define OM_FONT_HELVETICANEUE_BOLD_MEDIUM [UIFont fontWithName:@"HelveticaNeue-Bold" size:12]
#define OM_FONT_HELVETICANEUE_BOLD_BIG [UIFont fontWithName:@"HelveticaNeue-Bold" size:14]
#define OM_FONT_ARIAL_BIG [UIFont fontWithName:@"arial" size:14]
#define OM_FONT_ARIAL_BIGGEST [UIFont fontWithName:@"arial" size:18]

//Colors
#define OM_COLOR_GRAY [UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0]
#define OM_COLOR_DARK_GREEN [UIColor colorWithRed:0.0/255.0 green:200.0/255.0 blue:60.0/255.0 alpha:1.0]
#define OM_COLOR_NEW_GREEN [UIColor colorWithRed:0.0/255.0 green:200.0/255.0 blue:60.0/255.0 alpha:1.0]
#define OM_COLOR_LIGHT_GREEN [UIColor colorWithRed:66.0/255.00 green:173.0/255.0 blue:0.0/255.0 alpha:1.0]
#define OM_COLOR_CELL_SELECTION_GREEN [UIColor colorWithRed:0.0/255.0 green:200.0/255.0 blue:60.0/255.0 alpha:1.0]
#define IG_NAV_BAR_BORDER_COLOR [UIColor colorWithRed:0.0/255.00 green:97.0/255.0 blue:78.0/255.0 alpha:1.0]

//NSIntegers
//Pagination in transactions historical
#define FIRST_PAGE_INDEX 0
#define PAGE_RESULTS_SIZE 20
#define VIEW_WIDTH 600
#define VIEW_HEIGTH 600
#define VIEW_WIDTH_TABLET 1024
#define VIEW_HEIGTH_TABLET 768
// CGFloats
#define OM_CELL_HEIGHT_BIG 70.0f

//Tags
#define OM_TAG_ONE 101
#define OM_TAG_TWO 102
#define OM_TAG_THREE 103
#define OM_TAG_FOUR 104
#define OM_TAG_FIVE 105

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//Left menu

#define IG_LEFT_MENU_CELL_SELECTED_COLOR [UIColor colorWithRed:150.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0]
#define IG_LEFT_MENU_CELL_BACKGROUND_COLOR [UIColor colorWithRed:0.0/255.0 green:200.0/255.0 blue:60.0/255.0 alpha:1.0]
#define IG_LEFT_MENU_CELL_HIGHLIGHTEDTEXT_COLOR [UIColor colorWithRed:0.0/255.0 green:200.0/255.0 blue:60.0/255.0 alpha:1.0]
#define IG_LEFT_MENU_CELL_SEPARATOR_COLOR [UIColor colorWithRed:73.0/255.00 green:73.0/255.0 blue:73.0/255.0 alpha:1.0]
#define IG_LEFT_MENU_TEXT_COLOR [UIColor colorWithRed:194.0/255.00 green:194.0/255.0 blue:194.0/255.0 alpha:1.0]
#define IG_LEFT_MENU_TEXT_SELECTED_COLOR [UIColor whiteColor]
#define IG_LEFT_MENU_TEXT_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
#define IG_LEFT_MENU_TEXT_FONT_SELECTED [UIFont fontWithName:@"HelveticaNeue-Medium" size:10  ];
#define IG_NAV_BAR_COLOR [UIColor colorWithRed:0.0/255.00 green:22.0/255.0 blue:91.0/255.0 alpha:0.8]

//Validation Regex
#define IG_REGISTER_QUESTION_VALIDATION @"(?=^.{4,}$)^[a-zA-Z0-9]+$"
#define IG_CHANGE_PASS_SECURITY_VALIDATION @"(?=^.{8,15}$)(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+}{\":;?>.<,])(?!.*\\s).*$"
#define IG_CHANGE_PASS_CONSECUTIVE_CHARS_VALIDATION @"(.)\1{1,}"
#define IG_FORGOTPASS_EMAIL_VALIDATION @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

//Blocks
typedef void (^IGNetworkAvailabilityBlock)(BOOL isAvailable);
typedef void (^IGInvalidCredentialsBlock)(NSError *error);

//Pending action types
typedef enum {
    ChangePassword = 1,
    TermsAndConditions = 2,
    SecurityQuestions = 3,
    RegisterDevice = 4
}enumPendingActionType;

#endif
