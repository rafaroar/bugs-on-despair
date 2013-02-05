//
//  Bomb.m
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 31/01/13.
//
//

#import "Bomb.h"

@interface Bomb (PrivateMethods)

@end

@implementation Bomb

-(id) initWithBombImage
{
    bomtex = [[CCTextureCache sharedTextureCache] addImage:@"bomb.png"];
    
    (self = [super initWithTexture:bomtex]);
    if(!self)
        return nil;
    [self setScale:0.1f];
    return self;
}

@end
