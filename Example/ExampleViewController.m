//
//  ExampleViewController.m
//  Example
//
//  Created by Jason Rush on 11/9/12.
//  Copyright (c) 2012 Fizzawizza. All rights reserved.
//

#import "ExampleViewController.h"

@implementation ExampleViewController

- (NSUInteger)numberOfThumbsInThumbsView:(ThumbsView *)thumbsView {
    return 10;
}

- (ThumbsViewCell *)thumbsView:(ThumbsView *)thumbsView thumbViewAtIndex:(NSUInteger)index {
    ThumbsViewCell *cell = [thumbsView dequeueReusableCell];
    if (cell == nil) {
        cell = [[[ThumbsViewCell alloc] init] autorelease];
    }

    cell.backgroundColor = [UIColor redColor];

    return cell;
}

- (void)thumbsView:(ThumbsView *)thumbsView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"Selected: %d", index);
}

@end