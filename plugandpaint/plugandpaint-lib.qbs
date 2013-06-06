import qbs 1.0

DynamicLibrary {
    name: "plugandpaint-lib"

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["core", "widgets"] }

    Properties {
        condition: qbs.targetOS == "mac"
        cpp.installNamePrefix: "@executable_path/../Frameworks/"
    }

    Properties {
         condition: qbs.targetOS == "linux" || qbs.targetOS == "unix"
         cpp.rpaths: "$ORIGIN"
    }

    cpp.defines: "PLUGANDPAINT_LIBRARY"

    files : [
        "interfaces.h",
        "mainwindow.cpp",
        "mainwindow.h",
        "paintarea.cpp",
        "paintarea.h",
        "plugandpaint.qrc",
        "plugandpaint_global.h",
        "plugindialog.cpp",
        "plugindialog.h"
    ]

    Group {
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: project.install_library_path
    }
}
