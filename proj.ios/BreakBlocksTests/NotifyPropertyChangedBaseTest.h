//
//  NotifyPropertyChangedBaseTest.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/04.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "NotifyPropertyChangedBase.h"

@interface NotifyPropertyChangedBaseTest : SenTestCase

@end

class NotifyPropertyChangedMock : public NotifyPropertyChangedBase
{
public:
    void callOnPropertyChanged(const char* propertyName);
    void callOnPropertyChanged(const char* propertyName, float oldValue, float newValue);
    void callOnPropertyChanged(const char* propertyName, const char* oldValue, const char* newValue);
};
