include(CheckCXXCompilerFlag)

function(mangle_flag_name PREFIX FLAG OUTPUT)
  string(TOUPPER "${PREFIX}_${FLAG}" MANGLED_FLAG)
  string(REPLACE "+" "X" MANGLED_FLAG ${MANGLED_FLAG})
  string(REGEX REPLACE "[^A-Za-z_0-9]" "_" MANGLED_FLAG ${MANGLED_FLAG})
  string(REGEX REPLACE "_+" "_" MANGLED_FLAG ${MANGLED_FLAG})
  set(${OUTPUT} "${MANGLED_FLAG}" PARENT_SCOPE)
endfunction()

macro (CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT _FLAG)
  mangle_flag_name("RAWSPEED_HAVE_CXX_FLAG" "${_FLAG}" _RESULT)

  set(CMAKE_REQUIRED_FLAGS_ORIG "${CMAKE_REQUIRED_FLAGS}")
  set(CMAKE_REQUIRED_FLAGS "${CMAKE_CXX_FLAGS}")

  CHECK_CXX_COMPILER_FLAG("${_FLAG}" ${_RESULT})

  if(${${_RESULT}})
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${_FLAG}")
  endif()

  set(CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS_ORIG}")
endmacro ()
