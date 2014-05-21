//
//  ProfileViewController.m
//  StoryBoardExample
//
//  Created by Rafał Wójcik on 30.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileEditViewController.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.profileImageView.image = self.profileImage;
    self.usernameLabel.text = self.username;
    self.profileImageView.layer.borderWidth = 1.0f;
    
    self.title = @"User profile";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(showEditPrfileViewController)];
}

- (void)showEditPrfileViewController {
    
    ProfileEditViewController *detailViewController = [[ProfileEditViewController alloc] initWithNibName:@"EditUserProfile" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)setUsername:(NSString *)username {
    _username = username;
    self.usernameLabel.text = username;
}

- (void)setProfileImage:(UIImage *)profileImage {
    _profileImage = profileImage;
    self.profileImageView.image = profileImage;
}

@end
