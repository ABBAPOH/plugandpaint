import qbs 1.0

StaticLibrary {
    name: "pnp_basictools"
    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["core", "widgets"] }
    cpp.includePaths: "../../"
    cpp.defines: ["QT_STATICPLUGIN", "QT_PLUGIN"]

    files: [
        "basictoolsplugin.cpp",
        "basictoolsplugin.h"
    ]
}

