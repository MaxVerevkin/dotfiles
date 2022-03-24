local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
  return
end

trouble.setup {
  auto_fold = true,
  use_diagnostic_signs = true,
  position = "right",
}
