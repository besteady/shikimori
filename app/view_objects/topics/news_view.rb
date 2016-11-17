class Topics::NewsView < Topics::View
  def container_class
    super 'b-news-topic'
  end

  # def minified?
    # is_preview || is_mini
  # end

  def topic_title
    topic.title
  end

  def topic_title_html
    topic_title
  end

  def action_tag
    OpenStruct.new(
      type: 'news',
      text: i18n_i('news', :one)
    )
  end
end
