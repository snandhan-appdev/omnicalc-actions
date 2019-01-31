class ColorizeController < ApplicationController
  def colorize
    input = {
      image: params.fetch("image_url").strip
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    @original_image_url = params.fetch("image_url").strip
    
    input = {
      :image => @original_image_url
    }
    
    client = Algorithmia.client(ENV.fetch("ALGORITHMIA_KEY"))
    algo = client.algo("deeplearning/ColorfulImageColorization/1.1.13")
    
    @colorized_image_url = algo.pipe(input).result.fetch("output").to_s.gsub("data://", "https://algorithmia.com/v1/data/")





    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("colorize_templates/colorize.html.erb")
  end

  def colorize_form
    render("colorize_templates/colorize_form.html.erb")
  end
end
