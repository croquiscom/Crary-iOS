#define FONT_SYSTEM @"systemFont"
#define FONT_SYSTEM_BOLD @"systemFontBold"

#define IS_IOS6 ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
#define IS_PAD ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)

typedef void (^OnTaskComplete)(NSError *error, id result);