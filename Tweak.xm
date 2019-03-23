BOOL enabled;

%hook UIView
  -(void)setBackgroundColor:(UIColor *)textColor {
      if (enabled) {
          %orig([UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.00]);
      } else {
          %orig;
      }
  }
%end

%hook UILabel
  -(void)setTextColor:(UIColor *)textColor {
    if (enabled) {
      %orig([UIColor whiteColor]);
    } else {
      %orig;
    }
  }
%end

static void loadPrefs() {
NSString *preferencesPath = @"/User/Library/Preferences/com.404meemr.DarkPowerSelectorPrefs.plist";
NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
  if(!preferences) {
    preferences = [[NSMutableDictionary alloc] init];
    //1 for yes, 0 for no
    [preferences setObject:[NSNumber numberWithBool:1] forKey:@"isEnabled"];
    [preferences writeToFile:preferencesPath atomically:YES];
  } else {
    enabled = [[preferences objectForKey:@"isEnabled"] boolValue];
  }
[preferences release];
}

//Change this to your postNotification from your settings.
static NSString *nsNotificationString = @"com.lacertosusrepo.stellaeprefs/preferences.changed";
static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  loadPrefs();
}

%ctor {
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  loadPrefs();
  notificationCallback(NULL, NULL, NULL, NULL, NULL);
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
  [pool release];
}
