const std = @import("std");
const config = @cImport(
  @cInclude("config.h")
);

pub fn main() !void {
  var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
  defer _ = general_purpose_allocator.deinit();
  const gpa = general_purpose_allocator.allocator();

  const args = try std.process.argsAlloc(gpa);
  defer std.process.argsFree(gpa, args);
  const applicationPath = std.fs.path.dirname(args[0]) orelse args[0];

  const configName = "/config.json";
  const configPath = try std.mem.join(gpa, "", &.{ applicationPath, configName });
  defer gpa.free(configPath);
  const applicationConfig = config.loadConfig(configPath.ptr);
  std.debug.print("{s} `{s}`", .{ applicationConfig.title, configPath });
}
