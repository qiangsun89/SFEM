file(REMOVE_RECURSE
  "libsfem.pdb"
  "libsfem.so"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/libsfem.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
