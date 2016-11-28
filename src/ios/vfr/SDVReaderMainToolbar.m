//
//  SDVReaderMainToolbar.m
//
//  implements Sitewaerts Document Viewer runtime options for VFR Reader
//
//  Created by Philipp Bohnenstengel on 03.11.14.
//
//

#import "ReaderConstants.h"
#import "ReaderDocument.h"

#import "SDVReaderMainToolbar.h"
#import "ReaderMainToolbar+SDVReaderMainToolbarPassThrough.h"

#import <MessageUI/MessageUI.h>

@interface SDVReaderMainToolbar ()
    @property (nonatomic) UIButton *shareButton;
    @property (nonatomic) UIButton *doneButton;
    @property (nonatomic) UILabel *titleLabel;
@end


@implementation SDVReaderMainToolbar

#pragma mark - Constants

#define BUTTON_X 8.0f
#define BUTTON_Y 8.0f

#define BUTTON_SPACE 8.0f
#define BUTTON_HEIGHT 30.0f

#define BUTTON_FONT_SIZE 15.0f
#define TEXT_BUTTON_PADDING 24.0f

#define SHOW_CONTROL_WIDTH 80.0f
#define ICON_BUTTON_WIDTH 30.0f

#define TITLE_FONT_SIZE 19.0f
#define TITLE_HEIGHT 28.0f

//  this is just testcode to provide default options for the original method call
- (instancetype)initWithFrame:(CGRect)frame document:(ReaderDocument *)document
{
    // TODO: set default options
    NSMutableDictionary *bookmarkOptions = [ [NSMutableDictionary alloc]
                                            initWithObjectsAndKeys :
                                            [NSNumber numberWithBool:YES], @"enabled",
                                            nil
                                            ];
    NSMutableDictionary *documentViewOptions = [ [NSMutableDictionary alloc]
                                                initWithObjectsAndKeys :
                                                @"Test", @"closeLabel",
                                                nil
                                                ];
    NSMutableDictionary *emailOptions = [ [NSMutableDictionary alloc]
                                         initWithObjectsAndKeys :
                                         [NSNumber numberWithBool:YES], @"enabled",
                                         nil
                                         ];
    NSMutableDictionary *navigationViewOptions = [ [NSMutableDictionary alloc]
                                                  initWithObjectsAndKeys :
                                                  @"Back", @"closeLabel",
                                                  nil
                                                  ];
    NSMutableDictionary *openWithOptions = [ [NSMutableDictionary alloc]
                                            initWithObjectsAndKeys :
                                            [NSNumber numberWithBool:NO], @"enabled",
                                            nil
                                            ];
    NSMutableDictionary *printOptions = [ [NSMutableDictionary alloc]
                                         initWithObjectsAndKeys :
                                         [NSNumber numberWithBool:YES], @"enabled",
                                         nil
                                         ];
    NSMutableDictionary *searchOptions = [ [NSMutableDictionary alloc]
                                          initWithObjectsAndKeys :
                                          [NSNumber numberWithBool:NO], @"enabled",
                                          nil
                                          ];
    NSMutableDictionary *viewerDefaultOptions = [ [NSMutableDictionary alloc]
                                                 initWithObjectsAndKeys :
                                                 bookmarkOptions, @"bookmarks",
                                                 documentViewOptions, @"documentView",
                                                 emailOptions, @"email",
                                                 navigationViewOptions, @"navigationView",
                                                 openWithOptions, @"openWith",
                                                 printOptions, @"print",
                                                 searchOptions, @"search",
                                                 @"untitled", @"title",
                                                 nil
                                                 ];
    return [self initWithFrame:frame document:document options: viewerDefaultOptions ];
}

// new init method with options, modified version of initWithFrame from ReaderMainToolbar
- (instancetype)initWithFrame:(CGRect)frame document:(ReaderDocument *)document options:(NSDictionary *)options
{
    NSLog(@"[pdfviewer] toolbar-options: %@", options);
    
    assert(document != nil); // Must have a valid ReaderDocument
    
    if ((self = [super initWithFrame:frame document: document]))
    {
        CGPoint viewOrigin = self.bounds.origin;
        CGSize viewDimensions = self.bounds.size;
        CGFloat viewWidth = self.bounds.size.width; // Toolbar view width
        
#if (READER_FLAT_UI == TRUE) // Option
        UIImage *buttonH = nil; UIImage *buttonN = nil;
#else
        UIImage *buttonH = [[UIImage imageNamed:@"Reader-Button-H"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        UIImage *buttonN = [[UIImage imageNamed:@"Reader-Button-N"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
#endif // end of READER_FLAT_UI Option
        
        BOOL largeDevice = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
        
        const CGFloat buttonSpacing = BUTTON_SPACE; const CGFloat iconButtonWidth = ICON_BUTTON_WIDTH;
        
        CGFloat titleX = BUTTON_X; CGFloat titleWidth = (viewWidth - (titleX + titleX));
        
        CGFloat leftButtonX = BUTTON_X; // Left-side button start X position
        
#if (READER_STANDALONE == FALSE) // Option
        
        // cyoung - THIS ONE GETS CALLED
        UIFont *doneButtonFont = [UIFont systemFontOfSize:BUTTON_FONT_SIZE];
        //get doneButtonText from options
//        NSString *toolbarOptionCloseLabel = [[options objectForKey: @"documentView"] objectForKey: @"closeLabel"];
//        NSLog(@"[pdfviewer] toolbar-options close label: %@", toolbarOptionCloseLabel);
//        NSString *doneButtonText = toolbarOptionCloseLabel?:NSLocalizedString(@"Done", @"button");
//        CGSize doneButtonSize = [doneButtonText sizeWithFont:doneButtonFont];
        CGFloat doneButtonWidth = (80 + TEXT_BUTTON_PADDING);
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        doneButton.frame = CGRectMake(leftButtonX, BUTTON_Y, doneButtonWidth, BUTTON_HEIGHT);
        
        // Now load the image and create the image view
        UIImage *image = [UIImage imageNamed:@"backButton.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, BUTTON_HEIGHT-8, BUTTON_HEIGHT-8)];
        [imageView setImage:image];
        // Create the label and set its text
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BUTTON_HEIGHT-5, 0, 40, BUTTON_HEIGHT)];
        [label setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f]];
        [label setText:@"Exit"];

        // Put it all together
        [doneButton addSubview:label];
        [doneButton addSubview:imageView];
        
        
//        
//        [doneButton setTitle:@"Exit" forState:UIControlStateNormal];
//        [doneButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateNormal];
////        [doneButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateHighlighted];
////        [doneButton setTitle:doneButtonText forState:UIControlStateNormal]; doneButton.titleLabel.font = doneButtonFont;
        [doneButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
////        [doneButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
////        [doneButton setBackgroundImage:buttonN forState:UIControlStateNormal];
//        [doneButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
//        doneButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 10.0, 5.0, 5.0);
//        doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        
        //        doneButton.autoresizingMask = UIViewAutoresizingNone;
        doneButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //doneButton.backgroundColor = [UIColor grayColor];
        doneButton.exclusiveTouch = YES;
        
        self.doneButton = doneButton;
        [self addSubview:doneButton]; leftButtonX += (doneButtonWidth + buttonSpacing);
        
        
        titleX += (doneButtonWidth + buttonSpacing); titleWidth -= (doneButtonWidth + buttonSpacing);
        
        NSString *title = [[options objectForKey: @"title"] objectForKey: @"title"];
        CGSize labelSize = [title sizeWithFont:doneButtonFont];
        CGFloat labelWidth = (labelSize.width + TEXT_BUTTON_PADDING);
        
        CGFloat centerX = self.frame.size.width/2;
        CGFloat startLeft = centerX - labelWidth/2;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, BUTTON_Y, labelWidth, BUTTON_HEIGHT)];
        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor blackColor]];
        [titleLabel setText:title];


        self.titleLabel = titleLabel;
        
        [self addSubview:titleLabel];

        
#endif // end of READER_STANDALONE Option
        
#if (READER_ENABLE_THUMBS == TRUE) // Option
        //don't show navigation view for single page documents
        if ([document.pageCount intValue] > 1)
        {
            
            // cyoung - don't enable this at all
//            UIButton *thumbsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            thumbsButton.frame = CGRectMake(leftButtonX, BUTTON_Y, iconButtonWidth, BUTTON_HEIGHT);
//            [thumbsButton setImage:[UIImage imageNamed:@"SDVReader-Outline"] forState:UIControlStateNormal];
//            [thumbsButton addTarget:self action:@selector(thumbsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//            [thumbsButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
//            [thumbsButton setBackgroundImage:buttonN forState:UIControlStateNormal];
//            thumbsButton.autoresizingMask = UIViewAutoresizingNone;
//            //thumbsButton.backgroundColor = [UIColor grayColor];
//            thumbsButton.exclusiveTouch = YES;
//            
//            [self addSubview:thumbsButton]; //leftButtonX += (iconButtonWidth + buttonSpacing);
//            
//            titleX += (iconButtonWidth + buttonSpacing); titleWidth -= (iconButtonWidth + buttonSpacing);
        }
#endif // end of READER_ENABLE_THUMBS Option
        
        CGFloat rightButtonX = viewWidth; // Right-side buttons start X position
       
#if (READER_BOOKMARKS == TRUE) // Option
        //get bookmarks enabled options
        BOOL toolbarOptionBookmarks = [[[options objectForKey: @"bookmarks"] objectForKey: @"enabled"] boolValue];
        NSLog(@"[pdfviewer] toolbar-options bookmarks: %d", toolbarOptionBookmarks);
        if (toolbarOptionBookmarks) {
            
            rightButtonX -= (iconButtonWidth*2 + buttonSpacing*3); // Position
            
            UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
            flagButton.frame = CGRectMake(rightButtonX, BUTTON_Y, iconButtonWidth, BUTTON_HEIGHT);
            //[flagButton setImage:[UIImage imageNamed:@"Reader-Mark-N"] forState:UIControlStateNormal];
            [flagButton addTarget:self action:@selector(markButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [flagButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
            [flagButton setBackgroundImage:buttonN forState:UIControlStateNormal];
            flagButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            //flagButton.backgroundColor = [UIColor grayColor];
            flagButton.exclusiveTouch = YES;
            
            [self addSubview:flagButton]; titleWidth -= (iconButtonWidth + buttonSpacing);
            
            markButton = flagButton; markButton.enabled = NO; markButton.tag = NSIntegerMin;
            
            markImageN = [UIImage imageNamed:@"Reader-Mark-N"]; // N image
            markImageY = [UIImage imageNamed:@"Reader-Mark-Y"]; // Y image
            
        }
#endif // end of READER_BOOKMARKS Option
        
//        //get email enabled options
//        BOOL toolbarOptionEmail = [[[options objectForKey: @"email"] objectForKey: @"enabled"] boolValue];
//        NSLog(@"[pdfviewer] toolbar-options email: %d", toolbarOptionEmail);
//        if (toolbarOptionEmail) {
//            if (document.canEmail == YES) // Document email enabled
//            {
//                if ([MFMailComposeViewController canSendMail] == YES) // Can email
//                {
//                    unsigned long long fileSize = [document.fileSize unsignedLongLongValue];
//                    
//                    if (fileSize < 15728640ull) // Check attachment size limit (15MB)
//                    {
//                        rightButtonX -= (iconButtonWidth + buttonSpacing); // Next position
//                        
//                        UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                        emailButton.frame = CGRectMake(rightButtonX, BUTTON_Y, iconButtonWidth, BUTTON_HEIGHT);
//                        [emailButton setImage:[UIImage imageNamed:@"Reader-Email"] forState:UIControlStateNormal];
//                        [emailButton addTarget:self action:@selector(emailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//                        [emailButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
//                        [emailButton setBackgroundImage:buttonN forState:UIControlStateNormal];
//                        emailButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
//                        //emailButton.backgroundColor = [UIColor grayColor];
//                        emailButton.exclusiveTouch = YES;
//                        
//                        [self addSubview:emailButton]; titleWidth -= (iconButtonWidth + buttonSpacing);
//                    }
//                }
//            }
//        }
        
//        //get print enabled options
//        BOOL toolbarOptionPrint = [[[options objectForKey: @"print"] objectForKey: @"enabled"] boolValue];
//        NSLog(@"[pdfviewer] toolbar-options print: %d", toolbarOptionPrint);
//        if (toolbarOptionPrint) {
//            if ((document.canPrint == YES) && (document.password == nil)) // Document print enabled
//            {
//                Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");
//                
//                if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
//                {
//                    rightButtonX -= (iconButtonWidth + buttonSpacing); // Next position
//                    
//                    UIButton *printButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                    printButton.frame = CGRectMake(rightButtonX, BUTTON_Y, iconButtonWidth, BUTTON_HEIGHT);
//                    [printButton setImage:[UIImage imageNamed:@"Reader-Print"] forState:UIControlStateNormal];
//                    [printButton addTarget:self action:@selector(printButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//                    [printButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
//                    [printButton setBackgroundImage:buttonN forState:UIControlStateNormal];
//                    printButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
//                    //printButton.backgroundColor = [UIColor grayColor];
//                    printButton.exclusiveTouch = YES;
//                    
//                    [self addSubview:printButton]; titleWidth -= (iconButtonWidth + buttonSpacing);
//                }
//            }
//        }
        
//        //get open with enabled options
//        BOOL toolbarOptionOpenWith = [[[options objectForKey: @"openWith"] objectForKey: @"enabled"] boolValue];
//        NSLog(@"[pdfviewer] toolbar-options open with: %d", toolbarOptionOpenWith);
//        if (toolbarOptionOpenWith) {
//            if (document.canExport == YES) // Document export enabled
//            {
//                rightButtonX -= (iconButtonWidth + buttonSpacing); // Next position
//                
//                UIButton *exportButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                exportButton.frame = CGRectMake(rightButtonX, BUTTON_Y, iconButtonWidth, BUTTON_HEIGHT);
//                [exportButton setImage:[UIImage imageNamed:@"Reader-Export"] forState:UIControlStateNormal];
//                [exportButton addTarget:self action:@selector(exportButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//                [exportButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
//                [exportButton setBackgroundImage:buttonN forState:UIControlStateNormal];
//                exportButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
//                //exportButton.backgroundColor = [UIColor grayColor];
//                exportButton.exclusiveTouch = YES;
//                
//                [self addSubview:exportButton]; titleWidth -= (iconButtonWidth + buttonSpacing);
//            }
//        }
        
        //view modes
//        UIImage *singlePageButton = [UIImage imageNamed:@"SDVReader-SinglePage"];
//        UIImage *doublePageButton = [UIImage imageNamed:@"SDVReader-DoublePage"];
//        UIImage *coverPageButton = [UIImage imageNamed:@"SDVReader-CoverPage"];
//        NSArray *buttonItems = [NSArray arrayWithObjects:singlePageButton, doublePageButton, nil];
//        
//        BOOL useTint = [self respondsToSelector:@selector(tintColor)]; // iOS 7 and up
//
//        //don't show viewmode for single page documents
//        if ([document.pageCount intValue] > 1)
//        {
//        rightButtonX -= (SHOW_CONTROL_WIDTH + buttonSpacing*2 + SHOW_CONTROL_WIDTH/2); // Next position
//        
//        UISegmentedControl *showControl = [[UISegmentedControl alloc] initWithItems:buttonItems];
//        showControl.frame = CGRectMake(rightButtonX, BUTTON_Y, SHOW_CONTROL_WIDTH, BUTTON_HEIGHT);
//        showControl.tintColor = ([UIColor colorWithWhite:0.8f alpha:1.0f]);
//        showControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
//        showControl.segmentedControlStyle = UISegmentedControlStyleBar;
//        showControl.selectedSegmentIndex = 0; // Default segment index
//        //showControl.backgroundColor = [UIColor grayColor];
//        showControl.exclusiveTouch = YES;
//        
//        [showControl addTarget:self action:@selector(showControlTapped:) forControlEvents:UIControlEventValueChanged];
//        
//        [self addSubview:showControl];
//        //adjust available width for document title
//        titleWidth -= (SHOW_CONTROL_WIDTH + buttonSpacing);
//        }
        
        // BOOKMARK BUTTON
        
//        // SHARE BUTTON
//        rightButtonX -= buttonSpacing + iconButtonWidth;
//        
//        UIButton* shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        shareButton.frame = CGRectMake(rightButtonX, BUTTON_Y, doneButtonWidth, BUTTON_HEIGHT);
//        [shareButton addTarget:self action:@selector(shareButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//        [shareButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
//        [shareButton setBackgroundImage:buttonN forState:UIControlStateNormal];
//        [shareButton setImage:[UIImage imageNamed:@"shareButton.png"] forState:UIControlStateNormal];
//        shareButton.autoresizingMask = UIViewAutoresizingNone;
//        //doneButton.backgroundColor = [UIColor grayColor];
//        shareButton.exclusiveTouch = YES;
//        
//        self.shareButton = shareButton;
//        
//        [self addSubview:shareButton];
        
//        if (largeDevice == YES) // Show document filename in toolbar
//        {
//            CGRect titleRect = CGRectMake(titleX, BUTTON_Y, titleWidth, TITLE_HEIGHT);
//            
//            UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleRect];
//            
//            titleLabel.textAlignment = NSTextAlignmentCenter;
//            titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
//            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//            titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//            titleLabel.textColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
//            titleLabel.backgroundColor = [UIColor clearColor];
//            titleLabel.adjustsFontSizeToFitWidth = YES;
//            titleLabel.minimumScaleFactor = 0.75f;
//            //get title from options
//            NSString *toolbarOptionTitle = [options objectForKey: @"title"];
//            NSLog(@"[pdfviewer] toolbar-options title label: %@", toolbarOptionTitle);
//            titleLabel.text = toolbarOptionTitle?:[document.fileName stringByDeletingPathExtension];
//#if (READER_FLAT_UI == FALSE) // Option
//            titleLabel.shadowColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
//            titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
//#endif // end of READER_FLAT_UI Option
//            
//            [self addSubview:titleLabel];
//        }
    }
    
    return self;
}

- (void)resize
{
    CGRect viewFrame = self.frame;
    CGFloat newFrameWidth = [self superview].frame.size.width;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newFrameWidth, self.frame.size.height);
    
    CGFloat rightButtonX = self.frame.size.width - (BUTTON_SPACE + ICON_BUTTON_WIDTH);
    self.shareButton.frame = CGRectMake(rightButtonX, self.shareButton.frame.origin.y, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
    CGFloat doneButtonWidth = (20 + TEXT_BUTTON_PADDING);
    CGRect doneFrame = self.doneButton.frame;
    self.doneButton.frame = CGRectMake(self.doneButton.frame.origin.x, self.doneButton.frame.origin.y, doneButtonWidth, BUTTON_HEIGHT);
    
    CGFloat center = self.frame.size.width/2;
    CGFloat labelX = center - (self.titleLabel.frame.size.width/2);
    self.titleLabel.frame = CGRectMake(labelX, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
}

#pragma mark - UISegmentedControl action methods

- (void)showControlTapped:(UISegmentedControl *)control
{
    [self.delegate tappedInToolbar:self showControl:control];
}

- (void)shareButtonTapped:(UIButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share"
                                                    message:@"Share Button Placeholder."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
