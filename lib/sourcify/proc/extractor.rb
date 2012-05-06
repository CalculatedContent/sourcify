module Sourcify
  module Proc
    module Extractor
      class << self

        def extract_source(block)
          file, line = block.source_location
          sexp = SexpUtil.new(::File.read(file)).extract(:line => line)
          Sorcerer.source(sexp)
        end

        def extract_raw_source(block)
          file, line = block.source_location
          positions = SexpUtil.new(::File.read(file)).locate(:line => line)

          File.open(file,'r') do |fh|
            fh.extend(Extensions::File)
            normalize_indents(fh.chunk(positions[:from], positions[:till]))
          end
        end

      private

        def normalize_indents(code)
          indent = code.split("\n")[-1].match(/^\s+/)
          code.gsub("\n#{indent}","\n")
        end

      end
    end
  end
end
