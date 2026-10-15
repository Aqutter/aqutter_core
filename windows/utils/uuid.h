#ifndef AQUTTER_CORE_PLUGIN_UUID_UTIL_H_
#define AQUTTER_CORE_PLUGIN_UUID_UTIL_H_

#include <string>
#include <Windows.h>

namespace aqutter_core_plugin {
    static inline std::string get_uuid()
    {
        UUID uuid = { 0 };
        std::string guid;

        ::UuidCreate(&uuid);

        RPC_CSTR szUuid = NULL;
        if (::UuidToStringA(&uuid, &szUuid) == RPC_S_OK) {
            guid = (char*)szUuid;
            ::RpcStringFreeA(&szUuid);
        }

        return guid;
    }
}

#endif //AQUTTER_CORE_PLUGIN_UUID_UTIL_H_