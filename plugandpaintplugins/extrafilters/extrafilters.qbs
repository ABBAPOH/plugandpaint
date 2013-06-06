import qbs 1.0

DynamicLibrary {
    name: "pnp_extrafilters"

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["core", "widgets"] }

    cpp.includePaths: "../../"
    Properties {
        condition: qbs.targetOS == "mac"
        cpp.installNamePrefix: "@executable_path/../Frameworks/"
    }

    Properties {
         condition: qbs.targetOS == "linux" || qbs.targetOS == "unix"
         cpp.rpaths: "$ORIGIN/../.."
    }

    files: [
        "extrafiltersplugin.cpp",
        "extrafiltersplugin.h"
    ]

    Group {
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: project.install_plugin_path
    }
}

