/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/

library aqutter_core;

// Flutter 產生的 dart_plugin_registrant 以本入口取得各平台的 dartPluginClass，
// 因此每個已宣告的平台實作都必須從這裡匯出（原生與 Web 的取捨見 platforms.dart）。
export 'src/platforms/platforms.dart';
export 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart'
    hide
        ChannelController,
        InternalChannelController,
        AqutterInternalWebViewKeepAlive,
        IdGenerator,
        Color_,
        Util,
        UtilColor,
        HexColor,
        MapSize,
        MapEdgeInsets;
export 'src/main.dart';
export 'src/nativeview/nativeview.dart';
export 'src/rpc/rpc.dart';
