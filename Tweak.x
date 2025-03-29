//
// Copyright (c) 2025 Nightwind
//

#import <UIKit/UIKit.h>

@interface SBIconImageView : UIView
@property (nonatomic, readonly) UIImage *displayedImage;
@end

@interface SBMutableIconLabelImageParameters : NSObject
@property (nonatomic, strong) UIColor *textColor;
@end

@interface SBIconLegibilityLabelView : UIView
@property (nonatomic, strong) SBMutableIconLabelImageParameters *imageParameters;
@end

@interface SBIconView : UIView {
	SBIconImageView *_iconImageView;
}
@end

@interface UIImage (AverageColor)
- (UIColor *)_mil_averageColor;
@end

%hook SBIconView

- (SBMutableIconLabelImageParameters *)_labelImageParameters {
	SBMutableIconLabelImageParameters *const parameters = %orig;

	SBIconImageView *const imageView = [self valueForKey:@"_iconImageView"];
    if (!imageView) {
		return parameters;
	}

	parameters.textColor = [imageView.displayedImage _mil_averageColor];

	return parameters;
}

%end

@implementation UIImage (AverageColor)

- (UIColor *)_mil_averageColor {
    const CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    const CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);

	return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0 green:((CGFloat)rgba[1])/255.0 blue:((CGFloat)rgba[2])/255.0 alpha:((CGFloat)rgba[3])/255.0];
}

@end