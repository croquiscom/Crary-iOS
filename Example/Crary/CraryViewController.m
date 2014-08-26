#import "CraryViewController.h"
#import "UIAlertViewManager.h"

@interface CraryViewController ()

@end

@implementation CraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onShowAlertView:(id)sender
{
    [UIAlertViewManager showWithTitle:@"title" message:@"message" firstButtonTitle:@"ok" secondButtonTitle:@"cancel" complete:^(NSInteger index) {
    }];
}

@end
