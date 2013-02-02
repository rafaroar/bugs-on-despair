//
//  MissilePlant.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface MissilePlant : CCSprite
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
    CCTexture2D* plantex10;
    CCTexture2D* shooting1;
    CCTexture2D* shooting2;
}
@property int grow;
@property int thrower;
-(id) initWithPlantImage;
-(void) growMiss: (NSMutableArray*)throwers;
@end