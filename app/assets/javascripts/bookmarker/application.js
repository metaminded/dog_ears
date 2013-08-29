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
  var bookmarker = $('#bookmarker')
  var listbox = bookmarker.find("#bookmark-list");
  var path   = bookmarker.data('path');
  var method = bookmarker.data('method');
  var url    = bookmarker.data('url');
  var title  = bookmarker.data('title');
  var id     = bookmarker.data('id');
  var pinned = bookmarker.hasClass('pinned');

  bookmarker.find('#bookmark-pin').click(function(e) {
    e.stopPropagation();
    if(!pinned) {
      $.ajax(url, {
        data: { path: path, title: title },
        type: 'post',
        success: was_pinned
      })
    } else {
      $.ajax(url + "/" + id, {
        type: 'delete',
        success: was_unpinned
      })
    }
    return false;
  });

  function was_pinned(data) {
    console.log(data);
    alert('yo!');
  }

  function was_unpinned(data) {
    console.log(data);
    alert('no!');
  }

  bookmarker.find('span.level').click(function(e) {
    e.stopPropagation();
    listbox.css('background-color', $(this).css('background-color'));
    listbox.css('color', $(this).css('color'));
    $.ajax(url, {
      data: {level: $(this).data("level") },
      success: show_bookmarks
    });
  });

  function show_bookmarks(data) {
    listbox.html();
    console.log(data);
    var ul = $("<ul/>");
    $.each(data, function(i,bm) {
      var a = $("<a/>").attr('href', bm.path).html(bm.title);
      ul.append($("<li/>").html(a));
    });
    listbox.html(ul);
    listbox.show();
    alert('ho!');
  }
});
