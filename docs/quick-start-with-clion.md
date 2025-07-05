# Quickstart guid with clion
1. Open project
2. In the generator field, set it to "Let CMake Decide"
3. Build project

### AddressSanitizer

What AddressSanitizer Will Detect:
- Memory leaks (allocated but never freed)
- Buffer overflows (reading/writing past array bounds)
- Use after free (accessing freed memory)
- Double free (freeing the same memory twice)
- Use after scope (accessing local variables after they go out of scope)
- Initialization order bugs

you can also enable this through the IDE:
1. Go to File → Settings → Build, Execution, Deployment → CMake
2. In CMake options, add: -DENABLE_ASAN=ON
3. Rebuild your project

The AddressSanitizer will now automatically detect and report memory errors when you run your jamstack-server, making it much easier to catch issues like the ones we fixed earlier!
