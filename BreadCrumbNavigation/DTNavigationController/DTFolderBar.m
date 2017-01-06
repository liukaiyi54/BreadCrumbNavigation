//
//  DTFolderBar.m
//
// Copyright (c) 2013 Darktt
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "DTFolderBar.h"
#import "DTFolderItem.h"

// Config file
#import "DTFolderConfig.h"

// View Tag
#define kBackgroundViewTag 2
#define kScrollViewTag 3
#define kFolderItemViewTag 4

// Button Type
//#define kButtonType UIButtonTypeRoundedRect
#define kButtonType UIButtonTypeCustom

typedef void (^DTAnimationsBlock) (void);
typedef void (^DTCompletionBlock) (BOOL finshed);

@interface DTFolderBar ()
{
    NSMutableArray *_folderItems; // Saved folderItem array
}

@end

@implementation DTFolderBar

#pragma mark - Initialize Class

+ (id)folderBarWithFrame:(CGRect)frame
{
    DTFolderBar *folderBar = [[DTFolderBar alloc] initWithFrame:frame];
    
    return folderBar;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    [self setClipsToBounds:YES];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    _folderItems = [NSMutableArray new];
    
    UIViewAutoresizing autoresizing = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    [backgroundView setTag:kBackgroundViewTag];
    [backgroundView setContentMode:UIViewContentModeScaleToFill];
    [backgroundView setAutoresizingMask:autoresizing];
    
    CGRect scrollViewFrame = self.bounds;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    [scrollView setTag:kScrollViewTag];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView setAutoresizingMask:autoresizing];
    
    CGRect folderItemViewFrame = self.bounds;
    folderItemViewFrame.size.width = 0;
    
    UIView *folderItemView = [[UIView alloc] initWithFrame:folderItemViewFrame];
    [folderItemView setBackgroundColor:[UIColor clearColor]];
    [folderItemView setClipsToBounds:YES];
    [folderItemView setTag:kFolderItemViewTag];
    [folderItemView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    [self addSubview:backgroundView];
    [self addSubview:scrollView];
    
    if (_actionButton != nil) {
        [self addSubview:_actionButton];
    }
    
    [scrollView addSubview:folderItemView];
    
    return self;

}

#pragma mark - Add Folder Item Methods

- (void)setFolderItems:(NSArray *)folderItems
{
    [self setFolderItems:folderItems animated:NO];
}

- (void)setFolderItems:(NSArray *)folderItems animated:(BOOL)animated
{
    if (folderItems.count > _folderItems.count) {
        [_folderItems removeAllObjects];
        [_folderItems addObjectsFromArray:folderItems];
        
        DTFolderItem *folderItem = _folderItems.lastObject;
        folderItem.textLable.textColor = kFolderItemCurrentTextColor;
        [self addFolderItem:folderItem animated:animated];
        [self setNeedsColor];
    } else {
        NSMutableArray *removedItems = [NSMutableArray arrayWithArray:_folderItems];
        [removedItems removeObjectsInArray:folderItems];
        [removedItems enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(DTFolderItem *folderItem, NSUInteger idx, BOOL *stop){
            [self deleteFolderItem:folderItem animated:animated];
        }];
        
        [_folderItems removeAllObjects];
        [_folderItems addObjectsFromArray:folderItems];
    }
}

- (NSArray *)folderItems
{
    return _folderItems;
}

- (void)addFolderItem:(DTFolderItem *)folderItem animated:(BOOL)animated
{
    NSTimeInterval duration = animated ? kAddFolderDuration : 0.0f;
    
    UIView *folderItemView = (UIView *)[self viewWithTag:kFolderItemViewTag];
    CGRect folderItemViewFrame = folderItemView.frame;
    
    CGFloat nextItemPosition = folderItemViewFrame.size.width - 22.0f;
    folderItemViewFrame.size.width += folderItem.frame.size.width;
    
    if (nextItemPosition < 0.0f) {
        nextItemPosition = 0.0f;
    }
    
    CGRect folderItemFrame = folderItem.frame;
    folderItemFrame.origin.x = nextItemPosition;
    
    [folderItem setFrame:folderItemFrame];
    
    CGFloat folderItemViewWidth = nextItemPosition + folderItemFrame.size.width;
    folderItemViewFrame.size.width = folderItemViewWidth;
    
    DTAnimationsBlock animations = ^{
        [folderItemView insertSubview:folderItem atIndex:0];
        [folderItemView setFrame:folderItemViewFrame];
    };
    
    [UIView animateWithDuration:duration animations:animations];
    
    UIScrollView *scrollView = (UIScrollView *)[self viewWithTag:kScrollViewTag];
    [scrollView setContentSize:CGSizeMake((folderItemViewWidth + 44.0f), 0)];
    
    if (folderItemViewWidth > scrollView.frame.size.width) {
        CGPoint offset = scrollView.contentOffset;
        offset.x = folderItemViewWidth - scrollView.frame.size.width + 44.0f;
        
        [scrollView setContentOffset:offset animated:YES];
    }
}

- (void)deleteFolderItem:(DTFolderItem *)folderItem animated:(BOOL)animated
{
    NSTimeInterval duration = animated ? kDeleteFolderDuration : 0.0f;
    
    UIView *folderItemView = (UIView *)[self viewWithTag:kFolderItemViewTag];
    CGRect folderItemViewFrame = folderItemView.frame;
    folderItemViewFrame.size.width -= ( folderItem.frame.size.width - 22.0f );
    
    UIScrollView *scrollView = (UIScrollView *)[self viewWithTag:kScrollViewTag];
    
    CGSize contenSize = scrollView.contentSize;
    contenSize.width = folderItemViewFrame.size.width + 44.0f;
    
    DTAnimationsBlock animations = ^{
        [folderItemView setFrame:folderItemViewFrame];
        [scrollView setContentSize:contenSize];
    };
    
    DTCompletionBlock completion = ^(BOOL finsh){
        [folderItem removeFromSuperview];
    };
    
    [UIView animateWithDuration:duration animations:animations completion:completion];
}

- (void)setNeedsColor {
    for (DTFolderItem *item in _folderItems) {
        // 第一项总是绿色，之后除了最后一项，其他项总是绿色
        if (![item isEqual:_folderItems.lastObject] || [item isEqual:_folderItems.firstObject]) {
            item.textLable.textColor = kFolderItemTextColor;
        }
    }
}

@end
