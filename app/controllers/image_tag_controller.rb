class ImageTagController < ApplicationController
  def image_tag
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
    algo = client.algo('deeplearning/IllustrationTagger/0.4.0')
    data = algo.pipe(input).result
    final_data = data.fetch("general")
    
    @tag_hashes = final_data

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("image_tag_templates/image_tag.html.erb")
  end

  def image_tag_form
    render("image_tag_templates/image_tag_form.html.erb")
  end
end
