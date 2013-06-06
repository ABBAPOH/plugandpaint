import qbs 1.0

Project {

    property string app_target: qbs.targetOS == "mac" ? "PlugAndPaint" : "plugandpaint"
    property string install_app_path: qbs.targetOS == "mac" ? "" : "bin"
    property string lib_suffix: qbs.targetOS == "linux" ? (qbs.architecture == "x86_64" ? "64" : "") : ""
    property string install_library_path: {
        if (qbs.targetOS == "mac")
            return app_target + ".app/Contents/Frameworks"
        else if (qbs.targetOS == "windows")
            return install_app_path
        else
            return "lib" + lib_suffix + "/" + app_target
    }
    property string install_plugin_path: {
        if (qbs.targetOS == "mac")
            return app_target + ".app/Contents/PlugIns"
        else if (qbs.targetOS == "windows")
            return "plugins"
        else
            return install_library_path + "/plugins"
    }
    property string install_data_path: {
        if (qbs.targetOS == "mac")
            return app_target + ".app/Contents/Resources"
        else if (qbs.targetOS == "windows")
            return "resources"
        else
            return "share/" + app_target
    }

    references : [
        "plugandpaint/plugandpaint-app.qbs",
        "plugandpaint/plugandpaint-lib.qbs",
        "plugandpaintplugins/basictools/basictools.qbs",
        "plugandpaintplugins/extrafilters/extrafilters.qbs",
        "translations/translations.qbs"
    ]
}
