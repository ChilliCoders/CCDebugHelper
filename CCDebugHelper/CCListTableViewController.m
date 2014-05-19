//
//  ListTableViewController.m
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 30.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "CCListTableViewController.h"
#import "CCDebugHelper.h"
#import "CCDebugHelperCell.h"

@interface CCListTableViewController ()

@end

@implementation CCListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Debug Controllers List";
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.configsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.configsList.count) {
        return 277.0f;
    }
    return 51.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 277.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:CCDebugHelperBundle ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSArray *nibs = [bundle loadNibNamed:@"CCDebugHelperCells" owner:self options:nil];
    
    UITableViewCell *cell = [nibs objectAtIndex:1];
    
    UITapGestureRecognizer *tapCredits = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToCreditsSite)];
    [cell addGestureRecognizer:tapCredits];
    
    return cell;
}

- (void)goToCreditsSite {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://chillicoders.com"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCDebugHelperCell *cell = (CCDebugHelperCell *)[tableView dequeueReusableCellWithIdentifier:CCDebugHelperCellIdentifier];
    if (cell == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:CCDebugHelperBundle ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSArray *nibs = [bundle loadNibNamed:@"CCDebugHelperCells" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    
    CCViewControllerConfig *config = self.configsList[indexPath.row];
    cell.title = config.title;
    cell.subtitle = config.subtitle;
    cell.type = CCDebugHelperCellTypeStoryBoard;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self presentViewController:[self.helper loadingControllerWithConfigAtIndex:indexPath.row] animated:YES completion:nil];
}

@end
