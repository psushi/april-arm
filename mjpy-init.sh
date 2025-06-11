
  # Find the path to LIBDIR and LDLIBRARY (dylib file) on your system:
  PYTHON_LIB_DIR=$(python3 -c 'from distutils.sysconfig import get_config_var; print(get_config_var("LIBDIR"))')
  PYTHON_LIB_NAME=$(python3 -c 'from distutils.sysconfig import get_config_var; print(get_config_var("LDLIBRARY"))')
  # Soft link it inside your virtual environment:
  ln -s "$PYTHON_LIB_DIR/$PYTHON_LIB_NAME" ./.venv/lib/$PYTHON_LIB_NAME
