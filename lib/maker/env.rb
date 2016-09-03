module Maker

  class Env
    include Maker

    def self.delimitter
      return ':' if Maker.ostype == 'unix'
      return ';'
    end

    def self.set( n, v )
      line = ''
      if v.class.to_s == 'Array' then
        v.each do |e|
          line += delimitter + e
        end
      else
        line = v
      end
      if( ENV.keys.include?(n) ) then
        ENV[n] += line
      else
        ENV[n] = line
      end
    end
  end

end # module Maker
