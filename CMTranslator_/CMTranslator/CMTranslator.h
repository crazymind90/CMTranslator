//
//  CMTranslator.h
//  CMTranslator
//
//  Created by @CrazyMind90 on 05/12/2020.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>


@interface CMTranslator : NSViewController

@property (weak) IBOutlet NSTextField *Lang_From;
@property (weak) IBOutlet NSScrollView *Text_From;

@property (weak) IBOutlet NSTextField *Lang_To;
@property (weak) IBOutlet NSScrollView *Text_To;


@property (weak) IBOutlet NSTextField *From_Label;
@property (weak) IBOutlet NSTextField *To_Label;


@property (weak) IBOutlet NSButton *Auto_Lang;

@end

