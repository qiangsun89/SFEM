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

# Utility rule file for cppcheck.

# Include the progress variables for this target.
include CMakeFiles/cppcheck.dir/progress.make

cppcheck: CMakeFiles/cppcheck.dir/build.make
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Running cppcheck on entire source"
	cppcheck --xml --template=gcc --enable=all -I/home/qiang/software/SFEM/cmake-build-debug/ -I/home/qiang/software/SFEM/src/sfemlib/ -I/home/qiang/software/SFEM/src/sm/ -I/home/qiang/software/SFEM/src/fm/ -I/home/qiang/software/SFEM/src/tm/ -DDEBUG /home/qiang/software/SFEM/src/sfemlib/ /home/qiang/software/SFEM/src/sm/ /home/qiang/software/SFEM/src/fm/ /home/qiang/software/SFEM/src/tm/ /home/qiang/software/SFEM/src/main/ 2> cppcheck.xml
.PHONY : cppcheck

# Rule to build all files generated by this target.
CMakeFiles/cppcheck.dir/build: cppcheck

.PHONY : CMakeFiles/cppcheck.dir/build

CMakeFiles/cppcheck.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/cppcheck.dir/cmake_clean.cmake
.PHONY : CMakeFiles/cppcheck.dir/clean

CMakeFiles/cppcheck.dir/depend:
	cd /home/qiang/software/SFEM/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/qiang/software/SFEM /home/qiang/software/SFEM /home/qiang/software/SFEM/cmake-build-debug /home/qiang/software/SFEM/cmake-build-debug /home/qiang/software/SFEM/cmake-build-debug/CMakeFiles/cppcheck.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/cppcheck.dir/depend

