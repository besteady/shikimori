json.content render(
  partial: 'moderations/anime_video_reports/anime_video_report',
  collection: @processed,
  formats: :html
)

if @add_postloader
  json.postloader render('blocks/postloader', next_url: page_moderations_anime_video_reports_url(page: @page+1))
end
