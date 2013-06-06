/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "mainwindow.h"
#include <QtPlugin>
#include <QApplication>
#include <QDebug>
#include <QTranslator>

Q_IMPORT_PLUGIN(BasicToolsPlugin)

// returns root path of the application
static QString getRootPath()
{
    // Figure out root:  Up one from 'bin' or 'MacOs'
    QDir rootDir = QCoreApplication::applicationDirPath();
    rootDir.cdUp();
    return rootDir.canonicalPath();
}

static inline QString getDefaultTranslationsPath()
{
    const QString rootDirPath = getRootPath();
    // Build path
    QString result = rootDirPath;
#if defined Q_OS_MACX
    result += QLatin1Char('/');
    result += QLatin1String("Resources");
    result += QLatin1Char('/');
    result += QLatin1String("translations");
#elif defined Q_OS_WIN
    result += QLatin1Char('/');
    result += QLatin1String("resources");
    result += QLatin1Char('/');
    result += QLatin1String("translations");
#else
    // not Mac UNIXes
    result += QLatin1Char('/');
    result += QLatin1String("share");
    result += QLatin1Char('/');
    result += qApp->applicationName();
    result += QLatin1Char('/');
    result += QLatin1String("translations");
#endif
    return result;
}

static void loadTranslations()
{
    QString locale = QLocale::system().name();
    QTranslator *translator = new QTranslator();

    QString path = QString("%1_%2").arg(QCoreApplication::applicationName()).arg(locale);
    bool ok = translator->load(path, getDefaultTranslationsPath());
    if (!ok) {
        qWarning() << "PluginManagerPrivate::loadTranslations"
                   << "Failed to load translation file"
                   << path;
    } else {
        qApp->installTranslator(translator);
    }
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setApplicationName(QString(APP_NAME).toLower());
    loadTranslations();

    MainWindow window;
    window.show();
    return app.exec();
}
