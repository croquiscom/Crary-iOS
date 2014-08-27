#import "CraryMessageBox.h"
#import "Crary+Private.h"

@implementation CraryMessageBox

+ (void)alert:(NSString *)message
{
    NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self alert:message title:title];
}

+ (void)alert:(NSString *)message title:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
    [alert show];
}

@end
