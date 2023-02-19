QT += quick charts core
QT += network

CONFIG += c++11 #qmltypes
#QML_IMPORT_NAME = Test
#QML_IMPORT_MAJOR_VERSION = 1

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        inc/Server_Tcp.cpp \
        inc/thread.cpp \
        main.cpp \
        inc/Server_Tcp.cpp

RESOURCES += qml.qrc \
    font_icon.qrc \
    icon.qrc \
    icon.qrc \
    icon.qrc \
    qml.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

FORMS +=

HEADERS += \
    inc/Server_Tcp.h \
    inc/thread.h

DISTFILES +=
