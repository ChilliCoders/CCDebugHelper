//
//  MyDebugHelper.m
//  StoryBoardExample
//
//  Created by Rafał Wójcik on 30.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "MyDebugHelper.h"
#import "ProfileViewController.h"
#import "ProfileEditViewController.h"

@implementation MyDebugHelper

- (NSArray *)viewControllersConfigs {
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    // you can extract controller config to another method
    [viewControllers addObject:[self configForProfileViewController]];
    
    // or you can write it inline
    CCViewControllerConfig *config = [CCViewControllerConfig configWithName:@"Profile Edit"
                                                              forController:[ProfileViewController class]
                                                       storyboardIdentifier:@"ProfileEditViewController"
                                                                 storyboard:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
    [config setShouldWrapControllerWithNavigationController:YES];
    [viewControllers addObject:config];
    
    return [viewControllers copy];
}

#pragma mark Extracted controllers configs

- (CCViewControllerConfig *)configForProfileViewController {
    
    CCViewControllerConfig *config = [CCViewControllerConfig configWithName:@"Profile" forController:[ProfileViewController class] storyboardIdentifier:@"ProfileViewController" storyboard:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
    [config setShouldWrapControllerWithNavigationController:YES];
    
    // you can extract before action to another method
    [config addBeforeAction:[self loginAction]];
    
    // its work like prepareForSegue return initialized controller
    // so you can prepare controller to show by populating data
    CCBeforeAction *preapareProfileViewControllerAction = [[CCBeforeAction alloc] initSyncActionWithName:@"Setting username" actionBlock:^(ProfileViewController *controller) {
        controller.username = @"chillicoder";
    }];
    
    [config addBeforeAction:preapareProfileViewControllerAction];
    
    CCBeforeAction *fetchProfileImageAction = [[CCBeforeAction alloc] initAsyncActionWithName:@"Fetching profile image" actionBlock:^(ProfileViewController *controller, CCViewControllerConfigComplete complete) {
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://doraidmohammad.files.wordpress.com/2010/08/spicy-chilli-jam.jpg"]];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // you can set image for view controller
            controller.profileImage = responseObject;
            
            // you need call complete to finish async action
            complete();
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
            
            // even if downloading failed
            complete();
        }];
        [requestOperation start];
    }];
    
    [config addBeforeAction:fetchProfileImageAction];
    
    return config;
}

#pragma mark Extracted before actions

- (CCBeforeAction *)loginAction {
    return [[CCBeforeAction alloc] initAsyncActionWithName:@"Login" actionBlock:^(id controller, CCViewControllerConfigComplete complete) {
       
        // do async stuff for login
        
        // you need call complete callback for Async Actions
        complete();
    }];
}


@end
