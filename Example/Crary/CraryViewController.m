//
//  CraryViewController.m
//  Crary
//
//  Created by yamigo on 08/06/2014.
//  Copyright (c) 2014 yamigo. All rights reserved.
//

#import "CraryViewController.h"
#import "UIAlertViewManager.h"

@interface CraryViewController ()

@end

@implementation CraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [UIAlertViewManager showWithTitle:@"title" message:@"message" firstButtonTitle:@"ok" secondButtonTitle:@"cancel" complete:^(NSInteger index) {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
