# Overview

This is a small demo workspace showing how Zenoh can be used with Bazel. Right now, it shows a full Zenoh build with tests, and a simple example application where a zenohd server is started with multiple plugins, including the backend filesystem plugin.

The `zenoh-cpp` project also shows how C++ bindings can be built, using both zenoh-pico (a C implementation of zenoh) and zenoh-c (a C++ implementation of zenoh).

# Instructions

First, install Bazelisk. You can find the instructions here: https://github.com/bazelbuild/bazelisk.

To checkout the code, clone it and update the submodules:

```bash
git clone https://github.com/asymingt/zenoh_demo.git
git submodule update --init --recursive
```

To build and run the zenoh router, run:

```bash
bazel run //:zenohd

INFO: Analyzed target //:zenohd (119 packages loaded, 5077 targets configured).
INFO: Found 1 target...
Target //:zenohd up-to-date:
  bazel-bin/zenohd
INFO: Elapsed time: 81.224s, Critical Path: 78.52s
INFO: 845 processes: 95 action cache hit, 173 internal, 672 linux-sandbox.
INFO: Build completed successfully, 845 total actions
INFO: Running command line: bazel-bin/zenohd ../zenoh+/zenohd/zenohd ./zenohd.json5
2026-01-28T17:37:45.415022Z  INFO main ThreadId(01) zenohd: zenohd v0.0.0 built with rustc 1.86.0 (05f9846f8 2025-03-31)
2026-01-28T17:37:45.430381Z  INFO main ThreadId(01) zenohd: Initial conf: {"access_control":{"default_permission":"deny","enabled":false,"policies":null,"rules":null,"subjects":null},"adminspace":{"enabled":true,"permissions":{"read":true,"write":true}},"aggregation":{"publishers":[],"subscribers":[]},"connect":{"endpoints":[],"exit_on_failure":{"client":true,"peer":false,"router":false},"retry":{"period_increase_factor":2.0,"period_init_ms":1000,"period_max_ms":4000},"timeout_ms":{"client":0,"peer":-1,"router":-1}},"downsampling":[],"id":null,"listen":{"endpoints":{"peer":["tcp/[::]:0"],"router":["tcp/[::]:7447"]},"exit_on_failure":true,"retry":{"period_increase_factor":2.0,"period_init_ms":1000,"period_max_ms":4000},"timeout_ms":0},"low_pass_filter":[],"metadata":{"location":"Penny Lane","name":"strawberry"},"mode":"peer","namespace":null,"open":{"return_conditions":{"connect_scouted":true,"declares":true}},"plugins":{"rest":{"__required__":true,"http_port":8080},"storage_manager":{"__required__":true,"backend_search_dirs":[".."],"storages":{"demo":{"key_expr":"demo/example/**","strip_prefix":"demo/example","volume":{"dir":"example","id":"fs"}}},"volumes":{"fs":{}}}},"plugins_loading":{"enabled":true,"search_dirs":[".."]},"qos":{"network":[],"publication":[]},"queries_default_timeout":10000,"routing":{"interests":{"timeout":10000},"peer":{"linkstate":{"transport_weights":[]},"mode":"peer_to_peer"},"router":{"linkstate":{"transport_weights":[]},"peers_failover_brokering":true}},"scouting":{"delay":500,"gossip":{"autoconnect":{"peer":["router","peer"],"router":[]},"autoconnect_strategy":{"peer":{"to_peer":"always","to_router":"always"}},"enabled":true,"multihop":false,"target":{"peer":["router","peer"],"router":["router","peer"]}},"multicast":{"address":"224.0.0.224:7446","autoconnect":{"client":["router"],"peer":["router","peer"],"router":[]},"autoconnect_strategy":{"peer":{"to_peer":"always","to_router":"always"}},"enabled":true,"interface":"auto","listen":true,"ttl":1},"timeout":3000},"stats":{"filters":[]},"timestamping":{"drop_future_timestamp":false,"enabled":{"client":true,"peer":true,"router":true}},"transport":{"auth":{"pubkey":{"key_size":null,"known_keys_file":null,"private_key_file":null,"private_key_pem":null,"public_key_file":null,"public_key_pem":null},"usrpwd":{"dictionary_file":null,"password":null,"user":null}},"link":{"protocols":null,"rx":{"buffer_size":65535,"max_message_size":1073741824},"tcp":{"so_rcvbuf":null,"so_sndbuf":null},"tls":{"close_link_on_expiration":false,"connect_certificate":null,"connect_private_key":null,"enable_mtls":false,"listen_certificate":null,"listen_private_key":null,"root_ca_certificate":null,"so_rcvbuf":null,"so_sndbuf":null,"verify_name_on_connect":true},"tx":{"batch_size":65535,"keep_alive":4,"lease":10000,"queue":{"allocation":{"mode":"lazy"},"batching":{"enabled":true,"time_limit":1},"congestion_control":{"block":{"wait_before_close":5000000},"drop":{"max_wait_before_drop_fragments":50000,"wait_before_drop":1000}},"size":{"background":2,"control":2,"data":2,"data_high":2,"data_low":2,"interactive_high":2,"interactive_low":2,"real_time":2}},"sequence_number_resolution":"32bit","threads":16},"unixpipe":{"file_access_mask":null}},"multicast":{"compression":{"enabled":false},"join_interval":2500,"max_sessions":1000,"qos":{"enabled":false}},"shared_memory":{"enabled":true,"mode":"lazy","transport_optimization":{"enabled":true,"message_size_threshold":3072,"pool_size":16777216}},"unicast":{"accept_pending":100,"accept_timeout":10000,"compression":{"enabled":false},"lowlatency":false,"max_links":1,"max_sessions":1000,"open_timeout":10000,"qos":{"enabled":true}}}}
2026-01-28T17:37:45.431313Z  INFO main ThreadId(01) zenoh::net::runtime: Using ZID: ebbd6e8b91af993954db5da5d1fe4675
2026-01-28T17:37:45.432888Z  INFO main ThreadId(01) zenoh::api::loader: Loading required plugin "rest"
2026-01-28T17:37:45.473023Z  INFO main ThreadId(01) zenoh::api::loader: Loading required plugin "storage_manager"
2026-01-28T17:37:45.511898Z  INFO main ThreadId(01) zenoh::api::loader: Starting required plugin "rest"
2026-01-28T17:37:45.514944Z  INFO main ThreadId(01) zenoh::api::loader: Successfully started plugin rest from "../libzenoh_plugin_rest.so"
2026-01-28T17:37:45.514989Z  INFO main ThreadId(01) zenoh::api::loader: Finished loading plugins
2026-01-28T17:37:45.515003Z  INFO main ThreadId(01) zenoh::api::loader: Starting required plugin "storage_manager"
2026-01-28T17:37:45.614052Z  INFO main ThreadId(01) zenoh::api::loader: Successfully started plugin storage_manager from "../libzenoh_plugin_storage_manager.so"
2026-01-28T17:37:45.614109Z  INFO main ThreadId(01) zenoh::api::loader: Finished loading plugins
2026-01-28T17:37:45.615618Z  INFO main ThreadId(01) zenoh::net::runtime::orchestrator: Zenoh can be reached at: tcp/[fe80::9088:780c:50d2:ef1a]:46409
2026-01-28T17:37:45.615677Z  INFO main ThreadId(01) zenoh::net::runtime::orchestrator: Zenoh can be reached at: tcp/[fe80::4ccc:35ff:fe24:5461]:46409
2026-01-28T17:37:45.615689Z  INFO main ThreadId(01) zenoh::net::runtime::orchestrator: Zenoh can be reached at: tcp/[fe80::38d3:48ff:fe63:f164]:46409
2026-01-28T17:37:45.615699Z  INFO main ThreadId(01) zenoh::net::runtime::orchestrator: Zenoh can be reached at: tcp/172.19.27.44:46409
2026-01-28T17:37:45.615712Z  INFO main ThreadId(01) zenoh::net::runtime::orchestrator: Zenoh can be reached at: tcp/192.168.10.1:46409
2026-01-28T17:37:45.615843Z  INFO main ThreadId(01) zenoh::net::runtime::orchestrator: zenohd listening scout messages on 224.0.0.224:7446
```

To build and run the C++ tests to verify the zenoh-cpp build, use the following command:

```bash
bazel test @zenoh-cpp//...
INFO: Analyzed 36 targets (0 packages loaded, 0 targets configured).
INFO: Found 19 targets and 17 test targets...
INFO: Elapsed time: 0.650s, Critical Path: 0.00s
INFO: 1 process: 206 action cache hit, 1 internal.
INFO: Build completed successfully, 1 total action
@zenoh-cpp//:tests_build_warnings                               (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_bytes                              (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_closures                           (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_details                            (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_network_advanced_pub_sub           (cached) PASSED in 30.1s
@zenoh-cpp//:tests_universal_network_cancellation               (cached) PASSED in 37.1s
@zenoh-cpp//:tests_universal_network_keyexpr                    (cached) PASSED in 12.6s
@zenoh-cpp//:tests_universal_network_liveliness                 (cached) PASSED in 20.1s
@zenoh-cpp//:tests_universal_network_pub_sub                    (cached) PASSED in 60.7s
@zenoh-cpp//:tests_universal_network_queryable_get              (cached) PASSED in 19.6s
@zenoh-cpp//:tests_universal_network_source_info                (cached) PASSED in 32.1s
@zenoh-cpp//:tests_universal_serialization                      (cached) PASSED in 12.1s
@zenoh-cpp//:tests_zenohc_config                                (cached) PASSED in 12.1s
@zenoh-cpp//:tests_zenohc_shm_api                               (cached) PASSED in 15.2s
@zenoh-cpp//:tests_zenohpico_config                                     SKIPPED
@zenoh-cpp//:tests_zenohpico_network_batching                           SKIPPED
@zenoh-cpp//:tests_zenohpico_network_tasks                              SKIPPED
```

By default, `zenoh-cpp` is built above `zenoh-c`. To build it against `zenoh-pico` just add `--@zenoh-cpp//:use_zenoh_pico=true` to your `.bazelrc` or as a command line flag. For example:

```
bazel test @zenoh-cpp//... --@zenoh-cpp//:use_zenoh_pico=true
INFO: Analyzed 36 targets (0 packages loaded, 0 targets configured).
INFO: Found 19 targets and 17 test targets...
INFO: Elapsed time: 0.613s, Critical Path: 0.00s
INFO: 1 process: 124 action cache hit, 1 internal.
INFO: Build completed successfully, 1 total action
@zenoh-cpp//:tests_build_warnings                               (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_bytes                              (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_closures                           (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_details                            (cached) PASSED in 12.1s
@zenoh-cpp//:tests_universal_network_advanced_pub_sub           (cached) PASSED in 35.4s
@zenoh-cpp//:tests_universal_network_cancellation               (cached) PASSED in 48.7s
@zenoh-cpp//:tests_universal_network_keyexpr                    (cached) PASSED in 15.4s
@zenoh-cpp//:tests_universal_network_liveliness                 (cached) PASSED in 28.7s
@zenoh-cpp//:tests_universal_network_pub_sub                    (cached) PASSED in 42.1s
@zenoh-cpp//:tests_universal_network_queryable_get              (cached) PASSED in 32.1s
@zenoh-cpp//:tests_universal_network_source_info                (cached) PASSED in 45.4s
@zenoh-cpp//:tests_universal_serialization                      (cached) PASSED in 12.1s
@zenoh-cpp//:tests_zenohpico_config                             (cached) PASSED in 12.1s
@zenoh-cpp//:tests_zenohpico_network_batching                   (cached) PASSED in 28.7s
@zenoh-cpp//:tests_zenohpico_network_tasks                      (cached) PASSED in 18.7s
@zenoh-cpp//:tests_zenohc_config                                        SKIPPED
@zenoh-cpp//:tests_zenohc_shm_api                                       SKIPPED
```

# Notes

1. We build `zenoh` from source using `rules_rust` and crates universe to grab its dependencies.
2. We build `librocksdb-sys` from source in order to use our hermetic clang toolchain. It uses `@rocksdb` from the BCR which is not version-matche. We should fix this.
3. We build `zenoh-backend-filesystem` with crate.annotations to ensure that it gets the correct versions of `serde_json` and `async-trait` (local versus from `zenoh`).
4. The zenohd plugins are shared objects that are loaded at runtime. We have a Starlark rule called `remap_runfiles` that remaps the runfiles to the root of the runfiles tree. This allows us to set the plugin and backend plugin search paths to `..` to find them reliably. See the example configuration below.
5. The `zenoh-cpp` module uses the `zeno-pico` C implementation of zenoh. However, since this does not include a `zenohd` binary, we re-use the target from our `zenoh` module as a router instance for the tests. 
6. Some `zenoh` and `zenoh-pico` tests don't yet pass because they are busy being ported from the cmake build system.

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