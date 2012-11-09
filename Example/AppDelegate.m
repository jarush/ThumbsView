//
//  AppDelegate.m
//  Example
//
//  Created by Jason Rush on 11/9/12.
//  Copyright (c) 2012 Fizzawizza. All rights reserved.
//

#import "AppDelegate.h"
#import "ExampleViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController = [[[ExampleViewController alloc] init] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
