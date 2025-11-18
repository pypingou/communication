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

//! Score MW Com Rust bindings
//!
//! This crate provides Rust bindings for the Score middleware communication layer.

// Declare modules
pub mod common;
pub mod proxy_bridge;
pub mod skeleton_bridge;
pub mod macros;

// For compatibility with existing code that expects sample_ptr_rs as a separate module
#[path = "../plumbing/sample_ptr.rs"]
pub mod sample_ptr_rs;

// Create aliases for the expected names
pub use proxy_bridge as proxy_bridge_rs;
pub use skeleton_bridge as skeleton_bridge_rs;

// Re-export the main API from macros and bridges
pub use macros::*;
pub use proxy_bridge::{initialize, InstanceSpecifier, SamplePtr};

pub mod proxy {
    pub use crate::proxy_bridge::{find_service, SamplePtr};
}

pub mod skeleton {
    pub use crate::skeleton_bridge::{OfferState, Offered, SkeletonEvent, SkeletonOps, UnOffered};
}

pub mod ffi {
    pub use crate::proxy_bridge::NativeInstanceSpecifier;
    pub use crate::skeleton_bridge::SkeletonWrapperClass;
}

pub use common::{Error, Result};