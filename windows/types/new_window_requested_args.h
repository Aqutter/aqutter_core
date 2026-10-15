#ifndef AQUTTER_CORE_PLUGIN_NEW_WINDOW_REQUESTED_ARGS_H_
#define AQUTTER_CORE_PLUGIN_NEW_WINDOW_REQUESTED_ARGS_H_

#include <WebView2.h>
#include <wil/com.h>

namespace aqutter_core_plugin
{
  class NewWindowRequestedArgs
  {
  public:
    wil::com_ptr<ICoreWebView2NewWindowRequestedEventArgs> args;
    wil::com_ptr<ICoreWebView2Deferral> deferral;

    NewWindowRequestedArgs(wil::com_ptr<ICoreWebView2NewWindowRequestedEventArgs> args, wil::com_ptr<ICoreWebView2Deferral> deferral);
    ~NewWindowRequestedArgs() = default;
  };
}

#endif //AQUTTER_CORE_PLUGIN_NEW_WINDOW_REQUESTED_ARGS_H_