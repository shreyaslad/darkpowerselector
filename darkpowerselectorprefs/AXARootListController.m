#include "AXARootListController.h"

#define kTintColor [UIColor colorWithRed:0.09 green:0.12 blue:0.16 alpha:1.0]

@interface DARKHeader : UITableViewCell {
  UILabel *label;
  UILabel *underLabel;
}
@end

@implementation DARKHeader
- (id)initWithSpecifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  if (self) {
		#define kWidth [[UIApplication sharedApplication] keyWindow].frame.size.width
		CGRect labelFrame = CGRectMake(0, -15, kWidth, 80);
		CGRect underLabelFrame = CGRectMake(0, 35, kWidth, 60);

		label = [[UILabel alloc] initWithFrame:labelFrame];
		[label setNumberOfLines:1];
		label.font = [UIFont systemFontOfSize:50];
		[label setText:@"DarkPowerSelector"];
		//[label setBackgroundColor:[UIColor clearColor]];
		label.textColor = kTintColor;
		label.textAlignment = NSTextAlignmentCenter;

		underLabel = [[UILabel alloc] initWithFrame:underLabelFrame];
		[underLabel setNumberOfLines:1];
		underLabel.font = [UIFont systemFontOfSize:20];
		[underLabel setText:@"yes"];
		//[underLabel setBackgroundColor:[UIColor clearColor]];
		underLabel.textColor = [UIColor grayColor];
		underLabel.textAlignment = NSTextAlignmentCenter;

		[self addSubview:label];
		[self addSubview:underLabel];
  }
  return self;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
  CGFloat prefHeight = 75.0;
  return prefHeight;
}
@end

@implementation AXARootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(id)readPreferenceValue:(PSSpecifier*)specifier {
		NSDictionary * prefs = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];
		if (![prefs objectForKey:[specifier.properties objectForKey:@"key"]]) {
			return [specifier.properties objectForKey:@"default"];
		}
		return [prefs objectForKey:[specifier.properties objectForKey:@"key"]];
	}

	-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
		NSMutableDictionary * prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];
		[prefs setObject:value forKey:[specifier.properties objectForKey:@"key"]];
		[prefs writeToFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]] atomically:YES];
		if([specifier.properties objectForKey:@"PostNotification"]) {
			CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)[specifier.properties objectForKey:@"PostNotification"], NULL, NULL, YES);
		}
		[super setPreferenceValue:value specifier:specifier];
	}

- (void)openGithub {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://github.com/penetratingshot/darkpowerselector"]
	options:@{}
	completionHandler:nil];
}

- (void)openReddit {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://reddit.com/u/404meemr"]
	options:@{}
	completionHandler:nil];
}

@end
