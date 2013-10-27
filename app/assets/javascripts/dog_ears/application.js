// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

jQuery(function($){
  function init_dog_ears(url) {
    var dog_ears = $('#dog_ears')
    var listbox    = dog_ears.find("#bookmark-list");
    var form       = dog_ears.find('form#bookmark-form');
    var shareform  = dog_ears.find('form#bookmark-transfer-form');
    var path   = dog_ears.data('path');
    var method = dog_ears.data('method');
    var title  = dog_ears.data('title');
    var id     = dog_ears.data('id');
    var pinned = dog_ears.hasClass('pinned');

    dog_ears.find('#bookmark-pin').click(function(e) {
      e.stopPropagation();
      if(!pinned) {
        $('#dog_ears-bookmark-level').val(0);
        $('#dog_ears-bookmark-name').val(window.title);
        form.show();
      } else {
        $.ajax(url + "/" + id, {
          type: 'delete',
          success: new_component
        })
      }
      return false;
    });

    dog_ears.find('.bookmark-title').click(function(e) {
      e.stopPropagation();
      $('#dog_ears-bookmark-level').val(0);
      $('#dog_ears-bookmark-name').val(title);
      form.show();
      return false;
    });


    function new_component(data) {
      dog_ears.replaceWith(data);
      init_dog_ears(url);
    }

    dog_ears.find('span.level').click(function(e) {
      e.stopPropagation();
      var span = $(this);
      $.ajax(url, {
        type: 'get',
        data: { level: span.data('level') },
        success: show_bookmarks
      });
      listbox.css('background-color', span.css('background-color'));
      listbox.css('color', span.css('color'));
    });

    function show_bookmarks(data) {
      listbox.html();
      var ul = $("<ul/>");
      $.each(data, function(i,bm) {
        var a = $("<a/>").attr('href', bm.path).html(bm.title);
        ul.append($("<li/>").html(a));
      });
      listbox.html(ul);
      listbox.show();
    }

    dog_ears.find('button[data-level]').click(function(){
      dog_ears.find('button[type="submit"]').attr('class', $(this).attr('class')).removeClass('btn-mini');
      dog_ears.find('#dog_ears-bookmark-level').val($(this).data('level'));
    })

    form.submit(function(event){
      event.stopPropagation();
      var level = $('#dog_ears-bookmark-level').val();
      var name  = $('#dog_ears-bookmark-name').val();
      $.ajax(url, {
        data: {
          path: path,
          title: name,
          level: level
        },
        type: 'post',
        success: new_component
      })
      form.hide();
      return false;
    });

    $('#dog_ears').click(function(event){
      event.stopPropagation();
    });

    dog_ears.find('#bookmark-share').click(function(e) {
      e.stopPropagation();
      $.ajax(url + "/get_users", {
        type: 'get',
        success: show_share_form
      });
      return false;
    });

    function show_share_form(data) {
      var select = $('select#dog_ears-new-user');
      select.html();
      $.each(data, function(id,name){
        var option = $('<option>');
        option.val(id);
        option.html(name);
        select.append(option);
      });
      shareform.show();
    }

    shareform.submit(function(){
      var uid = $('select#dog_ears-new-user option:selected').val();
      $.ajax(url + "/" + id + "/share", {
        type: 'post',
        data: { user_id: uid },
        success: new_component
      })
      return false;
    });

  }

  $('html').click(function() {
    $('#bookmark-form').hide();
    $('#bookmark-list').hide();
    $('#bookmark-transfer-form').hide();
  });

  // $(document).on('click', '#dog_ears', function(event){
  //   event.stopPropagation();
  // });

  init_dog_ears($("#dog_ears").data('url'));
});
