cmake_minimum_required(VERSION 3.10)

# Project name
project(HelloASM)

# Assembly source files
set(SOURCE_FILES solve1.asm solve2.asm)

message(STATUS "Source files: ${SOURCE_FILES}")

# Output executables
set(EXECUTABLES solve1 solve2)

# Loop through source files and create build rules
foreach(SOURCE ${SOURCE_FILES})
    # Get the base name of the file (e.g., solve1 from solve1.asm)
    get_filename_component(EXECUTABLE_NAME ${SOURCE} NAME_WE)

    # Define the object file name
    set(OBJECT_FILE ${EXECUTABLE_NAME}.o)

    # Assemble the source file into an object file
    add_custom_command(
        OUTPUT ${OBJECT_FILE}
        COMMAND nasm -f macho64 ${CMAKE_SOURCE_DIR}/${SOURCE} -F dwarf -g -o ${OBJECT_FILE}
        DEPENDS ${SOURCE}
        COMMENT "Assembling ${SOURCE} with NASM"
    )

    # Link the object file into an executable
    add_custom_command(
        OUTPUT ${EXECUTABLE_NAME}
        COMMAND ld ${OBJECT_FILE} -o ${EXECUTABLE_NAME} -macos_version_min 11.0
                -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
                -lSystem -e _start
        DEPENDS ${OBJECT_FILE}
        COMMENT "Linking ${EXECUTABLE_NAME}"
    )

    # Add a custom target for the executable
    add_custom_target(${EXECUTABLE_NAME}_target ALL DEPENDS ${EXECUTABLE_NAME})
endforeach()