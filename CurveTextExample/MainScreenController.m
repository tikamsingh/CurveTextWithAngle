//
//  ViewController.m
//  CurveTextExample
//
//  Created by Dexati on 18/03/16.
//  Copyright © 2016 Dexati. All rights reserved.
//

#import "MainScreenController.h"

#define textLengthsupport 150 // if greater then 150 then we are not providing the curve feature.

#define minimumCurveAngle 35
#define xycurvePadding  40

#define RADIANS_TO_DEGREES(angle) ((angle) * 180.0 / M_PI)
#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

#define cornerRadiusValue 15



@interface MainScreenController ()
{
    /*Font View Variable */
    IBOutlet UITextView *previewText;
    IBOutlet CoreTextArcView *previewTextView;
    
    // IBOutlet for screen
    
    
    IBOutlet UIImageView *bgImageView;
    
    
    IBOutlet UIView *fontView;
    IBOutlet UITextField *inputText;
    
    /*Format Tab*/
    
    IBOutlet UISlider *curveSlider;
    IBOutlet UISlider *fontSlider;
    float curveSliderValue;
    float fontSizeSliderValue;
    float diameter;


}
@end

@implementation MainScreenController


- (void)viewDidLoad {
    
    self.quotesText = @"Hello This is Tikam Chandrakar From Bhilai. India ";
    if(self.quotesText.length > textLengthsupport)
    {
        curveSlider.enabled = false;
    }
    else
    {
        curveSlider.enabled = true;;
    }
    
    [super viewDidLoad];
    fontSizeSliderValue = 16.0f;
    curveSliderValue = 1;
    
    
    inputText.hidden = NO;
    inputText.text = self.quotesText;
    
    
    [previewText setFont:[UIFont fontWithName:@"Avenir-Medium" size:fontSizeSliderValue]];
    
    
    previewText.text = self.quotesText;
    previewTextView.text = self.quotesText;
    
    CGRect rect1 = previewTextView.frame;
    UIFont * font1 = [UIFont fontWithName:@"Avenir-Medium" size:fontSizeSliderValue];
    UIColor * color1 = [UIColor redColor];
    previewTextView = [[CoreTextArcView alloc] initWithFrame:rect1 font:font1 text:self.quotesText  radius:previewTextView.frame.size.height/2  arcSize:curveSliderValue color:color1];
    previewTextView.backgroundColor = [UIColor clearColor];
    previewTextView.hidden = YES;
    [fontView addSubview:previewTextView];
    [fontView sendSubviewToBack:previewTextView];
    [fontView sendSubviewToBack:bgImageView];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    NSNumber *orientationValue = [NSNumber numberWithInt:UIDeviceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationValue forKey:@"orientation"];
    [super viewDidAppear:YES];
    
}

#pragma mark- Hide Status Bar
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    return NO;
}
#pragma mark UITextFieldDelegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *value = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == inputText)
    {
        if(value.length > textLengthsupport)
        {
            previewTextView.hidden = YES;
            previewText.hidden = NO;
            curveSlider.enabled = false;
            curveSliderValue = 0;
            curveSlider.value = 0;
            
        }
        else{
            curveSlider.enabled = true;
        }
        
        previewText.text = value;
        previewTextView.text = value;
        [self updatePreviewText:previewTextView];
    }
    // [self getWidthOfFont:previewTextView.text];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"textFieldShouldClear:");
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self resetFrame:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldClear:");
    [self resetFrame:textField];
    return YES;
}

- (void)resetFrame:(UITextField *)textField
{
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [textField resignFirstResponder];
}
- (IBAction)hideKeyboard:(id)sender
{
    NSLog(@"hideKeyboard");
    [self resetFrame:sender];
    [sender resignFirstResponder];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    
    [self resetFrame:inputText];
}

#pragma mark- Formate View Feature

#pragma marks - Curve Text Feature and Formula.

- (IBAction)curveSliderChange
{
    curveSliderValue = curveSlider.value;
    [self updatePreviewText:previewTextView];
}

- (IBAction)fontSizeSlider
{
    fontSizeSliderValue = fontSlider.value;
    [self updatePreviewText:previewTextView];
}


-(void)updatePreviewText:(UIView *)preViewFrame
{
    UIFont * font1 = [UIFont fontWithName:@"Avenir-Medium" size:fontSizeSliderValue];
    UIColor * color1 = [UIColor redColor];
    previewTextView.font = font1;
    previewTextView.arcSize = curveSliderValue;
    previewTextView.color = color1;
    [previewTextView setBackgroundColor:[UIColor clearColor]];
    if(curveSliderValue < minimumCurveAngle && curveSliderValue> -minimumCurveAngle)
    {
        previewText.hidden = NO;
        previewTextView.hidden = YES;
        [previewText setFont:[UIFont fontWithName:@"Avenir-Medium" size:fontSizeSliderValue]];
        return;
    }
    
    previewText.hidden = YES;
    
    [self getWidthOfFont:previewTextView.text];
    
    if(curveSliderValue < -minimumCurveAngle)
    {
        previewTextView.radius = -previewTextView.frame.size.height/2+fontSizeSliderValue/2;
        
    }
    else if(curveSliderValue > minimumCurveAngle)
    {
        previewTextView.radius = previewTextView.frame.size.height/2-fontSizeSliderValue;
        
    }
    
    previewTextView.text = previewTextView.text;
    previewTextView.hidden = NO;
}
/* Get the width of updated preview
 text View*/

- (CGRect) getWidthOfFont:(NSString *) textString
{
    
    UIFont *font = [UIFont fontWithName:@"Avenir-Medium" size:fontSizeSliderValue];
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: [UIColor blackColor]};
    
    CGSize textSize = [textString sizeWithAttributes: userAttributes];
    
    {
        diameter = (float) (((double) ((360.0f * (textSize.width)) / (fabsf(curveSliderValue+1)))) / 3.141592653589793) + fontSizeSliderValue*2;
        
    }
    previewTextView.frame = CGRectZero;
    CGRect frameSize  = CGRectMake([self getXpoint:previewTextView.frame.origin.x+diameter frameWidth:[self deviceWidth]],0, previewTextView.frame.origin.y+diameter, previewTextView.frame.origin.y+diameter);
    previewTextView.frame = frameSize;
    return frameSize;
}

- (float) getHeightText
{
    float height = previewTextView.frame.size.height;
    height = height/2-height/2*cos(DEGREES_TO_RADIANS(curveSliderValue/2))+fontSizeSliderValue;
    return height;
    
}
- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (CGFloat)deviceWidth
{
    //DebugLog(@"Width %f",[UIScreen mainScreen].bounds.size.width);
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)deviceHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}
- (CGFloat)getXpoint:(CGFloat)width frameWidth:(CGFloat)frameWidth
{
    //    DebugLog(@"Top frameWidth %f",frameWidth);
    //    DebugLog(@"width %f",width);
    //    DebugLog(@"return; %f", (frameWidth - width)/2);
    
    return (frameWidth - width)/2;
}


- (CGFloat)getYpoint:(CGFloat)height frameHeight:(CGFloat)frameHeight
{
    return -(frameHeight - height)/2;
}


- (CGFloat)getYpointForViewController:(CGFloat)height frameHeight:(CGFloat)frameHeight
{
    //DebugLog(@"Top frameHeight %f",frameHeight);
    //  DebugLog(@"Height %f",height);
    return (frameHeight - height)/2;
}



@end
