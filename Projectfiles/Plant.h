//
//  Plant.h
//  thelifegame1
//
//  Created by Rafael Rodríguez Arguedas on 22/01/13.
//
//

#import "kobold2d.h"

@interface Plant : CCSprite
{
    CCTexture2D* plantex1;
    CCTexture2D* plantex2;
    CCTexture2D* plantex3;
    CCTexture2D* plantex4;
    CCTexture2D* plantex5;
    CCTexture2D* plantex6;
    CCTexture2D* plantex7;
    CCTexture2D* plantex8;
    CCTexture2D* plantex9;
    CCTexture2D* plantex11;
    CCTexture2D* plantex12;
    CCTexture2D* plantex13;
}
@property int grow;
@property int hunger;
-(id) initWithPlantImage;
-(void) growPlant: (NSMutableArray*)carnivores;
@end
