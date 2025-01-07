#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/kinovaasrc/kinova_demo"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/test/Downloads/190816_cmtm_code/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/test/Downloads/190816_cmtm_code/catkin_ws/install/lib/python2.7/dist-packages:/home/test/Downloads/190816_cmtm_code/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/test/Downloads/190816_cmtm_code/catkin_ws/build" \
    "/usr/bin/python2" \
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/kinovaasrc/kinova_demo/setup.py" \
     \
    build --build-base "/home/test/Downloads/190816_cmtm_code/catkin_ws/build/kinovaasrc/kinova_demo" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/test/Downloads/190816_cmtm_code/catkin_ws/install" --install-scripts="/home/test/Downloads/190816_cmtm_code/catkin_ws/install/bin"
