function GalleryPhoto(guest_like_btn, like_form) {
  this.guest_like_btn = guest_like_btn;
  this.like_form = like_form;
}

GalleryPhoto.prototype = {

  set_form_param: function(like_button){
    this.like_form.find('#like_photo_id').val(like_button.data('photo-id'));
  },

  show_like_form: function() {
    this.like_form.modal('show');
  },

  close_like_form: function() {
    this.like_form.modal('hide');
  },

  addEventHandler: function() {
    var that = this;

    this.guest_like_btn.click(function(){
      that.set_form_param($(this));
      that.show_like_form();
    });

    this.like_form.find('#like_photo_btn').click(function(){
      that.close_like_form();
    });
  }
}



$(document).on('page:change', function(){
  var guest_like_btn = $('button.guest_like_btn');
  var like_form = $('#like_photo_form');

  var photo = new GalleryPhoto(guest_like_btn, like_form);
  photo.addEventHandler();
});
