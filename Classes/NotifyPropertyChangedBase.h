//
//  NotifyPropertyChangedBase.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/03.
//
//

#ifndef __BreakBlocks__NotifyPropertyChangedBase__
#define __BreakBlocks__NotifyPropertyChangedBase__

#include <vector>
#include <string>
#include "IPropertyChangedListener.h"
#include "PropertyChangedEventArgs.h"

using namespace std;

class NotifyPropertyChangedBase
{
private:
    template <class T>
    void onPropertyChanged(PropertyChangedEventArgs<T>* e);
    
protected:
    vector<IPropertyChangedListener*> listeners;
    
    void onPropertyChanged(const char* propertyName);
    template <class T>
    void onPropertyChanged(const char* propertyName, T oldValue, T newValue);
    
public:
    virtual ~NotifyPropertyChangedBase();
    
    void addListener(IPropertyChangedListener* listener);
    
};

template <class T>
void NotifyPropertyChangedBase::onPropertyChanged(PropertyChangedEventArgs<T>* e)
{
    for (auto it = this->listeners.begin(); it != this->listeners.end(); it++)
        (*it)->propertyChanged(this, e);
}

template <class T>
void NotifyPropertyChangedBase::onPropertyChanged(const char* propertyName, T oldValue, T newValue)
{
    auto e = new PropertyChangedEventArgs<T>(propertyName, oldValue, newValue);
    this->onPropertyChanged(e);
}

#endif /* defined(__BreakBlocks__NotifyPropertyChangedBase__) */
