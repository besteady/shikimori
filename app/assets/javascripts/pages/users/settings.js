// переключение вкладок настроек
$('.settings .options-floated a').live('click', function() {
  $('.settings.slider-control a')
    .attr('href', $(this).attr('href'))
    .trigger('click');
  return false;
});

$('.slide .settings').live('ajax:success', function(e, data) {
}).live('ajax:clear', function(e, data) {
  // очистка контента, чтобы в следующий раз загрузился новый
  if ($.isReady) {
    $(this).append('<div class="clear-marker"></div>');
  }
});


//$('.slide > div.settings').live('ajax:success cache:success', function(e, data) {
  //if ('initialized' in arguments.callee) {
    //return;
  //}
  //arguments.callee.initialized = true;

  //$('.oauth img[title]').tipsy({
    //gravity: 'n',
    //live: true,
    //opacity: 1
  //});

  //// игнорируемые пользователи
  //$('.ignore-suggest').make_completable('Имя пользователя...', apply_autocomplete);
  //$('.ignore-suggest').keypress(function(e) {
    //if (e.charCode == 13) {
      //apply_autocomplete.apply(this, [e, this.value, this.value]);
      //return false;
    //}
  //});

  //// tooltips
  //$('.settings .notice').tipsy({
    //live: true,
    //gravity: 's',
    //opacity: 1
  //});

  //var $page_background = $('#user_page_background');
  //var $page = $('.page');
  //$(".range-slider").noUiSlider({
    //range: [0, 12],
    //start: parseFloat($(".range-slider").data('value')),
    //handles: 1,
    //slide: function() {
      //var value = $(this).val();
      //$page_background.val(value);
      //var ceiled_value = 255 - Math.ceil(value);
      //$page.css('background-color', 'rgb('+ceiled_value+','+ceiled_value+','+ceiled_value+')');
    //}
  //});

  //var $body = $('body');
  //var $body_background = $('#user_body_background');
  //$('.backgrounds .samples li').on('click', function() {
    //var value = $(this).data('background');
    //$body_background.val("url("+value+") repeat").trigger('change');
  //});
  //$body_background.on('change', function() {
    //$body.css('background', $(this).val());
  //});
  //$('#user_page_border').on('change', function() {
    //$('.page').toggleClass('bordered', $(this).prop('checked'));
  //});
//});
//$('.settings .save').live('click', function() {
  //$.flash({notice: 'Сохранение изменений...'});
  //var $this = $(this);
  //_.delay(function() {
    //$this.parents('.slide').find('form').submit();
  //});
//});

//// отмена игнора
//$('.ignores .item-minus').live('click', function() {
  //$(this).parent().remove();
//});

// удаление аватара
$('.avatar-delete span').live('click', function() {
  $(this)
    .closest('form')
    .find('.b-input.file input')
    .replaceWith('<p class="avatar-delete">[<span>сохраните настройки профиля</span>]</p><input type="hidden" name="delete_avatar" value="1" />');
  $(this)
    .closest('.avatar-edit')
    .remove();
});

//// переключение шрифта
//$('#stylo_bold,#new_catalog,#hentai_images').live('click', function() {
  //var $this = $(this);
  //var cookie = $this.data('cookie');
  //if ($this.is(':checked')) {
    //$.cookie(cookie, 1, {expires: 9999, path: '/'});
    //$(document.body).addClass(cookie);
  //} else {
    //$.cookie(cookie, null, {path: '/'});
    //$(document.body).removeClass(cookie);
  //}
//});

//// автозаполнение пользователей для игнора
//function apply_autocomplete(e, id, text, label) {
  //if (!id) {
    //return;
  //}
  ////id = id.replace(/ /, '+');
  //var $this = $(this);
  //var type = 'ignores';
  //var url = '/'+text;

  //var $container = $this.parent().find('.container');
  //if ($container.find('[value="'+text+'"]').length) {
    //return;
  //}
  //$container.append(
    //'<li>' +
      //'<span class="item-minus"></span>' +
      //'<input type="hidden" name="'+type+'[]" value="'+text+'" />' +
      //'<a href="'+url+'">'+text+'</a>' +
    //'</li>'
  //);
  //$this.attr('value', '');
//}
