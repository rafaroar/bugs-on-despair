//
//  Bomb.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "Bomb.h"

@interface Bomb (PrivateMethods)

@end

@implementation Bomb

-(id) initWithBombImage
{
    bomtex = [[CCTextureCache sharedTextureCache] addImage:@"bomb.png"];
    explosion = [[CCTextureCache sharedTextureCache] addImage:@"explo.png"];
    
    (self = [super initWithTexture:bomtex]);
    [self setScale:0.1f];
    return self;
}

-(void)explode:(NSMutableArray *)supplants
{
    [self setTexture: explosion];
    NSMutableArray* allp = [supplants objectAtIndex:0];
    NSMutableArray* darkp = [supplants objectAtIndex:1];
    int num = [allp count];
    for (int chu = 0; chu < num; chu ++)
    {
        CCSprite* item = [allp objectAtIndex:chu];
        int posx =self.position.x - item.position.x;
        int posy =self.position.y - item.position.y;
        if ((posx < 100) && (posx > -100) && (posy > -100) && (posy < 100))
        {
            [darkp addObject: item];
            [allp removeObject: item];
        }
    }
}

@end
