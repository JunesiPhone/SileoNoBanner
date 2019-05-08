%hook UIView
-(void)setBackgroundColor:(id)arg1 {
	UIColor *color = arg1;
	CGFloat red,green,blue,alpha;
	[color getRed:&red green:&green blue:&blue alpha:&alpha];
	if(red == 1.0f && green == 0.0f && blue == 0.0f){
		arg1 = [UIColor whiteColor];
	}
	%orig;
}
%end

static UILabel* noticeLabel = nil;

%hook UILabel
	/* This will easily break if sileo team changes the text but if it does it still will get rid of the ugly red banner. */
	-(NSString *)text{
		NSString *text = %orig;
		if([text isEqualToString:@"Web View depictions are deprecated. Please contact the repo maintainer about updating to native depictions."]){
			noticeLabel = self;
			return @"Developer has decided to use Webview depictions";
		}
		return %orig;
	}
	-(void)setText:(NSString *)arg1{
		if([arg1 isEqualToString:@"Web View depictions are deprecated. Please contact the repo maintainer about updating to native depictions."]){
			noticeLabel = self;
			arg1 = @"Developer has decided to use webview depictions";
		}
		%orig;
	}
	-(void)setTextColor:(UIColor *)arg1{
		if(self == noticeLabel){
			arg1 = [UIColor blackColor];
		}
		%orig;
	}
	-(UIColor*)textColor{
		if(self == noticeLabel){
			return [UIColor blackColor];
		}
		return %orig;
	}
%end