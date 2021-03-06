# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/qiang/software/clion-2020.3.4/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/qiang/software/clion-2020.3.4/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/qiang/software/SFEM

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/qiang/software/SFEM/cmake-build-debug

# Include any dependencies generated for this target.
include src/sfemlib/CMakeFiles/core.dir/depend.make

# Include the progress variables for this target.
include src/sfemlib/CMakeFiles/core.dir/progress.make

# Include the compile flags for this target's objects.
include src/sfemlib/CMakeFiles/core.dir/flags.make

src/sfemlib/CMakeFiles/core.dir/dof.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/dof.cpp.o: ../src/sfemlib/dof.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/sfemlib/CMakeFiles/core.dir/dof.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/dof.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/dof.cpp

src/sfemlib/CMakeFiles/core.dir/domain.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/domain.cpp.o: ../src/sfemlib/domain.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object src/sfemlib/CMakeFiles/core.dir/domain.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/domain.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/domain.cpp

src/sfemlib/CMakeFiles/core.dir/error.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/error.cpp.o: ../src/sfemlib/error.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object src/sfemlib/CMakeFiles/core.dir/error.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/error.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/error.cpp

src/sfemlib/CMakeFiles/core.dir/field.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/field.cpp.o: ../src/sfemlib/field.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object src/sfemlib/CMakeFiles/core.dir/field.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/field.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/field.cpp

src/sfemlib/CMakeFiles/core.dir/numericalMethod.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/numericalMethod.cpp.o: ../src/sfemlib/numericalMethod.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object src/sfemlib/CMakeFiles/core.dir/numericalMethod.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/numericalMethod.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/numericalMethod.cpp

src/sfemlib/CMakeFiles/core.dir/sparseMatrix.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/sparseMatrix.cpp.o: ../src/sfemlib/sparseMatrix.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object src/sfemlib/CMakeFiles/core.dir/sparseMatrix.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/sparseMatrix.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/sparseMatrix.cpp

src/sfemlib/CMakeFiles/core.dir/timer.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/timer.cpp.o: ../src/sfemlib/timer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object src/sfemlib/CMakeFiles/core.dir/timer.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/timer.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/timer.cpp

src/sfemlib/CMakeFiles/core.dir/workBench.cpp.o: src/sfemlib/CMakeFiles/core.dir/flags.make
src/sfemlib/CMakeFiles/core.dir/workBench.cpp.o: ../src/sfemlib/workBench.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object src/sfemlib/CMakeFiles/core.dir/workBench.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/core.dir/workBench.cpp.o -c /home/qiang/software/SFEM/src/sfemlib/workBench.cpp

core: src/sfemlib/CMakeFiles/core.dir/dof.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/domain.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/error.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/field.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/numericalMethod.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/sparseMatrix.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/timer.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/workBench.cpp.o
core: src/sfemlib/CMakeFiles/core.dir/build.make

.PHONY : core

# Rule to build all files generated by this target.
src/sfemlib/CMakeFiles/core.dir/build: core

.PHONY : src/sfemlib/CMakeFiles/core.dir/build

src/sfemlib/CMakeFiles/core.dir/clean:
	cd /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib && $(CMAKE_COMMAND) -P CMakeFiles/core.dir/cmake_clean.cmake
.PHONY : src/sfemlib/CMakeFiles/core.dir/clean

src/sfemlib/CMakeFiles/core.dir/depend:
	cd /home/qiang/software/SFEM/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/qiang/software/SFEM /home/qiang/software/SFEM/src/sfemlib /home/qiang/software/SFEM/cmake-build-debug /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib /home/qiang/software/SFEM/cmake-build-debug/src/sfemlib/CMakeFiles/core.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/sfemlib/CMakeFiles/core.dir/depend

