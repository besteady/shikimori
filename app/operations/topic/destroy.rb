class Topic::Destroy
  method_object :topic, :faye

  def call
    changelog
    @faye.destroy @topic
  end

private

  def changelog
    NamedLogger.changelog.info(
      user_id: @faye.actor&.id,
      action: :destroy,
      topic: @topic.attributes
    )
  end
end
