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
include src/iga/CMakeFiles/iga.dir/depend.make

# Include the progress variables for this target.
include src/iga/CMakeFiles/iga.dir/progress.make

# Include the compile flags for this target's objects.
include src/iga/CMakeFiles/iga.dir/flags.make

src/iga/CMakeFiles/iga.dir/temp.cpp.o: src/iga/CMakeFiles/iga.dir/flags.make
src/iga/CMakeFiles/iga.dir/temp.cpp.o: ../src/iga/temp.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qiang/software/SFEM/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/iga/CMakeFiles/iga.dir/temp.cpp.o"
	cd /home/qiang/software/SFEM/cmake-build-debug/src/iga && /usr/local/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/iga.dir/temp.cpp.o -c /home/qiang/software/SFEM/src/iga/temp.cpp

iga: src/iga/CMakeFiles/iga.dir/temp.cpp.o
iga: src/iga/CMakeFiles/iga.dir/build.make

.PHONY : iga

# Rule to build all files generated by this target.
src/iga/CMakeFiles/iga.dir/build: iga

.PHONY : src/iga/CMakeFiles/iga.dir/build

src/iga/CMakeFiles/iga.dir/clean:
	cd /home/qiang/software/SFEM/cmake-build-debug/src/iga && $(CMAKE_COMMAND) -P CMakeFiles/iga.dir/cmake_clean.cmake
.PHONY : src/iga/CMakeFiles/iga.dir/clean

src/iga/CMakeFiles/iga.dir/depend:
	cd /home/qiang/software/SFEM/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/qiang/software/SFEM /home/qiang/software/SFEM/src/iga /home/qiang/software/SFEM/cmake-build-debug /home/qiang/software/SFEM/cmake-build-debug/src/iga /home/qiang/software/SFEM/cmake-build-debug/src/iga/CMakeFiles/iga.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/iga/CMakeFiles/iga.dir/depend

