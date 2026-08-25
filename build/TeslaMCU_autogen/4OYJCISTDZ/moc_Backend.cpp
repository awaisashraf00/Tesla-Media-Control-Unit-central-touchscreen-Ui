/****************************************************************************
** Meta object code from reading C++ file 'Backend.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../header_files/Backend.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Backend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN7BACKENDE_t {};
} // unnamed namespace

template <> constexpr inline auto BACKEND::qt_create_metaobjectdata<qt_meta_tag_ZN7BACKENDE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "BACKEND",
        "Car_is_locked",
        "",
        "temp_checked",
        "name_set",
        "time_changed",
        "car_locked",
        "temprature",
        "user_name",
        "current_time"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'Car_is_locked'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'temp_checked'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'name_set'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'time_changed'
        QtMocHelpers::SignalData<void()>(5, 2, QMC::AccessPublic, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'car_locked'
        QtMocHelpers::PropertyData<bool>(6, QMetaType::Bool, QMC::DefaultPropertyFlags | QMC::Writable, 0),
        // property 'temprature'
        QtMocHelpers::PropertyData<int>(7, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Writable, 1),
        // property 'user_name'
        QtMocHelpers::PropertyData<QString>(8, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable, 2),
        // property 'current_time'
        QtMocHelpers::PropertyData<QString>(9, QMetaType::QString, QMC::DefaultPropertyFlags, 3),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<BACKEND, qt_meta_tag_ZN7BACKENDE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject BACKEND::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN7BACKENDE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN7BACKENDE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN7BACKENDE_t>.metaTypes,
    nullptr
} };

void BACKEND::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<BACKEND *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->Car_is_locked(); break;
        case 1: _t->temp_checked(); break;
        case 2: _t->name_set(); break;
        case 3: _t->time_changed(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (BACKEND::*)()>(_a, &BACKEND::Car_is_locked, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (BACKEND::*)()>(_a, &BACKEND::temp_checked, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (BACKEND::*)()>(_a, &BACKEND::name_set, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (BACKEND::*)()>(_a, &BACKEND::time_changed, 3))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->car_locked(); break;
        case 1: *reinterpret_cast<int*>(_v) = _t->temprature(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->user_name(); break;
        case 3: *reinterpret_cast<QString*>(_v) = _t->current_time(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->set_car_locked(*reinterpret_cast<bool*>(_v)); break;
        case 1: _t->set_temprature(*reinterpret_cast<int*>(_v)); break;
        case 2: _t->set_user_name(*reinterpret_cast<QString*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *BACKEND::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BACKEND::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN7BACKENDE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int BACKEND::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 4;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void BACKEND::Car_is_locked()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BACKEND::temp_checked()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void BACKEND::name_set()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void BACKEND::time_changed()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
