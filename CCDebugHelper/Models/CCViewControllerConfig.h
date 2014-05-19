//
//  CCViewControllerConfig.h
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 30.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBeforeAction.h"

@protocol CCViewControllerConfigDelegate <NSObject>

@optional
- (void)performingActionWithName:(NSString *)name;

@end


typedef void (^CCViewControllerConfigInitializeComplete)(id controller);

@interface CCViewControllerConfig : NSObject

@property (assign) BOOL shouldWrapControllerWithNavigationController;
@property (nonatomic, assign) Class navigationControllerClassName;
@property (nonatomic, weak) id <CCViewControllerConfigDelegate> delegate;


- (void)initializeControllerWithCompletion:(CCViewControllerConfigInitializeComplete)complete;

#pragma mark XIB inits

+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass;
+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass
                       xibName:(NSString *)xibName;


#pragma mark Storyboard inits

+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass
          storyboardIdentifier:(NSString *)storyboardIdentifier
                    storyboard:(UIStoryboard *)storyboard;

#pragma mark before action methods

- (void)addBeforeAction:(CCBeforeAction *)action;

#pragma mark helper functions

- (void)validateConfiguration;

- (NSString *)title;
- (NSString *)subtitle;
- (BOOL)hasBeforeActions;

@end
