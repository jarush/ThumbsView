//
//  Thumbs.m
//  Asset Record
//
//  Created by Jason Rush on 11/9/12.
//  Copyright (c) 2012 Flush Software. All rights reserved.
//

#import "ThumbsView.h"

@interface ThumbsView () <UIGestureRecognizerDelegate> {
    NSMutableDictionary *visibleCells;
    NSMutableSet *reusableCells;
    NSUInteger numberOfCells;
}

@end

@implementation ThumbsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.alwaysBounceVertical = YES;
        self.alwaysBounceHorizontal = NO;
        self.backgroundColor = [UIColor whiteColor];

        // Default cell size/padding will show 4 cells per row
        self.cellSize = CGSizeMake(75.f, 75.f);
        self.cellPadding = CGSizeMake(4.f, 4.f);

        UITapGestureRecognizer *tapGestureRecgonizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSelection:)];
        tapGestureRecgonizer.delegate = self;
        tapGestureRecgonizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGestureRecgonizer];

        visibleCells = [[NSMutableDictionary dictionary] retain];
        reusableCells = [[NSMutableSet set] retain];

        numberOfCells = 0;
    }
    return self;
}

- (void)dealloc {
    [visibleCells release];
    [reusableCells release];
    [super dealloc];
}

- (void)setThumbsDataSource:(id<ThumbsViewDataSource>)thumbsDataSource {
    _thumbsDataSource = thumbsDataSource;
    [self reloadData];
}

- (void)setCellSize:(CGSize)cellSize {
    _cellSize = cellSize;
    [self reloadData];
}

- (void)setCellPadding:(CGSize)cellPadding {
    _cellPadding = cellPadding;
    [self reloadData];
}

- (ThumbsViewCell *)dequeueReusableCell {
    ThumbsViewCell *reusableCell = [reusableCells anyObject];
    if (reusableCell != nil) {
        [reusableCells removeObject:reusableCell];
    }

    return reusableCell;
}

- (void)reloadData {
    // Recycle all the current cells
    for (ThumbsViewCell *cell in [visibleCells  allValues]) {
        [reusableCells addObject:cell];
        [cell removeFromSuperview];
    }
    [visibleCells removeAllObjects];

    // Update the number of cells
    numberOfCells = [self.thumbsDataSource numberOfThumbsInThumbsView:self];

    // Add the visible cells

    [self setNeedsLayout];
}

- (void)layoutSubviews {
    CGRect visibleBounds = {self.contentOffset, self.bounds.size};

    // Compute row/cell metrics
    NSUInteger numberOfCols = floor(visibleBounds.size.width / (_cellSize.width + _cellPadding.width));
    NSUInteger numberOfRows = ceil(numberOfCells / (CGFloat)numberOfCols);

    NSUInteger rowHeight = _cellSize.height + _cellPadding.height;

    // Compute the content size
    CGSize newContentSize = {
        self.bounds.size.width,
        numberOfRows * rowHeight + (numberOfRows > 0 ? _cellPadding.height : 0),
    };
    self.contentSize = newContentSize;

    // Compute which rows are visible
    NSUInteger minRow = floor(visibleBounds.origin.y / rowHeight);
    NSUInteger maxRow = ceil((visibleBounds.origin.y + visibleBounds.size.height) / rowHeight);
    NSUInteger minIndex = MIN(minRow * numberOfCols, numberOfCells - 1);
    NSUInteger maxIndex = MIN(maxRow * numberOfCols, numberOfCells);

    // Recycle all previously visible cells that will become offscreen
    NSMutableArray *cellsToRemove = [NSMutableArray array];
    for (ThumbsViewCell *cell in [visibleCells objectEnumerator]) {
        CGRect cellFrame = cell.frame;
        if (CGRectGetMinY(cellFrame) > CGRectGetMaxY(visibleBounds) &&
            CGRectGetMaxY(cellFrame) < CGRectGetMinY(visibleBounds)) {
            [cell removeFromSuperview];
            [cellsToRemove addObject:[NSNumber numberWithUnsignedInteger:cell.index]];
            [reusableCells addObject:cell];
        }
    }
    [visibleCells removeObjectsForKeys:cellsToRemove];

    // Layout all the cells on the screen
    for (NSUInteger index = minIndex; index < maxIndex; index++) {
        ThumbsViewCell *cell = [visibleCells objectForKey:[NSNumber numberWithUnsignedInteger:index]];
        if (cell == nil) {
            cell = [_thumbsDataSource thumbsView:self thumbViewAtIndex:index];
            cell.index = index;

            NSUInteger row = index / numberOfCols;
            NSUInteger col = index - (row * numberOfCols);
            NSUInteger x = col * (_cellSize.width + _cellPadding.width) + _cellPadding.width;
            NSUInteger y = row * rowHeight + _cellPadding.height;
            cell.frame = CGRectMake(x, y, _cellSize.width, _cellSize.height);

            [self addSubview:cell];
            [visibleCells setObject:cell forKey:[NSNumber numberWithUnsignedInteger:index]];
        }
    }

    [super layoutSubviews];
}

- (NSInteger)indexForItemAtPoint:(CGPoint)point {
    for (ThumbsViewCell *cell in [visibleCells objectEnumerator]) {
        if (CGRectContainsPoint(cell.frame, point)) {
            return cell.index;
        }
    }

    return -1;
}

- (void)handleSelection:(UITapGestureRecognizer *)tapGestureRecgonizer {
    if ([_thumbsDelegate respondsToSelector:@selector(thumbsView:didSelectItemAtIndex:)]) {
        CGPoint point = [tapGestureRecgonizer locationInView:self];
        NSInteger index = [self indexForItemAtPoint:point];
        if (index != -1) {
            [_thumbsDelegate thumbsView:self didSelectItemAtIndex:index];
        }
    }
}

@end
