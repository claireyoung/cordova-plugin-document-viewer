//
//  SDVReaderViewController.h
//
//  implements Sitewaerts Document Viewer runtime options for VFR Reader
//
//  Created by Philipp Bohnenstengel on 03.11.14.
//
//

#import "ReaderConstants.h"
#import "ReaderViewController.h"

#import <UIKit/UIKit.h>

typedef enum
{
    SDVReaderContentViewModeSinglePage = 0,
    SDVReaderContentViewModeDoublePage,
    SDVReaderContentViewModeCoverDoublePage
} SDVReaderContentViewMode;

typedef enum
{
    SDVReaderClosedOnSwipe = 0,
    SDVReaderClosedOnDone = 1,
    SDVReaderClosedOnPreview = 2
} SDVReaderClosedMode;

@interface SDVReaderViewController : ReaderViewController {
    UIView *swipeForArticleView;
}
@property NSMutableDictionary *viewerOptions;
@property int pagesPerScreen;
@property SDVReaderContentViewMode viewMode;
@property SDVReaderClosedMode closedOnDone;

- (instancetype)initWithReaderDocument:(ReaderDocument *)object options:(NSMutableDictionary *)options;

- (void)layoutContentViews:(UIScrollView *)scrollView;

- (void)updateContentSize:(UIScrollView *)scrollView;

- (void)decrementPageNumber;

- (void)incrementPageNumber;

@end
