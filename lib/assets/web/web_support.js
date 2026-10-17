// src/index.ts
(function() {
  let _JSON_stringify = window.JSON.stringify;
  let _Array_slice = window.Array.prototype.slice;
  _Array_slice.call = window.Function.prototype.call;
  window.aqutterWeb = {
    createAqutterWebView: function(viewId, iframe, iframeContainer, bridgeSecret) {
      const iframeId = iframe.id;
      const webView = {
        viewId,
        iframeId,
        iframe: null,
        iframeContainer: null,
        isFullscreen: false,
        documentTitle: null,
        functionMap: {},
        settings: {},
        javaScriptBridgeEnabled: true,
        disableContextMenuHandler: function(event) {
          event.preventDefault();
          event.stopPropagation();
          return false;
        },
        prepare: function(settings) {
          webView.settings = settings;
          webView.javaScriptBridgeEnabled = webView.settings.javaScriptBridgeEnabled ?? true;
          const javaScriptBridgeOriginAllowList = webView.settings.javaScriptBridgeOriginAllowList;
          if (javaScriptBridgeOriginAllowList != null && !javaScriptBridgeOriginAllowList.includes("*")) {
            if (javaScriptBridgeOriginAllowList.length === 0) {
              webView.javaScriptBridgeEnabled = false;
            }
          }
          document.addEventListener("fullscreenchange", function(event) {
            if (document.fullscreenElement && document.fullscreenElement.id == iframeId) {
              webView.isFullscreen = true;
              _nativeCommunication("onEnterFullscreen", viewId);
            } else if (!document.fullscreenElement && webView.isFullscreen) {
              webView.isFullscreen = false;
              _nativeCommunication("onExitFullscreen", viewId);
            } else {
              webView.isFullscreen = false;
            }
          });
          if (iframe != null) {
            webView.iframe = iframe;
            webView.iframeContainer = iframeContainer;
            iframe.addEventListener("load", function(event) {
              if (iframe.contentWindow == null) {
                return;
              }
              const userScriptsAtStart = _nativeCommunication("getUserOnlyScriptsAt", viewId, [0 /* AT_DOCUMENT_START */]);
              const userScriptsAtEnd = _nativeCommunication("getUserOnlyScriptsAt", viewId, [1 /* AT_DOCUMENT_END */]);
              try {
                let javaScriptBridgeEnabled = webView.javaScriptBridgeEnabled;
                if (javaScriptBridgeOriginAllowList != null) {
                  javaScriptBridgeEnabled = javaScriptBridgeOriginAllowList.map((allowedOriginRule) => new RegExp("^(?:" + allowedOriginRule + ")$")).some((rx) => {
                    return rx.test(iframe.contentWindow.location.origin);
                  });
                }
                if (javaScriptBridgeEnabled) {
                  const javaScriptBridgeName = _nativeCommunication("getJavaScriptBridgeName", viewId);
                  iframe.contentWindow[javaScriptBridgeName] = {
                    callHandler: function() {
                      let origin = "";
                      let requestUrl = "";
                      try {
                        origin = iframe.contentWindow.location.origin;
                      } catch (_) {
                      }
                      try {
                        requestUrl = iframe.contentWindow.location.href;
                      } catch (_) {
                      }
                      return _nativeCommunication(
                        "onCallJsHandler",
                        viewId,
                        [arguments[0], _JSON_stringify({
                          "origin": origin,
                          "requestUrl": requestUrl,
                          "isMainFrame": true,
                          "_bridgeSecret": bridgeSecret,
                          "args": _JSON_stringify(_Array_slice.call(arguments, 1))
                        })]
                      );
                    }
                  };
                }
              } catch (e) {
                console.log(e);
              }
              for (const userScript of [...userScriptsAtStart, ...userScriptsAtEnd]) {
                let ifStatement = "if (";
                let source = userScript.source;
                if (userScript.allowedOriginRules != null && !userScript.allowedOriginRules.includes("*")) {
                  if (userScript.allowedOriginRules.length === 0) {
                    source = "";
                  }
                  let jsRegExpArray = "[";
                  for (const allowedOriginRule of userScript.allowedOriginRules) {
                    if (jsRegExpArray.length > 1) {
                      jsRegExpArray += ",";
                    }
                    jsRegExpArray += `new RegExp('^(?:${allowedOriginRule.replace("'", "\\'")})$')`;
                  }
                  if (jsRegExpArray.length > 1) {
                    jsRegExpArray += "]";
                    ifStatement += `${jsRegExpArray}.some(function(rx) { return rx.test(window.location.origin); })`;
                  }
                }
                webView.evaluateJavascript(ifStatement.length > 4 ? `${ifStatement}) { ${source} }` : source);
              }
              let url = iframe.src;
              try {
                url = iframe.contentWindow.location.href;
              } catch (e) {
                console.log(e);
              }
              _nativeCommunication("onLoadStart", viewId, [url]);
              try {
                const oldLogs = {
                  "log": iframe.contentWindow.console.log,
                  "debug": iframe.contentWindow.console.debug,
                  "error": iframe.contentWindow.console.error,
                  "info": iframe.contentWindow.console.info,
                  "warn": iframe.contentWindow.console.warn
                };
                for (const k in oldLogs) {
                  (function(oldLog) {
                    iframe.contentWindow.console[oldLog] = function() {
                      var message = "";
                      for (var i in arguments) {
                        if (message == "") {
                          message += arguments[i];
                        } else {
                          message += " " + arguments[i];
                        }
                      }
                      oldLogs[oldLog].call(iframe.contentWindow.console, ...arguments);
                      _nativeCommunication("onConsoleMessage", viewId, [oldLog, message]);
                    };
                  })(k);
                }
              } catch (e) {
                console.log(e);
              }
              try {
                const originalPushState = iframe.contentWindow.history.pushState;
                iframe.contentWindow.history.pushState = function(state, unused, url2) {
                  originalPushState.call(iframe.contentWindow.history, state, unused, url2);
                  let iframeUrl = iframe.src;
                  try {
                    iframeUrl = iframe.contentWindow.location.href;
                  } catch (e) {
                    console.log(e);
                  }
                  _nativeCommunication("onUpdateVisitedHistory", viewId, [iframeUrl]);
                };
                const originalReplaceState = iframe.contentWindow.history.replaceState;
                iframe.contentWindow.history.replaceState = function(state, unused, url2) {
                  originalReplaceState.call(iframe.contentWindow.history, state, unused, url2);
                  let iframeUrl = iframe.src;
                  try {
                    iframeUrl = iframe.contentWindow.location.href;
                  } catch (e) {
                    console.log(e);
                  }
                  _nativeCommunication("onUpdateVisitedHistory", viewId, [iframeUrl]);
                };
                const originalClose = iframe.contentWindow.close;
                iframe.contentWindow.close = function() {
                  originalClose.call(iframe.contentWindow);
                  _nativeCommunication("onCloseWindow", viewId);
                };
                const originalOpen = iframe.contentWindow.open;
                iframe.contentWindow.open = function(url2, target, windowFeatures) {
                  const newWindow = originalOpen.call(iframe.contentWindow, ...arguments);
                  _nativeCommunication("onCreateWindow", viewId, [url2, target, windowFeatures]).then(function(handledByClient) {
                    if (handledByClient) {
                      newWindow?.close();
                    }
                  });
                  return newWindow;
                };
                const originalPrint = iframe.contentWindow.print;
                iframe.contentWindow.print = function() {
                  let iframeUrl = iframe.src;
                  try {
                    iframeUrl = iframe.contentWindow.location.href;
                  } catch (e) {
                    console.log(e);
                  }
                  _nativeCommunication("onPrintRequest", viewId, [iframeUrl]);
                  originalPrint.call(iframe.contentWindow);
                };
                webView.functionMap = {
                  "window.open": iframe.contentWindow.open
                };
                const initialTitle = iframe.contentDocument?.title;
                const titleEl = iframe.contentDocument?.querySelector("title");
                webView.documentTitle = initialTitle;
                _nativeCommunication("onTitleChanged", viewId, [initialTitle]);
                if (titleEl != null) {
                  new MutationObserver(function(mutations) {
                    const title = mutations[0].target.innerText;
                    if (title != webView.documentTitle) {
                      webView.documentTitle = title;
                      _nativeCommunication("onTitleChanged", viewId, [title]);
                    }
                  }).observe(
                    titleEl,
                    { subtree: true, characterData: true, childList: true }
                  );
                }
                let oldPixelRatio = iframe.contentWindow.devicePixelRatio;
                iframe.contentWindow.addEventListener("resize", function(e) {
                  const newPixelRatio = iframe.contentWindow.devicePixelRatio;
                  if (newPixelRatio !== oldPixelRatio) {
                    _nativeCommunication("onZoomScaleChanged", viewId, [oldPixelRatio, newPixelRatio]);
                    oldPixelRatio = newPixelRatio;
                  }
                });
                iframe.contentWindow.addEventListener("popstate", function(event2) {
                  let iframeUrl = iframe.src;
                  try {
                    iframeUrl = iframe.contentWindow.location.href;
                  } catch (e) {
                    console.log(e);
                  }
                  _nativeCommunication("onUpdateVisitedHistory", viewId, [iframeUrl]);
                });
                iframe.contentWindow.addEventListener("scroll", function(event2) {
                  let x = 0;
                  let y = 0;
                  try {
                    x = iframe.contentWindow.scrollX;
                    y = iframe.contentWindow.scrollY;
                  } catch (e) {
                    console.log(e);
                  }
                  _nativeCommunication("onScrollChanged", viewId, [x, y]);
                });
                iframe.contentWindow.addEventListener("focus", function(event2) {
                  _nativeCommunication("onWindowFocus", viewId);
                });
                iframe.contentWindow.addEventListener("blur", function(event2) {
                  _nativeCommunication("onWindowBlur", viewId);
                });
              } catch (e) {
                console.log(e);
              }
              try {
                if (!webView.settings.javaScriptCanOpenWindowsAutomatically) {
                  iframe.contentWindow.open = function() {
                    throw new Error("JavaScript cannot open windows automatically");
                  };
                }
                if (!webView.settings.verticalScrollBarEnabled && !webView.settings.horizontalScrollBarEnabled) {
                  const style = iframe.contentDocument?.createElement("style");
                  if (style != null) {
                    style.id = "settings.verticalScrollBarEnabled-settings.horizontalScrollBarEnabled";
                    style.innerHTML = "body::-webkit-scrollbar { width: 0px; height: 0px; }";
                    iframe.contentDocument?.head.append(style);
                  }
                }
                if (webView.settings.disableVerticalScroll) {
                  const style = iframe.contentDocument?.createElement("style");
                  if (style != null) {
                    style.id = "settings.disableVerticalScroll";
                    style.innerHTML = "body { overflow-y: hidden; }";
                    iframe.contentDocument?.head.append(style);
                  }
                }
                if (webView.settings.disableHorizontalScroll) {
                  const style = iframe.contentDocument?.createElement("style");
                  if (style != null) {
                    style.id = "settings.disableHorizontalScroll";
                    style.innerHTML = "body { overflow-x: hidden; }";
                    iframe.contentDocument?.head.append(style);
                  }
                }
                if (webView.settings.disableContextMenu) {
                  iframe.contentWindow.addEventListener("contextmenu", webView.disableContextMenuHandler);
                }
              } catch (e) {
                console.log(e);
              }
              _nativeCommunication("onLoadStop", viewId, [url]);
              try {
                iframe.contentWindow.dispatchEvent(new Event("aqutterPlatformReady"));
              } catch (e) {
                console.log(e);
              }
            });
          }
        },
        setSettings: function(newSettings) {
          const iframe2 = webView.iframe;
          if (iframe2 == null) {
            return;
          }
          try {
            if (webView.settings.javaScriptCanOpenWindowsAutomatically != newSettings.javaScriptCanOpenWindowsAutomatically) {
              if (!newSettings.javaScriptCanOpenWindowsAutomatically) {
                iframe2.contentWindow.open = function() {
                  throw new Error("JavaScript cannot open windows automatically");
                };
              } else {
                iframe2.contentWindow.open = webView.functionMap["window.open"];
              }
            }
            if (webView.settings.verticalScrollBarEnabled != newSettings.verticalScrollBarEnabled && webView.settings.horizontalScrollBarEnabled != newSettings.horizontalScrollBarEnabled) {
              if (!newSettings.verticalScrollBarEnabled && !newSettings.horizontalScrollBarEnabled) {
                const style = iframe2.contentDocument?.createElement("style");
                if (style != null) {
                  style.id = "settings.verticalScrollBarEnabled-settings.horizontalScrollBarEnabled";
                  style.innerHTML = "body::-webkit-scrollbar { width: 0px; height: 0px; }";
                  iframe2.contentDocument?.head.append(style);
                }
              } else {
                const styleElement = iframe2.contentDocument?.getElementById("settings.verticalScrollBarEnabled-settings.horizontalScrollBarEnabled");
                if (styleElement) {
                  styleElement.remove();
                }
              }
            }
            if (webView.settings.disableVerticalScroll != newSettings.disableVerticalScroll) {
              if (newSettings.disableVerticalScroll) {
                const style = iframe2.contentDocument?.createElement("style");
                if (style != null) {
                  style.id = "settings.disableVerticalScroll";
                  style.innerHTML = "body { overflow-y: hidden; }";
                  iframe2.contentDocument?.head.append(style);
                }
              } else {
                const styleElement = iframe2.contentDocument?.getElementById("settings.disableVerticalScroll");
                if (styleElement) {
                  styleElement.remove();
                }
              }
            }
            if (webView.settings.disableHorizontalScroll != newSettings.disableHorizontalScroll) {
              if (newSettings.disableHorizontalScroll) {
                const style = iframe2.contentDocument?.createElement("style");
                if (style != null) {
                  style.id = "settings.disableHorizontalScroll";
                  style.innerHTML = "body { overflow-x: hidden; }";
                  iframe2.contentDocument?.head.append(style);
                }
              } else {
                const styleElement = iframe2.contentDocument?.getElementById("settings.disableHorizontalScroll");
                if (styleElement) {
                  styleElement.remove();
                }
              }
            }
            if (webView.settings.disableContextMenu != newSettings.disableContextMenu) {
              if (newSettings.disableContextMenu) {
                iframe2.contentWindow?.addEventListener("contextmenu", webView.disableContextMenuHandler);
              } else {
                iframe2.contentWindow?.removeEventListener("contextmenu", webView.disableContextMenuHandler);
              }
            }
          } catch (e) {
            console.log(e);
          }
          webView.settings = newSettings;
        },
        reload: function() {
          var iframe2 = webView.iframe;
          if (iframe2 != null && iframe2.contentWindow != null) {
            try {
              iframe2.contentWindow.location.reload();
            } catch (e) {
              console.log(e);
              iframe2.contentWindow.location.href = iframe2.src;
            }
          }
        },
        goBack: function() {
          var iframe2 = webView.iframe;
          if (iframe2 != null) {
            try {
              iframe2.contentWindow?.history.back();
            } catch (e) {
              console.log(e);
            }
          }
        },
        goForward: function() {
          var iframe2 = webView.iframe;
          if (iframe2 != null) {
            try {
              iframe2.contentWindow?.history.forward();
            } catch (e) {
              console.log(e);
            }
          }
        },
        goBackOrForward: function(steps) {
          var iframe2 = webView.iframe;
          if (iframe2 != null) {
            try {
              iframe2.contentWindow?.history.go(steps);
            } catch (e) {
              console.log(e);
            }
          }
        },
        evaluateJavascript: function(source) {
          const iframe2 = webView.iframe;
          let result = null;
          if (iframe2 != null) {
            try {
              result = JSON.stringify(iframe2.contentWindow?.eval(source));
            } catch (e) {
            }
          }
          return result;
        },
        stopLoading: function() {
          const iframe2 = webView.iframe;
          if (iframe2 != null) {
            try {
              iframe2.contentWindow?.stop();
            } catch (e) {
              console.log(e);
            }
          }
        },
        getUrl: function() {
          const iframe2 = webView.iframe;
          let url = iframe2?.src;
          try {
            url = iframe2?.contentWindow?.location.href;
          } catch (e) {
            console.log(e);
          }
          return url;
        },
        getTitle: function() {
          const iframe2 = webView.iframe;
          let title = null;
          try {
            title = iframe2?.contentDocument?.title;
          } catch (e) {
            console.log(e);
          }
          return title;
        },
        injectJavascriptFileFromUrl: function(urlFile, scriptHtmlTagAttributes) {
          const iframe2 = webView.iframe;
          try {
            const d = iframe2?.contentDocument;
            if (d == null) {
              return;
            }
            const script = d.createElement("script");
            for (const key of Object.keys(scriptHtmlTagAttributes)) {
              if (scriptHtmlTagAttributes[key] != null) {
                script[key] = scriptHtmlTagAttributes[key];
              }
            }
            if (script.id != null) {
              script.onload = function() {
                _nativeCommunication("onInjectedScriptLoaded", webView.viewId, [script.id]);
              };
              script.onerror = function() {
                _nativeCommunication("onInjectedScriptError", webView.viewId, [script.id]);
              };
            }
            script.src = urlFile;
            if (d.body != null) {
              d.body.appendChild(script);
            }
          } catch (e) {
            console.log(e);
          }
        },
        injectCSSCode: function(source) {
          const iframe2 = webView.iframe;
          try {
            const d = iframe2?.contentDocument;
            if (d == null) {
              return;
            }
            const style = d.createElement("style");
            style.innerHTML = source;
            if (d.head != null) {
              d.head.appendChild(style);
            }
          } catch (e) {
            console.log(e);
          }
        },
        injectCSSFileFromUrl: function(urlFile, cssLinkHtmlTagAttributes) {
          const iframe2 = webView.iframe;
          try {
            const d = iframe2?.contentDocument;
            if (d == null) {
              return;
            }
            const link = d.createElement("link");
            for (const key of Object.keys(cssLinkHtmlTagAttributes)) {
              if (cssLinkHtmlTagAttributes[key] != null) {
                link[key] = cssLinkHtmlTagAttributes[key];
              }
            }
            link.type = "text/css";
            var alternateStylesheet = "";
            if (cssLinkHtmlTagAttributes.alternateStylesheet) {
              alternateStylesheet = "alternate ";
            }
            link.rel = alternateStylesheet + "stylesheet";
            link.href = urlFile;
            if (d.head != null) {
              d.head.appendChild(link);
            }
          } catch (e) {
            console.log(e);
          }
        },
        scrollTo: function(x, y, animated) {
          const iframe2 = webView.iframe;
          try {
            if (animated) {
              iframe2?.contentWindow?.scrollTo({ top: y, left: x, behavior: "smooth" });
            } else {
              iframe2?.contentWindow?.scrollTo(x, y);
            }
          } catch (e) {
            console.log(e);
          }
        },
        scrollBy: function(x, y, animated) {
          const iframe2 = webView.iframe;
          try {
            if (animated) {
              iframe2?.contentWindow?.scrollBy({ top: y, left: x, behavior: "smooth" });
            } else {
              iframe2?.contentWindow?.scrollBy(x, y);
            }
          } catch (e) {
            console.log(e);
          }
        },
        printCurrentPage: function() {
          const iframe2 = webView.iframe;
          try {
            iframe2?.contentWindow?.print();
          } catch (e) {
            console.log(e);
          }
        },
        getContentHeight: function() {
          const iframe2 = webView.iframe;
          try {
            return iframe2?.contentDocument?.documentElement.scrollHeight;
          } catch (e) {
            console.log(e);
          }
          return null;
        },
        getContentWidth: function() {
          const iframe2 = webView.iframe;
          try {
            return iframe2?.contentDocument?.documentElement.scrollWidth;
          } catch (e) {
            console.log(e);
          }
          return null;
        },
        getSelectedText: function() {
          const iframe2 = webView.iframe;
          try {
            let txt;
            const w = iframe2?.contentWindow;
            if (w == null) {
              return null;
            }
            if (w.getSelection) {
              txt = w.getSelection()?.toString();
            } else if (w.document.getSelection) {
              txt = w.document.getSelection()?.toString();
            } else if (w.document.selection) {
              txt = w.document.selection.createRange().text;
            }
            return txt;
          } catch (e) {
            console.log(e);
          }
          return null;
        },
        getScrollX: function() {
          const iframe2 = webView.iframe;
          try {
            return iframe2?.contentWindow?.scrollX;
          } catch (e) {
            console.log(e);
          }
          return null;
        },
        getScrollY: function() {
          const iframe2 = webView.iframe;
          try {
            return iframe2?.contentWindow?.scrollY;
          } catch (e) {
            console.log(e);
          }
          return null;
        },
        isSecureContext: function() {
          const iframe2 = webView.iframe;
          try {
            return iframe2?.contentWindow?.isSecureContext ?? false;
          } catch (e) {
            console.log(e);
          }
          return false;
        },
        canScrollVertically: function() {
          const iframe2 = webView.iframe;
          try {
            return (iframe2?.contentDocument?.body.scrollHeight ?? 0) > (iframe2?.contentWindow?.innerHeight ?? 0);
          } catch (e) {
            console.log(e);
          }
          return false;
        },
        canScrollHorizontally: function() {
          const iframe2 = webView.iframe;
          try {
            return (iframe2?.contentDocument?.body.scrollWidth ?? 0) > (iframe2?.contentWindow?.innerWidth ?? 0);
          } catch (e) {
            console.log(e);
          }
          return false;
        },
        getSize: function() {
          const iframeContainer2 = webView.iframeContainer;
          let width = 0;
          let height = 0;
          if (iframeContainer2 != null) {
            if (iframeContainer2.style.width != null && iframeContainer2.style.width != "" && iframeContainer2.style.width.indexOf("px") > 0) {
              width = parseFloat(iframeContainer2.style.width);
            }
            if (width == null || width == 0) {
              width = iframeContainer2.getBoundingClientRect().width;
            }
            if (iframeContainer2.style.height != null && iframeContainer2.style.height != "" && iframeContainer2.style.height.indexOf("px") > 0) {
              height = parseFloat(iframeContainer2.style.height);
            }
            if (height == null || height == 0) {
              height = iframeContainer2.getBoundingClientRect().height;
            }
          }
          return {
            width,
            height
          };
        }
      };
      return webView;
    },
    getCookieExpirationDate: function(timestamp) {
      return new Date(timestamp).toUTCString();
    },
    nativeAsyncCommunication: function(method, viewId, args) {
      throw new Error("Method not implemented.");
    },
    nativeSyncCommunication: function(method, viewId, args) {
      throw new Error("Method not implemented.");
    },
    nativeCommunication: function(method, viewId, args) {
      try {
        const result = window.aqutterWeb.nativeSyncCommunication(method, viewId, args);
        return result != null ? JSON.parse(result) : null;
      } catch (e1) {
        try {
          const promise = window.aqutterWeb.nativeAsyncCommunication(method, viewId, args);
          return promise.then(function(result) {
            return result != null ? JSON.parse(result) : null;
          });
        } catch (e2) {
          return null;
        }
      }
    }
  };
  let _nativeCommunication = window.aqutterWeb.nativeCommunication;
})();
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsiLi4vLi4vLi4vd2ViX3N1cHBvcnQvc3JjL2luZGV4LnRzIl0sCiAgInNvdXJjZXNDb250ZW50IjogWyJpbXBvcnQge1xuICBBcXV0dGVyV2ViVmlldyxcbiAgQXF1dHRlcldlYlZpZXdQbHVnaW4sXG4gIEFxdXR0ZXJXZWJWaWV3U2V0dGluZ3MsXG4gIEphdmFTY3JpcHRCcmlkZ2VIYW5kbGVyLFxuICBVc2VyU2NyaXB0LFxuICBVc2VyU2NyaXB0SW5qZWN0aW9uVGltZVxufSBmcm9tIFwiLi90eXBlc1wiO1xuXG5kZWNsYXJlIGdsb2JhbCB7XG4gIGludGVyZmFjZSBXaW5kb3cge1xuICAgIGFxdXR0ZXJXZWI6IEFxdXR0ZXJXZWJWaWV3UGx1Z2luO1xuICAgIGFxdXR0ZXI/OiBKYXZhU2NyaXB0QnJpZGdlSGFuZGxlciB8IG51bGw7XG4gICAgY29uc29sZTogQ29uc29sZTtcblxuICAgIGV2YWwoeDogc3RyaW5nKTogYW55O1xuICB9XG59XG5cbihmdW5jdGlvbiAoKSB7XG4gIGxldCBfSlNPTl9zdHJpbmdpZnkgPSB3aW5kb3cuSlNPTi5zdHJpbmdpZnk7XG4gIGxldCBfQXJyYXlfc2xpY2UgPSB3aW5kb3cuQXJyYXkucHJvdG90eXBlLnNsaWNlO1xuICBfQXJyYXlfc2xpY2UuY2FsbCA9IHdpbmRvdy5GdW5jdGlvbi5wcm90b3R5cGUuY2FsbDtcblxuICB3aW5kb3cuYXF1dHRlcldlYiA9IHtcbiAgICBjcmVhdGVBcXV0dGVyV2ViVmlldzogZnVuY3Rpb24gKHZpZXdJZDogbnVtYmVyIHwgc3RyaW5nLCBpZnJhbWU6IEhUTUxJRnJhbWVFbGVtZW50LCBpZnJhbWVDb250YWluZXI6IEhUTUxEaXZFbGVtZW50LCBicmlkZ2VTZWNyZXQ6IHN0cmluZykge1xuICAgICAgY29uc3QgaWZyYW1lSWQgPSBpZnJhbWUuaWQ7XG4gICAgICBjb25zdCB3ZWJWaWV3OiBBcXV0dGVyV2ViVmlldyA9IHtcbiAgICAgICAgdmlld0lkOiB2aWV3SWQsXG4gICAgICAgIGlmcmFtZUlkOiBpZnJhbWVJZCxcbiAgICAgICAgaWZyYW1lOiBudWxsLFxuICAgICAgICBpZnJhbWVDb250YWluZXI6IG51bGwsXG4gICAgICAgIGlzRnVsbHNjcmVlbjogZmFsc2UsXG4gICAgICAgIGRvY3VtZW50VGl0bGU6IG51bGwsXG4gICAgICAgIGZ1bmN0aW9uTWFwOiB7fSxcbiAgICAgICAgc2V0dGluZ3M6IHt9LFxuICAgICAgICBqYXZhU2NyaXB0QnJpZGdlRW5hYmxlZDogdHJ1ZSxcbiAgICAgICAgZGlzYWJsZUNvbnRleHRNZW51SGFuZGxlcjogZnVuY3Rpb24gKGV2ZW50OiBFdmVudCkge1xuICAgICAgICAgIGV2ZW50LnByZXZlbnREZWZhdWx0KCk7XG4gICAgICAgICAgZXZlbnQuc3RvcFByb3BhZ2F0aW9uKCk7XG4gICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICB9LFxuICAgICAgICBwcmVwYXJlOiBmdW5jdGlvbiAoc2V0dGluZ3M6IEFxdXR0ZXJXZWJWaWV3U2V0dGluZ3MpIHtcbiAgICAgICAgICB3ZWJWaWV3LnNldHRpbmdzID0gc2V0dGluZ3M7XG5cbiAgICAgICAgICB3ZWJWaWV3LmphdmFTY3JpcHRCcmlkZ2VFbmFibGVkID0gd2ViVmlldy5zZXR0aW5ncy5qYXZhU2NyaXB0QnJpZGdlRW5hYmxlZCA/PyB0cnVlO1xuICAgICAgICAgIGNvbnN0IGphdmFTY3JpcHRCcmlkZ2VPcmlnaW5BbGxvd0xpc3QgPSB3ZWJWaWV3LnNldHRpbmdzLmphdmFTY3JpcHRCcmlkZ2VPcmlnaW5BbGxvd0xpc3Q7XG4gICAgICAgICAgaWYgKGphdmFTY3JpcHRCcmlkZ2VPcmlnaW5BbGxvd0xpc3QgIT0gbnVsbCAmJiAhamF2YVNjcmlwdEJyaWRnZU9yaWdpbkFsbG93TGlzdC5pbmNsdWRlcyhcIipcIikpIHtcbiAgICAgICAgICAgIGlmIChqYXZhU2NyaXB0QnJpZGdlT3JpZ2luQWxsb3dMaXN0Lmxlbmd0aCA9PT0gMCkge1xuICAgICAgICAgICAgICAvLyBhbiBlbXB0eSBsaXN0IG1lYW5zIHRoYXQgdGhlIEphdmFTY3JpcHQgQnJpZGdlIGlzIG5vdCBhbGxvd2VkIGZvciBhbnkgb3JpZ2luLlxuICAgICAgICAgICAgICB3ZWJWaWV3LmphdmFTY3JpcHRCcmlkZ2VFbmFibGVkID0gZmFsc2U7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgfVxuXG4gICAgICAgICAgZG9jdW1lbnQuYWRkRXZlbnRMaXN0ZW5lcignZnVsbHNjcmVlbmNoYW5nZScsIGZ1bmN0aW9uIChldmVudDogRXZlbnQpIHtcbiAgICAgICAgICAgIC8vIGRvY3VtZW50LmZ1bGxzY3JlZW5FbGVtZW50IHdpbGwgcG9pbnQgdG8gdGhlIGVsZW1lbnQgdGhhdFxuICAgICAgICAgICAgLy8gaXMgaW4gZnVsbHNjcmVlbiBtb2RlIGlmIHRoZXJlIGlzIG9uZS4gSWYgdGhlcmUgaXNuJ3Qgb25lLFxuICAgICAgICAgICAgLy8gdGhlIHZhbHVlIG9mIHRoZSBwcm9wZXJ0eSBpcyBudWxsLlxuICAgICAgICAgICAgaWYgKGRvY3VtZW50LmZ1bGxzY3JlZW5FbGVtZW50ICYmIGRvY3VtZW50LmZ1bGxzY3JlZW5FbGVtZW50LmlkID09IGlmcmFtZUlkKSB7XG4gICAgICAgICAgICAgIHdlYlZpZXcuaXNGdWxsc2NyZWVuID0gdHJ1ZTtcbiAgICAgICAgICAgICAgX25hdGl2ZUNvbW11bmljYXRpb24oJ29uRW50ZXJGdWxsc2NyZWVuJywgdmlld0lkKTtcbiAgICAgICAgICAgIH0gZWxzZSBpZiAoIWRvY3VtZW50LmZ1bGxzY3JlZW5FbGVtZW50ICYmIHdlYlZpZXcuaXNGdWxsc2NyZWVuKSB7XG4gICAgICAgICAgICAgIHdlYlZpZXcuaXNGdWxsc2NyZWVuID0gZmFsc2U7XG4gICAgICAgICAgICAgIF9uYXRpdmVDb21tdW5pY2F0aW9uKCdvbkV4aXRGdWxsc2NyZWVuJywgdmlld0lkKTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgIHdlYlZpZXcuaXNGdWxsc2NyZWVuID0gZmFsc2U7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgfSk7XG5cbiAgICAgICAgICBpZiAoaWZyYW1lICE9IG51bGwpIHtcbiAgICAgICAgICAgIHdlYlZpZXcuaWZyYW1lID0gaWZyYW1lO1xuICAgICAgICAgICAgd2ViVmlldy5pZnJhbWVDb250YWluZXIgPSBpZnJhbWVDb250YWluZXI7XG4gICAgICAgICAgICBpZnJhbWUuYWRkRXZlbnRMaXN0ZW5lcignbG9hZCcsIGZ1bmN0aW9uIChldmVudDogRXZlbnQpIHtcbiAgICAgICAgICAgICAgaWYgKGlmcmFtZS5jb250ZW50V2luZG93ID09IG51bGwpIHtcbiAgICAgICAgICAgICAgICByZXR1cm47XG4gICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICBjb25zdCB1c2VyU2NyaXB0c0F0U3RhcnQgPSBfbmF0aXZlQ29tbXVuaWNhdGlvbjxVc2VyU2NyaXB0W10+KCdnZXRVc2VyT25seVNjcmlwdHNBdCcsIHZpZXdJZCwgW1VzZXJTY3JpcHRJbmplY3Rpb25UaW1lLkFUX0RPQ1VNRU5UX1NUQVJUXSk7XG4gICAgICAgICAgICAgIGNvbnN0IHVzZXJTY3JpcHRzQXRFbmQgPSBfbmF0aXZlQ29tbXVuaWNhdGlvbjxVc2VyU2NyaXB0W10+KCdnZXRVc2VyT25seVNjcmlwdHNBdCcsIHZpZXdJZCwgW1VzZXJTY3JpcHRJbmplY3Rpb25UaW1lLkFUX0RPQ1VNRU5UX0VORF0pO1xuXG4gICAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgICAgbGV0IGphdmFTY3JpcHRCcmlkZ2VFbmFibGVkID0gd2ViVmlldy5qYXZhU2NyaXB0QnJpZGdlRW5hYmxlZDtcbiAgICAgICAgICAgICAgICBpZiAoamF2YVNjcmlwdEJyaWRnZU9yaWdpbkFsbG93TGlzdCAhPSBudWxsKSB7XG4gICAgICAgICAgICAgICAgICBqYXZhU2NyaXB0QnJpZGdlRW5hYmxlZCA9IGphdmFTY3JpcHRCcmlkZ2VPcmlnaW5BbGxvd0xpc3RcbiAgICAgICAgICAgICAgICAgICAgICAvLyBcdTgyMDcgQW5kcm9pZCBcdTc2ODRcdTVCOENcdTY1NzRcdTZCRDRcdTVDMERcdUZGMDhtYXRjaGVyLm1hdGNoZXMoKVx1RkYwOVx1NEUwMFx1ODFGNFx1RkYxQVx1ODk4Rlx1NTI0N1x1NUZDNVx1OTgwOFx1NTQzQlx1NTQwOFx1NjU3NFx1NTAwQiBvcmlnaW5cdUZGMENcdTgwMENcdTRFMERcdTY2MkZcdTUxNzZcdTRFMkRcdTRFMDBcdTZCQjVcbiAgICAgICAgICAgICAgICAgICAgICAubWFwKGFsbG93ZWRPcmlnaW5SdWxlID0+IG5ldyBSZWdFeHAoJ14oPzonICsgYWxsb3dlZE9yaWdpblJ1bGUgKyAnKSQnKSlcbiAgICAgICAgICAgICAgICAgICAgICAuc29tZSgocngpID0+IHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByeC50ZXN0KGlmcmFtZS5jb250ZW50V2luZG93IS5sb2NhdGlvbi5vcmlnaW4pO1xuICAgICAgICAgICAgICAgICAgICAgIH0pXG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIGlmIChqYXZhU2NyaXB0QnJpZGdlRW5hYmxlZCkge1xuICAgICAgICAgICAgICAgICAgY29uc3QgamF2YVNjcmlwdEJyaWRnZU5hbWUgPSBfbmF0aXZlQ29tbXVuaWNhdGlvbjxzdHJpbmc+KCdnZXRKYXZhU2NyaXB0QnJpZGdlTmFtZScsIHZpZXdJZCk7XG4gICAgICAgICAgICAgICAgICAvLyBAdHMtaWdub3JlXG4gICAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdyFbamF2YVNjcmlwdEJyaWRnZU5hbWVdID0ge1xuICAgICAgICAgICAgICAgICAgICBjYWxsSGFuZGxlcjogZnVuY3Rpb24gKCkge1xuICAgICAgICAgICAgICAgICAgICAgIGxldCBvcmlnaW4gPSAnJztcbiAgICAgICAgICAgICAgICAgICAgICBsZXQgcmVxdWVzdFVybCA9ICcnO1xuICAgICAgICAgICAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBvcmlnaW4gPSBpZnJhbWUuY29udGVudFdpbmRvdyEubG9jYXRpb24ub3JpZ2luO1xuICAgICAgICAgICAgICAgICAgICAgIH0gY2F0Y2ggKF8pIHtcbiAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHJlcXVlc3RVcmwgPSBpZnJhbWUuY29udGVudFdpbmRvdyEubG9jYXRpb24uaHJlZjtcbiAgICAgICAgICAgICAgICAgICAgICB9IGNhdGNoIChfKSB7XG4gICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25DYWxsSnNIYW5kbGVyJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgdmlld0lkLFxuICAgICAgICAgICAgICAgICAgICAgICAgICBbYXJndW1lbnRzWzBdLCBfSlNPTl9zdHJpbmdpZnkoe1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICdvcmlnaW4nOiBvcmlnaW4sXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3JlcXVlc3RVcmwnOiByZXF1ZXN0VXJsLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICdpc01haW5GcmFtZSc6IHRydWUsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgJ19icmlkZ2VTZWNyZXQnOiBicmlkZ2VTZWNyZXQsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgJ2FyZ3MnOiBfSlNPTl9zdHJpbmdpZnkoX0FycmF5X3NsaWNlLmNhbGwoYXJndW1lbnRzLCAxKSlcbiAgICAgICAgICAgICAgICAgICAgICAgICAgfSldKTtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgfSBhcyBKYXZhU2NyaXB0QnJpZGdlSGFuZGxlcjtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgIGZvciAoY29uc3QgdXNlclNjcmlwdCBvZiBbLi4udXNlclNjcmlwdHNBdFN0YXJ0LCAuLi51c2VyU2NyaXB0c0F0RW5kXSkge1xuICAgICAgICAgICAgICAgIGxldCBpZlN0YXRlbWVudCA9IFwiaWYgKFwiO1xuICAgICAgICAgICAgICAgIGxldCBzb3VyY2UgPSB1c2VyU2NyaXB0LnNvdXJjZTtcbiAgICAgICAgICAgICAgICBpZiAodXNlclNjcmlwdC5hbGxvd2VkT3JpZ2luUnVsZXMgIT0gbnVsbCAmJiAhdXNlclNjcmlwdC5hbGxvd2VkT3JpZ2luUnVsZXMuaW5jbHVkZXMoXCIqXCIpKSB7XG4gICAgICAgICAgICAgICAgICBpZiAodXNlclNjcmlwdC5hbGxvd2VkT3JpZ2luUnVsZXMubGVuZ3RoID09PSAwKSB7XG4gICAgICAgICAgICAgICAgICAgIC8vIHJldHVybiBlbXB0eSBzb3VyY2Ugc3RyaW5nIGlmIGFsbG93ZWRPcmlnaW5SdWxlcyBpcyBhbiBlbXB0eSBsaXN0LlxuICAgICAgICAgICAgICAgICAgICAvLyBhbiBlbXB0eSBsaXN0IG1lYW5zIHRoYXQgdGhpcyBVc2VyU2NyaXB0IGlzIG5vdCBhbGxvd2VkIGZvciBhbnkgb3JpZ2luLlxuICAgICAgICAgICAgICAgICAgICBzb3VyY2UgPSBcIlwiO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgbGV0IGpzUmVnRXhwQXJyYXkgPSBcIltcIjtcbiAgICAgICAgICAgICAgICAgIGZvciAoY29uc3QgYWxsb3dlZE9yaWdpblJ1bGUgb2YgdXNlclNjcmlwdC5hbGxvd2VkT3JpZ2luUnVsZXMpIHtcbiAgICAgICAgICAgICAgICAgICAgaWYgKGpzUmVnRXhwQXJyYXkubGVuZ3RoID4gMSkge1xuICAgICAgICAgICAgICAgICAgICAgIGpzUmVnRXhwQXJyYXkgKz0gXCIsXCI7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAganNSZWdFeHBBcnJheSArPSBgbmV3IFJlZ0V4cCgnXig/OiR7YWxsb3dlZE9yaWdpblJ1bGUucmVwbGFjZShcIlxcJ1wiLCBcIlxcXFwnXCIpfSkkJylgO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgaWYgKGpzUmVnRXhwQXJyYXkubGVuZ3RoID4gMSkge1xuICAgICAgICAgICAgICAgICAgICBqc1JlZ0V4cEFycmF5ICs9IFwiXVwiO1xuICAgICAgICAgICAgICAgICAgICBpZlN0YXRlbWVudCArPSBgJHtqc1JlZ0V4cEFycmF5fS5zb21lKGZ1bmN0aW9uKHJ4KSB7IHJldHVybiByeC50ZXN0KHdpbmRvdy5sb2NhdGlvbi5vcmlnaW4pOyB9KWA7XG4gICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIHdlYlZpZXcuZXZhbHVhdGVKYXZhc2NyaXB0KGlmU3RhdGVtZW50Lmxlbmd0aCA+IDQgPyBgJHtpZlN0YXRlbWVudH0pIHsgJHtzb3VyY2V9IH1gIDogc291cmNlKTtcbiAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgIGxldCB1cmwgPSBpZnJhbWUuc3JjO1xuICAgICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICAgIHVybCA9IGlmcmFtZS5jb250ZW50V2luZG93LmxvY2F0aW9uLmhyZWY7XG4gICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25Mb2FkU3RhcnQnLCB2aWV3SWQsIFt1cmxdKTtcblxuICAgICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICAgIGNvbnN0IG9sZExvZ3MgPSB7XG4gICAgICAgICAgICAgICAgICAnbG9nJzogaWZyYW1lLmNvbnRlbnRXaW5kb3cuY29uc29sZS5sb2csXG4gICAgICAgICAgICAgICAgICAnZGVidWcnOiBpZnJhbWUuY29udGVudFdpbmRvdy5jb25zb2xlLmRlYnVnLFxuICAgICAgICAgICAgICAgICAgJ2Vycm9yJzogaWZyYW1lLmNvbnRlbnRXaW5kb3cuY29uc29sZS5lcnJvcixcbiAgICAgICAgICAgICAgICAgICdpbmZvJzogaWZyYW1lLmNvbnRlbnRXaW5kb3cuY29uc29sZS5pbmZvLFxuICAgICAgICAgICAgICAgICAgJ3dhcm4nOiBpZnJhbWUuY29udGVudFdpbmRvdy5jb25zb2xlLndhcm5cbiAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICAgIGZvciAoY29uc3QgayBpbiBvbGRMb2dzKSB7XG4gICAgICAgICAgICAgICAgICAoZnVuY3Rpb24gKG9sZExvZykge1xuICAgICAgICAgICAgICAgICAgICAvLyBAdHMtaWdub3JlXG4gICAgICAgICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93LmNvbnNvbGVbb2xkTG9nXSA9IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICAgICAgICAgICAgICB2YXIgbWVzc2FnZSA9ICcnO1xuICAgICAgICAgICAgICAgICAgICAgIGZvciAodmFyIGkgaW4gYXJndW1lbnRzKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBpZiAobWVzc2FnZSA9PSAnJykge1xuICAgICAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlICs9IGFyZ3VtZW50c1tpXTtcbiAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2UgKz0gJyAnICsgYXJndW1lbnRzW2ldO1xuICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAvLyBAdHMtaWdub3JlXG4gICAgICAgICAgICAgICAgICAgICAgb2xkTG9nc1tvbGRMb2ddLmNhbGwoaWZyYW1lLmNvbnRlbnRXaW5kb3cuY29uc29sZSwgLi4uYXJndW1lbnRzKTtcbiAgICAgICAgICAgICAgICAgICAgICBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25Db25zb2xlTWVzc2FnZScsIHZpZXdJZCwgW29sZExvZywgbWVzc2FnZV0pO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICB9KShrKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgICAgY29uc3Qgb3JpZ2luYWxQdXNoU3RhdGUgPSBpZnJhbWUuY29udGVudFdpbmRvdy5oaXN0b3J5LnB1c2hTdGF0ZTtcbiAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdy5oaXN0b3J5LnB1c2hTdGF0ZSA9IGZ1bmN0aW9uIChzdGF0ZSwgdW51c2VkLCB1cmwpIHtcbiAgICAgICAgICAgICAgICAgIG9yaWdpbmFsUHVzaFN0YXRlLmNhbGwoaWZyYW1lLmNvbnRlbnRXaW5kb3chLmhpc3RvcnksIHN0YXRlLCB1bnVzZWQsIHVybCk7XG4gICAgICAgICAgICAgICAgICBsZXQgaWZyYW1lVXJsID0gaWZyYW1lLnNyYztcbiAgICAgICAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgICAgICAgIGlmcmFtZVVybCA9IGlmcmFtZS5jb250ZW50V2luZG93IS5sb2NhdGlvbi5ocmVmO1xuICAgICAgICAgICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgIF9uYXRpdmVDb21tdW5pY2F0aW9uKCdvblVwZGF0ZVZpc2l0ZWRIaXN0b3J5Jywgdmlld0lkLCBbaWZyYW1lVXJsXSk7XG4gICAgICAgICAgICAgICAgfTtcblxuICAgICAgICAgICAgICAgIGNvbnN0IG9yaWdpbmFsUmVwbGFjZVN0YXRlID0gaWZyYW1lLmNvbnRlbnRXaW5kb3cuaGlzdG9yeS5yZXBsYWNlU3RhdGU7XG4gICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnRXaW5kb3cuaGlzdG9yeS5yZXBsYWNlU3RhdGUgPSBmdW5jdGlvbiAoc3RhdGUsIHVudXNlZCwgdXJsKSB7XG4gICAgICAgICAgICAgICAgICBvcmlnaW5hbFJlcGxhY2VTdGF0ZS5jYWxsKGlmcmFtZS5jb250ZW50V2luZG93IS5oaXN0b3J5LCBzdGF0ZSwgdW51c2VkLCB1cmwpO1xuICAgICAgICAgICAgICAgICAgbGV0IGlmcmFtZVVybCA9IGlmcmFtZS5zcmM7XG4gICAgICAgICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICAgICAgICBpZnJhbWVVcmwgPSBpZnJhbWUuY29udGVudFdpbmRvdyEubG9jYXRpb24uaHJlZjtcbiAgICAgICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25VcGRhdGVWaXNpdGVkSGlzdG9yeScsIHZpZXdJZCwgW2lmcmFtZVVybF0pO1xuICAgICAgICAgICAgICAgIH07XG5cbiAgICAgICAgICAgICAgICBjb25zdCBvcmlnaW5hbENsb3NlID0gaWZyYW1lLmNvbnRlbnRXaW5kb3cuY2xvc2U7XG4gICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnRXaW5kb3cuY2xvc2UgPSBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgICAgICAgICBvcmlnaW5hbENsb3NlLmNhbGwoaWZyYW1lLmNvbnRlbnRXaW5kb3cpO1xuICAgICAgICAgICAgICAgICAgX25hdGl2ZUNvbW11bmljYXRpb24oJ29uQ2xvc2VXaW5kb3cnLCB2aWV3SWQpO1xuICAgICAgICAgICAgICAgIH07XG5cbiAgICAgICAgICAgICAgICBjb25zdCBvcmlnaW5hbE9wZW4gPSBpZnJhbWUuY29udGVudFdpbmRvdy5vcGVuO1xuICAgICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93Lm9wZW4gPSBmdW5jdGlvbiAodXJsLCB0YXJnZXQsIHdpbmRvd0ZlYXR1cmVzKSB7XG4gICAgICAgICAgICAgICAgICBjb25zdCBuZXdXaW5kb3cgPSBvcmlnaW5hbE9wZW4uY2FsbChpZnJhbWUuY29udGVudFdpbmRvdywgLi4uYXJndW1lbnRzKTtcbiAgICAgICAgICAgICAgICAgIF9uYXRpdmVDb21tdW5pY2F0aW9uPFByb21pc2U8Ym9vbGVhbj4+KCdvbkNyZWF0ZVdpbmRvdycsIHZpZXdJZCwgW3VybCwgdGFyZ2V0LCB3aW5kb3dGZWF0dXJlc10pLnRoZW4oZnVuY3Rpb24gKGhhbmRsZWRCeUNsaWVudCkge1xuICAgICAgICAgICAgICAgICAgICBpZiAoaGFuZGxlZEJ5Q2xpZW50KSB7XG4gICAgICAgICAgICAgICAgICAgICAgbmV3V2luZG93Py5jbG9zZSgpO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICB9KTtcbiAgICAgICAgICAgICAgICAgIHJldHVybiBuZXdXaW5kb3c7XG4gICAgICAgICAgICAgICAgfTtcblxuICAgICAgICAgICAgICAgIGNvbnN0IG9yaWdpbmFsUHJpbnQgPSBpZnJhbWUuY29udGVudFdpbmRvdy5wcmludDtcbiAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdy5wcmludCA9IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICAgICAgICAgIGxldCBpZnJhbWVVcmwgPSBpZnJhbWUuc3JjO1xuICAgICAgICAgICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgICAgICAgICAgaWZyYW1lVXJsID0gaWZyYW1lLmNvbnRlbnRXaW5kb3chLmxvY2F0aW9uLmhyZWY7XG4gICAgICAgICAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgX25hdGl2ZUNvbW11bmljYXRpb24oJ29uUHJpbnRSZXF1ZXN0Jywgdmlld0lkLCBbaWZyYW1lVXJsXSk7XG4gICAgICAgICAgICAgICAgICBvcmlnaW5hbFByaW50LmNhbGwoaWZyYW1lLmNvbnRlbnRXaW5kb3cpO1xuICAgICAgICAgICAgICAgIH07XG5cbiAgICAgICAgICAgICAgICB3ZWJWaWV3LmZ1bmN0aW9uTWFwID0ge1xuICAgICAgICAgICAgICAgICAgXCJ3aW5kb3cub3BlblwiOiBpZnJhbWUuY29udGVudFdpbmRvdy5vcGVuLFxuICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICAgIGNvbnN0IGluaXRpYWxUaXRsZSA9IGlmcmFtZS5jb250ZW50RG9jdW1lbnQ/LnRpdGxlO1xuICAgICAgICAgICAgICAgIGNvbnN0IHRpdGxlRWwgPSBpZnJhbWUuY29udGVudERvY3VtZW50Py5xdWVyeVNlbGVjdG9yKCd0aXRsZScpO1xuICAgICAgICAgICAgICAgIHdlYlZpZXcuZG9jdW1lbnRUaXRsZSA9IGluaXRpYWxUaXRsZTtcbiAgICAgICAgICAgICAgICBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25UaXRsZUNoYW5nZWQnLCB2aWV3SWQsIFtpbml0aWFsVGl0bGVdKTtcbiAgICAgICAgICAgICAgICBpZiAodGl0bGVFbCAhPSBudWxsKSB7XG4gICAgICAgICAgICAgICAgICBuZXcgTXV0YXRpb25PYnNlcnZlcihmdW5jdGlvbiAobXV0YXRpb25zKSB7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IHRpdGxlID0gKG11dGF0aW9uc1swXS50YXJnZXQgYXMgSFRNTEVsZW1lbnQpLmlubmVyVGV4dDtcbiAgICAgICAgICAgICAgICAgICAgaWYgKHRpdGxlICE9IHdlYlZpZXcuZG9jdW1lbnRUaXRsZSkge1xuICAgICAgICAgICAgICAgICAgICAgIHdlYlZpZXcuZG9jdW1lbnRUaXRsZSA9IHRpdGxlO1xuICAgICAgICAgICAgICAgICAgICAgIF9uYXRpdmVDb21tdW5pY2F0aW9uKCdvblRpdGxlQ2hhbmdlZCcsIHZpZXdJZCwgW3RpdGxlXSk7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgIH0pLm9ic2VydmUoXG4gICAgICAgICAgICAgICAgICAgICAgdGl0bGVFbCxcbiAgICAgICAgICAgICAgICAgICAgICB7c3VidHJlZTogdHJ1ZSwgY2hhcmFjdGVyRGF0YTogdHJ1ZSwgY2hpbGRMaXN0OiB0cnVlfVxuICAgICAgICAgICAgICAgICAgKTtcbiAgICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgICBsZXQgb2xkUGl4ZWxSYXRpbyA9IGlmcmFtZS5jb250ZW50V2luZG93LmRldmljZVBpeGVsUmF0aW87XG4gICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnRXaW5kb3cuYWRkRXZlbnRMaXN0ZW5lcigncmVzaXplJywgZnVuY3Rpb24gKGUpIHtcbiAgICAgICAgICAgICAgICAgIGNvbnN0IG5ld1BpeGVsUmF0aW8gPSBpZnJhbWUuY29udGVudFdpbmRvdyEuZGV2aWNlUGl4ZWxSYXRpbztcbiAgICAgICAgICAgICAgICAgIGlmIChuZXdQaXhlbFJhdGlvICE9PSBvbGRQaXhlbFJhdGlvKSB7XG4gICAgICAgICAgICAgICAgICAgIF9uYXRpdmVDb21tdW5pY2F0aW9uKCdvblpvb21TY2FsZUNoYW5nZWQnLCB2aWV3SWQsIFtvbGRQaXhlbFJhdGlvLCBuZXdQaXhlbFJhdGlvXSk7XG4gICAgICAgICAgICAgICAgICAgIG9sZFBpeGVsUmF0aW8gPSBuZXdQaXhlbFJhdGlvO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH0pO1xuXG4gICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnRXaW5kb3cuYWRkRXZlbnRMaXN0ZW5lcigncG9wc3RhdGUnLCBmdW5jdGlvbiAoZXZlbnQ6IEV2ZW50KSB7XG4gICAgICAgICAgICAgICAgICBsZXQgaWZyYW1lVXJsID0gaWZyYW1lLnNyYztcbiAgICAgICAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgICAgICAgIGlmcmFtZVVybCA9IGlmcmFtZS5jb250ZW50V2luZG93IS5sb2NhdGlvbi5ocmVmO1xuICAgICAgICAgICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgIF9uYXRpdmVDb21tdW5pY2F0aW9uKCdvblVwZGF0ZVZpc2l0ZWRIaXN0b3J5Jywgdmlld0lkLCBbaWZyYW1lVXJsXSk7XG4gICAgICAgICAgICAgICAgfSk7XG5cbiAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdy5hZGRFdmVudExpc3RlbmVyKCdzY3JvbGwnLCBmdW5jdGlvbiAoZXZlbnQ6IEV2ZW50KSB7XG4gICAgICAgICAgICAgICAgICBsZXQgeCA9IDA7XG4gICAgICAgICAgICAgICAgICBsZXQgeSA9IDA7XG4gICAgICAgICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICAgICAgICB4ID0gaWZyYW1lLmNvbnRlbnRXaW5kb3chLnNjcm9sbFg7XG4gICAgICAgICAgICAgICAgICAgIHkgPSBpZnJhbWUuY29udGVudFdpbmRvdyEuc2Nyb2xsWTtcbiAgICAgICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25TY3JvbGxDaGFuZ2VkJywgdmlld0lkLCBbeCwgeV0pO1xuICAgICAgICAgICAgICAgIH0pO1xuXG4gICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnRXaW5kb3cuYWRkRXZlbnRMaXN0ZW5lcignZm9jdXMnLCBmdW5jdGlvbiAoZXZlbnQ6IEV2ZW50KSB7XG4gICAgICAgICAgICAgICAgICBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25XaW5kb3dGb2N1cycsIHZpZXdJZCk7XG4gICAgICAgICAgICAgICAgfSk7XG5cbiAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdy5hZGRFdmVudExpc3RlbmVyKCdibHVyJywgZnVuY3Rpb24gKGV2ZW50OiBFdmVudCkge1xuICAgICAgICAgICAgICAgICAgX25hdGl2ZUNvbW11bmljYXRpb24oJ29uV2luZG93Qmx1cicsIHZpZXdJZCk7XG4gICAgICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgICAgaWYgKCF3ZWJWaWV3LnNldHRpbmdzLmphdmFTY3JpcHRDYW5PcGVuV2luZG93c0F1dG9tYXRpY2FsbHkpIHtcbiAgICAgICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93Lm9wZW4gPSBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgICAgICAgICAgIHRocm93IG5ldyBFcnJvcignSmF2YVNjcmlwdCBjYW5ub3Qgb3BlbiB3aW5kb3dzIGF1dG9tYXRpY2FsbHknKTtcbiAgICAgICAgICAgICAgICAgIH07XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgaWYgKCF3ZWJWaWV3LnNldHRpbmdzLnZlcnRpY2FsU2Nyb2xsQmFyRW5hYmxlZCAmJiAhd2ViVmlldy5zZXR0aW5ncy5ob3Jpem9udGFsU2Nyb2xsQmFyRW5hYmxlZCkge1xuICAgICAgICAgICAgICAgICAgY29uc3Qgc3R5bGUgPSBpZnJhbWUuY29udGVudERvY3VtZW50Py5jcmVhdGVFbGVtZW50KCdzdHlsZScpO1xuICAgICAgICAgICAgICAgICAgaWYgKHN0eWxlICE9IG51bGwpIHtcbiAgICAgICAgICAgICAgICAgICAgc3R5bGUuaWQgPSBcInNldHRpbmdzLnZlcnRpY2FsU2Nyb2xsQmFyRW5hYmxlZC1zZXR0aW5ncy5ob3Jpem9udGFsU2Nyb2xsQmFyRW5hYmxlZFwiO1xuICAgICAgICAgICAgICAgICAgICBzdHlsZS5pbm5lckhUTUwgPSBcImJvZHk6Oi13ZWJraXQtc2Nyb2xsYmFyIHsgd2lkdGg6IDBweDsgaGVpZ2h0OiAwcHg7IH1cIjtcbiAgICAgICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnREb2N1bWVudD8uaGVhZC5hcHBlbmQoc3R5bGUpO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICAgIGlmICh3ZWJWaWV3LnNldHRpbmdzLmRpc2FibGVWZXJ0aWNhbFNjcm9sbCkge1xuICAgICAgICAgICAgICAgICAgY29uc3Qgc3R5bGUgPSBpZnJhbWUuY29udGVudERvY3VtZW50Py5jcmVhdGVFbGVtZW50KCdzdHlsZScpO1xuICAgICAgICAgICAgICAgICAgaWYgKHN0eWxlICE9IG51bGwpIHtcbiAgICAgICAgICAgICAgICAgICAgc3R5bGUuaWQgPSBcInNldHRpbmdzLmRpc2FibGVWZXJ0aWNhbFNjcm9sbFwiO1xuICAgICAgICAgICAgICAgICAgICBzdHlsZS5pbm5lckhUTUwgPSBcImJvZHkgeyBvdmVyZmxvdy15OiBoaWRkZW47IH1cIjtcbiAgICAgICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnREb2N1bWVudD8uaGVhZC5hcHBlbmQoc3R5bGUpO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICAgIGlmICh3ZWJWaWV3LnNldHRpbmdzLmRpc2FibGVIb3Jpem9udGFsU2Nyb2xsKSB7XG4gICAgICAgICAgICAgICAgICBjb25zdCBzdHlsZSA9IGlmcmFtZS5jb250ZW50RG9jdW1lbnQ/LmNyZWF0ZUVsZW1lbnQoJ3N0eWxlJyk7XG4gICAgICAgICAgICAgICAgICBpZiAoc3R5bGUgIT0gbnVsbCkge1xuICAgICAgICAgICAgICAgICAgICBzdHlsZS5pZCA9IFwic2V0dGluZ3MuZGlzYWJsZUhvcml6b250YWxTY3JvbGxcIjtcbiAgICAgICAgICAgICAgICAgICAgc3R5bGUuaW5uZXJIVE1MID0gXCJib2R5IHsgb3ZlcmZsb3cteDogaGlkZGVuOyB9XCI7XG4gICAgICAgICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50RG9jdW1lbnQ/LmhlYWQuYXBwZW5kKHN0eWxlKTtcbiAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgICBpZiAod2ViVmlldy5zZXR0aW5ncy5kaXNhYmxlQ29udGV4dE1lbnUpIHtcbiAgICAgICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93LmFkZEV2ZW50TGlzdGVuZXIoJ2NvbnRleHRtZW51Jywgd2ViVmlldy5kaXNhYmxlQ29udGV4dE1lbnVIYW5kbGVyKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgIF9uYXRpdmVDb21tdW5pY2F0aW9uKCdvbkxvYWRTdG9wJywgdmlld0lkLCBbdXJsXSk7XG5cbiAgICAgICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdy5kaXNwYXRjaEV2ZW50KG5ldyBFdmVudCgnYXF1dHRlclBsYXRmb3JtUmVhZHknKSk7XG4gICAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICB9KTtcbiAgICAgICAgICB9XG4gICAgICAgIH0sXG4gICAgICAgIHNldFNldHRpbmdzOiBmdW5jdGlvbiAobmV3U2V0dGluZ3M6IEFxdXR0ZXJXZWJWaWV3U2V0dGluZ3MpIHtcbiAgICAgICAgICBjb25zdCBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICBpZiAoaWZyYW1lID09IG51bGwpIHtcbiAgICAgICAgICAgIHJldHVybjtcbiAgICAgICAgICB9XG4gICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgIGlmICh3ZWJWaWV3LnNldHRpbmdzLmphdmFTY3JpcHRDYW5PcGVuV2luZG93c0F1dG9tYXRpY2FsbHkgIT0gbmV3U2V0dGluZ3MuamF2YVNjcmlwdENhbk9wZW5XaW5kb3dzQXV0b21hdGljYWxseSkge1xuICAgICAgICAgICAgICBpZiAoIW5ld1NldHRpbmdzLmphdmFTY3JpcHRDYW5PcGVuV2luZG93c0F1dG9tYXRpY2FsbHkpIHtcbiAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdyEub3BlbiA9IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICAgICAgICAgIHRocm93IG5ldyBFcnJvcignSmF2YVNjcmlwdCBjYW5ub3Qgb3BlbiB3aW5kb3dzIGF1dG9tYXRpY2FsbHknKTtcbiAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93IS5vcGVuID0gd2ViVmlldy5mdW5jdGlvbk1hcFtcIndpbmRvdy5vcGVuXCJdO1xuICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9XG5cbiAgICAgICAgICAgIGlmICh3ZWJWaWV3LnNldHRpbmdzLnZlcnRpY2FsU2Nyb2xsQmFyRW5hYmxlZCAhPSBuZXdTZXR0aW5ncy52ZXJ0aWNhbFNjcm9sbEJhckVuYWJsZWQgJiZcbiAgICAgICAgICAgICAgICB3ZWJWaWV3LnNldHRpbmdzLmhvcml6b250YWxTY3JvbGxCYXJFbmFibGVkICE9IG5ld1NldHRpbmdzLmhvcml6b250YWxTY3JvbGxCYXJFbmFibGVkKSB7XG4gICAgICAgICAgICAgIGlmICghbmV3U2V0dGluZ3MudmVydGljYWxTY3JvbGxCYXJFbmFibGVkICYmICFuZXdTZXR0aW5ncy5ob3Jpem9udGFsU2Nyb2xsQmFyRW5hYmxlZCkge1xuICAgICAgICAgICAgICAgIGNvbnN0IHN0eWxlID0gaWZyYW1lLmNvbnRlbnREb2N1bWVudD8uY3JlYXRlRWxlbWVudCgnc3R5bGUnKTtcbiAgICAgICAgICAgICAgICBpZiAoc3R5bGUgIT0gbnVsbCkge1xuICAgICAgICAgICAgICAgICAgc3R5bGUuaWQgPSBcInNldHRpbmdzLnZlcnRpY2FsU2Nyb2xsQmFyRW5hYmxlZC1zZXR0aW5ncy5ob3Jpem9udGFsU2Nyb2xsQmFyRW5hYmxlZFwiO1xuICAgICAgICAgICAgICAgICAgc3R5bGUuaW5uZXJIVE1MID0gXCJib2R5Ojotd2Via2l0LXNjcm9sbGJhciB7IHdpZHRoOiAwcHg7IGhlaWdodDogMHB4OyB9XCI7XG4gICAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudERvY3VtZW50Py5oZWFkLmFwcGVuZChzdHlsZSk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIGNvbnN0IHN0eWxlRWxlbWVudCA9IGlmcmFtZS5jb250ZW50RG9jdW1lbnQ/LmdldEVsZW1lbnRCeUlkKFwic2V0dGluZ3MudmVydGljYWxTY3JvbGxCYXJFbmFibGVkLXNldHRpbmdzLmhvcml6b250YWxTY3JvbGxCYXJFbmFibGVkXCIpO1xuICAgICAgICAgICAgICAgIGlmIChzdHlsZUVsZW1lbnQpIHtcbiAgICAgICAgICAgICAgICAgIHN0eWxlRWxlbWVudC5yZW1vdmUoKVxuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICBpZiAod2ViVmlldy5zZXR0aW5ncy5kaXNhYmxlVmVydGljYWxTY3JvbGwgIT0gbmV3U2V0dGluZ3MuZGlzYWJsZVZlcnRpY2FsU2Nyb2xsKSB7XG4gICAgICAgICAgICAgIGlmIChuZXdTZXR0aW5ncy5kaXNhYmxlVmVydGljYWxTY3JvbGwpIHtcbiAgICAgICAgICAgICAgICBjb25zdCBzdHlsZSA9IGlmcmFtZS5jb250ZW50RG9jdW1lbnQ/LmNyZWF0ZUVsZW1lbnQoJ3N0eWxlJyk7XG4gICAgICAgICAgICAgICAgaWYgKHN0eWxlICE9IG51bGwpIHtcbiAgICAgICAgICAgICAgICAgIHN0eWxlLmlkID0gXCJzZXR0aW5ncy5kaXNhYmxlVmVydGljYWxTY3JvbGxcIjtcbiAgICAgICAgICAgICAgICAgIHN0eWxlLmlubmVySFRNTCA9IFwiYm9keSB7IG92ZXJmbG93LXk6IGhpZGRlbjsgfVwiO1xuICAgICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnREb2N1bWVudD8uaGVhZC5hcHBlbmQoc3R5bGUpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICBjb25zdCBzdHlsZUVsZW1lbnQgPSBpZnJhbWUuY29udGVudERvY3VtZW50Py5nZXRFbGVtZW50QnlJZChcInNldHRpbmdzLmRpc2FibGVWZXJ0aWNhbFNjcm9sbFwiKTtcbiAgICAgICAgICAgICAgICBpZiAoc3R5bGVFbGVtZW50KSB7XG4gICAgICAgICAgICAgICAgICBzdHlsZUVsZW1lbnQucmVtb3ZlKClcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgaWYgKHdlYlZpZXcuc2V0dGluZ3MuZGlzYWJsZUhvcml6b250YWxTY3JvbGwgIT0gbmV3U2V0dGluZ3MuZGlzYWJsZUhvcml6b250YWxTY3JvbGwpIHtcbiAgICAgICAgICAgICAgaWYgKG5ld1NldHRpbmdzLmRpc2FibGVIb3Jpem9udGFsU2Nyb2xsKSB7XG4gICAgICAgICAgICAgICAgY29uc3Qgc3R5bGUgPSBpZnJhbWUuY29udGVudERvY3VtZW50Py5jcmVhdGVFbGVtZW50KCdzdHlsZScpO1xuICAgICAgICAgICAgICAgIGlmIChzdHlsZSAhPSBudWxsKSB7XG4gICAgICAgICAgICAgICAgICBzdHlsZS5pZCA9IFwic2V0dGluZ3MuZGlzYWJsZUhvcml6b250YWxTY3JvbGxcIjtcbiAgICAgICAgICAgICAgICAgIHN0eWxlLmlubmVySFRNTCA9IFwiYm9keSB7IG92ZXJmbG93LXg6IGhpZGRlbjsgfVwiO1xuICAgICAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnREb2N1bWVudD8uaGVhZC5hcHBlbmQoc3R5bGUpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICBjb25zdCBzdHlsZUVsZW1lbnQgPSBpZnJhbWUuY29udGVudERvY3VtZW50Py5nZXRFbGVtZW50QnlJZChcInNldHRpbmdzLmRpc2FibGVIb3Jpem9udGFsU2Nyb2xsXCIpO1xuICAgICAgICAgICAgICAgIGlmIChzdHlsZUVsZW1lbnQpIHtcbiAgICAgICAgICAgICAgICAgIHN0eWxlRWxlbWVudC5yZW1vdmUoKVxuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICBpZiAod2ViVmlldy5zZXR0aW5ncy5kaXNhYmxlQ29udGV4dE1lbnUgIT0gbmV3U2V0dGluZ3MuZGlzYWJsZUNvbnRleHRNZW51KSB7XG4gICAgICAgICAgICAgIGlmIChuZXdTZXR0aW5ncy5kaXNhYmxlQ29udGV4dE1lbnUpIHtcbiAgICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdz8uYWRkRXZlbnRMaXN0ZW5lcignY29udGV4dG1lbnUnLCB3ZWJWaWV3LmRpc2FibGVDb250ZXh0TWVudUhhbmRsZXIpO1xuICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93Py5yZW1vdmVFdmVudExpc3RlbmVyKCdjb250ZXh0bWVudScsIHdlYlZpZXcuZGlzYWJsZUNvbnRleHRNZW51SGFuZGxlcik7XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cbiAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICB9XG5cbiAgICAgICAgICB3ZWJWaWV3LnNldHRpbmdzID0gbmV3U2V0dGluZ3M7XG4gICAgICAgIH0sXG4gICAgICAgIHJlbG9hZDogZnVuY3Rpb24gKCkge1xuICAgICAgICAgIHZhciBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICBpZiAoaWZyYW1lICE9IG51bGwgJiYgaWZyYW1lLmNvbnRlbnRXaW5kb3cgIT0gbnVsbCkge1xuICAgICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgICAgaWZyYW1lLmNvbnRlbnRXaW5kb3cubG9jYXRpb24ucmVsb2FkKCk7XG4gICAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdy5sb2NhdGlvbi5ocmVmID0gaWZyYW1lLnNyYztcbiAgICAgICAgICAgIH1cbiAgICAgICAgICB9XG4gICAgICAgIH0sXG4gICAgICAgIGdvQmFjazogZnVuY3Rpb24gKCkge1xuICAgICAgICAgIHZhciBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICBpZiAoaWZyYW1lICE9IG51bGwpIHtcbiAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93Py5oaXN0b3J5LmJhY2soKTtcbiAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgfVxuICAgICAgICB9LFxuICAgICAgICBnb0ZvcndhcmQ6IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICB2YXIgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgaWYgKGlmcmFtZSAhPSBudWxsKSB7XG4gICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdz8uaGlzdG9yeS5mb3J3YXJkKCk7XG4gICAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfSxcbiAgICAgICAgZ29CYWNrT3JGb3J3YXJkOiBmdW5jdGlvbiAoc3RlcHMpIHtcbiAgICAgICAgICB2YXIgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgaWYgKGlmcmFtZSAhPSBudWxsKSB7XG4gICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICBpZnJhbWUuY29udGVudFdpbmRvdz8uaGlzdG9yeS5nbyhzdGVwcyk7XG4gICAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfSxcbiAgICAgICAgZXZhbHVhdGVKYXZhc2NyaXB0OiBmdW5jdGlvbiAoc291cmNlKSB7XG4gICAgICAgICAgY29uc3QgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgbGV0IHJlc3VsdCA9IG51bGw7XG4gICAgICAgICAgaWYgKGlmcmFtZSAhPSBudWxsKSB7XG4gICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICByZXN1bHQgPSBKU09OLnN0cmluZ2lmeShpZnJhbWUuY29udGVudFdpbmRvdz8uZXZhbChzb3VyY2UpKTtcbiAgICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICB9XG4gICAgICAgICAgcmV0dXJuIHJlc3VsdDtcbiAgICAgICAgfSxcbiAgICAgICAgc3RvcExvYWRpbmc6IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICBjb25zdCBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICBpZiAoaWZyYW1lICE9IG51bGwpIHtcbiAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgIGlmcmFtZS5jb250ZW50V2luZG93Py5zdG9wKCk7XG4gICAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfSxcbiAgICAgICAgZ2V0VXJsOiBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgY29uc3QgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgbGV0IHVybCA9IGlmcmFtZT8uc3JjO1xuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICB1cmwgPSBpZnJhbWU/LmNvbnRlbnRXaW5kb3c/LmxvY2F0aW9uLmhyZWY7XG4gICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgfVxuICAgICAgICAgIHJldHVybiB1cmw7XG4gICAgICAgIH0sXG4gICAgICAgIGdldFRpdGxlOiBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgY29uc3QgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgbGV0IHRpdGxlID0gbnVsbDtcbiAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgdGl0bGUgPSBpZnJhbWU/LmNvbnRlbnREb2N1bWVudD8udGl0bGU7XG4gICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgfVxuICAgICAgICAgIHJldHVybiB0aXRsZTtcbiAgICAgICAgfSxcbiAgICAgICAgaW5qZWN0SmF2YXNjcmlwdEZpbGVGcm9tVXJsOiBmdW5jdGlvbiAodXJsRmlsZSwgc2NyaXB0SHRtbFRhZ0F0dHJpYnV0ZXMpIHtcbiAgICAgICAgICBjb25zdCBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgY29uc3QgZCA9IGlmcmFtZT8uY29udGVudERvY3VtZW50O1xuICAgICAgICAgICAgaWYgKGQgPT0gbnVsbCkge1xuICAgICAgICAgICAgICByZXR1cm47XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBjb25zdCBzY3JpcHQgPSBkLmNyZWF0ZUVsZW1lbnQoJ3NjcmlwdCcpO1xuICAgICAgICAgICAgZm9yIChjb25zdCBrZXkgb2YgT2JqZWN0LmtleXMoc2NyaXB0SHRtbFRhZ0F0dHJpYnV0ZXMpKSB7XG4gICAgICAgICAgICAgIGlmIChzY3JpcHRIdG1sVGFnQXR0cmlidXRlc1trZXldICE9IG51bGwpIHtcbiAgICAgICAgICAgICAgICAvLyBAdHMtaWdub3JlXG4gICAgICAgICAgICAgICAgc2NyaXB0W2tleV0gPSBzY3JpcHRIdG1sVGFnQXR0cmlidXRlc1trZXldO1xuICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAoc2NyaXB0LmlkICE9IG51bGwpIHtcbiAgICAgICAgICAgICAgc2NyaXB0Lm9ubG9hZCA9IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICAgICAgICBfbmF0aXZlQ29tbXVuaWNhdGlvbignb25JbmplY3RlZFNjcmlwdExvYWRlZCcsIHdlYlZpZXcudmlld0lkLCBbc2NyaXB0LmlkXSk7XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgc2NyaXB0Lm9uZXJyb3IgPSBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgICAgICAgX25hdGl2ZUNvbW11bmljYXRpb24oJ29uSW5qZWN0ZWRTY3JpcHRFcnJvcicsIHdlYlZpZXcudmlld0lkLCBbc2NyaXB0LmlkXSk7XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIHNjcmlwdC5zcmMgPSB1cmxGaWxlO1xuICAgICAgICAgICAgaWYgKGQuYm9keSAhPSBudWxsKSB7XG4gICAgICAgICAgICAgIGQuYm9keS5hcHBlbmRDaGlsZChzY3JpcHQpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgIH1cbiAgICAgICAgfSxcbiAgICAgICAgaW5qZWN0Q1NTQ29kZTogZnVuY3Rpb24gKHNvdXJjZSkge1xuICAgICAgICAgIGNvbnN0IGlmcmFtZSA9IHdlYlZpZXcuaWZyYW1lO1xuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICBjb25zdCBkID0gaWZyYW1lPy5jb250ZW50RG9jdW1lbnQ7XG4gICAgICAgICAgICBpZiAoZCA9PSBudWxsKSB7XG4gICAgICAgICAgICAgIHJldHVybjtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGNvbnN0IHN0eWxlID0gZC5jcmVhdGVFbGVtZW50KCdzdHlsZScpO1xuICAgICAgICAgICAgc3R5bGUuaW5uZXJIVE1MID0gc291cmNlO1xuICAgICAgICAgICAgaWYgKGQuaGVhZCAhPSBudWxsKSB7XG4gICAgICAgICAgICAgIGQuaGVhZC5hcHBlbmRDaGlsZChzdHlsZSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgfVxuICAgICAgICB9LFxuICAgICAgICBpbmplY3RDU1NGaWxlRnJvbVVybDogZnVuY3Rpb24gKHVybEZpbGUsIGNzc0xpbmtIdG1sVGFnQXR0cmlidXRlcykge1xuICAgICAgICAgIGNvbnN0IGlmcmFtZSA9IHdlYlZpZXcuaWZyYW1lO1xuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICBjb25zdCBkID0gaWZyYW1lPy5jb250ZW50RG9jdW1lbnQ7XG4gICAgICAgICAgICBpZiAoZCA9PSBudWxsKSB7XG4gICAgICAgICAgICAgIHJldHVybjtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGNvbnN0IGxpbmsgPSBkLmNyZWF0ZUVsZW1lbnQoJ2xpbmsnKTtcbiAgICAgICAgICAgIGZvciAoY29uc3Qga2V5IG9mIE9iamVjdC5rZXlzKGNzc0xpbmtIdG1sVGFnQXR0cmlidXRlcykpIHtcbiAgICAgICAgICAgICAgaWYgKGNzc0xpbmtIdG1sVGFnQXR0cmlidXRlc1trZXldICE9IG51bGwpIHtcbiAgICAgICAgICAgICAgICAvLyBAdHMtaWdub3JlXG4gICAgICAgICAgICAgICAgbGlua1trZXldID0gY3NzTGlua0h0bWxUYWdBdHRyaWJ1dGVzW2tleV07XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGxpbmsudHlwZSA9ICd0ZXh0L2Nzcyc7XG4gICAgICAgICAgICB2YXIgYWx0ZXJuYXRlU3R5bGVzaGVldCA9IFwiXCI7XG4gICAgICAgICAgICBpZiAoY3NzTGlua0h0bWxUYWdBdHRyaWJ1dGVzLmFsdGVybmF0ZVN0eWxlc2hlZXQpIHtcbiAgICAgICAgICAgICAgYWx0ZXJuYXRlU3R5bGVzaGVldCA9IFwiYWx0ZXJuYXRlIFwiO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgbGluay5yZWwgPSBhbHRlcm5hdGVTdHlsZXNoZWV0ICsgXCJzdHlsZXNoZWV0XCI7XG4gICAgICAgICAgICBsaW5rLmhyZWYgPSB1cmxGaWxlO1xuICAgICAgICAgICAgaWYgKGQuaGVhZCAhPSBudWxsKSB7XG4gICAgICAgICAgICAgIGQuaGVhZC5hcHBlbmRDaGlsZChsaW5rKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICB9XG4gICAgICAgIH0sXG4gICAgICAgIHNjcm9sbFRvOiBmdW5jdGlvbiAoeCwgeSwgYW5pbWF0ZWQpIHtcbiAgICAgICAgICBjb25zdCBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgaWYgKGFuaW1hdGVkKSB7XG4gICAgICAgICAgICAgIGlmcmFtZT8uY29udGVudFdpbmRvdz8uc2Nyb2xsVG8oe3RvcDogeSwgbGVmdDogeCwgYmVoYXZpb3I6ICdzbW9vdGgnfSk7XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICBpZnJhbWU/LmNvbnRlbnRXaW5kb3c/LnNjcm9sbFRvKHgsIHkpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgIH1cbiAgICAgICAgfSxcbiAgICAgICAgc2Nyb2xsQnk6IGZ1bmN0aW9uICh4LCB5LCBhbmltYXRlZCkge1xuICAgICAgICAgIGNvbnN0IGlmcmFtZSA9IHdlYlZpZXcuaWZyYW1lO1xuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICBpZiAoYW5pbWF0ZWQpIHtcbiAgICAgICAgICAgICAgaWZyYW1lPy5jb250ZW50V2luZG93Py5zY3JvbGxCeSh7dG9wOiB5LCBsZWZ0OiB4LCBiZWhhdmlvcjogJ3Ntb290aCd9KTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgIGlmcmFtZT8uY29udGVudFdpbmRvdz8uc2Nyb2xsQnkoeCwgeSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgfVxuICAgICAgICB9LFxuICAgICAgICBwcmludEN1cnJlbnRQYWdlOiBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgY29uc3QgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgIGlmcmFtZT8uY29udGVudFdpbmRvdz8ucHJpbnQoKTtcbiAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICB9XG4gICAgICAgIH0sXG4gICAgICAgIGdldENvbnRlbnRIZWlnaHQ6IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICBjb25zdCBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgcmV0dXJuIGlmcmFtZT8uY29udGVudERvY3VtZW50Py5kb2N1bWVudEVsZW1lbnQuc2Nyb2xsSGVpZ2h0O1xuICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgIH1cbiAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgfSxcbiAgICAgICAgZ2V0Q29udGVudFdpZHRoOiBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgY29uc3QgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgIHJldHVybiBpZnJhbWU/LmNvbnRlbnREb2N1bWVudD8uZG9jdW1lbnRFbGVtZW50LnNjcm9sbFdpZHRoO1xuICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgIH1cbiAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgfSxcbiAgICAgICAgZ2V0U2VsZWN0ZWRUZXh0OiBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgY29uc3QgaWZyYW1lID0gd2ViVmlldy5pZnJhbWU7XG4gICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgIGxldCB0eHQ7XG4gICAgICAgICAgICBjb25zdCB3ID0gaWZyYW1lPy5jb250ZW50V2luZG93O1xuICAgICAgICAgICAgaWYgKHcgPT0gbnVsbCkge1xuICAgICAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGlmICh3LmdldFNlbGVjdGlvbikge1xuICAgICAgICAgICAgICB0eHQgPSB3LmdldFNlbGVjdGlvbigpPy50b1N0cmluZygpO1xuICAgICAgICAgICAgfSBlbHNlIGlmICh3LmRvY3VtZW50LmdldFNlbGVjdGlvbikge1xuICAgICAgICAgICAgICB0eHQgPSB3LmRvY3VtZW50LmdldFNlbGVjdGlvbigpPy50b1N0cmluZygpO1xuICAgICAgICAgICAgICAvLyBAdHMtaWdub3JlXG4gICAgICAgICAgICB9IGVsc2UgaWYgKHcuZG9jdW1lbnQuc2VsZWN0aW9uKSB7XG4gICAgICAgICAgICAgIC8vIEB0cy1pZ25vcmVcbiAgICAgICAgICAgICAgdHh0ID0gdy5kb2N1bWVudC5zZWxlY3Rpb24uY3JlYXRlUmFuZ2UoKS50ZXh0O1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgcmV0dXJuIHR4dDtcbiAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICB9XG4gICAgICAgICAgcmV0dXJuIG51bGw7XG4gICAgICAgIH0sXG4gICAgICAgIGdldFNjcm9sbFg6IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICBjb25zdCBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgcmV0dXJuIGlmcmFtZT8uY29udGVudFdpbmRvdz8uc2Nyb2xsWDtcbiAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICB9XG4gICAgICAgICAgcmV0dXJuIG51bGw7XG4gICAgICAgIH0sXG4gICAgICAgIGdldFNjcm9sbFk6IGZ1bmN0aW9uICgpIHtcbiAgICAgICAgICBjb25zdCBpZnJhbWUgPSB3ZWJWaWV3LmlmcmFtZTtcbiAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgcmV0dXJuIGlmcmFtZT8uY29udGVudFdpbmRvdz8uc2Nyb2xsWTtcbiAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICB9XG4gICAgICAgICAgcmV0dXJuIG51bGw7XG4gICAgICAgIH0sXG4gICAgICAgIGlzU2VjdXJlQ29udGV4dDogZnVuY3Rpb24gKCkge1xuICAgICAgICAgIGNvbnN0IGlmcmFtZSA9IHdlYlZpZXcuaWZyYW1lO1xuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICByZXR1cm4gaWZyYW1lPy5jb250ZW50V2luZG93Py5pc1NlY3VyZUNvbnRleHQgPz8gZmFsc2U7XG4gICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgY29uc29sZS5sb2coZSk7XG4gICAgICAgICAgfVxuICAgICAgICAgIHJldHVybiBmYWxzZTtcbiAgICAgICAgfSxcbiAgICAgICAgY2FuU2Nyb2xsVmVydGljYWxseTogZnVuY3Rpb24gKCkge1xuICAgICAgICAgIGNvbnN0IGlmcmFtZSA9IHdlYlZpZXcuaWZyYW1lO1xuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICByZXR1cm4gKGlmcmFtZT8uY29udGVudERvY3VtZW50Py5ib2R5LnNjcm9sbEhlaWdodCA/PyAwKSA+IChpZnJhbWU/LmNvbnRlbnRXaW5kb3c/LmlubmVySGVpZ2h0ID8/IDApO1xuICAgICAgICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgICAgIGNvbnNvbGUubG9nKGUpO1xuICAgICAgICAgIH1cbiAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgIH0sXG4gICAgICAgIGNhblNjcm9sbEhvcml6b250YWxseTogZnVuY3Rpb24gKCkge1xuICAgICAgICAgIGNvbnN0IGlmcmFtZSA9IHdlYlZpZXcuaWZyYW1lO1xuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICByZXR1cm4gKGlmcmFtZT8uY29udGVudERvY3VtZW50Py5ib2R5LnNjcm9sbFdpZHRoID8/IDApID4gKGlmcmFtZT8uY29udGVudFdpbmRvdz8uaW5uZXJXaWR0aCA/PyAwKTtcbiAgICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgICBjb25zb2xlLmxvZyhlKTtcbiAgICAgICAgICB9XG4gICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICB9LFxuICAgICAgICBnZXRTaXplOiBmdW5jdGlvbiAoKSB7XG4gICAgICAgICAgY29uc3QgaWZyYW1lQ29udGFpbmVyID0gd2ViVmlldy5pZnJhbWVDb250YWluZXI7XG4gICAgICAgICAgbGV0IHdpZHRoID0gMC4wO1xuICAgICAgICAgIGxldCBoZWlnaHQgPSAwLjA7XG4gICAgICAgICAgaWYgKGlmcmFtZUNvbnRhaW5lciAhPSBudWxsKSB7XG4gICAgICAgICAgICBpZiAoaWZyYW1lQ29udGFpbmVyLnN0eWxlLndpZHRoICE9IG51bGwgJiYgaWZyYW1lQ29udGFpbmVyLnN0eWxlLndpZHRoICE9ICcnICYmIGlmcmFtZUNvbnRhaW5lci5zdHlsZS53aWR0aC5pbmRleE9mKCdweCcpID4gMCkge1xuICAgICAgICAgICAgICB3aWR0aCA9IHBhcnNlRmxvYXQoaWZyYW1lQ29udGFpbmVyLnN0eWxlLndpZHRoKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGlmICh3aWR0aCA9PSBudWxsIHx8IHdpZHRoID09IDAuMCkge1xuICAgICAgICAgICAgICB3aWR0aCA9IGlmcmFtZUNvbnRhaW5lci5nZXRCb3VuZGluZ0NsaWVudFJlY3QoKS53aWR0aDtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGlmIChpZnJhbWVDb250YWluZXIuc3R5bGUuaGVpZ2h0ICE9IG51bGwgJiYgaWZyYW1lQ29udGFpbmVyLnN0eWxlLmhlaWdodCAhPSAnJyAmJiBpZnJhbWVDb250YWluZXIuc3R5bGUuaGVpZ2h0LmluZGV4T2YoJ3B4JykgPiAwKSB7XG4gICAgICAgICAgICAgIGhlaWdodCA9IHBhcnNlRmxvYXQoaWZyYW1lQ29udGFpbmVyLnN0eWxlLmhlaWdodCk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAoaGVpZ2h0ID09IG51bGwgfHwgaGVpZ2h0ID09IDAuMCkge1xuICAgICAgICAgICAgICBoZWlnaHQgPSBpZnJhbWVDb250YWluZXIuZ2V0Qm91bmRpbmdDbGllbnRSZWN0KCkuaGVpZ2h0O1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgICByZXR1cm4ge1xuICAgICAgICAgICAgd2lkdGg6IHdpZHRoLFxuICAgICAgICAgICAgaGVpZ2h0OiBoZWlnaHRcbiAgICAgICAgICB9O1xuICAgICAgICB9XG4gICAgICB9O1xuXG4gICAgICByZXR1cm4gd2ViVmlldztcbiAgICB9LFxuICAgIGdldENvb2tpZUV4cGlyYXRpb25EYXRlOiBmdW5jdGlvbiAodGltZXN0YW1wOiBudW1iZXIpIHtcbiAgICAgIHJldHVybiAobmV3IERhdGUodGltZXN0YW1wKSkudG9VVENTdHJpbmcoKTtcbiAgICB9LFxuICAgIG5hdGl2ZUFzeW5jQ29tbXVuaWNhdGlvbjogZnVuY3Rpb24gKG1ldGhvZDogc3RyaW5nLCB2aWV3SWQ6IG51bWJlciB8IHN0cmluZywgYXJncz86IGFueVtdKSB7XG4gICAgICB0aHJvdyBuZXcgRXJyb3IoXCJNZXRob2Qgbm90IGltcGxlbWVudGVkLlwiKTtcbiAgICB9LFxuICAgIG5hdGl2ZVN5bmNDb21tdW5pY2F0aW9uOiBmdW5jdGlvbiAobWV0aG9kOiBzdHJpbmcsIHZpZXdJZDogbnVtYmVyIHwgc3RyaW5nLCBhcmdzPzogYW55W10pIHtcbiAgICAgIHRocm93IG5ldyBFcnJvcihcIk1ldGhvZCBub3QgaW1wbGVtZW50ZWQuXCIpO1xuICAgIH0sXG4gICAgbmF0aXZlQ29tbXVuaWNhdGlvbjogZnVuY3Rpb24gKG1ldGhvZDogc3RyaW5nLCB2aWV3SWQ6IG51bWJlciB8IHN0cmluZywgYXJncz86IGFueVtdKSB7XG4gICAgICB0cnkge1xuICAgICAgICBjb25zdCByZXN1bHQgPSB3aW5kb3cuYXF1dHRlcldlYi5uYXRpdmVTeW5jQ29tbXVuaWNhdGlvbihtZXRob2QsIHZpZXdJZCwgYXJncyk7XG4gICAgICAgIHJldHVybiByZXN1bHQgIT0gbnVsbCA/IEpTT04ucGFyc2UocmVzdWx0KSA6IG51bGw7XG4gICAgICB9IGNhdGNoIChlMSkge1xuICAgICAgICB0cnkge1xuICAgICAgICAgIGNvbnN0IHByb21pc2UgPSB3aW5kb3cuYXF1dHRlcldlYi5uYXRpdmVBc3luY0NvbW11bmljYXRpb24obWV0aG9kLCB2aWV3SWQsIGFyZ3MpO1xuICAgICAgICAgIHJldHVybiBwcm9taXNlLnRoZW4oZnVuY3Rpb24gKHJlc3VsdCkge1xuICAgICAgICAgICAgcmV0dXJuIHJlc3VsdCAhPSBudWxsID8gSlNPTi5wYXJzZShyZXN1bHQpIDogbnVsbDtcbiAgICAgICAgICB9KTtcbiAgICAgICAgfSBjYXRjaCAoZTIpIHtcbiAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgfVxuICAgICAgfVxuICAgIH0sXG4gIH07XG5cbiAgbGV0IF9uYXRpdmVDb21tdW5pY2F0aW9uID0gd2luZG93LmFxdXR0ZXJXZWIubmF0aXZlQ29tbXVuaWNhdGlvbjtcbn0pKCk7Il0sCiAgIm1hcHBpbmdzIjogIjtDQW1CQyxXQUFZO0FBQ1gsTUFBSSxrQkFBa0IsT0FBTyxLQUFLO0FBQ2xDLE1BQUksZUFBZSxPQUFPLE1BQU0sVUFBVTtBQUMxQyxlQUFhLE9BQU8sT0FBTyxTQUFTLFVBQVU7QUFFOUMsU0FBTyxhQUFhO0FBQUEsSUFDbEIsc0JBQXNCLFNBQVUsUUFBeUIsUUFBMkIsaUJBQWlDLGNBQXNCO0FBQ3pJLFlBQU0sV0FBVyxPQUFPO0FBQ3hCLFlBQU0sVUFBMEI7QUFBQSxRQUM5QjtBQUFBLFFBQ0E7QUFBQSxRQUNBLFFBQVE7QUFBQSxRQUNSLGlCQUFpQjtBQUFBLFFBQ2pCLGNBQWM7QUFBQSxRQUNkLGVBQWU7QUFBQSxRQUNmLGFBQWEsQ0FBQztBQUFBLFFBQ2QsVUFBVSxDQUFDO0FBQUEsUUFDWCx5QkFBeUI7QUFBQSxRQUN6QiwyQkFBMkIsU0FBVSxPQUFjO0FBQ2pELGdCQUFNLGVBQWU7QUFDckIsZ0JBQU0sZ0JBQWdCO0FBQ3RCLGlCQUFPO0FBQUEsUUFDVDtBQUFBLFFBQ0EsU0FBUyxTQUFVLFVBQWtDO0FBQ25ELGtCQUFRLFdBQVc7QUFFbkIsa0JBQVEsMEJBQTBCLFFBQVEsU0FBUywyQkFBMkI7QUFDOUUsZ0JBQU0sa0NBQWtDLFFBQVEsU0FBUztBQUN6RCxjQUFJLG1DQUFtQyxRQUFRLENBQUMsZ0NBQWdDLFNBQVMsR0FBRyxHQUFHO0FBQzdGLGdCQUFJLGdDQUFnQyxXQUFXLEdB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
