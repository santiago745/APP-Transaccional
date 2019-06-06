//
//  AppDelegate.m
//  MobileApp
//
//  Created by Armando Restrepo on 2/23/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "AppDelegate.h"
#import "TestFairy.h"
#import "Flurry.h"
#import "TAGContainer.h"
#import "TAGContainerOpener.h"
#import "TAGManager.h"


// Dispatch interval for automatic dispatching of hits to Google Analytics.
// Values 0.0 or less will disable periodic dispatching. The default dispatch interval is 120 secs.
static NSTimeInterval const kMiEquipoDispatchInterval = 120;

// Set log level to have the Google Analytics SDK report debug information only in DEBUG mode.
#if DEBUG
static GAILogLevel const kMiEquipoLogLevel = kGAILogLevelVerbose;
#else
static GAILogLevel const kMiEquipoLogLevel = kGAILogLevelWarning;
#endif

@interface AppDelegate ()<TAGContainerOpenerNotifier>

// Used for sending Google Analytics traffic in the background.
@property(nonatomic, assign) BOOL okToWait;
@property(nonatomic, copy) void (^dispatchHandler)(GAIDispatchResult result);

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TestFairy begin:@"fcb491e5c02446424286521708018a52ccc05410"];
    [FIRApp configure];
    //Flurry initialization.
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:FLURRY_APP_ID];
    
     [self initializeGoogleAnalytics];
    
    
    self.tagManager = [TAGManager instance];
    
    // Optional: Change the LogLevel to Verbose to enable logging at VERBOSE and higher levels.
    [self.tagManager.logger setLogLevel:kTAGLoggerLogLevelVerbose];
    
    /*
     * Opens a container.
     *
     * @param containerId The ID of the container to load.
     * @param tagManager The TAGManager instance for getting the container.
     * @param openType The choice of how to open the container.
     * @param timeout The timeout period (default is 2.0 seconds).
     * @param notifier The notifier to inform on container load events.
     */
    [TAGContainerOpener openContainerWithId:@"GTM-58TLS72"   // Update with your Container ID.
                                 tagManager:self.tagManager
                                   openType:kTAGOpenTypePreferFresh
                                    timeout:nil
                                   notifier:self];
    
    // Method calls that don't need the container.
    
    return YES;
}

// TAGContainerOpenerNotifier callback.
- (void)containerAvailable:(TAGContainer *)container {
    // Note that containerAvailable may be called on any thread, so you may need to dispatch back to
    // your main thread.
    dispatch_async(dispatch_get_main_queue(), ^{
        self.container = container;
    });
}

- (void)initializeGoogleAnalytics {
    
    //Google Analitycs config
    NSDictionary *appDefaults = @{kAllowTracking: @(YES)};
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    
    // User must be able to opt out of tracking
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
    
    // Automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Set the dispatch interval for automatic dispatching.
    [GAI sharedInstance].dispatchInterval = kMiEquipoDispatchInterval;
    
    // Set the appropriate log level for the default logger.
    [GAI sharedInstance].logger.logLevel = kMiEquipoLogLevel;
    
    // Initialize a tracker using a Google Analytics property ID.
    [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
