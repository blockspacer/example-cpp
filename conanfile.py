import os
from conans import ConanFile, CMake, tools


class ExampleCppConan(ConanFile):
    name = "example-cpp"
    version = "0.1.5"
    license = "MIT"
    url = "https://github.com/ajaivgeorge/example-cpp"
    description = "Example Cpp project"
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake", "virtualenv"
    requires = (
        "boost/1.70.0@conan/stable",
    )
    build_requires = (
        "gtest/1.8.1@bincrafters/stable",
        "google-benchmark/1.4.1@mpusz/stable",
    )
    exports_sources = "*"
    options = {"shared": [True, False], "debug": [True, False]}
    default_options = (
        "shared=True",
        "debug=False",
    )

    def build(self):
        cmake = CMake(self)
        cmake.definitions["CONAN_AUTO_INSTALL"] = False
        cmake.definitions["USE_CLANG_TIDY"] = False
        cmake.configure()
        cmake.build(args=["--", "-j%s" % tools.cpu_count()])

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        self.cpp_info.includedirs = ["include"]
        self.cpp_info.libs = tools.collect_libs(self)
        self.cpp_info.libdirs = ["lib"]
        self.cpp_info.bindirs = ["bin"]
        self.env_info.LD_LIBRARY_PATH.append(
            os.path.join(self.package_folder, "lib"))
        self.env_info.PATH.append(os.path.join(self.package_folder, "bin"))
        for libpath in self.deps_cpp_info.lib_paths:
            self.env_info.LD_LIBRARY_PATH.append(libpath)
