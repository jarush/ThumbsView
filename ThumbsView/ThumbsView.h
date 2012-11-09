//
//  Thumbs.h
//  Asset Record
//
//  Created by Jason Rush on 11/9/12.
//  Copyright (c) 2012 Flush Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbsViewCell.h"

@class ThumbsView;

@protocol ThumbsViewDataSource <NSObject>
- (NSUInteger)numberOfThumbsInThumbsView:(ThumbsView *)thumbsView;
- (ThumbsViewCell *)thumbsView:(ThumbsView *)thumbsView thumbViewAtIndex:(NSUInteger)index;
@end

@protocol ThumbsViewDelegate <NSObject>
@optional
- (void)thumbsView:(ThumbsView *)thumbsView didSelectItemAtIndex:(NSUInteger)index;
@end

@interface ThumbsView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) id<ThumbsViewDataSource> thumbsDataSource;
@property (nonatomic, assign) id<ThumbsViewDelegate> thumbsDelegate;
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) CGSize cellPadding;

- (void)reloadData;
- (ThumbsViewCell *)dequeueReusableCell;

@end
