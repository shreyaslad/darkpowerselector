#line 1 "Tweak.xm"
BOOL enabled;


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UIView; @class UILabel; 
static void (*_logos_orig$_ungrouped$UIView$setBackgroundColor$)(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$_ungrouped$UIView$setBackgroundColor$(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST, SEL, UIColor *); static void (*_logos_orig$_ungrouped$UILabel$setTextColor$)(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$_ungrouped$UILabel$setTextColor$(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST, SEL, UIColor *); 

#line 3 "Tweak.xm"

  static void _logos_method$_ungrouped$UIView$setBackgroundColor$(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * textColor) {
      if (enabled) {
          _logos_orig$_ungrouped$UIView$setBackgroundColor$(self, _cmd, [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.00]);
      } else {
          _logos_orig$_ungrouped$UIView$setBackgroundColor$(self, _cmd, textColor);
      }
  }



  static void _logos_method$_ungrouped$UILabel$setTextColor$(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * textColor) {
    if (enabled) {
      _logos_orig$_ungrouped$UILabel$setTextColor$(self, _cmd, [UIColor whiteColor]);
    } else {
      _logos_orig$_ungrouped$UILabel$setTextColor$(self, _cmd, textColor);
    }
  }


static void loadPrefs() {
NSString *preferencesPath = @"/User/Library/Preferences/com.404meemr.DarkPowerSelectorPrefs.plist";
NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
  if(!preferences) {
    preferences = [[NSMutableDictionary alloc] init];
    
    [preferences setObject:[NSNumber numberWithBool:1] forKey:@"isEnabled"];
    [preferences writeToFile:preferencesPath atomically:YES];
  } else {
    enabled = [[preferences objectForKey:@"isEnabled"] boolValue];
  }
[preferences release];
}


static NSString *nsNotificationString = @"com.lacertosusrepo.stellaeprefs/preferences.changed";
static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  loadPrefs();
}

static __attribute__((constructor)) void _logosLocalCtor_9d1dd3f5(int __unused argc, char __unused **argv, char __unused **envp) {
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  loadPrefs();
  notificationCallback(NULL, NULL, NULL, NULL, NULL);
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
  [pool release];
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIView = objc_getClass("UIView"); MSHookMessageEx(_logos_class$_ungrouped$UIView, @selector(setBackgroundColor:), (IMP)&_logos_method$_ungrouped$UIView$setBackgroundColor$, (IMP*)&_logos_orig$_ungrouped$UIView$setBackgroundColor$);Class _logos_class$_ungrouped$UILabel = objc_getClass("UILabel"); MSHookMessageEx(_logos_class$_ungrouped$UILabel, @selector(setTextColor:), (IMP)&_logos_method$_ungrouped$UILabel$setTextColor$, (IMP*)&_logos_orig$_ungrouped$UILabel$setTextColor$);} }
#line 50 "Tweak.xm"
