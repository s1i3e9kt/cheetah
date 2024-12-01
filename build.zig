const std = @import("std");

pub fn build(b: *std.Build) void {
  const target = b.standardTargetOptions(.{});
  const optimize = b.standardOptimizeOption(.{});

  const exe = b.addExecutable(.{
    .name = "cheetah",
    .root_source_file = b.path("src/main.zig"),
    .target = target,
    .optimize = optimize,
  });

  exe.linkLibCpp();
  exe.addWin32ResourceFile(.{
    .file = b.path("res/res.rc"),
  });
  exe.addLibraryPath(b.path("cpp/lib/"));
  exe.addIncludePath(b.path("cpp/inc/"));
  exe.addIncludePath(b.path("cpp/src/"));
  exe.addCSourceFile(.{
    .file = b.path("cpp/src/config.cpp"),
    .flags = &.{ "-std=c++23" },
  });

  b.installArtifact(exe);
}
