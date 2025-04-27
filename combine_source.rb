#!/usr/bin/env ruby

require "pathname"
require "fileutils"

# Define source code file extensions to include
SOURCE_EXTENSIONS = %w[
  .rb .js .jsx .ts .tsx .html .css .scss .json .yml .yaml .md
  .mdc .haml .erb
]

# Directories to exclude based on .gitignore
EXCLUDED_DIRS = %w[
  node_modules
  tmp
  log
  storage
  public/assets
  coverage
  .bundle
  app/assets/builds
  vendor
  .git
]

def should_include?(file_path)
  # Check if file has a source code extension
  return false unless SOURCE_EXTENSIONS.include?(File.extname(file_path).downcase)

  # Check if file is in excluded directory
  EXCLUDED_DIRS.each do |dir|
    return false if file_path.include?("/#{dir}/") || file_path.start_with?("#{dir}/")
  end

  true
end

def process_file(file_path, output_file)
  content = File.read(file_path)
  output_file.puts "\n" + ("=" * 80)
  output_file.puts "File: #{file_path}"
  output_file.puts ("=" * 80) + "\n"
  output_file.puts content
rescue StandardError => e
  puts "Error processing #{file_path}: #{e.message}"
end

def main
  output_path = "source_code.txt"
  puts "Combining source code files into #{output_path}..."

  File.open(output_path, "w") do |output_file|
    Dir.glob("**/*").each do |path|
      next unless File.file?(path)
      next if EXCLUDED_DIRS.any? { |dir| path.include?("/#{dir}/") || path.start_with?("#{dir}/") }
      next unless SOURCE_EXTENSIONS.include?(File.extname(path).downcase)

      puts "Processing: #{path}"
      process_file(path, output_file)
    end
  end

  puts "Done! Source code has been combined into #{output_path}"
end

main
