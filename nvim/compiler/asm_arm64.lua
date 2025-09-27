-- Set makeprg for ARM64 assembly with macOS as & ld
-- -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`
vim.bo.makeprg = "as -o %:r.o % && ld -o %:r %:r.o -e _main -arch arm64 && ./%:r"

-- Set errorformat for macOS assembler/linker errors
vim.bo.errorformat = "%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%f:%l:%c: %m"
