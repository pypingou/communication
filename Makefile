# Score Communication Module Makefile
# Generated from Bazel BUILD file analysis
#
# This Makefile replaces the Bazel build system for the Score Communication middleware.
# Based on extracted build configurations from score/mw/com BUILD files.

# =============================================================================
# Configuration
# =============================================================================

# Compiler settings (from Bazel features)
CXX = g++
CC = gcc
CXXSTD = -std=c++17

# Compiler flags extracted from Bazel features
WARN_FLAGS = -Wall -Wno-error=deprecated-declarations -Wextra -Wpedantic -Werror
OPT_FLAGS = -O2 -g

# GCC 15+ compatibility flags (ensures required standard library headers are included)
GCC15_COMPAT_FLAGS = -include cstdint

# Note: CXXFLAGS can be overridden by RPM build, so we ensure -fPIC in compilation rules
CXXFLAGS ?= $(CXXSTD) $(WARN_FLAGS) $(OPT_FLAGS) $(GCC15_COMPAT_FLAGS) -fPIC -pthread
CFLAGS ?= $(WARN_FLAGS) $(OPT_FLAGS) -fPIC -pthread

# Mandatory flags for shared library compilation (cannot be overridden)
SHARED_LIB_FLAGS = -fPIC -pthread

# Include directories (using system-installed score-baselibs)
INCLUDES = -I. \
           -Iscore \
           -Iscore/mw/com \
           -Iscore/mw/com/impl \
           -Iscore/message_passing \
           -Ithird_party \
           -I/usr/include \
           -I/usr/include/score \
           -I/usr/include/score/language/futurecpp/include \
           -I/usr/include/score/static_reflection_with_serialization/visitor/include

# Library directories and links
LDFLAGS ?= -shared -pthread
LIBS = -pthread -lrt -ldl -lacl -lcap --coverage
# System library search paths for baselibs shared libraries
SCORE_LIB_PATHS = -L/usr/lib64 -L/usr/lib
SCORE_LIBS = -lscore_memory -lscore_utils -lscore_filesystem -lscore_containers -lscore_concurrency -lscore_json -lscore_os -lscore_log -lscore_analysis -lscore_safecpp -lscore_quality -lscore_result -lscore_futurecpp
BOOST_LIBS = -lboost_program_options

# Mandatory flags for shared library linking (cannot be overridden)
SHARED_LDFLAGS = -shared

# Build directories
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
LIB_DIR = $(BUILD_DIR)/lib
BIN_DIR = $(BUILD_DIR)/bin

# Output libraries
MAIN_LIB = $(LIB_DIR)/libscore-mw-com.so
MESSAGE_PASSING_LIB = $(LIB_DIR)/libscore-message-passing.so

# =============================================================================
# Source Files (extracted from BUILD file analysis)
# =============================================================================

# Core library sources (from //score/mw/com:com dependencies)
CORE_SOURCES = \
	score/mw/com/com_error_domain.cpp \
	score/mw/com/runtime.cpp \
	score/mw/com/runtime_configuration.cpp \
	score/mw/com/types.cpp

# Implementation library sources (from //score/mw/com/impl)
IMPL_SOURCES = \
	score/mw/com/impl/binding_type.cpp \
	score/mw/com/impl/com_error.cpp \
	score/mw/com/impl/enriched_instance_identifier.cpp \
	score/mw/com/impl/event_receive_handler.cpp \
	score/mw/com/impl/find_service_handle.cpp \
	score/mw/com/impl/find_service_handler.cpp \
	score/mw/com/impl/flag_owner.cpp \
	score/mw/com/impl/generic_proxy.cpp \
	score/mw/com/impl/generic_proxy_event_binding.cpp \
	score/mw/com/impl/generic_proxy_event.cpp \
	score/mw/com/impl/handle_type.cpp \
	score/mw/com/impl/instance_identifier.cpp \
	score/mw/com/impl/instance_specifier.cpp \
	score/mw/com/impl/i_runtime_binding.cpp \
	score/mw/com/impl/i_runtime.cpp \
	score/mw/com/impl/i_service_discovery_client.cpp \
	score/mw/com/impl/i_service_discovery.cpp \
	score/mw/com/impl/proxy_base.cpp \
	score/mw/com/impl/proxy_binding.cpp \
	score/mw/com/impl/proxy_event_base.cpp \
	score/mw/com/impl/proxy_event_binding_base.cpp \
	score/mw/com/impl/proxy_event_binding.cpp \
	score/mw/com/impl/proxy_event.cpp \
	score/mw/com/impl/proxy_field.cpp \
	score/mw/com/impl/runtime.cpp \
	score/mw/com/impl/sample_reference_tracker.cpp \
	score/mw/com/impl/scoped_event_receive_handler.cpp \
	score/mw/com/impl/service_discovery.cpp \
	score/mw/com/impl/service_element_map.cpp \
	score/mw/com/impl/service_element_type.cpp \
	score/mw/com/impl/skeleton_base.cpp \
	score/mw/com/impl/skeleton_binding.cpp \
	score/mw/com/impl/skeleton_event_base.cpp \
	score/mw/com/impl/skeleton_event_binding.cpp \
	score/mw/com/impl/skeleton_event.cpp \
	score/mw/com/impl/skeleton_field_base.cpp \
	score/mw/com/impl/skeleton_field.cpp \
	score/mw/com/impl/subscription_state.cpp \
	score/mw/com/impl/traits.cpp

# Configuration sources
CONFIG_SOURCES = \
	score/mw/com/impl/configuration/binding_service_type_deployment.cpp \
	score/mw/com/impl/configuration/config_parser.cpp \
	score/mw/com/impl/configuration/configuration_common_resources.cpp \
	score/mw/com/impl/configuration/configuration.cpp \
	score/mw/com/impl/configuration/configuration_error.cpp \
	score/mw/com/impl/configuration/global_configuration.cpp \
	score/mw/com/impl/configuration/lola_event_id.cpp \
	score/mw/com/impl/configuration/lola_event_instance_deployment.cpp \
	score/mw/com/impl/configuration/lola_field_id.cpp \
	score/mw/com/impl/configuration/lola_field_instance_deployment.cpp \
	score/mw/com/impl/configuration/lola_service_id.cpp \
	score/mw/com/impl/configuration/lola_service_instance_deployment.cpp \
	score/mw/com/impl/configuration/lola_service_instance_id.cpp \
	score/mw/com/impl/configuration/lola_service_type_deployment.cpp \
	score/mw/com/impl/configuration/quality_type.cpp \
	score/mw/com/impl/configuration/service_identifier_type.cpp \
	score/mw/com/impl/configuration/service_instance_deployment.cpp \
	score/mw/com/impl/configuration/service_instance_id.cpp \
	score/mw/com/impl/configuration/service_type_deployment.cpp \
	score/mw/com/impl/configuration/service_version_type.cpp \
	score/mw/com/impl/configuration/shm_size_calc_mode.cpp \
	score/mw/com/impl/configuration/someip_event_instance_deployment.cpp \
	score/mw/com/impl/configuration/someip_field_instance_deployment.cpp \
	score/mw/com/impl/configuration/someip_service_instance_deployment.cpp \
	score/mw/com/impl/configuration/someip_service_instance_id.cpp \
	score/mw/com/impl/configuration/tracing_configuration.cpp

# Plumbing layer sources
PLUMBING_SOURCES = \
	score/mw/com/impl/plumbing/proxy_binding_factory.cpp \
	score/mw/com/impl/plumbing/proxy_binding_factory_impl.cpp \
	score/mw/com/impl/plumbing/proxy_event_binding_factory.cpp \
	score/mw/com/impl/plumbing/proxy_event_binding_factory_impl.cpp \
	score/mw/com/impl/plumbing/proxy_field_binding_factory.cpp \
	score/mw/com/impl/plumbing/proxy_field_binding_factory_impl.cpp \
	score/mw/com/impl/plumbing/proxy_service_element_binding_factory_impl.cpp \
	score/mw/com/impl/plumbing/runtime_binding_factory.cpp \
	score/mw/com/impl/plumbing/sample_allocatee_ptr.cpp \
	score/mw/com/impl/plumbing/sample_ptr.cpp \
	score/mw/com/impl/plumbing/skeleton_binding_factory.cpp \
	score/mw/com/impl/plumbing/skeleton_binding_factory_impl.cpp \
	score/mw/com/impl/plumbing/skeleton_event_binding_factory.cpp \
	score/mw/com/impl/plumbing/skeleton_event_binding_factory_impl.cpp \
	score/mw/com/impl/plumbing/skeleton_field_binding_factory.cpp \
	score/mw/com/impl/plumbing/skeleton_field_binding_factory_impl.cpp \
	score/mw/com/impl/plumbing/skeleton_service_element_binding_factory_impl.cpp

# LoLa binding sources (zero-copy implementation)
LOLA_SOURCES = \
	score/mw/com/impl/bindings/lola/application_id_pid_mapping.cpp \
	score/mw/com/impl/bindings/lola/application_id_pid_mapping_entry.cpp \
	score/mw/com/impl/bindings/lola/control_slot_composite_indicator.cpp \
	score/mw/com/impl/bindings/lola/control_slot_indicator.cpp \
	score/mw/com/impl/bindings/lola/control_slot_types.cpp \
	score/mw/com/impl/bindings/lola/data_type_meta_info.cpp \
	score/mw/com/impl/bindings/lola/element_fq_id.cpp \
	score/mw/com/impl/bindings/lola/event_control.cpp \
	score/mw/com/impl/bindings/lola/event_data_control_composite.cpp \
	score/mw/com/impl/bindings/lola/event_data_control.cpp \
	score/mw/com/impl/bindings/lola/event_data_storage.cpp \
	score/mw/com/impl/bindings/lola/event_meta_info.cpp \
	score/mw/com/impl/bindings/lola/event_slot_status.cpp \
	score/mw/com/impl/bindings/lola/event_subscription_control.cpp \
	score/mw/com/impl/bindings/lola/generic_proxy_event.cpp \
	score/mw/com/impl/bindings/lola/partial_restart_path_builder.cpp \
	score/mw/com/impl/bindings/lola/path_builder.cpp \
	score/mw/com/impl/bindings/lola/proxy.cpp \
	score/mw/com/impl/bindings/lola/proxy_event_common.cpp \
	score/mw/com/impl/bindings/lola/proxy_event.cpp \
	score/mw/com/impl/bindings/lola/rollback_synchronization.cpp \
	score/mw/com/impl/bindings/lola/runtime.cpp \
	score/mw/com/impl/bindings/lola/sample_allocatee_ptr.cpp \
	score/mw/com/impl/bindings/lola/sample_ptr.cpp \
	score/mw/com/impl/bindings/lola/service_data_control.cpp \
	score/mw/com/impl/bindings/lola/service_data_storage.cpp \
	score/mw/com/impl/bindings/lola/shm_path_builder.cpp \
	score/mw/com/impl/bindings/lola/skeleton.cpp \
	score/mw/com/impl/bindings/lola/skeleton_event.cpp \
	score/mw/com/impl/bindings/lola/skeleton_event_properties.cpp \
	score/mw/com/impl/bindings/lola/slot_collector.cpp \
	score/mw/com/impl/bindings/lola/slot_decrementer.cpp \
	score/mw/com/impl/bindings/lola/subscription_helpers.cpp \
	score/mw/com/impl/bindings/lola/subscription_not_subscribed_states.cpp \
	score/mw/com/impl/bindings/lola/subscription_state_base.cpp \
	score/mw/com/impl/bindings/lola/subscription_state_machine.cpp \
	score/mw/com/impl/bindings/lola/subscription_state_machine_states.cpp \
	score/mw/com/impl/bindings/lola/subscription_subscribed_states.cpp \
	score/mw/com/impl/bindings/lola/subscription_subscription_pending_states.cpp \
	score/mw/com/impl/bindings/lola/transaction_log.cpp \
	score/mw/com/impl/bindings/lola/transaction_log_id.cpp \
	score/mw/com/impl/bindings/lola/transaction_log_registration_guard.cpp \
	score/mw/com/impl/bindings/lola/transaction_log_rollback_executor.cpp \
	score/mw/com/impl/bindings/lola/transaction_log_set.cpp \
	score/mw/com/impl/bindings/lola/transaction_log_slot.cpp \
	score/mw/com/impl/bindings/lola/type_erased_sample_ptrs_guard.cpp

# LoLa messaging sources
LOLA_MESSAGING_SOURCES = \
	score/mw/com/impl/bindings/lola/messaging/i_message_passing_service.cpp \
	score/mw/com/impl/bindings/lola/messaging/message_passing_client_cache.cpp \
	score/mw/com/impl/bindings/lola/messaging/message_passing_control.cpp \
	score/mw/com/impl/bindings/lola/messaging/message_passing_facade.cpp \
	score/mw/com/impl/bindings/lola/messaging/message_passing_service.cpp \
	score/mw/com/impl/bindings/lola/messaging/message_passing_service_instance.cpp \
	score/mw/com/impl/bindings/lola/messaging/messages/message_common.cpp \
	score/mw/com/impl/bindings/lola/messaging/messages/message_element_fq_id.cpp \
	score/mw/com/impl/bindings/lola/messaging/messages/message_outdated_nodeid.cpp \
	score/mw/com/impl/bindings/lola/messaging/node_identifier_copier.cpp \
	score/mw/com/impl/bindings/lola/messaging/notify_event_handler.cpp \
	score/mw/com/impl/bindings/lola/messaging/thread_abstraction.cpp

# LoLa service discovery sources
LOLA_SERVICE_DISCOVERY_SOURCES = \
	score/mw/com/impl/bindings/lola/service_discovery/client/service_discovery_client.cpp \
	score/mw/com/impl/bindings/lola/service_discovery/flag_file.cpp \
	score/mw/com/impl/bindings/lola/service_discovery/flag_file_crawler.cpp \
	score/mw/com/impl/bindings/lola/service_discovery/known_instances_container.cpp \
	score/mw/com/impl/bindings/lola/service_discovery/lola_service_instance_identifier.cpp \
	score/mw/com/impl/bindings/lola/service_discovery/quality_aware_container.cpp

# Tracing sources
TRACING_SOURCES = \
	score/mw/com/impl/tracing/common_event_tracing.cpp \
	score/mw/com/impl/tracing/proxy_event_tracing.cpp \
	score/mw/com/impl/tracing/proxy_event_tracing_data.cpp \
	score/mw/com/impl/tracing/service_element_tracing_data.cpp \
	score/mw/com/impl/tracing/skeleton_event_tracing.cpp \
	score/mw/com/impl/tracing/skeleton_event_tracing_data.cpp \
	score/mw/com/impl/tracing/skeleton_tracing.cpp \
	score/mw/com/impl/tracing/trace_error.cpp \
	score/mw/com/impl/tracing/tracing_runtime.cpp \
	score/mw/com/impl/tracing/type_erased_sample_ptr.cpp

# Tracing configuration sources
TRACING_CONFIG_SOURCES = \
	score/mw/com/impl/tracing/configuration/hash_helper_for_service_element_and_se_view.cpp \
	score/mw/com/impl/tracing/configuration/hash_helper_utility.cpp \
	score/mw/com/impl/tracing/configuration/proxy_event_trace_point_type.cpp \
	score/mw/com/impl/tracing/configuration/proxy_field_trace_point_type.cpp \
	score/mw/com/impl/tracing/configuration/service_element_identifier.cpp \
	score/mw/com/impl/tracing/configuration/service_element_identifier_view.cpp \
	score/mw/com/impl/tracing/configuration/service_element_instance_identifier_view.cpp \
	score/mw/com/impl/tracing/configuration/skeleton_event_trace_point_type.cpp \
	score/mw/com/impl/tracing/configuration/skeleton_field_trace_point_type.cpp \
	score/mw/com/impl/tracing/configuration/trace_point_key.cpp \
	score/mw/com/impl/tracing/configuration/tracing_config.cpp \
	score/mw/com/impl/tracing/configuration/tracing_filter_config.cpp \
	score/mw/com/impl/tracing/configuration/tracing_filter_config_parser.cpp

# LoLa tracing sources
LOLA_TRACING_SOURCES = \
	score/mw/com/impl/bindings/lola/tracing/tracing_runtime.cpp

# Message passing library sources (separate library)
MESSAGE_PASSING_SOURCES = \
	score/mw/com/message_passing/message.cpp \
	score/mw/com/message_passing/mqueue/mqueue_receiver_factory.cpp \
	score/mw/com/message_passing/mqueue/mqueue_receiver_traits.cpp \
	score/mw/com/message_passing/mqueue/mqueue_sender_factory.cpp \
	score/mw/com/message_passing/mqueue/mqueue_sender_traits.cpp \
	score/mw/com/message_passing/non_blocking_sender.cpp \
	score/mw/com/message_passing/receiver_factory.cpp \
	score/mw/com/message_passing/sender_factory.cpp \
	score/mw/com/message_passing/serializer.cpp \
	score/mw/com/message_passing/shared_properties.cpp

# Unix domain sockets implementation
UNIX_DOMAIN_SOURCES = \
	score/message_passing/client_connection.cpp \
	score/message_passing/common_headers.cpp \
	score/message_passing/non_allocating_future/non_allocating_future.cpp \
	score/message_passing/timed_command_queue.cpp \
	score/message_passing/unix_domain/unix_domain_client_factory.cpp \
	score/message_passing/unix_domain/unix_domain_engine.cpp \
	score/message_passing/unix_domain/unix_domain_server.cpp \
	score/message_passing/unix_domain/unix_domain_server_factory.cpp

# QNX dispatch implementation
QNX_DISPATCH_SOURCES = \
	score/message_passing/qnx_dispatch/qnx_dispatch_client_factory.cpp \
	score/message_passing/qnx_dispatch/qnx_dispatch_engine.cpp \
	score/message_passing/qnx_dispatch/qnx_dispatch_server.cpp \
	score/message_passing/qnx_dispatch/qnx_dispatch_server_factory.cpp \
	score/message_passing/qnx_dispatch/qnx_resource_path.cpp

# Utility sources
UTIL_SOURCES = \
	score/mw/com/impl/util/arithmetic_utils.cpp \
	score/mw/com/impl/util/copyable_atomic.cpp

# Combine all main library sources (score-baselibs now provided by system)
ALL_MAIN_SOURCES = $(CORE_SOURCES) $(IMPL_SOURCES) $(CONFIG_SOURCES) $(PLUMBING_SOURCES) \
                   $(LOLA_SOURCES) $(LOLA_MESSAGING_SOURCES) $(LOLA_SERVICE_DISCOVERY_SOURCES) \
                   $(TRACING_SOURCES) $(TRACING_CONFIG_SOURCES) $(LOLA_TRACING_SOURCES) $(UTIL_SOURCES)

# Combine all message passing sources
ALL_MESSAGE_PASSING_SOURCES = $(MESSAGE_PASSING_SOURCES) $(UNIX_DOMAIN_SOURCES)

# Example application sources
EXAMPLE_SOURCES = \
	score/mw/com/example/ipc_bridge/assert_handler.cpp \
	score/mw/com/example/ipc_bridge/datatype.cpp \
	score/mw/com/example/ipc_bridge/ipc_bridge_gen.cpp \
	score/mw/com/example/ipc_bridge/sample_sender_receiver.cpp

# Performance benchmark sources
BENCHMARK_COMMON_SOURCES = \
	score/mw/com/performance_benchmarks/macro_benchmark/common_resources.cpp \
	score/mw/com/performance_benchmarks/macro_benchmark/config_parser.cpp \
	score/mw/com/performance_benchmarks/macro_benchmark/json_parsing_convenience_wrappers.cpp \
	score/mw/com/performance_benchmarks/macro_benchmark/lola_interface.cpp \
	score/mw/com/performance_benchmarks/common_test_resources/shared_memory_object_creator.cpp \
	score/mw/com/performance_benchmarks/common_test_resources/shared_memory_object_guard.cpp \
	score/mw/com/performance_benchmarks/common_test_resources/stop_token_sig_term_handler.cpp

BENCHMARK_SERVICE_SOURCES = $(BENCHMARK_COMMON_SOURCES) \
	score/mw/com/performance_benchmarks/macro_benchmark/lola_benchmarking_service.cpp

BENCHMARK_CLIENT_SOURCES = $(BENCHMARK_COMMON_SOURCES) \
	score/mw/com/performance_benchmarks/macro_benchmark/lola_benchmarking_client.cpp

MICROBENCHMARK_SOURCES = \
	score/mw/com/performance_benchmarks/api_microbenchmarks/lola_public_api_benchmarks.cpp

# =============================================================================
# Object file lists
# =============================================================================

MAIN_OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(ALL_MAIN_SOURCES))
MESSAGE_PASSING_OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(ALL_MESSAGE_PASSING_SOURCES))
EXAMPLE_OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(EXAMPLE_SOURCES))
BENCHMARK_SERVICE_OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(BENCHMARK_SERVICE_SOURCES))
BENCHMARK_CLIENT_OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(BENCHMARK_CLIENT_SOURCES))
MICROBENCHMARK_OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(MICROBENCHMARK_SOURCES))

# =============================================================================
# Build Targets
# =============================================================================

.PHONY: all all-with-benchmarks clean libs examples benchmarks install install-benchmarks install-all uninstall help

# Default target
all: libs examples

# Extended target with benchmarks
all-with-benchmarks: libs examples benchmarks

# Build libraries
libs: $(MAIN_LIB) $(MESSAGE_PASSING_LIB)

# Build examples
examples: $(BIN_DIR)/ipc_bridge_cpp $(BIN_DIR)/ipc_bridge_rs

# Build benchmarks
benchmarks: $(BIN_DIR)/lola_benchmarking_service $(BIN_DIR)/lola_benchmarking_client $(BIN_DIR)/lola_public_api_benchmarks

# Create main communication library
$(MAIN_LIB): $(MAIN_OBJECTS) | $(LIB_DIR)
	@echo "Linking main library: $@"
	$(CXX) $(LDFLAGS) $(SHARED_LDFLAGS) -Wl,-soname,libscore-mw-com.so -o $@ $^ $(LIBS) $(SCORE_LIB_PATHS) $(SCORE_LIBS) $(BOOST_LIBS) -Wl,--allow-shlib-undefined

# Create message passing library
$(MESSAGE_PASSING_LIB): $(MESSAGE_PASSING_OBJECTS) | $(LIB_DIR)
	@echo "Linking message passing library: $@"
	$(CXX) $(LDFLAGS) $(SHARED_LDFLAGS) -Wl,-soname,libscore-message-passing.so -o $@ $^ $(LIBS)

# Build C++ example application
$(BIN_DIR)/ipc_bridge_cpp: $(EXAMPLE_OBJECTS) $(OBJ_DIR)/score/mw/com/example/ipc_bridge/main.o $(MAIN_LIB) $(MESSAGE_PASSING_LIB) | $(BIN_DIR)
	@echo "Linking C++ example application: $@"
	$(CXX) -o $@ $(EXAMPLE_OBJECTS) $(OBJ_DIR)/score/mw/com/example/ipc_bridge/main.o -L$(LIB_DIR) -lscore-mw-com -lscore-message-passing $(LIBS) $(SCORE_LIB_PATHS) $(SCORE_LIBS) $(BOOST_LIBS)

# Build Rust example application
$(BIN_DIR)/ipc_bridge_rs: score/mw/com/example/ipc_bridge/ipc_bridge.rs score/mw/com/example/ipc_bridge/ipc_bridge_gen.rs $(MAIN_LIB) $(MESSAGE_PASSING_LIB) | $(BIN_DIR)
	@echo "Linking Rust example application: $@"
	@if command -v rustc >/dev/null 2>&1; then \
		rustc --extern score_mw_com=$(LIB_DIR)/libscore-mw-com.so \
		      --extern score_message_passing=$(LIB_DIR)/libscore-message-passing.so \
		      -L $(LIB_DIR) \
		      -o $@ score/mw/com/example/ipc_bridge/ipc_bridge.rs; \
	else \
		echo "Rust compiler not found, skipping Rust example"; \
		touch $@; \
	fi

# Build benchmark service application
$(BIN_DIR)/lola_benchmarking_service: $(BENCHMARK_SERVICE_OBJECTS) $(MAIN_LIB) $(MESSAGE_PASSING_LIB) | $(BIN_DIR)
	@echo "Linking benchmark service application: $@"
	$(CXX) -o $@ $(BENCHMARK_SERVICE_OBJECTS) -L$(LIB_DIR) -lscore-mw-com -lscore-message-passing $(LIBS) $(SCORE_LIB_PATHS) $(SCORE_LIBS) $(BOOST_LIBS)

# Build benchmark client application
$(BIN_DIR)/lola_benchmarking_client: $(BENCHMARK_CLIENT_OBJECTS) $(MAIN_LIB) $(MESSAGE_PASSING_LIB) | $(BIN_DIR)
	@echo "Linking benchmark client application: $@"
	$(CXX) -o $@ $(BENCHMARK_CLIENT_OBJECTS) -L$(LIB_DIR) -lscore-mw-com -lscore-message-passing $(LIBS) $(SCORE_LIB_PATHS) $(SCORE_LIBS) $(BOOST_LIBS)

# Build API microbenchmarks (requires Google Benchmark)
$(BIN_DIR)/lola_public_api_benchmarks: $(MICROBENCHMARK_OBJECTS) $(MAIN_LIB) $(MESSAGE_PASSING_LIB) | $(BIN_DIR)
	@echo "Linking API microbenchmarks: $@"
	$(CXX) -o $@ $(MICROBENCHMARK_OBJECTS) -L$(LIB_DIR) -lscore-mw-com -lscore-message-passing $(LIBS) $(SCORE_LIB_PATHS) $(SCORE_LIBS) -lbenchmark -lpthread

# =============================================================================
# Object file compilation rules
# =============================================================================

# Compile C++ source files
$(OBJ_DIR)/%.o: %.cpp | $(OBJ_DIR)
	@echo "Compiling: $<"
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(SHARED_LIB_FLAGS) $(INCLUDES) -c $< -o $@

# Compile C source files
$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	@echo "Compiling: $<"
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(SHARED_LIB_FLAGS) $(INCLUDES) -c $< -o $@

# =============================================================================
# Directory creation
# =============================================================================

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(OBJ_DIR): | $(BUILD_DIR)
	mkdir -p $(OBJ_DIR)

$(LIB_DIR): | $(BUILD_DIR)
	mkdir -p $(LIB_DIR)

$(BIN_DIR): | $(BUILD_DIR)
	mkdir -p $(BIN_DIR)

# =============================================================================
# Installation
# =============================================================================

PREFIX ?= /usr/local
DESTDIR ?=
LIBDIR_SUFFIX ?= lib
LIBDIR = $(DESTDIR)$(PREFIX)/$(LIBDIR_SUFFIX)
INCLUDEDIR = $(DESTDIR)$(PREFIX)/include
BINDIR = $(DESTDIR)$(PREFIX)/bin
DATADIR = $(DESTDIR)$(PREFIX)/share/score-communication
DOCDIR = $(DESTDIR)$(PREFIX)/share/doc/score-communication

install: libs examples
	@echo "Installing Score Communication Module..."
	# Create directories
	install -d $(LIBDIR)
	install -d $(INCLUDEDIR)/score/mw/com
	install -d $(BINDIR)
	install -d $(DATADIR)/examples
	install -d $(DATADIR)/config
	install -d $(DATADIR)/schema
	install -d $(DOCDIR)

	# Install libraries
	install -m 644 $(MAIN_LIB) $(LIBDIR)/
	install -m 644 $(MESSAGE_PASSING_LIB) $(LIBDIR)/

	# Install example binaries
	if [ -f $(BIN_DIR)/ipc_bridge_cpp ]; then install -m 755 $(BIN_DIR)/ipc_bridge_cpp $(BINDIR)/; fi
	if [ -f $(BIN_DIR)/ipc_bridge_rs ]; then install -m 755 $(BIN_DIR)/ipc_bridge_rs $(BINDIR)/; fi

	# Install headers
	find score/mw/com -name "*.h" -exec install -D -m 644 {} $(INCLUDEDIR)/{} \;

	# Install examples source code and documentation
	cp -r score/mw/com/example/* $(DATADIR)/examples/

	# Install configuration files
	if [ -d score/mw/com/example/ipc_bridge/etc ]; then \
		cp -r score/mw/com/example/ipc_bridge/etc/* $(DATADIR)/config/; \
	fi

	# Install design documentation
	if [ -d score/mw/com/design ]; then \
		cp -r score/mw/com/design $(DOCDIR)/; \
	fi

	# Install JSON schema files
	find . -name "*.json" -path "*/configuration/*" -exec cp {} $(DATADIR)/schema/ \; 2>/dev/null || true

	@echo "Installation complete."

install-benchmarks: benchmarks
	@echo "Installing Score Communication Benchmarks..."
	# Create directories
	install -d $(BINDIR)
	install -d $(DATADIR)/benchmarks

	# Install benchmark binaries
	if [ -f $(BIN_DIR)/lola_benchmarking_service ]; then install -m 755 $(BIN_DIR)/lola_benchmarking_service $(BINDIR)/; fi
	if [ -f $(BIN_DIR)/lola_benchmarking_client ]; then install -m 755 $(BIN_DIR)/lola_benchmarking_client $(BINDIR)/; fi
	if [ -f $(BIN_DIR)/lola_public_api_benchmarks ]; then install -m 755 $(BIN_DIR)/lola_public_api_benchmarks $(BINDIR)/; fi

	# Install benchmark source code and documentation
	cp -r score/mw/com/performance_benchmarks/* $(DATADIR)/benchmarks/

	@echo "Benchmark installation complete."

install-all: install install-benchmarks
	@echo "Complete installation (including benchmarks) finished."

uninstall:
	@echo "Uninstalling Score Communication Module..."
	rm -f $(LIBDIR)/libscore-mw-com.so
	rm -f $(LIBDIR)/libscore-message-passing.so
	rm -f $(BINDIR)/ipc_bridge_example
	rm -rf $(INCLUDEDIR)/score/mw/com
	@echo "Uninstallation complete."

# =============================================================================
# Testing (placeholder for when tests are available)
# =============================================================================

test:
	@echo "Note: Test sources excluded from build (contain *_test.cpp pattern)"
	@echo "To run tests, Bazel is recommended: 'bazel test //...'"

# =============================================================================
# Cleaning
# =============================================================================

clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)

# =============================================================================
# Distribution and Packaging
# =============================================================================

# Create source distribution tarball
# Usage: make dist [VERSION=x.y.z] or make dist x.y.z
.PHONY: dist
dist:
	@if [ "$(filter-out dist,$(MAKECMDGOALS))" ]; then \
		VERSION="$(filter-out dist,$(MAKECMDGOALS))"; \
	else \
		VERSION=$${VERSION:-1.0.0}; \
	fi; \
	NAME="score-communication"; \
	TARBALL="$$NAME-$$VERSION.tar.gz"; \
	echo "Creating source tarball: $$TARBALL (version: $$VERSION)"; \
	$(MAKE) clean; \
	git archive --format=tar --prefix="$$NAME-$$VERSION/" HEAD | gzip > "$$TARBALL"; \
	echo "Created: $$TARBALL"; \
	echo "To build RPM: rpmbuild -ta $$TARBALL"

# Build source RPM package
# Usage: make srpm [VERSION=x.y.z] or make srpm x.y.z
.PHONY: srpm
srpm:
	@if [ "$(filter-out srpm,$(MAKECMDGOALS))" ]; then \
		VERSION="$(filter-out srpm,$(MAKECMDGOALS))"; \
	else \
		VERSION=$${VERSION:-1.0.0}; \
	fi; \
	NAME="score-communication"; \
	TARBALL="$$NAME-$$VERSION.tar.gz"; \
	echo "Building source RPM for version: $$VERSION"; \
	if [ ! -f "$$TARBALL" ]; then \
		echo "Creating tarball first..."; \
		$(MAKE) dist $$VERSION; \
	fi; \
	echo "Building SRPM from $$TARBALL"; \
	TEMP_DIR=$$(mktemp -d) && \
	cd "$$TEMP_DIR" && \
	cp "$(shell pwd)/$$TARBALL" . && \
	cp "$(shell pwd)/score-communication.spec" . && \
	sed -i "s/^Version:.*/Version:        $$VERSION/" score-communication.spec && \
	rpmbuild --define "_sourcedir $$TEMP_DIR" --define "_srcrpmdir $(shell pwd)" -bs "score-communication.spec" && \
	cd "$(shell pwd)" && \
	rm -rf "$$TEMP_DIR"

# Handle version argument as a target (prevents make from complaining)
%:
	@:

# =============================================================================
# Help
# =============================================================================

help:
	@echo "Score Communication Module Makefile"
	@echo "============================================"
	@echo ""
	@echo "Available targets:"
	@echo "  all                    - Build libraries and examples (default)"
	@echo "  all-with-benchmarks    - Build libraries, examples, and benchmarks"
	@echo "  libs                   - Build shared libraries only"
	@echo "  examples               - Build example applications"
	@echo "  benchmarks             - Build performance benchmark applications"
	@echo "  install                - Install libraries, headers, examples, and configs"
	@echo "  install-benchmarks     - Install benchmark applications and source"
	@echo "  install-all            - Install everything (main + benchmarks)"
	@echo "  uninstall              - Remove installed files"
	@echo "  test                   - Information about running tests"
	@echo "  clean                  - Remove build directory"
	@echo "  dist [VERSION]         - Create source distribution tarball"
	@echo "  srpm [VERSION]         - Build source RPM package"
	@echo "                           Usage: make dist/srpm 1.2.3 or VERSION=1.2.3 make dist/srpm"
	@echo "  help                   - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  PREFIX     - Installation prefix (default: /usr/local)"
	@echo "  CXX        - C++ compiler (default: g++)"
	@echo "  CC         - C compiler (default: gcc)"
	@echo ""
	@echo "Libraries built:"
	@echo "  libscore-mw-com.so         - Main communication middleware"
	@echo "  libscore-message-passing.so - Low-level message passing"
	@echo ""
	@echo "Applications built:"
	@echo "  ipc_bridge_cpp             - C++ IPC bridge example"
	@echo "  ipc_bridge_rs              - Rust IPC bridge example (if rustc available)"
	@echo "  lola_benchmarking_service  - Benchmark service application (benchmarks target)"
	@echo "  lola_benchmarking_client   - Benchmark client application (benchmarks target)"
	@echo "  lola_public_api_benchmarks - API microbenchmarks (benchmarks target, requires Google Benchmark)"
	@echo ""
	@echo "Note: This Makefile replaces the Bazel build system."
	@echo "External dependencies (@score-baselibs) are not included."
	@echo "Updated for GCC 15+ compatibility."
