//
//  SaveAsRedux.m
//  SaveAsRedux
//
//  Created by Ben Yellin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SaveAsRedux.h"

@interface SaveAsRedux (Private)
- (void)installMenuItem;
- (IBAction)performSaveAs:(id)sender;
@end

@implementation SaveAsRedux

static SaveAsRedux *instance = nil;
+ (SaveAsRedux *)sharedInstance {
    if (!instance)
        instance = [[SaveAsRedux alloc] init];
    return instance;
}

- (void)installMenuItem {
    NSMenu *fileMenu = [[[NSApp mainMenu] itemWithTitle:@"File"] submenu];
    
    // check for existing Save As item
    if ([fileMenu indexOfItemWithTitle:@"Save As…"] == -1) {
        NSInteger saveItemIndex = [fileMenu indexOfItemWithTitle:@"Save"];
        [fileMenu insertItemWithTitle:@"Save As…" 
                               action:@selector(performSaveAs:) 
                        keyEquivalent:@"" 
                              atIndex:saveItemIndex+1];
    }          
}

- (IBAction)performSaveAs:(id)sender {
    NSArray *docs = [NSApp orderedDocuments];
    if (docs != nil && docs.count > 0) {
        NSDocument *currentDocument = [docs objectAtIndex:0];
        [currentDocument saveDocumentAs:nil];
    }
}

+ (void)load {
    SaveAsRedux *redux = [SaveAsRedux sharedInstance];
    [redux installMenuItem];
}

@end
