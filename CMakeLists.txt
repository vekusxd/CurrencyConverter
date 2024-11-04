cmake_minimum_required(VERSION 3.16)

project(CurrencyConverter VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Network Svg)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appCurrencyConverter
    main.cpp
)

qt_add_qml_module(appCurrencyConverter
    URI CurrencyConverter
    VERSION 1.0
    QML_FILES
        Main.qml
    RESOURCES
        Assets/ru.svg
        Assets/default.json
        SOURCES CurrencyEntry.h CurrencyEntry.cpp
        SOURCES CurrencyListModel.h CurrencyListModel.cpp
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCurrencyConverter PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCurrencyConverter
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCurrencyConverter
    PRIVATE
        Qt6::Quick
        Qt6::Network
        Qt6::Svg
)

qt6_import_plugins(appCurrencyConverter INCLUDE Qt6::QSvgPlugin)

include(GNUInstallDirs)
install(TARGETS appCurrencyConverter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
