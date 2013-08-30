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
  function init_bookmarker(url) {
    var bookmarker = $('#bookmarker')
    var listbox    = bookmarker.find("#bookmark-list");
    var form       = bookmarker.find('form#bookmark-form');
    var path   = bookmarker.data('path');
    var method = bookmarker.data('method');
    var title  = bookmarker.data('title');
    var id     = bookmarker.data('id');
    var pinned = bookmarker.hasClass('pinned');

    bookmarker.find('#bookmark-pin').click(function(e) {
      e.stopPropagation();
      if(!pinned) {
        form.show();
      } else {
        $.ajax(url + "/" + id, {
          type: 'delete',
          success: was_unpinned
        })
      }
      return false;
    });

    function was_pinned(data) {
      bookmarker.replaceWith(data);
      init_bookmarker(url);
    }

    function was_unpinned(data) {
      bookmarker.replaceWith(data);
      init_bookmarker(url);
    }

    bookmarker.find('span.level').click(function(e) {
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

    bookmarker.find('button[data-level]').click(function(){
      bookmarker.find('button[type="submit"]').attr('class', $(this).attr('class')).removeClass('btn-mini');
      bookmarker.find('#bookmarker-bookmark-level').val($(this).data('level'));
    })

    form.submit(function(event){
      event.stopPropagation();
      var level = $('#bookmarker-bookmark-level').val();
      var name  = $('#bookmarker-bookmark-name').val();
      $.ajax(url, {
        data: {
          path: path,
          title: name,
          level: level
        },
        type: 'post',
        success: was_pinned
      })
      form.hide();
      return false;
    });

    $('#bookmarker').click(function(event){
      event.stopPropagation();
    });

  }

  $('html').click(function() {
    $('#bookmark-form').hide();
    $('#bookmark-list').hide();
  });

  // $(document).on('click', '#bookmarker', function(event){
  //   event.stopPropagation();
  // });

  init_bookmarker($("#bookmarker").data('url'));
});
