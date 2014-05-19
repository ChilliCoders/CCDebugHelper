//
//  CCLoadingViewController.m
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 06.05.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "CCLoadingViewController.h"

@interface CCLoadingViewController () <CCViewControllerConfigDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *actionNameLabel;


@end

@implementation CCLoadingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)configView {
    if (self.config) {
        self.config.delegate = self;
        self.nameLabel.text = [self.config title];
        self.actionNameLabel.text = @"";
        [self.activityIndicator startAnimating];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.config) {
        [self.config initializeControllerWithCompletion:^(id controller) {
            [controller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:controller animated:YES completion:nil];
        }];
    }
}

- (void)performingActionWithName:(NSString *)name {
    self.actionNameLabel.text = name;
}

@end
