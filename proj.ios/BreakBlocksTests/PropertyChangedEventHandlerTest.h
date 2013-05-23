//
//  PropertyChangedEventHandlerTest.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/19.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "PropertyChangedEventHandler.h"
#import "NotifyPropertyChangedBase.h"

@interface PropertyChangedEventHandlerTest : SenTestCase

@end

class PropertyChangedEventHandlerMock
{
public:
    bool called;
    PropertyChangedEventHandlerMock();
    void propertyChanged(void* sender, PropertyChangedEventArgsBase* e);
};

class NotifyPropertyChangedMock : public NotifyPropertyChangedBase
{
public:
    void callOnPropertyChanged();
};
