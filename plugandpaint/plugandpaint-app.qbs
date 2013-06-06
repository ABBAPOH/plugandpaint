import qbs 1.0

Application {
    name: project.app_target
    consoleApplication: false

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["core", "widgets"] }
    Depends { name: "plugandpaint-lib" }
    Depends { name: "pnp_basictools" }

    Properties {
        condition: qbs.targetOS == "linux" || qbs.targetOS == "unix"
        cpp.rpaths: [ "$ORIGIN/../lib" + project.lib_suffix + "/" + project.app_target ]
    }
    cpp.defines: "APP_NAME=\"" + project.app_target + "\""

    files : [
        "main.cpp"
    ]

    Group {
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: project.install_app_path
    }

    Group {
        name: "plugandpaint.icns"
        condition: qbs.targetOS == "mac"
        files: "PlugAndPaint.icns"
        qbs.install: true
        qbs.installDir: install_data_path
    }
    Group {
        name: "plugandpaint.rc"
        condition: qbs.targetOS == "windows"
        files: "plugandpaint.rc"
    }
    Group {
        name: "plugandpaint.desktop"
        condition: qbs.targetOS == "linux" || qbs.targetOS == "unix"
        files: "plugandpaint.desktop"
        qbs.install: true
        qbs.installDir: "share/applications"
    }
    Group {
        name: "plugandpaint.png"
        condition: qbs.targetOS == "linux" || qbs.targetOS == "unix"
        files: "plugandpaint.png"
        qbs.install: true
        qbs.installDir: "share/pixmaps"
    }
}
