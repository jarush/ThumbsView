//
//  ThumbsViewController.m
//  Asset Record
//
//  Created by Jason Rush on 11/9/12.
//  Copyright (c) 2012 Flush Software. All rights reserved.
//

#import "ThumbsViewController.h"

@implementation ThumbsViewController

- (void)loadView {
    [super loadView];
    
    _thumbsView = [[ThumbsView alloc] initWithFrame:self.view.bounds];
    _thumbsView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _thumbsView.thumbsDataSource = self;
    _thumbsView.thumbsDelegate = self;
    self.view = _thumbsView;
}

- (void)dealloc {
    [_thumbsView release];
    [super dealloc];
}

- (NSUInteger)numberOfThumbsInThumbsView:(ThumbsView *)thumbsView {
    return 0;
}

- (ThumbsViewCell *)thumbsView:(ThumbsView *)thumbsView thumbViewAtIndex:(NSUInteger)index {
    return [thumbsView dequeueReusableCell];
}

@end
