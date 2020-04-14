 var qf = {
  'submit': function(e) {
    e.preventDefault();
    var form = $(this),
        data = new FormData(this);
    $.ajax({
      url: form.attr('action'),
      type: form.attr('method'),
      dataType: 'html',
      data: data, 
      cache: false, 
      async: false, 
      contentType: false, 
      processData: false, 
      beforeSend: function() {
        form.find('.qf-box__btn').attr('disabled', true).css('cursor', 'wait');
      },
      success: function(data) {
        form.parent().parent().html(data);
      }
    });
  },
  'load': function({block = '.qf-popup', link = '', popup = 0}) {
    var box=$(block), url='';

    if(link != 0) url = link;
    else url = box.attr('data-link');

    if(url=='') return;

    box.removeClass('init').empty();

    $.ajax({
      url: url+'&popup='+popup,
      type: 'GET',
      dataType: 'html',
      success: function(data) {
        if(data == '') return;
        box.html(data);
        box.addClass('init');
        if(popup != 0) box.addClass('open');
      }
    });
  },

  'without': function(e) {
        el = $(this).find('.qf-popup .qf-box');

        if (!el.is(e.target) && el.has(e.target).length === 0) qf.close();
  },

  'close': function() {
    $('.qf-popup.open').removeClass('open').empty();
  }
};

$(document).ready(function() {
  $(document).on('mouseup', qf.without);
  $(document).on('click', '.qf-box__btn--close', qf.close);
  $(document).on('submit', 'form.qf-box__form', qf.submit);

  $('.qf-static').each(function(i, el) {
    qf.load({block:el});
  });

 $(document).on('click', '.qf-load-btn', function() {
    qf.load({link:$(this).attr('data-link'), popup:1});
  });
});
