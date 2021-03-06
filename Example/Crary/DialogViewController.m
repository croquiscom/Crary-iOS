#import "DialogViewController.h"
#import "CraryMessageBox.h"
#import "CraryInputDialog.h"

@interface DialogViewController ()

@end

@implementation DialogViewController

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
    [CraryMessageBox confirmYesNo:@"Really?" done:^(BOOL yes_selected){
        [CraryMessageBox alert:yes_selected ? @"You confirmed" : @"You cancelled"];
    }];
}

- (IBAction)onShowSelectItem:(id)sender
{
    NSArray *items = @[@"foo", @"bar", @"baz"];
    [CraryInputDialog selectSingle:sender items:items done:^(NSInteger buttonIndex) {
        if (buttonIndex >= items.count) {
            return;
        }
    
        [CraryMessageBox alert:items[buttonIndex]];
    }];
}

@end
