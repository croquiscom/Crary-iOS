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
    [CraryMessageBox alert:@"message" title:@"title" done:^{
        [CraryMessageBox alert:@"done"];
    }];
}

- (IBAction)onShowConfirm:(id)sender
{
    [CraryMessageBox confirm:@"Really?" done:^(BOOL result){
        [CraryMessageBox alert:result ? @"You confirmed" : @"You cancelled"];
    }];
}

@end
