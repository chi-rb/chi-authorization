module Abilities
  class Configuration

    def fetcher(&block)
      if block_given?
        @fetcher = block
      else
        @fetcher
      end
    end

  end
end
