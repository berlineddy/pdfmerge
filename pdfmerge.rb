#!/usr/bin/env ruby
require 'optparse'

VERSION="0.1"
command= "gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=%{ofile} %{mergefiles}"
os = `uname`
options = {}
 
optparse = OptionParser.new do|opts|
  opts.banner = "Usage: pdfmerge [options] file1 file2 ...\nExample: pdfmerge -o merged.pdf 1.pdf 2.pdf 3.pdf\n\n\n"

  options[:ofile] = nil
  opts.on( '-o', '--ofile FILE', 'Write to Output File' ) do |file|
    options[:ofile] = file
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end

  opts.on( '-v', '--version', 'Display version' ) do
    puts "pdfmerge Version: %{version}" % {:version => VERSION}
    exit
  end
end

optparse.parse!

ARGV.each do |arg|
  unless arg =~ /\.pdf$/
    puts "only PDF files are allowed!"
    puts "bad file -> " + arg
    exit
  end
end

unless options[:ofile].nil? || !(ARGV.length > 0)
    ex = command % {:ofile => options[:ofile] , :mergefiles => ARGV.join(" ")}
    `#{ex}`
end 
 