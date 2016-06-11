//
//  ViewController.h
//  CurveTextExample
//
//  Created by Dexati on 18/03/16.
//  Copyright © 2016 Dexati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextArcView.h"

@interface MainScreenController : UIViewController

{
    IBOutlet UIButton *back;
}
@property(nonatomic, strong) NSString *textureColor;
@property(nonatomic, strong) NSString *quotesText;
@property(nonatomic, strong) UIImage *bgImage;
@property(nonatomic, assign) CGSize textViewSize;

@end

