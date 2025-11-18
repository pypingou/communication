/********************************************************************************
* Copyright (c) 2025 Contributors to the Eclipse Foundation
 *
 * See the NOTICE file(s) distributed with this work for additional
 * information regarding copyright ownership.
 *
 * This program and the accompanying materials are made available under the
 * terms of the Apache License Version 2.0 which is available at
 * https://www.apache.org/licenses/LICENSE-2.0
 *
 * SPDX-License-Identifier: Apache-2.0
 ********************************************************************************/

// Include the generated types and FFI bindings
mod ipc_bridge_gen {
    include!("ipc_bridge_gen.rs");
}

// Re-export for easier access
use ipc_bridge_gen as ipc_bridge_gen_rs;

// Re-export the main type to make it accessible from crate root
pub use ipc_bridge_gen::MapApiLanesStamped;

// Include the main application logic
include!("ipc_bridge.rs");