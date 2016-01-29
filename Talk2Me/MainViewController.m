//
//  MainViewController.m
//  Talk2Me
//
//  Created by 刘凯 on 1/29/16.
//  Copyright © 2016 Michael. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBarButton];
    
    self.title = @"Messages";
}

- (void)setupBarButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didTapLeftButton:)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(didTapRightButton:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)didTapLeftButton:(id)sender {
    
}

- (void)didTapRightButton:(id)sender {
    
}

@end
