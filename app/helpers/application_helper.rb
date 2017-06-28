require 'digest/md5'

module ApplicationHelper
  def itemprop
    if @itemtype
      { itemscope: '', itemtype: @itemtype.html_safe }
    else
      {}
    end
  end

  def block &block
    capture(&block)
  end

  def show_social?
    #!is_mobile_request? && (!user_signed_in? || current_user.preferences.show_social_buttons?)
    false
  end

  def title page_title
    content_for :title, page_title
  end

  def cdn_image entry, image_size
    ImageUrlGenerator.instance.url entry, image_size
  end

  def meta_image_url file, style = :original, with_timestamp = true
    "#{request.protocol}#{request.host_with_port}#{file.url style, with_timestamp}"
  end

  def formatted_date date, fix_1_1=false, short_month=true
    return unless date

    if fix_1_1
      if date.day == 1 && date.month == 1
        "#{date.year}"
      elsif fix_1_1 && date.day == 1
        I18n.l date, format: :month_year_human
      else
        I18n.l(date, format: short_month ? :human_short : :human).strip
      end
    else
      I18n.l(date, format: :human).strip
    end
  end

  def info_line title, value=nil, &block
    value = capture(&block) if value.nil? && block_given?
    if value.present?
      "<div class='line-container'>
         <div class='line'>
           <div class='key'>#{title}:</div>
           <div class='value'>#{value}</div>
          </div>
        </div>".html_safe
    end
  end

  # форматирование html текста для вывода в шаблон
  # TODO: выпилить
  def format_html_text text
    raise 'deprecated. use decorator instead'
    text
      .gsub(/\[spoiler\](?:<br ?\/?>|\n)?(.*?)(?:<br ?\/?>|\n)?\[\/spoiler\](?:<br ?\/?>|\n)?/mi,
            '<div class="collapse"><span class="action half-hidden" style="display: none;">развернуть</span></div><div class="collapsed spoiler">спойлер</div><div class="target spoiler" style="display: none;">\1<span class="closing"></span></div>')
      .html_safe
  end

  # удаление спойлеров и дополнений в скобочках в из текста
  def remove_misc_data text
    text
      .gsub(/\[spoiler\][\s\S]*?\[\/spoiler\]|\]\]|\[\[|\([\s\S]*?\)|\[[\s\S]*?\]/, '')
      .gsub(/<(?!br).*?>/, '')
      .gsub(/<br *\/?>/, '')
  end

  def format_rss_urls text
    text
      .gsub(%r{href="/(?!/)}, "href=\"https://#{Site::DOMAIN}/")
      .gsub(%r{src="/(?!/)}, "src=\"https://#{Site::DOMAIN}/")
  end

  def time_ago_in_words date, format_string=nil, original=false
    if original || date > 1.day.ago
      format_string ? format_string % super(date) : super(date)
    else
      I18n.l date, format: '%e %b %Y'
    end
  end

  # костыли для совместимости старого Devise с Rails 3.2
  def password_path resource_name
    user_password_path
  end

  def new_session_path resource_name
    new_user_session_path
  end

  def mobile?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
      request.user_agent =~ /Mobile|webOS|Android/
    end
  end
end
