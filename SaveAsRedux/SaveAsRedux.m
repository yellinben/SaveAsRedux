//
//  SaveAsRedux.m
//  SaveAsRedux
//
//  Created by Ben Yellin on 3/29/12.
//  Copyright (c) 2012 Been Yelling. All rights reserved.
//

#import "SaveAsRedux.h"

@interface SaveAsRedux (Private)
- (void)installMenuItem;
- (IBAction)performSaveAs:(id)sender;
- (NSDocument *)activeDocument;
- (BOOL)hasActiveDocument;
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
    
    // make sure to check for existing Save As item
    if ([fileMenu indexOfItemWithTitle:@"Save As…"] == -1) {
        NSInteger saveItemIndex = -1;
        for (NSMenuItem *item in [fileMenu itemArray]) {
            if ([item action] == @selector(saveDocument:) || 
                [[item title] isEqualToString:@"Save"] ||
                [[item title] isEqualToString:@"Save…"])
                saveItemIndex = [fileMenu indexOfItem:item];
        }
        
        if (saveItemIndex != -1) {        
            NSMenuItem *saveAsItem = [[[NSMenuItem alloc] init] autorelease];
            [saveAsItem setRepresentedObject:self];
            [saveAsItem setTarget:self];
            [saveAsItem setTitle:@"Save As…"];
            [saveAsItem setAction:@selector(performSaveAs:)];        
            [saveAsItem setKeyEquivalent:@"s"];
            [saveAsItem setKeyEquivalentModifierMask:NSCommandKeyMask | NSShiftKeyMask];
            [saveAsItem setHidden:NO];
            
            [fileMenu insertItem:saveAsItem atIndex:saveItemIndex+1];
        }
    }          
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    if ([menuItem action] == @selector(performSaveAs:)) {
        return [self hasActiveDocument];
    }
    return YES;
}

- (IBAction)performSaveAs:(id)sender {
    if ([self hasActiveDocument])
        [[self activeDocument] saveDocumentAs:nil];
}
        
- (NSDocument *)activeDocument {
    NSArray *docs = [NSApp orderedDocuments];
    if (docs == nil || docs.count == 0)
        return nil;
    
    return [docs objectAtIndex:0];
}
        
- (BOOL)hasActiveDocument {
    return [self activeDocument] != nil;
}

+ (void)load {
    SaveAsRedux *redux = [SaveAsRedux sharedInstance];
    [redux installMenuItem];
}

@end
