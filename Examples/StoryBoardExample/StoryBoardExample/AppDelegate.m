//
//  AppDelegate.m
//  StoryBoardExample
//
//  Created by Rafał Wójcik on 29.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "AppDelegate.h"
#import "MyDebugHelper.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MyDebugHelper *viewDebuger = [[MyDebugHelper alloc] initWithWindow:self.window];
    [viewDebuger showControllerWithConfigIndex:0];
    
    [self styleApplicationALittleBit];
    return YES;
}

- (void)styleApplicationALittleBit {
    UIColor *chilliColor = [UIColor colorWithRed:215.0/255.0 green:5.0/255.0 blue:4.0/255.0 alpha:1];
    [[UINavigationBar appearance] setTintColor:chilliColor];
    [[UIButton appearance] setTintColor:chilliColor];
}

@end
