//
//  main.m
//  LocaleIcon
//
//  Created by Pavel Mazurin on 09/12/2018.
//  Copyright © 2018 Pavel Mazurin. All rights reserved.
//

@import Foundation;
@import Cocoa;
@import Carbon;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        IconRef iconRef;
        NSURL *url;
        TISInputSourceRef currentSource = TISCopyCurrentKeyboardInputSource();
        iconRef = (IconRef)TISGetInputSourceProperty(currentSource, kTISPropertyIconRef);
        if (iconRef==NULL) {
            url = (__bridge NSURL *)(CFURLRef)TISGetInputSourceProperty(currentSource, kTISPropertyIconImageURL);
        }
        NSImage *image = iconRef!=NULL ? [[NSImage alloc] initWithIconRef:iconRef] : [[NSImage alloc] initWithContentsOfURL:url];
        NSData *tiffData = image.TIFFRepresentation;
        NSBitmapImageRep *bitmapRep = [NSBitmapImageRep imageRepWithData:tiffData];
        NSData *pngData = [bitmapRep representationUsingType:NSBitmapImageFileTypePNG
                                                  properties:@{NSImageCompressionFactor: @1}];
        NSString *base64 = [pngData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        printf("%s", [base64 UTF8String]);
    }
    return 0;
}
