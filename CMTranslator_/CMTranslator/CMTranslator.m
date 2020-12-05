//
//  CMTranslator.m
//  CMTranslator
//
//  Created by @CrazyMind90 on 05/12/2020.
//

#import "CMTranslator.h"
#import <AVKit/AVKit.h>

@implementation CMTranslator

- (void)viewDidLoad {
    [super viewDidLoad];

 
    // From label
    [_From_Label setWantsLayer:YES];
    _From_Label.layer.cornerRadius = 5;
    _From_Label.layer.backgroundColor = NSColor.darkGrayColor.CGColor;
    
    // To label
    [_To_Label setWantsLayer:YES];
    _To_Label.layer.cornerRadius = 5;
    _To_Label.layer.backgroundColor = NSColor.darkGrayColor.CGColor;
    
    NSTextView *From = _Text_From.documentView;
    
    // From text_view
    [_Text_From.contentView setWantsLayer:YES];
    From.alignment = NSTextAlignmentCenter;
    _Text_From.contentView.layer.cornerRadius = 9;
    From.string = @"Hello";

    
    // To text_view
    NSTextView *To = _Text_To.documentView;
    [_Text_To.contentView setWantsLayer:YES];
    To.alignment = NSTextAlignmentCenter;
    _Text_To.contentView.layer.cornerRadius = 9;

    
    //
    [_Lang_From setEnabled:NO];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)Auto_CheckBox:(id)sender {
    
    // Checking if Auto_checkbox isOn
    if (_Auto_Lang.state == 1) {
        
        [_Lang_From setEnabled:NO];
    } else {
        
        [_Lang_From setEnabled:YES];
    }
}


NSTextView *From;
NSTextView *To;

- (IBAction)Trans_Button:(id)sender {
    
    From = _Text_From.documentView;
    To = _Text_To.documentView;
    
    
    NSCharacterSet *NSet = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *From_Text_Encoded = [From.string stringByAddingPercentEncodingWithAllowedCharacters:NSet];
    
    
    
    // Check https://cloud.google.com/translate/docs/setup
    // *It not for free
    NSString *API_Key = @"YOUR_GOOGLE_TRANSLATE_API_KEY";
    
    
    NSString *CallLink = nil;
    
    if (_Auto_Lang.state == 1)
    CallLink = [NSString stringWithFormat:@"https://translation.googleapis.com/language/translate/v2?key=%@&q=%@&target=%@",API_Key,From_Text_Encoded,_Lang_To.stringValue];
    else
    CallLink = [NSString stringWithFormat:@"https://translation.googleapis.com/language/translate/v2?key=%@&q=%@&target=%@&source=%@",API_Key,From_Text_Encoded,_Lang_To.stringValue,_Lang_From.stringValue];


    
          NSURL *URL = [NSURL URLWithString:CallLink];
          NSData *Data = [NSData dataWithContentsOfURL:URL];
          NSDictionary *Finder = [NSJSONSerialization JSONObjectWithData:Data options:0 error:nil];
          NSString *Translated =  Finder[@"data"][@"translations"][0][@"translatedText"];
    
    
    if (Translated) {

        To.string = Translated;

    }
    

}


- (IBAction)speaker:(id)sender {
    
    NSString *Encode_Tras = [To.string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    
  // Audio translate is free
  [CMTranslator PlayAudioFromURL:[NSString stringWithFormat:@"https://translate.google.com/translate_tts?ie=UTF-8&q=%@&tl=%@&textlar=14&client=tw-ob",Encode_Tras,_Lang_To.stringValue]];
}


- (IBAction)CrazyMind90:(id)sender {
     
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://twitter.com/CrazyMind90"]];

}


AVAudioPlayer *AudioPL;
+(void) PlayAudioFromURL:(NSString *_Nullable)URL {
    
    NSURL *url = [NSURL URLWithString:URL];

    NSData *data = [NSData dataWithContentsOfURL:url];

    AudioPL = [[AVAudioPlayer alloc] initWithData:data error:nil];

    [AudioPL play];
    
}



@end
