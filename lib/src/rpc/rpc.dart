/// 網頁與 Dart 之間的多工 RPC：呼叫、回應、事件與二進位共用一條本機連線。網頁端見 `@aqutter/aqutter`。
library;

export 'rpc_frame.dart'
    show
        AqutterRpcFormatException,
        AqutterRpcFrame,
        AqutterRpcFrameType,
        aqutterRpcBinaryKey,
        aqutterRpcMaxFrameBytes,
        decodeAqutterRpcFrame,
        encodeAqutterRpcFrame;
export 'rpc_host.dart'
    show
        AqutterRpcException,
        AqutterRpcHandler,
        AqutterRpcHost,
        aqutterRpcChannelName,
        aqutterRpcHandlerFailed,
        aqutterRpcHandlerNotFound,
        aqutterRpcPayloadTooLarge;
