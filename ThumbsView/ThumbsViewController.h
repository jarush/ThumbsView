//
//  ThumbsViewController.h
//  Asset Record
//
//  Created by Jason Rush on 11/9/12.
//  Copyright (c) 2012 Flush Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbsView.h"

@interface ThumbsViewController : UIViewController <ThumbsViewDataSource, ThumbsViewDelegate>

@property (nonatomic, readonly) ThumbsView *thumbsView;

@end
