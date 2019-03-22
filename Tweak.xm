%hook UIView
-(void)setBackgroundColor:(UIColor *)textColor {
%orig([UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.00]);
}
%end

%hook UILabel
-(void)setTextColor:(UIColor *)textColor {
%orig([UIColor whiteColor]);
}
%end