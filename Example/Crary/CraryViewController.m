#import "CraryViewController.h"
#import "CraryMessageBox.h"

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

- (IBAction)onShowAlert:(id)sender
{
    [CraryMessageBox alert:@"message"];
}

@end
