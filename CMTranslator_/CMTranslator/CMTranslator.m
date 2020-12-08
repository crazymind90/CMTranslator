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
    From.string = @"Hello world";

    
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
     
    
    NSString *CallLink = nil;
   
    if (_Auto_Lang.state == 1)
    CallLink = [NSString stringWithFormat:@"https://dev.microsofttranslator.com/translate?api-version=3.0&to=%@",_Lang_To.stringValue];
    else
    CallLink = [NSString stringWithFormat:@"https://dev.microsofttranslator.com/translate?api-version=3.0&from=%@&to=%@",_Lang_From.stringValue,_Lang_To.stringValue];


    NSURL *URL = [NSURL URLWithString:CallLink];

    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] init];

    NSString *Parameters = [NSString stringWithFormat:@"[{\"text\" : \"%@\"}]",From.string];

    [Request setHTTPMethod:@"POST"];

    [Request setURL:URL];

    [Request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [Request addValue:@"62fcdf528528442a84ff159d8cb66466" forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [Request addValue:@"A14C9DB9-0DED-48D7-8BBE-C517A1A8DBB0" forHTTPHeaderField:@"X-ClintTraceID"];

    NSData *PostData = [Parameters dataUsingEncoding:NSUTF8StringEncoding];

    [Request setHTTPBody:PostData];

    NSData *_Data = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:nil];
    
    NSMutableArray *Converter = [NSJSONSerialization JSONObjectWithData:_Data options:0 error:nil];
    
    NSDictionary *Dictionay = [Converter firstObject];
    NSString *Translated_Text = Dictionay[@"translations"][0][@"text"];
    
    NSLog(@"Translated_Text === %@",Translated_Text);
    
    if (Translated_Text) {

        To.string = Translated_Text;

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
