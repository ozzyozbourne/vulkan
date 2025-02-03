const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "VulkanTest",
        .target = target,
        .optimize = optimize,
    });

    exe.addCSourceFile(.{
        .file = b.path("main.cpp"),
        .flags = &[_][]const u8{
            "-std=c++23",
            "-Wall",
            "-Wextra",
            "-Wpedantic",
        },
    });

    exe.linkLibCpp();
    
    var env_map = std.process.getEnvMap(b.allocator) catch |err| {
        std.debug.print("Failed to get environment map: {}\n", .{err});
        return;
    };
    defer env_map.deinit();

    const vulkan_path = if (env_map.get("VULKAN_SDK")) |path| path else {
        std.debug.print("VULKAN_SDK environment variable not found\n", .{});
        return;
    };

    exe.addIncludePath(.{ .cwd_relative = "/opt/homebrew/Cellar/glfw/3.4/include" });
    exe.addIncludePath(.{ .cwd_relative = "/opt/homebrew/Cellar/glm/1.0.1/include" });
    exe.addIncludePath(.{ .cwd_relative = b.pathJoin(&.{ vulkan_path, "include" }) });

    exe.addLibraryPath(.{ .cwd_relative = "/opt/homebrew/Cellar/glfw/3.4/lib" });
    exe.addLibraryPath(.{ .cwd_relative = "/opt/homebrew/Cellar/glm/1.0.1/lib" });
    exe.addLibraryPath(.{ .cwd_relative = b.pathJoin(&.{ vulkan_path, "lib" }) });

    exe.linkSystemLibrary("vulkan");
    exe.linkSystemLibrary("glfw");
    exe.linkSystemLibrary("glm");

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the Vulkan application");
    run_step.dependOn(&run_cmd.step);
}
