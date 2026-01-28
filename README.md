# Overview

This is a small demo workspace showing how Zenoh can be used with Bazel. Right now, it shows a full Zenoh build with tests, and a simple example application where a zenohd server is started with multiple plugins, including the backend filesystem plugin. This is done without `rules_oci`, and we plan to add C and C++ support.

# Instructions

First, install Bazelisk. You can find the instructions here: https://github.com/bazelbuild/bazelisk.

To checkout the code, clone it and update the submodules:

```bash
git clone https://github.com/asymingt/zenoh_demo.git
git submodule update --init --recursive
```

To build and run the example application, run:

```bash
bazel run //:zenohd
```

To build and run tests, use the following commands:

```bash
bazel test @zenoh//...
bazel test @rust-rocksdb//...
bazel test @zenoh-backend-filesystem//...
```

# Notes

1. We build `zenoh` from source using `rules_rust` and crates universe to grab its dependencies.
2. We build `librocksdb-sys` from source in order to use our hermetic clang toolchain. It uses `@rocksdb` from the BCR which is not version-matche. We should fix this.
3. We build `zenoh-backend-filesystem` with crate.annotations to ensure that it gets the correct versions of `serde_json` and `async-trait` (local versus from `zenoh`).
4. The zenohd plugins are shared objects that are loaded at runtime. We have a Starlark rule called `remap_runfiles` that remaps the runfiles to the root of the runfiles tree. This allows us to set the plugin and backend plugin search paths to `..` to find them reliably. See the example configuration below.

```json5
{
  ...

  plugins_loading: {
    enabled: true,
    search_dirs: [".."]   # <---- IMPORTANT for regular plugins
  },

  plugins: {
    rest: {
      __required__: true,
      http_port: 8080,
    },
    storage_manager: {
      __required__: true,
      backend_search_dirs: [".."],   # <---- IMPORTANT for backend plugins
      volumes: {
          fs: {},
        },
        storages: {
          demo: {
            key_expr: "demo/example/**",
            strip_prefix: "demo/example",
            volume: {
              id: "fs",
              dir: "example"
            }
          }
        }
    },
  },
}
```