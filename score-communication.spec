# Score Communication Module RPM Spec
# RPM specification for the Score Communication middleware (LoLa)

%global debug_package %{nil}

Name:           score-communication
Version:        0.0.1
Release:        7%{?dist}
Summary:        High-performance automotive communication middleware (LoLa)

License:        Apache-2.0
URL:            https://github.com/eclipse-score/communication
Source0:        %{name}-%{version}.tar.gz

# Build requirements
BuildRequires:  gcc
BuildRequires:  gcc-c++
BuildRequires:  make
BuildRequires:  score-baselibs-devel
BuildRequires:  libacl-devel
BuildRequires:  libcap-devel
BuildRequires:  boost-devel
BuildRequires:  json-devel
BuildRequires:  google-benchmark-devel

# System dependencies
BuildRequires:  pkgconfig
BuildRequires:  libstdc++-devel

# Runtime dependencies
Requires:       glibc
Requires:       libgcc
Requires:       libstdc++
Requires:       score-baselibs

# Explicit library provides to help with dependency resolution
# Required for EL9 due to different RPM dependency generation behavior
Provides:       libscore-mw-com.so()(64bit)
Provides:       libscore-message-passing.so()(64bit)

%description
Score Communication Module (LoLa - Low Latency) is a high-performance,
safety-critical communication middleware implementation based on the Adaptive
AUTOSAR Communication Management specification.

This package provides:
- High-Performance Intra-ECU IPC with zero-copy shared-memory communication
- AUTOSAR Compliance with partial implementation of Adaptive AUTOSAR Communication Management (ara::com)
- Event-Driven Architecture using publisher/subscriber pattern with skeleton/proxy framework
- Service Discovery via flag file-based service registration and lookup mechanism
- Safety-Critical design for automotive safety standards (ASIL-B qualified)
- Multi-Threading Support with thread-safe operations and atomic data structures
- Memory Management with custom allocators optimized for shared memory usage
- Tracing Infrastructure for zero-copy, binding-agnostic communication tracing support
- Multi-Platform support for Linux and QNX operating systems
- Reproducible containerized builds with included Containerfile

%package        devel
Summary:        Development files for %{name}
Requires:       %{name}%{?_isa} = %{version}-%{release}

%description    devel
Development files and headers for the Score Communication middleware.
This package contains the header files and static libraries needed to develop
applications using the LoLa communication framework.

%package        examples
Summary:        Example applications for %{name}
Requires:       %{name}%{?_isa} = %{version}-%{release}

%description    examples
Example applications demonstrating the usage of Score Communication
middleware. Includes IPC bridge examples in both C++ and Rust implementations
with configuration files and sample code.

%package        performance-benchmarks
Summary:        Performance benchmarking tools for %{name}
Requires:       %{name}%{?_isa} = %{version}-%{release}
Requires:       python3
Requires:       google-benchmark

%description    performance-benchmarks
Performance benchmarking suite for Score Communication middleware.
Includes micro-benchmarks for API performance testing and macro-benchmarks
for end-to-end system performance evaluation. Contains Python configuration
generators and test utilities.

%prep
%autosetup -n %{name}-%{version}

# Clean any previous builds
make clean

%build
# Build using Make system (includes examples and benchmarks)
# Note: -fPIC is essential for shared library creation
make all-with-benchmarks CXXFLAGS="%{optflags} -fPIC" LDFLAGS="%{build_ldflags}"

%install
# Use Makefile install targets with DESTDIR for proper RPM packaging
# Use correct library directory for the target architecture
make install-all DESTDIR=%{buildroot} PREFIX=%{_prefix} LIBDIR_SUFFIX=%{_lib}

%files
%license LICENSE
%doc README.md NOTICE
%{_libdir}/libscore-mw-com.so
%{_libdir}/libscore-message-passing.so
%{_datadir}/%{name}/config/
%{_datadir}/%{name}/schema/

%files devel
%{_includedir}/score/
%{_docdir}/%{name}/design/
%doc CONTRIBUTING.md

%files examples
%{_bindir}/ipc_bridge_cpp
%{_bindir}/ipc_bridge_rs
%{_datadir}/%{name}/examples/

%files performance-benchmarks
%{_bindir}/lola_benchmarking_service
%{_bindir}/lola_benchmarking_client
%{_bindir}/lola_public_api_benchmarks
%{_datadir}/%{name}/benchmarks/

%post
/sbin/ldconfig

%postun
/sbin/ldconfig

%changelog
* Thu Oct 09 2025 Pierre-Yves Chibon <pingou@pingoured.fr> - 0.0.1-7
- Complete implementation of shared memory subdirectory support
- Add hybrid approach in SharedMemoryResource to handle paths with subdirectories
- Use regular file operations (open + mmap) for subdirectory paths, shm_open() for simple paths
- Fix SharedMemoryFactory to properly create directories and handle subdirectory unlinking
- Maintain full backward compatibility with existing simple path configurations

* Thu Oct 09 2025 Pierre-Yves Chibon <pingou@pingoured.fr> - 0.0.1-6
- Fix shared memory path prefix configuration bug
- Change skeleton to use *Path methods instead of *ShmName methods to respect configured shm-path-prefix

* Thu Oct 09 2025 Pierre-Yves Chibon <pingou@pingoured.fr> - 0.0.1-5
- Revert problematic skeleton changes to restore functionality
- Fix BuildRequires for CentOS Stream 9 compatibility

* Tue Oct 07 2025 Pierre-Yves Chibon <pingou@pingoured.fr> - 0.0.1-4
- Bump release

* Mon Oct 06 2025 Pierre-Yves Chibon <pingou@pingoured.fr> - 0.0.1-3
- Add configurable shared memory path prefix support
- New 'shm-path-prefix' configuration option allows customizing shared memory object locations
- Maintains backward compatibility with platform defaults

* Mon Oct 06 2025 Pierre-Yves Chibon <pingou@pingoured.fr> - 0.0.1-2
- Bump release to 2

* Thu Sep 25 2025 Pierre-Yves Chibon <pingou@pingoured.fr> - 0.0.1-1
- Initial RPM package for Score Communication Module
- Includes LoLa high-performance automotive communication middleware
- AUTOSAR-compliant implementation with ASIL-B qualification
- Zero-copy shared-memory IPC for embedded systems
- Support for Linux and QNX platforms
- C++ and Rust example applications included
