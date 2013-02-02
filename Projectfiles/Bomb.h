//
//  Bomb.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface Bomb : CCSprite
{
    CCTexture2D* bomtex;
    CCTexture2D* explosion;
}
-(id) initWithBombImage;
-(void)explode: (NSMutableArray*)supplants;
@end