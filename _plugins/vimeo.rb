# A plugin for embedding videos from Vimeo using a simple Liquid tag, ie: {% vimeo 12345678 %}.
# Based of the Youtube plugin from http://www.portwaypoint.co.uk/jekyll-youtube-liquid-template-tag-gist/

module Jekyll
  class Vimeo < Liquid::Tag

    include Liquid::StandardFilters
    Syntax = /(#{Liquid::QuotedFragment}+)?/

    def initialize(name, markup, tokens)
      @attributes = {}

      if markup =~ Syntax
        markup.scan(Liquid::TagAttributes) do |key, value|
          @attributes[key] = value
        end
      else
        raise SyntaxError.new("You've got a syntax error in 'vimeo'.\nThis is how we do it: vimeo id:ID [width:INT] [height:INT]")
      end

      @id = @attributes['id']
      @width = @attributes['width'] ||= "800"
      @height = @attributes['height'] ||= "450"

      super
    end

    def render(context)
      %(<iframe width="#{@width}" height="#{@height}" src="http://player.vimeo.com/video/#{@id}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>)
    end
  end
end

Liquid::Template.register_tag('vimeo', Jekyll::Vimeo)
