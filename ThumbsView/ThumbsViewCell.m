//
//  ThumbView.m
//  Asset Record
//
//  Created by Jason Rush on 11/9/12.
//  Copyright (c) 2012 Flush Software. All rights reserved.
//

#import "ThumbsViewCell.h"

@implementation ThumbsViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)dealloc {
    [_imageView release];
    [super dealloc];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _imageView.frame = self.bounds;
}

@end
